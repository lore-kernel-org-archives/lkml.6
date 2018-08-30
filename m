Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E22FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C413E20838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C413E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeH3WZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:25:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35866 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726732AbeH3WZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:25:55 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7UIIpRD133389
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 14:22:26 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m6nrj03w1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 14:22:26 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 Aug 2018 14:22:26 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Aug 2018 14:22:22 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7UIMLUM26411230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Aug 2018 18:22:21 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1A18B205F;
        Thu, 30 Aug 2018 14:21:15 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B31B5B2064;
        Thu, 30 Aug 2018 14:21:15 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 Aug 2018 14:21:15 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B525A16C3AA2; Thu, 30 Aug 2018 11:22:22 -0700 (PDT)
Date:   Thu, 30 Aug 2018 11:22:22 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 4/6] doc: Update documentation for removal
 of RCU-bh update machinery
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180829211637.GA20980@linux.vnet.ibm.com>
 <20180829211722.21694-4-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829211722.21694-4-paulmck@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18083018-0072-0000-0000-0000039A0580
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009640; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01081138; UDB=6.00557734; IPR=6.00861122;
 MB=3.00023020; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-30 18:22:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18083018-0073-0000-0000-00004941313C
Message-Id: <20180830182222.GA11903@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808300183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 02:17:20PM -0700, Paul E. McKenney wrote:
> The RCU-bh update API is now defined in terms of that of RCU-bh and
> RCU-sched, so this commit updates the documentation accordingly.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

And an update consolidating this patch with 6/6 and with the documentation
pieces of 4ca0508f7870 ("rcu: Remove rsp parameter from rcu_node tree
accessor macros").

							Thanx, Paul

------------------------------------------------------------------------

commit 77095901b895a64b6d775879b54c73472ba21e68
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Mon Jul 2 08:25:57 2018 -0700

    doc: Update removal of RCU-bh/sched update machinery
    
    The RCU-bh update API is now defined in terms of that of RCU-bh and
    RCU-sched, so this commit updates the documentation accordingly.
    
    In addition, although RCU-sched persists in !PREEMPT kernels, in
    the PREEMPT case its update API is now defined in terms of that of
    RCU-preempt, so this commit also updates the documentation accordingly.
    
    While in the area, this commit removes the documentation for the
    now-obsolete synchronize_rcu_mult() and clarifies the Tasks RCU
    documentation.
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.html b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
index 50be87e59937..1d2051c0c3fc 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.html
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
@@ -1374,8 +1374,7 @@ that is, if the CPU is currently idle.
 Accessor Functions</a></h3>
 
 <p>The following listing shows the
-<tt>rcu_get_root()</tt>, <tt>rcu_for_each_node_breadth_first</tt>,
-<tt>rcu_for_each_nonleaf_node_breadth_first()</tt>, and
+<tt>rcu_get_root()</tt>, <tt>rcu_for_each_node_breadth_first</tt> and
 <tt>rcu_for_each_leaf_node()</tt> function and macros:
 
 <pre>
@@ -1388,13 +1387,9 @@ Accessor Functions</a></h3>
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
@@ -1407,10 +1402,7 @@ macro takes advantage of the layout of the <tt>rcu_node</tt>
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
 
@@ -1418,15 +1410,14 @@ the last part of the array, thus traversing only the leaf
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
diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
index 7394f034be65..ffd612bfa436 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
@@ -12,10 +12,9 @@ high efficiency and minimal disturbance, expedited grace periods accept
 lower efficiency and significant disturbance to attain shorter latencies.
 
 <p>
-There are three flavors of RCU (RCU-bh, RCU-preempt, and RCU-sched),
-but only two flavors of expedited grace periods because the RCU-bh
-expedited grace period maps onto the RCU-sched expedited grace period.
-Each of the remaining two implementations is covered in its own section.
+There are two flavors of RCU (RCU-preempt and RCU-sched), with an earlier
+third RCU-bh flavor having been implemented in terms of the other two.
+Each of the two implementations is covered in its own section.
 
 <ol>
 <li>	<a href="#Expedited Grace Period Design">
diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
index 51f39f65002d..701b5c53607f 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.html
+++ b/Documentation/RCU/Design/Requirements/Requirements.html
@@ -1306,8 +1306,6 @@ doing so would degrade real-time response.
 
 <p>
 This non-requirement appeared with preemptible RCU.
-If you need a grace period that waits on non-preemptible code regions, use
-<a href="#Sched Flavor">RCU-sched</a>.
 
 <h2><a name="Parallelism Facts of Life">Parallelism Facts of Life</a></h2>
 
@@ -2165,14 +2163,9 @@ however, this is not a panacea because there would be severe restrictions
 on what operations those callbacks could invoke.
 
 <p>
-Perhaps surprisingly, <tt>synchronize_rcu()</tt>,
-<a href="#Bottom-Half Flavor"><tt>synchronize_rcu_bh()</tt></a>
-(<a href="#Bottom-Half Flavor">discussed below</a>),
-<a href="#Sched Flavor"><tt>synchronize_sched()</tt></a>,
+Perhaps surprisingly, <tt>synchronize_rcu()</tt> and
 <tt>synchronize_rcu_expedited()</tt>,
-<tt>synchronize_rcu_bh_expedited()</tt>, and
-<tt>synchronize_sched_expedited()</tt>
-will all operate normally
+will operate normally
 during very early boot, the reason being that there is only one CPU
 and preemption is disabled.
 This means that the call <tt>synchronize_rcu()</tt> (or friends)
@@ -2861,15 +2854,22 @@ The other four flavors are listed below, with requirements for each
 described in a separate section.
 
 <ol>
-<li>	<a href="#Bottom-Half Flavor">Bottom-Half Flavor</a>
-<li>	<a href="#Sched Flavor">Sched Flavor</a>
+<li>	<a href="#Bottom-Half Flavor">Bottom-Half Flavor (Historical)</a>
+<li>	<a href="#Sched Flavor">Sched Flavor (Historical)</a>
 <li>	<a href="#Sleepable RCU">Sleepable RCU</a>
 <li>	<a href="#Tasks RCU">Tasks RCU</a>
-<li>	<a href="#Waiting for Multiple Grace Periods">
-	Waiting for Multiple Grace Periods</a>
 </ol>
 
-<h3><a name="Bottom-Half Flavor">Bottom-Half Flavor</a></h3>
+<h3><a name="Bottom-Half Flavor">Bottom-Half Flavor (Historical)</a></h3>
+
+<p>
+The RCU-bh flavor of RCU has since been expressed in terms of
+the other RCU flavors as part of a consolidation of the three
+flavors into a single flavor.
+The read-side API remains, and continues to disable softirq and to
+be accounted for by lockdep.
+Much of the material in this section is therefore strictly historical
+in nature.
 
 <p>
 The softirq-disable (AKA &ldquo;bottom-half&rdquo;,
@@ -2929,8 +2929,20 @@ includes
 <tt>call_rcu_bh()</tt>,
 <tt>rcu_barrier_bh()</tt>, and
 <tt>rcu_read_lock_bh_held()</tt>.
+However, the update-side APIs are now simple wrappers for other RCU
+flavors, namely RCU-sched in CONFIG_PREEMPT=n kernels and RCU-preempt
+otherwise.
 
-<h3><a name="Sched Flavor">Sched Flavor</a></h3>
+<h3><a name="Sched Flavor">Sched Flavor (Historical)</a></h3>
+
+<p>
+The RCU-sched flavor of RCU has since been expressed in terms of
+the other RCU flavors as part of a consolidation of the three
+flavors into a single flavor.
+The read-side API remains, and continues to disable preemption and to
+be accounted for by lockdep.
+Much of the material in this section is therefore strictly historical
+in nature.
 
 <p>
 Before preemptible RCU, waiting for an RCU grace period had the
@@ -3150,94 +3162,14 @@ The tasks-RCU API is quite compact, consisting only of
 <tt>call_rcu_tasks()</tt>,
 <tt>synchronize_rcu_tasks()</tt>, and
 <tt>rcu_barrier_tasks()</tt>.
-
-<h3><a name="Waiting for Multiple Grace Periods">
-Waiting for Multiple Grace Periods</a></h3>
-
-<p>
-Perhaps you have an RCU protected data structure that is accessed from
-RCU read-side critical sections, from softirq handlers, and from
-hardware interrupt handlers.
-That is three flavors of RCU, the normal flavor, the bottom-half flavor,
-and the sched flavor.
-How to wait for a compound grace period?
-
-<p>
-The best approach is usually to &ldquo;just say no!&rdquo; and
-insert <tt>rcu_read_lock()</tt> and <tt>rcu_read_unlock()</tt>
-around each RCU read-side critical section, regardless of what
-environment it happens to be in.
-But suppose that some of the RCU read-side critical sections are
-on extremely hot code paths, and that use of <tt>CONFIG_PREEMPT=n</tt>
-is not a viable option, so that <tt>rcu_read_lock()</tt> and
-<tt>rcu_read_unlock()</tt> are not free.
-What then?
-
-<p>
-You <i>could</i> wait on all three grace periods in succession, as follows:
-
-<blockquote>
-<pre>
- 1 synchronize_rcu();
- 2 synchronize_rcu_bh();
- 3 synchronize_sched();
-</pre>
-</blockquote>
-
-<p>
-This works, but triples the update-side latency penalty.
-In cases where this is not acceptable, <tt>synchronize_rcu_mult()</tt>
-may be used to wait on all three flavors of grace period concurrently:
-
-<blockquote>
-<pre>
- 1 synchronize_rcu_mult(call_rcu, call_rcu_bh, call_rcu_sched);
-</pre>
-</blockquote>
-
-<p>
-But what if it is necessary to also wait on SRCU?
-This can be done as follows:
-
-<blockquote>
-<pre>
- 1 static void call_my_srcu(struct rcu_head *head,
- 2        void (*func)(struct rcu_head *head))
- 3 {
- 4   call_srcu(&amp;my_srcu, head, func);
- 5 }
- 6
- 7 synchronize_rcu_mult(call_rcu, call_rcu_bh, call_rcu_sched, call_my_srcu);
-</pre>
-</blockquote>
-
-<p>
-If you needed to wait on multiple different flavors of SRCU
-(but why???), you would need to create a wrapper function resembling
-<tt>call_my_srcu()</tt> for each SRCU flavor.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	But what if I need to wait for multiple RCU flavors, but I also need
-	the grace periods to be expedited?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	If you are using expedited grace periods, there should be less penalty
-	for waiting on them in succession.
-	But if that is nevertheless a problem, you can use workqueues
-	or multiple kthreads to wait on the various expedited grace
-	periods concurrently.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>
-Again, it is usually better to adjust the RCU read-side critical sections
-to use a single flavor of RCU, but when this is not feasible, you can use
-<tt>synchronize_rcu_mult()</tt>.
+In <tt>CONFIG_PREEMPT=n</tt> kernels, trampolines cannot be preempted,
+so these APIs map to
+<tt>call_rcu()</tt>,
+<tt>synchronize_rcu()</tt>, and
+<tt>rcu_barrier()</tt>, respectively.
+In <tt>CONFIG_PREEMPT=y</tt> kernels, trampolines can be preempted,
+and these three APIs are therefore implemented by separate functions
+that check for voluntary context switches.
 
 <h2><a name="Possible Future Changes">Possible Future Changes</a></h2>
 
@@ -3248,12 +3180,6 @@ If this becomes a serious problem, it will be necessary to rework the
 grace-period state machine so as to avoid the need for the additional
 latency.
 
-<p>
-Expedited grace periods scan the CPUs, so their latency and overhead
-increases with increasing numbers of CPUs.
-If this becomes a serious problem on large systems, it will be necessary
-to do some redesign to avoid this scalability problem.
-
 <p>
 RCU disables CPU hotplug in a few places, perhaps most notably in the
 <tt>rcu_barrier()</tt> operations.
@@ -3298,11 +3224,6 @@ Please note that arrangements that require RCU to remap CPU numbers will
 require extremely good demonstration of need and full exploration of
 alternatives.
 
-<p>
-There is an embarrassingly large number of flavors of RCU, and this
-number has been increasing over time.
-Perhaps it will be possible to combine some at some future date.
-
 <p>
 RCU's various kthreads are reasonably recent additions.
 It is quite likely that adjustments will be required to more gracefully
diff --git a/Documentation/RCU/stallwarn.txt b/Documentation/RCU/stallwarn.txt
index f99cf11b314b..491043fd976f 100644
--- a/Documentation/RCU/stallwarn.txt
+++ b/Documentation/RCU/stallwarn.txt
@@ -16,12 +16,9 @@ o	A CPU looping in an RCU read-side critical section.
 
 o	A CPU looping with interrupts disabled.
 
-o	A CPU looping with preemption disabled.  This condition can
-	result in RCU-sched stalls and, if ksoftirqd is in use, RCU-bh
-	stalls.
+o	A CPU looping with preemption disabled.
 
-o	A CPU looping with bottom halves disabled.  This condition can
-	result in RCU-sched and RCU-bh stalls.
+o	A CPU looping with bottom halves disabled.
 
 o	For !CONFIG_PREEMPT kernels, a CPU looping anywhere in the kernel
 	without invoking schedule().  If the looping in the kernel is
@@ -87,9 +84,9 @@ o	A hardware failure.  This is quite unlikely, but has occurred
 	This resulted in a series of RCU CPU stall warnings, eventually
 	leading the realization that the CPU had failed.
 
-The RCU, RCU-sched, RCU-bh, and RCU-tasks implementations have CPU stall
-warning.  Note that SRCU does -not- have CPU stall warnings.  Please note
-that RCU only detects CPU stalls when there is a grace period in progress.
+The RCU, RCU-sched, and RCU-tasks implementations have CPU stall warning.
+Note that SRCU does -not- have CPU stall warnings.  Please note that
+RCU only detects CPU stalls when there is a grace period in progress.
 No grace period, no CPU stall warnings.
 
 To diagnose the cause of the stall, inspect the stack traces.
diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
index c2a7facf7ff9..86d82f7f3500 100644
--- a/Documentation/RCU/whatisRCU.txt
+++ b/Documentation/RCU/whatisRCU.txt
@@ -934,7 +934,8 @@ c.	Do you need to treat NMI handlers, hardirq handlers,
 d.	Do you need RCU grace periods to complete even in the face
 	of softirq monopolization of one or more of the CPUs?  For
 	example, is your code subject to network-based denial-of-service
-	attacks?  If so, you need RCU-bh.
+	attacks?  If so, you should disable softirq across your readers,
+	for example, by using rcu_read_lock_bh().
 
 e.	Is your workload too update-intensive for normal use of
 	RCU, but inappropriate for other synchronization mechanisms?
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9871e649ffef..9e69ec54b7d3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3534,14 +3534,14 @@
 
 			In kernels built with CONFIG_RCU_NOCB_CPU=y, set
 			the specified list of CPUs to be no-callback CPUs.
-			Invocation of these CPUs' RCU callbacks will
-			be offloaded to "rcuox/N" kthreads created for
-			that purpose, where "x" is "b" for RCU-bh, "p"
-			for RCU-preempt, and "s" for RCU-sched, and "N"
-			is the CPU number.  This reduces OS jitter on the
-			offloaded CPUs, which can be useful for HPC and
-			real-time workloads.  It can also improve energy
-			efficiency for asymmetric multiprocessors.
+			Invocation of these CPUs' RCU callbacks will be
+			offloaded to "rcuox/N" kthreads created for that
+			purpose, where "x" is "p" for RCU-preempt, and
+			"s" for RCU-sched, and "N" is the CPU number.
+			This reduces OS jitter on the offloaded CPUs,
+			which can be useful for HPC and real-time
+			workloads.  It can also improve energy efficiency
+			for asymmetric multiprocessors.
 
 	rcu_nocb_poll	[KNL]
 			Rather than requiring that offloaded CPUs
diff --git a/Documentation/kernel-per-CPU-kthreads.txt b/Documentation/kernel-per-CPU-kthreads.txt
index 0f00f9c164ac..23b0c8b20cd1 100644
--- a/Documentation/kernel-per-CPU-kthreads.txt
+++ b/Documentation/kernel-per-CPU-kthreads.txt
@@ -321,7 +321,7 @@ To reduce its OS jitter, do at least one of the following:
 	to do.
 
 Name:
-  rcuob/%d, rcuop/%d, and rcuos/%d
+  rcuop/%d and rcuos/%d
 
 Purpose:
   Offload RCU callbacks from the corresponding CPU.

