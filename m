Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C4D7BC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65614208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u6U2sYaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65614208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964972AbeFNUnH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 16:43:07 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46221 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964883AbeFNUnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:43:02 -0400
Received: by mail-pf0-f195.google.com with SMTP id q1-v6so3789499pff.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 13:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=UJwbJNMs04dIeKVBAebEWhPfPtcN23MJnfnhxxKttQM=;
        b=u6U2sYaOUzHlNi0VNgR7rgzd+tX7Uk9zM/yhFqkysahBbVI1LXzibyTVIbyV6yEAVn
         Vh0FpBoLloei1nyppDN+/x3lv2vi0CfSkGmxZDHvbgd4AA70/GMYOuxTEzxg0EOAsSro
         M1r+NUaIBU2JBrkwLYdUvQo3Fh0b8dXl/zm9Lt63Zp+PAuaLrRuojtsUpjgjX3VLBMVW
         7XbtjAgjcKRVzms9JAlyprrId3hLzvEEA3C/oA62IEvy0RSrSjQl/ZO0/am5/Ast6JJE
         WJBX7//BiUUL3sawUP22s6fxH9iz2tJOkYLuJdOoQbeFl86OoeHa0C3HmSmr12bcmq7C
         QqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=UJwbJNMs04dIeKVBAebEWhPfPtcN23MJnfnhxxKttQM=;
        b=fdTxp2JLZRvFWz4zB3OQgKyhdpYFpaU2Q/BbfX7QXkv/WfEuVOLNUKuRVHMf/gk9yj
         Djs7IntQDXZC2bKsg50RWNZ68Sa+w28Y5XM1ifcMBeCmv5In9AXhsF8jKK4/psfnisUh
         XK4IkSFOA2LCVhnLmfjGDQiSJjYCpa/TZcczGEuGR/OZjkY3+J5Ozp0NNC94VZOK9vu3
         ENCskPhoVrN8kFB635g82AFxXHnIo6mw355i640KrLtNCNaSY1Mf07cw5ySeIIM5J17t
         oI0UW8y+EsDorYvqywZPbisDM7HMjNcQ8dDxAozoxQ0mkOlewkeOVTRxSDIX1UZ4c+bB
         GVCw==
X-Gm-Message-State: APt69E1L0F9NsBotsrCVKdkqdrFVCclzVZw/IlnBkDsq1TrG6HACHYmY
        cjTWNMHAJ/Ae1VBaTh+xvLKCtg==
X-Google-Smtp-Source: ADUXVKIMPZe3LUhAGUVD8CRvVggACuXtRZSHzpVSExhrHhCD2WfXdnTnGqq84rHTJSepgwWjJHAb4w==
X-Received: by 2002:a62:701:: with SMTP id b1-v6mr11081071pfd.252.1529008981085;
        Thu, 14 Jun 2018 13:43:01 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id v15-v6sm11032942pfk.12.2018.06.14.13.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 13:43:00 -0700 (PDT)
Date:   Thu, 14 Jun 2018 13:42:59 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Michal Hocko <mhocko@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [patch] mm, oom: fix unnecessary killing of additional processes
In-Reply-To: <alpine.DEB.2.21.1805241422070.182300@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1806141339580.4543@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1805241422070.182300@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The oom reaper ensures forward progress by setting MMF_OOM_SKIP itself if
it cannot reap an mm.  This can happen for a variety of reasons,
including:

 - the inability to grab mm->mmap_sem in a sufficient amount of time,

 - when the mm has blockable mmu notifiers that could cause the oom reaper
   to stall indefinitely,

but we can also add a third when the oom reaper can "reap" an mm but doing
so is unlikely to free any amount of memory:

 - when the mm's memory is fully mlocked.

When all memory is mlocked, the oom reaper will not be able to free any
substantial amount of memory.  It sets MMF_OOM_SKIP before the victim can
unmap and free its memory in exit_mmap() and subsequent oom victims are
chosen unnecessarily.  This is trivial to reproduce if all eligible
processes on the system have mlocked their memory: the oom killer calls
panic() even though forward progress can be made.

This is the same issue where the exit path sets MMF_OOM_SKIP before
unmapping memory and additional processes can be chosen unnecessarily
because the oom killer is racing with exit_mmap().

We can't simply defer setting MMF_OOM_SKIP, however, because if there is
a true oom livelock in progress, it never gets set and no additional
killing is possible.

To fix this, this patch introduces a per-mm reaping timeout, initially set
at 10s.  It requires that the oom reaper's list becomes a properly linked
list so that other mm's may be reaped while waiting for an mm's timeout to
expire.

This replaces the current timeouts in the oom reaper: (1) when trying to
grab mm->mmap_sem 10 times in a row with HZ/10 sleeps in between and (2)
a HZ sleep if there are blockable mmu notifiers.  It extends it with
timeout to allow an oom victim to reach exit_mmap() before choosing
additional processes unnecessarily.

The exit path will now set MMF_OOM_SKIP only after all memory has been
freed, so additional oom killing is justified, and rely on MMF_UNSTABLE to
determine when it can race with the oom reaper.

The oom reaper will now set MMF_OOM_SKIP only after the reap timeout has
lapsed because it can no longer guarantee forward progress.

The reaping timeout is intentionally set for a substantial amount of time
since oom livelock is a very rare occurrence and it's better to optimize
for preventing additional (unnecessary) oom killing than a scenario that
is much more unlikely.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 Note: I understand there is an objection based on timeout based delays.
 This is currently the only possible way to avoid oom killing important
 processes completely unnecessarily.  If the oom reaper can someday free
 all memory, including mlocked memory and those mm's with blockable mmu
 notifiers, and is guaranteed to always be able to grab mm->mmap_sem,
 this can be removed.  I do not believe any such guarantee is possible
 and consider the massive killing of additional processes unnecessarily
 to be a regression introduced by the oom reaper and its very quick
 setting of MMF_OOM_SKIP to allow additional processes to be oom killed.

 include/linux/mm_types.h |   4 ++
 include/linux/sched.h    |   2 +-
 kernel/fork.c            |   4 ++
 mm/mmap.c                |  12 ++---
 mm/oom_kill.c            | 112 ++++++++++++++++++++++-----------------
 5 files changed, 79 insertions(+), 55 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -449,6 +449,10 @@ struct mm_struct {
 #ifdef CONFIG_MMU_NOTIFIER
 	struct mmu_notifier_mm *mmu_notifier_mm;
 #endif
+#ifdef CONFIG_MMU
+	/* When to give up on oom reaping this mm */
+	unsigned long reap_timeout;
+#endif
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
 	pgtable_t pmd_huge_pte; /* protected by page_table_lock */
 #endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1163,7 +1163,7 @@ struct task_struct {
 #endif
 	int				pagefault_disabled;
 #ifdef CONFIG_MMU
-	struct task_struct		*oom_reaper_list;
+	struct list_head		oom_reap_list;
 #endif
 #ifdef CONFIG_VMAP_STACK
 	struct vm_struct		*stack_vm_area;
diff --git a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -835,6 +835,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->fail_nth = 0;
 #endif
 
+#ifdef CONFIG_MMU
+	INIT_LIST_HEAD(&tsk->oom_reap_list);
+#endif
+
 	return tsk;
 
 free_stack:
diff --git a/mm/mmap.c b/mm/mmap.c
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3059,11 +3059,10 @@ void exit_mmap(struct mm_struct *mm)
 	if (unlikely(mm_is_oom_victim(mm))) {
 		/*
 		 * Manually reap the mm to free as much memory as possible.
-		 * Then, as the oom reaper does, set MMF_OOM_SKIP to disregard
-		 * this mm from further consideration.  Taking mm->mmap_sem for
-		 * write after setting MMF_OOM_SKIP will guarantee that the oom
-		 * reaper will not run on this mm again after mmap_sem is
-		 * dropped.
+		 * Then, set MMF_UNSTABLE to avoid racing with the oom reaper.
+		 * Taking mm->mmap_sem for write after setting MMF_UNSTABLE will
+		 * guarantee that the oom reaper will not run on this mm again
+		 * after mmap_sem is dropped.
 		 *
 		 * Nothing can be holding mm->mmap_sem here and the above call
 		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
@@ -3077,7 +3076,7 @@ void exit_mmap(struct mm_struct *mm)
 		__oom_reap_task_mm(mm);
 		mutex_unlock(&oom_lock);
 
-		set_bit(MMF_OOM_SKIP, &mm->flags);
+		set_bit(MMF_UNSTABLE, &mm->flags);
 		down_write(&mm->mmap_sem);
 		up_write(&mm->mmap_sem);
 	}
@@ -3105,6 +3104,7 @@ void exit_mmap(struct mm_struct *mm)
 	unmap_vmas(&tlb, vma, 0, -1);
 	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb, 0, -1);
+	set_bit(MMF_OOM_SKIP, &mm->flags);
 
 	/*
 	 * Walk the list again, actually closing and freeing it,
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -476,7 +476,7 @@ bool process_shares_mm(struct task_struct *p, struct mm_struct *mm)
  */
 static struct task_struct *oom_reaper_th;
 static DECLARE_WAIT_QUEUE_HEAD(oom_reaper_wait);
-static struct task_struct *oom_reaper_list;
+static LIST_HEAD(oom_reaper_list);
 static DEFINE_SPINLOCK(oom_reaper_lock);
 
 void __oom_reap_task_mm(struct mm_struct *mm)
@@ -519,10 +519,8 @@ void __oom_reap_task_mm(struct mm_struct *mm)
 	}
 }
 
-static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
+static void oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 {
-	bool ret = true;
-
 	/*
 	 * We have to make sure to not race with the victim exit path
 	 * and cause premature new oom victim selection:
@@ -540,9 +538,8 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 	mutex_lock(&oom_lock);
 
 	if (!down_read_trylock(&mm->mmap_sem)) {
-		ret = false;
 		trace_skip_task_reaping(tsk->pid);
-		goto unlock_oom;
+		goto out_oom;
 	}
 
 	/*
@@ -551,69 +548,81 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 	 * TODO: we really want to get rid of this ugly hack and make sure that
 	 * notifiers cannot block for unbounded amount of time
 	 */
-	if (mm_has_blockable_invalidate_notifiers(mm)) {
-		up_read(&mm->mmap_sem);
-		schedule_timeout_idle(HZ);
-		goto unlock_oom;
-	}
+	if (mm_has_blockable_invalidate_notifiers(mm))
+		goto out_mm;
 
 	/*
-	 * MMF_OOM_SKIP is set by exit_mmap when the OOM reaper can't
-	 * work on the mm anymore. The check for MMF_OOM_SKIP must run
+	 * MMF_UNSTABLE is set by exit_mmap when the OOM reaper can't
+	 * work on the mm anymore. The check for MMF_UNSTABLE must run
 	 * under mmap_sem for reading because it serializes against the
 	 * down_write();up_write() cycle in exit_mmap().
 	 */
-	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
-		up_read(&mm->mmap_sem);
+	if (test_bit(MMF_UNSTABLE, &mm->flags)) {
 		trace_skip_task_reaping(tsk->pid);
-		goto unlock_oom;
+		goto out_mm;
 	}
 
 	trace_start_task_reaping(tsk->pid);
-
 	__oom_reap_task_mm(mm);
+	trace_finish_task_reaping(tsk->pid);
 
 	pr_info("oom_reaper: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
 			task_pid_nr(tsk), tsk->comm,
 			K(get_mm_counter(mm, MM_ANONPAGES)),
 			K(get_mm_counter(mm, MM_FILEPAGES)),
 			K(get_mm_counter(mm, MM_SHMEMPAGES)));
+out_mm:
 	up_read(&mm->mmap_sem);
-
-	trace_finish_task_reaping(tsk->pid);
-unlock_oom:
+out_oom:
 	mutex_unlock(&oom_lock);
-	return ret;
 }
 
-#define MAX_OOM_REAP_RETRIES 10
 static void oom_reap_task(struct task_struct *tsk)
 {
-	int attempts = 0;
 	struct mm_struct *mm = tsk->signal->oom_mm;
 
-	/* Retry the down_read_trylock(mmap_sem) a few times */
-	while (attempts++ < MAX_OOM_REAP_RETRIES && !oom_reap_task_mm(tsk, mm))
-		schedule_timeout_idle(HZ/10);
+	/*
+	 * If this mm has either been fully unmapped, or the oom reaper has
+	 * given up on it, nothing left to do except drop the refcount.
+	 */
+	if (test_bit(MMF_OOM_SKIP, &mm->flags))
+		goto drop;
 
-	if (attempts <= MAX_OOM_REAP_RETRIES ||
-	    test_bit(MMF_OOM_SKIP, &mm->flags))
-		goto done;
+	/*
+	 * If this mm has already been reaped, doing so again will not likely
+	 * free additional memory.
+	 */
+	if (!test_bit(MMF_UNSTABLE, &mm->flags))
+		oom_reap_task_mm(tsk, mm);
 
-	pr_info("oom_reaper: unable to reap pid:%d (%s)\n",
-		task_pid_nr(tsk), tsk->comm);
-	debug_show_all_locks();
+	if (time_after_eq(jiffies, mm->reap_timeout)) {
+		if (!test_bit(MMF_OOM_SKIP, &mm->flags)) {
+			pr_info("oom_reaper: unable to reap pid:%d (%s)\n",
+				task_pid_nr(tsk), tsk->comm);
+			debug_show_all_locks();
 
-done:
-	tsk->oom_reaper_list = NULL;
+			/*
+			 * Reaping has failed for the timeout period, so give up
+			 * and allow additional processes to be oom killed.
+			 */
+			set_bit(MMF_OOM_SKIP, &mm->flags);
+		}
+		goto drop;
+	}
 
-	/*
-	 * Hide this mm from OOM killer because it has been either reaped or
-	 * somebody can't call up_write(mmap_sem).
-	 */
-	set_bit(MMF_OOM_SKIP, &mm->flags);
+	if (test_bit(MMF_OOM_SKIP, &mm->flags))
+		goto drop;
 
-	/* Drop a reference taken by wake_oom_reaper */
+	/* Enqueue to be reaped again */
+	spin_lock(&oom_reaper_lock);
+	list_add_tail(&tsk->oom_reap_list, &oom_reaper_list);
+	spin_unlock(&oom_reaper_lock);
+
+	schedule_timeout_idle(HZ/10);
+	return;
+
+drop:
+	/* Drop the reference taken by wake_oom_reaper */
 	put_task_struct(tsk);
 }
 
@@ -622,11 +631,13 @@ static int oom_reaper(void *unused)
 	while (true) {
 		struct task_struct *tsk = NULL;
 
-		wait_event_freezable(oom_reaper_wait, oom_reaper_list != NULL);
+		wait_event_freezable(oom_reaper_wait,
+				     !list_empty(&oom_reaper_list));
 		spin_lock(&oom_reaper_lock);
-		if (oom_reaper_list != NULL) {
-			tsk = oom_reaper_list;
-			oom_reaper_list = tsk->oom_reaper_list;
+		if (!list_empty(&oom_reaper_list)) {
+			tsk = list_entry(oom_reaper_list.next,
+					 struct task_struct, oom_reap_list);
+			list_del(&tsk->oom_reap_list);
 		}
 		spin_unlock(&oom_reaper_lock);
 
@@ -637,17 +648,22 @@ static int oom_reaper(void *unused)
 	return 0;
 }
 
+/* How long to wait to oom reap an mm before selecting another process */
+#define OOM_REAP_TIMEOUT_MSECS (10 * 1000)
 static void wake_oom_reaper(struct task_struct *tsk)
 {
-	/* tsk is already queued? */
-	if (tsk == oom_reaper_list || tsk->oom_reaper_list)
+	/*
+	 * Set the reap timeout; if it's already set, the mm is enqueued and
+	 * this tsk can be ignored.
+	 */
+	if (cmpxchg(&tsk->signal->oom_mm->reap_timeout, 0UL,
+			jiffies + msecs_to_jiffies(OOM_REAP_TIMEOUT_MSECS)))
 		return;
 
 	get_task_struct(tsk);
 
 	spin_lock(&oom_reaper_lock);
-	tsk->oom_reaper_list = oom_reaper_list;
-	oom_reaper_list = tsk;
+	list_add(&tsk->oom_reap_list, &oom_reaper_list);
 	spin_unlock(&oom_reaper_lock);
 	trace_wake_reaper(tsk->pid);
 	wake_up(&oom_reaper_wait);
