Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48768C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14A120871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14A120871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeKLFqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:46:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726471AbeKLFqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:46:20 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJs5Fi140301
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:56:52 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npdcu1xnj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:56:51 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:56:50 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:56:46 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJuk7R25297108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:56:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E453EB2065;
        Sun, 11 Nov 2018 19:56:45 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABCA7B2064;
        Sun, 11 Nov 2018 19:56:45 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:56:45 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DB0CC16C5D34; Sun, 11 Nov 2018 11:56:46 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 01/20] doc: Set down forward-progress requirements
Date:   Sun, 11 Nov 2018 11:56:26 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111195619.GA6958@linux.ibm.com>
References: <20181111195619.GA6958@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111119-0052-0000-0000-0000035422DA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116023; UDB=6.00578735; IPR=6.00896124;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:56:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-0053-0000-0000-00005EBB2577
Message-Id: <20181111195645.9205-1-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

This commit adds a section to the requirements documentation setting down
requirements for grace-period and callback-invocation forward progress.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 .../RCU/Design/Requirements/Requirements.html | 110 +++++++++++++++++-
 1 file changed, 108 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
index 43c4e2f05f40..7efc1c1da7af 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.html
+++ b/Documentation/RCU/Design/Requirements/Requirements.html
@@ -1381,6 +1381,7 @@ Classes of quality-of-implementation requirements are as follows:
 <ol>
 <li>	<a href="#Specialization">Specialization</a>
 <li>	<a href="#Performance and Scalability">Performance and Scalability</a>
+<li>	<a href="#Forward Progress">Forward Progress</a>
 <li>	<a href="#Composability">Composability</a>
 <li>	<a href="#Corner Cases">Corner Cases</a>
 </ol>
@@ -1822,6 +1823,106 @@ so it is too early to tell whether they will stand the test of time.
 RCU thus provides a range of tools to allow updaters to strike the
 required tradeoff between latency, flexibility and CPU overhead.
 
+<h3><a name="Forward Progress">Forward Progress</a></h3>
+
+<p>
+In theory, delaying grace-period completion and callback invocation
+is harmless.
+In practice, not only are memory sizes finite but also callbacks sometimes
+do wakeups, and sufficiently deferred wakeups can be difficult
+to distinguish from system hangs.
+Therefore, RCU must provide a number of mechanisms to promote forward
+progress.
+
+<p>
+These mechanisms are not foolproof, nor can they be.
+For one simple example, an infinite loop in an RCU read-side critical
+section must by definition prevent later grace periods from ever completing.
+For a more involved example, consider a 64-CPU system built with
+<tt>CONFIG_RCU_NOCB_CPU=y</tt> and booted with <tt>rcu_nocbs=1-63</tt>,
+where CPUs&nbsp;1 through&nbsp;63 spin in tight loops that invoke
+<tt>call_rcu()</tt>.
+Even if these tight loops also contain calls to <tt>cond_resched()</tt>
+(thus allowing grace periods to complete), CPU&nbsp;0 simply will
+not be able to invoke callbacks as fast as the other 63 CPUs can
+register them, at least not until the system runs out of memory.
+In both of these examples, the Spiderman principle applies:  With great
+power comes great responsibility.
+However, short of this level of abuse, RCU is required to
+ensure timely completion of grace periods and timely invocation of
+callbacks.
+
+<p>
+RCU takes the following steps to encourage timely completion of
+grace periods:
+
+<ol>
+<li>	If a grace period fails to complete within 100&nbsp;milliseconds,
+	RCU causes future invocations of <tt>cond_resched()</tt> on
+	the holdout CPUs to provide an RCU quiescent state.
+	RCU also causes those CPUs' <tt>need_resched()</tt> invocations
+	to return <tt>true</tt>, but only after the corresponding CPU's
+	next scheduling-clock.
+<li>	CPUs mentioned in the <tt>nohz_full</tt> kernel boot parameter
+	can run indefinitely in the kernel without scheduling-clock
+	interrupts, which defeats the above <tt>need_resched()</tt>
+	strategem.
+	RCU will therefore invoke <tt>resched_cpu()</tt> on any
+	<tt>nohz_full</tt> CPUs still holding out after
+	109&nbsp;milliseconds.
+<li>	In kernels built with <tt>CONFIG_RCU_BOOST=y</tt>, if a given
+	task that has been preempted within an RCU read-side critical
+	section is holding out for more than 500&nbsp;milliseconds,
+	RCU will resort to priority boosting.
+<li>	If a CPU is still holding out 10&nbsp;seconds into the grace
+	period, RCU will invoke <tt>resched_cpu()</tt> on it regardless
+	of its <tt>nohz_full</tt> state.
+</ol>
+
+<p>
+The above values are defaults for systems running with <tt>HZ=1000</tt>.
+They will vary as the value of <tt>HZ</tt> varies, and can also be
+changed using the relevant Kconfig options and kernel boot parameters.
+RCU currently does not do much sanity checking of these
+parameters, so please use caution when changing them.
+Note that these forward-progress measures are provided only for RCU,
+not for
+<a href="#Sleepable RCU">SRCU</a> or
+<a href="#Tasks RCU">Tasks RCU</a>.
+
+<p>
+RCU takes the following steps in <tt>call_rcu()</tt> to encourage timely
+invocation of callbacks when any given non-<tt>rcu_nocbs</tt> CPU has
+10,000 callbacks, or has 10,000 more callbacks than it had the last time
+encouragement was provided:
+
+<ol>
+<li>	Starts a grace period, if one is not already in progress.
+<li>	Forces immediate checking for quiescent states, rather than
+	waiting for three milliseconds to have elapsed since the
+	beginning of the grace period.
+<li>	Immediately tags the CPU's callbacks with their grace period
+	completion numbers, rather than waiting for the <tt>RCU_SOFTIRQ</tt>
+	handler to get around to it.
+<li>	Lifts callback-execution batch limits, which speeds up callback
+	invocation at the expense of degrading realtime response.
+</ol>
+
+<p>
+Again, these are default values when running at <tt>HZ=1000</tt>,
+and can be overridden.
+Again, these forward-progress measures are provided only for RCU,
+not for
+<a href="#Sleepable RCU">SRCU</a> or
+<a href="#Tasks RCU">Tasks RCU</a>.
+Even for RCU, callback-invocation forward progress for <tt>rcu_nocbs</tt>
+CPUs is much less well-developed, in part because workloads benefiting
+from <tt>rcu_nocbs</tt> CPUs tend to invoke <tt>call_rcu()</tt>
+relatively infrequently.
+If workloads emerge that need both <tt>rcu_nocbs</tt> CPUs and high
+<tt>call_rcu()</tt> invocation rates, then additional forward-progress
+work will be required.
+
 <h3><a name="Composability">Composability</a></h3>
 
 <p>
@@ -2272,7 +2373,7 @@ that meets this requirement.
 Furthermore, NMI handlers can be interrupted by what appear to RCU
 to be normal interrupts.
 One way that this can happen is for code that directly invokes
-<tt>rcu_irq_enter()</tt> and </tt>rcu_irq_exit()</tt> to be called
+<tt>rcu_irq_enter()</tt> and <tt>rcu_irq_exit()</tt> to be called
 from an NMI handler.
 This astonishing fact of life prompted the current code structure,
 which has <tt>rcu_irq_enter()</tt> invoking <tt>rcu_nmi_enter()</tt>
@@ -2294,7 +2395,7 @@ via <tt>del_timer_sync()</tt> or similar.
 <p>
 Unfortunately, there is no way to cancel an RCU callback;
 once you invoke <tt>call_rcu()</tt>, the callback function is
-going to eventually be invoked, unless the system goes down first.
+eventually going to be invoked, unless the system goes down first.
 Because it is normally considered socially irresponsible to crash the system
 in response to a module unload request, we need some other way
 to deal with in-flight RCU callbacks.
@@ -3233,6 +3334,11 @@ For example, RCU callback overhead might be charged back to the
 originating <tt>call_rcu()</tt> instance, though probably not
 in production kernels.
 
+<p>
+Additional work may be required to provide reasonable forward-progress
+guarantees under heavy load for grace periods and for callback
+invocation.
+
 <h2><a name="Summary">Summary</a></h2>
 
 <p>
-- 
2.17.1

