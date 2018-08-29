Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665F2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4BA20644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4BA20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeH3CiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:38:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727539AbeH3CiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:07 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMcikg081093
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:03 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m62g7usnf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:03 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:02 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:57 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcuHr25690234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F06DAB206C;
        Wed, 29 Aug 2018 18:37:51 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAE2DB2068;
        Wed, 29 Aug 2018 18:37:51 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:51 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0F49B16C91D6; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 15/52] rcu: Remove rsp parameter from rcu_gp_kthread_wake()
Date:   Wed, 29 Aug 2018 15:38:17 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0064-0000-0000-000003440009
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557497; IPR=6.00860729;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0065-0000-0000-00003A7847C7
Message-Id: <20180829223854.4055-15-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=961 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There now is only one rcu_state structure in a given build of the
Linux kernel, so there is no need to pass it as a parameter to RCU's
functions.  This commit therefore removes the rsp parameter from
rcu_gp_kthread_wake().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 22 +++++++++++-----------
 kernel/rcu/tree_plugin.h |  4 ++--
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 967d429ecfaf..d3150943db9f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1641,13 +1641,13 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
  * raced to awaken, and we lost), and finally don't try to awaken
  * a kthread that has not yet been created.
  */
-static void rcu_gp_kthread_wake(struct rcu_state *rsp)
+static void rcu_gp_kthread_wake(void)
 {
-	if (current == rsp->gp_kthread ||
-	    !READ_ONCE(rsp->gp_flags) ||
-	    !rsp->gp_kthread)
+	if (current == rcu_state.gp_kthread ||
+	    !READ_ONCE(rcu_state.gp_flags) ||
+	    !rcu_state.gp_kthread)
 		return;
-	swake_up_one(&rsp->gp_wq);
+	swake_up_one(&rcu_state.gp_wq);
 }
 
 /*
@@ -1721,7 +1721,7 @@ static void rcu_accelerate_cbs_unlocked(struct rcu_state *rsp,
 	needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
 	raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
 	if (needwake)
-		rcu_gp_kthread_wake(rsp);
+		rcu_gp_kthread_wake();
 }
 
 /*
@@ -1819,7 +1819,7 @@ static void note_gp_changes(struct rcu_state *rsp, struct rcu_data *rdp)
 	needwake = __note_gp_changes(rsp, rnp, rdp);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	if (needwake)
-		rcu_gp_kthread_wake(rsp);
+		rcu_gp_kthread_wake();
 }
 
 static void rcu_gp_slow(struct rcu_state *rsp, int delay)
@@ -2202,7 +2202,7 @@ static void rcu_report_qs_rsp(unsigned long flags)
 	WARN_ON_ONCE(!rcu_gp_in_progress());
 	WRITE_ONCE(rsp->gp_flags, READ_ONCE(rsp->gp_flags) | RCU_GP_FLAG_FQS);
 	raw_spin_unlock_irqrestore_rcu_node(rcu_get_root(), flags);
-	rcu_gp_kthread_wake(rsp);
+	rcu_gp_kthread_wake();
 }
 
 /*
@@ -2363,7 +2363,7 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
 		if (needwake)
-			rcu_gp_kthread_wake(rsp);
+			rcu_gp_kthread_wake();
 	}
 }
 
@@ -2669,7 +2669,7 @@ static void force_quiescent_state(struct rcu_state *rsp)
 	}
 	WRITE_ONCE(rsp->gp_flags, READ_ONCE(rsp->gp_flags) | RCU_GP_FLAG_FQS);
 	raw_spin_unlock_irqrestore_rcu_node(rnp_old, flags);
-	rcu_gp_kthread_wake(rsp);
+	rcu_gp_kthread_wake();
 }
 
 /*
@@ -3671,7 +3671,7 @@ static void rcu_migrate_callbacks(int cpu, struct rcu_state *rsp)
 		     !rcu_segcblist_n_cbs(&my_rdp->cblist));
 	raw_spin_unlock_irqrestore_rcu_node(rnp_root, flags);
 	if (needwake)
-		rcu_gp_kthread_wake(rsp);
+		rcu_gp_kthread_wake();
 	WARN_ONCE(rcu_segcblist_n_cbs(&rdp->cblist) != 0 ||
 		  !rcu_segcblist_empty(&rdp->cblist),
 		  "rcu_cleanup_dead_cpu: Callbacks on offline CPU %d: qlen=%lu, 1stCB=%p\n",
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 545e4ac9422a..50ca000ad9f2 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1700,7 +1700,7 @@ static void rcu_prepare_for_idle(void)
 		needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
 		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
 		if (needwake)
-			rcu_gp_kthread_wake(rsp);
+			rcu_gp_kthread_wake();
 	}
 }
 
@@ -2147,7 +2147,7 @@ static void rcu_nocb_wait_gp(struct rcu_data *rdp)
 		needwake = rcu_start_this_gp(rnp, rdp, c);
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		if (needwake)
-			rcu_gp_kthread_wake(rdp->rsp);
+			rcu_gp_kthread_wake();
 	}
 
 	/*
-- 
2.17.1

