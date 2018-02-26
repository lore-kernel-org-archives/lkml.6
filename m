Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeBZV5H (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:57:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751950AbeBZV4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:56:12 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 4/5] srcu: Remove dead code in srcu_gp_end()
Date: Mon, 26 Feb 2018 13:56:31 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226215614.GA31616@linux.vnet.ibm.com>
References: <20180226215614.GA31616@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022621-0052-0000-0000-000002BEAF0C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995531; UDB=6.00506034; IPR=6.00774859;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 21:56:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022621-0053-0000-0000-00005BD26053
Message-Id: <1519682192-31987-4-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260275
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Byungchul Park <byungchul.park@lge.com>

Of course, compilers will optimize out a dead code. Anyway, remove
any dead code for better readibility.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/srcutree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index d582a2352cdb..f962f4428c39 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -532,7 +532,6 @@ static void srcu_gp_end(struct srcu_struct *sp)
 	unsigned long flags;
 	unsigned long gpseq;
 	int idx;
-	int idxnext;
 	unsigned long mask;
 	struct srcu_data *sdp;
 	struct srcu_node *snp;
@@ -556,7 +555,6 @@ static void srcu_gp_end(struct srcu_struct *sp)
 
 	/* Initiate callback invocation as needed. */
 	idx = rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->srcu_have_cbs);
-	idxnext = (idx + 1) % ARRAY_SIZE(snp->srcu_have_cbs);
 	rcu_for_each_node_breadth_first(sp, snp) {
 		spin_lock_irq_rcu_node(snp);
 		cbs = false;
-- 
2.5.2
