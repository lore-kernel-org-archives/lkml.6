Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4636DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1139B20651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405434AbfAPQYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:24:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728499AbfAPQYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:24:01 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GGJsqZ019997
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:23:59 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q26s3m4a1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:23:59 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <s1seetee@linux.vnet.ibm.com>;
        Wed, 16 Jan 2019 16:23:57 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 16:23:53 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GGNqAr57344150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 16:23:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA5FB42045;
        Wed, 16 Jan 2019 16:23:52 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BA0842041;
        Wed, 16 Jan 2019 16:23:50 +0000 (GMT)
Received: from oc1548405160.ibm.com (unknown [9.85.72.239])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Jan 2019 16:23:50 +0000 (GMT)
From:   Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     s1seetee@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com
Subject: [PATCH] perf scripts python: Add Python 3 support to check-perf-trace.py
Date:   Wed, 16 Jan 2019 21:53:29 +0530
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19011616-0016-0000-0000-00000246545F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011616-0017-0000-0000-000032A0728A
Message-Id: <1547655825-28754-1-git-send-email-s1seetee@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python 2 and Python 3 in check-perf-trace.py.
``print`` is now a function rather than a statement. This should have
no functional change.

Fix indentation issue, replace spaces with tab

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/scripts/python/check-perf-trace.py | 32 +++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/perf/scripts/python/check-perf-trace.py b/tools/perf/scripts/python/check-perf-trace.py
index 334599c..1c5fab9 100644
--- a/tools/perf/scripts/python/check-perf-trace.py
+++ b/tools/perf/scripts/python/check-perf-trace.py
@@ -19,7 +19,7 @@ from perf_trace_context import *
 unhandled = autodict()
 
 def trace_begin():
-	print "trace_begin"
+	print("trace_begin")
 	pass
 
 def trace_end():
@@ -31,10 +31,10 @@ def irq__softirq_entry(event_name, context, common_cpu,
 		print_header(event_name, common_cpu, common_secs, common_nsecs,
 			common_pid, common_comm)
 
-                print_uncommon(context)
+		print_uncommon(context)
 
-		print "vec=%s\n" % \
-		(symbol_str("irq__softirq_entry", "vec", vec)),
+		print("vec=%s\n" % \
+		(symbol_str("irq__softirq_entry", "vec", vec))),
 
 def kmem__kmalloc(event_name, context, common_cpu,
 	common_secs, common_nsecs, common_pid, common_comm,
@@ -43,13 +43,13 @@ def kmem__kmalloc(event_name, context, common_cpu,
 		print_header(event_name, common_cpu, common_secs, common_nsecs,
 			common_pid, common_comm)
 
-                print_uncommon(context)
+		print_uncommon(context)
 
-		print "call_site=%u, ptr=%u, bytes_req=%u, " \
+		print("call_site=%u, ptr=%u, bytes_req=%u, " \
 		"bytes_alloc=%u, gfp_flags=%s\n" % \
 		(call_site, ptr, bytes_req, bytes_alloc,
 
-		flag_str("kmem__kmalloc", "gfp_flags", gfp_flags)),
+		flag_str("kmem__kmalloc", "gfp_flags", gfp_flags))),
 
 def trace_unhandled(event_name, context, event_fields_dict):
     try:
@@ -58,25 +58,25 @@ def trace_unhandled(event_name, context, event_fields_dict):
         unhandled[event_name] = 1
 
 def print_header(event_name, cpu, secs, nsecs, pid, comm):
-	print "%-20s %5u %05u.%09u %8u %-20s " % \
-	(event_name, cpu, secs, nsecs, pid, comm),
+	print("%-20s %5u %05u.%09u %8u %-20s " % \
+	(event_name, cpu, secs, nsecs, pid, comm)),
 
 # print trace fields not included in handler args
 def print_uncommon(context):
-    print "common_preempt_count=%d, common_flags=%s, common_lock_depth=%d, " \
+    print("common_preempt_count=%d, common_flags=%s, common_lock_depth=%d, " \
         % (common_pc(context), trace_flag_str(common_flags(context)), \
-               common_lock_depth(context))
+               common_lock_depth(context)))
 
 def print_unhandled():
     keys = unhandled.keys()
     if not keys:
         return
 
-    print "\nunhandled events:\n\n",
+    print("\nunhandled events:\n\n"),
 
-    print "%-40s  %10s\n" % ("event", "count"),
-    print "%-40s  %10s\n" % ("----------------------------------------", \
-                                 "-----------"),
+    print("%-40s  %10s\n" % ("event", "count")),
+    print("%-40s  %10s\n" % ("----------------------------------------", \
+                                 "-----------")),
 
     for event_name in keys:
-	print "%-40s  %10d\n" % (event_name, unhandled[event_name])
+        print("%-40s  %10d\n" % (event_name, unhandled[event_name]))
-- 
1.8.3.1

