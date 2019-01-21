Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1FCC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6068620663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfAUKk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:40:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726678AbfAUKk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:40:29 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0LActC6125889
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 05:40:28 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q5c3w992a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 05:40:27 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <s1seetee@linux.vnet.ibm.com>;
        Mon, 21 Jan 2019 10:40:25 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 21 Jan 2019 10:40:22 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0LAeKta52428808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 10:40:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3C254C050;
        Mon, 21 Jan 2019 10:40:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 174644C05C;
        Mon, 21 Jan 2019 10:40:19 +0000 (GMT)
Received: from oc1548405160.ibm.com (unknown [9.124.31.87])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 21 Jan 2019 10:40:18 +0000 (GMT)
From:   Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
To:     tonyj@suse.de, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, ravi.bangoria@linux.ibm.com
Cc:     s1seetee@linux.vnet.ibm.com
Subject: [PATCH v3] perf scripts python: Add Python 3 support to export-to-postgresql.py
Date:   Mon, 21 Jan 2019 16:10:17 +0530
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19012110-0028-0000-0000-0000033BF344
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012110-0029-0000-0000-000023F9282D
Message-Id: <1548067217-10617-1-git-send-email-s1seetee@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python 2 and Python 3 in export-to-postgresql.py. ``print``
is now a function rather than a statement. This should have no functional
change.

Also, handles the conversion of "print >> sys.stderr".

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/scripts/python/export-to-postgresql.py | 25 ++++++++++++-----------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 0564dd7..b2ff375 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -9,6 +9,7 @@
 # ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 # more details.
+from __future__ import print_function
 
 import os
 import sys
@@ -236,10 +237,10 @@ perf_db_export_callchains = False
 
 
 def usage():
-	print >> sys.stderr, "Usage is: export-to-postgresql.py <database name> [<columns>] [<calls>] [<callchains>]"
-	print >> sys.stderr, "where:	columns		'all' or 'branches'"
-	print >> sys.stderr, "		calls		'calls' => create calls and call_paths table"
-	print >> sys.stderr, "		callchains	'callchains' => create call_paths table"
+	sys.stderr.write("Usage is: export-to-postgresql.py <database name> [<columns>] [<calls>] [<callchains>]");
+	sys.stderr.write("where:	columns		'all' or 'branches'");
+	sys.stderr.write("		calls		'calls' => create calls and call_paths table");
+	sys.stderr.write("		callchains	'callchains' => create call_paths table");
 	raise Exception("Too few arguments")
 
 if (len(sys.argv) < 2):
@@ -273,7 +274,7 @@ def do_query(q, s):
 		return
 	raise Exception("Query failed: " + q.lastError().text())
 
-print datetime.datetime.today(), "Creating database..."
+print(datetime.datetime.today(), "Creating database...")
 
 db = QSqlDatabase.addDatabase('QPSQL')
 query = QSqlQuery(db)
@@ -564,7 +565,7 @@ if perf_db_export_calls:
 	call_file		= open_output_file("call_table.bin")
 
 def trace_begin():
-	print datetime.datetime.today(), "Writing to intermediate files..."
+	print(datetime.datetime.today(), "Writing to intermediate files...")
 	# id == 0 means unknown.  It is easier to create records for them than replace the zeroes with NULLs
 	evsel_table(0, "unknown")
 	machine_table(0, 0, "unknown")
@@ -579,7 +580,7 @@ def trace_begin():
 unhandled_count = 0
 
 def trace_end():
-	print datetime.datetime.today(), "Copying to database..."
+	print(datetime.datetime.today(), "Copying to database...")
 	copy_output_file(evsel_file,		"selected_events")
 	copy_output_file(machine_file,		"machines")
 	copy_output_file(thread_file,		"threads")
@@ -594,7 +595,7 @@ def trace_end():
 	if perf_db_export_calls:
 		copy_output_file(call_file,		"calls")
 
-	print datetime.datetime.today(), "Removing intermediate files..."
+	print(datetime.datetime.today(), "Removing intermediate files...")
 	remove_output_file(evsel_file)
 	remove_output_file(machine_file)
 	remove_output_file(thread_file)
@@ -609,7 +610,7 @@ def trace_end():
 	if perf_db_export_calls:
 		remove_output_file(call_file)
 	os.rmdir(output_dir_name)
-	print datetime.datetime.today(), "Adding primary keys"
+	print(datetime.datetime.today(), "Adding primary keys")
 	do_query(query, 'ALTER TABLE selected_events ADD PRIMARY KEY (id)')
 	do_query(query, 'ALTER TABLE machines        ADD PRIMARY KEY (id)')
 	do_query(query, 'ALTER TABLE threads         ADD PRIMARY KEY (id)')
@@ -624,7 +625,7 @@ def trace_end():
 	if perf_db_export_calls:
 		do_query(query, 'ALTER TABLE calls           ADD PRIMARY KEY (id)')
 
-	print datetime.datetime.today(), "Adding foreign keys"
+	print(datetime.datetime.today(), "Adding foreign keys")
 	do_query(query, 'ALTER TABLE threads '
 					'ADD CONSTRAINT machinefk  FOREIGN KEY (machine_id)   REFERENCES machines   (id),'
 					'ADD CONSTRAINT processfk  FOREIGN KEY (process_id)   REFERENCES threads    (id)')
@@ -659,8 +660,8 @@ def trace_end():
 		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
 
 	if (unhandled_count):
-		print datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events"
-	print datetime.datetime.today(), "Done"
+		print(datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events")
+	print(datetime.datetime.today(), "Done")
 
 def trace_unhandled(event_name, context, event_fields_dict):
 	global unhandled_count
-- 
1.8.3.1

