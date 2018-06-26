Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8648FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0C62631A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0C62631A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964813AbeFZAK0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:10:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934571AbeFZAHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:05 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q03tYn119281
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:05 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96p2vj9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:05 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:03 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:59 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06w1I11534832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE69BB206B;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A81C4B2068;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C4F0E16CA0B3; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Joel Fernandes <joelaf@google.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 38/40] rcu: Rename the grace-period-request variables and parameters
Date:   Mon, 25 Jun 2018 17:08:57 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0064-0000-0000-000003202FA0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052327; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0065-0000-0000-000039B74455
Message-Id: <20180626000859.23572-38-paulmck@linux.vnet.ibm.com>
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

From: Joel Fernandes <joelaf@google.com>

The name 'c' is used for variables and parameters holding the requested
grace-period sequence number.  However it is no longer very meaningful
given the conversions from ->gpnum and (especially) ->completed to
->gp_seq. This commit therefore renames 'c' to 'gp_seq_req'.

Previous patch discussion is at:
https://patchwork.kernel.org/patch/10396579/

Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/trace/events/rcu.h | 15 +++++++------
 kernel/rcu/tree.c          | 46 ++++++++++++++++++++++----------------
 2 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 5ab1df0a2801..759e7e83733d 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -103,15 +103,16 @@ TRACE_EVENT(rcu_grace_period,
  */
 TRACE_EVENT(rcu_future_grace_period,
 
-	TP_PROTO(const char *rcuname, unsigned long gp_seq, unsigned long c,
-		 u8 level, int grplo, int grphi, const char *gpevent),
+	TP_PROTO(const char *rcuname, unsigned long gp_seq,
+		 unsigned long gp_seq_req, u8 level, int grplo, int grphi,
+		 const char *gpevent),
 
-	TP_ARGS(rcuname, gp_seq, c, level, grplo, grphi, gpevent),
+	TP_ARGS(rcuname, gp_seq, gp_seq_req, level, grplo, grphi, gpevent),
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
 		__field(unsigned long, gp_seq)
-		__field(unsigned long, c)
+		__field(unsigned long, gp_seq_req)
 		__field(u8, level)
 		__field(int, grplo)
 		__field(int, grphi)
@@ -121,7 +122,7 @@ TRACE_EVENT(rcu_future_grace_period,
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
 		__entry->gp_seq = gp_seq;
-		__entry->c = c;
+		__entry->gp_seq_req = gp_seq_req;
 		__entry->level = level;
 		__entry->grplo = grplo;
 		__entry->grphi = grphi;
@@ -129,7 +130,7 @@ TRACE_EVENT(rcu_future_grace_period,
 	),
 
 	TP_printk("%s %lu %lu %u %d %d %s",
-		  __entry->rcuname, __entry->gp_seq, __entry->c, __entry->level,
+		  __entry->rcuname, __entry->gp_seq, __entry->gp_seq_req, __entry->level,
 		  __entry->grplo, __entry->grphi, __entry->gpevent)
 );
 
@@ -751,7 +752,7 @@ TRACE_EVENT(rcu_barrier,
 #else /* #ifdef CONFIG_RCU_TRACE */
 
 #define trace_rcu_grace_period(rcuname, gp_seq, gpevent) do { } while (0)
-#define trace_rcu_future_grace_period(rcuname, gp_seq, c, \
+#define trace_rcu_future_grace_period(rcuname, gp_seq, gp_seq_req, \
 				      level, grplo, grphi, event) \
 				      do { } while (0)
 #define trace_rcu_grace_period_init(rcuname, gp_seq, level, grplo, grphi, \
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ad76aeade637..89ed285a55c8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1546,13 +1546,18 @@ void rcu_cpu_stall_reset(void)
 
 /* Trace-event wrapper function for trace_rcu_future_grace_period.  */
 static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
-			      unsigned long c, const char *s)
+			      unsigned long gp_seq_req, const char *s)
 {
-	trace_rcu_future_grace_period(rdp->rsp->name, rnp->gp_seq, c,
+	trace_rcu_future_grace_period(rdp->rsp->name, rnp->gp_seq, gp_seq_req,
 				      rnp->level, rnp->grplo, rnp->grphi, s);
 }
 
 /*
+ * rcu_start_this_gp - Request the start of a particular grace period
+ * @rnp: The leaf node of the CPU from which to start.
+ * @rdp: The rcu_data corresponding to the CPU from which to start.
+ * @gp_seq_req: The gp_seq of the grace period to start.
+ *
  * Start the specified grace period, as needed to handle newly arrived
  * callbacks.  The required future grace periods are recorded in each
  * rcu_node structure's ->gp_seq_needed field.  Returns true if there
@@ -1560,9 +1565,11 @@ static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
  *
  * The caller must hold the specified rcu_node structure's ->lock, which
  * is why the caller is responsible for waking the grace-period kthread.
+ *
+ * Returns true if the GP thread needs to be awakened else false.
  */
 static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
-			      unsigned long c)
+			      unsigned long gp_seq_req)
 {
 	bool ret = false;
 	struct rcu_state *rsp = rdp->rsp;
@@ -1578,25 +1585,27 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	 * not be released.
 	 */
 	raw_lockdep_assert_held_rcu_node(rnp);
-	trace_rcu_this_gp(rnp, rdp, c, TPS("Startleaf"));
+	trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startleaf"));
 	for (rnp_root = rnp; 1; rnp_root = rnp_root->parent) {
 		if (rnp_root != rnp)
 			raw_spin_lock_rcu_node(rnp_root);
-		if (ULONG_CMP_GE(rnp_root->gp_seq_needed, c) ||
-		    rcu_seq_started(&rnp_root->gp_seq, c) ||
+		if (ULONG_CMP_GE(rnp_root->gp_seq_needed, gp_seq_req) ||
+		    rcu_seq_started(&rnp_root->gp_seq, gp_seq_req) ||
 		    (rnp != rnp_root &&
 		     rcu_seq_state(rcu_seq_current(&rnp_root->gp_seq)))) {
-			trace_rcu_this_gp(rnp_root, rdp, c, TPS("Prestarted"));
+			trace_rcu_this_gp(rnp_root, rdp, gp_seq_req,
+					  TPS("Prestarted"));
 			goto unlock_out;
 		}
-		rnp_root->gp_seq_needed = c;
+		rnp_root->gp_seq_needed = gp_seq_req;
 		if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq))) {
 			/*
 			 * We just marked the leaf, and a grace period
 			 * is in progress, which means that rcu_gp_cleanup()
 			 * will see the marking.  Bail to reduce contention.
 			 */
-			trace_rcu_this_gp(rnp, rdp, c, TPS("Startedleaf"));
+			trace_rcu_this_gp(rnp, rdp, gp_seq_req,
+					  TPS("Startedleaf"));
 			goto unlock_out;
 		}
 		if (rnp_root != rnp && rnp_root->parent != NULL)
@@ -1607,21 +1616,21 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 
 	/* If GP already in progress, just leave, otherwise start one. */
 	if (rcu_gp_in_progress(rsp)) {
-		trace_rcu_this_gp(rnp_root, rdp, c, TPS("Startedleafroot"));
+		trace_rcu_this_gp(rnp_root, rdp, gp_seq_req, TPS("Startedleafroot"));
 		goto unlock_out;
 	}
-	trace_rcu_this_gp(rnp_root, rdp, c, TPS("Startedroot"));
+	trace_rcu_this_gp(rnp_root, rdp, gp_seq_req, TPS("Startedroot"));
 	WRITE_ONCE(rsp->gp_flags, rsp->gp_flags | RCU_GP_FLAG_INIT);
 	rsp->gp_req_activity = jiffies;
 	if (!rsp->gp_kthread) {
-		trace_rcu_this_gp(rnp_root, rdp, c, TPS("NoGPkthread"));
+		trace_rcu_this_gp(rnp_root, rdp, gp_seq_req, TPS("NoGPkthread"));
 		goto unlock_out;
 	}
 	trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gp_seq), TPS("newreq"));
 	ret = true;  /* Caller must wake GP kthread. */
 unlock_out:
 	/* Push furthest requested GP to leaf node and rcu_data structure. */
-	if (ULONG_CMP_LT(c, rnp_root->gp_seq_needed)) {
+	if (ULONG_CMP_LT(gp_seq_req, rnp_root->gp_seq_needed)) {
 		rnp->gp_seq_needed = rnp_root->gp_seq_needed;
 		rdp->gp_seq_needed = rnp_root->gp_seq_needed;
 	}
@@ -1636,14 +1645,13 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
  */
 static bool rcu_future_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
 {
-	unsigned long c = rnp->gp_seq;
 	bool needmore;
 	struct rcu_data *rdp = this_cpu_ptr(rsp->rda);
 
 	needmore = ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed);
 	if (!needmore)
 		rnp->gp_seq_needed = rnp->gp_seq; /* Avoid counter wrap. */
-	trace_rcu_this_gp(rnp, rdp, c,
+	trace_rcu_this_gp(rnp, rdp, rnp->gp_seq,
 			  needmore ? TPS("CleanupMore") : TPS("Cleanup"));
 	return needmore;
 }
@@ -1679,7 +1687,7 @@ static void rcu_gp_kthread_wake(struct rcu_state *rsp)
 static bool rcu_accelerate_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
 			       struct rcu_data *rdp)
 {
-	unsigned long c;
+	unsigned long gp_seq_req;
 	bool ret = false;
 
 	raw_lockdep_assert_held_rcu_node(rnp);
@@ -1698,9 +1706,9 @@ static bool rcu_accelerate_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
 	 * accelerating callback invocation to an earlier grace-period
 	 * number.
 	 */
-	c = rcu_seq_snap(&rsp->gp_seq);
-	if (rcu_segcblist_accelerate(&rdp->cblist, c))
-		ret = rcu_start_this_gp(rnp, rdp, c);
+	gp_seq_req = rcu_seq_snap(&rsp->gp_seq);
+	if (rcu_segcblist_accelerate(&rdp->cblist, gp_seq_req))
+		ret = rcu_start_this_gp(rnp, rdp, gp_seq_req);
 
 	/* Trace depending on how much we were able to accelerate. */
 	if (rcu_segcblist_restempty(&rdp->cblist, RCU_WAIT_TAIL))
-- 
2.17.1

