Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABA8C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1BB20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1BB20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeLKPZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:25:33 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49841 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeLKPZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:25:33 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFOvfX4040792
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:24:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFOvZu4040789;
        Tue, 11 Dec 2018 07:24:57 -0800
Date:   Tue, 11 Dec 2018 07:24:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-7f3c7952d111ac93573fb86f4d5aeff527a07fcc@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, sashal@kernel.org,
        tglx@linutronix.de, longman@redhat.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        sasha.levin@oracle.com, johannes@sipsolutions.net,
        bvanassche@acm.org, hpa@zytor.com
Reply-To: johannes@sipsolutions.net, sasha.levin@oracle.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, bvanassche@acm.org,
          tglx@linutronix.de, sashal@kernel.org, peterz@infradead.org,
          mingo@kernel.org, torvalds@linux-foundation.org,
          longman@redhat.com
In-Reply-To: <20181207011148.251812-6-bvanassche@acm.org>
References: <20181207011148.251812-6-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/lib/lockdep: Rename "trywlock" into
 "trywrlock"
Git-Commit-ID: 7f3c7952d111ac93573fb86f4d5aeff527a07fcc
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

Commit-ID:  7f3c7952d111ac93573fb86f4d5aeff527a07fcc
Gitweb:     https://git.kernel.org/tip/7f3c7952d111ac93573fb86f4d5aeff527a07fcc
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 6 Dec 2018 17:11:29 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 14:54:50 +0100

tools/lib/lockdep: Rename "trywlock" into "trywrlock"

This patch avoids that the following compiler warning is reported while
compiling the lockdep unit tests:

include/liblockdep/rwlock.h: In function 'liblockdep_pthread_rwlock_trywlock':
include/liblockdep/rwlock.h:66:9: warning: implicit declaration of function 'pthread_rwlock_trywlock'; did you mean 'pthread_rwlock_trywrlock'? [-Wimplicit-function-declaration]
  return pthread_rwlock_trywlock(&lock->rwlock) == 0 ? 1 : 0;
         ^~~~~~~~~~~~~~~~~~~~~~~
         pthread_rwlock_trywrlock

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <sasha.levin@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: johannes.berg@intel.com
Cc: tj@kernel.org
Fixes: 5a52c9b480e0 ("liblockdep: Add public headers for pthread_rwlock_t implementation")
Link: https://lkml.kernel.org/r/20181207011148.251812-6-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/lib/lockdep/include/liblockdep/rwlock.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/lockdep/include/liblockdep/rwlock.h b/tools/lib/lockdep/include/liblockdep/rwlock.h
index a96c3bf0fef1..365762e3a1ea 100644
--- a/tools/lib/lockdep/include/liblockdep/rwlock.h
+++ b/tools/lib/lockdep/include/liblockdep/rwlock.h
@@ -60,10 +60,10 @@ static inline int liblockdep_pthread_rwlock_tryrdlock(liblockdep_pthread_rwlock_
 	return pthread_rwlock_tryrdlock(&lock->rwlock) == 0 ? 1 : 0;
 }
 
-static inline int liblockdep_pthread_rwlock_trywlock(liblockdep_pthread_rwlock_t *lock)
+static inline int liblockdep_pthread_rwlock_trywrlock(liblockdep_pthread_rwlock_t *lock)
 {
 	lock_acquire(&lock->dep_map, 0, 1, 0, 1, NULL, (unsigned long)_RET_IP_);
-	return pthread_rwlock_trywlock(&lock->rwlock) == 0 ? 1 : 0;
+	return pthread_rwlock_trywrlock(&lock->rwlock) == 0 ? 1 : 0;
 }
 
 static inline int liblockdep_rwlock_destroy(liblockdep_pthread_rwlock_t *lock)
@@ -79,7 +79,7 @@ static inline int liblockdep_rwlock_destroy(liblockdep_pthread_rwlock_t *lock)
 #define pthread_rwlock_unlock		liblockdep_pthread_rwlock_unlock
 #define pthread_rwlock_wrlock		liblockdep_pthread_rwlock_wrlock
 #define pthread_rwlock_tryrdlock	liblockdep_pthread_rwlock_tryrdlock
-#define pthread_rwlock_trywlock		liblockdep_pthread_rwlock_trywlock
+#define pthread_rwlock_trywrlock	liblockdep_pthread_rwlock_trywrlock
 #define pthread_rwlock_destroy		liblockdep_rwlock_destroy
 
 #endif
