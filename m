Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B90DC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E093120652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cf7PMckG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E093120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933811AbeFTWgs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:36:48 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40208 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933555AbeFTWgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:36:47 -0400
Received: by mail-pf0-f193.google.com with SMTP id z24-v6so485373pfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 15:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ql9gs7/prN1ScVKvd7ntPk5Zl09MJbvQXf+MDEauG5A=;
        b=Cf7PMckGTRet1EKtknz7uYT6N6dOTu+DTma1z24Lx/EOSUSrQUQSwjqxns9BfRhSY7
         f8rmyetO35ONWqrL36/67GnfeZszrjs42glq/TvlANpNUMjEPFk8QW8B2klItMnadhSW
         yQRhHC2vfRQLxGZWiCinbHhHQ5F9gUFdWxBSEm4xe/qxkWP4pYhOvN+MoD1itIuhzkVG
         ucfWOg25hUpfVLwA9tjjikjG60gqNiUgwH6IBRZztfIFDpT63tbnmrMQbZnWyOOMYxOx
         kyTyJ9/wFfezfGEJlgQ6chBttWLF/nGEXDwlxLGh7QMeeJlK23ipI2++Y7PZpAHE4NU0
         uo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ql9gs7/prN1ScVKvd7ntPk5Zl09MJbvQXf+MDEauG5A=;
        b=QTt+Lz25VVPkCrzPgRdGNc2dZCAu/nZVxBeA5IStSB+QgvW1cKs40vjc8BJurqqg+V
         rKpi7kJ6DB/mbJKx+EK4zb8768jZGTtz3XusIEPwYGnkPD+qcCh3IhMMT3pTkBv2pDDx
         agTObjjZNtqSKdnYs4s2m79G1oj349GMZTfNiSMhlC1A2WvRUhHkexCh+kUPepsEhNOZ
         v6iYwgOZ6QvRZ5e6w54D63M8VPgckqsJ9UxX9b+SCcaag3perw5lf0wkxZH7mkzZmjLS
         3od5P27VWT8x4ukciE2G7Db59diaZrfMJTPH7zSNL+foWJsn0mJn6rTKCzL6vMIfKB+g
         GnXA==
X-Gm-Message-State: APt69E3ZDB2gYf5CUYYjw8iQq7nq8MnATHXCigw/5ZALOIzHTy0SndjY
        S2Xgr761+est9I79Ai3qVDi/HQ==
X-Google-Smtp-Source: ADUXVKI6fbGYfkSZNtK+yjT7VhdlA/XMPASbZiggY6YzPL79C2TLXHwsRa7TWhiJp4dnvEuVdR2nHQ==
X-Received: by 2002:a63:3641:: with SMTP id d62-v6mr19801870pga.18.1529534206395;
        Wed, 20 Jun 2018 15:36:46 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id q71-v6sm5528841pfd.165.2018.06.20.15.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 15:36:45 -0700 (PDT)
Date:   Wed, 20 Jun 2018 15:36:45 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     linux-mm@kvack.org, mhocko@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,oom: Bring OOM notifier callbacks to outside of OOM
 killer.
In-Reply-To: <1529493638-6389-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <alpine.DEB.2.21.1806201528490.16984@chino.kir.corp.google.com>
References: <1529493638-6389-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018, Tetsuo Handa wrote:

> Sleeping with oom_lock held can cause AB-BA lockup bug because
> __alloc_pages_may_oom() does not wait for oom_lock. Since
> blocking_notifier_call_chain() in out_of_memory() might sleep, sleeping
> with oom_lock held is currently an unavoidable problem.
> 
> As a preparation for not to sleep with oom_lock held, this patch brings
> OOM notifier callbacks to outside of OOM killer, with two small behavior
> changes explained below.
> 
> One is that this patch makes it impossible for SysRq-f and PF-OOM to
> reclaim via OOM notifier. But such change should be tolerable because
> "we unlikely try to use SysRq-f for reclaiming memory via OOM notifier
> callbacks" and "pagefault_out_of_memory() will be called when OOM killer
> selected current thread as an OOM victim after OOM notifier callbacks
> already failed to reclaim memory".
> 
> The other is that this patch makes it possible to reclaim memory via OOM
> notifier after OOM killer is disabled (that is, suspend/hibernate is in
> progress). But such change should be safe because of pm_suspended_storage()
> check.
> 

Makes sense in general and I don't think that getting around these two 
caveats is problematic.  We should be handling everything that can free 
memory to preempt an oom kill in the page allocator and get rid of the 
notion that this is "oom notification" when in reality it is intended as 
the last form of reclaim prior to oom kill.

> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  include/linux/oom.h |  1 +
>  mm/oom_kill.c       | 35 ++++++++++++++++++------
>  mm/page_alloc.c     | 76 +++++++++++++++++++++++++++++++----------------------
>  3 files changed, 73 insertions(+), 39 deletions(-)
> 
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index 6adac11..085b033 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -101,6 +101,7 @@ extern unsigned long oom_badness(struct task_struct *p,
>  		struct mem_cgroup *memcg, const nodemask_t *nodemask,
>  		unsigned long totalpages);
>  
> +extern unsigned long try_oom_notifier(void);
>  extern bool out_of_memory(struct oom_control *oc);
>  
>  extern void exit_oom_victim(void);
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 84081e7..2ff5db2 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1010,6 +1010,33 @@ int unregister_oom_notifier(struct notifier_block *nb)
>  EXPORT_SYMBOL_GPL(unregister_oom_notifier);
>  
>  /**
> + * try_oom_notifier - Try to reclaim memory from OOM notifier list.
> + *
> + * Returns non-zero if notifier callbacks released something, zero otherwise.
> + */
> +unsigned long try_oom_notifier(void)

It certainly is tried, but based on its usage it would probably be better 
to describe what is being returned (it's going to set *did_some_progress, 
which is a page count).

That makes me think that "oom_notify_list" isn't very intuitive: it can 
free memory as a last step prior to oom kill.  OOM notify, to me, sounds 
like its only notifying some callbacks about the condition.  Maybe 
oom_reclaim_list and then rename this to oom_reclaim_pages()?

> +{
> +	static DEFINE_MUTEX(oom_notifier_lock);
> +	unsigned long freed = 0;
> +
> +	/*
> +	 * Since OOM notifier callbacks must not depend on __GFP_DIRECT_RECLAIM
> +	 * && !__GFP_NORETRY memory allocation, waiting for mutex here is safe.
> +	 * If lockdep reports possible deadlock dependency, it will be a bug in
> +	 * OOM notifier callbacks.
> +	 *
> +	 * If SIGKILL is pending, it is likely that current thread was selected
> +	 * as an OOM victim. In that case, current thread should return as soon
> +	 * as possible using memory reserves.
> +	 */
> +	if (mutex_lock_killable(&oom_notifier_lock))
> +		return 0;
> +	blocking_notifier_call_chain(&oom_notify_list, 0, &freed);
> +	mutex_unlock(&oom_notifier_lock);
> +	return freed;
> +}

If __blocking_notifier_call_chain() used down_read_killable(), could we 
eliminate oom_notifier_lock?

> +
> +/**
>   * out_of_memory - kill the "best" process when we run out of memory
>   * @oc: pointer to struct oom_control
>   *
> @@ -1020,19 +1047,11 @@ int unregister_oom_notifier(struct notifier_block *nb)
>   */
>  bool out_of_memory(struct oom_control *oc)
>  {
> -	unsigned long freed = 0;
>  	enum oom_constraint constraint = CONSTRAINT_NONE;
>  
>  	if (oom_killer_disabled)
>  		return false;
>  
> -	if (!is_memcg_oom(oc)) {
> -		blocking_notifier_call_chain(&oom_notify_list, 0, &freed);
> -		if (freed > 0)
> -			/* Got some memory back in the last second. */
> -			return true;
> -	}
> -
>  	/*
>  	 * If current has a pending SIGKILL or is exiting, then automatically
>  	 * select it.  The goal is to allow it to allocate so that it may
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1521100..c72ef1e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3447,10 +3447,50 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
>  	return page;
>  }
>  
> +static inline bool can_oomkill(gfp_t gfp_mask, unsigned int order,
> +			       const struct alloc_context *ac)

I'd suggest a more mm/page_alloc.c friendly name, something like 
oom_kill_allowed().

> +{
> +	/* Coredumps can quickly deplete all memory reserves */
> +	if (current->flags & PF_DUMPCORE)
> +		return false;
> +	/* The OOM killer will not help higher order allocs */
> +	if (order > PAGE_ALLOC_COSTLY_ORDER)
> +		return false;
> +	/*
> +	 * We have already exhausted all our reclaim opportunities without any
> +	 * success so it is time to admit defeat. We will skip the OOM killer
> +	 * because it is very likely that the caller has a more reasonable
> +	 * fallback than shooting a random task.
> +	 */
> +	if (gfp_mask & __GFP_RETRY_MAYFAIL)
> +		return false;
> +	/* The OOM killer does not needlessly kill tasks for lowmem */
> +	if (ac->high_zoneidx < ZONE_NORMAL)
> +		return false;
> +	if (pm_suspended_storage())
> +		return false;
> +	/*
> +	 * XXX: GFP_NOFS allocations should rather fail than rely on
> +	 * other request to make a forward progress.
> +	 * We are in an unfortunate situation where out_of_memory cannot
> +	 * do much for this context but let's try it to at least get
> +	 * access to memory reserved if the current task is killed (see
> +	 * out_of_memory). Once filesystems are ready to handle allocation
> +	 * failures more gracefully we should just bail out here.
> +	 */
> +
> +	/* The OOM killer may not free memory on a specific node */
> +	if (gfp_mask & __GFP_THISNODE)
> +		return false;
> +
> +	return true;
> +}
> +
>  static inline struct page *
>  __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>  	const struct alloc_context *ac, unsigned long *did_some_progress)
>  {
> +	const bool oomkill = can_oomkill(gfp_mask, order, ac);
>  	struct oom_control oc = {
>  		.zonelist = ac->zonelist,
>  		.nodemask = ac->nodemask,
> @@ -3462,6 +3502,10 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
>  
>  	*did_some_progress = 0;
>  
> +	/* Try to reclaim via OOM notifier callback. */
> +	if (oomkill)
> +		*did_some_progress = try_oom_notifier();
> +
>  	/*
>  	 * Acquire the oom lock.  If that fails, somebody else is
>  	 * making progress for us.

*did_some_progress = oom_kill_allowed ? oom_reclaim_pages() : 0;

This patch is certainly an improvement because it does the last 
get_page_from_freelist() call after invoking the oom notifiers that can 
free memory and we've otherwise pointlessly redirected it elsewhere.

> @@ -3485,37 +3529,7 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
>  	if (page)
>  		goto out;
>  
> -	/* Coredumps can quickly deplete all memory reserves */
> -	if (current->flags & PF_DUMPCORE)
> -		goto out;
> -	/* The OOM killer will not help higher order allocs */
> -	if (order > PAGE_ALLOC_COSTLY_ORDER)
> -		goto out;
> -	/*
> -	 * We have already exhausted all our reclaim opportunities without any
> -	 * success so it is time to admit defeat. We will skip the OOM killer
> -	 * because it is very likely that the caller has a more reasonable
> -	 * fallback than shooting a random task.
> -	 */
> -	if (gfp_mask & __GFP_RETRY_MAYFAIL)
> -		goto out;
> -	/* The OOM killer does not needlessly kill tasks for lowmem */
> -	if (ac->high_zoneidx < ZONE_NORMAL)
> -		goto out;
> -	if (pm_suspended_storage())
> -		goto out;
> -	/*
> -	 * XXX: GFP_NOFS allocations should rather fail than rely on
> -	 * other request to make a forward progress.
> -	 * We are in an unfortunate situation where out_of_memory cannot
> -	 * do much for this context but let's try it to at least get
> -	 * access to memory reserved if the current task is killed (see
> -	 * out_of_memory). Once filesystems are ready to handle allocation
> -	 * failures more gracefully we should just bail out here.
> -	 */
> -
> -	/* The OOM killer may not free memory on a specific node */
> -	if (gfp_mask & __GFP_THISNODE)
> +	if (!oomkill)
>  		goto out;
>  
>  	/* Exhausted what can be done so it's blame time */
