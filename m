Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09594C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C862120851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C862120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeLKP1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:27:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55555 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeLKP1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:27:50 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFRIsH4041268
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:27:18 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFRIfM4041265;
        Tue, 11 Dec 2018 07:27:18 -0800
Date:   Tue, 11 Dec 2018 07:27:18 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-d35568bdb6ce4be3f885f8f189bbde5adc7e0160@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, sasha.levin@oracle.com,
        johannes@sipsolutions.net, torvalds@linux-foundation.org,
        bvanassche@acm.org, longman@redhat.com, hpa@zytor.com
Reply-To: longman@redhat.com, hpa@zytor.com, torvalds@linux-foundation.org,
          bvanassche@acm.org, johannes@sipsolutions.net,
          sasha.levin@oracle.com, tglx@linutronix.de, mingo@kernel.org,
          peterz@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20181207011148.251812-10-bvanassche@acm.org>
References: <20181207011148.251812-10-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Inline __lockdep_init_map()
Git-Commit-ID: d35568bdb6ce4be3f885f8f189bbde5adc7e0160
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

Commit-ID:  d35568bdb6ce4be3f885f8f189bbde5adc7e0160
Gitweb:     https://git.kernel.org/tip/d35568bdb6ce4be3f885f8f189bbde5adc7e0160
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 6 Dec 2018 17:11:33 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 14:54:51 +0100

locking/lockdep: Inline __lockdep_init_map()

Since the function __lockdep_init_map() only has one caller, inline it
into its caller. This patch does not change any functionality.

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
Link: https://lkml.kernel.org/r/20181207011148.251812-10-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 7434a00b2b2f..b5c8fcb6c070 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3091,7 +3091,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 /*
  * Initialize a lock instance's lock-class mapping info:
  */
-static void __lockdep_init_map(struct lockdep_map *lock, const char *name,
+void lockdep_init_map(struct lockdep_map *lock, const char *name,
 		      struct lock_class_key *key, int subclass)
 {
 	int i;
@@ -3147,12 +3147,6 @@ static void __lockdep_init_map(struct lockdep_map *lock, const char *name,
 		raw_local_irq_restore(flags);
 	}
 }
-
-void lockdep_init_map(struct lockdep_map *lock, const char *name,
-		      struct lock_class_key *key, int subclass)
-{
-	__lockdep_init_map(lock, name, key, subclass);
-}
 EXPORT_SYMBOL_GPL(lockdep_init_map);
 
 struct lock_class_key __lockdep_no_validate__;
