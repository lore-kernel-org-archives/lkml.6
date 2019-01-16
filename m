Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC4CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9E420675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405544AbfAPQYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:24:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405532AbfAPQYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:24:32 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GGJsGl084149
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:24:31 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q25k8fb45-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:24:30 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <s1seetee@linux.vnet.ibm.com>;
        Wed, 16 Jan 2019 16:24:28 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 16:24:25 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GGOOID52232376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 16:24:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D834F4203F;
        Wed, 16 Jan 2019 16:24:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C292E42041;
        Wed, 16 Jan 2019 16:24:22 +0000 (GMT)
Received: from oc1548405160.ibm.com (unknown [9.85.72.239])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Jan 2019 16:24:22 +0000 (GMT)
From:   Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     s1seetee@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com
Subject: [PATCH] perf scripts python: Add Python 3 support to net_dropmonitor.py
Date:   Wed, 16 Jan 2019 21:53:38 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547655825-28754-1-git-send-email-s1seetee@linux.vnet.ibm.com>
References: <1547655825-28754-1-git-send-email-s1seetee@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011616-0028-0000-0000-0000033A0BF5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011616-0029-0000-0000-000023F733BF
Message-Id: <1547655825-28754-10-git-send-email-s1seetee@linux.vnet.ibm.com>
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

Support both Python 2 and Python 3 in net_dropmonitor.py.
``print`` is now a function rather than a statement. This should
have no functional change.

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/scripts/python/net_dropmonitor.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/net_dropmonitor.py b/tools/perf/scripts/python/net_dropmonitor.py
index a150164..091f4b3 100755
--- a/tools/perf/scripts/python/net_dropmonitor.py
+++ b/tools/perf/scripts/python/net_dropmonitor.py
@@ -50,19 +50,19 @@ def get_sym(sloc):
 		return (None, 0)
 
 def print_drop_table():
-	print "%25s %25s %25s" % ("LOCATION", "OFFSET", "COUNT")
+	print("%25s %25s %25s" % ("LOCATION", "OFFSET", "COUNT"))
 	for i in drop_log.keys():
 		(sym, off) = get_sym(i)
 		if sym == None:
 			sym = i
-		print "%25s %25s %25s" % (sym, off, drop_log[i])
+		print("%25s %25s %25s" % (sym, off, drop_log[i]))
 
 
 def trace_begin():
-	print "Starting trace (Ctrl-C to dump results)"
+	print("Starting trace (Ctrl-C to dump results)")
 
 def trace_end():
-	print "Gathering kallsyms data"
+	print("Gathering kallsyms data")
 	get_kallsyms_table()
 	print_drop_table()
 
-- 
1.8.3.1

