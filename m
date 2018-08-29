Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBAEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B7120661
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B7120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeH3CVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:21:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727294AbeH3CTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:19:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMIhtD094283
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:55 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m627rc13d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:55 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:20:55 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:20:49 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMKmbb25821232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:20:48 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAA96B2075;
        Wed, 29 Aug 2018 18:19:44 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A245EB2070;
        Wed, 29 Aug 2018 18:19:44 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:19:44 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1D26016C91C9; Wed, 29 Aug 2018 15:20:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 05/19] rcu: Remove now-unused ->b.exp_need_qs field from the rcu_special union
Date:   Wed, 29 Aug 2018 15:20:33 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829222021.GA29944@linux.vnet.ibm.com>
References: <20180829222021.GA29944@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0040-0000-0000-0000046756CE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080738; UDB=6.00557494; IPR=6.00860724;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:20:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0041-0000-0000-0000086E70A1
Message-Id: <20180829222047.319-5-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ->b.exp_need_qs field is now set only to false, so this commit
removes it.  The job this field used to do is now done by the rcu_data
structure's ->deferred_qs field, which is a consequence of a better
split between task-based (the rcu_node structure's ->exp_tasks field) and
CPU-based (the aforementioned rcu_data structure's ->deferred_qs field)
tracking of quiescent states for RCU-preempt expedited grace periods.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/sched.h    |  6 +-----
 kernel/rcu/tree_plugin.h | 13 ++++---------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 977cb57d7bc9..004ca21f7e80 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -571,12 +571,8 @@ union rcu_special {
 	struct {
 		u8			blocked;
 		u8			need_qs;
-		u8			exp_need_qs;
-
-		/* Otherwise the compiler can store garbage here: */
-		u8			pad;
 	} b; /* Bits. */
-	u32 s; /* Set of bits. */
+	u16 s; /* Set of bits. */
 };
 
 enum perf_event_task_context {
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 24c209676d20..527a52792dce 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -284,13 +284,10 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * no need to check for a subsequent expedited GP.  (Though we are
 	 * still in a quiescent state in any case.)
 	 */
-	if (blkd_state & RCU_EXP_BLKD &&
-	    t->rcu_read_unlock_special.b.exp_need_qs) {
-		t->rcu_read_unlock_special.b.exp_need_qs = false;
+	if (blkd_state & RCU_EXP_BLKD && rdp->deferred_qs)
 		rcu_report_exp_rdp(rdp->rsp, rdp, true);
-	} else {
-		WARN_ON_ONCE(t->rcu_read_unlock_special.b.exp_need_qs);
-	}
+	else
+		WARN_ON_ONCE(rdp->deferred_qs);
 }
 
 /*
@@ -509,9 +506,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	 * tasks are handled when removing the task from the
 	 * blocked-tasks list below.
 	 */
-	if (special.b.exp_need_qs || rdp->deferred_qs) {
-		t->rcu_read_unlock_special.b.exp_need_qs = false;
-		rdp->deferred_qs = false;
+	if (rdp->deferred_qs) {
 		rcu_report_exp_rdp(rcu_state_p, rdp, true);
 		if (!t->rcu_read_unlock_special.s) {
 			local_irq_restore(flags);
-- 
2.17.1

