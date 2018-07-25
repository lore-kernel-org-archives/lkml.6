Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82F9C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAB320843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DAB320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbeGYPbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:31:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43019 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbeGYPbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:31:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEJ1Cx399782
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:19:01 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEIxnP399779;
        Wed, 25 Jul 2018 07:18:59 -0700
Date:   Wed, 25 Jul 2018 07:18:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Rosin <tipbot@zytor.com>
Message-ID: <tip-62cedf3e60af03e47849fe2bd6a03ec179422a8a@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, peda@axentia.se,
        mingo@kernel.org, gregkh@linuxfoundation.org, will.deacon@arm.com,
        wsa@the-dreams.de, deepadinamani@google.com, dave@stgolabs.net,
        peterz@infradead.org, torvalds@linux-foundation.org,
        jsperbeck@google.com, hpa@zytor.com, dpf@google.com,
        pombredanne@nexb.com
Reply-To: wsa@the-dreams.de, will.deacon@arm.com,
          gregkh@linuxfoundation.org, mingo@kernel.org, peda@axentia.se,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, dpf@google.com,
          pombredanne@nexb.com, hpa@zytor.com, jsperbeck@google.com,
          torvalds@linux-foundation.org, peterz@infradead.org,
          dave@stgolabs.net, deepadinamani@google.com
In-Reply-To: <20180720083914.1950-2-peda@axentia.se>
References: <20180720083914.1950-2-peda@axentia.se>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/rtmutex: Allow specifying a subclass
 for nested locking
Git-Commit-ID: 62cedf3e60af03e47849fe2bd6a03ec179422a8a
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

Commit-ID:  62cedf3e60af03e47849fe2bd6a03ec179422a8a
Gitweb:     https://git.kernel.org/tip/62cedf3e60af03e47849fe2bd6a03ec179422a8a
Author:     Peter Rosin <peda@axentia.se>
AuthorDate: Fri, 20 Jul 2018 10:39:13 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:22:19 +0200

locking/rtmutex: Allow specifying a subclass for nested locking

Needed for annotating rt_mutex locks.

Tested-by: John Sperbeck <jsperbeck@google.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Deepa Dinamani <deepadinamani@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Chang <dpf@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Link: http://lkml.kernel.org/r/20180720083914.1950-2-peda@axentia.se
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/rtmutex.h  |  7 +++++++
 kernel/locking/rtmutex.c | 29 +++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 1b92a28dd672..6fd615a0eea9 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -106,7 +106,14 @@ static inline int rt_mutex_is_locked(struct rt_mutex *lock)
 extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
 extern void rt_mutex_destroy(struct rt_mutex *lock);
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+extern void rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass);
+#define rt_mutex_lock(lock) rt_mutex_lock_nested(lock, 0)
+#else
 extern void rt_mutex_lock(struct rt_mutex *lock);
+#define rt_mutex_lock_nested(lock, subclass) rt_mutex_lock(lock)
+#endif
+
 extern int rt_mutex_lock_interruptible(struct rt_mutex *lock);
 extern int rt_mutex_timed_lock(struct rt_mutex *lock,
 			       struct hrtimer_sleeper *timeout);
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4f014be7a4b8..2823d4163a37 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1465,6 +1465,29 @@ rt_mutex_fastunlock(struct rt_mutex *lock,
 		rt_mutex_postunlock(&wake_q);
 }
 
+static inline void __rt_mutex_lock(struct rt_mutex *lock, unsigned int subclass)
+{
+	might_sleep();
+
+	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, rt_mutex_slowlock);
+}
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+/**
+ * rt_mutex_lock_nested - lock a rt_mutex
+ *
+ * @lock: the rt_mutex to be locked
+ * @subclass: the lockdep subclass
+ */
+void __sched rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass)
+{
+	__rt_mutex_lock(lock, subclass);
+}
+EXPORT_SYMBOL_GPL(rt_mutex_lock_nested);
+#endif
+
+#ifndef CONFIG_DEBUG_LOCK_ALLOC
 /**
  * rt_mutex_lock - lock a rt_mutex
  *
@@ -1472,12 +1495,10 @@ rt_mutex_fastunlock(struct rt_mutex *lock,
  */
 void __sched rt_mutex_lock(struct rt_mutex *lock)
 {
-	might_sleep();
-
-	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, rt_mutex_slowlock);
+	__rt_mutex_lock(lock, 0);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock);
+#endif
 
 /**
  * rt_mutex_lock_interruptible - lock a rt_mutex interruptible
