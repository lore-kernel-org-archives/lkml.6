Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129F4C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B847626372
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B847626372
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935119AbeFZAiQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:38:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934575AbeFZAdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:33:17 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q0Sfxs040084
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:33:16 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96p3r0t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:33:16 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:33:15 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:33:10 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q0X9I164159886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:33:09 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66728B2070;
        Mon, 25 Jun 2018 20:33:04 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E505B206C;
        Mon, 25 Jun 2018 20:33:04 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:33:04 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BC70416CA095; Mon, 25 Jun 2018 17:35:14 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Joe Perches <joe@perches.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 04/27] rcu: Use pr_fmt to prefix "rcu: " to logging output
Date:   Mon, 25 Jun 2018 17:34:50 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626003448.GA26209@linux.vnet.ibm.com>
References: <20180626003448.GA26209@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0064-0000-0000-000003204528
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052336; UDB=6.00539470; IPR=6.00830262;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:33:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0065-0000-0000-000039B764CC
Message-Id: <20180626003513.27812-4-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>

This commit also adjusts some whitespace while in the area.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ paulmck: Revert string-breaking %s as requested by Andy Shevchenko. ]
---
 kernel/rcu/rcuperf.c     |  7 +++----
 kernel/rcu/rcutorture.c  |  4 ++--
 kernel/rcu/srcutree.c    |  5 ++++-
 kernel/rcu/tree.c        |  8 +++++---
 kernel/rcu/tree_plugin.h | 10 ++++++----
 5 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index b080bc4a4f45..00e395c0d7d0 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -680,12 +680,11 @@ rcu_perf_init(void)
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
index eb6d4915b4e6..773ce12f9582 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1755,8 +1755,8 @@ rcu_torture_init(void)
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
index d6d6ea9738c0..e526b56998af 100644
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
index 50a8f49e1763..fcb0355a8084 100644
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
@@ -1374,8 +1377,7 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gp_seq)
 	 * See Documentation/RCU/stallwarn.txt for info on how to debug
 	 * RCU CPU stall warnings.
 	 */
-	pr_err("INFO: %s detected stalls on CPUs/tasks:",
-	       rsp->name);
+	pr_err("INFO: %s detected stalls on CPUs/tasks:", rsp->name);
 	print_cpu_stall_info_begin();
 	rcu_for_each_leaf_node(rsp, rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -4046,7 +4048,7 @@ static void __init rcu_init_geometry(void)
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
-- 
2.17.1

