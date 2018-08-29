Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3FFC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA26320644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA26320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeH3Cxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:53:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727346AbeH3Cxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:53:52 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMsf8R042806
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:44 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m637yjmre-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:43 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:54:12 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:54:08 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMs7CX38076564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:54:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87340B2066;
        Wed, 29 Aug 2018 18:53:03 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55656B206A;
        Wed, 29 Aug 2018 18:53:03 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:53:03 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 79DE916C91CF; Wed, 29 Aug 2018 15:54:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 09/24] rcu: Remove now-unused rcutorture APIs
Date:   Wed, 29 Aug 2018 15:53:50 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829225340.GA7019@linux.vnet.ibm.com>
References: <20180829225340.GA7019@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0064-0000-0000-0000034400F9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080749; UDB=6.00557500; IPR=6.00860734;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:54:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0065-0000-0000-00003A784D88
Message-Id: <20180829225405.7275-9-paulmck@linux.vnet.ibm.com>
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

This commit removes rcu_sched_get_gp_seq(), rcu_bh_get_gp_seq(),
rcu_exp_batches_completed_sched(), rcu_sched_force_quiescent_state(),
and rcu_bh_force_quiescent_state(), which are no longer used because
rcutorture no longer does "rcu_bh" and "rcu_sched" torture types.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcu.h  | 10 ----------
 kernel/rcu/tree.c | 47 -----------------------------------------------
 2 files changed, 57 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 2bb77fddc11f..aa3dc08af4b3 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -509,29 +509,19 @@ void srcutorture_get_gp_data(enum rcutorture_type test_type,
 
 #ifdef CONFIG_TINY_RCU
 static inline unsigned long rcu_get_gp_seq(void) { return 0; }
-static inline unsigned long rcu_bh_get_gp_seq(void) { return 0; }
-static inline unsigned long rcu_sched_get_gp_seq(void) { return 0; }
 static inline unsigned long rcu_exp_batches_completed(void) { return 0; }
-static inline unsigned long rcu_exp_batches_completed_sched(void) { return 0; }
 static inline unsigned long
 srcu_batches_completed(struct srcu_struct *sp) { return 0; }
 static inline void rcu_force_quiescent_state(void) { }
-static inline void rcu_bh_force_quiescent_state(void) { }
-static inline void rcu_sched_force_quiescent_state(void) { }
 static inline void show_rcu_gp_kthreads(void) { }
 static inline int rcu_get_gp_kthreads_prio(void) { return 0; }
 #else /* #ifdef CONFIG_TINY_RCU */
 unsigned long rcu_get_gp_seq(void);
-unsigned long rcu_bh_get_gp_seq(void);
-unsigned long rcu_sched_get_gp_seq(void);
 unsigned long rcu_exp_batches_completed(void);
-unsigned long rcu_exp_batches_completed_sched(void);
 unsigned long srcu_batches_completed(struct srcu_struct *sp);
 void show_rcu_gp_kthreads(void);
 int rcu_get_gp_kthreads_prio(void);
 void rcu_force_quiescent_state(void);
-void rcu_bh_force_quiescent_state(void);
-void rcu_sched_force_quiescent_state(void);
 extern struct workqueue_struct *rcu_gp_wq;
 extern struct workqueue_struct *rcu_par_gp_wq;
 #endif /* #else #ifdef CONFIG_TINY_RCU */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b2ebdd01c8a2..fb888085d304 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -490,25 +490,6 @@ unsigned long rcu_get_gp_seq(void)
 }
 EXPORT_SYMBOL_GPL(rcu_get_gp_seq);
 
-/*
- * Return the number of RCU-sched GPs completed thus far for debug & stats.
- */
-unsigned long rcu_sched_get_gp_seq(void)
-{
-	return rcu_get_gp_seq();
-}
-EXPORT_SYMBOL_GPL(rcu_sched_get_gp_seq);
-
-/*
- * Return the number of RCU GPs completed thus far for debug & stats.
- * This is a transitional API and will soon be removed.
- */
-unsigned long rcu_bh_get_gp_seq(void)
-{
-	return READ_ONCE(rcu_state.gp_seq);
-}
-EXPORT_SYMBOL_GPL(rcu_bh_get_gp_seq);
-
 /*
  * Return the number of RCU expedited batches completed thus far for
  * debug & stats.  Odd numbers mean that a batch is in progress, even
@@ -521,16 +502,6 @@ unsigned long rcu_exp_batches_completed(void)
 }
 EXPORT_SYMBOL_GPL(rcu_exp_batches_completed);
 
-/*
- * Return the number of RCU-sched expedited batches completed thus far
- * for debug & stats.  Similar to rcu_exp_batches_completed().
- */
-unsigned long rcu_exp_batches_completed_sched(void)
-{
-	return rcu_state.expedited_sequence;
-}
-EXPORT_SYMBOL_GPL(rcu_exp_batches_completed_sched);
-
 /*
  * Force a quiescent state.
  */
@@ -540,24 +511,6 @@ void rcu_force_quiescent_state(void)
 }
 EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
 
-/*
- * Force a quiescent state for RCU BH.
- */
-void rcu_bh_force_quiescent_state(void)
-{
-	force_quiescent_state();
-}
-EXPORT_SYMBOL_GPL(rcu_bh_force_quiescent_state);
-
-/*
- * Force a quiescent state for RCU-sched.
- */
-void rcu_sched_force_quiescent_state(void)
-{
-	rcu_force_quiescent_state();
-}
-EXPORT_SYMBOL_GPL(rcu_sched_force_quiescent_state);
-
 /*
  * Show the state of the grace-period kthreads.
  */
-- 
2.17.1

