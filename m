Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D444C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BAB2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbfAQJp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:45:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727013AbfAQJp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:45:57 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0H9ib5l109775
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 04:45:55 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q2mjxxvcn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 04:45:55 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <s1seetee@linux.vnet.ibm.com>;
        Thu, 17 Jan 2019 09:45:53 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Jan 2019 09:45:51 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0H9joEB7078190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 09:45:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63B7D11C050;
        Thu, 17 Jan 2019 09:45:50 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 039A911C04A;
        Thu, 17 Jan 2019 09:45:49 +0000 (GMT)
Received: from oc1548405160.ibm.com (unknown [9.124.35.202])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Jan 2019 09:45:48 +0000 (GMT)
From:   Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     s1seetee@linux.vnet.ibm.com
Subject: [PATCH v2] perf scripts python: Add Python 3 support to event_analyzing_sample.py
Date:   Thu, 17 Jan 2019 15:15:29 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547718344-27382-1-git-send-email-s1seetee@linux.vnet.ibm.com>
References: <1547718344-27382-1-git-send-email-s1seetee@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011709-4275-0000-0000-000003005E4D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011709-4276-0000-0000-0000380E822F
Message-Id: <1547718344-27382-2-git-send-email-s1seetee@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python 2 and Python 3 in event_analyzing_sample.py. ``print``
is now a function rather than a statement. This should have no functional
change.

Fixes indentation issue, replace spaces with tab. The "has_key()" method
is deprecated in favor of the "in" operator. So incorporate those changes
here.

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 .../perf/scripts/python/event_analyzing_sample.py  | 57 +++++++++++-----------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/tools/perf/scripts/python/event_analyzing_sample.py b/tools/perf/scripts/python/event_analyzing_sample.py
index 4e843b9..4ae239d 100644
--- a/tools/perf/scripts/python/event_analyzing_sample.py
+++ b/tools/perf/scripts/python/event_analyzing_sample.py
@@ -14,6 +14,7 @@
 # generic events with the help of sqlite, and the 2nd one "show_pebs_ll" is
 # for a x86 HW PMU event: PEBS with load latency data.
 #
+from __future__ import print_function
 
 import os
 import sys
@@ -37,20 +38,20 @@ con = sqlite3.connect("/dev/shm/perf.db")
 con.isolation_level = None
 
 def trace_begin():
-	print "In trace_begin:\n"
+	print("In trace_begin:\n")
 
         #
         # Will create several tables at the start, pebs_ll is for PEBS data with
         # load latency info, while gen_events is for general event.
         #
-        con.execute("""
+	con.execute("""
                 create table if not exists gen_events (
                         name text,
                         symbol text,
                         comm text,
                         dso text
                 );""")
-        con.execute("""
+	con.execute("""
                 create table if not exists pebs_ll (
                         name text,
                         symbol text,
@@ -76,12 +77,12 @@ def process_event(param_dict):
         name       = param_dict["ev_name"]
 
         # Symbol and dso info are not always resolved
-        if (param_dict.has_key("dso")):
+        if ('dso' in param_dict):
                 dso = param_dict["dso"]
         else:
                 dso = "Unknown_dso"
 
-        if (param_dict.has_key("symbol")):
+        if ('symbol' in param_dict):
                 symbol = param_dict["symbol"]
         else:
                 symbol = "Unknown_symbol"
@@ -102,11 +103,11 @@ def insert_db(event):
                                 event.ip, event.status, event.dse, event.dla, event.lat))
 
 def trace_end():
-	print "In trace_end:\n"
+	print("In trace_end:\n")
         # We show the basic info for the 2 type of event classes
-        show_general_events()
-        show_pebs_ll()
-        con.close()
+	show_general_events()
+	show_pebs_ll()
+	con.close()
 
 #
 # As the event number may be very big, so we can't use linear way
@@ -123,29 +124,29 @@ def show_general_events():
         # Check the total record number in the table
         count = con.execute("select count(*) from gen_events")
         for t in count:
-                print "There is %d records in gen_events table" % t[0]
+                print("There is %d records in gen_events table" % t[0])
                 if t[0] == 0:
                         return
 
-        print "Statistics about the general events grouped by thread/symbol/dso: \n"
+        print("Statistics about the general events grouped by thread/symbol/dso: \n")
 
          # Group by thread
         commq = con.execute("select comm, count(comm) from gen_events group by comm order by -count(comm)")
-        print "\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42)
+        print("\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42))
         for row in commq:
-             print "%16s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%16s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
         # Group by symbol
-        print "\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58)
+        print("\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58))
         symbolq = con.execute("select symbol, count(symbol) from gen_events group by symbol order by -count(symbol)")
         for row in symbolq:
-             print "%32s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
         # Group by dso
-        print "\n%40s %8s %16s\n%s" % ("dso", "number", "histogram", "="*74)
+        print("\n%40s %8s %16s\n%s" % ("dso", "number", "histogram", "="*74))
         dsoq = con.execute("select dso, count(dso) from gen_events group by dso order by -count(dso)")
         for row in dsoq:
-             print "%40s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%40s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
 #
 # This function just shows the basic info, and we could do more with the
@@ -156,35 +157,35 @@ def show_pebs_ll():
 
         count = con.execute("select count(*) from pebs_ll")
         for t in count:
-                print "There is %d records in pebs_ll table" % t[0]
+                print("There is %d records in pebs_ll table" % t[0])
                 if t[0] == 0:
                         return
 
-        print "Statistics about the PEBS Load Latency events grouped by thread/symbol/dse/latency: \n"
+        print("Statistics about the PEBS Load Latency events grouped by thread/symbol/dse/latency: \n")
 
         # Group by thread
         commq = con.execute("select comm, count(comm) from pebs_ll group by comm order by -count(comm)")
-        print "\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42)
+        print("\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42))
         for row in commq:
-             print "%16s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%16s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
         # Group by symbol
-        print "\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58)
+        print("\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58))
         symbolq = con.execute("select symbol, count(symbol) from pebs_ll group by symbol order by -count(symbol)")
         for row in symbolq:
-             print "%32s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
         # Group by dse
         dseq = con.execute("select dse, count(dse) from pebs_ll group by dse order by -count(dse)")
-        print "\n%32s %8s %16s\n%s" % ("dse", "number", "histogram", "="*58)
+        print("\n%32s %8s %16s\n%s" % ("dse", "number", "histogram", "="*58))
         for row in dseq:
-             print "%32s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
         # Group by latency
         latq = con.execute("select lat, count(lat) from pebs_ll group by lat order by lat")
-        print "\n%32s %8s %16s\n%s" % ("latency", "number", "histogram", "="*58)
+        print("\n%32s %8s %16s\n%s" % ("latency", "number", "histogram", "="*58))
         for row in latq:
-             print "%32s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
 def trace_unhandled(event_name, context, event_fields_dict):
-		print ' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())])
+		print(' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())]))
-- 
1.8.3.1

