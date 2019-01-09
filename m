Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794A9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4928120685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfAIV32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:29:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726729AbfAIV2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:28:44 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LSZXw034554
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:28:43 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pwn7pt58k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:28:42 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:28:42 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:28:37 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LSaci23658578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:28:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16DCAB205F;
        Wed,  9 Jan 2019 21:28:36 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E50C0B206C;
        Wed,  9 Jan 2019 21:28:35 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:28:35 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7A46116C6405; Wed,  9 Jan 2019 13:28:35 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 07/12] rcu: Update NOCB comments
Date:   Wed,  9 Jan 2019 13:28:29 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109212816.GA32282@linux.ibm.com>
References: <20190109212816.GA32282@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0064-0000-0000-0000039410D7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144145; UDB=6.00595708; IPR=6.00924407;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:28:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0065-0000-0000-00003BF962E2
Message-Id: <20190109212834.1257-7-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit updates a few obsolete comments in the RCU callback-offload
code.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree_plugin.h | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b241c4b20549..f0019c2a2cbc 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1857,22 +1857,24 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp)
 
 /*
  * Offload callback processing from the boot-time-specified set of CPUs
- * specified by rcu_nocb_mask.  For each CPU in the set, there is a
- * kthread created that pulls the callbacks from the corresponding CPU,
- * waits for a grace period to elapse, and invokes the callbacks.
- * The no-CBs CPUs do a wake_up() on their kthread when they insert
- * a callback into any empty list, unless the rcu_nocb_poll boot parameter
- * has been specified, in which case each kthread actively polls its
- * CPU.  (Which isn't so great for energy efficiency, but which does
- * reduce RCU's overhead on that CPU.)
+ * specified by rcu_nocb_mask.  For the CPUs in the set, there are kthreads
+ * created that pull the callbacks from the corresponding CPU, wait for
+ * a grace period to elapse, and invoke the callbacks.  These kthreads
+ * are organized into leaders, which manage incoming callbacks, wait for
+ * grace periods, and awaken followers, and the followers, which only
+ * invoke callbacks.  Each leader is its own follower.  The no-CBs CPUs
+ * do a wake_up() on their kthread when they insert a callback into any
+ * empty list, unless the rcu_nocb_poll boot parameter has been specified,
+ * in which case each kthread actively polls its CPU.  (Which isn't so great
+ * for energy efficiency, but which does reduce RCU's overhead on that CPU.)
  *
  * This is intended to be used in conjunction with Frederic Weisbecker's
  * adaptive-idle work, which would seriously reduce OS jitter on CPUs
  * running CPU-bound user-mode computations.
  *
- * Offloading of callback processing could also in theory be used as
- * an energy-efficiency measure because CPUs with no RCU callbacks
- * queued are more aggressive about entering dyntick-idle mode.
+ * Offloading of callbacks can also be used as an energy-efficiency
+ * measure because CPUs with no RCU callbacks queued are more aggressive
+ * about entering dyntick-idle mode.
  */
 
 
@@ -1976,10 +1978,7 @@ static void wake_nocb_leader_defer(struct rcu_data *rdp, int waketype,
 	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 }
 
-/*
- * Does the specified CPU need an RCU callback for this invocation
- * of rcu_barrier()?
- */
+/* Does rcu_barrier need to queue an RCU callback on the specified CPU?  */
 static bool rcu_nocb_cpu_needs_barrier(int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
@@ -1995,8 +1994,8 @@ static bool rcu_nocb_cpu_needs_barrier(int cpu)
 	 * callbacks would be posted.  In the worst case, the first
 	 * barrier in rcu_barrier() suffices (but the caller cannot
 	 * necessarily rely on this, not a substitute for the caller
-	 * getting the concurrency design right!).  There must also be
-	 * a barrier between the following load an posting of a callback
+	 * getting the concurrency design right!).  There must also be a
+	 * barrier between the following load and posting of a callback
 	 * (if a callback is in fact needed).  This is associated with an
 	 * atomic_inc() in the caller.
 	 */
-- 
2.17.1

