Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2C5C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1BD20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1BD20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbeLKF3Y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:29:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:37572 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728756AbeLKF3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:29:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 21:29:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,341,1539673200"; 
   d="scan'208";a="302777673"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga005.fm.intel.com with ESMTP; 10 Dec 2018 21:29:22 -0800
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 10 Dec 2018 21:29:22 -0800
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 10 Dec 2018 21:29:22 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.203]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.222]) with mapi id 14.03.0415.000;
 Tue, 11 Dec 2018 13:29:20 +0800
From:   "He, Bo" <bo.he@intel.com>
To:     "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "Zhang, Jun" <jun.zhang@intel.com>,
        "Xiao, Jin" <jin.xiao@intel.com>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>,
        "Bai, Jie A" <jie.a.bai@intel.com>
Subject: RE: rcu_preempt caused oom
Thread-Topic: rcu_preempt caused oom
Thread-Index: AdSHvQIr70OYynHSTxKgLAvVXX+0Zv//yKOAgAAWeAD//li4UIADPhuAgAAJSYD//3lRYIAAoJ4A//tcRfABJU8zAP/+T9Nw//xa4AD/91m7QP/uoBSA/9vB3nD/t3F+AP9tcGAw/tr6woD9snCZgPtjpC6Q9sakFQDtjQLogNsZc+ew
Date:   Tue, 11 Dec 2018 05:29:20 +0000
Message-ID: <CD6925E8781EFD4D8E11882D20FC406D52A18B0C@SHSMSX104.ccr.corp.intel.com>
References: <20181204194936.GD4170@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A16605@SHSMSX104.ccr.corp.intel.com>
 <20181205174435.GU4170@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A16C46@SHSMSX104.ccr.corp.intel.com>
 <20181206173808.GI4170@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A180C5@SHSMSX104.ccr.corp.intel.com>
 <20181207141131.GP4170@linux.ibm.com> <20181209195601.GA7854@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A186D0@SHSMSX104.ccr.corp.intel.com>
 <20181211003838.GD4170@linux.ibm.com> <20181211044631.GA19942@linux.ibm.com>
In-Reply-To: <20181211044631.GA19942@linux.ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjY5Y2UyOTQtYzA2Yy00N2Q0LWJjOTAtYzQ0NDliZTZkN2RkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicGE0dGdhZzIxS3JmWCtcL1l3enRcL0FkWFVvMzh5MVVVcUxUOFpQMEJ6RXJOangweml3UHRnelwvbmFpZkNobXFIeSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sure, we will update the new patch to run the test.

-----Original Message-----
From: Paul E. McKenney <paulmck@linux.ibm.com> 
Sent: Tuesday, December 11, 2018 12:47 PM
To: He, Bo <bo.he@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>; linux-kernel@vger.kernel.org; josh@joshtriplett.org; mathieu.desnoyers@efficios.com; jiangshanlai@gmail.com; Zhang, Jun <jun.zhang@intel.com>; Xiao, Jin <jin.xiao@intel.com>; Zhang, Yanmin <yanmin.zhang@intel.com>; Bai, Jie A <jie.a.bai@intel.com>
Subject: Re: rcu_preempt caused oom

On Mon, Dec 10, 2018 at 04:38:38PM -0800, Paul E. McKenney wrote:
> On Mon, Dec 10, 2018 at 06:56:18AM +0000, He, Bo wrote:
> > Hi, 
> >    We have start the test with the CONFIG_PROVE_RCU=y, and also add one 2s to detect the preempt rcu hang, hope we can get more useful logs tomorrow.
> >    I also enclosed the config and the debug patches for you review.
> 
> I instead suggest the (lightly tested) debug patch shown below, which 
> tracks wakeups of RCU's grace-period kthreads and dumps them out if a 
> given requested grace period fails to start.  Again, it is necessary 
> to build with CONFIG_PROVE_RCU=y, that is, with CONFIG_PROVE_LOCKING=y.

Right.  This time without commenting out the wakeup as a test of the diagnostic.  :-/

Please use the patch below instead of the one that I sent in my previous email.

							Thanx, Paul

------------------------------------------------------------------------

commit adfc7dff659495a3433d5084256be59eee0ac6df
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Mon Dec 10 16:33:59 2018 -0800

    rcu: Improve diagnostics for failed RCU grace-period start
    
    Backported from v4.21/v5.0
    
    If a grace period fails to start (for example, because you commented
    out the last two lines of rcu_accelerate_cbs_unlocked()), rcu_core()
    will invoke rcu_check_gp_start_stall(), which will notice and complain.
    However, this complaint is lacking crucial debugging information such
    as when the last wakeup executed and what the value of ->gp_seq was at
    that time.  This commit therefore removes the current pr_alert() from
    rcu_check_gp_start_stall(), instead invoking show_rcu_gp_kthreads(),
    which has been updated to print the needed information, which is collected
    by rcu_gp_kthread_wake().
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index 0b760c1369f7..4bcd8753e293 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -626,25 +626,57 @@ void rcu_sched_force_quiescent_state(void)
 }
 EXPORT_SYMBOL_GPL(rcu_sched_force_quiescent_state);
 
+/*
+ * Convert a ->gp_state value to a character string.
+ */
+static const char *gp_state_getname(short gs) {
+	if (gs < 0 || gs >= ARRAY_SIZE(gp_state_names))
+		return "???";
+	return gp_state_names[gs];
+}
+
+/*
+ * Return the root node of the specified rcu_state structure.
+ */
+static struct rcu_node *rcu_get_root(struct rcu_state *rsp) {
+	return &rsp->node[0];
+}
+
 /*
  * Show the state of the grace-period kthreads.
  */
 void show_rcu_gp_kthreads(void)
 {
 	int cpu;
+	unsigned long j;
+	unsigned long ja;
+	unsigned long jr;
+	unsigned long jw;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 	struct rcu_state *rsp;
 
+	j = jiffies;
 	for_each_rcu_flavor(rsp) {
-		pr_info("%s: wait state: %d ->state: %#lx\n",
-			rsp->name, rsp->gp_state, rsp->gp_kthread->state);
+		ja = j - READ_ONCE(rsp->gp_activity);
+		jr = j - READ_ONCE(rsp->gp_req_activity);
+		jw = j - READ_ONCE(rsp->gp_wake_time);
+		pr_info("%s: wait state: %s(%d) ->state: %#lx delta ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
+			rsp->name, gp_state_getname(rsp->gp_state),
+			rsp->gp_state,
+			rsp->gp_kthread ? rsp->gp_kthread->state : 0x1ffffL,
+			ja, jr, jw, (long)READ_ONCE(rsp->gp_wake_seq),
+			(long)READ_ONCE(rsp->gp_seq),
+			(long)READ_ONCE(rcu_get_root(rsp)->gp_seq_needed),
+			READ_ONCE(rsp->gp_flags));
 		rcu_for_each_node_breadth_first(rsp, rnp) {
 			if (ULONG_CMP_GE(rsp->gp_seq, rnp->gp_seq_needed))
 				continue;
-			pr_info("\trcu_node %d:%d ->gp_seq %lu ->gp_seq_needed %lu\n",
-				rnp->grplo, rnp->grphi, rnp->gp_seq,
-				rnp->gp_seq_needed);
+			pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld\n",
+				rnp->grplo, rnp->grphi, (long)rnp->gp_seq,
+				(long)rnp->gp_seq_needed);
 			if (!rcu_is_leaf_node(rnp))
 				continue;
 			for_each_leaf_node_possible_cpu(rnp, cpu) { @@ -653,8 +685,8 @@ void show_rcu_gp_kthreads(void)
 				    ULONG_CMP_GE(rsp->gp_seq,
 						 rdp->gp_seq_needed))
 					continue;
-				pr_info("\tcpu %d ->gp_seq_needed %lu\n",
-					cpu, rdp->gp_seq_needed);
+				pr_info("\tcpu %d ->gp_seq_needed %ld\n",
+					cpu, (long)rdp->gp_seq_needed);
 			}
 		}
 		/* sched_show_task(rsp->gp_kthread); */ @@ -690,14 +722,6 @@ void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,  }  EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
 
-/*
- * Return the root node of the specified rcu_state structure.
- */
-static struct rcu_node *rcu_get_root(struct rcu_state *rsp) -{
-	return &rsp->node[0];
-}
-
 /*
  * Enter an RCU extended quiescent state, which can be either the
  * idle loop or adaptive-tickless usermode execution.
@@ -1285,16 +1309,6 @@ static void record_gp_stall_check_time(struct rcu_state *rsp)
 	rsp->n_force_qs_gpstart = READ_ONCE(rsp->n_force_qs);  }
 
-/*
- * Convert a ->gp_state value to a character string.
- */
-static const char *gp_state_getname(short gs) -{
-	if (gs < 0 || gs >= ARRAY_SIZE(gp_state_names))
-		return "???";
-	return gp_state_names[gs];
-}
-
 /*
  * Complain about starvation of grace-period kthread.
  */
@@ -1693,7 +1707,8 @@ static bool rcu_future_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
  * Don't do a self-awaken, and don't bother awakening when there is
  * nothing for the grace-period kthread to do (as in several CPUs
  * raced to awaken, and we lost), and finally don't try to awaken
- * a kthread that has not yet been created.
+ * a kthread that has not yet been created.  If all those checks are
+ * passed, track some debug information and awaken.
  */
 static void rcu_gp_kthread_wake(struct rcu_state *rsp)  { @@ -1701,6 +1716,8 @@ static void rcu_gp_kthread_wake(struct rcu_state *rsp)
 	    !READ_ONCE(rsp->gp_flags) ||
 	    !rsp->gp_kthread)
 		return;
+	WRITE_ONCE(rsp->gp_wake_time, jiffies);
+	WRITE_ONCE(rsp->gp_wake_seq, READ_ONCE(rsp->gp_seq));
 	swake_up_one(&rsp->gp_wq);
 }
 
@@ -2802,16 +2819,11 @@ rcu_check_gp_start_stall(struct rcu_state *rsp, struct rcu_node *rnp,
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
-	pr_alert("%s: g%ld->%ld gar:%lu ga:%lu f%#x gs:%d %s->state:%#lx\n",
-		 __func__, (long)READ_ONCE(rsp->gp_seq),
-		 (long)READ_ONCE(rnp_root->gp_seq_needed),
-		 j - rsp->gp_req_activity, j - rsp->gp_activity,
-		 rsp->gp_flags, rsp->gp_state, rsp->name,
-		 rsp->gp_kthread ? rsp->gp_kthread->state : 0x1ffffL);
 	WARN_ON(1);
 	if (rnp_root != rnp)
 		raw_spin_unlock_rcu_node(rnp_root);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	show_rcu_gp_kthreads();
 }
 
 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h index 4e74df768c57..0e051d9b5f1a 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -327,6 +327,8 @@ struct rcu_state {
 	struct swait_queue_head gp_wq;		/* Where GP task waits. */
 	short gp_flags;				/* Commands for GP task. */
 	short gp_state;				/* GP kthread sleep state. */
+	unsigned long gp_wake_time;		/* Last GP kthread wake. */
+	unsigned long gp_wake_seq;		/* ->gp_seq at ^^^. */
 
 	/* End of fields guarded by root rcu_node's lock. */
 

