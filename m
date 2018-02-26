Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeBZVyl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:54:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43068 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751823AbeBZVww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:52:52 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 15/20] rcu: Fix init_rcu_head() comment.
Date: Mon, 26 Feb 2018 13:53:05 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226215219.GA27379@linux.vnet.ibm.com>
References: <20180226215219.GA27379@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022621-0048-0000-0000-0000023FB3DA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995530; UDB=6.00506033; IPR=6.00774858;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 21:52:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022621-0049-0000-0000-00004443360E
Message-Id: <1519681990-31349-15-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260274
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current (and implicit) comment header for init_rcu_head() and
destroy_rcu_head() incorrectly says that they are not needed for
statically allocated rcu_head structures.  This commit therefore
fixes this comment.

Reported-by: Bart Van Assche <Bart.VanAssche@wdc.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
---
 include/linux/rcupdate.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 043d04784675..36360d07f25b 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -214,10 +214,12 @@ do { \
 #endif
 
 /*
- * init_rcu_head_on_stack()/destroy_rcu_head_on_stack() are needed for dynamic
- * initialization and destruction of rcu_head on the stack. rcu_head structures
- * allocated dynamically in the heap or defined statically don't need any
- * initialization.
+ * The init_rcu_head_on_stack() and destroy_rcu_head_on_stack() calls
+ * are needed for dynamic initialization and destruction of rcu_head
+ * on the stack, and init_rcu_head()/destroy_rcu_head() are needed for
+ * dynamic initialization and destruction of statically allocated rcu_head
+ * structures.  However, rcu_head structures allocated dynamically in the
+ * heap don't need any initialization.
  */
 #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
 void init_rcu_head(struct rcu_head *head);
-- 
2.5.2
