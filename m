Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7556C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8822220651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405460AbfAPQYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:24:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728499AbfAPQYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:24:09 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GGK3V9189797
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:24:07 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q26cgn4cs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:24:06 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <s1seetee@linux.vnet.ibm.com>;
        Wed, 16 Jan 2019 16:24:05 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 16:24:01 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GGO03n32964834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 16:24:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E23094204B;
        Wed, 16 Jan 2019 16:23:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C69094203F;
        Wed, 16 Jan 2019 16:23:57 +0000 (GMT)
Received: from oc1548405160.ibm.com (unknown [9.85.72.239])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Jan 2019 16:23:57 +0000 (GMT)
From:   Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     s1seetee@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com
Subject: [PATCH] perf scripts python: Add Python 3 support to exported-sql-viewer.py
Date:   Wed, 16 Jan 2019 21:53:31 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547655825-28754-1-git-send-email-s1seetee@linux.vnet.ibm.com>
References: <1547655825-28754-1-git-send-email-s1seetee@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011616-0028-0000-0000-0000033A0BE9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011616-0029-0000-0000-000023F733B2
Message-Id: <1547655825-28754-3-git-send-email-s1seetee@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160132
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
 tools/perf/scripts/python/exported-sql-viewer.py | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index f278ce5..02f964a 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1,4 +1,3 @@
-#!/usr/bin/python2
 # SPDX-License-Identifier: GPL-2.0
 # exported-sql-viewer.py: view data from sql database
 # Copyright (c) 2014-2018, Intel Corporation.
@@ -92,7 +91,6 @@ import sys
 import weakref
 import threading
 import string
-import cPickle
 import re
 import os
 from PySide.QtCore import *
@@ -102,6 +100,11 @@ from decimal import *
 from ctypes import *
 from multiprocessing import Process, Array, Value, Event
 
+if sys.version_info[0] < 3:
+    import cPickle
+else:
+    import _pickle as cPickle
+
 # Data formatting helpers
 
 def tohex(ip):
@@ -1560,7 +1563,7 @@ class SQLTableDialogDataItem():
 					return str(lower_id)
 
 	def ConvertRelativeTime(self, val):
-		print "val ", val
+		print("val ", val)
 		mult = 1
 		suffix = val[-2:]
 		if suffix == "ms":
@@ -1582,29 +1585,29 @@ class SQLTableDialogDataItem():
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

