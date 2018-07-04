Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C33C6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4B524730
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gWjofe7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4B524730
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932790AbeGDBnx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 21:43:53 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42094 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932364AbeGDBnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 21:43:51 -0400
Received: by mail-pf0-f194.google.com with SMTP id v9-v6so1842370pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 18:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=VRgpF/hmL6dOWqwWnPonXNMTu8ZaWF5X+sVt/Lnso5o=;
        b=gWjofe7lQZ5vco5/xapID4nlwDr3e3FM0nHjmK444mZBL7CtEcggcg8tynQ8M2G+Oi
         H2MxKiJHCQcQVMFL+oAWxrMr8Ldmf8Ez7LhfS0mm28lv+naDvG32f2Du8qKmAvjLCuxD
         9fR6ISxL0sZ1arqIfPKaWs2rbyB3JkWADqnjd5EiNt/Fiwbmfl1cAKIgqWOt0++wFuJL
         Smw3vEPsBh8CcibNXFa8xAQdu3CCT2mOvhLdqZO0IjQf0CJrtoMrasc2E+vtCbmY8NlC
         vhC/ph1pFX+Nw4GX36GKC8gcNZ0cvGOatZkvvQGf3Bbh915F1fl4a5Mj8gzyojZ19evc
         dy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=VRgpF/hmL6dOWqwWnPonXNMTu8ZaWF5X+sVt/Lnso5o=;
        b=ehr1nbzSdRlCk+SFKXT7WF4lJfRGiABOJZdz7nZM4oCgwei6XqB+dkhawRz+2zU9Q7
         QaYO7ktbiE4dtWqNp/+KXZZLKyw5U8a55gF3fUF1W5efe6g1u/ndh0tYL9dD0Sykw6rJ
         Vvm0gBdhl6riNO0TDzaWdP6YuBkhadubl7vPFY1YiFTqjLUpJfy0bwVRJEhWsa60aBvW
         /OmssyDPDhzyKnMLdO2fgbMtOTnmW3oIaID2rD2f1Sf2a1MfspVKM8VD5Fnu++c9cG5Y
         ISfzoYsyj64hqbox+5NbFQz61zbN5eE+PFL8UllbyuETGFTtL9pN2pjnFbK1fy4+lh6h
         ewqA==
X-Gm-Message-State: APt69E3WoP7SyTxcFU1ggoAR0P+iCieUtZPidw8O25+U9mN8X5M4m40D
        +udlNCTEzcqp/99SCcz+URQck5U0mu8=
X-Google-Smtp-Source: AAOMgpckOH2IGsbmb0CEuHZhQzqjECD5JG7Sl9hJzWmVRvEpbJZiGBj2mSUAmJjda+FiVJ70Cg7pow==
X-Received: by 2002:a62:9c9c:: with SMTP id u28-v6mr88584pfk.90.1530668630555;
        Tue, 03 Jul 2018 18:43:50 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id l6-v6sm5896203pfc.172.2018.07.03.18.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 18:43:49 -0700 (PDT)
Date:   Tue, 3 Jul 2018 18:43:49 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Michal Hocko <mhocko@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v3] mm, oom: fix unnecessary killing of additional
 processes
In-Reply-To: <alpine.DEB.2.21.1806211434420.51095@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1807031841220.110853@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1806211434420.51095@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

This can be something that can easily be removed if it becomes obsoleted 
because the oom reaper is always able to free memory to the extent of 
exit_mmap().  I argue that it cannot, because it cannot do free_pgtables() 
for large amounts of virtual memory, but am fine to be proved wrong.

In the meantime, however, this patch should introduce no significant 
change in functionality and the only interface it is added is in debugfs 
and can easily be removed if it is obsoleted.

The work to make the oom reaper more effective or realible can still 
continue with this patch.



On Thu, 21 Jun 2018, David Rientjes wrote:

> The oom reaper ensures forward progress by setting MMF_OOM_SKIP itself if
> it cannot reap an mm.  This can happen for a variety of reasons,
> including:
> 
>  - the inability to grab mm->mmap_sem in a sufficient amount of time,
> 
>  - when the mm has blockable mmu notifiers that could cause the oom reaper
>    to stall indefinitely,
> 
> but we can also add a third when the oom reaper can "reap" an mm but doing
> so is unlikely to free any amount of memory:
> 
>  - when the mm's memory is mostly mlocked.
> 
> When all memory is mlocked, the oom reaper will not be able to free any
> substantial amount of memory.  It sets MMF_OOM_SKIP before the victim can
> unmap and free its memory in exit_mmap() and subsequent oom victims are
> chosen unnecessarily.  This is trivial to reproduce if all eligible
> processes on the system have mlocked their memory: the oom killer calls
> panic() even though forward progress can be made.
> 
> This is the same issue where the exit path sets MMF_OOM_SKIP before
> unmapping memory and additional processes can be chosen unnecessarily
> because the oom killer is racing with exit_mmap() and is separate from
> the oom reaper setting MMF_OOM_SKIP prematurely.
> 
> We can't simply defer setting MMF_OOM_SKIP, however, because if there is
> a true oom livelock in progress, it never gets set and no additional
> killing is possible.
> 
> To fix this, this patch introduces a per-mm reaping period, which is
> configurable through the new oom_free_timeout_ms file in debugfs and
> defaults to one second to match the current heuristics.  This support
> requires that the oom reaper's list becomes a proper linked list so that
> other mm's may be reaped while waiting for an mm's timeout to expire.
> 
> This replaces the current timeouts in the oom reaper: (1) when trying to
> grab mm->mmap_sem 10 times in a row with HZ/10 sleeps in between and (2)
> a HZ sleep if there are blockable mmu notifiers.  It extends it with
> timeout to allow an oom victim to reach exit_mmap() before choosing
> additional processes unnecessarily.
> 
> The exit path will now set MMF_OOM_SKIP only after all memory has been
> freed, so additional oom killing is justified, and rely on MMF_UNSTABLE to
> determine when it can race with the oom reaper.
> 
> The oom reaper will now set MMF_OOM_SKIP only after the reap timeout has
> lapsed because it can no longer guarantee forward progress.  Since the
> default oom_free_timeout_ms is one second, the same as current heuristics,
> there should be no functional change with this patch for users who do not
> tune it to be longer other than MMF_OOM_SKIP is set by exit_mmap() after
> free_pgtables(), which is the preferred behavior.
> 
> The reaping timeout can intentionally be set for a substantial amount of
> time, such as 10s, since oom livelock is a very rare occurrence and it's
> better to optimize for preventing additional (unnecessary) oom killing
> than a scenario that is much more unlikely.
> 
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  v3:
>   - oom_free_timeout_ms is now static per kbuild test robot
> 
>  v2:
>   - configurable timeout period through debugfs
>   - change mm->reap_timeout to mm->oom_free_expire and add more
>     descriptive comment per akpm
>   - add comment to describe task->oom_reap_list locking based on
>     oom_reaper_lock per akpm
>   - rework the exit_mmap() comment and split into two parts to be more
>     descriptive about the locking and the issue with the oom reaper
>     racing with munlock_vma_pages_all() per akpm
> ---
>  include/linux/mm_types.h |   7 ++
>  include/linux/sched.h    |   3 +-
>  kernel/fork.c            |   3 +
>  mm/mmap.c                |  26 +++++---
>  mm/oom_kill.c            | 140 +++++++++++++++++++++++++--------------
>  5 files changed, 119 insertions(+), 60 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -449,6 +449,13 @@ struct mm_struct {
>  #ifdef CONFIG_MMU_NOTIFIER
>  	struct mmu_notifier_mm *mmu_notifier_mm;
>  #endif
> +#ifdef CONFIG_MMU
> +	/*
> +	 * When to give up on memory freeing from this mm after its
> +	 * threads have been oom killed, in jiffies.
> +	 */
> +	unsigned long oom_free_expire;
> +#endif
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
>  	pgtable_t pmd_huge_pte; /* protected by page_table_lock */
>  #endif
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1163,7 +1163,8 @@ struct task_struct {
>  #endif
>  	int				pagefault_disabled;
>  #ifdef CONFIG_MMU
> -	struct task_struct		*oom_reaper_list;
> +	/* OOM victim queue for oom reaper, protected by oom_reaper_lock */
> +	struct list_head		oom_reap_list;
>  #endif
>  #ifdef CONFIG_VMAP_STACK
>  	struct vm_struct		*stack_vm_area;
> diff --git a/kernel/fork.c b/kernel/fork.c
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -842,6 +842,9 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
>  #ifdef CONFIG_FAULT_INJECTION
>  	tsk->fail_nth = 0;
>  #endif
> +#ifdef CONFIG_MMU
> +	INIT_LIST_HEAD(&tsk->oom_reap_list);
> +#endif
>  
>  	return tsk;
>  
> diff --git a/mm/mmap.c b/mm/mmap.c
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3059,25 +3059,28 @@ void exit_mmap(struct mm_struct *mm)
>  	if (unlikely(mm_is_oom_victim(mm))) {
>  		/*
>  		 * Manually reap the mm to free as much memory as possible.
> -		 * Then, as the oom reaper does, set MMF_OOM_SKIP to disregard
> -		 * this mm from further consideration.  Taking mm->mmap_sem for
> -		 * write after setting MMF_OOM_SKIP will guarantee that the oom
> -		 * reaper will not run on this mm again after mmap_sem is
> -		 * dropped.
> -		 *
>  		 * Nothing can be holding mm->mmap_sem here and the above call
>  		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
>  		 * __oom_reap_task_mm() will not block.
> -		 *
> -		 * This needs to be done before calling munlock_vma_pages_all(),
> -		 * which clears VM_LOCKED, otherwise the oom reaper cannot
> -		 * reliably test it.
>  		 */
>  		mutex_lock(&oom_lock);
>  		__oom_reap_task_mm(mm);
>  		mutex_unlock(&oom_lock);
>  
> -		set_bit(MMF_OOM_SKIP, &mm->flags);
> +		/*
> +		 * Now, set MMF_UNSTABLE to avoid racing with the oom reaper.
> +		 * This needs to be done before calling munlock_vma_pages_all(),
> +		 * which clears VM_LOCKED, otherwise the oom reaper cannot
> +		 * reliably test for it.  If the oom reaper races with
> +		 * munlock_vma_pages_all(), this can result in a kernel oops if
> +		 * a pmd is zapped, for example, after follow_page_mask() has
> +		 * checked pmd_none().
> +		 *
> +		 * Taking mm->mmap_sem for write after setting MMF_UNSTABLE will
> +		 * guarantee that the oom reaper will not run on this mm again
> +		 * after mmap_sem is dropped.
> +		 */
> +		set_bit(MMF_UNSTABLE, &mm->flags);
>  		down_write(&mm->mmap_sem);
>  		up_write(&mm->mmap_sem);
>  	}
> @@ -3105,6 +3108,7 @@ void exit_mmap(struct mm_struct *mm)
>  	unmap_vmas(&tlb, vma, 0, -1);
>  	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
>  	tlb_finish_mmu(&tlb, 0, -1);
> +	set_bit(MMF_OOM_SKIP, &mm->flags);
>  
>  	/*
>  	 * Walk the list again, actually closing and freeing it,
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -41,6 +41,7 @@
>  #include <linux/kthread.h>
>  #include <linux/init.h>
>  #include <linux/mmu_notifier.h>
> +#include <linux/debugfs.h>
>  
>  #include <asm/tlb.h>
>  #include "internal.h"
> @@ -476,7 +477,7 @@ bool process_shares_mm(struct task_struct *p, struct mm_struct *mm)
>   */
>  static struct task_struct *oom_reaper_th;
>  static DECLARE_WAIT_QUEUE_HEAD(oom_reaper_wait);
> -static struct task_struct *oom_reaper_list;
> +static LIST_HEAD(oom_reaper_list);
>  static DEFINE_SPINLOCK(oom_reaper_lock);
>  
>  void __oom_reap_task_mm(struct mm_struct *mm)
> @@ -519,10 +520,8 @@ void __oom_reap_task_mm(struct mm_struct *mm)
>  	}
>  }
>  
> -static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
> +static void oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
>  {
> -	bool ret = true;
> -
>  	/*
>  	 * We have to make sure to not race with the victim exit path
>  	 * and cause premature new oom victim selection:
> @@ -540,9 +539,8 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
>  	mutex_lock(&oom_lock);
>  
>  	if (!down_read_trylock(&mm->mmap_sem)) {
> -		ret = false;
>  		trace_skip_task_reaping(tsk->pid);
> -		goto unlock_oom;
> +		goto out_oom;
>  	}
>  
>  	/*
> @@ -551,69 +549,81 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
>  	 * TODO: we really want to get rid of this ugly hack and make sure that
>  	 * notifiers cannot block for unbounded amount of time
>  	 */
> -	if (mm_has_blockable_invalidate_notifiers(mm)) {
> -		up_read(&mm->mmap_sem);
> -		schedule_timeout_idle(HZ);
> -		goto unlock_oom;
> -	}
> +	if (mm_has_blockable_invalidate_notifiers(mm))
> +		goto out_mm;
>  
>  	/*
> -	 * MMF_OOM_SKIP is set by exit_mmap when the OOM reaper can't
> -	 * work on the mm anymore. The check for MMF_OOM_SKIP must run
> +	 * MMF_UNSTABLE is set by exit_mmap when the OOM reaper can't
> +	 * work on the mm anymore. The check for MMF_UNSTABLE must run
>  	 * under mmap_sem for reading because it serializes against the
>  	 * down_write();up_write() cycle in exit_mmap().
>  	 */
> -	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
> -		up_read(&mm->mmap_sem);
> +	if (test_bit(MMF_UNSTABLE, &mm->flags)) {
>  		trace_skip_task_reaping(tsk->pid);
> -		goto unlock_oom;
> +		goto out_mm;
>  	}
>  
>  	trace_start_task_reaping(tsk->pid);
> -
>  	__oom_reap_task_mm(mm);
> +	trace_finish_task_reaping(tsk->pid);
>  
>  	pr_info("oom_reaper: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
>  			task_pid_nr(tsk), tsk->comm,
>  			K(get_mm_counter(mm, MM_ANONPAGES)),
>  			K(get_mm_counter(mm, MM_FILEPAGES)),
>  			K(get_mm_counter(mm, MM_SHMEMPAGES)));
> +out_mm:
>  	up_read(&mm->mmap_sem);
> -
> -	trace_finish_task_reaping(tsk->pid);
> -unlock_oom:
> +out_oom:
>  	mutex_unlock(&oom_lock);
> -	return ret;
>  }
>  
> -#define MAX_OOM_REAP_RETRIES 10
>  static void oom_reap_task(struct task_struct *tsk)
>  {
> -	int attempts = 0;
>  	struct mm_struct *mm = tsk->signal->oom_mm;
>  
> -	/* Retry the down_read_trylock(mmap_sem) a few times */
> -	while (attempts++ < MAX_OOM_REAP_RETRIES && !oom_reap_task_mm(tsk, mm))
> -		schedule_timeout_idle(HZ/10);
> +	/*
> +	 * If this mm has either been fully unmapped, or the oom reaper has
> +	 * given up on it, nothing left to do except drop the refcount.
> +	 */
> +	if (test_bit(MMF_OOM_SKIP, &mm->flags))
> +		goto drop;
>  
> -	if (attempts <= MAX_OOM_REAP_RETRIES ||
> -	    test_bit(MMF_OOM_SKIP, &mm->flags))
> -		goto done;
> +	/*
> +	 * If this mm has already been reaped, doing so again will not likely
> +	 * free additional memory.
> +	 */
> +	if (!test_bit(MMF_UNSTABLE, &mm->flags))
> +		oom_reap_task_mm(tsk, mm);
>  
> -	pr_info("oom_reaper: unable to reap pid:%d (%s)\n",
> -		task_pid_nr(tsk), tsk->comm);
> -	debug_show_all_locks();
> +	if (time_after_eq(jiffies, mm->oom_free_expire)) {
> +		if (!test_bit(MMF_OOM_SKIP, &mm->flags)) {
> +			pr_info("oom_reaper: unable to reap pid:%d (%s)\n",
> +				task_pid_nr(tsk), tsk->comm);
> +			debug_show_all_locks();
>  
> -done:
> -	tsk->oom_reaper_list = NULL;
> +			/*
> +			 * Reaping has failed for the timeout period, so give up
> +			 * and allow additional processes to be oom killed.
> +			 */
> +			set_bit(MMF_OOM_SKIP, &mm->flags);
> +		}
> +		goto drop;
> +	}
>  
> -	/*
> -	 * Hide this mm from OOM killer because it has been either reaped or
> -	 * somebody can't call up_write(mmap_sem).
> -	 */
> -	set_bit(MMF_OOM_SKIP, &mm->flags);
> +	if (test_bit(MMF_OOM_SKIP, &mm->flags))
> +		goto drop;
> +
> +	/* Enqueue to be reaped again */
> +	spin_lock(&oom_reaper_lock);
> +	list_add_tail(&tsk->oom_reap_list, &oom_reaper_list);
> +	spin_unlock(&oom_reaper_lock);
>  
> -	/* Drop a reference taken by wake_oom_reaper */
> +	schedule_timeout_idle(HZ/10);
> +	return;
> +
> +drop:
> +	/* Drop the reference taken by wake_oom_reaper */
>  	put_task_struct(tsk);
>  }
>  
> @@ -622,11 +632,13 @@ static int oom_reaper(void *unused)
>  	while (true) {
>  		struct task_struct *tsk = NULL;
>  
> -		wait_event_freezable(oom_reaper_wait, oom_reaper_list != NULL);
> +		wait_event_freezable(oom_reaper_wait,
> +				     !list_empty(&oom_reaper_list));
>  		spin_lock(&oom_reaper_lock);
> -		if (oom_reaper_list != NULL) {
> -			tsk = oom_reaper_list;
> -			oom_reaper_list = tsk->oom_reaper_list;
> +		if (!list_empty(&oom_reaper_list)) {
> +			tsk = list_entry(oom_reaper_list.next,
> +					 struct task_struct, oom_reap_list);
> +			list_del(&tsk->oom_reap_list);
>  		}
>  		spin_unlock(&oom_reaper_lock);
>  
> @@ -637,25 +649,57 @@ static int oom_reaper(void *unused)
>  	return 0;
>  }
>  
> +/*
> + * Millisecs to wait for an oom mm to free memory before selecting another
> + * victim.
> + */
> +static u64 oom_free_timeout_ms = 1000;
>  static void wake_oom_reaper(struct task_struct *tsk)
>  {
> -	/* tsk is already queued? */
> -	if (tsk == oom_reaper_list || tsk->oom_reaper_list)
> +	/*
> +	 * Set the reap timeout; if it's already set, the mm is enqueued and
> +	 * this tsk can be ignored.
> +	 */
> +	if (cmpxchg(&tsk->signal->oom_mm->oom_free_expire, 0UL,
> +			jiffies + msecs_to_jiffies(oom_free_timeout_ms)))
>  		return;
>  
>  	get_task_struct(tsk);
>  
>  	spin_lock(&oom_reaper_lock);
> -	tsk->oom_reaper_list = oom_reaper_list;
> -	oom_reaper_list = tsk;
> +	list_add(&tsk->oom_reap_list, &oom_reaper_list);
>  	spin_unlock(&oom_reaper_lock);
>  	trace_wake_reaper(tsk->pid);
>  	wake_up(&oom_reaper_wait);
>  }
>  
> +#ifdef CONFIG_DEBUG_FS
> +static int oom_free_timeout_ms_read(void *data, u64 *val)
> +{
> +	*val = oom_free_timeout_ms;
> +	return 0;
> +}
> +
> +static int oom_free_timeout_ms_write(void *data, u64 val)
> +{
> +	if (val > 60 * 1000)
> +		return -EINVAL;
> +
> +	oom_free_timeout_ms = val;
> +	return 0;
> +}
> +DEFINE_SIMPLE_ATTRIBUTE(oom_free_timeout_ms_fops, oom_free_timeout_ms_read,
> +			oom_free_timeout_ms_write, "%llu\n");
> +#endif /* CONFIG_DEBUG_FS */
> +
>  static int __init oom_init(void)
>  {
>  	oom_reaper_th = kthread_run(oom_reaper, NULL, "oom_reaper");
> +#ifdef CONFIG_DEBUG_FS
> +	if (!IS_ERR(oom_reaper_th))
> +		debugfs_create_file("oom_free_timeout_ms", 0200, NULL, NULL,
> +				    &oom_free_timeout_ms_fops);
> +#endif
>  	return 0;
>  }
>  subsys_initcall(oom_init)
> 
