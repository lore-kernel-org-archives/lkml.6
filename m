Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1831BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7EE20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7EE20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbeKLFqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:46:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726838AbeKLFqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:46:21 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJs34h140122
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:56:53 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npdcu1xpc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:56:52 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:56:51 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:56:47 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJukUW29229284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:56:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7540FB205F;
        Sun, 11 Nov 2018 19:56:46 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47969B2064;
        Sun, 11 Nov 2018 19:56:46 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:56:46 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2C43416C5DA6; Sun, 11 Nov 2018 11:56:47 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 13/20] doc: rcu: Remove obsolete checklist item about synchronize_rcu usage
Date:   Sun, 11 Nov 2018 11:56:38 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111195619.GA6958@linux.ibm.com>
References: <20181111195619.GA6958@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111119-0064-0000-0000-000003722F17
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116023; UDB=6.00577118; IPR=6.00896123;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:56:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-0065-0000-0000-00003B4D44E4
Message-Id: <20181111195645.9205-13-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Since the RCU mechanisms have been consolidated, the checklist item
warning that synchronize_rcu() waits only for RCU readers is obsolete.
This commit therefore removes this checklist item.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 Documentation/RCU/checklist.txt | 37 +++++++--------------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

diff --git a/Documentation/RCU/checklist.txt b/Documentation/RCU/checklist.txt
index cc22ce49618d..b90ad1b0665a 100644
--- a/Documentation/RCU/checklist.txt
+++ b/Documentation/RCU/checklist.txt
@@ -320,37 +320,14 @@ over a rather long period of time, but improvements are always welcome!
 	will break Alpha, cause aggressive compilers to generate bad code,
 	and confuse people trying to read your code.
 
-11.	Note that synchronize_rcu() -only- guarantees to wait until
-	all currently executing rcu_read_lock()-protected RCU read-side
-	critical sections complete.  It does -not- necessarily guarantee
-	that all currently running interrupts, NMIs, preempt_disable()
-	code, or idle loops will complete.  Therefore, if your
-	read-side critical sections are protected by something other
-	than rcu_read_lock(), do -not- use synchronize_rcu().
-
-	Similarly, disabling preemption is not an acceptable substitute
-	for rcu_read_lock().  Code that attempts to use preemption
-	disabling where it should be using rcu_read_lock() will break
-	in CONFIG_PREEMPT=y kernel builds.
-
-	If you want to wait for interrupt handlers, NMI handlers, and
-	code under the influence of preempt_disable(), you instead
-	need to use synchronize_irq() or synchronize_sched().
-
-	This same limitation also applies to synchronize_rcu_bh()
-	and synchronize_srcu(), as well as to the asynchronous and
-	expedited forms of the three primitives, namely call_rcu(),
-	call_rcu_bh(), call_srcu(), synchronize_rcu_expedited(),
-	synchronize_rcu_bh_expedited(), and synchronize_srcu_expedited().
-
-12.	Any lock acquired by an RCU callback must be acquired elsewhere
+11.	Any lock acquired by an RCU callback must be acquired elsewhere
 	with softirq disabled, e.g., via spin_lock_irqsave(),
 	spin_lock_bh(), etc.  Failing to disable irq on a given
 	acquisition of that lock will result in deadlock as soon as
 	the RCU softirq handler happens to run your RCU callback while
 	interrupting that acquisition's critical section.
 
-13.	RCU callbacks can be and are executed in parallel.  In many cases,
+12.	RCU callbacks can be and are executed in parallel.  In many cases,
 	the callback code simply wrappers around kfree(), so that this
 	is not an issue (or, more accurately, to the extent that it is
 	an issue, the memory-allocator locking handles it).  However,
@@ -366,7 +343,7 @@ over a rather long period of time, but improvements are always welcome!
 	not the case, a self-spawning RCU callback would prevent the
 	victim CPU from ever going offline.)
 
-14.	Unlike other forms of RCU, it -is- permissible to block in an
+13.	Unlike other forms of RCU, it -is- permissible to block in an
 	SRCU read-side critical section (demarked by srcu_read_lock()
 	and srcu_read_unlock()), hence the "SRCU": "sleepable RCU".
 	Please note that if you don't need to sleep in read-side critical
@@ -410,7 +387,7 @@ over a rather long period of time, but improvements are always welcome!
 	Note that rcu_dereference() and rcu_assign_pointer() relate to
 	SRCU just as they do to other forms of RCU.
 
-15.	The whole point of call_rcu(), synchronize_rcu(), and friends
+14.	The whole point of call_rcu(), synchronize_rcu(), and friends
 	is to wait until all pre-existing readers have finished before
 	carrying out some otherwise-destructive operation.  It is
 	therefore critically important to -first- remove any path
@@ -422,13 +399,13 @@ over a rather long period of time, but improvements are always welcome!
 	is the caller's responsibility to guarantee that any subsequent
 	readers will execute safely.
 
-16.	The various RCU read-side primitives do -not- necessarily contain
+15.	The various RCU read-side primitives do -not- necessarily contain
 	memory barriers.  You should therefore plan for the CPU
 	and the compiler to freely reorder code into and out of RCU
 	read-side critical sections.  It is the responsibility of the
 	RCU update-side primitives to deal with this.
 
-17.	Use CONFIG_PROVE_LOCKING, CONFIG_DEBUG_OBJECTS_RCU_HEAD, and the
+16.	Use CONFIG_PROVE_LOCKING, CONFIG_DEBUG_OBJECTS_RCU_HEAD, and the
 	__rcu sparse checks to validate your RCU code.	These can help
 	find problems as follows:
 
@@ -451,7 +428,7 @@ over a rather long period of time, but improvements are always welcome!
 	These debugging aids can help you find problems that are
 	otherwise extremely difficult to spot.
 
-18.	If you register a callback using call_rcu(), call_rcu_bh(),
+17.	If you register a callback using call_rcu(), call_rcu_bh(),
 	call_rcu_sched(), or call_srcu(), and pass in a function defined
 	within a loadable module, then it in necessary to wait for
 	all pending callbacks to be invoked after the last invocation
-- 
2.17.1

