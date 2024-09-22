#!/bin/bash
set -e


echo
echo
echo "------------------------------------------------------------"
echo
echo

print_size_and_checksums () {
cat <<EOF
### \`${1}\` size and checksum

    $ stat --printf="%s bytes\n" $1
    $(stat --printf="%s bytes\n" $1)

    $ md5sum $1
    $(md5sum $1)
    
    $ sha256sum $1
    $(sha256sum $1)
    
    $ b2sum $1
    $(b2sum $1)


EOF
}


cat <<EOF
### md5sums FILE CONTENTS

$(ar -p *.deb control.tar.zst | tar xO --zstd ./md5sums)


EOF

print_size_and_checksums *.deb

ar -p *.deb data.tar.zst | tar x --zstd --strip-components=3 ./usr/bin/s3fs
print_size_and_checksums s3fs
rm s3fs

cat <<EOF
DONE

------------------------------------------------------------

EOF
