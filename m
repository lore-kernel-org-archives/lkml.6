Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08058C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC5020836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC5020836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932939AbeFTRDp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:03:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932808AbeFTRDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:03:42 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KGwvmB143885
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:03:42 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jqt7na10v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:03:41 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 18:03:39 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 18:03:36 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KH3ZjB29753552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 17:03:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D862AA4051;
        Wed, 20 Jun 2018 17:54:15 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DB63A404D;
        Wed, 20 Jun 2018 17:54:14 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.124.219.212])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 17:54:14 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 08/19] sched/numa: Remove unused task_capacity from numa_stats
Date:   Wed, 20 Jun 2018 22:32:49 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062017-0012-0000-0000-000002819986
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062017-0013-0000-0000-000020B2DA61
Message-Id: <1529514181-9842-9-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

task_capacity field in struct numa_stats is redundant.
Also move nr_running for better packing within the struct.

No functional changes.

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
16    25308.6     25377.3     0.271
1     72964       72287       -0.92

Acked-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ed60fbd..0580a27 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1411,14 +1411,12 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 
 /* Cached statistics for all CPUs within a node */
 struct numa_stats {
-	unsigned long nr_running;
 	unsigned long load;
 
 	/* Total compute capacity of CPUs on a node */
 	unsigned long compute_capacity;
 
-	/* Approximate capacity in terms of runnable tasks on a node */
-	unsigned long task_capacity;
+	unsigned int nr_running;
 	int has_free_capacity;
 };
 
@@ -1456,9 +1454,9 @@ static void update_numa_stats(struct numa_stats *ns, int nid)
 	smt = DIV_ROUND_UP(SCHED_CAPACITY_SCALE * cpus, ns->compute_capacity);
 	capacity = cpus / smt; /* cores */
 
-	ns->task_capacity = min_t(unsigned, capacity,
+	capacity = min_t(unsigned, capacity,
 		DIV_ROUND_CLOSEST(ns->compute_capacity, SCHED_CAPACITY_SCALE));
-	ns->has_free_capacity = (ns->nr_running < ns->task_capacity);
+	ns->has_free_capacity = (ns->nr_running < capacity);
 }
 
 struct task_numa_env {
-- 
1.8.3.1

