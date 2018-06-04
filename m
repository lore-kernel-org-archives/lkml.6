Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752625AbeFDKBL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:01:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752416AbeFDKBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:01:08 -0400
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 06/19] sched/debug: Reverse the order of printing faults
Date: Mon,  4 Jun 2018 15:30:15 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060410-4275-0000-0000-000002895C97
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060410-4276-0000-0000-0000379070F2
Message-Id: <1528106428-19992-7-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=996 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the order in which the private and shared numa faults are getting
printed.

Shouldn't have any performance impact.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 15b10e2..82ac522 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -869,8 +869,8 @@ void print_numa_stats(struct seq_file *m, int node, unsigned long tsf,
 		unsigned long tpf, unsigned long gsf, unsigned long gpf)
 {
 	SEQ_printf(m, "numa_faults node=%d ", node);
-	SEQ_printf(m, "task_private=%lu task_shared=%lu ", tsf, tpf);
-	SEQ_printf(m, "group_private=%lu group_shared=%lu\n", gsf, gpf);
+	SEQ_printf(m, "task_private=%lu task_shared=%lu ", tpf, tsf);
+	SEQ_printf(m, "group_private=%lu group_shared=%lu\n", gpf, gsf);
 }
 #endif
 
-- 
1.8.3.1
