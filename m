Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291FFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F014A20859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfAQJqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:46:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727013AbfAQJqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:46:00 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0H9iDP7041238
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 04:45:59 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q2nt0mc1b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 04:45:59 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <s1seetee@linux.vnet.ibm.com>;
        Thu, 17 Jan 2019 09:45:57 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Jan 2019 09:45:54 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0H9jr5U18022594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 09:45:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B3E811C05E;
        Thu, 17 Jan 2019 09:45:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A572611C050;
        Thu, 17 Jan 2019 09:45:51 +0000 (GMT)
Received: from oc1548405160.ibm.com (unknown [9.124.35.202])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Jan 2019 09:45:51 +0000 (GMT)
From:   Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     s1seetee@linux.vnet.ibm.com
Subject: [PATCH v2] perf scripts python: Add Python 3 support to exported-sql-viewer.py
Date:   Thu, 17 Jan 2019 15:15:30 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547718344-27382-1-git-send-email-s1seetee@linux.vnet.ibm.com>
References: <1547718344-27382-1-git-send-email-s1seetee@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011709-0016-0000-0000-00000246A3AA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011709-0017-0000-0000-000032A0C53E
Message-Id: <1547718344-27382-3-git-send-email-s1seetee@linux.vnet.ibm.com>
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

Support both Python 2 and Python 3 in exported-sql-viewer.py.
``print`` is now a function rather than a statement. This should have
no functional change.

Add support of _pickle module in Python3

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index f278ce5..a4aef58 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1,4 +1,3 @@
-#!/usr/bin/python2
 # SPDX-License-Identifier: GPL-2.0
 # exported-sql-viewer.py: view data from sql database
 # Copyright (c) 2014-2018, Intel Corporation.
@@ -87,12 +86,12 @@
 #                                                                              7fab593ea94f 48 8b 05 1a 15 22 00                            movq  0x22151a(%rip), %rax
 #                                                                              7fab593ea956 48 89 15 3b 13 22 00                            movq  %rdx, 0x22133b(%rip)
 # 8107675243232  2    ls       22011  22011  hardware interrupt     No         7fab593ea956 _dl_start+0x26 (ld-2.19.so) -> ffffffff86a012e0 page_fault ([kernel])
+from __future__ import print_function
 
 import sys
 import weakref
 import threading
 import string
-import cPickle
 import re
 import os
 from PySide.QtCore import *
@@ -102,6 +101,11 @@ from decimal import *
 from ctypes import *
 from multiprocessing import Process, Array, Value, Event
 
+if sys.version_info[0] < 3:
+    import cPickle
+else:
+    import _pickle as cPickle
+
 # Data formatting helpers
 
 def tohex(ip):
@@ -1560,7 +1564,7 @@ class SQLTableDialogDataItem():
 					return str(lower_id)
 
 	def ConvertRelativeTime(self, val):
-		print "val ", val
+		print("val ", val)
 		mult = 1
 		suffix = val[-2:]
 		if suffix == "ms":
@@ -1582,29 +1586,29 @@ class SQLTableDialogDataItem():
 		return str(val)
 
 	def ConvertTimeRange(self, vrange):
-		print "vrange ", vrange
+		print("vrange ", vrange)
 		if vrange[0] == "":
 			vrange[0] = str(self.first_time)
 		if vrange[1] == "":
 			vrange[1] = str(self.last_time)
 		vrange[0] = self.ConvertRelativeTime(vrange[0])
 		vrange[1] = self.ConvertRelativeTime(vrange[1])
-		print "vrange2 ", vrange
+		print("vrange2 ", vrange)
 		if not self.IsNumber(vrange[0]) or not self.IsNumber(vrange[1]):
 			return False
-		print "ok1"
+		print("ok1")
 		beg_range = max(int(vrange[0]), self.first_time)
 		end_range = min(int(vrange[1]), self.last_time)
 		if beg_range > self.last_time or end_range < self.first_time:
 			return False
-		print "ok2"
+		print("ok2")
 		vrange[0] = self.BinarySearchTime(0, self.last_id, beg_range, True)
 		vrange[1] = self.BinarySearchTime(1, self.last_id + 1, end_range, False)
-		print "vrange3 ", vrange
+		print("vrange3 ", vrange)
 		return True
 
 	def AddTimeRange(self, value, ranges):
-		print "value ", value
+		print("value ", value)
 		n = value.count("-")
 		if n == 1:
 			pass
-- 
1.8.3.1

