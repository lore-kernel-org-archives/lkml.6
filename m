Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3322034-1526421043-2-1965052596035148389
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526421042; b=hfkKK8JNa3h+ddZTyIc7OZiFTZD+4aqYuMVv+mDMSvzY73DP0U
    Hbh7jLYMZ6eu6T2uvHAJynEIqoQIhPsFXwxTjeWu2h3EMawIifN+8KlbsgsTGDvw
    DM9RRAg5kqlG2wsfzehCK2FU/4lPuMf8/S6txAG66zJErrsbe2Cs2vXWVNiVqvh2
    iqtNllhnjI3p6oVMCRPU6co62CeBldHEejaa0PKB5XlM8MMFnl2lEsmRXtpHMwhf
    yoAaVAnPOd8yv+A829N5OF4OZODSovQJfGVS+Tz5e1HftT343i7bW6DxFCX+qIbT
    /rIyDB6U+eKaY0fzg2MyUhrm6a+GKqnRGSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526421042; bh=
    vV0mxsOxAuWLJvJB/yWbfKHmslKOnsFHRh08+gb8dy4=; b=UjBy1qdsOSWQMNEt
    mgS0Txz7hEJKkZc91Lm6RDK2bJQKZejR/7Bjwl3V80LQWRGFnX5/kj7Nbe17apu3
    2JhY1cMSrn/FNQ4BU3kN510nChkhWf3GTlVTiY3wbbcdDJcs/YEU6tb/Nu1EWEbr
    exsgZL5cL3WJReqsO1O9eovYQAdBOZnvF9jLMma3JkLNa7MOGgZAlmT2uMhxcDz+
    XLRG5i2oBF4jkpEBm6gXLJ2RaUQi7KacyDVeR4bLfdk1yqazfep/8R+bLnCaDhFK
    k3xitEQjDzLRrZs86g8ICfXW2t2jqFOPBochdBkNM3rmvlG+HiBgzsbnEsM8e/Xx
    A4/XcA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfF4QCAuw1czbexbJmr5BbYeOzEtqXmKDUfnJ9mzXRI+ZCWt3sp+IJpF1k0ygndHAzUV3jTtq2B45ZXInO4JHW+F0bYyPOhGPiMYhRSk3UENEuMScO4uH
    /LwlLIB+Qa3TZrRMORdJV/wptWmLXen50B6tW328uKCpmJcPamkdJoIuizM4MrAcghInZNBVMiFJo/ZrzYnQLCyDIJeQr7c9Cw6Mo8hkakwB6rziJFSXAD4q
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=9n50GB4xyT7VpKlAsUUA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbeEOVuj (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 17:50:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751578AbeEOVuE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 May 2018 17:50:04 -0400
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 1/2] locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED flag
Date: Tue, 15 May 2018 17:49:50 -0400
Message-Id: <1526420991-21213-2-git-send-email-longman@redhat.com>
In-Reply-To: <1526420991-21213-1-git-send-email-longman@redhat.com>
References: <1526420991-21213-1-git-send-email-longman@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are use cases where a rwsem can be acquired by one task, but
released by another task. In thess cases, optimistic spinning may need
to be disabled.  One example will be the filesystem freeze/thaw code
where the task that freezes the filesystem will acquire a write lock
on a rwsem and then un-owns it before returning to userspace. Later on,
another task will come along, acquire the ownership, thaw the filesystem
and release the rwsem.

Bit 0 of the owner field was used to designate that it is a reader
owned rwsem. It is now repurposed to mean that the owner of the rwsem
is not known. If only bit 0 is set, the rwsem is reader owned. If bit
0 and other bits are set, it is writer owned with an unknown owner.
One such value for the latter case is (-1L). So we can set owner to 1 for
reader-owned, -1 for writer-owned. The owner is unknown in both cases.

To handle transfer of rwsem ownership, the higher level code should
set the owner field to -1 to indicate a write-locked rwsem with unknown
owner.  Optimistic spinning will be disabled in this case.

Once the higher level code figures who the new owner is, it can then
set the owner field accordingly.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 17 +++++++----------
 kernel/locking/rwsem.c      |  2 --
 kernel/locking/rwsem.h      | 30 +++++++++++++++++++++---------
 3 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index e795908..604d247 100644
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
 
@@ -382,11 +379,11 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 {
 	struct task_struct *owner = READ_ONCE(sem->owner);
 
-	if (!rwsem_owner_is_writer(owner))
-		goto out;
+	if (!is_rwsem_owner_spinnable(owner))
+		return false;
 
 	rcu_read_lock();
-	while (sem->owner == owner) {
+	while (owner && (READ_ONCE(sem->owner) == owner)) {
 		/*
 		 * Ensure we emit the owner->on_cpu, dereference _after_
 		 * checking sem->owner still matches owner, if that fails,
@@ -408,12 +405,12 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
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
index 30465a2..bc1e507 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -221,5 +221,3 @@ void up_read_non_owner(struct rw_semaphore *sem)
 EXPORT_SYMBOL(up_read_non_owner);
 
 #endif
-
-
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index a17cba8..b9d0e72 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -1,20 +1,24 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * The owner field of the rw_semaphore structure will be set to
- * RWSEM_READ_OWNED when a reader grabs the lock. A writer will clear
+ * RWSEM_READER_OWNED when a reader grabs the lock. A writer will clear
  * the owner field when it unlocks. A reader, on the other hand, will
  * not touch the owner field when it unlocks.
  *
- * In essence, the owner field now has the following 3 states:
+ * In essence, the owner field now has the following 4 states:
  *  1) 0
  *     - lock is free or the owner hasn't set the field yet
  *  2) RWSEM_READER_OWNED
  *     - lock is currently or previously owned by readers (lock is free
  *       or not set by owner yet)
- *  3) Other non-zero value
- *     - a writer owns the lock
+ *  3) RWSEM_ANONYMOUSLY_OWNED bit set with some other bits set as well
+ *     - lock is owned by an anonymous writer, so spinning on the lock
+ *       owner should be disabled.
+ *  4) Other non-zero value
+ *     - a writer owns the lock and other writers can spin on the lock owner.
  */
-#define RWSEM_READER_OWNED	((struct task_struct *)1UL)
+#define RWSEM_ANONYMOUSLY_OWNED	(1UL << 0)
+#define RWSEM_READER_OWNED	((struct task_struct *)RWSEM_ANONYMOUSLY_OWNED)
 
 #ifdef CONFIG_DEBUG_RWSEMS
 # define DEBUG_RWSEMS_WARN_ON(c)	DEBUG_LOCKS_WARN_ON(c)
@@ -51,14 +55,22 @@ static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
 		WRITE_ONCE(sem->owner, RWSEM_READER_OWNED);
 }
 
-static inline bool rwsem_owner_is_writer(struct task_struct *owner)
+/*
+ * Return true if the a rwsem waiter can spin on the rwsem's owner
+ * and steal the lock, i.e. the lock is not anonymously owned.
+ * N.B. !owner is considered spinnable.
+ */
+static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
 {
-	return owner && owner != RWSEM_READER_OWNED;
+	return !((unsigned long)owner & RWSEM_ANONYMOUSLY_OWNED);
 }
 
-static inline bool rwsem_owner_is_reader(struct task_struct *owner)
+/*
+ * Return true if rwsem is owned by an anonymous writer or readers.
+ */
+static inline bool rwsem_has_anonymous_owner(struct task_struct *owner)
 {
-	return owner == RWSEM_READER_OWNED;
+	return (unsigned long)owner & RWSEM_ANONYMOUSLY_OWNED;
 }
 #else
 static inline void rwsem_set_owner(struct rw_semaphore *sem)
-- 
1.8.3.1
