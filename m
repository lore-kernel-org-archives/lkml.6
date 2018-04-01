Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753853AbeDAQnG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 12:43:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40393 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbeDAQnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 12:43:04 -0400
X-Google-Smtp-Source: AIpwx4+Z33DQK1EovgCc3Zi26C3PVUZBjyz7iZU8v0DToOCp0QwJnKgHrALk7BCFAZmgnJK4v4bSEQ==
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: paulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v3 3/3] locking: Clean up comment and #ifndef for {,queued_}spin_is_locked()
Date: Sun,  1 Apr 2018 18:41:52 +0200
Message-Id: <1522600912-6208-4-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522600912-6208-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1522600912-6208-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes "#ifndef queued_spin_is_locked" from the generic code: this is
unused and it's reasonable to conclude that it won't in a near future.

Also removes the comment about spin_is_locked() from mutex_is_locked():
the comment remains valid but not particularly useful.

Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/asm-generic/qspinlock.h | 2 --
 include/linux/mutex.h           | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index b37b4ad7eb946..dc4e4ac4937ea 100644
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
index 14bc0d5d0ee59..3093dd1624243 100644
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
 
-- 
2.7.4
