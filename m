Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754091AbeDWDC6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:02:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753937AbeDWDCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:02:41 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 21/21] rcu: Update list of rcu_future_grace_period() trace events
Date: Sun, 22 Apr 2018 20:03:44 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423030258.GA23370@linux.vnet.ibm.com>
References: <20180423030258.GA23370@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042303-0044-0000-0000-0000040974B7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021898; UDB=6.00521542; IPR=6.00801133;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:02:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-0045-0000-0000-0000083B7DB4
Message-Id: <1524452624-27589-21-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230032
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reworking grace-period initiation and funnel locking added new
rcu_future_grace_period() trace events, so this commit updates the
rcu_future_grace_period() trace event's header comment accordingly.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/trace/events/rcu.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index d8c33298c153..5936aac357ab 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -84,20 +84,21 @@ TRACE_EVENT(rcu_grace_period,
 );
 
 /*
- * Tracepoint for future grace-period events, including those for no-callbacks
- * CPUs.  The caller should pull the data from the rcu_node structure,
- * other than rcuname, which comes from the rcu_state structure, and event,
- * which is one of the following:
+ * Tracepoint for future grace-period events.  The caller should pull
+ * the data from the rcu_node structure, other than rcuname, which comes
+ * from the rcu_state structure, and event, which is one of the following:
  *
- * "Startleaf": Request a nocb grace period based on leaf-node data.
+ * "Startleaf": Request a grace period based on leaf-node data.
+ * "Prestarted": Someone beat us to the request
  * "Startedleaf": Leaf-node start proved sufficient.
  * "Startedleafroot": Leaf-node start proved sufficient after checking root.
  * "Startedroot": Requested a nocb grace period based on root-node data.
+ * "NoGPkthread": The RCU grace-period kthread has not yet started.
  * "StartWait": Start waiting for the requested grace period.
  * "ResumeWait": Resume waiting after signal.
  * "EndWait": Complete wait.
  * "Cleanup": Clean up rcu_node structure after previous GP.
- * "CleanupMore": Clean up, and another no-CB GP is needed.
+ * "CleanupMore": Clean up, and another GP is needed.
  */
 TRACE_EVENT(rcu_future_grace_period,
 
-- 
2.5.2
