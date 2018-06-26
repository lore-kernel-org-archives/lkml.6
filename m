Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CE7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1F42636D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1F42636D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935204AbeFZAgb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:36:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934655AbeFZAdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:33:17 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q0Sbj5040886
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:33:17 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96ubmsd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:33:17 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:33:15 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:33:10 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q0X91i786832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:33:09 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D50EB2064;
        Mon, 25 Jun 2018 20:33:04 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44DA9B2071;
        Mon, 25 Jun 2018 20:33:04 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:33:04 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C28C416CA097; Mon, 25 Jun 2018 17:35:14 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 05/27] rcu: Improve RCU-tasks naming and comments
Date:   Mon, 25 Jun 2018 17:34:51 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626003448.GA26209@linux.vnet.ibm.com>
References: <20180626003448.GA26209@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0068-0000-0000-0000030E2D4F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052336; UDB=6.00539469; IPR=6.00830262;
 MB=3.00021856; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:33:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0069-0000-0000-000044CF28BD
Message-Id: <20180626003513.27812-5-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The naming and comments associated with some RCU-tasks code make
the faulty assumption that context switches due to cond_resched()
are voluntary.  As several people pointed out, this is not the case.
This commit therefore updates function names and comments to better
reflect current reality.

Reported-by: Byungchul Park <byungchul.park@lge.com>
Reported-by: Joel Fernandes <joel@joelfernandes.org>
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/rcupdate.h | 12 ++++++------
 include/linux/rcutiny.h  |  2 +-
 kernel/rcu/tree.c        |  2 +-
 kernel/rcu/update.c      | 27 ++++++++++++++-------------
 4 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index dacc90358b33..75e5b393cf44 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -158,11 +158,11 @@ static inline void rcu_init_nohz(void) { }
 	} while (0)
 
 /*
- * Note a voluntary context switch for RCU-tasks benefit.  This is a
- * macro rather than an inline function to avoid #include hell.
+ * Note a quasi-voluntary context switch for RCU-tasks's benefit.
+ * This is a macro rather than an inline function to avoid #include hell.
  */
 #ifdef CONFIG_TASKS_RCU
-#define rcu_note_voluntary_context_switch_lite(t) \
+#define rcu_tasks_qs(t) \
 	do { \
 		if (READ_ONCE((t)->rcu_tasks_holdout)) \
 			WRITE_ONCE((t)->rcu_tasks_holdout, false); \
@@ -170,14 +170,14 @@ static inline void rcu_init_nohz(void) { }
 #define rcu_note_voluntary_context_switch(t) \
 	do { \
 		rcu_all_qs(); \
-		rcu_note_voluntary_context_switch_lite(t); \
+		rcu_tasks_qs(t); \
 	} while (0)
 void call_rcu_tasks(struct rcu_head *head, rcu_callback_t func);
 void synchronize_rcu_tasks(void);
 void exit_tasks_rcu_start(void);
 void exit_tasks_rcu_finish(void);
 #else /* #ifdef CONFIG_TASKS_RCU */
-#define rcu_note_voluntary_context_switch_lite(t)	do { } while (0)
+#define rcu_tasks_qs(t)	do { } while (0)
 #define rcu_note_voluntary_context_switch(t)		rcu_all_qs()
 #define call_rcu_tasks call_rcu_sched
 #define synchronize_rcu_tasks synchronize_sched
@@ -194,7 +194,7 @@ static inline void exit_tasks_rcu_finish(void) { }
  */
 #define cond_resched_tasks_rcu_qs() \
 do { \
-	rcu_note_voluntary_context_switch_lite(current); \
+	rcu_tasks_qs(current); \
 	cond_resched(); \
 } while (0)
 
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 7b3c82e8a625..8d9a0ea8f0b5 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -93,7 +93,7 @@ static inline void kfree_call_rcu(struct rcu_head *head,
 #define rcu_note_context_switch(preempt) \
 	do { \
 		rcu_sched_qs(); \
-		rcu_note_voluntary_context_switch_lite(current); \
+		rcu_tasks_qs(current); \
 	} while (0)
 
 static inline int rcu_needs_cpu(u64 basemono, u64 *nextevt)
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index fcb0355a8084..1ea971244512 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -457,7 +457,7 @@ void rcu_note_context_switch(bool preempt)
 		rcu_momentary_dyntick_idle();
 	this_cpu_inc(rcu_dynticks.rcu_qs_ctr);
 	if (!preempt)
-		rcu_note_voluntary_context_switch_lite(current);
+		rcu_tasks_qs(current);
 out:
 	trace_rcu_utilization(TPS("End context switch"));
 	barrier(); /* Avoid RCU read-side critical sections leaking up. */
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 4c230a60ece4..5783bdf86e5a 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -507,14 +507,15 @@ early_initcall(check_cpu_stall_init);
 #ifdef CONFIG_TASKS_RCU
 
 /*
- * Simple variant of RCU whose quiescent states are voluntary context switch,
- * user-space execution, and idle.  As such, grace periods can take one good
- * long time.  There are no read-side primitives similar to rcu_read_lock()
- * and rcu_read_unlock() because this implementation is intended to get
- * the system into a safe state for some of the manipulations involved in
- * tracing and the like.  Finally, this implementation does not support
- * high call_rcu_tasks() rates from multiple CPUs.  If this is required,
- * per-CPU callback lists will be needed.
+ * Simple variant of RCU whose quiescent states are voluntary context
+ * switch, cond_resched_rcu_qs(), user-space execution, and idle.
+ * As such, grace periods can take one good long time.  There are no
+ * read-side primitives similar to rcu_read_lock() and rcu_read_unlock()
+ * because this implementation is intended to get the system into a safe
+ * state for some of the manipulations involved in tracing and the like.
+ * Finally, this implementation does not support high call_rcu_tasks()
+ * rates from multiple CPUs.  If this is required, per-CPU callback lists
+ * will be needed.
  */
 
 /* Global list of callbacks and associated lock. */
@@ -542,11 +543,11 @@ static struct task_struct *rcu_tasks_kthread_ptr;
  * period elapses, in other words after all currently executing RCU
  * read-side critical sections have completed. call_rcu_tasks() assumes
  * that the read-side critical sections end at a voluntary context
- * switch (not a preemption!), entry into idle, or transition to usermode
- * execution.  As such, there are no read-side primitives analogous to
- * rcu_read_lock() and rcu_read_unlock() because this primitive is intended
- * to determine that all tasks have passed through a safe state, not so
- * much for data-strcuture synchronization.
+ * switch (not a preemption!), cond_resched_rcu_qs(), entry into idle,
+ * or transition to usermode execution.  As such, there are no read-side
+ * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
+ * this primitive is intended to determine that all tasks have passed
+ * through a safe state, not so much for data-strcuture synchronization.
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
-- 
2.17.1

