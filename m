Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77F9C7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF7020861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfAULcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:32:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50117 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfAULcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:32:16 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LBVxJW2496701
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 03:32:00 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LBVxBb2496698;
        Mon, 21 Jan 2019 03:31:59 -0800
Date:   Mon, 21 Jan 2019 03:31:59 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-bba2a8f1f974a45ca6ceaf688b2be7bc1c418a2f@git.kernel.org>
Cc:     mingo@kernel.org, will.deacon@arm.com, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, frederic@kernel.org, akpm@linux-foundation.org
Reply-To: paulmck@linux.vnet.ibm.com, tglx@linutronix.de, mingo@kernel.org,
          will.deacon@arm.com, torvalds@linux-foundation.org,
          peterz@infradead.org, akpm@linux-foundation.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, frederic@kernel.org
In-Reply-To: <1545973321-24422-3-git-send-email-frederic@kernel.org>
References: <1545973321-24422-3-git-send-email-frederic@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Provide enum lock_usage_bit
 mask names
Git-Commit-ID: bba2a8f1f974a45ca6ceaf688b2be7bc1c418a2f
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

Commit-ID:  bba2a8f1f974a45ca6ceaf688b2be7bc1c418a2f
Gitweb:     https://git.kernel.org/tip/bba2a8f1f974a45ca6ceaf688b2be7bc1c418a2f
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Fri, 28 Dec 2018 06:02:01 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 11:18:56 +0100

locking/lockdep: Provide enum lock_usage_bit mask names

It makes the code more self-explanatory and tells throughout the code
what magic number refers to:

 - state (Hardirq/Softirq)
 - direction (used in or enabled above state)
 - read or write

We can even remove some comments that were compensating for the lack of
those constant names.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/r/1545973321-24422-3-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c           | 33 +++++++++++----------------------
 kernel/locking/lockdep_internals.h |  4 ++++
 2 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1dcd8341e35b..608f74ed8bb9 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1624,29 +1624,18 @@ static const char *state_rnames[] = {
 
 static inline const char *state_name(enum lock_usage_bit bit)
 {
-	return (bit & 1) ? state_rnames[bit >> 2] : state_names[bit >> 2];
+	return (bit & LOCK_USAGE_READ_MASK) ? state_rnames[bit >> 2] : state_names[bit >> 2];
 }
 
 static int exclusive_bit(int new_bit)
 {
-	/*
-	 * USED_IN
-	 * USED_IN_READ
-	 * ENABLED
-	 * ENABLED_READ
-	 *
-	 * bit 0 - write/read
-	 * bit 1 - used_in/enabled
-	 * bit 2+  state
-	 */
-
-	int state = new_bit & ~3;
-	int dir = new_bit & 2;
+	int state = new_bit & LOCK_USAGE_STATE_MASK;
+	int dir = new_bit & LOCK_USAGE_DIR_MASK;
 
 	/*
 	 * keep state, bit flip the direction and strip read.
 	 */
-	return state | (dir ^ 2);
+	return state | (dir ^ LOCK_USAGE_DIR_MASK);
 }
 
 static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
@@ -2662,8 +2651,8 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 		enum lock_usage_bit new_bit)
 {
 	int excl_bit = exclusive_bit(new_bit);
-	int read = new_bit & 1;
-	int dir = new_bit & 2;
+	int read = new_bit & LOCK_USAGE_READ_MASK;
+	int dir = new_bit & LOCK_USAGE_DIR_MASK;
 
 	/*
 	 * mark USED_IN has to look forwards -- to ensure no dependency
@@ -2687,19 +2676,19 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	 * states.
 	 */
 	if ((!read || !dir || STRICT_READ_CHECKS) &&
-			!usage(curr, this, excl_bit, state_name(new_bit & ~1)))
+			!usage(curr, this, excl_bit, state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
 		return 0;
 
 	/*
 	 * Check for read in write conflicts
 	 */
 	if (!read) {
-		if (!valid_state(curr, this, new_bit, excl_bit + 1))
+		if (!valid_state(curr, this, new_bit, excl_bit + LOCK_USAGE_READ_MASK))
 			return 0;
 
 		if (STRICT_READ_CHECKS &&
-			!usage(curr, this, excl_bit + 1,
-				state_name(new_bit + 1)))
+			!usage(curr, this, excl_bit + LOCK_USAGE_READ_MASK,
+				state_name(new_bit + LOCK_USAGE_READ_MASK)))
 			return 0;
 	}
 
@@ -2723,7 +2712,7 @@ mark_held_locks(struct task_struct *curr, enum lock_usage_bit base_bit)
 		hlock = curr->held_locks + i;
 
 		if (hlock->read)
-			hlock_bit += 1; /* READ */
+			hlock_bit += LOCK_USAGE_READ_MASK;
 
 		BUG_ON(hlock_bit >= LOCK_USAGE_STATES);
 
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 88c847a41c8a..2ebb9d0ea91c 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -22,6 +22,10 @@ enum lock_usage_bit {
 	LOCK_USAGE_STATES
 };
 
+#define LOCK_USAGE_READ_MASK 1
+#define LOCK_USAGE_DIR_MASK  2
+#define LOCK_USAGE_STATE_MASK (~(LOCK_USAGE_READ_MASK | LOCK_USAGE_DIR_MASK))
+
 /*
  * Usage-state bitmasks:
  */
