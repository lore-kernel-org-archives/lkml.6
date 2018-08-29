Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97449C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBF620644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBF620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeH3CmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:42:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727530AbeH3CiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:06 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMcjFF116430
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:03 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m6158y7e3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:03 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:02 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:56 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMctEc27459604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:55 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F62CB2065;
        Wed, 29 Aug 2018 18:37:51 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CA61B2070;
        Wed, 29 Aug 2018 18:37:51 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:51 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B1FF416C91B7; Wed, 29 Aug 2018 15:38:55 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 01/52] rcu: Remove rsp parameter from rcu_report_qs_rnp()
Date:   Wed, 29 Aug 2018 15:38:03 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0060-0000-0000-000002A66415
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557498; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0061-0000-0000-00004655B6A6
Message-Id: <20180829223854.4055-1-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=878 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There now is only one rcu_state structure in a given build of the
Linux kernel, so there is no need to pass it as a parameter to RCU's
functions.  This commit therefore removes the rsp parameter from
rcu_report_qs_rnp().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f0e7e3972fd9..c9f4d7f3de91 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -132,9 +132,8 @@ EXPORT_SYMBOL_GPL(rcu_scheduler_active);
  */
 static int rcu_scheduler_fully_active __read_mostly;
 
-static void
-rcu_report_qs_rnp(unsigned long mask, struct rcu_state *rsp,
-		  struct rcu_node *rnp, unsigned long gps, unsigned long flags);
+static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
+			      unsigned long gps, unsigned long flags);
 static void rcu_init_new_rnp(struct rcu_node *rnp_leaf);
 static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf);
 static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu);
@@ -1946,7 +1945,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 		mask = rnp->qsmask & ~rnp->qsmaskinitnext;
 		rnp->rcu_gp_init_mask = mask;
 		if ((mask || rnp->wait_blkd_tasks) && rcu_is_leaf_node(rnp))
-			rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
+			rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		else
 			raw_spin_unlock_irq_rcu_node(rnp);
 		cond_resched_tasks_rcu_qs();
@@ -2213,13 +2212,13 @@ static void rcu_report_qs_rsp(struct rcu_state *rsp, unsigned long flags)
  * disabled.  This allows propagating quiescent state due to resumed tasks
  * during grace-period initialization.
  */
-static void
-rcu_report_qs_rnp(unsigned long mask, struct rcu_state *rsp,
-		  struct rcu_node *rnp, unsigned long gps, unsigned long flags)
+static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
+			      unsigned long gps, unsigned long flags)
 	__releases(rnp->lock)
 {
 	unsigned long oldmask = 0;
 	struct rcu_node *rnp_c;
+	struct rcu_state __maybe_unused *rsp = &rcu_state;
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -2311,7 +2310,7 @@ rcu_report_unblock_qs_rnp(struct rcu_state *rsp,
 	mask = rnp->grpmask;
 	raw_spin_unlock_rcu_node(rnp);	/* irqs remain disabled. */
 	raw_spin_lock_rcu_node(rnp_p);	/* irqs already disabled. */
-	rcu_report_qs_rnp(mask, rsp, rnp_p, gps, flags);
+	rcu_report_qs_rnp(mask, rnp_p, gps, flags);
 }
 
 /*
@@ -2354,7 +2353,7 @@ rcu_report_qs_rdp(int cpu, struct rcu_state *rsp, struct rcu_data *rdp)
 		 */
 		needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
 
-		rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
+		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
 		if (needwake)
 			rcu_gp_kthread_wake(rsp);
@@ -2622,7 +2621,7 @@ static void force_qs_rnp(struct rcu_state *rsp, int (*f)(struct rcu_data *rsp))
 		}
 		if (mask != 0) {
 			/* Idle/offline CPUs, report (releases rnp->lock). */
-			rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
+			rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		} else {
 			/* Nothing to do here, so just drop the lock. */
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
@@ -3576,7 +3575,7 @@ void rcu_cpu_starting(unsigned int cpu)
 		rdp->rcu_onl_gp_flags = READ_ONCE(rsp->gp_flags);
 		if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
 			/* Report QS -after- changing ->qsmaskinitnext! */
-			rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
+			rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		} else {
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		}
@@ -3605,7 +3604,7 @@ static void rcu_cleanup_dying_idle_cpu(int cpu, struct rcu_state *rsp)
 	rdp->rcu_ofl_gp_flags = READ_ONCE(rsp->gp_flags);
 	if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
 		/* Report quiescent state -before- changing ->qsmaskinitnext! */
-		rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
+		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	}
 	rnp->qsmaskinitnext &= ~mask;
-- 
2.17.1

