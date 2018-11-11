Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D232C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C208214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C208214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeKLFTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:19:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54948 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726633AbeKLFSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:18:36 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJNutv112163
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:29:12 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npde81d90-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:29:12 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:29:10 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:29:06 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJT5Rp65732690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:29:05 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 796CDB206B;
        Sun, 11 Nov 2018 19:29:05 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 565C0B2067;
        Sun, 11 Nov 2018 19:29:05 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:29:05 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 818BC16C35AF; Sun, 11 Nov 2018 11:29:06 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 05/14] rcu: Add state name to show_rcu_gp_kthreads() output
Date:   Sun, 11 Nov 2018 11:28:55 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111192839.GA32144@linux.ibm.com>
References: <20181111192839.GA32144@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111119-0040-0000-0000-00000490883E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116014; UDB=6.00577119; IPR=6.00896114;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:29:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-0041-0000-0000-0000089990E7
Message-Id: <20181111192904.3199-5-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the name of the RCU grace-period state to
the show_rcu_gp_kthreads() output in order to ease debugging.
This commit also moves gp_state_getname() up in the code so that
show_rcu_gp_kthreads() can use it.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 36e30150e1e9..ea78532183ac 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -499,6 +499,16 @@ void rcu_force_quiescent_state(void)
 }
 EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
 
+/*
+ * Convert a ->gp_state value to a character string.
+ */
+static const char *gp_state_getname(short gs)
+{
+	if (gs < 0 || gs >= ARRAY_SIZE(gp_state_names))
+		return "???";
+	return gp_state_names[gs];
+}
+
 /*
  * Show the state of the grace-period kthreads.
  */
@@ -508,8 +518,9 @@ void show_rcu_gp_kthreads(void)
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 
-	pr_info("%s: wait state: %d ->state: %#lx\n", rcu_state.name,
-		rcu_state.gp_state, rcu_state.gp_kthread->state);
+	pr_info("%s: wait state: %s(%d) ->state: %#lx\n", rcu_state.name,
+		gp_state_getname(rcu_state.gp_state), rcu_state.gp_state,
+		rcu_state.gp_kthread->state);
 	rcu_for_each_node_breadth_first(rnp) {
 		if (ULONG_CMP_GE(rcu_state.gp_seq, rnp->gp_seq_needed))
 			continue;
@@ -1142,16 +1153,6 @@ static void record_gp_stall_check_time(void)
 	rcu_state.n_force_qs_gpstart = READ_ONCE(rcu_state.n_force_qs);
 }
 
-/*
- * Convert a ->gp_state value to a character string.
- */
-static const char *gp_state_getname(short gs)
-{
-	if (gs < 0 || gs >= ARRAY_SIZE(gp_state_names))
-		return "???";
-	return gp_state_names[gs];
-}
-
 /*
  * Complain about starvation of grace-period kthread.
  */
-- 
2.17.1

