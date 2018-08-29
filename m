Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5255EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007FE20644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007FE20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbeH3Cx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:53:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727659AbeH3CxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:53:24 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMs3Mk133547
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:15 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m615dfm60-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:15 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:54:14 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:54:08 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMs78025362640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:54:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E3DDB2076;
        Wed, 29 Aug 2018 18:53:03 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A28DB206B;
        Wed, 29 Aug 2018 18:53:03 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:53:03 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7FDC916C91D1; Wed, 29 Aug 2018 15:54:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 10/24] rcu: Clean up flavor-related definitions and comments in rcupdate.h
Date:   Wed, 29 Aug 2018 15:53:51 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829225340.GA7019@linux.vnet.ibm.com>
References: <20180829225340.GA7019@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0052-0000-0000-0000032821B9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080749; UDB=6.00557500; IPR=6.00860734;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:54:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0053-0000-0000-00005DE600FF
Message-Id: <20180829225405.7275-10-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/rcupdate.h | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 12103e1bbe67..d6d543b60a9f 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -119,11 +119,10 @@ static inline void rcu_init_nohz(void) { }
  * RCU_NONIDLE - Indicate idle-loop code that needs RCU readers
  * @a: Code that RCU needs to pay attention to.
  *
- * RCU, RCU-bh, and RCU-sched read-side critical sections are forbidden
- * in the inner idle loop, that is, between the rcu_idle_enter() and
- * the rcu_idle_exit() -- RCU will happily ignore any such read-side
- * critical sections.  However, things like powertop need tracepoints
- * in the inner idle loop.
+ * RCU read-side critical sections are forbidden in the inner idle loop,
+ * that is, between the rcu_idle_enter() and the rcu_idle_exit() -- RCU
+ * will happily ignore any such read-side critical sections.  However,
+ * things like powertop need tracepoints in the inner idle loop.
  *
  * This macro provides the way out:  RCU_NONIDLE(do_something_with_RCU())
  * will tell RCU that it needs to pay attention, invoke its argument
@@ -163,7 +162,7 @@ void exit_tasks_rcu_finish(void);
 #else /* #ifdef CONFIG_TASKS_RCU */
 #define rcu_tasks_qs(t)	do { } while (0)
 #define rcu_note_voluntary_context_switch(t)		rcu_all_qs()
-#define call_rcu_tasks call_rcu_sched
+#define call_rcu_tasks call_rcu
 #define synchronize_rcu_tasks synchronize_rcu
 static inline void exit_tasks_rcu_start(void) { }
 static inline void exit_tasks_rcu_finish(void) { }
@@ -309,8 +308,8 @@ static inline void rcu_preempt_sleep_check(void) { }
  * Helper functions for rcu_dereference_check(), rcu_dereference_protected()
  * and rcu_assign_pointer().  Some of these could be folded into their
  * callers, but they are left separate in order to ease introduction of
- * multiple flavors of pointers to match the multiple flavors of RCU
- * (e.g., __rcu_sched, and __srcu), should this make sense in the future.
+ * multiple pointers markings to match different RCU implementations
+ * (e.g., __srcu), should this make sense in the future.
  */
 
 #ifdef __CHECKER__
@@ -670,9 +669,8 @@ static inline void rcu_read_unlock(void)
  * rcu_read_lock_bh() - mark the beginning of an RCU-bh critical section
  *
  * This is equivalent of rcu_read_lock(), but also disables softirqs.
- * Note that synchronize_rcu() and friends may be used for the update
- * side, although synchronize_rcu_bh() is available as a wrapper in the
- * short term.  Longer term, the _bh update-side API will be eliminated.
+ * Note that anything else that disables softirqs can also serve as
+ * an RCU read-side critical section.
  *
  * Note that rcu_read_lock_bh() and the matching rcu_read_unlock_bh()
  * must occur in the same context, for example, it is illegal to invoke
@@ -705,10 +703,9 @@ static inline void rcu_read_unlock_bh(void)
 /**
  * rcu_read_lock_sched() - mark the beginning of a RCU-sched critical section
  *
- * This is equivalent of rcu_read_lock(), but to be used when updates
- * are being done using call_rcu_sched() or synchronize_rcu_sched().
- * Read-side critical sections can also be introduced by anything that
- * disables preemption, including local_irq_disable() and friends.
+ * This is equivalent of rcu_read_lock(), but disables preemption.
+ * Read-side critical sections can also be introduced by anything else
+ * that disables preemption, including local_irq_disable() and friends.
  *
  * Note that rcu_read_lock_sched() and the matching rcu_read_unlock_sched()
  * must occur in the same context, for example, it is illegal to invoke
-- 
2.17.1

