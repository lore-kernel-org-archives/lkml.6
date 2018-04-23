Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754208AbeDWCdY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:33:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753948AbeDWCbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:31:23 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 09/22] rcu: Update rcu_bind_gp_kthread() header comment
Date: Sun, 22 Apr 2018 19:32:14 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423023150.GA21533@linux.vnet.ibm.com>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042302-0052-0000-0000-000002E0B1C1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021888; UDB=6.00521536; IPR=6.00801123;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 02:31:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042302-0053-0000-0000-00005C6D822D
Message-Id: <1524450747-22778-9-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230025
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header comment for rcu_bind_gp_kthread() refers to sysidle, which
is no longer with us.  However, it is still important to bind RCU's
grace-period kthreads to the housekeeping CPU(s), so rather than remove
rcu_bind_gp_kthread(), this commit updates the comment.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree_plugin.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ee24a5de0503..d37b9bb3f481 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2622,8 +2622,7 @@ static bool rcu_nohz_full_cpu(struct rcu_state *rsp)
 }
 
 /*
- * Bind the grace-period kthread for the sysidle flavor of RCU to the
- * timekeeping CPU.
+ * Bind the RCU grace-period kthreads to the housekeeping CPU.
  */
 static void rcu_bind_gp_kthread(void)
 {
-- 
2.5.2
