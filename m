Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEED0C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88AA926387
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AA926387
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935193AbeFZAun (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:50:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934620AbeFZAub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:50:31 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q0n0Qf029064
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:50:30 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96qbv70-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:50:30 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:50:29 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:50:25 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q0oOsK8454482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:50:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA372B2071;
        Mon, 25 Jun 2018 20:50:18 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A72E5B2064;
        Mon, 25 Jun 2018 20:50:18 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:50:18 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 38ADC16C9ED6; Mon, 25 Jun 2018 17:52:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 01/13] rcu: Remove rcutorture test version and sequence number
Date:   Mon, 25 Jun 2018 17:52:15 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626005205.GA28179@linux.vnet.ibm.com>
References: <20180626005205.GA28179@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0060-0000-0000-000002827CBF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052342; UDB=6.00539473; IPR=6.00830268;
 MB=3.00021856; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:50:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0061-0000-0000-000045935E15
Message-Id: <20180626005227.30660-1-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back when RCU had a debugfs interface, there was a test version and
sequence number that allowed associating debugfs data with a particular
test run, where the test run started with modprobe and ended with rmmod,
which was how tests were run back on the old ABAT system within IBM.
But rcutorture testing no longer runs on ABAT, and there is no longer an
RCU debugfs interface, so there is no longer any need for test versions
and sequence numbers.

This commit therefore removes the rcutorture_record_test_transition()
and rcutorture_record_progress() functions, and along with them the
rcutorture_testseq and rcutorture_vernum variables that they update.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcu.h        |  4 ----
 kernel/rcu/rcutorture.c |  4 +---
 kernel/rcu/tree.c       | 37 -------------------------------------
 3 files changed, 1 insertion(+), 44 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index aa215d6355f8..0453a7d12b3f 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -444,7 +444,6 @@ enum rcutorture_type {
 #if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
 void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 			    unsigned long *gp_seq);
-void rcutorture_record_test_transition(void);
 void rcutorture_record_progress(unsigned long vernum);
 void do_trace_rcu_torture_read(const char *rcutorturename,
 			       struct rcu_head *rhp,
@@ -458,7 +457,6 @@ static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
 	*flags = 0;
 	*gp_seq = 0;
 }
-static inline void rcutorture_record_test_transition(void) { }
 static inline void rcutorture_record_progress(unsigned long vernum) { }
 #ifdef CONFIG_RCU_TRACE
 void do_trace_rcu_torture_read(const char *rcutorturename,
@@ -505,8 +503,6 @@ static inline void rcu_bh_force_quiescent_state(void) { }
 static inline void rcu_sched_force_quiescent_state(void) { }
 static inline void show_rcu_gp_kthreads(void) { }
 #else /* #ifdef CONFIG_TINY_RCU */
-extern unsigned long rcutorture_testseq;
-extern unsigned long rcutorture_vernum;
 unsigned long rcu_get_gp_seq(void);
 unsigned long rcu_bh_get_gp_seq(void);
 unsigned long rcu_sched_get_gp_seq(void);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index eb6d4915b4e6..335387fabac2 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1016,7 +1016,7 @@ rcu_torture_writer(void *arg)
 				break;
 			}
 		}
-		rcutorture_record_progress(++rcu_torture_current_version);
+		rcu_torture_current_version++;
 		/* Cycle through nesting levels of rcu_expedite_gp() calls. */
 		if (can_expedite &&
 		    !(torture_random(&rand) & 0xff & (!!expediting - 1))) {
@@ -1613,7 +1613,6 @@ rcu_torture_cleanup(void)
 	unsigned long gp_seq = 0;
 	int i;
 
-	rcutorture_record_test_transition();
 	if (torture_cleanup_begin()) {
 		if (cur_ops->cb_barrier != NULL)
 			cur_ops->cb_barrier();
@@ -1918,7 +1917,6 @@ rcu_torture_init(void)
 				goto unwind;
 		}
 	}
-	rcutorture_record_test_transition();
 	torture_init_end();
 	return 0;
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4b0aee4f9318..21878aada657 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -191,18 +191,6 @@ module_param(gp_cleanup_delay, int, 0444);
  */
 #define PER_RCU_NODE_PERIOD 3	/* Number of grace periods between delays. */
 
-/*
- * Track the rcutorture test sequence number and the update version
- * number within a given test.  The rcutorture_testseq is incremented
- * on every rcutorture module load and unload, so has an odd value
- * when a test is running.  The rcutorture_vernum is set to zero
- * when rcutorture starts and is incremented on each rcutorture update.
- * These variables enable correlating rcutorture output with the
- * RCU tracing information.
- */
-unsigned long rcutorture_testseq;
-unsigned long rcutorture_vernum;
-
 /*
  * Compute the mask of online CPUs for the specified rcu_node structure.
  * This will not be stable unless the rcu_node structure's ->lock is
@@ -622,20 +610,6 @@ void show_rcu_gp_kthreads(void)
 }
 EXPORT_SYMBOL_GPL(show_rcu_gp_kthreads);
 
-/*
- * Record the number of times rcutorture tests have been initiated and
- * terminated.  This information allows the debugfs tracing stats to be
- * correlated to the rcutorture messages, even when the rcutorture module
- * is being repeatedly loaded and unloaded.  In other words, we cannot
- * store this state in rcutorture itself.
- */
-void rcutorture_record_test_transition(void)
-{
-	rcutorture_testseq++;
-	rcutorture_vernum = 0;
-}
-EXPORT_SYMBOL_GPL(rcutorture_record_test_transition);
-
 /*
  * Send along grace-period-related data for rcutorture diagnostics.
  */
@@ -664,17 +638,6 @@ void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 }
 EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
 
-/*
- * Record the number of writer passes through the current rcutorture test.
- * This is also used to correlate debugfs tracing stats with the rcutorture
- * messages.
- */
-void rcutorture_record_progress(unsigned long vernum)
-{
-	rcutorture_vernum++;
-}
-EXPORT_SYMBOL_GPL(rcutorture_record_progress);
-
 /*
  * Return the root node of the specified rcu_state structure.
  */
-- 
2.17.1

