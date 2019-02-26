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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD32C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D61B2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJQicrkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfBZKDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:03:51 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41509 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbfBZKDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:03:49 -0500
Received: by mail-pl1-f194.google.com with SMTP id y5so6000364plk.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 02:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bPwDnj46r4cY05MHvV7iFfotcB3dxtInryIXYed2AL4=;
        b=kJQicrkUWwUh31DnMo2FTHrzPMgE1ghOniwbRSL+LdMD7pPZbW2KXROCOUqYmu0blx
         1HvkU8gzB2cWmir5oyar1hKHfaE7jm4pIzrycso6vOcmjafT5k9krhOCX4Q6D8Qn8HEk
         05NwSEUlmEAsEi1Aj3t08ELoK+3RTJRGGSMhM8yvPldmJMwxCeVtzsJftqNRbCpYGKou
         7QVn7hJpolpU053bFOkpAqEOWrav4husM85i4R8SI1mmcSJ5Y/fmGgGKWwgFS6TQzdYj
         gFwd34ycTnnfcLhevm2RjdjfGVjM9NflQziAusZpFu/9g7WKPvGWfet1ftnsCJUxJ0Ih
         lWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bPwDnj46r4cY05MHvV7iFfotcB3dxtInryIXYed2AL4=;
        b=eWycuTD7/Zm6EJBwM34F6GNFSrf1IKME+4lfTYSYAgBjd8d9si+mT9dUUTN1jylD0P
         jyszHUWQi94wE0QbfjUmnu69A+GAPNjal5TXLF2BHzm7478LShWAbxYOuw8T3gPeuQbK
         S3NP1NPEDGMT219KNCXymt5u3O7EsvxM8ic/N3ZYwdy4iz2eaF76s14WEUS//FW3SGtK
         sEtGdBuukZOcN5jVSRtHZ2u1N68mu1oSjYjC2ov+Y3Y7N9yontdu1VJ6zUN2cUtc9fOx
         Xwumqn0HTXL1LPFyHBwUQF7vLJwFBwydw/EXXEkeyUZ026LwMKCYbUaxcK5lJZzr49FS
         lmWA==
X-Gm-Message-State: AHQUAuZDiKwCu4hlCBoIKaZBnqF9cYu/EawtlGlPopx1cLsLcypVbTUk
        BPJi1jeAQeyxNOsgbO0NQlk=
X-Google-Smtp-Source: AHgI3IaKID9vJKWkgPQfRu/4nHdtPFIGq72JxZaEzVWHVsFmx2BQ/s5QpdvcLLOkmZKe/cM4hpDzFg==
X-Received: by 2002:a17:902:64:: with SMTP id 91mr25967635pla.229.1551175428332;
        Tue, 26 Feb 2019 02:03:48 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id y6sm12045520pfy.87.2019.02.26.02.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 02:03:47 -0800 (PST)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 5/8] locking/lockdep: Adjust indents for some lines
Date:   Tue, 26 Feb 2019 18:03:24 +0800
Message-Id: <20190226100327.19340-6-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190226100327.19340-1-duyuyang@gmail.com>
References: <20190226100327.19340-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Being paranoid to see function arguments lines are aligned.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 59 +++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 0610c0b..55270938 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1067,19 +1067,17 @@ static int __bfs(struct lock_list *source_entry,
 	return ret;
 }
 
-static inline int __bfs_forwards(struct lock_list *src_entry,
-			void *data,
-			int (*match)(struct lock_list *entry, void *data),
-			struct lock_list **target_entry)
+static inline int __bfs_forwards(struct lock_list *src_entry, void *data,
+				 int (*match)(struct lock_list *entry, void *data),
+				 struct lock_list **target_entry)
 {
 	return __bfs(src_entry, data, match, target_entry, 1);
 
 }
 
-static inline int __bfs_backwards(struct lock_list *src_entry,
-			void *data,
-			int (*match)(struct lock_list *entry, void *data),
-			struct lock_list **target_entry)
+static inline int __bfs_backwards(struct lock_list *src_entry, void *data,
+				  int (*match)(struct lock_list *entry, void *data),
+				  struct lock_list **target_entry)
 {
 	return __bfs(src_entry, data, match, target_entry, 0);
 
@@ -1161,8 +1159,8 @@ static void print_circular_lock_scenario(struct held_lock *src,
  */
 static noinline void
 print_circular_bug_header(struct lock_list *entry, unsigned int depth,
-			struct held_lock *check_src,
-			struct held_lock *check_tgt)
+			  struct held_lock *check_src,
+			  struct held_lock *check_tgt)
 {
 	struct task_struct *curr = current;
 
@@ -1307,7 +1305,7 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
  */
 static noinline int
 check_noncircular(struct lock_list *root, struct lock_class *target,
-		struct lock_list **target_entry)
+		  struct lock_list **target_entry)
 {
 	int result;
 
@@ -1357,7 +1355,7 @@ static inline int usage_match(struct lock_list *entry, void *bit)
  */
 static int
 find_usage_forwards(struct lock_list *root, enum lock_usage_bit bit,
-			struct lock_list **target_entry)
+		    struct lock_list **target_entry)
 {
 	int result;
 
@@ -1380,7 +1378,7 @@ static inline int usage_match(struct lock_list *entry, void *bit)
  */
 static int
 find_usage_backwards(struct lock_list *root, enum lock_usage_bit bit,
-			struct lock_list **target_entry)
+		     struct lock_list **target_entry)
 {
 	int result;
 
@@ -1672,7 +1670,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 
 static int
 check_prev_add_irq(struct task_struct *curr, struct held_lock *prev,
-		struct held_lock *next)
+		   struct held_lock *next)
 {
 #define LOCKDEP_STATE(__STATE)						\
 	if (!check_irq_usage(curr, prev, next, LOCK_USED_IN_##__STATE))	\
@@ -2028,7 +2026,7 @@ struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
  * Returns the index of the first held_lock of the current chain
  */
 static inline int get_first_held_lock(struct task_struct *curr,
-					struct held_lock *hlock)
+				      struct held_lock *hlock)
 {
 	int i;
 	struct held_lock *hlock_curr;
@@ -2123,8 +2121,8 @@ static void print_collision(struct task_struct *curr,
  * Returns: 0 not passed, 1 passed
  */
 static int check_no_collision(struct task_struct *curr,
-			struct held_lock *hlock,
-			struct lock_chain *chain)
+			      struct held_lock *hlock,
+			      struct lock_chain *chain)
 {
 #ifdef CONFIG_DEBUG_LOCKDEP
 	int i, j, id;
@@ -2301,7 +2299,7 @@ static inline int lookup_chain_cache_add(struct task_struct *curr,
 }
 
 static int validate_chain(struct task_struct *curr, struct lockdep_map *lock,
-		struct held_lock *hlock, int chain_head, u64 chain_key)
+			  struct held_lock *hlock, int chain_head, u64 chain_key)
 {
 	/*
 	 * Trylock needs to maintain the stack of held locks, but it
@@ -2686,7 +2684,7 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 	 * states.
 	 */
 	if ((!read || !dir || STRICT_READ_CHECKS) &&
-			!usage(curr, this, excl_bit, state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
+	    !usage(curr, this, excl_bit, state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
 		return 0;
 
 	/*
@@ -2697,8 +2695,8 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 			return 0;
 
 		if (STRICT_READ_CHECKS &&
-			!usage(curr, this, excl_bit + LOCK_USAGE_READ_MASK,
-				state_name(new_bit + LOCK_USAGE_READ_MASK)))
+		    !usage(curr, this, excl_bit + LOCK_USAGE_READ_MASK,
+			   state_name(new_bit + LOCK_USAGE_READ_MASK)))
 			return 0;
 	}
 
@@ -2964,7 +2962,7 @@ static inline unsigned int task_irq_context(struct task_struct *task)
 }
 
 static int separate_irq_context(struct task_struct *curr,
-		struct held_lock *hlock)
+				struct held_lock *hlock)
 {
 	unsigned int depth = curr->lockdep_depth;
 
@@ -2990,14 +2988,14 @@ static int separate_irq_context(struct task_struct *curr,
 
 static inline
 int mark_lock_irq(struct task_struct *curr, struct held_lock *this,
-		enum lock_usage_bit new_bit)
+		  enum lock_usage_bit new_bit)
 {
 	WARN_ON(1); /* Impossible innit? when we don't have TRACE_IRQFLAG */
 	return 1;
 }
 
 static inline int mark_irqflags(struct task_struct *curr,
-		struct held_lock *hlock)
+				struct held_lock *hlock)
 {
 	return 1;
 }
@@ -3008,7 +3006,7 @@ static inline unsigned int task_irq_context(struct task_struct *task)
 }
 
 static inline int separate_irq_context(struct task_struct *curr,
-		struct held_lock *hlock)
+				       struct held_lock *hlock)
 {
 	return 0;
 }
@@ -3019,7 +3017,7 @@ static inline int separate_irq_context(struct task_struct *curr,
  * Mark a lock with a usage bit, and validate the state transition:
  */
 static int mark_lock(struct task_struct *curr, struct held_lock *this,
-			     enum lock_usage_bit new_bit)
+		     enum lock_usage_bit new_bit)
 {
 	unsigned int new_mask = 1 << new_bit, ret = 1;
 
@@ -3458,7 +3456,7 @@ static struct held_lock *find_held_lock(struct task_struct *curr,
 }
 
 static int reacquire_held_locks(struct task_struct *curr, unsigned int depth,
-			      int idx)
+				int idx)
 {
 	struct held_lock *hlock;
 
@@ -3832,8 +3830,8 @@ void lock_downgrade(struct lockdep_map *lock, unsigned long ip)
  * and also avoid lockdep recursion:
  */
 void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
-			  int trylock, int read, int check,
-			  struct lockdep_map *nest_lock, unsigned long ip)
+		  int trylock, int read, int check,
+		  struct lockdep_map *nest_lock, unsigned long ip)
 {
 	unsigned long flags;
 
@@ -3852,8 +3850,7 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 }
 EXPORT_SYMBOL_GPL(lock_acquire);
 
-void lock_release(struct lockdep_map *lock, int nested,
-			  unsigned long ip)
+void lock_release(struct lockdep_map *lock, int nested, unsigned long ip)
 {
 	unsigned long flags;
 
-- 
1.8.3.1

