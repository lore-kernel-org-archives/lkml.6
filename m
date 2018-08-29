Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27393C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CFE20647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CFE20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbeH3BQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:16:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728754AbeH3BQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:16:15 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TL9Ewq047067
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:17:31 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m61rcuj37-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:17:31 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 17:17:30 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 17:17:24 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TLHN1Y59244720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 21:17:23 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD049B2065;
        Wed, 29 Aug 2018 17:16:19 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB5E7B205F;
        Wed, 29 Aug 2018 17:16:19 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 17:16:19 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B264C16C91CA; Wed, 29 Aug 2018 14:17:23 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 6/6] doc: Update documentation for removal of RCU-sched update machinery
Date:   Wed, 29 Aug 2018 14:17:22 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829211637.GA20980@linux.vnet.ibm.com>
References: <20180829211637.GA20980@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082921-0040-0000-0000-000004675197
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080717; UDB=6.00557481; IPR=6.00860703;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 21:17:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082921-0041-0000-0000-0000086E6B64
Message-Id: <20180829211722.21694-6-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although RCU-sched persists in !PREEMPT kernels, in the PREEMPT case its
update API is now defined in terms of that of RCU-preempt, so this commit
updates the documentation accordingly.  While in the area, this commit
removes the documentation for the now-obsolete synchronize_rcu_mult()
and clarifies the Tasks RCU documentation.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 .../RCU/Design/Requirements/Requirements.html | 133 +++---------------
 1 file changed, 21 insertions(+), 112 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
index 68bedbe8da76..701b5c53607f 100644
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
@@ -2862,11 +2855,9 @@ described in a separate section.
 
 <ol>
 <li>	<a href="#Bottom-Half Flavor">Bottom-Half Flavor (Historical)</a>
-<li>	<a href="#Sched Flavor">Sched Flavor</a>
+<li>	<a href="#Sched Flavor">Sched Flavor (Historical)</a>
 <li>	<a href="#Sleepable RCU">Sleepable RCU</a>
 <li>	<a href="#Tasks RCU">Tasks RCU</a>
-<li>	<a href="#Waiting for Multiple Grace Periods">
-	Waiting for Multiple Grace Periods</a>
 </ol>
 
 <h3><a name="Bottom-Half Flavor">Bottom-Half Flavor (Historical)</a></h3>
@@ -2942,7 +2933,16 @@ However, the update-side APIs are now simple wrappers for other RCU
 flavors, namely RCU-sched in CONFIG_PREEMPT=n kernels and RCU-preempt
 otherwise.
 
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
@@ -3162,94 +3162,14 @@ The tasks-RCU API is quite compact, consisting only of
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
 
@@ -3260,12 +3180,6 @@ If this becomes a serious problem, it will be necessary to rework the
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
@@ -3310,11 +3224,6 @@ Please note that arrangements that require RCU to remap CPU numbers will
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
-- 
2.17.1

