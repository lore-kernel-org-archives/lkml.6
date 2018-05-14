Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1283123-1526326444-2-3868029976155318833
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526326443; b=VPfdHKPomUJmXD8QDJmFJlLNsm7Uem64IcPCWpRWwJaQUJeFgf
    vq/R/XxurgYfIVrgU4M2ksm3u6My0NKa3tL0vJxdaXTwglL24+n6D4AiyjM25t2x
    kU2wOvtvnBo8h3L3WMXmO4XhsxPduxv62pQm0NgvKouXDz/DNNvvJioBdHWF/9Dz
    64liQavskm0TTNHJnxL1xJpPAZt2Q2kLkaN7K4kjYhR/GM721OKphCjkq17TfOrQ
    RLlIwwtE2MXqqzlCvprgXgIf/M9mjNmvxTHO4Pt5EJ157kfNlzT2zE8Uvjp1JY6B
    AXEpEhnJxHZU8tluuMIhtLWD5/2OYvA5JvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526326443; bh=
    4JKPOTlCu0TvV9wZ5qvdJKLtHp8XDCOhcqft66W153g=; b=akJhUYfk0qEVYI5B
    2UaHofB6EQOhG+CF0yDVjt3FdyrJtXpDGxjnS8Ly35ifmwP3e+2aNDF/uVkqEAQg
    cYSTfdnQPCLaTPAg6UOl6itAKXOr78yce18C6xK3UWdY5mpGHtWgxsWHsIh3TD0C
    6nGYSh6hkYaeFplB3+k1/HNBiaLfkvNa7uzoGa3hks4zp4I1F9aJak6b2xhNAUN2
    j1rgQ+C5sKnGWorVEkf9UZyMYrWbMZLinw75P3tyHY926mpo8NIP6rHGvsaKdFiZ
    e2IvEpXJqSvqponvCBXI84ySLrca6v6nkieFfm3It3kHMtOlU5b9K0G/dXRvbYSW
    OrSd4g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGRCIzBnOBPnJSdQWt749Fl2myXY7JjGStMbW7dC6luFAdu0t7ZStWcYHx76Woti/SKsoYkxmICfxyoGwphMa2Ck9QSJg9KUuxBc/xdCtxppobi+7YUf
    IWUmdmlqlEk3Ku+nG2ZO5A3eD9kksMor9rsxoZs22RmznVKF//MS8IHT1+66PjmmmEOFnX1jld5M97TrIer4na7kSBYR4XBxWJa2qc38dbefIBBdA6OQyNQd
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=4CBHjKQC6pAkuscCNd4A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeENTd7 (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 15:33:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751855AbeENTdp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 May 2018 15:33:45 -0400
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Waiman Long <longman@redhat.com>
Subject: [RFC PATCH v2 1/2] locking/rwsem: Add a new RWSEM_WRITER_OWNED_NOSPIN flag
Date: Mon, 14 May 2018 15:31:06 -0400
Message-Id: <1526326267-22501-2-git-send-email-longman@redhat.com>
In-Reply-To: <1526326267-22501-1-git-send-email-longman@redhat.com>
References: <1526326267-22501-1-git-send-email-longman@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are use cases where a rwsem can be acquired by one task, but
released by another task. In thess cases, it may not be appropriate
for the lock waiters to spin on the task that acquires the lock.
One example will be the filesystem freeze/thaw code.

To handle such use cases, a new RWSEM_WRITER_OWNED_NOSPIN
flag can now be set in the owner field of the rwsem by the new
rwsem_set_writer_owned_nospin() function to indicate that the rwsem is
writer owned, but optimistic spinning on the rwsem should be disabled.

Later on, the new rwsem_set_writer_owned() function can be called to
set the new owner, if it is known. This function should not be called
without a prior rwsem_set_writer_owned_nospin() call.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/rwsem.h       | 10 ++++++++++
 kernel/locking/rwsem-xadd.c | 17 ++++++++---------
 kernel/locking/rwsem.c      | 16 +++++++++++++++-
 kernel/locking/rwsem.h      | 37 ++++++++++++++++++++++++++++++-------
 4 files changed, 63 insertions(+), 17 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 56707d5..1ddf24b 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -145,6 +145,16 @@ static inline int rwsem_is_contended(struct rw_semaphore *sem)
  */
 extern void downgrade_write(struct rw_semaphore *sem);
 
+#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
+extern void rwsem_set_writer_owned_nospin(struct rw_semaphore *sem);
+extern void rwsem_set_writer_owned(struct rw_semaphore *sem,
+				   struct task_struct *task);
+#else
+static inline void rwsem_set_writer_owned_nospin(struct rw_semaphore *sem) { }
+extern inline void rwsem_set_writer_owned(struct rw_semaphore *sem,
+					  struct task_struct *task) { }
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /*
  * nested locking. NOTE: rwsems are not allowed to recurse
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index e795908..a27dbb4 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -357,11 +357,8 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 
 	rcu_read_lock();
 	owner = READ_ONCE(sem->owner);
-	if (!rwsem_owner_is_writer(owner)) {
-		/*
-		 * Don't spin if the rwsem is readers owned.
-		 */
-		ret = !rwsem_owner_is_reader(owner);
+	if (!owner || !is_rwsem_owner_spinnable(owner)) {
+		ret = !owner;	/* !owner is spinnable */
 		goto done;
 	}
 
@@ -382,8 +379,10 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 {
 	struct task_struct *owner = READ_ONCE(sem->owner);
 
-	if (!rwsem_owner_is_writer(owner))
-		goto out;
+	if (!owner)
+		return true;
+	else if (!is_rwsem_owner_spinnable(owner))
+		return false;
 
 	rcu_read_lock();
 	while (sem->owner == owner) {
@@ -408,12 +407,12 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 		cpu_relax();
 	}
 	rcu_read_unlock();
-out:
+
 	/*
 	 * If there is a new owner or the owner is not set, we continue
 	 * spinning.
 	 */
-	return !rwsem_owner_is_reader(READ_ONCE(sem->owner));
+	return is_rwsem_owner_spinnable(READ_ONCE(sem->owner));
 }
 
 static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 30465a2..90e89ee 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -130,7 +130,8 @@ void up_read(struct rw_semaphore *sem)
 void up_write(struct rw_semaphore *sem)
 {
 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
-	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
+	DEBUG_RWSEMS_WARN_ON((sem->owner != current) &&
+			     (sem->owner != RWSEM_WRITER_OWNED_NOSPIN));
 
 	rwsem_clear_owner(sem);
 	__up_write(sem);
@@ -222,4 +223,17 @@ void up_read_non_owner(struct rw_semaphore *sem)
 
 #endif
 
+#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
+void rwsem_set_writer_owned_nospin(struct rw_semaphore *sem)
+{
+	__rwsem_set_writer_owned_nospin(sem);
+}
+EXPORT_SYMBOL(rwsem_set_writer_owned_nospin);
 
+void rwsem_set_writer_owned(struct rw_semaphore *sem, struct task_struct *task)
+{
+	DEBUG_RWSEMS_WARN_ON(sem->owner != RWSEM_WRITER_OWNED_NOSPIN);
+	__rwsem_set_writer_owned(sem, task);
+}
+EXPORT_SYMBOL(rwsem_set_writer_owned);
+#endif
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index a17cba8..bbbd5a3 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -11,10 +11,15 @@
  *  2) RWSEM_READER_OWNED
  *     - lock is currently or previously owned by readers (lock is free
  *       or not set by owner yet)
- *  3) Other non-zero value
- *     - a writer owns the lock
+ *  3) RWSEM_WRITER_OWNED_NOSPIN
+ *     - lock is owned by a writer whose lock ownership may be transfered to
+ *	 another task and so spinning on the lock owner should be disabled.
+ *  4) Other non-zero value
+ *     - a writer owns the lock and other writers can spin on the lock owner.
  */
-#define RWSEM_READER_OWNED	((struct task_struct *)1UL)
+#define RWSEM_READER_OWNED		((struct task_struct *)1UL)
+#define RWSEM_WRITER_OWNED_NOSPIN	((struct task_struct *)2UL)
+#define RWSEM_NOSPIN_MASK		3UL
 
 #ifdef CONFIG_DEBUG_RWSEMS
 # define DEBUG_RWSEMS_WARN_ON(c)	DEBUG_LOCKS_WARN_ON(c)
@@ -51,14 +56,32 @@ static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
 		WRITE_ONCE(sem->owner, RWSEM_READER_OWNED);
 }
 
-static inline bool rwsem_owner_is_writer(struct task_struct *owner)
+/*
+ * Mark the rwsem as writer owned, but optimistic spinning should be
+ * disabled.
+ *
+ * The caller must make sure that the rwsem is really writer owned
+ * and the lock won't be freed concurrently with this call.
+ */
+static inline void __rwsem_set_writer_owned_nospin(struct rw_semaphore *sem)
+{
+	WRITE_ONCE(sem->owner, RWSEM_WRITER_OWNED_NOSPIN);
+}
+
+static inline void __rwsem_set_writer_owned(struct rw_semaphore *sem,
+					    struct task_struct *task)
 {
-	return owner && owner != RWSEM_READER_OWNED;
+	WRITE_ONCE(sem->owner, task);
 }
 
-static inline bool rwsem_owner_is_reader(struct task_struct *owner)
+/*
+ * Return true if the a rwsem waiter can spin on the rwsem's owner
+ * and steal the lock.
+ * N.B. !owner is considered spinnable.
+ */
+static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
 {
-	return owner == RWSEM_READER_OWNED;
+	return !((unsigned long)owner & RWSEM_NOSPIN_MASK);
 }
 #else
 static inline void rwsem_set_owner(struct rw_semaphore *sem)
-- 
1.8.3.1
