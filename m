Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F9AC43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9645920871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9645920871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbeKLFrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:47:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726374AbeKLFqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:46:21 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJs6Hd140379
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:56:53 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npdcu1xpm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:56:53 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:56:51 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:56:47 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJukVU42139680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:56:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C56FB2066;
        Sun, 11 Nov 2018 19:56:46 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35B4FB2067;
        Sun, 11 Nov 2018 19:56:46 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:56:46 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1A08216C5DA3; Sun, 11 Nov 2018 11:56:47 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 10/20] doc: rcu: Update core and full API in whatisRCU
Date:   Sun, 11 Nov 2018 11:56:35 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111195619.GA6958@linux.ibm.com>
References: <20181111195619.GA6958@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111119-0068-0000-0000-0000035E48CD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116023; UDB=6.00578735; IPR=6.00896124;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:56:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-0069-0000-0000-00004664501B
Message-Id: <20181111195645.9205-10-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=951 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

RCU consolidation effort causes the update side of the RCU API to
be consistent across all the 3 RCU flavors (normal, sched, bh). This
commit therefore updates the full API in the whatisRCU document, thus
encouraging people to use the consolidated RCU update API instead of
the old RCU-bh and RCU-sched update APIs.

Also rcu_dereference is documented to be the same for all 3 mechanisms
(even before the consolidation), however its actually different - as
using the right rcu_dereference primitive (such as rcu_dereference_bh
for bh) is needed to make lock debugging work correctly. This update
also corrects that.

Also, add local_bh_disable() and local_bh_enable() as softirq
protection primitives and correct a grammar error in a quiz answer.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 Documentation/RCU/whatisRCU.txt | 55 +++++++++++++++++----------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
index 86d82f7f3500..7c33445fd0e5 100644
--- a/Documentation/RCU/whatisRCU.txt
+++ b/Documentation/RCU/whatisRCU.txt
@@ -322,28 +322,27 @@ to their callers and (2) call_rcu() callbacks may be invoked.  Efficient
 implementations of the RCU infrastructure make heavy use of batching in
 order to amortize their overhead over many uses of the corresponding APIs.
 
-There are no fewer than three RCU mechanisms in the Linux kernel; the
-diagram above shows the first one, which is by far the most commonly used.
-The rcu_dereference() and rcu_assign_pointer() primitives are used for
-all three mechanisms, but different defer and protect primitives are
-used as follows:
+There are at least three flavors of RCU usage in the Linux kernel. The diagram
+above shows the most common one. On the updater side, the rcu_assign_pointer(),
+sychronize_rcu() and call_rcu() primitives used are the same for all three
+flavors. However for protection (on the reader side), the primitives used vary
+depending on the flavor:
 
-	Defer			Protect
+a.	rcu_read_lock() / rcu_read_unlock()
+	rcu_dereference()
 
-a.	synchronize_rcu()	rcu_read_lock() / rcu_read_unlock()
-	call_rcu()		rcu_dereference()
+b.	rcu_read_lock_bh() / rcu_read_unlock_bh()
+	local_bh_disable() / local_bh_enable()
+	rcu_dereference_bh()
 
-b.	synchronize_rcu_bh()	rcu_read_lock_bh() / rcu_read_unlock_bh()
-	call_rcu_bh()		rcu_dereference_bh()
+c.	rcu_read_lock_sched() / rcu_read_unlock_sched()
+	preempt_disable() / preempt_enable()
+	local_irq_save() / local_irq_restore()
+	hardirq enter / hardirq exit
+	NMI enter / NMI exit
+	rcu_dereference_sched()
 
-c.	synchronize_sched()	rcu_read_lock_sched() / rcu_read_unlock_sched()
-	call_rcu_sched()	preempt_disable() / preempt_enable()
-				local_irq_save() / local_irq_restore()
-				hardirq enter / hardirq exit
-				NMI enter / NMI exit
-				rcu_dereference_sched()
-
-These three mechanisms are used as follows:
+These three flavors are used as follows:
 
 a.	RCU applied to normal data structures.
 
@@ -867,18 +866,20 @@ RCU:	Critical sections	Grace period		Barrier
 
 bh:	Critical sections	Grace period		Barrier
 
-	rcu_read_lock_bh	call_rcu_bh		rcu_barrier_bh
-	rcu_read_unlock_bh	synchronize_rcu_bh
-	rcu_dereference_bh	synchronize_rcu_bh_expedited
+	rcu_read_lock_bh	call_rcu		rcu_barrier
+	rcu_read_unlock_bh	synchronize_rcu
+	[local_bh_disable]	synchronize_rcu_expedited
+	[and friends]
+	rcu_dereference_bh
 	rcu_dereference_bh_check
 	rcu_dereference_bh_protected
 	rcu_read_lock_bh_held
 
 sched:	Critical sections	Grace period		Barrier
 
-	rcu_read_lock_sched	synchronize_sched	rcu_barrier_sched
-	rcu_read_unlock_sched	call_rcu_sched
-	[preempt_disable]	synchronize_sched_expedited
+	rcu_read_lock_sched	call_rcu		rcu_barrier
+	rcu_read_unlock_sched	synchronize_rcu
+	[preempt_disable]	synchronize_rcu_expedited
 	[and friends]
 	rcu_read_lock_sched_notrace
 	rcu_read_unlock_sched_notrace
@@ -890,8 +891,8 @@ sched:	Critical sections	Grace period		Barrier
 
 SRCU:	Critical sections	Grace period		Barrier
 
-	srcu_read_lock		synchronize_srcu	srcu_barrier
-	srcu_read_unlock	call_srcu
+	srcu_read_lock		call_srcu		srcu_barrier
+	srcu_read_unlock	synchronize_srcu
 	srcu_dereference	synchronize_srcu_expedited
 	srcu_dereference_check
 	srcu_read_lock_held
@@ -1034,7 +1035,7 @@ Answer:		Just as PREEMPT_RT permits preemption of spinlock
 		spinlocks blocking while in RCU read-side critical
 		sections.
 
-		Why the apparent inconsistency?  Because it is it
+		Why the apparent inconsistency?  Because it is
 		possible to use priority boosting to keep the RCU
 		grace periods short if need be (for example, if running
 		short of memory).  In contrast, if blocking waiting
-- 
2.17.1

