Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FF3C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584FE205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584FE205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeJPX41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:56:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36749 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJPX41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:56:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9GG4xuq4158679
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 16 Oct 2018 09:04:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9GG4xDC4158676;
        Tue, 16 Oct 2018 09:04:59 -0700
Date:   Tue, 16 Oct 2018 09:04:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-756b1df4c2c82a1cdffeafa9d2aa76c92e7fb405@git.kernel.org>
Cc:     peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        will.deacon@arm.com, mingo@kernel.org
Reply-To: will.deacon@arm.com, torvalds@linux-foundation.org,
          mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20181003130257.156322446@infradead.org>
References: <20181003130257.156322446@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/qspinlock: Rework some comments
Git-Commit-ID: 756b1df4c2c82a1cdffeafa9d2aa76c92e7fb405
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

Commit-ID:  756b1df4c2c82a1cdffeafa9d2aa76c92e7fb405
Gitweb:     https://git.kernel.org/tip/756b1df4c2c82a1cdffeafa9d2aa76c92e7fb405
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 26 Sep 2018 13:01:19 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Oct 2018 17:33:54 +0200

locking/qspinlock: Rework some comments

While working my way through the code again; I felt the comments could
use help.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: andrea.parri@amarulasolutions.com
Cc: longman@redhat.com
Link: https://lkml.kernel.org/r/20181003130257.156322446@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/qspinlock.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index ec343276f975..47cb99787e4d 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -326,16 +326,23 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	/*
 	 * trylock || pending
 	 *
-	 * 0,0,0 -> 0,0,1 ; trylock
-	 * 0,0,1 -> 0,1,1 ; pending
+	 * 0,0,* -> 0,1,* -> 0,0,1 pending, trylock
 	 */
 	val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
+
 	/*
-	 * If we observe any contention; undo and queue.
+	 * If we observe contention, there is a concurrent locker.
+	 *
+	 * Undo and queue; our setting of PENDING might have made the
+	 * n,0,0 -> 0,0,0 transition fail and it will now be waiting
+	 * on @next to become !NULL.
 	 */
 	if (unlikely(val & ~_Q_LOCKED_MASK)) {
+
+		/* Undo PENDING if we set it. */
 		if (!(val & _Q_PENDING_MASK))
 			clear_pending(lock);
+
 		goto queue;
 	}
 
@@ -474,16 +481,25 @@ locked:
 	 */
 
 	/*
-	 * In the PV case we might already have _Q_LOCKED_VAL set.
+	 * In the PV case we might already have _Q_LOCKED_VAL set, because
+	 * of lock stealing; therefore we must also allow:
 	 *
-	 * The atomic_cond_read_acquire() call above has provided the
-	 * necessary acquire semantics required for locking.
+	 * n,0,1 -> 0,0,1
+	 *
+	 * Note: at this point: (val & _Q_PENDING_MASK) == 0, because of the
+	 *       above wait condition, therefore any concurrent setting of
+	 *       PENDING will make the uncontended transition fail.
 	 */
-	if (((val & _Q_TAIL_MASK) == tail) &&
-	    atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
-		goto release; /* No contention */
+	if ((val & _Q_TAIL_MASK) == tail) {
+		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
+			goto release; /* No contention */
+	}
 
-	/* Either somebody is queued behind us or _Q_PENDING_VAL is set */
+	/*
+	 * Either somebody is queued behind us or _Q_PENDING_VAL got set
+	 * which will then detect the remaining tail and queue behind us
+	 * ensuring we'll see a @next.
+	 */
 	set_locked(lock);
 
 	/*
