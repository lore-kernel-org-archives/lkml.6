Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752880AbeEOVWI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:22:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752733AbeEOVWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:22:06 -0400
Date: Tue, 15 May 2018 14:23:33 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joe Perches <joe@perches.com>
Cc: Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/18] rcu: Use pr_fmt to prefix "rcu: " to logging output
Reply-To: paulmck@linux.vnet.ibm.com
References: <41d9686471d67f6f98d160e5891bf61061515b6d.1525964386.git.joe@perches.com>
 <20180514202910.GI26088@linux.vnet.ibm.com>
 <32216d8f154b29400d4c11bae91850591114f7f8.camel@perches.com>
 <20180514222456.GO26088@linux.vnet.ibm.com>
 <3c7770a062355650fb61e48a5fbeb9653d98d85a.camel@perches.com>
 <20180514235832.GR26088@linux.vnet.ibm.com>
 <0cb282d85c37d9b626933a03574848d17430f04c.camel@perches.com>
 <20180515003205.GT26088@linux.vnet.ibm.com>
 <20180515192856.GA24473@linux.vnet.ibm.com>
 <4fe632fec126388ef14412ea35cca2525f2449c5.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fe632fec126388ef14412ea35cca2525f2449c5.camel@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051521-0048-0000-0000-0000026D8106
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009030; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032819; UDB=6.00528046; IPR=6.00811951;
 MB=3.00021133; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-15 21:22:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051521-0049-0000-0000-00004522469D
Message-Id: <20180515212333.GQ26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-15_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805150208
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 02:11:48PM -0700, Joe Perches wrote:
> On Tue, 2018-05-15 at 12:28 -0700, Paul E. McKenney wrote:
> > On Mon, May 14, 2018 at 05:32:05PM -0700, Paul E. McKenney wrote:
> > > On Mon, May 14, 2018 at 05:23:59PM -0700, Joe Perches wrote:
> > > > On Mon, 2018-05-14 at 16:58 -0700, Paul E. McKenney wrote:
> > > > > OK, so if I define pr_fmt as follows, I get the old behavior?
> > > > > 
> > > > > 	#define pr_fmt(fmt) fmt
> > > > 
> > > > yes.
> > > 
> > > OK, then I will queue patches with this for the near term for
> > > the various torture files.
> > 
> > And here is the patch.  Thoughts?
> 
> Seems sensible.
> Perhaps still do the pr_alert->pr_cont conversions.

Agreed, and I have those queued as shown below.  Please let me know
if I missed something.

							Thanx, Paul

------------------------------------------------------------------------

commit adf02580b79ba77156bf60ccd338d9f49eaf8eb3
Author: Joe Perches <joe@perches.com>
Date:   Mon May 14 13:27:33 2018 -0700

    rcu: Use pr_fmt to prefix "rcu: " to logging output
    
    This commit also adjusts some whitespace while in the area.
    
    Signed-off-by: Joe Perches <joe@perches.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    [ paulmck: Revert string-breaking %s as requested by Andy Shevchenko. ]

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 479820d231bf..9047e5439e46 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -663,12 +663,11 @@ rcu_perf_init(void)
 			break;
 	}
 	if (i == ARRAY_SIZE(perf_ops)) {
-		pr_alert("rcu-perf: invalid perf type: \"%s\"\n",
-			 perf_type);
+		pr_alert("rcu-perf: invalid perf type: \"%s\"\n", perf_type);
 		pr_alert("rcu-perf types:");
 		for (i = 0; i < ARRAY_SIZE(perf_ops); i++)
-			pr_alert(" %s", perf_ops[i]->name);
-		pr_alert("\n");
+			pr_cont(" %s", perf_ops[i]->name);
+		pr_cont("\n");
 		firsterr = -EINVAL;
 		goto unwind;
 	}
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index ba82285a023a..9d80245b2a1c 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1744,8 +1744,8 @@ rcu_torture_init(void)
 			 torture_type);
 		pr_alert("rcu-torture types:");
 		for (i = 0; i < ARRAY_SIZE(torture_ops); i++)
-			pr_alert(" %s", torture_ops[i]->name);
-		pr_alert("\n");
+			pr_cont(" %s", torture_ops[i]->name);
+		pr_cont("\n");
 		firsterr = -EINVAL;
 		goto unwind;
 	}
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ff894ae6d386..031d2713701f 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -26,6 +26,8 @@
  *
  */
 
+#define pr_fmt(fmt) "rcu: " fmt
+
 #include <linux/export.h>
 #include <linux/mutex.h>
 #include <linux/percpu.h>
@@ -390,7 +392,8 @@ void _cleanup_srcu_struct(struct srcu_struct *sp, bool quiesced)
 		}
 	if (WARN_ON(rcu_seq_state(READ_ONCE(sp->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
 	    WARN_ON(srcu_readers_active(sp))) {
-		pr_info("%s: Active srcu_struct %p state: %d\n", __func__, sp, rcu_seq_state(READ_ONCE(sp->srcu_gp_seq)));
+		pr_info("%s: Active srcu_struct %p state: %d\n",
+			__func__, sp, rcu_seq_state(READ_ONCE(sp->srcu_gp_seq)));
 		return; /* Caller forgot to stop doing call_srcu()? */
 	}
 	free_percpu(sp->sda);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 23b855f5c5cb..3826ce90fd6e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -27,6 +27,9 @@
  * For detailed explanation of Read-Copy Update mechanism see -
  *	Documentation/RCU
  */
+
+#define pr_fmt(fmt) "rcu: " fmt
+
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -1352,8 +1355,7 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gp_seq)
 	 * See Documentation/RCU/stallwarn.txt for info on how to debug
 	 * RCU CPU stall warnings.
 	 */
-	pr_err("INFO: %s detected stalls on CPUs/tasks:",
-	       rsp->name);
+	pr_err("INFO: %s detected stalls on CPUs/tasks:", rsp->name);
 	print_cpu_stall_info_begin();
 	rcu_for_each_leaf_node(rsp, rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -3996,7 +3998,7 @@ static void __init rcu_init_geometry(void)
 	if (rcu_fanout_leaf == RCU_FANOUT_LEAF &&
 	    nr_cpu_ids == NR_CPUS)
 		return;
-	pr_info("RCU: Adjusting geometry for rcu_fanout_leaf=%d, nr_cpu_ids=%u\n",
+	pr_info("Adjusting geometry for rcu_fanout_leaf=%d, nr_cpu_ids=%u\n",
 		rcu_fanout_leaf, nr_cpu_ids);
 
 	/*
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 54a251640f53..dbfe90191e19 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -74,8 +74,8 @@ static void __init rcu_bootup_announce_oddness(void)
 		pr_info("\tRCU event tracing is enabled.\n");
 	if ((IS_ENABLED(CONFIG_64BIT) && RCU_FANOUT != 64) ||
 	    (!IS_ENABLED(CONFIG_64BIT) && RCU_FANOUT != 32))
-		pr_info("\tCONFIG_RCU_FANOUT set to non-default value of %d\n",
-		       RCU_FANOUT);
+		pr_info("\tCONFIG_RCU_FANOUT set to non-default value of %d.\n",
+			RCU_FANOUT);
 	if (rcu_fanout_exact)
 		pr_info("\tHierarchical RCU autobalancing is disabled.\n");
 	if (IS_ENABLED(CONFIG_RCU_FAST_NO_HZ))
@@ -88,11 +88,13 @@ static void __init rcu_bootup_announce_oddness(void)
 		pr_info("\tBuild-time adjustment of leaf fanout to %d.\n",
 			RCU_FANOUT_LEAF);
 	if (rcu_fanout_leaf != RCU_FANOUT_LEAF)
-		pr_info("\tBoot-time adjustment of leaf fanout to %d.\n", rcu_fanout_leaf);
+		pr_info("\tBoot-time adjustment of leaf fanout to %d.\n",
+			rcu_fanout_leaf);
 	if (nr_cpu_ids != NR_CPUS)
 		pr_info("\tRCU restricting CPUs from NR_CPUS=%d to nr_cpu_ids=%u.\n", NR_CPUS, nr_cpu_ids);
 #ifdef CONFIG_RCU_BOOST
-	pr_info("\tRCU priority boosting: priority %d delay %d ms.\n", kthread_prio, CONFIG_RCU_BOOST_DELAY);
+	pr_info("\tRCU priority boosting: priority %d delay %d ms.\n",
+		kthread_prio, CONFIG_RCU_BOOST_DELAY);
 #endif
 	if (blimit != DEFAULT_RCU_BLIMIT)
 		pr_info("\tBoot-time adjustment of callback invocation limit to %ld.\n", blimit);
