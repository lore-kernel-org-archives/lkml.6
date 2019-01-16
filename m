Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FECC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7FE20651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405556AbfAPQYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:24:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731613AbfAPQYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:24:37 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GGMh3Q179577
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:24:36 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q2832g2uw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:24:35 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <s1seetee@linux.vnet.ibm.com>;
        Wed, 16 Jan 2019 16:24:33 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 16:24:29 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GGOS1w50266350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 16:24:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 795BD4204D;
        Wed, 16 Jan 2019 16:24:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4447842042;
        Wed, 16 Jan 2019 16:24:26 +0000 (GMT)
Received: from oc1548405160.ibm.com (unknown [9.85.72.239])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Jan 2019 16:24:26 +0000 (GMT)
From:   Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     s1seetee@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com
Subject: [PATCH] perf scripts python: Add Python 3 support to powerpc-hcalls.py
Date:   Wed, 16 Jan 2019 21:53:39 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547655825-28754-1-git-send-email-s1seetee@linux.vnet.ibm.com>
References: <1547655825-28754-1-git-send-email-s1seetee@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011616-4275-0000-0000-000003000E56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011616-4276-0000-0000-0000380E304D
Message-Id: <1547655825-28754-11-git-send-email-s1seetee@linux.vnet.ibm.com>
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

Support both Python 2 and Python 3 in powerpc-hcalls.py.
``print`` is now a function rather than a statement. This should
have no functional change.

The "has_key()" method is deprecated in favor of the "in" operator.
So incorporate those changes here.

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/scripts/python/powerpc-hcalls.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/scripts/python/powerpc-hcalls.py b/tools/perf/scripts/python/powerpc-hcalls.py
index 00e0e74..6cf33f0 100644
--- a/tools/perf/scripts/python/powerpc-hcalls.py
+++ b/tools/perf/scripts/python/powerpc-hcalls.py
@@ -149,7 +149,7 @@ hcall_table = {
 }
 
 def hcall_table_lookup(opcode):
-	if (hcall_table.has_key(opcode)):
+	if (opcode in hcall_table):
 		return hcall_table[opcode]
 	else:
 		return opcode
@@ -157,8 +157,8 @@ def hcall_table_lookup(opcode):
 print_ptrn = '%-28s%10s%10s%10s%10s'
 
 def trace_end():
-	print print_ptrn % ('hcall', 'count', 'min(ns)', 'max(ns)', 'avg(ns)')
-	print '-' * 68
+	print(print_ptrn % ('hcall', 'count', 'min(ns)', 'max(ns)', 'avg(ns)'))
+	print('-' * 68)
 	for opcode in output:
 		h_name = hcall_table_lookup(opcode)
 		time = output[opcode]['time']
@@ -166,14 +166,14 @@ def trace_end():
 		min_t = output[opcode]['min']
 		max_t = output[opcode]['max']
 
-		print print_ptrn % (h_name, cnt, min_t, max_t, time/cnt)
+		print(print_ptrn % (h_name, cnt, min_t, max_t, time/cnt))
 
 def powerpc__hcall_exit(name, context, cpu, sec, nsec, pid, comm, callchain,
 			opcode, retval):
-	if (d_enter.has_key(cpu) and d_enter[cpu].has_key(opcode)):
+	if ((cpu in d_enter) and (opcode in d_enter[cpu])):
 		diff = nsecs(sec, nsec) - d_enter[cpu][opcode]
 
-		if (output.has_key(opcode)):
+		if (opcode in output):
 			output[opcode]['time'] += diff
 			output[opcode]['cnt'] += 1
 			if (output[opcode]['min'] > diff):
@@ -194,7 +194,7 @@ def powerpc__hcall_exit(name, context, cpu, sec, nsec, pid, comm, callchain,
 
 def powerpc__hcall_entry(event_name, context, cpu, sec, nsec, pid, comm,
 			 callchain, opcode):
-		if (d_enter.has_key(cpu)):
+		if (cpu in d_enter):
 			d_enter[cpu][opcode] = nsecs(sec, nsec)
 		else:
 			d_enter[cpu] = {opcode: nsecs(sec, nsec)}
-- 
1.8.3.1

