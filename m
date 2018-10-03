Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72D8C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7446E20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7446E20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeJCOSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:18:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33757 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeJCOSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:18:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w937UqOH2264419
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 3 Oct 2018 00:30:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w937UqAm2264416;
        Wed, 3 Oct 2018 00:30:52 -0700
Date:   Wed, 3 Oct 2018 00:30:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-44318d5b07be7d7cfe718aa22ea3b2577361a0b5@git.kernel.org>
Cc:     peterz@infradead.org, will.deacon@arm.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        torvalds@linux-foundation.org, a.p.zijlstra@chello.nl,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: a.p.zijlstra@chello.nl, longman@redhat.com,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          mingo@kernel.org, peterz@infradead.org, will.deacon@arm.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <1538511560-10090-2-git-send-email-longman@redhat.com>
References: <1538511560-10090-2-git-send-email-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Remove
 add_chain_cache_classes()
Git-Commit-ID: 44318d5b07be7d7cfe718aa22ea3b2577361a0b5
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

Commit-ID:  44318d5b07be7d7cfe718aa22ea3b2577361a0b5
Gitweb:     https://git.kernel.org/tip/44318d5b07be7d7cfe718aa22ea3b2577361a0b5
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Tue, 2 Oct 2018 16:19:16 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Oct 2018 08:46:02 +0200

locking/lockdep: Remove add_chain_cache_classes()

The inline function add_chain_cache_classes() is defined, but has no
caller. Just remove it.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/1538511560-10090-2-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 70 ------------------------------------------------
 1 file changed, 70 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e406c5fdb41e..fa82d55279fe 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2148,76 +2148,6 @@ static int check_no_collision(struct task_struct *curr,
 	return 1;
 }
 
-/*
- * This is for building a chain between just two different classes,
- * instead of adding a new hlock upon current, which is done by
- * add_chain_cache().
- *
- * This can be called in any context with two classes, while
- * add_chain_cache() must be done within the lock owener's context
- * since it uses hlock which might be racy in another context.
- */
-static inline int add_chain_cache_classes(unsigned int prev,
-					  unsigned int next,
-					  unsigned int irq_context,
-					  u64 chain_key)
-{
-	struct hlist_head *hash_head = chainhashentry(chain_key);
-	struct lock_chain *chain;
-
-	/*
-	 * Allocate a new chain entry from the static array, and add
-	 * it to the hash:
-	 */
-
-	/*
-	 * We might need to take the graph lock, ensure we've got IRQs
-	 * disabled to make this an IRQ-safe lock.. for recursion reasons
-	 * lockdep won't complain about its own locking errors.
-	 */
-	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
-		return 0;
-
-	if (unlikely(nr_lock_chains >= MAX_LOCKDEP_CHAINS)) {
-		if (!debug_locks_off_graph_unlock())
-			return 0;
-
-		print_lockdep_off("BUG: MAX_LOCKDEP_CHAINS too low!");
-		dump_stack();
-		return 0;
-	}
-
-	chain = lock_chains + nr_lock_chains++;
-	chain->chain_key = chain_key;
-	chain->irq_context = irq_context;
-	chain->depth = 2;
-	if (likely(nr_chain_hlocks + chain->depth <= MAX_LOCKDEP_CHAIN_HLOCKS)) {
-		chain->base = nr_chain_hlocks;
-		nr_chain_hlocks += chain->depth;
-		chain_hlocks[chain->base] = prev - 1;
-		chain_hlocks[chain->base + 1] = next -1;
-	}
-#ifdef CONFIG_DEBUG_LOCKDEP
-	/*
-	 * Important for check_no_collision().
-	 */
-	else {
-		if (!debug_locks_off_graph_unlock())
-			return 0;
-
-		print_lockdep_off("BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!");
-		dump_stack();
-		return 0;
-	}
-#endif
-
-	hlist_add_head_rcu(&chain->entry, hash_head);
-	debug_atomic_inc(chain_lookup_misses);
-	inc_chains();
-
-	return 1;
-}
-
 /*
  * Adds a dependency chain into chain hashtable. And must be called with
  * graph_lock held.
