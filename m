Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E280C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157E620652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157E620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbeH3BQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:16:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37830 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728449AbeH3BQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:16:14 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TL8oTf038279
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:17:29 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m615dd2kr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:17:29 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 17:17:28 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 17:17:24 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TLHNZ621495904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 21:17:23 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7747BB205F;
        Wed, 29 Aug 2018 17:16:19 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CC8BB206C;
        Wed, 29 Aug 2018 17:16:19 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 17:16:19 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A9AA816C91C7; Wed, 29 Aug 2018 14:17:23 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 4/6] doc: Update documentation for removal of RCU-bh update machinery
Date:   Wed, 29 Aug 2018 14:17:20 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829211637.GA20980@linux.vnet.ibm.com>
References: <20180829211637.GA20980@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082921-0068-0000-0000-00000331B283
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080717; UDB=6.00557481; IPR=6.00860703;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 21:17:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082921-0069-0000-0000-0000458EF0E7
Message-Id: <20180829211722.21694-4-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RCU-bh update API is now defined in terms of that of RCU-bh and
RCU-sched, so this commit updates the documentation accordingly.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 .../Expedited-Grace-Periods.html                 |  7 +++----
 .../RCU/Design/Requirements/Requirements.html    | 16 ++++++++++++++--
 Documentation/RCU/stallwarn.txt                  | 13 +++++--------
 Documentation/RCU/whatisRCU.txt                  |  3 ++-
 Documentation/admin-guide/kernel-parameters.txt  | 16 ++++++++--------
 Documentation/kernel-per-CPU-kthreads.txt        |  2 +-
 6 files changed, 33 insertions(+), 24 deletions(-)

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
index 51f39f65002d..68bedbe8da76 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.html
+++ b/Documentation/RCU/Design/Requirements/Requirements.html
@@ -2861,7 +2861,7 @@ The other four flavors are listed below, with requirements for each
 described in a separate section.
 
 <ol>
-<li>	<a href="#Bottom-Half Flavor">Bottom-Half Flavor</a>
+<li>	<a href="#Bottom-Half Flavor">Bottom-Half Flavor (Historical)</a>
 <li>	<a href="#Sched Flavor">Sched Flavor</a>
 <li>	<a href="#Sleepable RCU">Sleepable RCU</a>
 <li>	<a href="#Tasks RCU">Tasks RCU</a>
@@ -2869,7 +2869,16 @@ described in a separate section.
 	Waiting for Multiple Grace Periods</a>
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
@@ -2929,6 +2938,9 @@ includes
 <tt>call_rcu_bh()</tt>,
 <tt>rcu_barrier_bh()</tt>, and
 <tt>rcu_read_lock_bh_held()</tt>.
+However, the update-side APIs are now simple wrappers for other RCU
+flavors, namely RCU-sched in CONFIG_PREEMPT=n kernels and RCU-preempt
+otherwise.
 
 <h3><a name="Sched Flavor">Sched Flavor</a></h3>
 
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
-- 
2.17.1

