Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7C2C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D02820849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D02820849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeLKP2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:28:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45527 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeLKP2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:28:31 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFRrUm4041325
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:27:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFRr994041321;
        Tue, 11 Dec 2018 07:27:53 -0800
Date:   Tue, 11 Dec 2018 07:27:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-2904d9fa45d3ce7153f1e10d78c570ecf7f19c35@git.kernel.org>
Cc:     johannes@sipsolutions.net, tglx@linutronix.de, hpa@zytor.com,
        longman@redhat.com, peterz@infradead.org, mingo@kernel.org,
        torvalds@linux-foundation.org, sasha.levin@oracle.com,
        bvanassche@acm.org, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, johannes@sipsolutions.net,
          peterz@infradead.org, longman@redhat.com, hpa@zytor.com,
          torvalds@linux-foundation.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, bvanassche@acm.org,
          sasha.levin@oracle.com
In-Reply-To: <20181207011148.251812-11-bvanassche@acm.org>
References: <20181207011148.251812-11-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Introduce
 lock_class_cache_is_registered()
Git-Commit-ID: 2904d9fa45d3ce7153f1e10d78c570ecf7f19c35
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

Commit-ID:  2904d9fa45d3ce7153f1e10d78c570ecf7f19c35
Gitweb:     https://git.kernel.org/tip/2904d9fa45d3ce7153f1e10d78c570ecf7f19c35
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 6 Dec 2018 17:11:34 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 14:54:53 +0100

locking/lockdep: Introduce lock_class_cache_is_registered()

This patch does not change any functionality but makes the
lockdep_reset_lock() function easier to read.

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
Link: https://lkml.kernel.org/r/20181207011148.251812-11-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 50 +++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b5c8fcb6c070..81388d028ac7 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4201,13 +4201,33 @@ void lockdep_free_key_range(void *start, unsigned long size)
 	 */
 }
 
-void lockdep_reset_lock(struct lockdep_map *lock)
+/*
+ * Check whether any element of the @lock->class_cache[] array refers to a
+ * registered lock class. The caller must hold either the graph lock or the
+ * RCU read lock.
+ */
+static bool lock_class_cache_is_registered(struct lockdep_map *lock)
 {
 	struct lock_class *class;
 	struct hlist_head *head;
-	unsigned long flags;
 	int i, j;
-	int locked;
+
+	for (i = 0; i < CLASSHASH_SIZE; i++) {
+		head = classhash_table + i;
+		hlist_for_each_entry_rcu(class, head, hash_entry) {
+			for (j = 0; j < NR_LOCKDEP_CACHING_CLASSES; j++)
+				if (lock->class_cache[j] == class)
+					return true;
+		}
+	}
+	return false;
+}
+
+void lockdep_reset_lock(struct lockdep_map *lock)
+{
+	struct lock_class *class;
+	unsigned long flags;
+	int j, locked;
 
 	raw_local_irq_save(flags);
 
@@ -4227,24 +4247,14 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 	 * be gone.
 	 */
 	locked = graph_lock();
-	for (i = 0; i < CLASSHASH_SIZE; i++) {
-		head = classhash_table + i;
-		hlist_for_each_entry_rcu(class, head, hash_entry) {
-			int match = 0;
-
-			for (j = 0; j < NR_LOCKDEP_CACHING_CLASSES; j++)
-				match |= class == lock->class_cache[j];
-
-			if (unlikely(match)) {
-				if (debug_locks_off_graph_unlock()) {
-					/*
-					 * We all just reset everything, how did it match?
-					 */
-					WARN_ON(1);
-				}
-				goto out_restore;
-			}
+	if (unlikely(lock_class_cache_is_registered(lock))) {
+		if (debug_locks_off_graph_unlock()) {
+			/*
+			 * We all just reset everything, how did it match?
+			 */
+			WARN_ON(1);
 		}
+		goto out_restore;
 	}
 	if (locked)
 		graph_unlock();
