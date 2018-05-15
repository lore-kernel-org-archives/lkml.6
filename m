Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752347AbeEOG1L (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:27:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59197 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752148AbeEOG1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:27:10 -0400
Date: Mon, 14 May 2018 23:26:46 -0700
From: tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-1362ae43c503a4e333ab6948fc4c6e0e794e1558@git.kernel.org>
Cc: tglx@linutronix.de, peterz@infradead.org, will.deacon@arm.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        akpm@linux-foundation.org, andrea.parri@amarulasolutions.com,
        paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org
Reply-To: tglx@linutronix.de, peterz@infradead.org, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        andrea.parri@amarulasolutions.com, paulmck@linux.vnet.ibm.com
In-Reply-To: <1526338889-7003-3-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526338889-7003-3-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/spinlocks: Clean up comment and #ifndef
 for {,queued_}spin_is_locked()
Git-Commit-ID: 1362ae43c503a4e333ab6948fc4c6e0e794e1558
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1362ae43c503a4e333ab6948fc4c6e0e794e1558
Gitweb:     https://git.kernel.org/tip/1362ae43c503a4e333ab6948fc4c6e0e794e1558
Author:     Andrea Parri <andrea.parri@amarulasolutions.com>
AuthorDate: Mon, 14 May 2018 16:01:29 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:15 +0200

locking/spinlocks: Clean up comment and #ifndef for {,queued_}spin_is_locked()

Removes "#ifndef queued_spin_is_locked" from the generic code: this is
unused and it's reasonable to conclude that it will continue to be unused.

Also removes the comment about spin_is_locked() from mutex_is_locked():
the comment remains valid but not particularly useful.

Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: stern@rowland.harvard.edu
Link: http://lkml.kernel.org/r/1526338889-7003-3-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/asm-generic/qspinlock.h | 2 --
 include/linux/mutex.h           | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index a8ed0a352d75..9cc457597ddf 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -26,7 +26,6 @@
  * @lock: Pointer to queued spinlock structure
  * Return: 1 if it is locked, 0 otherwise
  */
-#ifndef queued_spin_is_locked
 static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
 {
 	/*
@@ -35,7 +34,6 @@ static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
 	 */
 	return atomic_read(&lock->val);
 }
-#endif
 
 /**
  * queued_spin_value_unlocked - is the spinlock structure unlocked?
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 14bc0d5d0ee5..3093dd162424 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -146,9 +146,6 @@ extern void __mutex_init(struct mutex *lock, const char *name,
  */
 static inline bool mutex_is_locked(struct mutex *lock)
 {
-	/*
-	 * XXX think about spin_is_locked
-	 */
 	return __mutex_owner(lock) != NULL;
 }
 
