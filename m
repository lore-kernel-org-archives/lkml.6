Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D97ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07E820671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A99xEuwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07E820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbeGTXEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 19:04:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44037 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbeGTXEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 19:04:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so7921560pgp.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 15:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=f0GVuaU8mcNvy9tTLPl9T+Q7VQlvX5HhHcuzlCceTQE=;
        b=A99xEuwIq9E9VNuHgeRRRwzK+67LRbSU6MO5T6/oBGhWvJvWqzXXHc4bjZ5GY+I/T4
         QWEdu6vRppnPKapbYZP8mmNI4rIbzN8BrHXdI/W+Iko9fKCZ44f4l2FOeMS90RKqSEGc
         /DK81rxETiQ3ULS4TgtmgfoylmouWEG1VeR/aPNcncCwlyy4cuaBs9K/J+ZCQxc7702q
         xUAqIGPSeigDQRiFWXkEimwlC4RQbuzDuEoxp1WRrqd+fUrg2w8KfS41waL7kW8mN374
         o3u9r303NBTI817OJzfU5ceK5iqNPd1zHLb3a3cHHcALd4MQdcvjAXwLrCdB88F3jNPV
         HAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=f0GVuaU8mcNvy9tTLPl9T+Q7VQlvX5HhHcuzlCceTQE=;
        b=gOu+D12St6setOIfF3rWvqR4KYTI6ljFO9Ggon4aMjWEUxOG/RkLvgX5mE0dAk/h9p
         S1xw0Q3hasJJZ+x1OoouMIhG3TQ5fE5pVnbRn/6v0HrpZYZb7z4ZqdxchCVhBJf4240v
         CeHdEMWPCAw0Z1mvgc4JXAy3ziMtCfTDGRqIVXCE3qD9BYFiNI4ELk1ahRiqwOXOfqBr
         uojvsFWb6kvYGzLKNA8nLlP/uMR9gwWNH8vHi2KQ103ipBpeGcNP1fvZV7WcsEfBF5FV
         dT++2b4bL4WqSYNA1hh4kxZny71jaZ2pW8ukeUsvQj1eJl9HVlW+AvLnpaDkdKzJTSJT
         Xa2w==
X-Gm-Message-State: AOUpUlFErw2LpzhNq9Ia6lTXhpKSTMG0a0ci7o4FS4tmdgo14G7xKNRE
        DzYor2y9GUVy7soVICYK3LDnZg==
X-Google-Smtp-Source: AAOMgpdV0kNmLITsC86YEtA9yujePi2xfYnY1yh2d/BQDFvj2yNg0IgGmvgMmkjg0n10VIt0zn6NKA==
X-Received: by 2002:a62:1489:: with SMTP id 131-v6mr3838248pfu.159.1532124826276;
        Fri, 20 Jul 2018 15:13:46 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id l27-v6sm5467377pfi.180.2018.07.20.15.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 15:13:45 -0700 (PDT)
Date:   Fri, 20 Jul 2018 15:13:44 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch v4] mm, oom: fix unnecessary killing of additional
 processes
In-Reply-To: <ca34b123-5c81-569f-85ea-4851bc569962@i-love.sakura.ne.jp>
Message-ID: <alpine.DEB.2.21.1807201505550.38399@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1806211434420.51095@chino.kir.corp.google.com> <d19d44c3-c8cf-70a1-9b15-c98df233d5f0@i-love.sakura.ne.jp> <alpine.DEB.2.21.1807181317540.49359@chino.kir.corp.google.com> <a78fb992-ad59-0cdb-3c38-8284b2245f21@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.1807200133310.119737@chino.kir.corp.google.com> <alpine.DEB.2.21.1807201314230.231119@chino.kir.corp.google.com> <ca34b123-5c81-569f-85ea-4851bc569962@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jul 2018, Tetsuo Handa wrote:

> > diff --git a/mm/mmap.c b/mm/mmap.c
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -3066,25 +3066,27 @@ void exit_mmap(struct mm_struct *mm)
> >  	if (unlikely(mm_is_oom_victim(mm))) {
> >  		/*
> >  		 * Manually reap the mm to free as much memory as possible.
> > -		 * Then, as the oom reaper does, set MMF_OOM_SKIP to disregard
> > -		 * this mm from further consideration.  Taking mm->mmap_sem for
> > -		 * write after setting MMF_OOM_SKIP will guarantee that the oom
> > -		 * reaper will not run on this mm again after mmap_sem is
> > -		 * dropped.
> > -		 *
> >  		 * Nothing can be holding mm->mmap_sem here and the above call
> >  		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
> >  		 * __oom_reap_task_mm() will not block.
> >  		 *
> > +		 * This sets MMF_UNSTABLE to avoid racing with the oom reaper.
> >  		 * This needs to be done before calling munlock_vma_pages_all(),
> >  		 * which clears VM_LOCKED, otherwise the oom reaper cannot
> > -		 * reliably test it.
> > +		 * reliably test for it.  If the oom reaper races with
> > +		 * munlock_vma_pages_all(), this can result in a kernel oops if
> > +		 * a pmd is zapped, for example, after follow_page_mask() has
> > +		 * checked pmd_none().
> >  		 */
> >  		mutex_lock(&oom_lock);
> >  		__oom_reap_task_mm(mm);
> >  		mutex_unlock(&oom_lock);
> 
> I don't like holding oom_lock for full teardown of an mm, for an OOM victim's mm
> might have multiple TB memory which could take long time.
> 

This patch does not involve deltas for oom_lock here, it can certainly be 
changed on top of this patch.  I'm not attempting to address any oom_lock 
issue here.  It should pose no roadblock for you.

I only propose this patch now since it fixes millions of processes being 
oom killed unnecessarily, it was in -mm before a NACK for the most trivial 
fixes that have now been squashed into it, and is actually tested.

> >  
> > -		set_bit(MMF_OOM_SKIP, &mm->flags);
> > +		/*
> > +		 * Taking mm->mmap_sem for write after setting MMF_UNSTABLE will
> > +		 * guarantee that the oom reaper will not run on this mm again
> > +		 * after mmap_sem is dropped.
> > +		 */
> >  		down_write(&mm->mmap_sem);
> >  		up_write(&mm->mmap_sem);
> >  	}
> 
> 
> 
> > -#define MAX_OOM_REAP_RETRIES 10
> >  static void oom_reap_task(struct task_struct *tsk)
> >  {
> > -	int attempts = 0;
> >  	struct mm_struct *mm = tsk->signal->oom_mm;
> >  
> > -	/* Retry the down_read_trylock(mmap_sem) a few times */
> > -	while (attempts++ < MAX_OOM_REAP_RETRIES && !oom_reap_task_mm(tsk, mm))
> > -		schedule_timeout_idle(HZ/10);
> > +	/*
> > +	 * If this mm has either been fully unmapped, or the oom reaper has
> > +	 * given up on it, nothing left to do except drop the refcount.
> > +	 */
> > +	if (test_bit(MMF_OOM_SKIP, &mm->flags))
> > +		goto drop;
> >  
> > -	if (attempts <= MAX_OOM_REAP_RETRIES ||
> > -	    test_bit(MMF_OOM_SKIP, &mm->flags))
> > -		goto done;
> > +	/*
> > +	 * If this mm has already been reaped, doing so again will not likely
> > +	 * free additional memory.
> > +	 */
> > +	if (!test_bit(MMF_UNSTABLE, &mm->flags))
> > +		oom_reap_task_mm(tsk, mm);
> 
> This is still wrong. If preempted immediately after set_bit(MMF_UNSTABLE, &mm->flags) from
> __oom_reap_task_mm() from exit_mmap(), oom_reap_task() can give up before reclaiming any memory.

If there is a single thread holding onto the mm and has reached 
exit_mmap() and is in the process of starting oom reaping itself, there's 
no advantage to the oom reaper trying to oom reap it.  The thread in 
exit_mmap() will take care of it, __oom_reap_task_mm() does not block and 
oom_free_timeout_ms allows for enough time for that memory freeing to 
occur.  The oom reaper will not set MMF_OOM_SKIP until the timeout has 
expired.

As I said before, you could make a case for extending the timeout once 
MMF_UNSTABLE has been set.  It practice, we haven't encountered a case 
where that matters.  But that's trivial to do if you would prefer.
