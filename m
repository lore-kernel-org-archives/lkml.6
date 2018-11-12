Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56583C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D3E2245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="t4poFByS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D3E2245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbeKLW4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:56:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37090 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbeKLW4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:56:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id o15-v6so9245288wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 05:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=WyOYtBKXz6FLIjL3yBN5qXtR4cY/RREpww7JUBviVhI=;
        b=t4poFBySv7hND8UXdpG2vPlnYxp63JT4b1/p2wS0/GBN54WvZreKqrapV32Qct9osS
         RKyXRiVNXQGLSSQAIdUMtllx6aFnPkU+8XY555TORxuytrJBnahpxyUmwr7Wr6aCj/3T
         1ixqnnQo/NHYUptgAVOosGvnVY8+W49ZAVrq/KwR6+p3NcJU4m7KD4ZsyBrEMSOFx8Tw
         YMxXi3T48pVo01Fr089i8HdtUvS+vQl0nL8+noKUNgmKv8ISbgDGZjZnRubZHKcdnEZt
         R/M2+8vX9RFWoo7RLry5kEFFZJN6fuGUW49xeyGr3Xzq519SrO/kwL2cXYWMZsp+mqCF
         OZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WyOYtBKXz6FLIjL3yBN5qXtR4cY/RREpww7JUBviVhI=;
        b=W+8RFIRtPp/5gUVcTMyX2hDnZyFJrXPgsRxPz0LAnIgT3OVXI1oOosn34dUcPBWk2V
         Si5P9hyJodZIgovGyb3j3q5Fek6N57CTDB2NfiPVWWkN+8ZYqLzc55rAxLCo1Nn0wfc0
         mT0eSCcT1Gc54rkr9ChQVb64XTBkUPMVsvwfshubrV0is8AlXMZxeIhLpv2FwEcVM+zA
         6l6VYOrGwGAS4ySRawBVQaTivtSOH8XLBarbe2w02we5XtGbm/b/vxL1O1dNGJkf4I8v
         jS7pphJ5LuHWgWB44hrvmZwxvkVtckiyVzoWk/BwxUuC7QASbyEJ1Y8ztYeCBpkAVp+1
         BJsg==
X-Gm-Message-State: AGRZ1gLUMcRm4jic+ejhQ4VPfR4WmdGhwZuabDCboAnkZge3Z3qGyIuq
        jLQVKtsSM3v+62N7cszAoL0a5Q==
X-Google-Smtp-Source: AJdET5ey6mEyJyXFxMK6/SSFPJCRqVvmji9hjvyI8WkXhbDAeNPN10LTWnzTLu1lxg89G5QYjqNwqw==
X-Received: by 2002:adf:a20a:: with SMTP id p10-v6mr852062wra.249.1542027804606;
        Mon, 12 Nov 2018 05:03:24 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id g8-v6sm17836045wri.58.2018.11.12.05.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 05:03:23 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     mingo@redhat.com, peterz@infradead.org, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFC] locking/lockdep: replace simple printk by pr_info
Date:   Mon, 12 Nov 2018 13:03:14 +0000
Message-Id: <1542027794-2255-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on detector of new warn/err/crit/... messages, I found that the
following messages was printed with the warn loglevel:
[    0.001607] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.001625] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.001641] ... MAX_LOCK_DEPTH:          48
[    0.001658] ... MAX_LOCKDEP_KEYS:        8191
[    0.001673] ... CLASSHASH_SIZE:          4096
[    0.001689] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.001704] ... MAX_LOCKDEP_CHAINS:      65536
[    0.001719] ... CHAINHASH_SIZE:          32768
[    0.001735]  memory used by lock dependency info: 4623 kB

While the cause is still unknown to me, converting printk to pr_info fixed the issue.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 kernel/locking/lockdep.c | 152 +++++++++++++++++++++++------------------------
 1 file changed, 76 insertions(+), 76 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1efada2..9454597 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -560,9 +560,9 @@ static void lockdep_print_held_locks(struct task_struct *p)
 	int i, depth = READ_ONCE(p->lockdep_depth);
 
 	if (!depth)
-		printk("no locks held by %s/%d.\n", p->comm, task_pid_nr(p));
+		pr_info("no locks held by %s/%d.\n", p->comm, task_pid_nr(p));
 	else
-		printk("%d lock%s held by %s/%d:\n", depth,
+		pr_info("%d lock%s held by %s/%d:\n", depth,
 		       depth > 1 ? "s" : "", p->comm, task_pid_nr(p));
 	/*
 	 * It's not reliable to print a task's held locks if it's not sleeping
@@ -571,14 +571,14 @@ static void lockdep_print_held_locks(struct task_struct *p)
 	if (p->state == TASK_RUNNING && p != current)
 		return;
 	for (i = 0; i < depth; i++) {
-		printk(" #%d: ", i);
+		pr_info(" #%d: ", i);
 		print_lock(p->held_locks + i);
 	}
 }
 
 static void print_kernel_ident(void)
 {
-	printk("%s %.*s %s\n", init_utsname()->release,
+	pr_info("%s %.*s %s\n", init_utsname()->release,
 		(int)strcspn(init_utsname()->version, " "),
 		init_utsname()->version,
 		print_tainted());
@@ -806,7 +806,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	if (verbose(class)) {
 		graph_unlock();
 
-		printk("\nnew class %px: %s", class->key, class->name);
+		pr_info("\nnew class %px: %s", class->key, class->name);
 		if (class->name_version > 1)
 			printk(KERN_CONT "#%d", class->name_version);
 		printk(KERN_CONT "\n");
@@ -1085,7 +1085,7 @@ print_circular_bug_entry(struct lock_list *target, int depth)
 {
 	if (debug_locks_silent)
 		return 0;
-	printk("\n-> #%u", depth);
+	pr_info("\n-> #%u", depth);
 	print_lock_name(target->class);
 	printk(KERN_CONT ":\n");
 	print_stack_trace(&target->trace, 6);
@@ -1116,7 +1116,7 @@ print_circular_lock_scenario(struct held_lock *src,
 	 * from the safe_class lock to the unsafe_class lock.
 	 */
 	if (parent != source) {
-		printk("Chain exists of:\n  ");
+		pr_info("Chain exists of:\n  ");
 		__print_lock_name(source);
 		printk(KERN_CONT " --> ");
 		__print_lock_name(parent);
@@ -1125,22 +1125,22 @@ print_circular_lock_scenario(struct held_lock *src,
 		printk(KERN_CONT "\n\n");
 	}
 
-	printk(" Possible unsafe locking scenario:\n\n");
-	printk("       CPU0                    CPU1\n");
-	printk("       ----                    ----\n");
-	printk("  lock(");
+	pr_info(" Possible unsafe locking scenario:\n\n");
+	pr_info("       CPU0                    CPU1\n");
+	pr_info("       ----                    ----\n");
+	pr_info("  lock(");
 	__print_lock_name(target);
 	printk(KERN_CONT ");\n");
-	printk("                               lock(");
+	pr_info("                               lock(");
 	__print_lock_name(parent);
 	printk(KERN_CONT ");\n");
-	printk("                               lock(");
+	pr_info("                               lock(");
 	__print_lock_name(target);
 	printk(KERN_CONT ");\n");
-	printk("  lock(");
+	pr_info("  lock(");
 	__print_lock_name(source);
 	printk(KERN_CONT ");\n");
-	printk("\n *** DEADLOCK ***\n\n");
+	pr_info("\n *** DEADLOCK ***\n\n");
 }
 
 /*
@@ -1211,13 +1211,13 @@ static noinline int print_circular_bug(struct lock_list *this,
 		parent = get_lock_parent(parent);
 	}
 
-	printk("\nother info that might help us debug this:\n\n");
+	pr_info("\nother info that might help us debug this:\n\n");
 	print_circular_lock_scenario(check_src, check_tgt,
 				     first_parent);
 
 	lockdep_print_held_locks(curr);
 
-	printk("\nstack backtrace:\n");
+	pr_info("\nstack backtrace:\n");
 	dump_stack();
 
 	return 0;
@@ -1389,7 +1389,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 {
 	int bit;
 
-	printk("%*s->", depth, "");
+	pr_info("%*s->", depth, "");
 	print_lock_name(class);
 #ifdef CONFIG_DEBUG_LOCKDEP
 	printk(KERN_CONT " ops: %lu", debug_class_ops_read(class));
@@ -1400,14 +1400,14 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 		if (class->usage_mask & (1 << bit)) {
 			int len = depth;
 
-			len += printk("%*s   %s", depth, "", usage_str[bit]);
+			len += pr_info("%*s   %s", depth, "", usage_str[bit]);
 			len += printk(KERN_CONT " at:\n");
 			print_stack_trace(class->usage_traces + bit, len);
 		}
 	}
-	printk("%*s }\n", depth, "");
+	pr_info("%*s }\n", depth, "");
 
-	printk("%*s ... key      at: [<%px>] %pS\n",
+	pr_info("%*s ... key      at: [<%px>] %pS\n",
 		depth, "", class->key, class->key);
 }
 
@@ -1426,12 +1426,12 @@ print_shortest_lock_dependencies(struct lock_list *leaf,
 
 	do {
 		print_lock_class_header(entry->class, depth);
-		printk("%*s ... acquired at:\n", depth, "");
+		pr_info("%*s ... acquired at:\n", depth, "");
 		print_stack_trace(&entry->trace, 2);
-		printk("\n");
+		pr_info("\n");
 
 		if (depth == 0 && (entry != root)) {
-			printk("lockdep:%s bad path found in chain graph\n", __func__);
+			pr_info("lockdep:%s bad path found in chain graph\n", __func__);
 			break;
 		}
 
@@ -1469,7 +1469,7 @@ print_irq_lock_scenario(struct lock_list *safe_entry,
 	 * from the safe_class lock to the unsafe_class lock.
 	 */
 	if (middle_class != unsafe_class) {
-		printk("Chain exists of:\n  ");
+		pr_info("Chain exists of:\n  ");
 		__print_lock_name(safe_class);
 		printk(KERN_CONT " --> ");
 		__print_lock_name(middle_class);
@@ -1478,24 +1478,24 @@ print_irq_lock_scenario(struct lock_list *safe_entry,
 		printk(KERN_CONT "\n\n");
 	}
 
-	printk(" Possible interrupt unsafe locking scenario:\n\n");
-	printk("       CPU0                    CPU1\n");
-	printk("       ----                    ----\n");
-	printk("  lock(");
+	pr_info(" Possible interrupt unsafe locking scenario:\n\n");
+	pr_info("       CPU0                    CPU1\n");
+	pr_info("       ----                    ----\n");
+	pr_info("  lock(");
 	__print_lock_name(unsafe_class);
 	printk(KERN_CONT ");\n");
-	printk("                               local_irq_disable();\n");
-	printk("                               lock(");
+	pr_info("                               local_irq_disable();\n");
+	pr_info("                               lock(");
 	__print_lock_name(safe_class);
 	printk(KERN_CONT ");\n");
-	printk("                               lock(");
+	pr_info("                               lock(");
 	__print_lock_name(middle_class);
 	printk(KERN_CONT ");\n");
-	printk("  <Interrupt>\n");
-	printk("    lock(");
+	pr_info("  <Interrupt>\n");
+	pr_info("    lock(");
 	__print_lock_name(safe_class);
 	printk(KERN_CONT ");\n");
-	printk("\n *** DEADLOCK ***\n\n");
+	pr_info("\n *** DEADLOCK ***\n\n");
 }
 
 static int
@@ -1722,17 +1722,17 @@ print_deadlock_scenario(struct held_lock *nxt,
 	struct lock_class *next = hlock_class(nxt);
 	struct lock_class *prev = hlock_class(prv);
 
-	printk(" Possible unsafe locking scenario:\n\n");
-	printk("       CPU0\n");
-	printk("       ----\n");
-	printk("  lock(");
+	pr_info(" Possible unsafe locking scenario:\n\n");
+	pr_info("       CPU0\n");
+	pr_info("       ----\n");
+	pr_info("  lock(");
 	__print_lock_name(prev);
 	printk(KERN_CONT ");\n");
-	printk("  lock(");
+	pr_info("  lock(");
 	__print_lock_name(next);
 	printk(KERN_CONT ");\n");
-	printk("\n *** DEADLOCK ***\n\n");
-	printk(" May be due to missing lock nesting notation\n\n");
+	pr_info("\n *** DEADLOCK ***\n\n");
+	pr_info(" May be due to missing lock nesting notation\n\n");
 }
 
 static int
@@ -2052,7 +2052,7 @@ static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
 {
 	u64 new_chain_key = iterate_chain_key(chain_key, class_idx);
 
-	printk(" class_idx:%d -> chain_key:%016Lx",
+	pr_info(" class_idx:%d -> chain_key:%016Lx",
 		class_idx,
 		(unsigned long long)new_chain_key);
 	return new_chain_key;
@@ -2066,7 +2066,7 @@ print_chain_keys_held_locks(struct task_struct *curr, struct held_lock *hlock_ne
 	int depth = curr->lockdep_depth;
 	int i;
 
-	printk("depth: %u\n", depth + 1);
+	pr_info("depth: %u\n", depth + 1);
 	for (i = get_first_held_lock(curr, hlock_next); i < depth; i++) {
 		hlock = curr->held_locks + i;
 		chain_key = print_chain_key_iteration(hlock->class_idx, chain_key);
@@ -2084,13 +2084,13 @@ static void print_chain_keys_chain(struct lock_chain *chain)
 	u64 chain_key = 0;
 	int class_id;
 
-	printk("depth: %u\n", chain->depth);
+	pr_info("depth: %u\n", chain->depth);
 	for (i = 0; i < chain->depth; i++) {
 		class_id = chain_hlocks[chain->base + i];
 		chain_key = print_chain_key_iteration(class_id + 1, chain_key);
 
 		print_lock_name(lock_classes + class_id);
-		printk("\n");
+		pr_info("\n");
 	}
 }
 
@@ -2269,7 +2269,7 @@ static inline int lookup_chain_cache_add(struct task_struct *curr,
 			return 0;
 
 		if (very_verbose(class)) {
-			printk("\nhash chain already cached, key: "
+			pr_info("\nhash chain already cached, key: "
 					"%016Lx tail class: [%px] %s\n",
 					(unsigned long long)chain_key,
 					class->key, class->name);
@@ -2279,7 +2279,7 @@ static inline int lookup_chain_cache_add(struct task_struct *curr,
 	}
 
 	if (very_verbose(class)) {
-		printk("\nnew hash chain, key: %016Lx tail class: [%px] %s\n",
+		pr_info("\nnew hash chain, key: %016Lx tail class: [%px] %s\n",
 			(unsigned long long)chain_key, class->key, class->name);
 	}
 
@@ -2422,17 +2422,17 @@ print_usage_bug_scenario(struct held_lock *lock)
 {
 	struct lock_class *class = hlock_class(lock);
 
-	printk(" Possible unsafe locking scenario:\n\n");
-	printk("       CPU0\n");
-	printk("       ----\n");
-	printk("  lock(");
+	pr_info(" Possible unsafe locking scenario:\n\n");
+	pr_info("       CPU0\n");
+	pr_info("       ----\n");
+	pr_info("  lock(");
 	__print_lock_name(class);
 	printk(KERN_CONT ");\n");
-	printk("  <Interrupt>\n");
-	printk("    lock(");
+	pr_info("  <Interrupt>\n");
+	pr_info("    lock(");
 	__print_lock_name(class);
 	printk(KERN_CONT ");\n");
-	printk("\n *** DEADLOCK ***\n\n");
+	pr_info("\n *** DEADLOCK ***\n\n");
 }
 
 static int
@@ -2605,17 +2605,17 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 
 void print_irqtrace_events(struct task_struct *curr)
 {
-	printk("irq event stamp: %u\n", curr->irq_events);
-	printk("hardirqs last  enabled at (%u): [<%px>] %pS\n",
+	pr_info("irq event stamp: %u\n", curr->irq_events);
+	pr_info("hardirqs last  enabled at (%u): [<%px>] %pS\n",
 		curr->hardirq_enable_event, (void *)curr->hardirq_enable_ip,
 		(void *)curr->hardirq_enable_ip);
-	printk("hardirqs last disabled at (%u): [<%px>] %pS\n",
+	pr_info("hardirqs last disabled at (%u): [<%px>] %pS\n",
 		curr->hardirq_disable_event, (void *)curr->hardirq_disable_ip,
 		(void *)curr->hardirq_disable_ip);
-	printk("softirqs last  enabled at (%u): [<%px>] %pS\n",
+	pr_info("softirqs last  enabled at (%u): [<%px>] %pS\n",
 		curr->softirq_enable_event, (void *)curr->softirq_enable_ip,
 		(void *)curr->softirq_enable_ip);
-	printk("softirqs last disabled at (%u): [<%px>] %pS\n",
+	pr_info("softirqs last disabled at (%u): [<%px>] %pS\n",
 		curr->softirq_disable_event, (void *)curr->softirq_disable_ip,
 		(void *)curr->softirq_disable_ip);
 }
@@ -3076,7 +3076,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	 * We must printk outside of the graph_lock:
 	 */
 	if (ret == 2) {
-		printk("\nmarked lock as {%s}:\n", usage_str[new_bit]);
+		pr_info("\nmarked lock as {%s}:\n", usage_str[new_bit]);
 		print_lock(this);
 		print_irqtrace_events(curr);
 		dump_stack();
@@ -3119,7 +3119,7 @@ static void __lockdep_init_map(struct lockdep_map *lock, const char *name,
 	 * Sanity check, the lock-class key must be persistent:
 	 */
 	if (!static_obj(key)) {
-		printk("BUG: key %px not in .data!\n", key);
+		pr_info("BUG: key %px not in .data!\n", key);
 		/*
 		 * What it says above ^^^^^, I suggest you read it.
 		 */
@@ -3232,7 +3232,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	debug_class_ops_inc(class);
 
 	if (very_verbose(class)) {
-		printk("\nacquire class [%px] %s", class->key, class->name);
+		pr_info("\nacquire class [%px] %s", class->key, class->name);
 		if (class->name_version > 1)
 			printk(KERN_CONT "#%d", class->name_version);
 		printk(KERN_CONT "\n");
@@ -3759,11 +3759,11 @@ static void check_flags(unsigned long flags)
 
 	if (irqs_disabled_flags(flags)) {
 		if (DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)) {
-			printk("possible reason: unannotated irqs-off.\n");
+			pr_info("possible reason: unannotated irqs-off.\n");
 		}
 	} else {
 		if (DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)) {
-			printk("possible reason: unannotated irqs-on.\n");
+			pr_info("possible reason: unannotated irqs-on.\n");
 		}
 	}
 
@@ -4258,17 +4258,17 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 
 void __init lockdep_init(void)
 {
-	printk("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
+	pr_info("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
 
-	printk("... MAX_LOCKDEP_SUBCLASSES:  %lu\n", MAX_LOCKDEP_SUBCLASSES);
-	printk("... MAX_LOCK_DEPTH:          %lu\n", MAX_LOCK_DEPTH);
-	printk("... MAX_LOCKDEP_KEYS:        %lu\n", MAX_LOCKDEP_KEYS);
-	printk("... CLASSHASH_SIZE:          %lu\n", CLASSHASH_SIZE);
-	printk("... MAX_LOCKDEP_ENTRIES:     %lu\n", MAX_LOCKDEP_ENTRIES);
-	printk("... MAX_LOCKDEP_CHAINS:      %lu\n", MAX_LOCKDEP_CHAINS);
-	printk("... CHAINHASH_SIZE:          %lu\n", CHAINHASH_SIZE);
+	pr_info("... MAX_LOCKDEP_SUBCLASSES:  %lu\n", MAX_LOCKDEP_SUBCLASSES);
+	pr_info("... MAX_LOCK_DEPTH:          %lu\n", MAX_LOCK_DEPTH);
+	pr_info("... MAX_LOCKDEP_KEYS:        %lu\n", MAX_LOCKDEP_KEYS);
+	pr_info("... CLASSHASH_SIZE:          %lu\n", CLASSHASH_SIZE);
+	pr_info("... MAX_LOCKDEP_ENTRIES:     %lu\n", MAX_LOCKDEP_ENTRIES);
+	pr_info("... MAX_LOCKDEP_CHAINS:      %lu\n", MAX_LOCKDEP_CHAINS);
+	pr_info("... CHAINHASH_SIZE:          %lu\n", CHAINHASH_SIZE);
 
-	printk(" memory used by lock dependency info: %lu kB\n",
+	pr_info(" memory used by lock dependency info: %lu kB\n",
 		(sizeof(struct lock_class) * MAX_LOCKDEP_KEYS +
 		sizeof(struct list_head) * CLASSHASH_SIZE +
 		sizeof(struct lock_list) * MAX_LOCKDEP_ENTRIES +
@@ -4280,7 +4280,7 @@ void __init lockdep_init(void)
 		) / 1024
 		);
 
-	printk(" per task-struct memory footprint: %lu bytes\n",
+	pr_info(" per task-struct memory footprint: %lu bytes\n",
 		sizeof(struct held_lock) * MAX_LOCK_DEPTH);
 }
 
@@ -4403,7 +4403,7 @@ EXPORT_SYMBOL_GPL(debug_show_all_locks);
 void debug_show_held_locks(struct task_struct *task)
 {
 	if (unlikely(!debug_locks)) {
-		printk("INFO: lockdep is turned off.\n");
+		pr_info("INFO: lockdep is turned off.\n");
 		return;
 	}
 	lockdep_print_held_locks(task);
-- 
2.7.4

