Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB3BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D347A2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D347A2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeH3IKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 04:10:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51208 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727193AbeH3IKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 04:10:43 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7U49JbI063144
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 00:10:25 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m693tghgk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 00:10:24 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 Aug 2018 00:10:24 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Aug 2018 00:10:19 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7U4AIib26607648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Aug 2018 04:10:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B488FB2066;
        Thu, 30 Aug 2018 00:09:13 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C9D3B205F;
        Thu, 30 Aug 2018 00:09:13 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.196.106])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 Aug 2018 00:09:13 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3FAB716C321A; Wed, 29 Aug 2018 21:10:17 -0700 (PDT)
Date:   Wed, 29 Aug 2018 21:10:17 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 0/52] Remove rcu_state pointers for
 v4.20/v5.0
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180829223830.GA1800@linux.vnet.ibm.com>
 <20180829220026.3579e9a1@vmware.local.home>
 <20180830032216.GF4225@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830032216.GF4225@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18083004-0040-0000-0000-000004679C7E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009637; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080853; UDB=6.00557563; IPR=6.00860838;
 MB=3.00023005; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-30 04:10:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18083004-0041-0000-0000-0000086EB690
Message-Id: <20180830041017.GA27378@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-30_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808300041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 08:22:16PM -0700, Paul E. McKenney wrote:
> On Wed, Aug 29, 2018 at 10:00:26PM -0400, Steven Rostedt wrote:
> > On Wed, 29 Aug 2018 15:38:30 -0700
> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > 
> > > Hello!
> > > 
> > > This commit does RCU-consolidation cleanups that get rid of pointers to
> > > the sole remaining rcu_state structure:
> > > 
> > > 1-40:	Remove the "rsp" parameter from numerous functions, given that
> > > 	the corresponding argument will always be &rcu_state.
> > 
> > Hmm, couldn't 1-40 have been made into a single patch?
> 
> They could.  I separated them to make finding the inevitable typos easier.
> But at this point, it is easy enough to squash them together, though.

And please see below for what the resulting diff would look like.  Is
this an improvement?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.html b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
index f5120a00f511..772c26a3865a 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.html
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
@@ -1372,8 +1372,7 @@ that is, if the CPU is currently idle.
 Accessor Functions</a></h3>
 
 <p>The following listing shows the
-<tt>rcu_get_root()</tt>, <tt>rcu_for_each_node_breadth_first</tt>,
-<tt>rcu_for_each_nonleaf_node_breadth_first()</tt>, and
+<tt>rcu_get_root()</tt>, <tt>rcu_for_each_node_breadth_first</tt> and
 <tt>rcu_for_each_leaf_node()</tt> function and macros:
 
 <pre>
@@ -1386,13 +1385,9 @@ Accessor Functions</a></h3>
   7   for ((rnp) = &amp;(rsp)-&gt;node[0]; \
   8        (rnp) &lt; &amp;(rsp)-&gt;node[NUM_RCU_NODES]; (rnp)++)
   9
- 10 #define rcu_for_each_nonleaf_node_breadth_first(rsp, rnp) \
- 11   for ((rnp) = &amp;(rsp)-&gt;node[0]; \
- 12        (rnp) &lt; (rsp)-&gt;level[NUM_RCU_LVLS - 1]; (rnp)++)
- 13
- 14 #define rcu_for_each_leaf_node(rsp, rnp) \
- 15   for ((rnp) = (rsp)-&gt;level[NUM_RCU_LVLS - 1]; \
- 16        (rnp) &lt; &amp;(rsp)-&gt;node[NUM_RCU_NODES]; (rnp)++)
+ 10 #define rcu_for_each_leaf_node(rsp, rnp) \
+ 11   for ((rnp) = (rsp)-&gt;level[NUM_RCU_LVLS - 1]; \
+ 12        (rnp) &lt; &amp;(rsp)-&gt;node[NUM_RCU_NODES]; (rnp)++)
 </pre>
 
 <p>The <tt>rcu_get_root()</tt> simply returns a pointer to the
@@ -1405,10 +1400,7 @@ macro takes advantage of the layout of the <tt>rcu_node</tt>
 structures in the <tt>rcu_state</tt> structure's
 <tt>-&gt;node[]</tt> array, performing a breadth-first traversal by
 simply traversing the array in order.
-The <tt>rcu_for_each_nonleaf_node_breadth_first()</tt> macro operates
-similarly, but traverses only the first part of the array, thus excluding
-the leaf <tt>rcu_node</tt> structures.
-Finally, the <tt>rcu_for_each_leaf_node()</tt> macro traverses only
+Similarly, the <tt>rcu_for_each_leaf_node()</tt> macro traverses only
 the last part of the array, thus traversing only the leaf
 <tt>rcu_node</tt> structures.
 
@@ -1416,15 +1408,14 @@ the last part of the array, thus traversing only the leaf
 <tr><th>&nbsp;</th></tr>
 <tr><th align="left">Quick Quiz:</th></tr>
 <tr><td>
-	What do <tt>rcu_for_each_nonleaf_node_breadth_first()</tt> and
+	What does
 	<tt>rcu_for_each_leaf_node()</tt> do if the <tt>rcu_node</tt> tree
 	contains only a single node?
 </td></tr>
 <tr><th align="left">Answer:</th></tr>
 <tr><td bgcolor="#ffffff"><font color="ffffff">
 	In the single-node case,
-	<tt>rcu_for_each_nonleaf_node_breadth_first()</tt> is a no-op
-	and <tt>rcu_for_each_leaf_node()</tt> traverses the single node.
+	<tt>rcu_for_each_leaf_node()</tt> traverses the single node.
 </font></td></tr>
 <tr><td>&nbsp;</td></tr>
 </table>
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 4d04683c31b2..2bb77fddc11f 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -329,29 +329,23 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
 }
 
 /* Returns first leaf rcu_node of the specified RCU flavor. */
-#define rcu_first_leaf_node(rsp) ((rsp)->level[rcu_num_lvls - 1])
+#define rcu_first_leaf_node() (rcu_state.level[rcu_num_lvls - 1])
 
 /* Is this rcu_node a leaf? */
 #define rcu_is_leaf_node(rnp) ((rnp)->level == rcu_num_lvls - 1)
 
 /* Is this rcu_node the last leaf? */
-#define rcu_is_last_leaf_node(rsp, rnp) ((rnp) == &(rsp)->node[rcu_num_nodes - 1])
+#define rcu_is_last_leaf_node(rnp) ((rnp) == &rcu_state.node[rcu_num_nodes - 1])
 
 /*
- * Do a full breadth-first scan of the rcu_node structures for the
+ * Do a full breadth-first scan of the {s,}rcu_node structures for the
  * specified rcu_state structure.
  */
-#define rcu_for_each_node_breadth_first(rsp, rnp) \
-	for ((rnp) = &(rsp)->node[0]; \
-	     (rnp) < &(rsp)->node[rcu_num_nodes]; (rnp)++)
-
-/*
- * Do a breadth-first scan of the non-leaf rcu_node structures for the
- * specified rcu_state structure.  Note that if there is a singleton
- * rcu_node tree with but one rcu_node structure, this loop is a no-op.
- */
-#define rcu_for_each_nonleaf_node_breadth_first(rsp, rnp) \
-	for ((rnp) = &(rsp)->node[0]; !rcu_is_leaf_node(rsp, rnp); (rnp)++)
+#define srcu_for_each_node_breadth_first(sp, rnp) \
+	for ((rnp) = &(sp)->node[0]; \
+	     (rnp) < &(sp)->node[rcu_num_nodes]; (rnp)++)
+#define rcu_for_each_node_breadth_first(rnp) \
+	srcu_for_each_node_breadth_first(&rcu_state, rnp)
 
 /*
  * Scan the leaves of the rcu_node hierarchy for the specified rcu_state
@@ -359,9 +353,9 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
  * one rcu_node structure, this loop -will- visit the rcu_node structure.
  * It is still a leaf node, even if it is also the root node.
  */
-#define rcu_for_each_leaf_node(rsp, rnp) \
-	for ((rnp) = rcu_first_leaf_node(rsp); \
-	     (rnp) < &(rsp)->node[rcu_num_nodes]; (rnp)++)
+#define rcu_for_each_leaf_node(rnp) \
+	for ((rnp) = rcu_first_leaf_node(); \
+	     (rnp) < &rcu_state.node[rcu_num_nodes]; (rnp)++)
 
 /*
  * Iterate over all possible CPUs in a leaf RCU node.
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6c9866a854b1..2042080cd38b 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -105,7 +105,7 @@ static void init_srcu_struct_nodes(struct srcu_struct *sp, bool is_static)
 	rcu_init_levelspread(levelspread, num_rcu_lvl);
 
 	/* Each pass through this loop initializes one srcu_node structure. */
-	rcu_for_each_node_breadth_first(sp, snp) {
+	srcu_for_each_node_breadth_first(sp, snp) {
 		spin_lock_init(&ACCESS_PRIVATE(snp, lock));
 		WARN_ON_ONCE(ARRAY_SIZE(snp->srcu_have_cbs) !=
 			     ARRAY_SIZE(snp->srcu_data_have_cbs));
@@ -561,7 +561,7 @@ static void srcu_gp_end(struct srcu_struct *sp)
 
 	/* Initiate callback invocation as needed. */
 	idx = rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->srcu_have_cbs);
-	rcu_for_each_node_breadth_first(sp, snp) {
+	srcu_for_each_node_breadth_first(sp, snp) {
 		spin_lock_irq_rcu_node(snp);
 		cbs = false;
 		last_lvl = snp >= sp->level[rcu_num_lvls - 1];
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f0e7e3972fd9..35b705c1da40 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -132,15 +132,14 @@ EXPORT_SYMBOL_GPL(rcu_scheduler_active);
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
 static void invoke_rcu_core(void);
-static void invoke_rcu_callbacks(struct rcu_state *rsp, struct rcu_data *rdp);
-static void rcu_report_exp_rdp(struct rcu_state *rsp, struct rcu_data *rdp);
+static void invoke_rcu_callbacks(struct rcu_data *rdp);
+static void rcu_report_exp_rdp(struct rcu_data *rdp);
 static void sync_sched_exp_online_cleanup(int cpu);
 
 /* rcuc/rcub kthread realtime priority */
@@ -190,9 +189,9 @@ unsigned long rcu_rnp_online_cpus(struct rcu_node *rnp)
  * permit this function to be invoked without holding the root rcu_node
  * structure's ->lock, but of course results can be subject to change.
  */
-static int rcu_gp_in_progress(struct rcu_state *rsp)
+static int rcu_gp_in_progress(void)
 {
-	return rcu_seq_state(rcu_seq_current(&rsp->gp_seq));
+	return rcu_seq_state(rcu_seq_current(&rcu_state.gp_seq));
 }
 
 void rcu_softirq_qs(void)
@@ -480,8 +479,8 @@ module_param(rcu_kick_kthreads, bool, 0644);
 static ulong jiffies_till_sched_qs = HZ / 10;
 module_param(jiffies_till_sched_qs, ulong, 0444);
 
-static void force_qs_rnp(struct rcu_state *rsp, int (*f)(struct rcu_data *rsp));
-static void force_quiescent_state(struct rcu_state *rsp);
+static void force_qs_rnp(int (*f)(struct rcu_data *rsp));
+static void force_quiescent_state(void);
 static int rcu_pending(void);
 
 /*
@@ -539,7 +538,7 @@ EXPORT_SYMBOL_GPL(rcu_exp_batches_completed_sched);
  */
 void rcu_force_quiescent_state(void)
 {
-	force_quiescent_state(&rcu_state);
+	force_quiescent_state();
 }
 EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
 
@@ -548,7 +547,7 @@ EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
  */
 void rcu_bh_force_quiescent_state(void)
 {
-	force_quiescent_state(&rcu_state);
+	force_quiescent_state();
 }
 EXPORT_SYMBOL_GPL(rcu_bh_force_quiescent_state);
 
@@ -574,7 +573,7 @@ void show_rcu_gp_kthreads(void)
 	for_each_rcu_flavor(rsp) {
 		pr_info("%s: wait state: %d ->state: %#lx\n",
 			rsp->name, rsp->gp_state, rsp->gp_kthread->state);
-		rcu_for_each_node_breadth_first(rsp, rnp) {
+		rcu_for_each_node_breadth_first(rnp) {
 			if (ULONG_CMP_GE(rsp->gp_seq, rnp->gp_seq_needed))
 				continue;
 			pr_info("\trcu_node %d:%d ->gp_seq %lu ->gp_seq_needed %lu\n",
@@ -624,9 +623,9 @@ EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
 /*
  * Return the root node of the specified rcu_state structure.
  */
-static struct rcu_node *rcu_get_root(struct rcu_state *rsp)
+static struct rcu_node *rcu_get_root(void)
 {
-	return &rsp->node[0];
+	return &rcu_state.node[0];
 }
 
 /*
@@ -1214,17 +1213,17 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	return 0;
 }
 
-static void record_gp_stall_check_time(struct rcu_state *rsp)
+static void record_gp_stall_check_time(void)
 {
 	unsigned long j = jiffies;
 	unsigned long j1;
 
-	rsp->gp_start = j;
+	rcu_state.gp_start = j;
 	j1 = rcu_jiffies_till_stall_check();
 	/* Record ->gp_start before ->jiffies_stall. */
-	smp_store_release(&rsp->jiffies_stall, j + j1); /* ^^^ */
-	rsp->jiffies_resched = j + j1 / 2;
-	rsp->n_force_qs_gpstart = READ_ONCE(rsp->n_force_qs);
+	smp_store_release(&rcu_state.jiffies_stall, j + j1); /* ^^^ */
+	rcu_state.jiffies_resched = j + j1 / 2;
+	rcu_state.n_force_qs_gpstart = READ_ONCE(rcu_state.n_force_qs);
 }
 
 /*
@@ -1240,10 +1239,11 @@ static const char *gp_state_getname(short gs)
 /*
  * Complain about starvation of grace-period kthread.
  */
-static void rcu_check_gp_kthread_starvation(struct rcu_state *rsp)
+static void rcu_check_gp_kthread_starvation(void)
 {
 	unsigned long gpa;
 	unsigned long j;
+	struct rcu_state *rsp = &rcu_state;
 
 	j = jiffies;
 	gpa = READ_ONCE(rsp->gp_activity);
@@ -1269,13 +1269,13 @@ static void rcu_check_gp_kthread_starvation(struct rcu_state *rsp)
  * that don't support NMI-based stack dumps.  The NMI-triggered stack
  * traces are more accurate because they are printed by the target CPU.
  */
-static void rcu_dump_cpu_stacks(struct rcu_state *rsp)
+static void rcu_dump_cpu_stacks(void)
 {
 	int cpu;
 	unsigned long flags;
 	struct rcu_node *rnp;
 
-	rcu_for_each_leaf_node(rsp, rnp) {
+	rcu_for_each_leaf_node(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		for_each_leaf_node_possible_cpu(rnp, cpu)
 			if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu))
@@ -1289,15 +1289,16 @@ static void rcu_dump_cpu_stacks(struct rcu_state *rsp)
  * If too much time has passed in the current grace period, and if
  * so configured, go kick the relevant kthreads.
  */
-static void rcu_stall_kick_kthreads(struct rcu_state *rsp)
+static void rcu_stall_kick_kthreads(void)
 {
 	unsigned long j;
+	struct rcu_state *rsp = &rcu_state;
 
 	if (!rcu_kick_kthreads)
 		return;
 	j = READ_ONCE(rsp->jiffies_kick_kthreads);
 	if (time_after(jiffies, j) && rsp->gp_kthread &&
-	    (rcu_gp_in_progress(rsp) || READ_ONCE(rsp->gp_flags))) {
+	    (rcu_gp_in_progress() || READ_ONCE(rsp->gp_flags))) {
 		WARN_ONCE(1, "Kicking %s grace-period kthread\n", rsp->name);
 		rcu_ftrace_dump(DUMP_ALL);
 		wake_up_process(rsp->gp_kthread);
@@ -1311,18 +1312,19 @@ static void panic_on_rcu_stall(void)
 		panic("RCU Stall\n");
 }
 
-static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gp_seq)
+static void print_other_cpu_stall(unsigned long gp_seq)
 {
 	int cpu;
 	unsigned long flags;
 	unsigned long gpa;
 	unsigned long j;
 	int ndetected = 0;
-	struct rcu_node *rnp = rcu_get_root(rsp);
+	struct rcu_node *rnp = rcu_get_root();
+	struct rcu_state *rsp = &rcu_state;
 	long totqlen = 0;
 
 	/* Kick and suppress, if so configured. */
-	rcu_stall_kick_kthreads(rsp);
+	rcu_stall_kick_kthreads();
 	if (rcu_cpu_stall_suppress)
 		return;
 
@@ -1333,13 +1335,13 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gp_seq)
 	 */
 	pr_err("INFO: %s detected stalls on CPUs/tasks:", rsp->name);
 	print_cpu_stall_info_begin();
-	rcu_for_each_leaf_node(rsp, rnp) {
+	rcu_for_each_leaf_node(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		ndetected += rcu_print_task_stall(rnp);
 		if (rnp->qsmask != 0) {
 			for_each_leaf_node_possible_cpu(rnp, cpu)
 				if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
-					print_cpu_stall_info(rsp, cpu);
+					print_cpu_stall_info(cpu);
 					ndetected++;
 				}
 		}
@@ -1354,10 +1356,10 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gp_seq)
 	       smp_processor_id(), (long)(jiffies - rsp->gp_start),
 	       (long)rcu_seq_current(&rsp->gp_seq), totqlen);
 	if (ndetected) {
-		rcu_dump_cpu_stacks(rsp);
+		rcu_dump_cpu_stacks();
 
 		/* Complain about tasks blocking the grace period. */
-		rcu_print_detail_task_stall(rsp);
+		rcu_print_detail_task_stall();
 	} else {
 		if (rcu_seq_current(&rsp->gp_seq) != gp_seq) {
 			pr_err("INFO: Stall ended before state dump start\n");
@@ -1367,7 +1369,7 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gp_seq)
 			pr_err("All QSes seen, last %s kthread activity %ld (%ld-%ld), jiffies_till_next_fqs=%ld, root ->qsmask %#lx\n",
 			       rsp->name, j - gpa, j, gpa,
 			       jiffies_till_next_fqs,
-			       rcu_get_root(rsp)->qsmask);
+			       rcu_get_root()->qsmask);
 			/* In this case, the current CPU might be at fault. */
 			sched_show_task(current);
 		}
@@ -1377,23 +1379,24 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gp_seq)
 		WRITE_ONCE(rsp->jiffies_stall,
 			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
 
-	rcu_check_gp_kthread_starvation(rsp);
+	rcu_check_gp_kthread_starvation();
 
 	panic_on_rcu_stall();
 
-	force_quiescent_state(rsp);  /* Kick them all. */
+	force_quiescent_state();  /* Kick them all. */
 }
 
-static void print_cpu_stall(struct rcu_state *rsp)
+static void print_cpu_stall(void)
 {
 	int cpu;
 	unsigned long flags;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-	struct rcu_node *rnp = rcu_get_root(rsp);
+	struct rcu_node *rnp = rcu_get_root();
+	struct rcu_state *rsp = &rcu_state;
 	long totqlen = 0;
 
 	/* Kick and suppress, if so configured. */
-	rcu_stall_kick_kthreads(rsp);
+	rcu_stall_kick_kthreads();
 	if (rcu_cpu_stall_suppress)
 		return;
 
@@ -1405,7 +1408,7 @@ static void print_cpu_stall(struct rcu_state *rsp)
 	pr_err("INFO: %s self-detected stall on CPU", rsp->name);
 	print_cpu_stall_info_begin();
 	raw_spin_lock_irqsave_rcu_node(rdp->mynode, flags);
-	print_cpu_stall_info(rsp, smp_processor_id());
+	print_cpu_stall_info(smp_processor_id());
 	raw_spin_unlock_irqrestore_rcu_node(rdp->mynode, flags);
 	print_cpu_stall_info_end();
 	for_each_possible_cpu(cpu)
@@ -1415,9 +1418,9 @@ static void print_cpu_stall(struct rcu_state *rsp)
 		jiffies - rsp->gp_start,
 		(long)rcu_seq_current(&rsp->gp_seq), totqlen);
 
-	rcu_check_gp_kthread_starvation(rsp);
+	rcu_check_gp_kthread_starvation();
 
-	rcu_dump_cpu_stacks(rsp);
+	rcu_dump_cpu_stacks();
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	/* Rewrite if needed in case of slow consoles. */
@@ -1438,7 +1441,7 @@ static void print_cpu_stall(struct rcu_state *rsp)
 	resched_cpu(smp_processor_id());
 }
 
-static void check_cpu_stall(struct rcu_state *rsp, struct rcu_data *rdp)
+static void check_cpu_stall(struct rcu_data *rdp)
 {
 	unsigned long gs1;
 	unsigned long gs2;
@@ -1447,11 +1450,12 @@ static void check_cpu_stall(struct rcu_state *rsp, struct rcu_data *rdp)
 	unsigned long jn;
 	unsigned long js;
 	struct rcu_node *rnp;
+	struct rcu_state *rsp = &rcu_state;
 
 	if ((rcu_cpu_stall_suppress && !rcu_kick_kthreads) ||
-	    !rcu_gp_in_progress(rsp))
+	    !rcu_gp_in_progress())
 		return;
-	rcu_stall_kick_kthreads(rsp);
+	rcu_stall_kick_kthreads();
 	j = jiffies;
 
 	/*
@@ -1484,19 +1488,19 @@ static void check_cpu_stall(struct rcu_state *rsp, struct rcu_data *rdp)
 		return; /* No stall or GP completed since entering function. */
 	rnp = rdp->mynode;
 	jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
-	if (rcu_gp_in_progress(rsp) &&
+	if (rcu_gp_in_progress() &&
 	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
 	    cmpxchg(&rsp->jiffies_stall, js, jn) == js) {
 
 		/* We haven't checked in, so go dump stack. */
-		print_cpu_stall(rsp);
+		print_cpu_stall();
 
-	} else if (rcu_gp_in_progress(rsp) &&
+	} else if (rcu_gp_in_progress() &&
 		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
 		   cmpxchg(&rsp->jiffies_stall, js, jn) == js) {
 
 		/* They had a few time units to dump stack, so complain. */
-		print_other_cpu_stall(rsp, gs2);
+		print_other_cpu_stall(gs2);
 	}
 }
 
@@ -1589,7 +1593,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 	}
 
 	/* If GP already in progress, just leave, otherwise start one. */
-	if (rcu_gp_in_progress(rsp)) {
+	if (rcu_gp_in_progress()) {
 		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startedleafroot"));
 		goto unlock_out;
 	}
@@ -1617,7 +1621,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
  * Clean up any old requests for the just-ended grace period.  Also return
  * whether any additional grace periods have been requested.
  */
-static bool rcu_future_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
+static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
 {
 	bool needmore;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
@@ -1637,13 +1641,13 @@ static bool rcu_future_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
  * raced to awaken, and we lost), and finally don't try to awaken
  * a kthread that has not yet been created.
  */
-static void rcu_gp_kthread_wake(struct rcu_state *rsp)
+static void rcu_gp_kthread_wake(void)
 {
-	if (current == rsp->gp_kthread ||
-	    !READ_ONCE(rsp->gp_flags) ||
-	    !rsp->gp_kthread)
+	if (current == rcu_state.gp_kthread ||
+	    !READ_ONCE(rcu_state.gp_flags) ||
+	    !rcu_state.gp_kthread)
 		return;
-	swake_up_one(&rsp->gp_wq);
+	swake_up_one(&rcu_state.gp_wq);
 }
 
 /*
@@ -1658,11 +1662,11 @@ static void rcu_gp_kthread_wake(struct rcu_state *rsp)
  *
  * The caller must hold rnp->lock with interrupts disabled.
  */
-static bool rcu_accelerate_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
-			       struct rcu_data *rdp)
+static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	unsigned long gp_seq_req;
 	bool ret = false;
+	struct rcu_state *rsp = &rcu_state;
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -1699,25 +1703,24 @@ static bool rcu_accelerate_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
  * that a new grace-period request be made, invokes rcu_accelerate_cbs()
  * while holding the leaf rcu_node structure's ->lock.
  */
-static void rcu_accelerate_cbs_unlocked(struct rcu_state *rsp,
-					struct rcu_node *rnp,
+static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
 					struct rcu_data *rdp)
 {
 	unsigned long c;
 	bool needwake;
 
 	lockdep_assert_irqs_disabled();
-	c = rcu_seq_snap(&rsp->gp_seq);
+	c = rcu_seq_snap(&rcu_state.gp_seq);
 	if (!rdp->gpwrap && ULONG_CMP_GE(rdp->gp_seq_needed, c)) {
 		/* Old request still live, so mark recent callbacks. */
 		(void)rcu_segcblist_accelerate(&rdp->cblist, c);
 		return;
 	}
 	raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
-	needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
+	needwake = rcu_accelerate_cbs(rnp, rdp);
 	raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
 	if (needwake)
-		rcu_gp_kthread_wake(rsp);
+		rcu_gp_kthread_wake();
 }
 
 /*
@@ -1730,8 +1733,7 @@ static void rcu_accelerate_cbs_unlocked(struct rcu_state *rsp,
  *
  * The caller must hold rnp->lock with interrupts disabled.
  */
-static bool rcu_advance_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
-			    struct rcu_data *rdp)
+static bool rcu_advance_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -1746,7 +1748,7 @@ static bool rcu_advance_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
 	rcu_segcblist_advance(&rdp->cblist, rnp->gp_seq);
 
 	/* Classify any remaining callbacks. */
-	return rcu_accelerate_cbs(rsp, rnp, rdp);
+	return rcu_accelerate_cbs(rnp, rdp);
 }
 
 /*
@@ -1755,11 +1757,11 @@ static bool rcu_advance_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
  * structure corresponding to the current CPU, and must have irqs disabled.
  * Returns true if the grace-period kthread needs to be awakened.
  */
-static bool __note_gp_changes(struct rcu_state *rsp, struct rcu_node *rnp,
-			      struct rcu_data *rdp)
+static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	bool ret;
 	bool need_gp;
+	struct rcu_state __maybe_unused *rsp = &rcu_state;
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -1769,10 +1771,10 @@ static bool __note_gp_changes(struct rcu_state *rsp, struct rcu_node *rnp,
 	/* Handle the ends of any preceding grace periods first. */
 	if (rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
 	    unlikely(READ_ONCE(rdp->gpwrap))) {
-		ret = rcu_advance_cbs(rsp, rnp, rdp); /* Advance callbacks. */
+		ret = rcu_advance_cbs(rnp, rdp); /* Advance callbacks. */
 		trace_rcu_grace_period(rsp->name, rdp->gp_seq, TPS("cpuend"));
 	} else {
-		ret = rcu_accelerate_cbs(rsp, rnp, rdp); /* Recent callbacks. */
+		ret = rcu_accelerate_cbs(rnp, rdp); /* Recent callbacks. */
 	}
 
 	/* Now handle the beginnings of any new-to-this-CPU grace periods. */
@@ -1798,7 +1800,7 @@ static bool __note_gp_changes(struct rcu_state *rsp, struct rcu_node *rnp,
 	return ret;
 }
 
-static void note_gp_changes(struct rcu_state *rsp, struct rcu_data *rdp)
+static void note_gp_changes(struct rcu_data *rdp)
 {
 	unsigned long flags;
 	bool needwake;
@@ -1812,16 +1814,16 @@ static void note_gp_changes(struct rcu_state *rsp, struct rcu_data *rdp)
 		local_irq_restore(flags);
 		return;
 	}
-	needwake = __note_gp_changes(rsp, rnp, rdp);
+	needwake = __note_gp_changes(rnp, rdp);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	if (needwake)
-		rcu_gp_kthread_wake(rsp);
+		rcu_gp_kthread_wake();
 }
 
-static void rcu_gp_slow(struct rcu_state *rsp, int delay)
+static void rcu_gp_slow(int delay)
 {
 	if (delay > 0 &&
-	    !(rcu_seq_ctr(rsp->gp_seq) %
+	    !(rcu_seq_ctr(rcu_state.gp_seq) %
 	      (rcu_num_nodes * PER_RCU_NODE_PERIOD * delay)))
 		schedule_timeout_uninterruptible(delay);
 }
@@ -1829,13 +1831,14 @@ static void rcu_gp_slow(struct rcu_state *rsp, int delay)
 /*
  * Initialize a new grace period.  Return false if no grace period required.
  */
-static bool rcu_gp_init(struct rcu_state *rsp)
+static bool rcu_gp_init(void)
 {
 	unsigned long flags;
 	unsigned long oldmask;
 	unsigned long mask;
 	struct rcu_data *rdp;
-	struct rcu_node *rnp = rcu_get_root(rsp);
+	struct rcu_node *rnp = rcu_get_root();
+	struct rcu_state *rsp = &rcu_state;
 
 	WRITE_ONCE(rsp->gp_activity, jiffies);
 	raw_spin_lock_irq_rcu_node(rnp);
@@ -1846,7 +1849,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 	}
 	WRITE_ONCE(rsp->gp_flags, 0); /* Clear all flags: New grace period. */
 
-	if (WARN_ON_ONCE(rcu_gp_in_progress(rsp))) {
+	if (WARN_ON_ONCE(rcu_gp_in_progress())) {
 		/*
 		 * Grace period already in progress, don't start another.
 		 * Not supposed to be able to happen.
@@ -1856,7 +1859,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 	}
 
 	/* Advance to a new grace period and initialize state. */
-	record_gp_stall_check_time(rsp);
+	record_gp_stall_check_time();
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
 	rcu_seq_start(&rsp->gp_seq);
 	trace_rcu_grace_period(rsp->name, rsp->gp_seq, TPS("start"));
@@ -1869,7 +1872,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 	 * will handle subsequent offline CPUs.
 	 */
 	rsp->gp_state = RCU_GP_ONOFF;
-	rcu_for_each_leaf_node(rsp, rnp) {
+	rcu_for_each_leaf_node(rnp) {
 		spin_lock(&rsp->ofl_lock);
 		raw_spin_lock_irq_rcu_node(rnp);
 		if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
@@ -1914,7 +1917,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 		raw_spin_unlock_irq_rcu_node(rnp);
 		spin_unlock(&rsp->ofl_lock);
 	}
-	rcu_gp_slow(rsp, gp_preinit_delay); /* Races with CPU hotplug. */
+	rcu_gp_slow(gp_preinit_delay); /* Races with CPU hotplug. */
 
 	/*
 	 * Set the quiescent-state-needed bits in all the rcu_node
@@ -1929,15 +1932,15 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 	 * process finishes, because this kthread handles both.
 	 */
 	rsp->gp_state = RCU_GP_INIT;
-	rcu_for_each_node_breadth_first(rsp, rnp) {
-		rcu_gp_slow(rsp, gp_init_delay);
+	rcu_for_each_node_breadth_first(rnp) {
+		rcu_gp_slow(gp_init_delay);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		rdp = this_cpu_ptr(&rcu_data);
-		rcu_preempt_check_blocked_tasks(rsp, rnp);
+		rcu_preempt_check_blocked_tasks(rnp);
 		rnp->qsmask = rnp->qsmaskinit;
 		WRITE_ONCE(rnp->gp_seq, rsp->gp_seq);
 		if (rnp == rdp->mynode)
-			(void)__note_gp_changes(rsp, rnp, rdp);
+			(void)__note_gp_changes(rnp, rdp);
 		rcu_preempt_boost_start_gp(rnp);
 		trace_rcu_grace_period_init(rsp->name, rnp->gp_seq,
 					    rnp->level, rnp->grplo,
@@ -1946,7 +1949,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 		mask = rnp->qsmask & ~rnp->qsmaskinitnext;
 		rnp->rcu_gp_init_mask = mask;
 		if ((mask || rnp->wait_blkd_tasks) && rcu_is_leaf_node(rnp))
-			rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
+			rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		else
 			raw_spin_unlock_irq_rcu_node(rnp);
 		cond_resched_tasks_rcu_qs();
@@ -1960,12 +1963,12 @@ static bool rcu_gp_init(struct rcu_state *rsp)
  * Helper function for swait_event_idle_exclusive() wakeup at force-quiescent-state
  * time.
  */
-static bool rcu_gp_fqs_check_wake(struct rcu_state *rsp, int *gfp)
+static bool rcu_gp_fqs_check_wake(int *gfp)
 {
-	struct rcu_node *rnp = rcu_get_root(rsp);
+	struct rcu_node *rnp = rcu_get_root();
 
 	/* Someone like call_rcu() requested a force-quiescent-state scan. */
-	*gfp = READ_ONCE(rsp->gp_flags);
+	*gfp = READ_ONCE(rcu_state.gp_flags);
 	if (*gfp & RCU_GP_FLAG_FQS)
 		return true;
 
@@ -1979,18 +1982,19 @@ static bool rcu_gp_fqs_check_wake(struct rcu_state *rsp, int *gfp)
 /*
  * Do one round of quiescent-state forcing.
  */
-static void rcu_gp_fqs(struct rcu_state *rsp, bool first_time)
+static void rcu_gp_fqs(bool first_time)
 {
-	struct rcu_node *rnp = rcu_get_root(rsp);
+	struct rcu_node *rnp = rcu_get_root();
+	struct rcu_state *rsp = &rcu_state;
 
 	WRITE_ONCE(rsp->gp_activity, jiffies);
 	rsp->n_force_qs++;
 	if (first_time) {
 		/* Collect dyntick-idle snapshots. */
-		force_qs_rnp(rsp, dyntick_save_progress_counter);
+		force_qs_rnp(dyntick_save_progress_counter);
 	} else {
 		/* Handle dyntick-idle and offline CPUs. */
-		force_qs_rnp(rsp, rcu_implicit_dynticks_qs);
+		force_qs_rnp(rcu_implicit_dynticks_qs);
 	}
 	/* Clear flag to prevent immediate re-entry. */
 	if (READ_ONCE(rsp->gp_flags) & RCU_GP_FLAG_FQS) {
@@ -2004,13 +2008,14 @@ static void rcu_gp_fqs(struct rcu_state *rsp, bool first_time)
 /*
  * Clean up after the old grace period.
  */
-static void rcu_gp_cleanup(struct rcu_state *rsp)
+static void rcu_gp_cleanup(void)
 {
 	unsigned long gp_duration;
 	bool needgp = false;
 	unsigned long new_gp_seq;
 	struct rcu_data *rdp;
-	struct rcu_node *rnp = rcu_get_root(rsp);
+	struct rcu_node *rnp = rcu_get_root();
+	struct rcu_state *rsp = &rcu_state;
 	struct swait_queue_head *sq;
 
 	WRITE_ONCE(rsp->gp_activity, jiffies);
@@ -2040,25 +2045,25 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	 */
 	new_gp_seq = rsp->gp_seq;
 	rcu_seq_end(&new_gp_seq);
-	rcu_for_each_node_breadth_first(rsp, rnp) {
+	rcu_for_each_node_breadth_first(rnp) {
 		raw_spin_lock_irq_rcu_node(rnp);
 		if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
-			dump_blkd_tasks(rsp, rnp, 10);
+			dump_blkd_tasks(rnp, 10);
 		WARN_ON_ONCE(rnp->qsmask);
 		WRITE_ONCE(rnp->gp_seq, new_gp_seq);
 		rdp = this_cpu_ptr(&rcu_data);
 		if (rnp == rdp->mynode)
-			needgp = __note_gp_changes(rsp, rnp, rdp) || needgp;
+			needgp = __note_gp_changes(rnp, rdp) || needgp;
 		/* smp_mb() provided by prior unlock-lock pair. */
-		needgp = rcu_future_gp_cleanup(rsp, rnp) || needgp;
+		needgp = rcu_future_gp_cleanup(rnp) || needgp;
 		sq = rcu_nocb_gp_get(rnp);
 		raw_spin_unlock_irq_rcu_node(rnp);
 		rcu_nocb_gp_cleanup(sq);
 		cond_resched_tasks_rcu_qs();
 		WRITE_ONCE(rsp->gp_activity, jiffies);
-		rcu_gp_slow(rsp, gp_cleanup_delay);
+		rcu_gp_slow(gp_cleanup_delay);
 	}
-	rnp = rcu_get_root(rsp);
+	rnp = rcu_get_root();
 	raw_spin_lock_irq_rcu_node(rnp); /* GP before rsp->gp_seq update. */
 
 	/* Declare grace period done. */
@@ -2073,7 +2078,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 		needgp = true;
 	}
 	/* Advance CBs to reduce false positives below. */
-	if (!rcu_accelerate_cbs(rsp, rnp, rdp) && needgp) {
+	if (!rcu_accelerate_cbs(rnp, rdp) && needgp) {
 		WRITE_ONCE(rsp->gp_flags, RCU_GP_FLAG_INIT);
 		rsp->gp_req_activity = jiffies;
 		trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gp_seq),
@@ -2087,14 +2092,14 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 /*
  * Body of kthread that handles grace periods.
  */
-static int __noreturn rcu_gp_kthread(void *arg)
+static int __noreturn rcu_gp_kthread(void *unused)
 {
 	bool first_gp_fqs;
 	int gf;
 	unsigned long j;
 	int ret;
-	struct rcu_state *rsp = arg;
-	struct rcu_node *rnp = rcu_get_root(rsp);
+	struct rcu_state *rsp = &rcu_state;
+	struct rcu_node *rnp = rcu_get_root();
 
 	rcu_bind_gp_kthread();
 	for (;;) {
@@ -2109,7 +2114,7 @@ static int __noreturn rcu_gp_kthread(void *arg)
 						     RCU_GP_FLAG_INIT);
 			rsp->gp_state = RCU_GP_DONE_GPS;
 			/* Locking provides needed memory barrier. */
-			if (rcu_gp_init(rsp))
+			if (rcu_gp_init())
 				break;
 			cond_resched_tasks_rcu_qs();
 			WRITE_ONCE(rsp->gp_activity, jiffies);
@@ -2134,7 +2139,7 @@ static int __noreturn rcu_gp_kthread(void *arg)
 					       TPS("fqswait"));
 			rsp->gp_state = RCU_GP_WAIT_FQS;
 			ret = swait_event_idle_timeout_exclusive(rsp->gp_wq,
-					rcu_gp_fqs_check_wake(rsp, &gf), j);
+					rcu_gp_fqs_check_wake(&gf), j);
 			rsp->gp_state = RCU_GP_DOING_FQS;
 			/* Locking provides needed memory barriers. */
 			/* If grace period done, leave loop. */
@@ -2147,7 +2152,7 @@ static int __noreturn rcu_gp_kthread(void *arg)
 				trace_rcu_grace_period(rsp->name,
 						       READ_ONCE(rsp->gp_seq),
 						       TPS("fqsstart"));
-				rcu_gp_fqs(rsp, first_gp_fqs);
+				rcu_gp_fqs(first_gp_fqs);
 				first_gp_fqs = false;
 				trace_rcu_grace_period(rsp->name,
 						       READ_ONCE(rsp->gp_seq),
@@ -2175,7 +2180,7 @@ static int __noreturn rcu_gp_kthread(void *arg)
 
 		/* Handle grace-period end. */
 		rsp->gp_state = RCU_GP_CLEANUP;
-		rcu_gp_cleanup(rsp);
+		rcu_gp_cleanup();
 		rsp->gp_state = RCU_GP_CLEANED;
 	}
 }
@@ -2189,14 +2194,16 @@ static int __noreturn rcu_gp_kthread(void *arg)
  * just-completed grace period.  Note that the caller must hold rnp->lock,
  * which is released before return.
  */
-static void rcu_report_qs_rsp(struct rcu_state *rsp, unsigned long flags)
-	__releases(rcu_get_root(rsp)->lock)
+static void rcu_report_qs_rsp(unsigned long flags)
+	__releases(rcu_get_root()->lock)
 {
-	raw_lockdep_assert_held_rcu_node(rcu_get_root(rsp));
-	WARN_ON_ONCE(!rcu_gp_in_progress(rsp));
+	struct rcu_state *rsp = &rcu_state;
+
+	raw_lockdep_assert_held_rcu_node(rcu_get_root());
+	WARN_ON_ONCE(!rcu_gp_in_progress());
 	WRITE_ONCE(rsp->gp_flags, READ_ONCE(rsp->gp_flags) | RCU_GP_FLAG_FQS);
-	raw_spin_unlock_irqrestore_rcu_node(rcu_get_root(rsp), flags);
-	rcu_gp_kthread_wake(rsp);
+	raw_spin_unlock_irqrestore_rcu_node(rcu_get_root(), flags);
+	rcu_gp_kthread_wake();
 }
 
 /*
@@ -2213,13 +2220,13 @@ static void rcu_report_qs_rsp(struct rcu_state *rsp, unsigned long flags)
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
 
@@ -2268,7 +2275,7 @@ rcu_report_qs_rnp(unsigned long mask, struct rcu_state *rsp,
 	 * state for this grace period.  Invoke rcu_report_qs_rsp()
 	 * to clean up and start the next grace period if one is needed.
 	 */
-	rcu_report_qs_rsp(rsp, flags); /* releases rnp->lock. */
+	rcu_report_qs_rsp(flags); /* releases rnp->lock. */
 }
 
 /*
@@ -2279,8 +2286,7 @@ rcu_report_qs_rnp(unsigned long mask, struct rcu_state *rsp,
  * disabled.
  */
 static void __maybe_unused
-rcu_report_unblock_qs_rnp(struct rcu_state *rsp,
-			  struct rcu_node *rnp, unsigned long flags)
+rcu_report_unblock_qs_rnp(struct rcu_node *rnp, unsigned long flags)
 	__releases(rnp->lock)
 {
 	unsigned long gps;
@@ -2302,7 +2308,7 @@ rcu_report_unblock_qs_rnp(struct rcu_state *rsp,
 		 * Only one rcu_node structure in the tree, so don't
 		 * try to report up to its nonexistent parent!
 		 */
-		rcu_report_qs_rsp(rsp, flags);
+		rcu_report_qs_rsp(flags);
 		return;
 	}
 
@@ -2311,7 +2317,7 @@ rcu_report_unblock_qs_rnp(struct rcu_state *rsp,
 	mask = rnp->grpmask;
 	raw_spin_unlock_rcu_node(rnp);	/* irqs remain disabled. */
 	raw_spin_lock_rcu_node(rnp_p);	/* irqs already disabled. */
-	rcu_report_qs_rnp(mask, rsp, rnp_p, gps, flags);
+	rcu_report_qs_rnp(mask, rnp_p, gps, flags);
 }
 
 /*
@@ -2319,7 +2325,7 @@ rcu_report_unblock_qs_rnp(struct rcu_state *rsp,
  * structure.  This must be called from the specified CPU.
  */
 static void
-rcu_report_qs_rdp(int cpu, struct rcu_state *rsp, struct rcu_data *rdp)
+rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 {
 	unsigned long flags;
 	unsigned long mask;
@@ -2352,12 +2358,12 @@ rcu_report_qs_rdp(int cpu, struct rcu_state *rsp, struct rcu_data *rdp)
 		 * This GP can't end until cpu checks in, so all of our
 		 * callbacks can be processed during the next GP.
 		 */
-		needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
+		needwake = rcu_accelerate_cbs(rnp, rdp);
 
-		rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
+		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
 		if (needwake)
-			rcu_gp_kthread_wake(rsp);
+			rcu_gp_kthread_wake();
 	}
 }
 
@@ -2368,10 +2374,10 @@ rcu_report_qs_rdp(int cpu, struct rcu_state *rsp, struct rcu_data *rdp)
  * quiescent state for this grace period, and record that fact if so.
  */
 static void
-rcu_check_quiescent_state(struct rcu_state *rsp, struct rcu_data *rdp)
+rcu_check_quiescent_state(struct rcu_data *rdp)
 {
 	/* Check for grace-period ends and beginnings. */
-	note_gp_changes(rsp, rdp);
+	note_gp_changes(rdp);
 
 	/*
 	 * Does this CPU still need to do its part for current grace period?
@@ -2391,24 +2397,26 @@ rcu_check_quiescent_state(struct rcu_state *rsp, struct rcu_data *rdp)
 	 * Tell RCU we are done (but rcu_report_qs_rdp() will be the
 	 * judge of that).
 	 */
-	rcu_report_qs_rdp(rdp->cpu, rsp, rdp);
+	rcu_report_qs_rdp(rdp->cpu, rdp);
 }
 
 /*
- * Trace the fact that this CPU is going offline.
+ * Near the end of the offline process.  Trace the fact that this CPU
+ * is going offline.
  */
-static void rcu_cleanup_dying_cpu(struct rcu_state *rsp)
+int rcutree_dying_cpu(unsigned int cpu)
 {
 	RCU_TRACE(bool blkd;)
 	RCU_TRACE(struct rcu_data *rdp = this_cpu_ptr(&rcu_data);)
 	RCU_TRACE(struct rcu_node *rnp = rdp->mynode;)
 
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
-		return;
+		return 0;
 
 	RCU_TRACE(blkd = !!(rnp->qsmask & rdp->grpmask);)
-	trace_rcu_grace_period(rsp->name, rnp->gp_seq,
+	trace_rcu_grace_period(rcu_state.name, rnp->gp_seq,
 			       blkd ? TPS("cpuofl") : TPS("cpuofl-bgp"));
+	return 0;
 }
 
 /*
@@ -2462,28 +2470,32 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
  * There can only be one CPU hotplug operation at a time, so no need for
  * explicit locking.
  */
-static void rcu_cleanup_dead_cpu(int cpu, struct rcu_state *rsp)
+int rcutree_dead_cpu(unsigned int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
 
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
-		return;
+		return 0;
 
 	/* Adjust any no-longer-needed kthreads. */
 	rcu_boost_kthread_setaffinity(rnp, -1);
+	/* Do any needed no-CB deferred wakeups from this CPU. */
+	do_nocb_deferred_wakeup(per_cpu_ptr(&rcu_data, cpu));
+	return 0;
 }
 
 /*
  * Invoke any RCU callbacks that have made it to the end of their grace
  * period.  Thottle as specified by rdp->blimit.
  */
-static void rcu_do_batch(struct rcu_state *rsp, struct rcu_data *rdp)
+static void rcu_do_batch(struct rcu_data *rdp)
 {
 	unsigned long flags;
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	long bl, count;
+	struct rcu_state *rsp = &rcu_state;
 
 	/* If no callbacks are ready, just return. */
 	if (!rcu_segcblist_ready_cbs(&rdp->cblist)) {
@@ -2587,14 +2599,14 @@ void rcu_check_callbacks(int user)
  *
  * The caller must have suppressed start of new grace periods.
  */
-static void force_qs_rnp(struct rcu_state *rsp, int (*f)(struct rcu_data *rsp))
+static void force_qs_rnp(int (*f)(struct rcu_data *rsp))
 {
 	int cpu;
 	unsigned long flags;
 	unsigned long mask;
 	struct rcu_node *rnp;
 
-	rcu_for_each_leaf_node(rsp, rnp) {
+	rcu_for_each_leaf_node(rnp) {
 		cond_resched_tasks_rcu_qs();
 		mask = 0;
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -2622,7 +2634,7 @@ static void force_qs_rnp(struct rcu_state *rsp, int (*f)(struct rcu_data *rsp))
 		}
 		if (mask != 0) {
 			/* Idle/offline CPUs, report (releases rnp->lock). */
-			rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
+			rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		} else {
 			/* Nothing to do here, so just drop the lock. */
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
@@ -2634,12 +2646,13 @@ static void force_qs_rnp(struct rcu_state *rsp, int (*f)(struct rcu_data *rsp))
  * Force quiescent states on reluctant CPUs, and also detect which
  * CPUs are in dyntick-idle mode.
  */
-static void force_quiescent_state(struct rcu_state *rsp)
+static void force_quiescent_state(void)
 {
 	unsigned long flags;
 	bool ret;
 	struct rcu_node *rnp;
 	struct rcu_node *rnp_old = NULL;
+	struct rcu_state *rsp = &rcu_state;
 
 	/* Funnel through hierarchy to reduce memory contention. */
 	rnp = __this_cpu_read(rcu_data.mynode);
@@ -2652,7 +2665,7 @@ static void force_quiescent_state(struct rcu_state *rsp)
 			return;
 		rnp_old = rnp;
 	}
-	/* rnp_old == rcu_get_root(rsp), rnp == NULL. */
+	/* rnp_old == rcu_get_root(), rnp == NULL. */
 
 	/* Reached the root of the rcu_node tree, acquire lock. */
 	raw_spin_lock_irqsave_rcu_node(rnp_old, flags);
@@ -2663,7 +2676,7 @@ static void force_quiescent_state(struct rcu_state *rsp)
 	}
 	WRITE_ONCE(rsp->gp_flags, READ_ONCE(rsp->gp_flags) | RCU_GP_FLAG_FQS);
 	raw_spin_unlock_irqrestore_rcu_node(rnp_old, flags);
-	rcu_gp_kthread_wake(rsp);
+	rcu_gp_kthread_wake();
 }
 
 /*
@@ -2671,16 +2684,16 @@ static void force_quiescent_state(struct rcu_state *rsp)
  * RCU to come out of its idle mode.
  */
 static void
-rcu_check_gp_start_stall(struct rcu_state *rsp, struct rcu_node *rnp,
-			 struct rcu_data *rdp)
+rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	const unsigned long gpssdelay = rcu_jiffies_till_stall_check() * HZ;
 	unsigned long flags;
 	unsigned long j;
-	struct rcu_node *rnp_root = rcu_get_root(rsp);
+	struct rcu_node *rnp_root = rcu_get_root();
+	struct rcu_state *rsp = &rcu_state;
 	static atomic_t warned = ATOMIC_INIT(0);
 
-	if (!IS_ENABLED(CONFIG_PROVE_RCU) || rcu_gp_in_progress(rsp) ||
+	if (!IS_ENABLED(CONFIG_PROVE_RCU) || rcu_gp_in_progress() ||
 	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed))
 		return;
 	j = jiffies; /* Expensive access, and in common case don't get here. */
@@ -2691,7 +2704,7 @@ rcu_check_gp_start_stall(struct rcu_state *rsp, struct rcu_node *rnp,
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	j = jiffies;
-	if (rcu_gp_in_progress(rsp) ||
+	if (rcu_gp_in_progress() ||
 	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed) ||
 	    time_before(j, READ_ONCE(rsp->gp_req_activity) + gpssdelay) ||
 	    time_before(j, READ_ONCE(rsp->gp_activity) + gpssdelay) ||
@@ -2704,7 +2717,7 @@ rcu_check_gp_start_stall(struct rcu_state *rsp, struct rcu_node *rnp,
 	if (rnp_root != rnp)
 		raw_spin_lock_rcu_node(rnp_root); /* irqs already disabled. */
 	j = jiffies;
-	if (rcu_gp_in_progress(rsp) ||
+	if (rcu_gp_in_progress() ||
 	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed) ||
 	    time_before(j, rsp->gp_req_activity + gpssdelay) ||
 	    time_before(j, rsp->gp_activity + gpssdelay) ||
@@ -2726,17 +2739,19 @@ rcu_check_gp_start_stall(struct rcu_state *rsp, struct rcu_node *rnp,
 }
 
 /*
- * This does the RCU core processing work for the specified rcu_state
- * and rcu_data structures.  This may be called only from the CPU to
- * whom the rdp belongs.
+ * This does the RCU core processing work for the specified rcu_data
+ * structures.  This may be called only from the CPU to whom the rdp
+ * belongs.
  */
-static void
-__rcu_process_callbacks(struct rcu_state *rsp)
+static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused)
 {
 	unsigned long flags;
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
 
+	if (cpu_is_offline(smp_processor_id()))
+		return;
+	trace_rcu_utilization(TPS("Start RCU core"));
 	WARN_ON_ONCE(!rdp->beenonline);
 
 	/* Report any deferred quiescent states if preemption enabled. */
@@ -2746,39 +2761,25 @@ __rcu_process_callbacks(struct rcu_state *rsp)
 		resched_cpu(rdp->cpu); /* Provoke future context switch. */
 
 	/* Update RCU state based on any recent quiescent states. */
-	rcu_check_quiescent_state(rsp, rdp);
+	rcu_check_quiescent_state(rdp);
 
 	/* No grace period and unregistered callbacks? */
-	if (!rcu_gp_in_progress(rsp) &&
+	if (!rcu_gp_in_progress() &&
 	    rcu_segcblist_is_enabled(&rdp->cblist)) {
 		local_irq_save(flags);
 		if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
-			rcu_accelerate_cbs_unlocked(rsp, rnp, rdp);
+			rcu_accelerate_cbs_unlocked(rnp, rdp);
 		local_irq_restore(flags);
 	}
 
-	rcu_check_gp_start_stall(rsp, rnp, rdp);
+	rcu_check_gp_start_stall(rnp, rdp);
 
 	/* If there are callbacks ready, invoke them. */
 	if (rcu_segcblist_ready_cbs(&rdp->cblist))
-		invoke_rcu_callbacks(rsp, rdp);
+		invoke_rcu_callbacks(rdp);
 
 	/* Do any needed deferred wakeups of rcuo kthreads. */
 	do_nocb_deferred_wakeup(rdp);
-}
-
-/*
- * Do RCU core processing for the current CPU.
- */
-static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused)
-{
-	struct rcu_state *rsp;
-
-	if (cpu_is_offline(smp_processor_id()))
-		return;
-	trace_rcu_utilization(TPS("Start RCU core"));
-	for_each_rcu_flavor(rsp)
-		__rcu_process_callbacks(rsp);
 	trace_rcu_utilization(TPS("End RCU core"));
 }
 
@@ -2789,12 +2790,14 @@ static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused
  * are running on the current CPU with softirqs disabled, the
  * rcu_cpu_kthread_task cannot disappear out from under us.
  */
-static void invoke_rcu_callbacks(struct rcu_state *rsp, struct rcu_data *rdp)
+static void invoke_rcu_callbacks(struct rcu_data *rdp)
 {
+	struct rcu_state *rsp = &rcu_state;
+
 	if (unlikely(!READ_ONCE(rcu_scheduler_fully_active)))
 		return;
 	if (likely(!rsp->boost)) {
-		rcu_do_batch(rsp, rdp);
+		rcu_do_batch(rdp);
 		return;
 	}
 	invoke_rcu_callbacks_kthread();
@@ -2809,8 +2812,8 @@ static void invoke_rcu_core(void)
 /*
  * Handle any core-RCU processing required by a call_rcu() invocation.
  */
-static void __call_rcu_core(struct rcu_state *rsp, struct rcu_data *rdp,
-			    struct rcu_head *head, unsigned long flags)
+static void __call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
+			    unsigned long flags)
 {
 	/*
 	 * If called from an extended quiescent state, invoke the RCU
@@ -2834,18 +2837,18 @@ static void __call_rcu_core(struct rcu_state *rsp, struct rcu_data *rdp,
 		     rdp->qlen_last_fqs_check + qhimark)) {
 
 		/* Are we ignoring a completed grace period? */
-		note_gp_changes(rsp, rdp);
+		note_gp_changes(rdp);
 
 		/* Start a new grace period if one not already started. */
-		if (!rcu_gp_in_progress(rsp)) {
-			rcu_accelerate_cbs_unlocked(rsp, rdp->mynode, rdp);
+		if (!rcu_gp_in_progress()) {
+			rcu_accelerate_cbs_unlocked(rdp->mynode, rdp);
 		} else {
 			/* Give the grace period a kick. */
 			rdp->blimit = LONG_MAX;
-			if (rsp->n_force_qs == rdp->n_force_qs_snap &&
+			if (rcu_state.n_force_qs == rdp->n_force_qs_snap &&
 			    rcu_segcblist_first_pend_cb(&rdp->cblist) != head)
-				force_quiescent_state(rsp);
-			rdp->n_force_qs_snap = rsp->n_force_qs;
+				force_quiescent_state();
+			rdp->n_force_qs_snap = rcu_state.n_force_qs;
 			rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
 		}
 	}
@@ -2865,11 +2868,11 @@ static void rcu_leak_callback(struct rcu_head *rhp)
  * is expected to specify a CPU.
  */
 static void
-__call_rcu(struct rcu_head *head, rcu_callback_t func,
-	   struct rcu_state *rsp, int cpu, bool lazy)
+__call_rcu(struct rcu_head *head, rcu_callback_t func, int cpu, bool lazy)
 {
 	unsigned long flags;
 	struct rcu_data *rdp;
+	struct rcu_state __maybe_unused *rsp = &rcu_state;
 
 	/* Misaligned rcu_head! */
 	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
@@ -2927,7 +2930,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func,
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
 	/* Go handle any RCU core processing required. */
-	__call_rcu_core(rsp, rdp, head, flags);
+	__call_rcu_core(rdp, head, flags);
 	local_irq_restore(flags);
 }
 
@@ -2968,7 +2971,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func,
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	__call_rcu(head, func, &rcu_state, -1, 0);
+	__call_rcu(head, func, -1, 0);
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
@@ -2992,10 +2995,9 @@ EXPORT_SYMBOL_GPL(call_rcu_sched);
  * callbacks in the list of pending callbacks. Until then, this
  * function may only be called from __kfree_rcu().
  */
-void kfree_call_rcu(struct rcu_head *head,
-		    rcu_callback_t func)
+void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	__call_rcu(head, func, &rcu_state, -1, 1);
+	__call_rcu(head, func, -1, 1);
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
 
@@ -3075,21 +3077,23 @@ void cond_synchronize_sched(unsigned long oldstate)
 EXPORT_SYMBOL_GPL(cond_synchronize_sched);
 
 /*
- * Check to see if there is any immediate RCU-related work to be done
- * by the current CPU, for the specified type of RCU, returning 1 if so.
- * The checks are in order of increasing expense: checks that can be
- * carried out against CPU-local state are performed first.  However,
- * we must check for CPU stalls first, else we might not get a chance.
+ * Check to see if there is any immediate RCU-related work to be done by
+ * the current CPU, for the specified type of RCU, returning 1 if so and
+ * zero otherwise.  The checks are in order of increasing expense: checks
+ * that can be carried out against CPU-local state are performed first.
+ * However, we must check for CPU stalls first, else we might not get
+ * a chance.
  */
-static int __rcu_pending(struct rcu_state *rsp, struct rcu_data *rdp)
+static int rcu_pending(void)
 {
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
 
 	/* Check for CPU stalls, if enabled. */
-	check_cpu_stall(rsp, rdp);
+	check_cpu_stall(rdp);
 
 	/* Is this CPU a NO_HZ_FULL CPU that should ignore RCU? */
-	if (rcu_nohz_full_cpu(rsp))
+	if (rcu_nohz_full_cpu())
 		return 0;
 
 	/* Is the RCU core waiting for a quiescent state from this CPU? */
@@ -3101,7 +3105,7 @@ static int __rcu_pending(struct rcu_state *rsp, struct rcu_data *rdp)
 		return 1;
 
 	/* Has RCU gone idle with this CPU needing another grace period? */
-	if (!rcu_gp_in_progress(rsp) &&
+	if (!rcu_gp_in_progress() &&
 	    rcu_segcblist_is_enabled(&rdp->cblist) &&
 	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 		return 1;
@@ -3119,21 +3123,6 @@ static int __rcu_pending(struct rcu_state *rsp, struct rcu_data *rdp)
 	return 0;
 }
 
-/*
- * Check to see if there is any immediate RCU-related work to be done
- * by the current CPU, returning 1 if so.  This function is part of the
- * RCU implementation; it is -not- an exported member of the RCU API.
- */
-static int rcu_pending(void)
-{
-	struct rcu_state *rsp;
-
-	for_each_rcu_flavor(rsp)
-		if (__rcu_pending(rsp, this_cpu_ptr(&rcu_data)))
-			return 1;
-	return 0;
-}
-
 /*
  * Return true if the specified CPU has any callback.  If all_lazy is
  * non-NULL, store an indication of whether all callbacks are lazy.
@@ -3165,11 +3154,10 @@ static bool rcu_cpu_has_callbacks(bool *all_lazy)
  * Helper function for _rcu_barrier() tracing.  If tracing is disabled,
  * the compiler is expected to optimize this away.
  */
-static void _rcu_barrier_trace(struct rcu_state *rsp, const char *s,
-			       int cpu, unsigned long done)
+static void _rcu_barrier_trace(const char *s, int cpu, unsigned long done)
 {
-	trace_rcu_barrier(rsp->name, s, cpu,
-			  atomic_read(&rsp->barrier_cpu_count), done);
+	trace_rcu_barrier(rcu_state.name, s, cpu,
+			  atomic_read(&rcu_state.barrier_cpu_count), done);
 }
 
 /*
@@ -3182,11 +3170,10 @@ static void rcu_barrier_callback(struct rcu_head *rhp)
 	struct rcu_state *rsp = rdp->rsp;
 
 	if (atomic_dec_and_test(&rsp->barrier_cpu_count)) {
-		_rcu_barrier_trace(rsp, TPS("LastCB"), -1,
-				   rsp->barrier_sequence);
+		_rcu_barrier_trace(TPS("LastCB"), -1, rsp->barrier_sequence);
 		complete(&rsp->barrier_completion);
 	} else {
-		_rcu_barrier_trace(rsp, TPS("CB"), -1, rsp->barrier_sequence);
+		_rcu_barrier_trace(TPS("CB"), -1, rsp->barrier_sequence);
 	}
 }
 
@@ -3198,15 +3185,14 @@ static void rcu_barrier_func(void *type)
 	struct rcu_state *rsp = type;
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 
-	_rcu_barrier_trace(rsp, TPS("IRQ"), -1, rsp->barrier_sequence);
+	_rcu_barrier_trace(TPS("IRQ"), -1, rsp->barrier_sequence);
 	rdp->barrier_head.func = rcu_barrier_callback;
 	debug_rcu_head_queue(&rdp->barrier_head);
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head, 0)) {
 		atomic_inc(&rsp->barrier_cpu_count);
 	} else {
 		debug_rcu_head_unqueue(&rdp->barrier_head);
-		_rcu_barrier_trace(rsp, TPS("IRQNQ"), -1,
-				   rsp->barrier_sequence);
+		_rcu_barrier_trace(TPS("IRQNQ"), -1, rsp->barrier_sequence);
 	}
 }
 
@@ -3214,21 +3200,21 @@ static void rcu_barrier_func(void *type)
  * Orchestrate the specified type of RCU barrier, waiting for all
  * RCU callbacks of the specified type to complete.
  */
-static void _rcu_barrier(struct rcu_state *rsp)
+static void _rcu_barrier(void)
 {
 	int cpu;
 	struct rcu_data *rdp;
+	struct rcu_state *rsp = &rcu_state;
 	unsigned long s = rcu_seq_snap(&rsp->barrier_sequence);
 
-	_rcu_barrier_trace(rsp, TPS("Begin"), -1, s);
+	_rcu_barrier_trace(TPS("Begin"), -1, s);
 
 	/* Take mutex to serialize concurrent rcu_barrier() requests. */
 	mutex_lock(&rsp->barrier_mutex);
 
 	/* Did someone else do our work for us? */
 	if (rcu_seq_done(&rsp->barrier_sequence, s)) {
-		_rcu_barrier_trace(rsp, TPS("EarlyExit"), -1,
-				   rsp->barrier_sequence);
+		_rcu_barrier_trace(TPS("EarlyExit"), -1, rsp->barrier_sequence);
 		smp_mb(); /* caller's subsequent code after above check. */
 		mutex_unlock(&rsp->barrier_mutex);
 		return;
@@ -3236,7 +3222,7 @@ static void _rcu_barrier(struct rcu_state *rsp)
 
 	/* Mark the start of the barrier operation. */
 	rcu_seq_start(&rsp->barrier_sequence);
-	_rcu_barrier_trace(rsp, TPS("Inc1"), -1, rsp->barrier_sequence);
+	_rcu_barrier_trace(TPS("Inc1"), -1, rsp->barrier_sequence);
 
 	/*
 	 * Initialize the count to one rather than to zero in order to
@@ -3258,23 +3244,23 @@ static void _rcu_barrier(struct rcu_state *rsp)
 			continue;
 		rdp = per_cpu_ptr(&rcu_data, cpu);
 		if (rcu_is_nocb_cpu(cpu)) {
-			if (!rcu_nocb_cpu_needs_barrier(rsp, cpu)) {
-				_rcu_barrier_trace(rsp, TPS("OfflineNoCB"), cpu,
+			if (!rcu_nocb_cpu_needs_barrier(cpu)) {
+				_rcu_barrier_trace(TPS("OfflineNoCB"), cpu,
 						   rsp->barrier_sequence);
 			} else {
-				_rcu_barrier_trace(rsp, TPS("OnlineNoCB"), cpu,
+				_rcu_barrier_trace(TPS("OnlineNoCB"), cpu,
 						   rsp->barrier_sequence);
 				smp_mb__before_atomic();
 				atomic_inc(&rsp->barrier_cpu_count);
 				__call_rcu(&rdp->barrier_head,
-					   rcu_barrier_callback, rsp, cpu, 0);
+					   rcu_barrier_callback, cpu, 0);
 			}
 		} else if (rcu_segcblist_n_cbs(&rdp->cblist)) {
-			_rcu_barrier_trace(rsp, TPS("OnlineQ"), cpu,
+			_rcu_barrier_trace(TPS("OnlineQ"), cpu,
 					   rsp->barrier_sequence);
 			smp_call_function_single(cpu, rcu_barrier_func, rsp, 1);
 		} else {
-			_rcu_barrier_trace(rsp, TPS("OnlineNQ"), cpu,
+			_rcu_barrier_trace(TPS("OnlineNQ"), cpu,
 					   rsp->barrier_sequence);
 		}
 	}
@@ -3291,7 +3277,7 @@ static void _rcu_barrier(struct rcu_state *rsp)
 	wait_for_completion(&rsp->barrier_completion);
 
 	/* Mark the end of the barrier operation. */
-	_rcu_barrier_trace(rsp, TPS("Inc2"), -1, rsp->barrier_sequence);
+	_rcu_barrier_trace(TPS("Inc2"), -1, rsp->barrier_sequence);
 	rcu_seq_end(&rsp->barrier_sequence);
 
 	/* Other rcu_barrier() invocations can now safely proceed. */
@@ -3303,7 +3289,7 @@ static void _rcu_barrier(struct rcu_state *rsp)
  */
 void rcu_barrier_bh(void)
 {
-	_rcu_barrier(&rcu_state);
+	_rcu_barrier();
 }
 EXPORT_SYMBOL_GPL(rcu_barrier_bh);
 
@@ -3317,7 +3303,7 @@ EXPORT_SYMBOL_GPL(rcu_barrier_bh);
  */
 void rcu_barrier(void)
 {
-	_rcu_barrier(&rcu_state);
+	_rcu_barrier();
 }
 EXPORT_SYMBOL_GPL(rcu_barrier);
 
@@ -3364,7 +3350,7 @@ static void rcu_init_new_rnp(struct rcu_node *rnp_leaf)
  * Do boot-time initialization of a CPU's per-CPU RCU data.
  */
 static void __init
-rcu_boot_init_percpu_data(int cpu, struct rcu_state *rsp)
+rcu_boot_init_percpu_data(int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 
@@ -3373,32 +3359,34 @@ rcu_boot_init_percpu_data(int cpu, struct rcu_state *rsp)
 	rdp->dynticks = &per_cpu(rcu_dynticks, cpu);
 	WARN_ON_ONCE(rdp->dynticks->dynticks_nesting != 1);
 	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp->dynticks)));
-	rdp->rcu_ofl_gp_seq = rsp->gp_seq;
+	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
 	rdp->rcu_ofl_gp_flags = RCU_GP_CLEANED;
-	rdp->rcu_onl_gp_seq = rsp->gp_seq;
+	rdp->rcu_onl_gp_seq = rcu_state.gp_seq;
 	rdp->rcu_onl_gp_flags = RCU_GP_CLEANED;
 	rdp->cpu = cpu;
-	rdp->rsp = rsp;
+	rdp->rsp = &rcu_state;
 	rcu_boot_init_nocb_percpu_data(rdp);
 }
 
 /*
- * Initialize a CPU's per-CPU RCU data.  Note that only one online or
+ * Invoked early in the CPU-online process, when pretty much all services
+ * are available.  The incoming CPU is not present.
+ *
+ * Initializes a CPU's per-CPU RCU data.  Note that only one online or
  * offline event can be happening at a given time.  Note also that we can
  * accept some slop in the rsp->gp_seq access due to the fact that this
  * CPU cannot possibly have any RCU callbacks in flight yet.
  */
-static void
-rcu_init_percpu_data(int cpu, struct rcu_state *rsp)
+int rcutree_prepare_cpu(unsigned int cpu)
 {
 	unsigned long flags;
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	struct rcu_node *rnp = rcu_get_root(rsp);
+	struct rcu_node *rnp = rcu_get_root();
 
 	/* Set up local state, ensuring consistent view of global state. */
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	rdp->qlen_last_fqs_check = 0;
-	rdp->n_force_qs_snap = rsp->n_force_qs;
+	rdp->n_force_qs_snap = rcu_state.n_force_qs;
 	rdp->blimit = blimit;
 	if (rcu_segcblist_empty(&rdp->cblist) && /* No early-boot CBs? */
 	    !init_nocb_callback_list(rdp))
@@ -3422,21 +3410,8 @@ rcu_init_percpu_data(int cpu, struct rcu_state *rsp)
 	rdp->core_needs_qs = false;
 	rdp->rcu_iw_pending = false;
 	rdp->rcu_iw_gp_seq = rnp->gp_seq - 1;
-	trace_rcu_grace_period(rsp->name, rdp->gp_seq, TPS("cpuonl"));
+	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-}
-
-/*
- * Invoked early in the CPU-online process, when pretty much all
- * services are available.  The incoming CPU is not present.
- */
-int rcutree_prepare_cpu(unsigned int cpu)
-{
-	struct rcu_state *rsp;
-
-	for_each_rcu_flavor(rsp)
-		rcu_init_percpu_data(cpu, rsp);
-
 	rcu_prepare_kthreads(cpu);
 	rcu_spawn_all_nocb_kthreads(cpu);
 
@@ -3505,32 +3480,6 @@ int rcutree_offline_cpu(unsigned int cpu)
 	return 0;
 }
 
-/*
- * Near the end of the offline process.  We do only tracing here.
- */
-int rcutree_dying_cpu(unsigned int cpu)
-{
-	struct rcu_state *rsp;
-
-	for_each_rcu_flavor(rsp)
-		rcu_cleanup_dying_cpu(rsp);
-	return 0;
-}
-
-/*
- * The outgoing CPU is gone and we are running elsewhere.
- */
-int rcutree_dead_cpu(unsigned int cpu)
-{
-	struct rcu_state *rsp;
-
-	for_each_rcu_flavor(rsp) {
-		rcu_cleanup_dead_cpu(cpu, rsp);
-		do_nocb_deferred_wakeup(per_cpu_ptr(&rcu_data, cpu));
-	}
-	return 0;
-}
-
 static DEFINE_PER_CPU(int, rcu_cpu_started);
 
 /*
@@ -3576,7 +3525,7 @@ void rcu_cpu_starting(unsigned int cpu)
 		rdp->rcu_onl_gp_flags = READ_ONCE(rsp->gp_flags);
 		if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
 			/* Report QS -after- changing ->qsmaskinitnext! */
-			rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
+			rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		} else {
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		}
@@ -3586,63 +3535,55 @@ void rcu_cpu_starting(unsigned int cpu)
 
 #ifdef CONFIG_HOTPLUG_CPU
 /*
- * The CPU is exiting the idle loop into the arch_cpu_idle_dead()
- * function.  We now remove it from the rcu_node tree's ->qsmaskinitnext
- * bit masks.
+ * The outgoing function has no further need of RCU, so remove it from
+ * the rcu_node tree's ->qsmaskinitnext bit masks.
+ *
+ * Note that this function is special in that it is invoked directly
+ * from the outgoing CPU rather than from the cpuhp_step mechanism.
+ * This is because this function must be invoked at a precise location.
  */
-static void rcu_cleanup_dying_idle_cpu(int cpu, struct rcu_state *rsp)
+void rcu_report_dead(unsigned int cpu)
 {
 	unsigned long flags;
 	unsigned long mask;
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
 
+	/* QS for any half-done expedited RCU-sched GP. */
+	preempt_disable();
+	rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
+	preempt_enable();
+	rcu_preempt_deferred_qs(current);
+
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
 	mask = rdp->grpmask;
-	spin_lock(&rsp->ofl_lock);
+	spin_lock(&rcu_state.ofl_lock);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
-	rdp->rcu_ofl_gp_seq = READ_ONCE(rsp->gp_seq);
-	rdp->rcu_ofl_gp_flags = READ_ONCE(rsp->gp_flags);
+	rdp->rcu_ofl_gp_seq = READ_ONCE(rcu_state.gp_seq);
+	rdp->rcu_ofl_gp_flags = READ_ONCE(rcu_state.gp_flags);
 	if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
 		/* Report quiescent state -before- changing ->qsmaskinitnext! */
-		rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
+		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	}
 	rnp->qsmaskinitnext &= ~mask;
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	spin_unlock(&rsp->ofl_lock);
-}
-
-/*
- * The outgoing function has no further need of RCU, so remove it from
- * the list of CPUs that RCU must track.
- *
- * Note that this function is special in that it is invoked directly
- * from the outgoing CPU rather than from the cpuhp_step mechanism.
- * This is because this function must be invoked at a precise location.
- */
-void rcu_report_dead(unsigned int cpu)
-{
-	struct rcu_state *rsp;
-
-	/* QS for any half-done expedited RCU-sched GP. */
-	preempt_disable();
-	rcu_report_exp_rdp(&rcu_state, this_cpu_ptr(&rcu_data));
-	preempt_enable();
-	rcu_preempt_deferred_qs(current);
-	for_each_rcu_flavor(rsp)
-		rcu_cleanup_dying_idle_cpu(cpu, rsp);
+	spin_unlock(&rcu_state.ofl_lock);
 
 	per_cpu(rcu_cpu_started, cpu) = 0;
 }
 
-/* Migrate the dead CPU's callbacks to the current CPU. */
-static void rcu_migrate_callbacks(int cpu, struct rcu_state *rsp)
+/*
+ * The outgoing CPU has just passed through the dying-idle state, and we
+ * are being invoked from the CPU that was IPIed to continue the offline
+ * operation.  Migrate the outgoing CPU's callbacks to the current CPU.
+ */
+void rcutree_migrate_callbacks(int cpu)
 {
 	unsigned long flags;
 	struct rcu_data *my_rdp;
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	struct rcu_node *rnp_root = rcu_get_root(rdp->rsp);
+	struct rcu_node *rnp_root = rcu_get_root();
 	bool needwake;
 
 	if (rcu_is_nocb_cpu(cpu) || rcu_segcblist_empty(&rdp->cblist))
@@ -3656,33 +3597,20 @@ static void rcu_migrate_callbacks(int cpu, struct rcu_state *rsp)
 	}
 	raw_spin_lock_rcu_node(rnp_root); /* irqs already disabled. */
 	/* Leverage recent GPs and set GP for new callbacks. */
-	needwake = rcu_advance_cbs(rsp, rnp_root, rdp) ||
-		   rcu_advance_cbs(rsp, rnp_root, my_rdp);
+	needwake = rcu_advance_cbs(rnp_root, rdp) ||
+		   rcu_advance_cbs(rnp_root, my_rdp);
 	rcu_segcblist_merge(&my_rdp->cblist, &rdp->cblist);
 	WARN_ON_ONCE(rcu_segcblist_empty(&my_rdp->cblist) !=
 		     !rcu_segcblist_n_cbs(&my_rdp->cblist));
 	raw_spin_unlock_irqrestore_rcu_node(rnp_root, flags);
 	if (needwake)
-		rcu_gp_kthread_wake(rsp);
+		rcu_gp_kthread_wake();
 	WARN_ONCE(rcu_segcblist_n_cbs(&rdp->cblist) != 0 ||
 		  !rcu_segcblist_empty(&rdp->cblist),
 		  "rcu_cleanup_dead_cpu: Callbacks on offline CPU %d: qlen=%lu, 1stCB=%p\n",
 		  cpu, rcu_segcblist_n_cbs(&rdp->cblist),
 		  rcu_segcblist_first_cb(&rdp->cblist));
 }
-
-/*
- * The outgoing CPU has just passed through the dying-idle state,
- * and we are being invoked from the CPU that was IPIed to continue the
- * offline operation.  We need to migrate the outgoing CPU's callbacks.
- */
-void rcutree_migrate_callbacks(int cpu)
-{
-	struct rcu_state *rsp;
-
-	for_each_rcu_flavor(rsp)
-		rcu_migrate_callbacks(cpu, rsp);
-}
 #endif
 
 /*
@@ -3738,9 +3666,9 @@ static int __init rcu_spawn_gp_kthread(void)
 
 	rcu_scheduler_fully_active = 1;
 	for_each_rcu_flavor(rsp) {
-		t = kthread_create(rcu_gp_kthread, rsp, "%s", rsp->name);
+		t = kthread_create(rcu_gp_kthread, NULL, "%s", rsp->name);
 		BUG_ON(IS_ERR(t));
-		rnp = rcu_get_root(rsp);
+		rnp = rcu_get_root();
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		rsp->gp_kthread = t;
 		if (kthread_prio) {
@@ -3778,7 +3706,7 @@ void rcu_scheduler_starting(void)
 /*
  * Helper function for rcu_init() that initializes one rcu_state structure.
  */
-static void __init rcu_init_one(struct rcu_state *rsp)
+static void __init rcu_init_one(void)
 {
 	static const char * const buf[] = RCU_NODE_NAME_INIT;
 	static const char * const fqs[] = RCU_FQS_NAME_INIT;
@@ -3790,6 +3718,7 @@ static void __init rcu_init_one(struct rcu_state *rsp)
 	int i;
 	int j;
 	struct rcu_node *rnp;
+	struct rcu_state *rsp = &rcu_state;
 
 	BUILD_BUG_ON(RCU_NUM_LVLS > ARRAY_SIZE(buf));  /* Fix buf[] init! */
 
@@ -3847,12 +3776,12 @@ static void __init rcu_init_one(struct rcu_state *rsp)
 
 	init_swait_queue_head(&rsp->gp_wq);
 	init_swait_queue_head(&rsp->expedited_wq);
-	rnp = rcu_first_leaf_node(rsp);
+	rnp = rcu_first_leaf_node();
 	for_each_possible_cpu(i) {
 		while (i > rnp->grphi)
 			rnp++;
 		per_cpu_ptr(&rcu_data, i)->mynode = rnp;
-		rcu_boot_init_percpu_data(i, rsp);
+		rcu_boot_init_percpu_data(i);
 	}
 	list_add(&rsp->flavors, &rcu_struct_flavors);
 }
@@ -3940,14 +3869,14 @@ static void __init rcu_init_geometry(void)
  * Dump out the structure of the rcu_node combining tree associated
  * with the rcu_state structure referenced by rsp.
  */
-static void __init rcu_dump_rcu_node_tree(struct rcu_state *rsp)
+static void __init rcu_dump_rcu_node_tree(void)
 {
 	int level = 0;
 	struct rcu_node *rnp;
 
 	pr_info("rcu_node tree layout dump\n");
 	pr_info(" ");
-	rcu_for_each_node_breadth_first(rsp, rnp) {
+	rcu_for_each_node_breadth_first(rnp) {
 		if (rnp->level != level) {
 			pr_cont("\n");
 			pr_info(" ");
@@ -3969,9 +3898,9 @@ void __init rcu_init(void)
 
 	rcu_bootup_announce();
 	rcu_init_geometry();
-	rcu_init_one(&rcu_state);
+	rcu_init_one();
 	if (dump_tree)
-		rcu_dump_rcu_node_tree(&rcu_state);
+		rcu_dump_rcu_node_tree();
 	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
 
 	/*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index d60304f1ef56..b21d79bdab23 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -61,7 +61,6 @@ struct rcu_dynticks {
 /* Communicate arguments to a workqueue handler. */
 struct rcu_exp_work {
 	smp_call_func_t rew_func;
-	struct rcu_state *rew_rsp;
 	unsigned long rew_s;
 	struct work_struct rew_work;
 };
@@ -452,23 +451,17 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp);
 #ifdef CONFIG_HOTPLUG_CPU
 static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
 #endif /* #ifdef CONFIG_HOTPLUG_CPU */
-static void rcu_print_detail_task_stall(struct rcu_state *rsp);
+static void rcu_print_detail_task_stall(void);
 static int rcu_print_task_stall(struct rcu_node *rnp);
 static int rcu_print_task_exp_stall(struct rcu_node *rnp);
-static void rcu_preempt_check_blocked_tasks(struct rcu_state *rsp,
-					    struct rcu_node *rnp);
+static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp);
 static void rcu_flavor_check_callbacks(int user);
 void call_rcu(struct rcu_head *head, rcu_callback_t func);
-static void dump_blkd_tasks(struct rcu_state *rsp, struct rcu_node *rnp,
-			    int ncheck);
+static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck);
 static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
 static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
 static void invoke_rcu_callbacks_kthread(void);
 static bool rcu_is_callbacks_kthread(void);
-#ifdef CONFIG_RCU_BOOST
-static int rcu_spawn_one_boost_kthread(struct rcu_state *rsp,
-						 struct rcu_node *rnp);
-#endif /* #ifdef CONFIG_RCU_BOOST */
 static void __init rcu_spawn_boost_kthreads(void);
 static void rcu_prepare_kthreads(int cpu);
 static void rcu_cleanup_after_idle(void);
@@ -478,11 +471,11 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
 static bool rcu_preempt_need_deferred_qs(struct task_struct *t);
 static void rcu_preempt_deferred_qs(struct task_struct *t);
 static void print_cpu_stall_info_begin(void);
-static void print_cpu_stall_info(struct rcu_state *rsp, int cpu);
+static void print_cpu_stall_info(int cpu);
 static void print_cpu_stall_info_end(void);
 static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static void increment_cpu_stall_ticks(void);
-static bool rcu_nocb_cpu_needs_barrier(struct rcu_state *rsp, int cpu);
+static bool rcu_nocb_cpu_needs_barrier(int cpu);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
@@ -497,11 +490,11 @@ static void rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp);
 static void rcu_spawn_all_nocb_kthreads(int cpu);
 static void __init rcu_spawn_nocb_kthreads(void);
 #ifdef CONFIG_RCU_NOCB_CPU
-static void __init rcu_organize_nocb_kthreads(struct rcu_state *rsp);
+static void __init rcu_organize_nocb_kthreads(void);
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
 static bool init_nocb_callback_list(struct rcu_data *rdp);
 static void rcu_bind_gp_kthread(void);
-static bool rcu_nohz_full_cpu(struct rcu_state *rsp);
+static bool rcu_nohz_full_cpu(void);
 static void rcu_dynticks_task_enter(void);
 static void rcu_dynticks_task_exit(void);
 
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 298a6904bbcd..060bdb45cd95 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -25,39 +25,39 @@
 /*
  * Record the start of an expedited grace period.
  */
-static void rcu_exp_gp_seq_start(struct rcu_state *rsp)
+static void rcu_exp_gp_seq_start(void)
 {
-	rcu_seq_start(&rsp->expedited_sequence);
+	rcu_seq_start(&rcu_state.expedited_sequence);
 }
 
 /*
  * Return then value that expedited-grace-period counter will have
  * at the end of the current grace period.
  */
-static __maybe_unused unsigned long rcu_exp_gp_seq_endval(struct rcu_state *rsp)
+static __maybe_unused unsigned long rcu_exp_gp_seq_endval(void)
 {
-	return rcu_seq_endval(&rsp->expedited_sequence);
+	return rcu_seq_endval(&rcu_state.expedited_sequence);
 }
 
 /*
  * Record the end of an expedited grace period.
  */
-static void rcu_exp_gp_seq_end(struct rcu_state *rsp)
+static void rcu_exp_gp_seq_end(void)
 {
-	rcu_seq_end(&rsp->expedited_sequence);
+	rcu_seq_end(&rcu_state.expedited_sequence);
 	smp_mb(); /* Ensure that consecutive grace periods serialize. */
 }
 
 /*
  * Take a snapshot of the expedited-grace-period counter.
  */
-static unsigned long rcu_exp_gp_seq_snap(struct rcu_state *rsp)
+static unsigned long rcu_exp_gp_seq_snap(void)
 {
 	unsigned long s;
 
 	smp_mb(); /* Caller's modifications seen first by other CPUs. */
-	s = rcu_seq_snap(&rsp->expedited_sequence);
-	trace_rcu_exp_grace_period(rsp->name, s, TPS("snap"));
+	s = rcu_seq_snap(&rcu_state.expedited_sequence);
+	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("snap"));
 	return s;
 }
 
@@ -66,9 +66,9 @@ static unsigned long rcu_exp_gp_seq_snap(struct rcu_state *rsp)
  * if a full expedited grace period has elapsed since that snapshot
  * was taken.
  */
-static bool rcu_exp_gp_seq_done(struct rcu_state *rsp, unsigned long s)
+static bool rcu_exp_gp_seq_done(unsigned long s)
 {
-	return rcu_seq_done(&rsp->expedited_sequence, s);
+	return rcu_seq_done(&rcu_state.expedited_sequence, s);
 }
 
 /*
@@ -78,26 +78,26 @@ static bool rcu_exp_gp_seq_done(struct rcu_state *rsp, unsigned long s)
  * ever been online.  This means that this function normally takes its
  * no-work-to-do fastpath.
  */
-static void sync_exp_reset_tree_hotplug(struct rcu_state *rsp)
+static void sync_exp_reset_tree_hotplug(void)
 {
 	bool done;
 	unsigned long flags;
 	unsigned long mask;
 	unsigned long oldmask;
-	int ncpus = smp_load_acquire(&rsp->ncpus); /* Order against locking. */
+	int ncpus = smp_load_acquire(&rcu_state.ncpus); /* Order vs. locking. */
 	struct rcu_node *rnp;
 	struct rcu_node *rnp_up;
 
 	/* If no new CPUs onlined since last time, nothing to do. */
-	if (likely(ncpus == rsp->ncpus_snap))
+	if (likely(ncpus == rcu_state.ncpus_snap))
 		return;
-	rsp->ncpus_snap = ncpus;
+	rcu_state.ncpus_snap = ncpus;
 
 	/*
 	 * Each pass through the following loop propagates newly onlined
 	 * CPUs for the current rcu_node structure up the rcu_node tree.
 	 */
-	rcu_for_each_leaf_node(rsp, rnp) {
+	rcu_for_each_leaf_node(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (rnp->expmaskinit == rnp->expmaskinitnext) {
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
@@ -135,13 +135,13 @@ static void sync_exp_reset_tree_hotplug(struct rcu_state *rsp)
  * Reset the ->expmask values in the rcu_node tree in preparation for
  * a new expedited grace period.
  */
-static void __maybe_unused sync_exp_reset_tree(struct rcu_state *rsp)
+static void __maybe_unused sync_exp_reset_tree(void)
 {
 	unsigned long flags;
 	struct rcu_node *rnp;
 
-	sync_exp_reset_tree_hotplug(rsp);
-	rcu_for_each_node_breadth_first(rsp, rnp) {
+	sync_exp_reset_tree_hotplug();
+	rcu_for_each_node_breadth_first(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		WARN_ON_ONCE(rnp->expmask);
 		rnp->expmask = rnp->expmaskinit;
@@ -194,7 +194,7 @@ static bool sync_rcu_preempt_exp_done_unlocked(struct rcu_node *rnp)
  *
  * Caller must hold the specified rcu_node structure's ->lock.
  */
-static void __rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
+static void __rcu_report_exp_rnp(struct rcu_node *rnp,
 				 bool wake, unsigned long flags)
 	__releases(rnp->lock)
 {
@@ -212,7 +212,7 @@ static void __rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 			if (wake) {
 				smp_mb(); /* EGP done before wake_up(). */
-				swake_up_one(&rsp->expedited_wq);
+				swake_up_one(&rcu_state.expedited_wq);
 			}
 			break;
 		}
@@ -229,20 +229,19 @@ static void __rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
  * Report expedited quiescent state for specified node.  This is a
  * lock-acquisition wrapper function for __rcu_report_exp_rnp().
  */
-static void __maybe_unused rcu_report_exp_rnp(struct rcu_state *rsp,
-					      struct rcu_node *rnp, bool wake)
+static void __maybe_unused rcu_report_exp_rnp(struct rcu_node *rnp, bool wake)
 {
 	unsigned long flags;
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-	__rcu_report_exp_rnp(rsp, rnp, wake, flags);
+	__rcu_report_exp_rnp(rnp, wake, flags);
 }
 
 /*
  * Report expedited quiescent state for multiple CPUs, all covered by the
  * specified leaf rcu_node structure.
  */
-static void rcu_report_exp_cpu_mult(struct rcu_state *rsp, struct rcu_node *rnp,
+static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
 				    unsigned long mask, bool wake)
 {
 	unsigned long flags;
@@ -253,23 +252,23 @@ static void rcu_report_exp_cpu_mult(struct rcu_state *rsp, struct rcu_node *rnp,
 		return;
 	}
 	rnp->expmask &= ~mask;
-	__rcu_report_exp_rnp(rsp, rnp, wake, flags); /* Releases rnp->lock. */
+	__rcu_report_exp_rnp(rnp, wake, flags); /* Releases rnp->lock. */
 }
 
 /*
  * Report expedited quiescent state for specified rcu_data (CPU).
  */
-static void rcu_report_exp_rdp(struct rcu_state *rsp, struct rcu_data *rdp)
+static void rcu_report_exp_rdp(struct rcu_data *rdp)
 {
 	WRITE_ONCE(rdp->deferred_qs, false);
-	rcu_report_exp_cpu_mult(rsp, rdp->mynode, rdp->grpmask, true);
+	rcu_report_exp_cpu_mult(rdp->mynode, rdp->grpmask, true);
 }
 
 /* Common code for work-done checking. */
-static bool sync_exp_work_done(struct rcu_state *rsp, unsigned long s)
+static bool sync_exp_work_done(unsigned long s)
 {
-	if (rcu_exp_gp_seq_done(rsp, s)) {
-		trace_rcu_exp_grace_period(rsp->name, s, TPS("done"));
+	if (rcu_exp_gp_seq_done(s)) {
+		trace_rcu_exp_grace_period(rcu_state.name, s, TPS("done"));
 		/* Ensure test happens before caller kfree(). */
 		smp_mb__before_atomic(); /* ^^^ */
 		return true;
@@ -284,28 +283,28 @@ static bool sync_exp_work_done(struct rcu_state *rsp, unsigned long s)
  * with the mutex held, indicating that the caller must actually do the
  * expedited grace period.
  */
-static bool exp_funnel_lock(struct rcu_state *rsp, unsigned long s)
+static bool exp_funnel_lock(unsigned long s)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, raw_smp_processor_id());
 	struct rcu_node *rnp = rdp->mynode;
-	struct rcu_node *rnp_root = rcu_get_root(rsp);
+	struct rcu_node *rnp_root = rcu_get_root();
 
 	/* Low-contention fastpath. */
 	if (ULONG_CMP_LT(READ_ONCE(rnp->exp_seq_rq), s) &&
 	    (rnp == rnp_root ||
 	     ULONG_CMP_LT(READ_ONCE(rnp_root->exp_seq_rq), s)) &&
-	    mutex_trylock(&rsp->exp_mutex))
+	    mutex_trylock(&rcu_state.exp_mutex))
 		goto fastpath;
 
 	/*
 	 * Each pass through the following loop works its way up
 	 * the rcu_node tree, returning if others have done the work or
-	 * otherwise falls through to acquire rsp->exp_mutex.  The mapping
+	 * otherwise falls through to acquire ->exp_mutex.  The mapping
 	 * from CPU to rcu_node structure can be inexact, as it is just
 	 * promoting locality and is not strictly needed for correctness.
 	 */
 	for (; rnp != NULL; rnp = rnp->parent) {
-		if (sync_exp_work_done(rsp, s))
+		if (sync_exp_work_done(s))
 			return true;
 
 		/* Work not done, either wait here or go up. */
@@ -314,26 +313,26 @@ static bool exp_funnel_lock(struct rcu_state *rsp, unsigned long s)
 
 			/* Someone else doing GP, so wait for them. */
 			spin_unlock(&rnp->exp_lock);
-			trace_rcu_exp_funnel_lock(rsp->name, rnp->level,
+			trace_rcu_exp_funnel_lock(rcu_state.name, rnp->level,
 						  rnp->grplo, rnp->grphi,
 						  TPS("wait"));
 			wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
-				   sync_exp_work_done(rsp, s));
+				   sync_exp_work_done(s));
 			return true;
 		}
 		rnp->exp_seq_rq = s; /* Followers can wait on us. */
 		spin_unlock(&rnp->exp_lock);
-		trace_rcu_exp_funnel_lock(rsp->name, rnp->level, rnp->grplo,
-					  rnp->grphi, TPS("nxtlvl"));
+		trace_rcu_exp_funnel_lock(rcu_state.name, rnp->level,
+					  rnp->grplo, rnp->grphi, TPS("nxtlvl"));
 	}
-	mutex_lock(&rsp->exp_mutex);
+	mutex_lock(&rcu_state.exp_mutex);
 fastpath:
-	if (sync_exp_work_done(rsp, s)) {
-		mutex_unlock(&rsp->exp_mutex);
+	if (sync_exp_work_done(s)) {
+		mutex_unlock(&rcu_state.exp_mutex);
 		return true;
 	}
-	rcu_exp_gp_seq_start(rsp);
-	trace_rcu_exp_grace_period(rsp->name, s, TPS("start"));
+	rcu_exp_gp_seq_start();
+	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("start"));
 	return false;
 }
 
@@ -352,7 +351,6 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 	struct rcu_exp_work *rewp =
 		container_of(wp, struct rcu_exp_work, rew_work);
 	struct rcu_node *rnp = container_of(rewp, struct rcu_node, rew);
-	struct rcu_state *rsp = rewp->rew_rsp;
 
 	func = rewp->rew_func;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -400,7 +398,7 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 			mask_ofl_test |= mask;
 			continue;
 		}
-		ret = smp_call_function_single(cpu, func, rsp, 0);
+		ret = smp_call_function_single(cpu, func, NULL, 0);
 		if (!ret) {
 			mask_ofl_ipi &= ~mask;
 			continue;
@@ -411,7 +409,7 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 		    (rnp->expmask & mask)) {
 			/* Online, so delay for a bit and try again. */
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-			trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("selectofl"));
+			trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("selectofl"));
 			schedule_timeout_uninterruptible(1);
 			goto retry_ipi;
 		}
@@ -423,33 +421,31 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 	/* Report quiescent states for those that went offline. */
 	mask_ofl_test |= mask_ofl_ipi;
 	if (mask_ofl_test)
-		rcu_report_exp_cpu_mult(rsp, rnp, mask_ofl_test, false);
+		rcu_report_exp_cpu_mult(rnp, mask_ofl_test, false);
 }
 
 /*
  * Select the nodes that the upcoming expedited grace period needs
  * to wait for.
  */
-static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
-				     smp_call_func_t func)
+static void sync_rcu_exp_select_cpus(smp_call_func_t func)
 {
 	int cpu;
 	struct rcu_node *rnp;
 
-	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("reset"));
-	sync_exp_reset_tree(rsp);
-	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("select"));
+	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("reset"));
+	sync_exp_reset_tree();
+	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("select"));
 
 	/* Schedule work for each leaf rcu_node structure. */
-	rcu_for_each_leaf_node(rsp, rnp) {
+	rcu_for_each_leaf_node(rnp) {
 		rnp->exp_need_flush = false;
 		if (!READ_ONCE(rnp->expmask))
 			continue; /* Avoid early boot non-existent wq. */
 		rnp->rew.rew_func = func;
-		rnp->rew.rew_rsp = rsp;
 		if (!READ_ONCE(rcu_par_gp_wq) ||
 		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
-		    rcu_is_last_leaf_node(rsp, rnp)) {
+		    rcu_is_last_leaf_node(rnp)) {
 			/* No workqueues yet or last leaf, do direct call. */
 			sync_rcu_exp_select_node_cpus(&rnp->rew.rew_work);
 			continue;
@@ -466,12 +462,12 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
 	}
 
 	/* Wait for workqueue jobs (if any) to complete. */
-	rcu_for_each_leaf_node(rsp, rnp)
+	rcu_for_each_leaf_node(rnp)
 		if (rnp->exp_need_flush)
 			flush_work(&rnp->rew.rew_work);
 }
 
-static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
+static void synchronize_sched_expedited_wait(void)
 {
 	int cpu;
 	unsigned long jiffies_stall;
@@ -479,16 +475,16 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
 	unsigned long mask;
 	int ndetected;
 	struct rcu_node *rnp;
-	struct rcu_node *rnp_root = rcu_get_root(rsp);
+	struct rcu_node *rnp_root = rcu_get_root();
 	int ret;
 
-	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("startwait"));
+	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("startwait"));
 	jiffies_stall = rcu_jiffies_till_stall_check();
 	jiffies_start = jiffies;
 
 	for (;;) {
 		ret = swait_event_timeout_exclusive(
-				rsp->expedited_wq,
+				rcu_state.expedited_wq,
 				sync_rcu_preempt_exp_done_unlocked(rnp_root),
 				jiffies_stall);
 		if (ret > 0 || sync_rcu_preempt_exp_done_unlocked(rnp_root))
@@ -498,9 +494,9 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
 			continue;
 		panic_on_rcu_stall();
 		pr_err("INFO: %s detected expedited stalls on CPUs/tasks: {",
-		       rsp->name);
+		       rcu_state.name);
 		ndetected = 0;
-		rcu_for_each_leaf_node(rsp, rnp) {
+		rcu_for_each_leaf_node(rnp) {
 			ndetected += rcu_print_task_exp_stall(rnp);
 			for_each_leaf_node_possible_cpu(rnp, cpu) {
 				struct rcu_data *rdp;
@@ -517,11 +513,11 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
 			}
 		}
 		pr_cont(" } %lu jiffies s: %lu root: %#lx/%c\n",
-			jiffies - jiffies_start, rsp->expedited_sequence,
+			jiffies - jiffies_start, rcu_state.expedited_sequence,
 			rnp_root->expmask, ".T"[!!rnp_root->exp_tasks]);
 		if (ndetected) {
 			pr_err("blocking rcu_node structures:");
-			rcu_for_each_node_breadth_first(rsp, rnp) {
+			rcu_for_each_node_breadth_first(rnp) {
 				if (rnp == rnp_root)
 					continue; /* printed unconditionally */
 				if (sync_rcu_preempt_exp_done_unlocked(rnp))
@@ -533,7 +529,7 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
 			}
 			pr_cont("\n");
 		}
-		rcu_for_each_leaf_node(rsp, rnp) {
+		rcu_for_each_leaf_node(rnp) {
 			for_each_leaf_node_possible_cpu(rnp, cpu) {
 				mask = leaf_node_cpu_bit(rnp, cpu);
 				if (!(rnp->expmask & mask))
@@ -551,21 +547,21 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
  * grace period.  Also update all the ->exp_seq_rq counters as needed
  * in order to avoid counter-wrap problems.
  */
-static void rcu_exp_wait_wake(struct rcu_state *rsp, unsigned long s)
+static void rcu_exp_wait_wake(unsigned long s)
 {
 	struct rcu_node *rnp;
 
-	synchronize_sched_expedited_wait(rsp);
-	rcu_exp_gp_seq_end(rsp);
-	trace_rcu_exp_grace_period(rsp->name, s, TPS("end"));
+	synchronize_sched_expedited_wait();
+	rcu_exp_gp_seq_end();
+	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("end"));
 
 	/*
 	 * Switch over to wakeup mode, allowing the next GP, but -only- the
 	 * next GP, to proceed.
 	 */
-	mutex_lock(&rsp->exp_wake_mutex);
+	mutex_lock(&rcu_state.exp_wake_mutex);
 
-	rcu_for_each_node_breadth_first(rsp, rnp) {
+	rcu_for_each_node_breadth_first(rnp) {
 		if (ULONG_CMP_LT(READ_ONCE(rnp->exp_seq_rq), s)) {
 			spin_lock(&rnp->exp_lock);
 			/* Recheck, avoid hang in case someone just arrived. */
@@ -574,24 +570,23 @@ static void rcu_exp_wait_wake(struct rcu_state *rsp, unsigned long s)
 			spin_unlock(&rnp->exp_lock);
 		}
 		smp_mb(); /* All above changes before wakeup. */
-		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rsp->expedited_sequence) & 0x3]);
+		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rcu_state.expedited_sequence) & 0x3]);
 	}
-	trace_rcu_exp_grace_period(rsp->name, s, TPS("endwake"));
-	mutex_unlock(&rsp->exp_wake_mutex);
+	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("endwake"));
+	mutex_unlock(&rcu_state.exp_wake_mutex);
 }
 
 /*
  * Common code to drive an expedited grace period forward, used by
  * workqueues and mid-boot-time tasks.
  */
-static void rcu_exp_sel_wait_wake(struct rcu_state *rsp,
-				  smp_call_func_t func, unsigned long s)
+static void rcu_exp_sel_wait_wake(smp_call_func_t func, unsigned long s)
 {
 	/* Initialize the rcu_node tree in preparation for the wait. */
-	sync_rcu_exp_select_cpus(rsp, func);
+	sync_rcu_exp_select_cpus(func);
 
 	/* Wait and clean up, including waking everyone. */
-	rcu_exp_wait_wake(rsp, s);
+	rcu_exp_wait_wake(s);
 }
 
 /*
@@ -602,15 +597,14 @@ static void wait_rcu_exp_gp(struct work_struct *wp)
 	struct rcu_exp_work *rewp;
 
 	rewp = container_of(wp, struct rcu_exp_work, rew_work);
-	rcu_exp_sel_wait_wake(rewp->rew_rsp, rewp->rew_func, rewp->rew_s);
+	rcu_exp_sel_wait_wake(rewp->rew_func, rewp->rew_s);
 }
 
 /*
  * Given an rcu_state pointer and a smp_call_function() handler, kick
  * off the specified flavor of expedited grace period.
  */
-static void _synchronize_rcu_expedited(struct rcu_state *rsp,
-				       smp_call_func_t func)
+static void _synchronize_rcu_expedited(smp_call_func_t func)
 {
 	struct rcu_data *rdp;
 	struct rcu_exp_work rew;
@@ -624,18 +618,17 @@ static void _synchronize_rcu_expedited(struct rcu_state *rsp,
 	}
 
 	/* Take a snapshot of the sequence number.  */
-	s = rcu_exp_gp_seq_snap(rsp);
-	if (exp_funnel_lock(rsp, s))
+	s = rcu_exp_gp_seq_snap();
+	if (exp_funnel_lock(s))
 		return;  /* Someone else did our work for us. */
 
 	/* Ensure that load happens before action based on it. */
 	if (unlikely(rcu_scheduler_active == RCU_SCHEDULER_INIT)) {
 		/* Direct call during scheduler init and early_initcalls(). */
-		rcu_exp_sel_wait_wake(rsp, func, s);
+		rcu_exp_sel_wait_wake(func, s);
 	} else {
 		/* Marshall arguments & schedule the expedited grace period. */
 		rew.rew_func = func;
-		rew.rew_rsp = rsp;
 		rew.rew_s = s;
 		INIT_WORK_ONSTACK(&rew.rew_work, wait_rcu_exp_gp);
 		queue_work(rcu_gp_wq, &rew.rew_work);
@@ -643,13 +636,13 @@ static void _synchronize_rcu_expedited(struct rcu_state *rsp,
 
 	/* Wait for expedited grace period to complete. */
 	rdp = per_cpu_ptr(&rcu_data, raw_smp_processor_id());
-	rnp = rcu_get_root(rsp);
+	rnp = rcu_get_root();
 	wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
-		   sync_exp_work_done(rsp, s));
+		   sync_exp_work_done(s));
 	smp_mb(); /* Workqueue actions happen before return. */
 
 	/* Let the next expedited grace period start. */
-	mutex_unlock(&rsp->exp_mutex);
+	mutex_unlock(&rcu_state.exp_mutex);
 }
 
 #ifdef CONFIG_PREEMPT_RCU
@@ -661,10 +654,9 @@ static void _synchronize_rcu_expedited(struct rcu_state *rsp,
  * ->expmask fields in the rcu_node tree.  Otherwise, immediately
  * report the quiescent state.
  */
-static void sync_rcu_exp_handler(void *info)
+static void sync_rcu_exp_handler(void *unused)
 {
 	unsigned long flags;
-	struct rcu_state *rsp = info;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
 	struct task_struct *t = current;
@@ -677,7 +669,7 @@ static void sync_rcu_exp_handler(void *info)
 	if (!t->rcu_read_lock_nesting) {
 		if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
 		    rcu_dynticks_curr_cpu_in_eqs()) {
-			rcu_report_exp_rdp(rsp, rdp);
+			rcu_report_exp_rdp(rdp);
 		} else {
 			rdp->deferred_qs = true;
 			resched_cpu(rdp->cpu);
@@ -756,8 +748,6 @@ static void sync_sched_exp_online_cleanup(int cpu)
  */
 void synchronize_rcu_expedited(void)
 {
-	struct rcu_state *rsp = &rcu_state;
-
 	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
 			 lock_is_held(&rcu_lock_map) ||
 			 lock_is_held(&rcu_sched_lock_map),
@@ -765,7 +755,7 @@ void synchronize_rcu_expedited(void)
 
 	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
 		return;
-	_synchronize_rcu_expedited(rsp, sync_rcu_exp_handler);
+	_synchronize_rcu_expedited(sync_rcu_exp_handler);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
 
@@ -783,7 +773,7 @@ static void sync_sched_exp_handler(void *unused)
 	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp))
 		return;
 	if (rcu_is_cpu_rrupt_from_idle()) {
-		rcu_report_exp_rdp(&rcu_state, this_cpu_ptr(&rcu_data));
+		rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
 		return;
 	}
 	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, true);
@@ -798,13 +788,12 @@ static void sync_sched_exp_online_cleanup(int cpu)
 	struct rcu_data *rdp;
 	int ret;
 	struct rcu_node *rnp;
-	struct rcu_state *rsp = &rcu_state;
 
 	rdp = per_cpu_ptr(&rcu_data, cpu);
 	rnp = rdp->mynode;
 	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask))
 		return;
-	ret = smp_call_function_single(cpu, sync_sched_exp_handler, rsp, 0);
+	ret = smp_call_function_single(cpu, sync_sched_exp_handler, NULL, 0);
 	WARN_ON_ONCE(ret);
 }
 
@@ -831,8 +820,6 @@ static int rcu_blocking_is_gp(void)
 /* PREEMPT=n implementation of synchronize_rcu_expedited(). */
 void synchronize_rcu_expedited(void)
 {
-	struct rcu_state *rsp = &rcu_state;
-
 	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
 			 lock_is_held(&rcu_lock_map) ||
 			 lock_is_held(&rcu_sched_lock_map),
@@ -842,7 +829,7 @@ void synchronize_rcu_expedited(void)
 	if (rcu_blocking_is_gp())
 		return;
 
-	_synchronize_rcu_expedited(rsp, sync_sched_exp_handler);
+	_synchronize_rcu_expedited(sync_sched_exp_handler);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 18175ca19f34..b60d3df92ff5 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -123,8 +123,7 @@ static void __init rcu_bootup_announce_oddness(void)
 
 #ifdef CONFIG_PREEMPT_RCU
 
-static void rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
-			       bool wake);
+static void rcu_report_exp_rnp(struct rcu_node *rnp, bool wake);
 static void rcu_read_unlock_special(struct task_struct *t);
 
 /*
@@ -281,7 +280,7 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * still in a quiescent state in any case.)
 	 */
 	if (blkd_state & RCU_EXP_BLKD && rdp->deferred_qs)
-		rcu_report_exp_rdp(rdp->rsp, rdp);
+		rcu_report_exp_rdp(rdp);
 	else
 		WARN_ON_ONCE(rdp->deferred_qs);
 }
@@ -381,7 +380,7 @@ void rcu_note_context_switch(bool preempt)
 	 */
 	rcu_qs();
 	if (rdp->deferred_qs)
-		rcu_report_exp_rdp(&rcu_state, rdp);
+		rcu_report_exp_rdp(rdp);
 	trace_rcu_utilization(TPS("End context switch"));
 	barrier(); /* Avoid RCU read-side critical sections leaking up. */
 }
@@ -509,7 +508,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	 * blocked-tasks list below.
 	 */
 	if (rdp->deferred_qs) {
-		rcu_report_exp_rdp(&rcu_state, rdp);
+		rcu_report_exp_rdp(rdp);
 		if (!t->rcu_read_unlock_special.s) {
 			local_irq_restore(flags);
 			return;
@@ -566,7 +565,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 							 rnp->grplo,
 							 rnp->grphi,
 							 !!rnp->gp_tasks);
-			rcu_report_unblock_qs_rnp(&rcu_state, rnp, flags);
+			rcu_report_unblock_qs_rnp(rnp, flags);
 		} else {
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		}
@@ -580,7 +579,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		 * then we need to report up the rcu_node hierarchy.
 		 */
 		if (!empty_exp && empty_exp_now)
-			rcu_report_exp_rnp(&rcu_state, rnp, true);
+			rcu_report_exp_rnp(rnp, true);
 	} else {
 		local_irq_restore(flags);
 	}
@@ -683,12 +682,12 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
  * Dump detailed information for all tasks blocking the current RCU
  * grace period.
  */
-static void rcu_print_detail_task_stall(struct rcu_state *rsp)
+static void rcu_print_detail_task_stall(void)
 {
-	struct rcu_node *rnp = rcu_get_root(rsp);
+	struct rcu_node *rnp = rcu_get_root();
 
 	rcu_print_detail_task_stall_rnp(rnp);
-	rcu_for_each_leaf_node(rsp, rnp)
+	rcu_for_each_leaf_node(rnp)
 		rcu_print_detail_task_stall_rnp(rnp);
 }
 
@@ -756,14 +755,13 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
  * Also, if there are blocked tasks on the list, they automatically
  * block the newly created grace period, so set up ->gp_tasks accordingly.
  */
-static void
-rcu_preempt_check_blocked_tasks(struct rcu_state *rsp, struct rcu_node *rnp)
+static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
 {
 	struct task_struct *t;
 
 	RCU_LOCKDEP_WARN(preemptible(), "rcu_preempt_check_blocked_tasks() invoked with preemption enabled!!!\n");
 	if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
-		dump_blkd_tasks(rsp, rnp, 10);
+		dump_blkd_tasks(rnp, 10);
 	if (rcu_preempt_has_tasks(rnp) &&
 	    (rnp->qsmaskinit || rnp->wait_blkd_tasks)) {
 		rnp->gp_tasks = rnp->blkd_tasks.next;
@@ -884,7 +882,7 @@ void exit_rcu(void)
  * specified number of elements.
  */
 static void
-dump_blkd_tasks(struct rcu_state *rsp, struct rcu_node *rnp, int ncheck)
+dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 {
 	int cpu;
 	int i;
@@ -948,7 +946,7 @@ static void rcu_qs(void)
 	if (!__this_cpu_read(rcu_data.cpu_no_qs.b.exp))
 		return;
 	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, false);
-	rcu_report_exp_rdp(&rcu_state, this_cpu_ptr(&rcu_data));
+	rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
 }
 
 /*
@@ -1005,7 +1003,7 @@ static void rcu_preempt_deferred_qs(struct task_struct *t) { }
  * Because preemptible RCU does not exist, we never have to check for
  * tasks blocked within RCU read-side critical sections.
  */
-static void rcu_print_detail_task_stall(struct rcu_state *rsp)
+static void rcu_print_detail_task_stall(void)
 {
 }
 
@@ -1033,8 +1031,7 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
  * so there is no need to check for blocked tasks.  So check only for
  * bogus qsmask values.
  */
-static void
-rcu_preempt_check_blocked_tasks(struct rcu_state *rsp, struct rcu_node *rnp)
+static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
 {
 	WARN_ON_ONCE(rnp->qsmask);
 }
@@ -1095,7 +1092,7 @@ void exit_rcu(void)
  * Dump the guaranteed-empty blocked-tasks state.  Trust but verify.
  */
 static void
-dump_blkd_tasks(struct rcu_state *rsp, struct rcu_node *rnp, int ncheck)
+dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 {
 	WARN_ON_ONCE(!list_empty(&rnp->blkd_tasks));
 }
@@ -1292,21 +1289,20 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
  * already exist.  We only create this kthread for preemptible RCU.
  * Returns zero if all is well, a negated errno otherwise.
  */
-static int rcu_spawn_one_boost_kthread(struct rcu_state *rsp,
-				       struct rcu_node *rnp)
+static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 {
-	int rnp_index = rnp - &rsp->node[0];
+	int rnp_index = rnp - rcu_get_root();
 	unsigned long flags;
 	struct sched_param sp;
 	struct task_struct *t;
 
-	if (&rcu_state != rsp)
+	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
 		return 0;
 
 	if (!rcu_scheduler_fully_active || rcu_rnp_online_cpus(rnp) == 0)
 		return 0;
 
-	rsp->boost = 1;
+	rcu_state.boost = 1;
 	if (rnp->boost_kthread_task != NULL)
 		return 0;
 	t = kthread_create(rcu_boost_kthread, (void *)rnp,
@@ -1324,7 +1320,7 @@ static int rcu_spawn_one_boost_kthread(struct rcu_state *rsp,
 
 static void rcu_kthread_do_work(void)
 {
-	rcu_do_batch(&rcu_state, this_cpu_ptr(&rcu_data));
+	rcu_do_batch(this_cpu_ptr(&rcu_data));
 }
 
 static void rcu_cpu_kthread_setup(unsigned int cpu)
@@ -1431,8 +1427,8 @@ static void __init rcu_spawn_boost_kthreads(void)
 	for_each_possible_cpu(cpu)
 		per_cpu(rcu_cpu_has_work, cpu) = 0;
 	BUG_ON(smpboot_register_percpu_thread(&rcu_cpu_thread_spec));
-	rcu_for_each_leaf_node(&rcu_state, rnp)
-		(void)rcu_spawn_one_boost_kthread(&rcu_state, rnp);
+	rcu_for_each_leaf_node(rnp)
+		(void)rcu_spawn_one_boost_kthread(rnp);
 }
 
 static void rcu_prepare_kthreads(int cpu)
@@ -1442,7 +1438,7 @@ static void rcu_prepare_kthreads(int cpu)
 
 	/* Fire up the incoming CPU's kthread and leaf rcu_node kthread. */
 	if (rcu_scheduler_fully_active)
-		(void)rcu_spawn_one_boost_kthread(&rcu_state, rnp);
+		(void)rcu_spawn_one_boost_kthread(rnp);
 }
 
 #else /* #ifdef CONFIG_RCU_BOOST */
@@ -1586,7 +1582,7 @@ static bool __maybe_unused rcu_try_advance_all_cbs(void)
 					  rcu_seq_current(&rnp->gp_seq)) ||
 		     unlikely(READ_ONCE(rdp->gpwrap))) &&
 		    rcu_segcblist_pend_cbs(&rdp->cblist))
-			note_gp_changes(rsp, rdp);
+			note_gp_changes(rdp);
 
 		if (rcu_segcblist_ready_cbs(&rdp->cblist))
 			cbs_ready = true;
@@ -1697,10 +1693,10 @@ static void rcu_prepare_for_idle(void)
 			continue;
 		rnp = rdp->mynode;
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
-		needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
+		needwake = rcu_accelerate_cbs(rnp, rdp);
 		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
 		if (needwake)
-			rcu_gp_kthread_wake(rsp);
+			rcu_gp_kthread_wake();
 	}
 }
 
@@ -1774,7 +1770,7 @@ static void print_cpu_stall_info_begin(void)
  *
  * Also print out idle and (if CONFIG_RCU_FAST_NO_HZ) idle-entry info.
  */
-static void print_cpu_stall_info(struct rcu_state *rsp, int cpu)
+static void print_cpu_stall_info(int cpu)
 {
 	unsigned long delta;
 	char fast_no_hz[72];
@@ -1789,7 +1785,7 @@ static void print_cpu_stall_info(struct rcu_state *rsp, int cpu)
 	 */
 	touch_nmi_watchdog();
 
-	ticks_value = rcu_seq_ctr(rsp->gp_seq - rdp->gp_seq);
+	ticks_value = rcu_seq_ctr(rcu_state.gp_seq - rdp->gp_seq);
 	if (ticks_value) {
 		ticks_title = "GPs behind";
 	} else {
@@ -1810,7 +1806,7 @@ static void print_cpu_stall_info(struct rcu_state *rsp, int cpu)
 	       rcu_dynticks_snap(rdtp) & 0xfff,
 	       rdtp->dynticks_nesting, rdtp->dynticks_nmi_nesting,
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
-	       READ_ONCE(rsp->n_force_qs) - rsp->n_force_qs_gpstart,
+	       READ_ONCE(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
 	       fast_no_hz);
 }
 
@@ -1963,7 +1959,7 @@ static void wake_nocb_leader_defer(struct rcu_data *rdp, int waketype,
  * Does the specified CPU need an RCU callback for the specified flavor
  * of rcu_barrier()?
  */
-static bool rcu_nocb_cpu_needs_barrier(struct rcu_state *rsp, int cpu)
+static bool rcu_nocb_cpu_needs_barrier(int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	unsigned long ret;
@@ -2147,7 +2143,7 @@ static void rcu_nocb_wait_gp(struct rcu_data *rdp)
 		needwake = rcu_start_this_gp(rnp, rdp, c);
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		if (needwake)
-			rcu_gp_kthread_wake(rdp->rsp);
+			rcu_gp_kthread_wake();
 	}
 
 	/*
@@ -2427,7 +2423,7 @@ void __init rcu_init_nohz(void)
 	for_each_rcu_flavor(rsp) {
 		for_each_cpu(cpu, rcu_nocb_mask)
 			init_nocb_callback_list(per_cpu_ptr(&rcu_data, cpu));
-		rcu_organize_nocb_kthreads(rsp);
+		rcu_organize_nocb_kthreads();
 	}
 }
 
@@ -2447,7 +2443,7 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
  * brought online out of order, this can require re-organizing the
  * leader-follower relationships.
  */
-static void rcu_spawn_one_nocb_kthread(struct rcu_state *rsp, int cpu)
+static void rcu_spawn_one_nocb_kthread(int cpu)
 {
 	struct rcu_data *rdp;
 	struct rcu_data *rdp_last;
@@ -2484,7 +2480,7 @@ static void rcu_spawn_one_nocb_kthread(struct rcu_state *rsp, int cpu)
 
 	/* Spawn the kthread for this CPU and RCU flavor. */
 	t = kthread_run(rcu_nocb_kthread, rdp_spawn,
-			"rcuo%c/%d", rsp->abbr, cpu);
+			"rcuo%c/%d", rcu_state.abbr, cpu);
 	BUG_ON(IS_ERR(t));
 	WRITE_ONCE(rdp_spawn->nocb_kthread, t);
 }
@@ -2499,7 +2495,7 @@ static void rcu_spawn_all_nocb_kthreads(int cpu)
 
 	if (rcu_scheduler_fully_active)
 		for_each_rcu_flavor(rsp)
-			rcu_spawn_one_nocb_kthread(rsp, cpu);
+			rcu_spawn_one_nocb_kthread(cpu);
 }
 
 /*
@@ -2523,7 +2519,7 @@ module_param(rcu_nocb_leader_stride, int, 0444);
 /*
  * Initialize leader-follower relationships for all no-CBs CPU.
  */
-static void __init rcu_organize_nocb_kthreads(struct rcu_state *rsp)
+static void __init rcu_organize_nocb_kthreads(void)
 {
 	int cpu;
 	int ls = rcu_nocb_leader_stride;
@@ -2582,7 +2578,7 @@ static bool init_nocb_callback_list(struct rcu_data *rdp)
 
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 
-static bool rcu_nocb_cpu_needs_barrier(struct rcu_state *rsp, int cpu)
+static bool rcu_nocb_cpu_needs_barrier(int cpu)
 {
 	WARN_ON_ONCE(1); /* Should be dead code. */
 	return false;
@@ -2651,12 +2647,12 @@ static bool init_nocb_callback_list(struct rcu_data *rdp)
  * This code relies on the fact that all NO_HZ_FULL CPUs are also
  * CONFIG_RCU_NOCB_CPU CPUs.
  */
-static bool rcu_nohz_full_cpu(struct rcu_state *rsp)
+static bool rcu_nohz_full_cpu(void)
 {
 #ifdef CONFIG_NO_HZ_FULL
 	if (tick_nohz_full_cpu(smp_processor_id()) &&
-	    (!rcu_gp_in_progress(rsp) ||
-	     ULONG_CMP_LT(jiffies, READ_ONCE(rsp->gp_start) + HZ)))
+	    (!rcu_gp_in_progress() ||
+	     ULONG_CMP_LT(jiffies, READ_ONCE(rcu_state.gp_start) + HZ)))
 		return true;
 #endif /* #ifdef CONFIG_NO_HZ_FULL */
 	return false;

