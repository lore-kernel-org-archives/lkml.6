Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbeBZVxC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:53:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751845AbeBZVwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:52:53 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        "Liu, Changcheng" <changcheng.liu@intel.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 13/20] rcu: Remove redundant nxttail index macro define
Date: Mon, 26 Feb 2018 13:53:03 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226215219.GA27379@linux.vnet.ibm.com>
References: <20180226215219.GA27379@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022621-0040-0000-0000-000003FD5BDA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995530; UDB=6.00506033; IPR=6.00774858;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 21:52:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022621-0041-0000-0000-000007FE65E9
Message-Id: <1519681990-31349-13-git-send-email-paulmck@linux.vnet.ibm.com>
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

From: "Liu, Changcheng" <changcheng.liu@intel.com>

RCU's nxttail has been optimized to be a rcu_segcblist, which is
a multi-tailed linked list with macros defined for the indexes for
each tail.  The indexes have been defined in linux/rcu_segcblist.h,
so this commit removes the redundant definitions in kernel/rcu/tree.h.

Signed-off-by: Liu Changcheng <changcheng.liu@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 2edd56397b00..f491ab4f2e8e 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -178,13 +178,6 @@ union rcu_noqs {
 	u16 s; /* Set of bits, aggregate OR here. */
 };
 
-/* Index values for nxttail array in struct rcu_data. */
-#define RCU_DONE_TAIL		0	/* Also RCU_WAIT head. */
-#define RCU_WAIT_TAIL		1	/* Also RCU_NEXT_READY head. */
-#define RCU_NEXT_READY_TAIL	2	/* Also RCU_NEXT head. */
-#define RCU_NEXT_TAIL		3
-#define RCU_NEXT_SIZE		4
-
 /* Per-CPU data for read-copy update. */
 struct rcu_data {
 	/* 1) quiescent-state and grace-period handling : */
-- 
2.5.2
