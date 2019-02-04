Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02617C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C503C214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfBDI7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:59:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37791 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfBDI7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:59:17 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148wqC1358434
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:58:52 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148wqqc358431;
        Mon, 4 Feb 2019 00:58:52 -0800
Date:   Mon, 4 Feb 2019 00:58:52 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-412f34a82ccf7dd52f6b197f6450a33f03342523@git.kernel.org>
Cc:     bp@alien8.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@linux.vnet.ibm.com, hpa@zytor.com, james.morse@arm.com,
        longman@redhat.com, zhenzhong.duan@oracle.com, will.deacon@arm.com,
        mingo@kernel.org, akpm@linux-foundation.org,
        srinivas.eeda@oracle.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Reply-To: longman@redhat.com, mingo@kernel.org, will.deacon@arm.com,
          zhenzhong.duan@oracle.com, hpa@zytor.com, james.morse@arm.com,
          paulmck@linux.vnet.ibm.com, bp@alien8.de, peterz@infradead.org,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
          srinivas.eeda@oracle.com
In-Reply-To: <1548798828-16156-3-git-send-email-longman@redhat.com>
References: <1548798828-16156-3-git-send-email-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/qspinlock_stat: Track the no MCS node
 available case
Git-Commit-ID: 412f34a82ccf7dd52f6b197f6450a33f03342523
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  412f34a82ccf7dd52f6b197f6450a33f03342523
Gitweb:     https://git.kernel.org/tip/412f34a82ccf7dd52f6b197f6450a33f03342523
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Tue, 29 Jan 2019 22:53:46 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 09:03:30 +0100

locking/qspinlock_stat: Track the no MCS node available case

Track the number of slowpath locking operations that are being done
without any MCS node available as well renaming lock_index[123] to make
them more descriptive.

Using these stat counters is one way to find out if a code path is
being exercised.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: James Morse <james.morse@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: SRINIVAS <srinivas.eeda@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Link: https://lkml.kernel.org/r/1548798828-16156-3-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/qspinlock.c      |  3 ++-
 kernel/locking/qspinlock_stat.h | 21 +++++++++++++++------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 0875053c4050..21ee51b47961 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -422,6 +422,7 @@ pv_queue:
 	 * simple enough.
 	 */
 	if (unlikely(idx >= MAX_NODES)) {
+		qstat_inc(qstat_lock_no_node, true);
 		while (!queued_spin_trylock(lock))
 			cpu_relax();
 		goto release;
@@ -432,7 +433,7 @@ pv_queue:
 	/*
 	 * Keep counts of non-zero index values:
 	 */
-	qstat_inc(qstat_lock_idx1 + idx - 1, idx);
+	qstat_inc(qstat_lock_use_node2 + idx - 1, idx);
 
 	/*
 	 * Ensure that we increment the head node->count before initialising
diff --git a/kernel/locking/qspinlock_stat.h b/kernel/locking/qspinlock_stat.h
index 42d3d8dc8f49..d73f85388d5c 100644
--- a/kernel/locking/qspinlock_stat.h
+++ b/kernel/locking/qspinlock_stat.h
@@ -30,6 +30,13 @@
  *   pv_wait_node	- # of vCPU wait's at a non-head queue node
  *   lock_pending	- # of locking operations via pending code
  *   lock_slowpath	- # of locking operations via MCS lock queue
+ *   lock_use_node2	- # of locking operations that use 2nd per-CPU node
+ *   lock_use_node3	- # of locking operations that use 3rd per-CPU node
+ *   lock_use_node4	- # of locking operations that use 4th per-CPU node
+ *   lock_no_node	- # of locking operations without using per-CPU node
+ *
+ * Subtracting lock_use_node[234] from lock_slowpath will give you
+ * lock_use_node1.
  *
  * Writing to the "reset_counters" file will reset all the above counter
  * values.
@@ -55,9 +62,10 @@ enum qlock_stats {
 	qstat_pv_wait_node,
 	qstat_lock_pending,
 	qstat_lock_slowpath,
-	qstat_lock_idx1,
-	qstat_lock_idx2,
-	qstat_lock_idx3,
+	qstat_lock_use_node2,
+	qstat_lock_use_node3,
+	qstat_lock_use_node4,
+	qstat_lock_no_node,
 	qstat_num,	/* Total number of statistical counters */
 	qstat_reset_cnts = qstat_num,
 };
@@ -85,9 +93,10 @@ static const char * const qstat_names[qstat_num + 1] = {
 	[qstat_pv_wait_node]       = "pv_wait_node",
 	[qstat_lock_pending]       = "lock_pending",
 	[qstat_lock_slowpath]      = "lock_slowpath",
-	[qstat_lock_idx1]	   = "lock_index1",
-	[qstat_lock_idx2]	   = "lock_index2",
-	[qstat_lock_idx3]	   = "lock_index3",
+	[qstat_lock_use_node2]	   = "lock_use_node2",
+	[qstat_lock_use_node3]	   = "lock_use_node3",
+	[qstat_lock_use_node4]	   = "lock_use_node4",
+	[qstat_lock_no_node]	   = "lock_no_node",
 	[qstat_reset_cnts]         = "reset_counters",
 };
 
