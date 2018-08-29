Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8C8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7025D20658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7025D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeH3CVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:21:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727288AbeH3CTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:19:54 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMJJss056820
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:55 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m615deryv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:55 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:20:54 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:20:50 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMKnN824510500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:20:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5389FB2064;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AC0DB2075;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5906C16C91D6; Wed, 29 Aug 2018 15:20:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 15/19] rcu: Remove RCU_STATE_INITIALIZER()
Date:   Wed, 29 Aug 2018 15:20:43 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829222021.GA29944@linux.vnet.ibm.com>
References: <20180829222021.GA29944@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0064-0000-0000-00000343FE8B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080738; UDB=6.00557494; IPR=6.00860724;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:20:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0065-0000-0000-00003A783FDE
Message-Id: <20180829222047.319-15-paulmck@linux.vnet.ibm.com>
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

Now that a given build of the Linux kernel has only one set of rcu_state,
rcu_node, and rcu_data structures, there is no point in creating a macro
to declare and compile-time initialize them.  This commit therefore
just does normal declaration and compile-time initialization of these
structures.  While in the area, this commit also removes #ifndefs of
the no-longer-ever-defined preprocessor macro RCU_TREE_NONCORE.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 54 ++++++++++++-----------------------------------
 kernel/rcu/tree.h | 29 +++++++++++++++++++------
 2 files changed, 37 insertions(+), 46 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a8965a7caf25..1868df8089ba 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -72,46 +72,20 @@
 
 /* Data structures. */
 
-/*
- * In order to export the rcu_state name to the tracing tools, it
- * needs to be added in the __tracepoint_string section.
- * This requires defining a separate variable tp_<sname>_varname
- * that points to the string being used, and this will allow
- * the tracing userspace tools to be able to decipher the string
- * address to the matching string.
- */
-#ifdef CONFIG_TRACING
-# define DEFINE_RCU_TPS(sname) \
-static char sname##_varname[] = #sname; \
-static const char *tp_##sname##_varname __used __tracepoint_string = sname##_varname;
-# define RCU_STATE_NAME(sname) sname##_varname
-#else
-# define DEFINE_RCU_TPS(sname)
-# define RCU_STATE_NAME(sname) __stringify(sname)
-#endif
-
-#define RCU_STATE_INITIALIZER(sname, sabbr, cr) \
-DEFINE_RCU_TPS(sname) \
-static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data); \
-struct rcu_state rcu_state = { \
-	.level = { &rcu_state.node[0] }, \
-	.rda = &rcu_data, \
-	.call = cr, \
-	.gp_state = RCU_GP_IDLE, \
-	.gp_seq = (0UL - 300UL) << RCU_SEQ_CTR_SHIFT, \
-	.barrier_mutex = __MUTEX_INITIALIZER(rcu_state.barrier_mutex), \
-	.name = RCU_STATE_NAME(sname), \
-	.abbr = sabbr, \
-	.exp_mutex = __MUTEX_INITIALIZER(rcu_state.exp_mutex), \
-	.exp_wake_mutex = __MUTEX_INITIALIZER(rcu_state.exp_wake_mutex), \
-	.ofl_lock = __SPIN_LOCK_UNLOCKED(rcu_state.ofl_lock), \
-}
-
-#ifdef CONFIG_PREEMPT_RCU
-RCU_STATE_INITIALIZER(rcu_preempt, 'p', call_rcu);
-#else
-RCU_STATE_INITIALIZER(rcu_sched, 's', call_rcu);
-#endif
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data);
+struct rcu_state rcu_state = {
+	.level = { &rcu_state.node[0] },
+	.rda = &rcu_data,
+	.call = call_rcu,
+	.gp_state = RCU_GP_IDLE,
+	.gp_seq = (0UL - 300UL) << RCU_SEQ_CTR_SHIFT,
+	.barrier_mutex = __MUTEX_INITIALIZER(rcu_state.barrier_mutex),
+	.name = RCU_NAME,
+	.abbr = RCU_ABBR,
+	.exp_mutex = __MUTEX_INITIALIZER(rcu_state.exp_mutex),
+	.exp_wake_mutex = __MUTEX_INITIALIZER(rcu_state.exp_wake_mutex),
+	.ofl_lock = __SPIN_LOCK_UNLOCKED(rcu_state.ofl_lock),
+};
 
 static struct rcu_state *const rcu_state_p = &rcu_state;
 static struct rcu_data __percpu *const rcu_data_p = &rcu_data;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 38658ca87dcb..3f36562d3118 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -386,7 +386,6 @@ struct rcu_state {
 #define RCU_GP_CLEANUP   7	/* Grace-period cleanup started. */
 #define RCU_GP_CLEANED   8	/* Grace-period cleanup complete. */
 
-#ifndef RCU_TREE_NONCORE
 static const char * const gp_state_names[] = {
 	"RCU_GP_IDLE",
 	"RCU_GP_WAIT_GPS",
@@ -398,7 +397,29 @@ static const char * const gp_state_names[] = {
 	"RCU_GP_CLEANUP",
 	"RCU_GP_CLEANED",
 };
-#endif /* #ifndef RCU_TREE_NONCORE */
+
+/*
+ * In order to export the rcu_state name to the tracing tools, it
+ * needs to be added in the __tracepoint_string section.
+ * This requires defining a separate variable tp_<sname>_varname
+ * that points to the string being used, and this will allow
+ * the tracing userspace tools to be able to decipher the string
+ * address to the matching string.
+ */
+#ifdef CONFIG_PREEMPT_RCU
+#define RCU_ABBR 'p'
+#define RCU_NAME_RAW "rcu_preempt"
+#else /* #ifdef CONFIG_PREEMPT_RCU */
+#define RCU_ABBR 's'
+#define RCU_NAME_RAW "rcu_sched"
+#endif /* #else #ifdef CONFIG_PREEMPT_RCU */
+#ifndef CONFIG_TRACING
+#define RCU_NAME RCU_NAME_RAW
+#else /* #ifdef CONFIG_TRACING */
+static char rcu_name[] = RCU_NAME_RAW;
+static const char *tp_rcu_varname __used __tracepoint_string = rcu_name;
+#define RCU_NAME rcu_name
+#endif /* #else #ifdef CONFIG_TRACING */
 
 extern struct list_head rcu_struct_flavors;
 
@@ -426,8 +447,6 @@ DECLARE_PER_CPU(unsigned int, rcu_cpu_kthread_loops);
 DECLARE_PER_CPU(char, rcu_cpu_has_work);
 #endif /* #ifdef CONFIG_RCU_BOOST */
 
-#ifndef RCU_TREE_NONCORE
-
 /* Forward declarations for rcutree_plugin.h */
 static void rcu_bootup_announce(void);
 static void rcu_qs(void);
@@ -495,5 +514,3 @@ void srcu_offline_cpu(unsigned int cpu);
 void srcu_online_cpu(unsigned int cpu) { }
 void srcu_offline_cpu(unsigned int cpu) { }
 #endif /* #else #ifdef CONFIG_SRCU */
-
-#endif /* #ifndef RCU_TREE_NONCORE */
-- 
2.17.1

