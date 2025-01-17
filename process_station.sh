#!/usr/bin/bash
###############################################################################
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
###############################################################################
for file in ./data/input/*_SYNOP.csv
do
file=`basename ${file}`
echo ${file}
station_name=`echo ${file} | cut -d '.' -f 1 | sed s/_SYNOP//g`
WSI=`grep ${station_name} ./data/input/station_list.csv | cut -d ',' -f 2`
csv2bufr data transform \
   ./data/input/${file} \
   --bufr-template synop_bufr \
   --geojson-template synop_json \
   --output-dir ./data/output \
   --station-metadata ./metadata/${WSI}.json >& ${WSI}.log
done
