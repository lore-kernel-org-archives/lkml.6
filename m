Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C593C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 11:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D06218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 11:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="farlpYsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfAZL3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 06:29:34 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35195 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfAZL3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 06:29:34 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so8731903lfc.2;
        Sat, 26 Jan 2019 03:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pfc5BY3RUMQrdUuR6kt6gMqUClwh6XrEZRqymzrITxE=;
        b=farlpYshc4vbngnRjo+yXoJ03n6bv1su7ocwe0cBnpW2EB94knHl0zjtK3+JrIQfdO
         p64XKmCy1vuS4hFFXllEyEAzUi+pTk4wsdWk9oDWQJ5JZZ7RBKRQhdTNf9um99RDRU3k
         7QXpAWUyoD7Puc5JwdLNmf3xh+RVysyQZRN/yTm0iGcom25qZwd2f6CjEHIWtpNzBaZl
         uSi5eUIf6aZsCZYUX+hSQt9oGH+S4PR8gfy29luM3fGAroyegOemQsTbnftQnvKkGsxz
         JM6ml7DeIsh+Hq5zb4miwfDtic1wE6Fqnr6FVO9sNUgRuOBrs0lNxX/DrDwpgpde3U0/
         mVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pfc5BY3RUMQrdUuR6kt6gMqUClwh6XrEZRqymzrITxE=;
        b=Za2bukN7pPJ+XXpmQ2qWY7iLdW26dQlLo1joSdSUanXI0ephmDoKMhAbM9DxV2/U6s
         z6IL85PTlxC0PwleLthewRKLRZxaNqNLijtX4ouq3W5UkjD4grep3Akz145K+vVb2qsF
         dCak1qB3VbtLHyylCRGuIOD0l8GgaDXW1DhHDA/OpV54ZCOjtctcktW6yvedNrnPZTvp
         28zZa4Kay1qAdt93mUwScynW1lXWYy59x6SyLp0nTqm5KuvW8bR3o0NRQSSyqW4r8i18
         Q92FhA0OF1KfVDuZ2Zc/fYtR+qysYBHkjJQh49yEyTPI0ljft2U6jLdcFiXm3dwa0+mw
         huBg==
X-Gm-Message-State: AJcUukev86UkkEsNI4DNedh4Lfy59tli1OymHVw6n+w+5RCqtPN3po2e
        P2Qpabed0Yx7ZvpeJkhL5hI=
X-Google-Smtp-Source: ALg8bN6NdGFUucuidf43Ek82d5b9nLpLiQn/yZ3omTwrCGUTBYcNEV926E0RA1QSqBYhctNPa2OZ/w==
X-Received: by 2002:a19:cd50:: with SMTP id d77mr11239796lfg.125.1548502170981;
        Sat, 26 Jan 2019 03:29:30 -0800 (PST)
Received: from amb.local (31-179-17-47.dynamic.chello.pl. [31.179.17.47])
        by smtp.gmail.com with ESMTPSA id r29-v6sm2027341ljd.44.2019.01.26.03.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 03:29:30 -0800 (PST)
Subject: Re: pids.current with invalid value for hours [5.0.0 rc3 git]
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Aleksa Sarai <asarai@suse.de>, Jay Kamat <jgkamat@fb.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <df806a77-3327-9db5-8be2-976fde1c84e5@gmail.com>
 <20190117122535.njcbqhlmzozdkncw@mikami>
 <1d36b181-cbaf-6694-1a31-2f7f55d15675@gmail.com>
 <96ef6615-a5df-30af-b4dc-417a18ca63f1@gmail.com>
 <1cdbef13-564d-61a6-95f4-579d2cad243d@gmail.com>
 <20190125163731.GJ50184@devbig004.ftw2.facebook.com>
 <a95d004a-4358-7efc-6d21-12aac4411b32@gmail.com>
 <480296c4-ed7a-3265-e84a-298e42a0f1d5@I-love.SAKURA.ne.jp>
 <6da6ca69-5a6e-a9f6-d091-f89a8488982a@gmail.com>
 <72aa8863-a534-b8df-6b9e-f69cf4dd5c4d@i-love.sakura.ne.jp>
 <33a07810-6dbc-36be-5bb6-a279773ccf69@i-love.sakura.ne.jp>
 <34e97b46-0792-cc66-e0f2-d72576cdec59@i-love.sakura.ne.jp>
From:   =?UTF-8?Q?Arkadiusz_Mi=c5=9bkiewicz?= <a.miskiewicz@gmail.com>
Message-ID: <2b0c7d6c-c58a-da7d-6f0a-4900694ec2d3@gmail.com>
Date:   Sat, 26 Jan 2019 12:29:29 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <34e97b46-0792-cc66-e0f2-d72576cdec59@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: pl
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2019 12:09, Tetsuo Handa wrote:
> Arkadiusz, will you try this patch?


Works. Several tries and always getting 0 pids.current after ~1s.

Please use

Reported-by: Arkadiusz Miśkiewicz <arekm@maven.pl>

(using gmail for transport only since vger postmasters aren't reasonable)

And also
Tested-by: Arkadiusz Miśkiewicz <arekm@maven.pl>

Testing was done on:
5.0.0-rc3-00104-gc04e2a780caf-dirty

Thanks!

> 
> From 48744b6339cf649a69b55997e138c17df1ecc897 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Sat, 26 Jan 2019 20:00:51 +0900
> Subject: [PATCH] oom, oom_reaper: do not enqueue same task twice
> 
> Arkadiusz reported that enabling memcg's group oom killing causes
> strange memcg statistics where there is no task in a memcg despite
> the number of tasks in that memcg is not 0. It turned out that there
> is a bug in wake_oom_reaper() which allows enqueuing same task twice
> which makes impossible to decrease the number of tasks in that memcg
> due to a refcount leak.
> 
> This bug existed since the OOM reaper became invokable from
> task_will_free_mem(current) path in out_of_memory() in Linux 4.7,
> but memcg's group oom killing made it easier to trigger this bug by
> calling wake_oom_reaper() on the same task from one out_of_memory()
> request.
> 
> Fix this bug using an approach used by commit 855b018325737f76
> ("oom, oom_reaper: disable oom_reaper for oom_kill_allocating_task").
> Since task_will_free_mem(p) == false if p->mm == NULL, we can assume that
> p->mm != NULL when wake_oom_reaper() is called from task_will_free_mem()
> paths. As a side effect of this patch, this patch also avoids enqueuing
> multiple threads sharing memory via task_will_free_mem(current) path.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: Arkadiusz Miśkiewicz <a.miskiewicz@gmail.com>
> Fixes: af8e15cc85a25315 ("oom, oom_reaper: do not enqueue task if it is on the oom_reaper_list head")
> ---
>  mm/oom_kill.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index f0e8cd9..457f240 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -505,14 +505,6 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
>  	struct vm_area_struct *vma;
>  	bool ret = true;
>  
> -	/*
> -	 * Tell all users of get_user/copy_from_user etc... that the content
> -	 * is no longer stable. No barriers really needed because unmapping
> -	 * should imply barriers already and the reader would hit a page fault
> -	 * if it stumbled over a reaped memory.
> -	 */
> -	set_bit(MMF_UNSTABLE, &mm->flags);
> -
>  	for (vma = mm->mmap ; vma; vma = vma->vm_next) {
>  		if (!can_madv_dontneed_vma(vma))
>  			continue;
> @@ -645,10 +637,15 @@ static int oom_reaper(void *unused)
>  	return 0;
>  }
>  
> -static void wake_oom_reaper(struct task_struct *tsk)
> +static void wake_oom_reaper(struct task_struct *tsk, struct mm_struct *mm)
>  {
> -	/* tsk is already queued? */
> -	if (tsk == oom_reaper_list || tsk->oom_reaper_list)
> +	/*
> +	 * Tell all users of get_user/copy_from_user etc... that the content
> +	 * is no longer stable. No barriers really needed because unmapping
> +	 * should imply barriers already and the reader would hit a page fault
> +	 * if it stumbled over a reaped memory.
> +	 */
> +	if (test_and_set_bit(MMF_UNSTABLE, &mm->flags))
>  		return;
>  
>  	get_task_struct(tsk);
> @@ -668,7 +665,8 @@ static int __init oom_init(void)
>  }
>  subsys_initcall(oom_init)
>  #else
> -static inline void wake_oom_reaper(struct task_struct *tsk)
> +static inline void wake_oom_reaper(struct task_struct *tsk,
> +				   struct mm_struct *mm)
>  {
>  }
>  #endif /* CONFIG_MMU */
> @@ -915,7 +913,7 @@ static void __oom_kill_process(struct task_struct *victim)
>  	rcu_read_unlock();
>  
>  	if (can_oom_reap)
> -		wake_oom_reaper(victim);
> +		wake_oom_reaper(victim, mm);
>  
>  	mmdrop(mm);
>  	put_task_struct(victim);
> @@ -955,7 +953,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
>  	task_lock(p);
>  	if (task_will_free_mem(p)) {
>  		mark_oom_victim(p);
> -		wake_oom_reaper(p);
> +		wake_oom_reaper(p, p->mm);
>  		task_unlock(p);
>  		put_task_struct(p);
>  		return;
> @@ -1085,7 +1083,7 @@ bool out_of_memory(struct oom_control *oc)
>  	 */
>  	if (task_will_free_mem(current)) {
>  		mark_oom_victim(current);
> -		wake_oom_reaper(current);
> +		wake_oom_reaper(current, current->mm);
>  		return true;
>  	}
>  
> 


-- 
Arkadiusz Miśkiewicz, arekm / ( maven.pl | pld-linux.org )
