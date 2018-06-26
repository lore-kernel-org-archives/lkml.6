Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2FAC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7615826311
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7615826311
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935321AbeFZAKm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:10:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934543AbeFZAHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:05 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q03jGk068803
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:04 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96qapng-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:04 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:03 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:59 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06w2P11796894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9D08B2073;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3B69B2070;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CA4F616CA0B4; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 39/40] rcu: Use better variable names in funnel locking loop
Date:   Mon, 25 Jun 2018 17:08:58 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-2213-0000-0000-000002BFDECC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052327; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-2214-0000-0000-00005A9B953E
Message-Id: <20180626000859.23572-39-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

The funnel locking loop in rcu_start_this_gp uses rcu_root as a
temporary variable while walking the combining tree. This causes a
tiresome exercise of a code reader reminding themselves that rcu_root
may not be root. Lets just call it rnp, and rename other variables as
well to be more appropriate.

Original patch: https://patchwork.kernel.org/patch/10396577/

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ paulmck: Fix name in comment as well. ]
---
 kernel/rcu/tree.c | 64 +++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 89ed285a55c8..0dac8c716c48 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1554,7 +1554,7 @@ static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 
 /*
  * rcu_start_this_gp - Request the start of a particular grace period
- * @rnp: The leaf node of the CPU from which to start.
+ * @rnp_start: The leaf node of the CPU from which to start.
  * @rdp: The rcu_data corresponding to the CPU from which to start.
  * @gp_seq_req: The gp_seq of the grace period to start.
  *
@@ -1568,74 +1568,74 @@ static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
  *
  * Returns true if the GP thread needs to be awakened else false.
  */
-static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
+static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 			      unsigned long gp_seq_req)
 {
 	bool ret = false;
 	struct rcu_state *rsp = rdp->rsp;
-	struct rcu_node *rnp_root;
+	struct rcu_node *rnp;
 
 	/*
 	 * Use funnel locking to either acquire the root rcu_node
 	 * structure's lock or bail out if the need for this grace period
-	 * has already been recorded -- or has already started.  If there
-	 * is already a grace period in progress in a non-leaf node, no
-	 * recording is needed because the end of the grace period will
-	 * scan the leaf rcu_node structures.  Note that rnp->lock must
-	 * not be released.
+	 * has already been recorded -- or if that grace period has in
+	 * fact already started.  If there is already a grace period in
+	 * progress in a non-leaf node, no recording is needed because the
+	 * end of the grace period will scan the leaf rcu_node structures.
+	 * Note that rnp_start->lock must not be released.
 	 */
-	raw_lockdep_assert_held_rcu_node(rnp);
-	trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startleaf"));
-	for (rnp_root = rnp; 1; rnp_root = rnp_root->parent) {
-		if (rnp_root != rnp)
-			raw_spin_lock_rcu_node(rnp_root);
-		if (ULONG_CMP_GE(rnp_root->gp_seq_needed, gp_seq_req) ||
-		    rcu_seq_started(&rnp_root->gp_seq, gp_seq_req) ||
-		    (rnp != rnp_root &&
-		     rcu_seq_state(rcu_seq_current(&rnp_root->gp_seq)))) {
-			trace_rcu_this_gp(rnp_root, rdp, gp_seq_req,
+	raw_lockdep_assert_held_rcu_node(rnp_start);
+	trace_rcu_this_gp(rnp_start, rdp, gp_seq_req, TPS("Startleaf"));
+	for (rnp = rnp_start; 1; rnp = rnp->parent) {
+		if (rnp != rnp_start)
+			raw_spin_lock_rcu_node(rnp);
+		if (ULONG_CMP_GE(rnp->gp_seq_needed, gp_seq_req) ||
+		    rcu_seq_started(&rnp->gp_seq, gp_seq_req) ||
+		    (rnp != rnp_start &&
+		     rcu_seq_state(rcu_seq_current(&rnp->gp_seq)))) {
+			trace_rcu_this_gp(rnp, rdp, gp_seq_req,
 					  TPS("Prestarted"));
 			goto unlock_out;
 		}
-		rnp_root->gp_seq_needed = gp_seq_req;
-		if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq))) {
+		rnp->gp_seq_needed = gp_seq_req;
+		if (rcu_seq_state(rcu_seq_current(&rnp_start->gp_seq))) {
 			/*
 			 * We just marked the leaf, and a grace period
 			 * is in progress, which means that rcu_gp_cleanup()
 			 * will see the marking.  Bail to reduce contention.
 			 */
-			trace_rcu_this_gp(rnp, rdp, gp_seq_req,
+			trace_rcu_this_gp(rnp_start, rdp, gp_seq_req,
 					  TPS("Startedleaf"));
 			goto unlock_out;
 		}
-		if (rnp_root != rnp && rnp_root->parent != NULL)
-			raw_spin_unlock_rcu_node(rnp_root);
-		if (!rnp_root->parent)
+		if (rnp != rnp_start && rnp->parent != NULL)
+			raw_spin_unlock_rcu_node(rnp);
+		if (!rnp->parent)
 			break;  /* At root, and perhaps also leaf. */
 	}
 
 	/* If GP already in progress, just leave, otherwise start one. */
 	if (rcu_gp_in_progress(rsp)) {
-		trace_rcu_this_gp(rnp_root, rdp, gp_seq_req, TPS("Startedleafroot"));
+		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startedleafroot"));
 		goto unlock_out;
 	}
-	trace_rcu_this_gp(rnp_root, rdp, gp_seq_req, TPS("Startedroot"));
+	trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startedroot"));
 	WRITE_ONCE(rsp->gp_flags, rsp->gp_flags | RCU_GP_FLAG_INIT);
 	rsp->gp_req_activity = jiffies;
 	if (!rsp->gp_kthread) {
-		trace_rcu_this_gp(rnp_root, rdp, gp_seq_req, TPS("NoGPkthread"));
+		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("NoGPkthread"));
 		goto unlock_out;
 	}
 	trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gp_seq), TPS("newreq"));
 	ret = true;  /* Caller must wake GP kthread. */
 unlock_out:
 	/* Push furthest requested GP to leaf node and rcu_data structure. */
-	if (ULONG_CMP_LT(gp_seq_req, rnp_root->gp_seq_needed)) {
-		rnp->gp_seq_needed = rnp_root->gp_seq_needed;
-		rdp->gp_seq_needed = rnp_root->gp_seq_needed;
+	if (ULONG_CMP_LT(gp_seq_req, rnp->gp_seq_needed)) {
+		rnp_start->gp_seq_needed = rnp->gp_seq_needed;
+		rdp->gp_seq_needed = rnp->gp_seq_needed;
 	}
-	if (rnp != rnp_root)
-		raw_spin_unlock_rcu_node(rnp_root);
+	if (rnp != rnp_start)
+		raw_spin_unlock_rcu_node(rnp);
 	return ret;
 }
 
-- 
2.17.1

