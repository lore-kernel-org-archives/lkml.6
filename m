Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40411C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB55204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB55204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeH3CxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:53:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727590AbeH3CxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:53:23 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMs0Vt118883
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:15 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m61g7xntx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:14 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:54:13 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:54:08 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMs8tP28115118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:54:08 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E72F0B2065;
        Wed, 29 Aug 2018 18:53:03 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5522B2064;
        Wed, 29 Aug 2018 18:53:03 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:53:03 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B1EE616C91D9; Wed, 29 Aug 2018 15:54:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 18/24] rcu: Clean up flavor-related definitions and comments in tree.c
Date:   Wed, 29 Aug 2018 15:53:59 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829225340.GA7019@linux.vnet.ibm.com>
References: <20180829225340.GA7019@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0068-0000-0000-00000331BA5D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080749; UDB=6.00557500; IPR=6.00860734;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:54:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0069-0000-0000-0000458F1C59
Message-Id: <20180829225405.7275-18-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 74 ++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 42 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index fb888085d304..e8fbb7ee76cc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -382,12 +382,11 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 }
 
 /*
- * Register a quiescent state for all RCU flavors.  If there is an
+ * Register an urgently needed quiescent state.  If there is an
  * emergency, invoke rcu_momentary_dyntick_idle() to do a heavy-weight
- * dyntick-idle quiescent state visible to other CPUs (but only for those
- * RCU flavors in desperate need of a quiescent state, which will normally
- * be none of them).  Either way, do a lightweight quiescent state for
- * all RCU flavors.
+ * dyntick-idle quiescent state visible to other CPUs, which will in
+ * some cases serve for expedited as well as normal grace periods.
+ * Either way, register a lightweight quiescent state.
  *
  * The barrier() calls are redundant in the common case when this is
  * called externally, but just in case this is called from within this
@@ -564,7 +563,7 @@ void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
 
 /*
- * Return the root node of the specified rcu_state structure.
+ * Return the root node of the rcu_state structure.
  */
 static struct rcu_node *rcu_get_root(void)
 {
@@ -948,11 +947,7 @@ void rcu_request_urgent_qs_task(struct task_struct *t)
  * Disable preemption to avoid false positives that could otherwise
  * happen due to the current CPU number being sampled, this task being
  * preempted, its old CPU being taken offline, resuming on some other CPU,
- * then determining that its old CPU is now offline.  Because there are
- * multiple flavors of RCU, and because this function can be called in the
- * midst of updating the flavors while a given CPU coming online or going
- * offline, it is necessary to check all flavors.  If any of the flavors
- * believe that given CPU is online, it is considered to be online.
+ * then determining that its old CPU is now offline.
  *
  * Disable checking if in an NMI handler because we cannot safely
  * report errors from NMI handlers anyway.  In addition, it is OK to use
@@ -1562,11 +1557,10 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
 }
 
 /*
- * Awaken the grace-period kthread for the specified flavor of RCU.
- * Don't do a self-awaken, and don't bother awakening when there is
- * nothing for the grace-period kthread to do (as in several CPUs
- * raced to awaken, and we lost), and finally don't try to awaken
- * a kthread that has not yet been created.
+ * Awaken the grace-period kthread.  Don't do a self-awaken, and don't
+ * bother awakening when there is nothing for the grace-period kthread
+ * to do (as in several CPUs raced to awaken, and we lost), and finally
+ * don't try to awaken a kthread that has not yet been created.
  */
 static void rcu_gp_kthread_wake(void)
 {
@@ -2118,13 +2112,13 @@ static int __noreturn rcu_gp_kthread(void *unused)
 }
 
 /*
- * Report a full set of quiescent states to the specified rcu_state data
- * structure.  Invoke rcu_gp_kthread_wake() to awaken the grace-period
- * kthread if another grace period is required.  Whether we wake
- * the grace-period kthread or it awakens itself for the next round
- * of quiescent-state forcing, that kthread will clean up after the
- * just-completed grace period.  Note that the caller must hold rnp->lock,
- * which is released before return.
+ * Report a full set of quiescent states to the rcu_state data structure.
+ * Invoke rcu_gp_kthread_wake() to awaken the grace-period kthread if
+ * another grace period is required.  Whether we wake the grace-period
+ * kthread or it awakens itself for the next round of quiescent-state
+ * forcing, that kthread will clean up after the just-completed grace
+ * period.  Note that the caller must hold rnp->lock, which is released
+ * before return.
  */
 static void rcu_report_qs_rsp(unsigned long flags)
 	__releases(rcu_get_root()->lock)
@@ -2211,7 +2205,7 @@ static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
 /*
  * Record a quiescent state for all tasks that were previously queued
  * on the specified rcu_node structure and that were blocking the current
- * RCU grace period.  The caller must hold the specified rnp->lock with
+ * RCU grace period.  The caller must hold the corresponding rnp->lock with
  * irqs disabled, and this lock is released upon return, but irqs remain
  * disabled.
  */
@@ -2713,11 +2707,11 @@ static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused
 }
 
 /*
- * Schedule RCU callback invocation.  If the specified type of RCU
- * does not support RCU priority boosting, just do a direct call,
- * otherwise wake up the per-CPU kernel kthread.  Note that because we
- * are running on the current CPU with softirqs disabled, the
- * rcu_cpu_kthread_task cannot disappear out from under us.
+ * Schedule RCU callback invocation.  If the running implementation of RCU
+ * does not support RCU priority boosting, just do a direct call, otherwise
+ * wake up the per-CPU kernel kthread.  Note that because we are running
+ * on the current CPU with softirqs disabled, the rcu_cpu_kthread_task
+ * cannot disappear out from under us.
  */
 static void invoke_rcu_callbacks(struct rcu_data *rdp)
 {
@@ -2958,11 +2952,10 @@ EXPORT_SYMBOL_GPL(cond_synchronize_rcu);
 
 /*
  * Check to see if there is any immediate RCU-related work to be done by
- * the current CPU, for the specified type of RCU, returning 1 if so and
- * zero otherwise.  The checks are in order of increasing expense: checks
- * that can be carried out against CPU-local state are performed first.
- * However, we must check for CPU stalls first, else we might not get
- * a chance.
+ * the current CPU, returning 1 if so and zero otherwise.  The checks are
+ * in order of increasing expense: checks that can be carried out against
+ * CPU-local state are performed first.  However, we must check for CPU
+ * stalls first, else we might not get a chance.
  */
 static int rcu_pending(void)
 {
@@ -3069,10 +3062,7 @@ static void rcu_barrier_func(void *unused)
 	}
 }
 
-/*
- * Orchestrate the specified type of RCU barrier, waiting for all
- * RCU callbacks of the specified type to complete.
- */
+/* Orchestrate an RCU barrier, waiting for all RCU callbacks to complete.  */
 static void _rcu_barrier(void)
 {
 	int cpu;
@@ -3392,7 +3382,7 @@ void rcu_report_dead(unsigned int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
 
-	/* QS for any half-done expedited RCU-sched GP. */
+	/* QS for any half-done expedited grace period. */
 	preempt_disable();
 	rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
 	preempt_enable();
@@ -3481,7 +3471,7 @@ static int rcu_pm_notify(struct notifier_block *self,
 }
 
 /*
- * Spawn the kthreads that handle each RCU flavor's grace periods.
+ * Spawn the kthreads that handle RCU's grace periods.
  */
 static int __init rcu_spawn_gp_kthread(void)
 {
@@ -3544,7 +3534,7 @@ void rcu_scheduler_starting(void)
 }
 
 /*
- * Helper function for rcu_init() that initializes one rcu_state structure.
+ * Helper function for rcu_init() that initializes the rcu_state structure.
  */
 static void __init rcu_init_one(void)
 {
@@ -3706,7 +3696,7 @@ static void __init rcu_init_geometry(void)
 
 /*
  * Dump out the structure of the rcu_node combining tree associated
- * with the rcu_state structure referenced by rsp.
+ * with the rcu_state structure.
  */
 static void __init rcu_dump_rcu_node_tree(void)
 {
-- 
2.17.1

