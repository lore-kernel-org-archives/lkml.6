Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17DFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51515217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPqQ2Ii7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfBZKDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:03:42 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45774 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfBZKDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:03:41 -0500
Received: by mail-pl1-f195.google.com with SMTP id r14so5984198pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 02:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TztcUOYDFQ2d3Vdno2s+y9NLN5NEGQ0uZFQ2afvuarc=;
        b=rPqQ2Ii7LTa0M716X9HiYK88/8czLsSl9FiV3Noi1Y5Hj60WUe+3tBDhLISNqLeXCw
         bDSyc0hz9j7iq42nwAt1KUcz0sYCMWGdvCEkdoQvVuAik02jTF2WnYO0xzg9UyldxrcF
         ws7Gh8MO40cTb4Vx7uZMwdW/ba+E1U/uYEoq+Dg/IstlGA07eLCsbuBaz3yCGqB/o49c
         cq3ce5UOjxoqSvR1lNrOE0G/hjmEl8FzXATNCUi7KqtkupsEAcTMoW0pLIKR6DbF+PrY
         L8KA+Oco9TpMjZJGnpxRS3ddxK03h4h14EI9TnfUhmNE/MvVjK1j6lCFMVsEAlp/+qCH
         WENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TztcUOYDFQ2d3Vdno2s+y9NLN5NEGQ0uZFQ2afvuarc=;
        b=KHDgeTeh0wQAzR98KxT1MF5jnf/tw4Qiej9zdY2vjHoxXPtfYmNkUV38NCKM0iUvuK
         DHUWJjsi1JelJKqIaWUxAmwKlpQLO3ux4ns4YaW/adZqYBUZyfqFxQAJMPpZ4FVQslw3
         ISf28ZfyRzBs+KJ9bLybFf+aDdiCYZk8gELS5edpxrKZpgtRG1yIXkdQFDqBbwG8Hp8J
         0eyzbztZlhvT0DUuCV9U2hrcQk/WJBQgpi4kjIoODNQprW13Y0x1u50tmTiZORh4hzhn
         mt2wWy7hmfRacIvsJtEiW044zLr4wlQ1jaDJVF5XXsHE4wTO6f/Z+tmAmV+DlNWk8Utg
         7wkQ==
X-Gm-Message-State: AHQUAuZxQMhQcpAP2JPtxgeJIjBILEnIGb3EdvzYFmqyvvXCj0zD6wGq
        PGti3Yd6cY3iicST+oDxvIQ=
X-Google-Smtp-Source: AHgI3IZo3AnMHDlB9fnP0XQTtAr6bImuz656XQdaKN3/ZZ66CK7xbkXQWMKoonoMDlPHXspnD4QUeQ==
X-Received: by 2002:a17:902:e090:: with SMTP id cb16mr24500567plb.32.1551175419534;
        Tue, 26 Feb 2019 02:03:39 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id y6sm12045520pfy.87.2019.02.26.02.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 02:03:39 -0800 (PST)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 1/8] locking/lockdep: Change all print_*() return type to void
Date:   Tue, 26 Feb 2019 18:03:20 +0800
Message-Id: <20190226100327.19340-2-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190226100327.19340-1-duyuyang@gmail.com>
References: <20190226100327.19340-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of the print_*() function's return value is necessary, so change
their return type to void. No functional change.

In cases where an invariable return value is used, this change
improves readability, i.e.:

	print_x();
	return 0;

is definitely better than:

	return print_x(); /* where print_x() only returns 0 */

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 222 ++++++++++++++++++++++++-----------------------
 1 file changed, 112 insertions(+), 110 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c1653a1..41eab3d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1084,23 +1084,20 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
  * Print a dependency chain entry (this is only done when a deadlock
  * has been detected):
  */
-static noinline int
+static noinline void
 print_circular_bug_entry(struct lock_list *target, int depth)
 {
 	if (debug_locks_silent)
-		return 0;
+		return;
 	printk("\n-> #%u", depth);
 	print_lock_name(target->class);
 	printk(KERN_CONT ":\n");
 	print_stack_trace(&target->trace, 6);
-
-	return 0;
 }
 
-static void
-print_circular_lock_scenario(struct held_lock *src,
-			     struct held_lock *tgt,
-			     struct lock_list *prt)
+static void print_circular_lock_scenario(struct held_lock *src,
+					 struct held_lock *tgt,
+					 struct lock_list *prt)
 {
 	struct lock_class *source = hlock_class(src);
 	struct lock_class *target = hlock_class(tgt);
@@ -1151,7 +1148,7 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
  * When a circular dependency is detected, print the
  * header first:
  */
-static noinline int
+static noinline void
 print_circular_bug_header(struct lock_list *entry, unsigned int depth,
 			struct held_lock *check_src,
 			struct held_lock *check_tgt)
@@ -1159,7 +1156,7 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 	struct task_struct *curr = current;
 
 	if (debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("======================================================\n");
@@ -1177,8 +1174,6 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 	pr_warn("\nthe existing dependency chain (in reverse order) is:\n");
 
 	print_circular_bug_entry(entry, depth);
-
-	return 0;
 }
 
 static inline int class_equal(struct lock_list *entry, void *data)
@@ -1186,11 +1181,11 @@ static inline int class_equal(struct lock_list *entry, void *data)
 	return entry->class == data;
 }
 
-static noinline int print_circular_bug(struct lock_list *this,
-				struct lock_list *target,
-				struct held_lock *check_src,
-				struct held_lock *check_tgt,
-				struct stack_trace *trace)
+static noinline void print_circular_bug(struct lock_list *this,
+					struct lock_list *target,
+					struct held_lock *check_src,
+					struct held_lock *check_tgt,
+					struct stack_trace *trace)
 {
 	struct task_struct *curr = current;
 	struct lock_list *parent;
@@ -1198,10 +1193,10 @@ static noinline int print_circular_bug(struct lock_list *this,
 	int depth;
 
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return 0;
+		return;
 
 	if (!save_trace(&this->trace))
-		return 0;
+		return;
 
 	depth = get_lock_depth(target);
 
@@ -1223,21 +1218,17 @@ static noinline int print_circular_bug(struct lock_list *this,
 
 	printk("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
-static noinline int print_bfs_bug(int ret)
+static noinline void print_bfs_bug(int ret)
 {
 	if (!debug_locks_off_graph_unlock())
-		return 0;
+		return;
 
 	/*
 	 * Breadth-first-search failed, graph got corrupted?
 	 */
 	WARN(1, "lockdep bfs error:%d\n", ret);
-
-	return 0;
 }
 
 static int noop_count(struct lock_list *entry, void *data)
@@ -1420,7 +1411,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
  */
 static void __used
 print_shortest_lock_dependencies(struct lock_list *leaf,
-				struct lock_list *root)
+				 struct lock_list *root)
 {
 	struct lock_list *entry = leaf;
 	int depth;
@@ -1442,8 +1433,6 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 		entry = get_lock_parent(entry);
 		depth--;
 	} while (entry && (depth >= 0));
-
-	return;
 }
 
 static void
@@ -1502,7 +1491,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 	printk("\n *** DEADLOCK ***\n\n");
 }
 
-static int
+static void
 print_bad_irq_dependency(struct task_struct *curr,
 			 struct lock_list *prev_root,
 			 struct lock_list *next_root,
@@ -1515,7 +1504,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 			 const char *irqclass)
 {
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("=====================================================\n");
@@ -1561,19 +1550,17 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 
 	pr_warn("\nthe dependencies between %s-irq-safe lock and the holding lock:\n", irqclass);
 	if (!save_trace(&prev_root->trace))
-		return 0;
+		return;
 	print_shortest_lock_dependencies(backwards_entry, prev_root);
 
 	pr_warn("\nthe dependencies between the lock to be acquired");
 	pr_warn(" and %s-irq-unsafe lock:\n", irqclass);
 	if (!save_trace(&next_root->trace))
-		return 0;
+		return;
 	print_shortest_lock_dependencies(forwards_entry, next_root);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 static int
@@ -1590,23 +1577,28 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 
 	this.class = hlock_class(prev);
 	ret = find_usage_backwards(&this, bit_backwards, &target_entry);
-	if (ret < 0)
-		return print_bfs_bug(ret);
+	if (ret < 0) {
+		print_bfs_bug(ret);
+		return 0;
+	}
 	if (ret == 1)
 		return ret;
 
 	that.parent = NULL;
 	that.class = hlock_class(next);
 	ret = find_usage_forwards(&that, bit_forwards, &target_entry1);
-	if (ret < 0)
-		return print_bfs_bug(ret);
+	if (ret < 0) {
+		print_bfs_bug(ret);
+		return 0;
+	}
 	if (ret == 1)
 		return ret;
 
-	return print_bad_irq_dependency(curr, &this, &that,
-			target_entry, target_entry1,
-			prev, next,
-			bit_backwards, bit_forwards, irqclass);
+	print_bad_irq_dependency(curr, &this, &that,
+				 target_entry, target_entry1,
+				 prev, next,
+				 bit_backwards, bit_forwards, irqclass);
+	return 0;
 }
 
 static const char *state_names[] = {
@@ -1696,7 +1688,7 @@ static void inc_chains(void)
 
 static inline int
 check_prev_add_irq(struct task_struct *curr, struct held_lock *prev,
-		struct held_lock *next)
+		   struct held_lock *next)
 {
 	return 1;
 }
@@ -1708,9 +1700,8 @@ static inline void inc_chains(void)
 
 #endif
 
-static void
-print_deadlock_scenario(struct held_lock *nxt,
-			     struct held_lock *prv)
+static void print_deadlock_scenario(struct held_lock *nxt,
+				    struct held_lock *prv)
 {
 	struct lock_class *next = hlock_class(nxt);
 	struct lock_class *prev = hlock_class(prv);
@@ -1728,12 +1719,12 @@ static inline void inc_chains(void)
 	printk(" May be due to missing lock nesting notation\n\n");
 }
 
-static int
+static void
 print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 		   struct held_lock *next)
 {
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("============================================\n");
@@ -1752,8 +1743,6 @@ static inline void inc_chains(void)
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 /*
@@ -1795,7 +1784,8 @@ static inline void inc_chains(void)
 		if (nest)
 			return 2;
 
-		return print_deadlock_bug(curr, prev, next);
+		print_deadlock_bug(curr, prev, next);
+		return 0;
 	}
 	return 1;
 }
@@ -1853,10 +1843,13 @@ static inline void inc_chains(void)
 			 */
 			save(trace);
 		}
-		return print_circular_bug(&this, target_entry, next, prev, trace);
+		print_circular_bug(&this, target_entry, next, prev, trace);
+		return 0;
+	}
+	else if (unlikely(ret < 0)) {
+		print_bfs_bug(ret);
+		return 0;
 	}
-	else if (unlikely(ret < 0))
-		return print_bfs_bug(ret);
 
 	if (!check_prev_add_irq(curr, prev, next))
 		return 0;
@@ -1897,8 +1890,10 @@ static inline void inc_chains(void)
 		debug_atomic_inc(nr_redundant);
 		return 2;
 	}
-	if (ret < 0)
-		return print_bfs_bug(ret);
+	if (ret < 0) {
+		print_bfs_bug(ret);
+		return 0;
+	}
 
 
 	if (!trace->entries && !save(trace))
@@ -2088,8 +2083,8 @@ static void print_chain_keys_chain(struct lock_chain *chain)
 }
 
 static void print_collision(struct task_struct *curr,
-			struct held_lock *hlock_next,
-			struct lock_chain *chain)
+			    struct held_lock *hlock_next,
+			    struct lock_chain *chain)
 {
 	pr_warn("\n");
 	pr_warn("============================\n");
@@ -2352,8 +2347,8 @@ static int validate_chain(struct task_struct *curr, struct lockdep_map *lock,
 }
 #else
 static inline int validate_chain(struct task_struct *curr,
-	       	struct lockdep_map *lock, struct held_lock *hlock,
-		int chain_head, u64 chain_key)
+				 struct lockdep_map *lock, struct held_lock *hlock,
+				 int chain_head, u64 chain_key)
 {
 	return 1;
 }
@@ -2410,8 +2405,7 @@ static void check_chain_key(struct task_struct *curr)
 #endif
 }
 
-static void
-print_usage_bug_scenario(struct held_lock *lock)
+static void print_usage_bug_scenario(struct held_lock *lock)
 {
 	struct lock_class *class = hlock_class(lock);
 
@@ -2428,12 +2422,12 @@ static void check_chain_key(struct task_struct *curr)
 	printk("\n *** DEADLOCK ***\n\n");
 }
 
-static int
+static void
 print_usage_bug(struct task_struct *curr, struct held_lock *this,
 		enum lock_usage_bit prev_bit, enum lock_usage_bit new_bit)
 {
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("================================\n");
@@ -2463,8 +2457,6 @@ static void check_chain_key(struct task_struct *curr)
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 /*
@@ -2474,8 +2466,10 @@ static void check_chain_key(struct task_struct *curr)
 valid_state(struct task_struct *curr, struct held_lock *this,
 	    enum lock_usage_bit new_bit, enum lock_usage_bit bad_bit)
 {
-	if (unlikely(hlock_class(this)->usage_mask & (1 << bad_bit)))
-		return print_usage_bug(curr, this, bad_bit, new_bit);
+	if (unlikely(hlock_class(this)->usage_mask & (1 << bad_bit))) {
+		print_usage_bug(curr, this, bad_bit, new_bit);
+		return 0;
+	}
 	return 1;
 }
 
@@ -2487,7 +2481,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 /*
  * print irq inversion bug:
  */
-static int
+static void
 print_irq_inversion_bug(struct task_struct *curr,
 			struct lock_list *root, struct lock_list *other,
 			struct held_lock *this, int forwards,
@@ -2498,7 +2492,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	int depth;
 
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("========================================================\n");
@@ -2539,13 +2533,11 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 
 	pr_warn("\nthe shortest dependencies between 2nd lock and 1st lock:\n");
 	if (!save_trace(&root->trace))
-		return 0;
+		return;
 	print_shortest_lock_dependencies(other, root);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 /*
@@ -2563,13 +2555,16 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	root.parent = NULL;
 	root.class = hlock_class(this);
 	ret = find_usage_forwards(&root, bit, &target_entry);
-	if (ret < 0)
-		return print_bfs_bug(ret);
+	if (ret < 0) {
+		print_bfs_bug(ret);
+		return 0;
+	}
 	if (ret == 1)
 		return ret;
 
-	return print_irq_inversion_bug(curr, &root, target_entry,
-					this, 1, irqclass);
+	print_irq_inversion_bug(curr, &root, target_entry,
+				this, 1, irqclass);
+	return 0;
 }
 
 /*
@@ -2587,13 +2582,16 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	root.parent = NULL;
 	root.class = hlock_class(this);
 	ret = find_usage_backwards(&root, bit, &target_entry);
-	if (ret < 0)
-		return print_bfs_bug(ret);
+	if (ret < 0) {
+		print_bfs_bug(ret);
+		return 0;
+	}
 	if (ret == 1)
 		return ret;
 
-	return print_irq_inversion_bug(curr, &root, target_entry,
-					this, 0, irqclass);
+	print_irq_inversion_bug(curr, &root, target_entry,
+				this, 0, irqclass);
+	return 0;
 }
 
 void print_irqtrace_events(struct task_struct *curr)
@@ -3137,15 +3135,15 @@ void lockdep_init_map(struct lockdep_map *lock, const char *name,
 struct lock_class_key __lockdep_no_validate__;
 EXPORT_SYMBOL_GPL(__lockdep_no_validate__);
 
-static int
+static void
 print_lock_nested_lock_not_held(struct task_struct *curr,
 				struct held_lock *hlock,
 				unsigned long ip)
 {
 	if (!debug_locks_off())
-		return 0;
+		return;
 	if (debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("==================================\n");
@@ -3167,8 +3165,6 @@ void lockdep_init_map(struct lockdep_map *lock, const char *name,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 static int __lock_is_held(const struct lockdep_map *lock, int read);
@@ -3317,8 +3313,10 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	}
 	chain_key = iterate_chain_key(chain_key, class_idx);
 
-	if (nest_lock && !__lock_is_held(nest_lock, -1))
-		return print_lock_nested_lock_not_held(curr, hlock, ip);
+	if (nest_lock && !__lock_is_held(nest_lock, -1)) {
+		print_lock_nested_lock_not_held(curr, hlock, ip);
+		return 0;
+	}
 
 	if (!validate_chain(curr, lock, hlock, chain_head, chain_key))
 		return 0;
@@ -3349,14 +3347,14 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	return 1;
 }
 
-static int
-print_unlock_imbalance_bug(struct task_struct *curr, struct lockdep_map *lock,
-			   unsigned long ip)
+static void print_unlock_imbalance_bug(struct task_struct *curr,
+				       struct lockdep_map *lock,
+				       unsigned long ip)
 {
 	if (!debug_locks_off())
-		return 0;
+		return;
 	if (debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("=====================================\n");
@@ -3374,8 +3372,6 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 static int match_held_lock(const struct held_lock *hlock,
@@ -3494,8 +3490,10 @@ static int reacquire_held_locks(struct task_struct *curr, unsigned int depth,
 		return 0;
 
 	hlock = find_held_lock(curr, lock, depth, &i);
-	if (!hlock)
-		return print_unlock_imbalance_bug(curr, lock, ip);
+	if (!hlock) {
+		print_unlock_imbalance_bug(curr, lock, ip);
+		return 0;
+	}
 
 	lockdep_init_map(lock, name, key, 0);
 	class = register_lock_class(lock, subclass, 0);
@@ -3535,8 +3533,10 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 		return 0;
 
 	hlock = find_held_lock(curr, lock, depth, &i);
-	if (!hlock)
-		return print_unlock_imbalance_bug(curr, lock, ip);
+	if (!hlock) {
+		print_unlock_imbalance_bug(curr, lock, ip);
+		return 0;
+	}
 
 	curr->lockdep_depth = i;
 	curr->curr_chain_key = hlock->prev_chain_key;
@@ -3580,16 +3580,20 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 	 * So we're all set to release this lock.. wait what lock? We don't
 	 * own any locks, you've been drinking again?
 	 */
-	if (DEBUG_LOCKS_WARN_ON(depth <= 0))
-		 return print_unlock_imbalance_bug(curr, lock, ip);
+	if (DEBUG_LOCKS_WARN_ON(depth <= 0)) {
+		print_unlock_imbalance_bug(curr, lock, ip);
+		return 0;
+	}
 
 	/*
 	 * Check whether the lock exists in the current stack
 	 * of held locks:
 	 */
 	hlock = find_held_lock(curr, lock, depth, &i);
-	if (!hlock)
-		return print_unlock_imbalance_bug(curr, lock, ip);
+	if (!hlock) {
+		print_unlock_imbalance_bug(curr, lock, ip);
+		return 0;
+	}
 
 	if (hlock->instance == lock)
 		lock_release_holdtime(hlock);
@@ -3932,14 +3936,14 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 EXPORT_SYMBOL_GPL(lock_unpin_lock);
 
 #ifdef CONFIG_LOCK_STAT
-static int
-print_lock_contention_bug(struct task_struct *curr, struct lockdep_map *lock,
-			   unsigned long ip)
+static void print_lock_contention_bug(struct task_struct *curr,
+				      struct lockdep_map *lock,
+				      unsigned long ip)
 {
 	if (!debug_locks_off())
-		return 0;
+		return;
 	if (debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("=================================\n");
@@ -3957,8 +3961,6 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 static void
-- 
1.8.3.1

