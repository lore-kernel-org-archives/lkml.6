Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F3FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C3B2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C3B2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeH3CT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:19:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727379AbeH3CT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:19:56 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMIif3075486
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:56 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m60r17uv8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:56 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:20:56 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:20:50 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMKnQU25493736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:20:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46509B2066;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 151ADB206E;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3920716C91D1; Wed, 29 Aug 2018 15:20:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 10/19] rcu: Update comments and help text for no more RCU-bh updaters
Date:   Wed, 29 Aug 2018 15:20:38 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829222021.GA29944@linux.vnet.ibm.com>
References: <20180829222021.GA29944@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0068-0000-0000-00000331B7B5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080738; UDB=6.00557494; IPR=6.00860723;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:20:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0069-0000-0000-0000458F0E11
Message-Id: <20180829222047.319-10-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit updates comments and help text to account for the fact that
RCU-bh update-side functions are now simple wrappers for their RCU or
RCU-sched counterparts.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/rcupdate.h      | 12 ++++--------
 include/linux/rcupdate_wait.h |  6 +++---
 include/linux/rcutree.h       | 14 ++------------
 kernel/rcu/Kconfig            | 10 +++++-----
 kernel/rcu/tree.c             | 17 +++++++++--------
 kernel/rcu/update.c           |  2 +-
 6 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 9ebfd436cec7..8d5740edd63c 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -688,14 +688,10 @@ static inline void rcu_read_unlock(void)
 /**
  * rcu_read_lock_bh() - mark the beginning of an RCU-bh critical section
  *
- * This is equivalent of rcu_read_lock(), but to be used when updates
- * are being done using call_rcu_bh() or synchronize_rcu_bh(). Since
- * both call_rcu_bh() and synchronize_rcu_bh() consider completion of a
- * softirq handler to be a quiescent state, a process in RCU read-side
- * critical section must be protected by disabling softirqs. Read-side
- * critical sections in interrupt context can use just rcu_read_lock(),
- * though this should at least be commented to avoid confusing people
- * reading the code.
+ * This is equivalent of rcu_read_lock(), but also disables softirqs.
+ * Note that synchronize_rcu() and friends may be used for the update
+ * side, although synchronize_rcu_bh() is available as a wrapper in the
+ * short term.  Longer term, the _bh update-side API will be eliminated.
  *
  * Note that rcu_read_lock_bh() and the matching rcu_read_unlock_bh()
  * must occur in the same context, for example, it is illegal to invoke
diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index 57f371344152..bc104699560e 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -36,13 +36,13 @@ do {									\
  * @...: List of call_rcu() functions for the flavors to wait on.
  *
  * This macro waits concurrently for multiple flavors of RCU grace periods.
- * For example, synchronize_rcu_mult(call_rcu, call_rcu_bh) would wait
- * on concurrent RCU and RCU-bh grace periods.  Waiting on a give SRCU
+ * For example, synchronize_rcu_mult(call_rcu, call_rcu_sched) would wait
+ * on concurrent RCU and RCU-sched grace periods.  Waiting on a give SRCU
  * domain requires you to write a wrapper function for that SRCU domain's
  * call_srcu() function, supplying the corresponding srcu_struct.
  *
  * If Tiny RCU, tell _wait_rcu_gp() not to bother waiting for RCU
- * or RCU-bh, given that anywhere synchronize_rcu_mult() can be called
+ * or RCU-sched, given that anywhere synchronize_rcu_mult() can be called
  * is automatically a grace period.
  */
 #define synchronize_rcu_mult(...) \
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index c789c302a2c9..f7a41323aa54 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -58,18 +58,8 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
 /**
  * synchronize_rcu_bh_expedited - Brute-force RCU-bh grace period
  *
- * Wait for an RCU-bh grace period to elapse, but use a "big hammer"
- * approach to force the grace period to end quickly.  This consumes
- * significant time on all CPUs and is unfriendly to real-time workloads,
- * so is thus not recommended for any sort of common-case code.  In fact,
- * if you are using synchronize_rcu_bh_expedited() in a loop, please
- * restructure your code to batch your updates, and then use a single
- * synchronize_rcu_bh() instead.
- *
- * Note that it is illegal to call this function while holding any lock
- * that is acquired by a CPU-hotplug notifier.  And yes, it is also illegal
- * to call this function from a CPU-hotplug notifier.  Failing to observe
- * these restriction will result in deadlock.
+ * This is a transitional API and will soon be removed, with all
+ * callers converted to synchronize_rcu_expedited().
  */
 static inline void synchronize_rcu_bh_expedited(void)
 {
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 9210379c0353..a0b7f0103ca9 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -229,11 +229,11 @@ config RCU_NOCB_CPU
 	  CPUs specified at boot time by the rcu_nocbs parameter.
 	  For each such CPU, a kthread ("rcuox/N") will be created to
 	  invoke callbacks, where the "N" is the CPU being offloaded,
-	  and where the "x" is "b" for RCU-bh, "p" for RCU-preempt, and
-	  "s" for RCU-sched.  Nothing prevents this kthread from running
-	  on the specified CPUs, but (1) the kthreads may be preempted
-	  between each callback, and (2) affinity or cgroups can be used
-	  to force the kthreads to run on whatever set of CPUs is desired.
+	  and where the "p" for RCU-preempt and "s" for RCU-sched.
+	  Nothing prevents this kthread from running on the specified
+	  CPUs, but (1) the kthreads may be preempted between each
+	  callback, and (2) affinity or cgroups can be used to force
+	  the kthreads to run on whatever set of CPUs is desired.
 
 	  Say Y here if you want to help to debug reduced OS jitter.
 	  Say N here if you are unsure.
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b602d60462ba..8d04cf2c6f76 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -565,7 +565,8 @@ unsigned long rcu_sched_get_gp_seq(void)
 EXPORT_SYMBOL_GPL(rcu_sched_get_gp_seq);
 
 /*
- * Return the number of RCU-bh GPs completed thus far for debug & stats.
+ * Return the number of RCU GPs completed thus far for debug & stats.
+ * This is a transitional API and will soon be removed.
  */
 unsigned long rcu_bh_get_gp_seq(void)
 {
@@ -3068,13 +3069,13 @@ void kfree_call_rcu(struct rcu_head *head,
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
 
 /*
- * Because a context switch is a grace period for RCU-sched and RCU-bh,
- * any blocking grace-period wait automatically implies a grace period
- * if there is only one CPU online at any point time during execution
- * of either synchronize_sched() or synchronize_rcu_bh().  It is OK to
- * occasionally incorrectly indicate that there are multiple CPUs online
- * when there was in fact only one the whole time, as this just adds
- * some overhead: RCU still operates correctly.
+ * Because a context switch is a grace period for RCU-sched, any blocking
+ * grace-period wait automatically implies a grace period if there
+ * is only one CPU online at any point time during execution of either
+ * synchronize_sched() or synchronize_rcu_bh().  It is OK to occasionally
+ * incorrectly indicate that there are multiple CPUs online when there
+ * was in fact only one the whole time, as this just adds some overhead:
+ * RCU still operates correctly.
  */
 static int rcu_blocking_is_gp(void)
 {
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 39cb23d22109..9ea87d0aa386 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -298,7 +298,7 @@ EXPORT_SYMBOL_GPL(rcu_read_lock_held);
  *
  * Check debug_lockdep_rcu_enabled() to prevent false positives during boot.
  *
- * Note that rcu_read_lock() is disallowed if the CPU is either idle or
+ * Note that rcu_read_lock_bh() is disallowed if the CPU is either idle or
  * offline from an RCU perspective, so check for those as well.
  */
 int rcu_read_lock_bh_held(void)
-- 
2.17.1

