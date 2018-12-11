Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9100FC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EB720851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50EB720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeLKP0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:26:40 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38747 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeLKP0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:26:39 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFQ78s4040955
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:26:07 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFQ60S4040952;
        Tue, 11 Dec 2018 07:26:06 -0800
Date:   Tue, 11 Dec 2018 07:26:06 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-886adbed7ac19352315e9f1dd880360c7544d25c@git.kernel.org>
Cc:     johannes@sipsolutions.net, sasha.levin@oracle.com,
        tglx@linutronix.de, bvanassche@acm.org, mingo@kernel.org,
        longman@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, torvalds@linux-foundation.org
Reply-To: johannes@sipsolutions.net, sasha.levin@oracle.com,
          tglx@linutronix.de, bvanassche@acm.org, mingo@kernel.org,
          longman@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
          peterz@infradead.org, torvalds@linux-foundation.org
In-Reply-To: <20181207011148.251812-8-bvanassche@acm.org>
References: <20181207011148.251812-8-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/lib/lockdep/tests: Test the
 lockdep_reset_lock() implementation
Git-Commit-ID: 886adbed7ac19352315e9f1dd880360c7544d25c
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

Commit-ID:  886adbed7ac19352315e9f1dd880360c7544d25c
Gitweb:     https://git.kernel.org/tip/886adbed7ac19352315e9f1dd880360c7544d25c
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 6 Dec 2018 17:11:31 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 14:54:51 +0100

tools/lib/lockdep/tests: Test the lockdep_reset_lock() implementation

This patch makes sure that the lockdep_reset_lock() function gets
tested.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <sasha.levin@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: johannes.berg@intel.com
Cc: tj@kernel.org
Link: https://lkml.kernel.org/r/20181207011148.251812-8-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/lib/lockdep/include/liblockdep/common.h | 1 +
 tools/lib/lockdep/include/liblockdep/mutex.h  | 1 +
 tools/lib/lockdep/tests/ABBA.c                | 3 +++
 tools/lib/lockdep/tests/ABBCCA.c              | 4 ++++
 tools/lib/lockdep/tests/ABBCCDDA.c            | 5 +++++
 tools/lib/lockdep/tests/ABCABC.c              | 4 ++++
 tools/lib/lockdep/tests/ABCDBCDA.c            | 5 +++++
 tools/lib/lockdep/tests/ABCDBDDA.c            | 5 +++++
 tools/lib/lockdep/tests/unlock_balance.c      | 2 ++
 9 files changed, 30 insertions(+)

diff --git a/tools/lib/lockdep/include/liblockdep/common.h b/tools/lib/lockdep/include/liblockdep/common.h
index 8862da80995a..d640a9761f09 100644
--- a/tools/lib/lockdep/include/liblockdep/common.h
+++ b/tools/lib/lockdep/include/liblockdep/common.h
@@ -44,6 +44,7 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 			struct lockdep_map *nest_lock, unsigned long ip);
 void lock_release(struct lockdep_map *lock, int nested,
 			unsigned long ip);
+void lockdep_reset_lock(struct lockdep_map *lock);
 extern void debug_check_no_locks_freed(const void *from, unsigned long len);
 
 #define STATIC_LOCKDEP_MAP_INIT(_name, _key) \
diff --git a/tools/lib/lockdep/include/liblockdep/mutex.h b/tools/lib/lockdep/include/liblockdep/mutex.h
index a80ac39f966e..2073d4e1f2f0 100644
--- a/tools/lib/lockdep/include/liblockdep/mutex.h
+++ b/tools/lib/lockdep/include/liblockdep/mutex.h
@@ -54,6 +54,7 @@ static inline int liblockdep_pthread_mutex_trylock(liblockdep_pthread_mutex_t *l
 
 static inline int liblockdep_pthread_mutex_destroy(liblockdep_pthread_mutex_t *lock)
 {
+	lockdep_reset_lock(&lock->dep_map);
 	return pthread_mutex_destroy(&lock->mutex);
 }
 
diff --git a/tools/lib/lockdep/tests/ABBA.c b/tools/lib/lockdep/tests/ABBA.c
index 1460afd33d71..623313f54720 100644
--- a/tools/lib/lockdep/tests/ABBA.c
+++ b/tools/lib/lockdep/tests/ABBA.c
@@ -11,4 +11,7 @@ void main(void)
 
 	LOCK_UNLOCK_2(a, b);
 	LOCK_UNLOCK_2(b, a);
+
+	pthread_mutex_destroy(&b);
+	pthread_mutex_destroy(&a);
 }
diff --git a/tools/lib/lockdep/tests/ABBCCA.c b/tools/lib/lockdep/tests/ABBCCA.c
index a54c1b2af118..48446129d496 100644
--- a/tools/lib/lockdep/tests/ABBCCA.c
+++ b/tools/lib/lockdep/tests/ABBCCA.c
@@ -13,4 +13,8 @@ void main(void)
 	LOCK_UNLOCK_2(a, b);
 	LOCK_UNLOCK_2(b, c);
 	LOCK_UNLOCK_2(c, a);
+
+	pthread_mutex_destroy(&c);
+	pthread_mutex_destroy(&b);
+	pthread_mutex_destroy(&a);
 }
diff --git a/tools/lib/lockdep/tests/ABBCCDDA.c b/tools/lib/lockdep/tests/ABBCCDDA.c
index aa5d194e8869..3570bf7b3804 100644
--- a/tools/lib/lockdep/tests/ABBCCDDA.c
+++ b/tools/lib/lockdep/tests/ABBCCDDA.c
@@ -15,4 +15,9 @@ void main(void)
 	LOCK_UNLOCK_2(b, c);
 	LOCK_UNLOCK_2(c, d);
 	LOCK_UNLOCK_2(d, a);
+
+	pthread_mutex_destroy(&d);
+	pthread_mutex_destroy(&c);
+	pthread_mutex_destroy(&b);
+	pthread_mutex_destroy(&a);
 }
diff --git a/tools/lib/lockdep/tests/ABCABC.c b/tools/lib/lockdep/tests/ABCABC.c
index b54a08e60416..a1c4659894cd 100644
--- a/tools/lib/lockdep/tests/ABCABC.c
+++ b/tools/lib/lockdep/tests/ABCABC.c
@@ -13,4 +13,8 @@ void main(void)
 	LOCK_UNLOCK_2(a, b);
 	LOCK_UNLOCK_2(c, a);
 	LOCK_UNLOCK_2(b, c);
+
+	pthread_mutex_destroy(&c);
+	pthread_mutex_destroy(&b);
+	pthread_mutex_destroy(&a);
 }
diff --git a/tools/lib/lockdep/tests/ABCDBCDA.c b/tools/lib/lockdep/tests/ABCDBCDA.c
index a56742250d86..335af1c90ab5 100644
--- a/tools/lib/lockdep/tests/ABCDBCDA.c
+++ b/tools/lib/lockdep/tests/ABCDBCDA.c
@@ -15,4 +15,9 @@ void main(void)
 	LOCK_UNLOCK_2(c, d);
 	LOCK_UNLOCK_2(b, c);
 	LOCK_UNLOCK_2(d, a);
+
+	pthread_mutex_destroy(&d);
+	pthread_mutex_destroy(&c);
+	pthread_mutex_destroy(&b);
+	pthread_mutex_destroy(&a);
 }
diff --git a/tools/lib/lockdep/tests/ABCDBDDA.c b/tools/lib/lockdep/tests/ABCDBDDA.c
index 238a3353f3c3..3c5972863049 100644
--- a/tools/lib/lockdep/tests/ABCDBDDA.c
+++ b/tools/lib/lockdep/tests/ABCDBDDA.c
@@ -15,4 +15,9 @@ void main(void)
 	LOCK_UNLOCK_2(c, d);
 	LOCK_UNLOCK_2(b, d);
 	LOCK_UNLOCK_2(d, a);
+
+	pthread_mutex_destroy(&d);
+	pthread_mutex_destroy(&c);
+	pthread_mutex_destroy(&b);
+	pthread_mutex_destroy(&a);
 }
diff --git a/tools/lib/lockdep/tests/unlock_balance.c b/tools/lib/lockdep/tests/unlock_balance.c
index 34cf32f689de..dba25064b50a 100644
--- a/tools/lib/lockdep/tests/unlock_balance.c
+++ b/tools/lib/lockdep/tests/unlock_balance.c
@@ -10,4 +10,6 @@ void main(void)
 	pthread_mutex_lock(&a);
 	pthread_mutex_unlock(&a);
 	pthread_mutex_unlock(&a);
+
+	pthread_mutex_destroy(&a);
 }
