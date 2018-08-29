Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E739FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0ACF20647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0ACF20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeH3CyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:54:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34136 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727722AbeH3CxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:53:25 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMs1Rq118975
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:16 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m61g7xnuu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:16 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:54:15 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:54:09 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMs8m727852962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:54:08 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE6D8B2066;
        Wed, 29 Aug 2018 18:53:04 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 980E1B2065;
        Wed, 29 Aug 2018 18:53:04 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:53:04 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BADA816C91B7; Wed, 29 Aug 2018 15:54:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 20/24] rcu: Clean up flavor-related definitions and comments in tree_plugin.h
Date:   Wed, 29 Aug 2018 15:54:01 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829225340.GA7019@linux.vnet.ibm.com>
References: <20180829225340.GA7019@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0052-0000-0000-0000032821BC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080749; UDB=6.00557500; IPR=6.00860734;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:54:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0053-0000-0000-00005DE60102
Message-Id: <20180829225405.7275-20-paulmck@linux.vnet.ibm.com>
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
 kernel/rcu/tree_plugin.h | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index cd276c46bc14..cd4c1b979446 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -38,8 +38,7 @@
 #include "../locking/rtmutex_common.h"
 
 /*
- * Control variables for per-CPU and per-rcu_node kthreads.  These
- * handle all flavors of RCU.
+ * Control variables for per-CPU and per-rcu_node kthreads.
  */
 static DEFINE_PER_CPU(struct task_struct *, rcu_cpu_kthread_task);
 DEFINE_PER_CPU(unsigned int, rcu_cpu_kthread_status);
@@ -826,8 +825,8 @@ static void rcu_flavor_check_callbacks(int user)
  *
  * Note that this guarantee implies further memory-ordering guarantees.
  * On systems with more than one CPU, when synchronize_rcu() returns,
- * each CPU is guaranteed to have executed a full memory barrier since the
- * end of its last RCU-sched read-side critical section whose beginning
+ * each CPU is guaranteed to have executed a full memory barrier since
+ * the end of its last RCU read-side critical section whose beginning
  * preceded the call to synchronize_rcu().  In addition, each CPU having
  * an RCU read-side critical section that extends beyond the return from
  * synchronize_rcu() is guaranteed to have executed a full memory barrier
@@ -1069,7 +1068,7 @@ void synchronize_rcu(void)
 	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
 			 lock_is_held(&rcu_lock_map) ||
 			 lock_is_held(&rcu_sched_lock_map),
-			 "Illegal synchronize_rcu() in RCU-sched read-side critical section");
+			 "Illegal synchronize_rcu() in RCU read-side critical section");
 	if (rcu_blocking_is_gp())
 		return;
 	if (rcu_gp_is_expedited())
@@ -1341,9 +1340,9 @@ static int rcu_cpu_kthread_should_run(unsigned int cpu)
 }
 
 /*
- * Per-CPU kernel thread that invokes RCU callbacks.  This replaces the
- * RCU softirq used in flavors and configurations of RCU that do not
- * support RCU priority boosting.
+ * Per-CPU kernel thread that invokes RCU callbacks.  This replaces
+ * the RCU softirq used in configurations of RCU that do not support RCU
+ * priority boosting.
  */
 static void rcu_cpu_kthread(unsigned int cpu)
 {
@@ -1484,8 +1483,8 @@ static void rcu_prepare_kthreads(int cpu)
  * 1 if so.  This function is part of the RCU implementation; it is -not-
  * an exported member of the RCU API.
  *
- * Because we not have RCU_FAST_NO_HZ, just check whether this CPU needs
- * any flavor of RCU.
+ * Because we not have RCU_FAST_NO_HZ, just check whether or not this
+ * CPU has RCU callbacks queued.
  */
 int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 {
@@ -1551,9 +1550,9 @@ static int rcu_idle_lazy_gp_delay = RCU_IDLE_LAZY_GP_DELAY;
 module_param(rcu_idle_lazy_gp_delay, int, 0644);
 
 /*
- * Try to advance callbacks for all flavors of RCU on the current CPU, but
- * only if it has been awhile since the last time we did so.  Afterwards,
- * if there are any callbacks ready for immediate invocation, return true.
+ * Try to advance callbacks on the current CPU, but only if it has been
+ * awhile since the last time we did so.  Afterwards, if there are any
+ * callbacks ready for immediate invocation, return true.
  */
 static bool __maybe_unused rcu_try_advance_all_cbs(void)
 {
@@ -1808,7 +1807,7 @@ static void print_cpu_stall_info_end(void)
 	pr_err("\t");
 }
 
-/* Zero ->ticks_this_gp for all flavors of RCU. */
+/* Zero ->ticks_this_gp and snapshot the number of RCU softirq handlers. */
 static void zero_cpu_stall_ticks(struct rcu_data *rdp)
 {
 	rdp->ticks_this_gp = 0;
@@ -1939,7 +1938,7 @@ static void wake_nocb_leader_defer(struct rcu_data *rdp, int waketype,
 }
 
 /*
- * Does the specified CPU need an RCU callback for the specified flavor
+ * Does the specified CPU need an RCU callback for this invocation
  * of rcu_barrier()?
  */
 static bool rcu_nocb_cpu_needs_barrier(int cpu)
@@ -2419,9 +2418,8 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
 
 /*
  * If the specified CPU is a no-CBs CPU that does not already have its
- * rcuo kthread for the specified RCU flavor, spawn it.  If the CPUs are
- * brought online out of order, this can require re-organizing the
- * leader-follower relationships.
+ * rcuo kthread, spawn it.  If the CPUs are brought online out of order,
+ * this can require re-organizing the leader-follower relationships.
  */
 static void rcu_spawn_one_nocb_kthread(int cpu)
 {
@@ -2458,7 +2456,7 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
 		rdp_spawn->nocb_next_follower = rdp_old_leader;
 	}
 
-	/* Spawn the kthread for this CPU and RCU flavor. */
+	/* Spawn the kthread for this CPU. */
 	t = kthread_run(rcu_nocb_kthread, rdp_spawn,
 			"rcuo%c/%d", rcu_state.abbr, cpu);
 	BUG_ON(IS_ERR(t));
-- 
2.17.1

