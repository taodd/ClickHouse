#!/usr/bin/env bash

set -o errexit
set -o pipefail

for i in {1..10}; do seq 1 100 | sed 's/.*/SELECT * FROM (SELECT * FROM system.numbers_mt LIMIT 111) LIMIT 55;/' | clickhouse-client -n --receive_timeout=1 --max_block_size=1 | wc -l | grep -vE '^5500$' && echo 'Fail!' && break; echo -n '.'; done; echo
