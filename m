Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8384C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FA72054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfAQJqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:46:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39658 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbfAQJqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:46:14 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0H9j7BC185028
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 04:46:12 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q2mt2p98j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 04:46:12 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <s1seetee@linux.vnet.ibm.com>;
        Thu, 17 Jan 2019 09:46:10 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Jan 2019 09:46:07 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0H9k60W53412084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 09:46:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63AB511C058;
        Thu, 17 Jan 2019 09:46:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0503511C054;
        Thu, 17 Jan 2019 09:46:05 +0000 (GMT)
Received: from oc1548405160.ibm.com (unknown [9.124.35.202])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Jan 2019 09:46:04 +0000 (GMT)
From:   Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     s1seetee@linux.vnet.ibm.com
Subject: [PATCH v2] perf scripts python: Add Python 3 support to mem-phys-addr.py
Date:   Thu, 17 Jan 2019 15:15:35 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547718344-27382-1-git-send-email-s1seetee@linux.vnet.ibm.com>
References: <1547718344-27382-1-git-send-email-s1seetee@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011709-0028-0000-0000-0000033A5AEE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011709-0029-0000-0000-000023F7850B
Message-Id: <1547718344-27382-8-git-send-email-s1seetee@linux.vnet.ibm.com>
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

Support both Python 2 and Python 3 in mem-phys-addr.py. ``print`` is now a
function rather than a statement. This should have no functional change.

Fix lambda syntax error.

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/scripts/python/mem-phys-addr.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/scripts/python/mem-phys-addr.py b/tools/perf/scripts/python/mem-phys-addr.py
index ebee2c5..e30fc9d 100644
--- a/tools/perf/scripts/python/mem-phys-addr.py
+++ b/tools/perf/scripts/python/mem-phys-addr.py
@@ -3,6 +3,7 @@
 #
 # Copyright (c) 2018, Intel Corporation.
 
+from __future__ import print_function
 from __future__ import division
 import os
 import sys
@@ -38,14 +39,14 @@ def parse_iomem():
 			pmem.append(long(m[1], 16))
 
 def print_memory_type():
-	print "Event: %s" % (event_name)
-	print "%-40s  %10s  %10s\n" % ("Memory type", "count", "percentage"),
-	print "%-40s  %10s  %10s\n" % ("----------------------------------------", \
-					"-----------", "-----------"),
+	print("Event: %s" % (event_name))
+	print("%-40s  %10s  %10s\n" % ("Memory type", "count", "percentage")),
+	print("%-40s  %10s  %10s\n" % ("----------------------------------------", \
+					"-----------", "-----------")),
 	total = sum(load_mem_type_cnt.values())
 	for mem_type, count in sorted(load_mem_type_cnt.most_common(), \
-					key = lambda(k, v): (v, k), reverse = True):
-		print "%-40s  %10d  %10.1f%%\n" % (mem_type, count, 100 * count / total),
+					key = lambda k_v: (k_v[1], k_v[0]), reverse = True):
+		print("%-40s  %10d  %10.1f%%\n" % (mem_type, count, 100 * count / total)),
 
 def trace_begin():
 	parse_iomem()
-- 
1.8.3.1

