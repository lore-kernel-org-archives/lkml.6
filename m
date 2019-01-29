Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56B7C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7472120857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AruFYuA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfA2Rju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:39:50 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45577 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfA2Rjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:39:49 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so18195949ljd.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 09:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KIaWr0Zq9+BtRkxw1MjIPRqsGQx0NbC1v2Rp0V9/A/c=;
        b=AruFYuA615iqmLt6moyy7Tr8BAEm5qxgDyZzBrSBg6C2Jh3ZJE2PgHzTmAQZhRXkZQ
         fqBrdqqReYLN40c6roqStJJcfijWgr1eXjJC0+9x7IvCgpPCvYynxOemgUspEWGjsLFf
         w5tyLM/4WD3zFo+xuKTbOb8P9OWPmIpHFUehuicWryw6KwRm6xlbhTx3pDTAL5GKLzO+
         yC5AEqAnlROh0B3rH+GDChw5a+5tJc7gVdgu8odLXPzVdG3NTRdqemNu385kw5npus0S
         OpwwN0RBjuI3O0apN66HWAJg8zRhKiaLQZUBIzP1XjYXx/FU39AgOt0q4SNCPwiZ24jd
         IBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KIaWr0Zq9+BtRkxw1MjIPRqsGQx0NbC1v2Rp0V9/A/c=;
        b=t0i+CIw4blSm7xw7/XD0wG0vaB11HCt0CA14hwD+oqn/Pnaqp0QAW4quRCUwGZUoeO
         96Px3umfUvA2E7LlzDnFlg2VL2iRKsxynV6t/FAMO1A+yNOU7Ud1W1wEm2HpsPBLPksd
         4RaKO+76tZaRS3h3B5EpA324bVXkx6+NhmHoAYFrQEX1XKVnicqPkTWnk0t5PuLVIuye
         vkBaDQWgBWZieHxm1JekAkRNiMuETR4D33Ufi7hxqY+cZuTOmM1/o9Bbdy1oVyQsrJIQ
         Radsbq/MtST5zA3H9AktPxDMk0Cs3hq0ke70DxOdh7LPT22MOV52DtVrmrdV4NWgI3W+
         KuEg==
X-Gm-Message-State: AJcUukdv582/GDOUWAtiJh3Vf/zyylLwusK7hacHbGCnc126vHpRMobg
        IYwTzwXSYnfJ/vK77EtCXvzeUoLDB9c=
X-Google-Smtp-Source: ALg8bN7W6EIoEIQoFEsV3JNk/AtCA2tr4O0YD6DSYh1j8+wPjM/kByazFbNqyIb8ydT1zvuH61jN1w==
X-Received: by 2002:a2e:3a04:: with SMTP id h4-v6mr23245958lja.81.1548783586715;
        Tue, 29 Jan 2019 09:39:46 -0800 (PST)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id l17sm3553290lfk.40.2019.01.29.09.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 09:39:45 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 29 Jan 2019 18:39:36 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v1 2/2] mm: add priority threshold to
 __purge_vmap_area_lazy()
Message-ID: <20190129173936.4sscooiybzbhos77@pc636>
References: <20190124115648.9433-1-urezki@gmail.com>
 <20190124115648.9433-3-urezki@gmail.com>
 <20190128224528.GB38107@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128224528.GB38107@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 05:45:28PM -0500, Joel Fernandes wrote:
> On Thu, Jan 24, 2019 at 12:56:48PM +0100, Uladzislau Rezki (Sony) wrote:
> > commit 763b218ddfaf ("mm: add preempt points into
> > __purge_vmap_area_lazy()")
> > 
> > introduced some preempt points, one of those is making an
> > allocation more prioritized over lazy free of vmap areas.
> > 
> > Prioritizing an allocation over freeing does not work well
> > all the time, i.e. it should be rather a compromise.
> > 
> > 1) Number of lazy pages directly influence on busy list length
> > thus on operations like: allocation, lookup, unmap, remove, etc.
> > 
> > 2) Under heavy stress of vmalloc subsystem i run into a situation
> > when memory usage gets increased hitting out_of_memory -> panic
> > state due to completely blocking of logic that frees vmap areas
> > in the __purge_vmap_area_lazy() function.
> > 
> > Establish a threshold passing which the freeing is prioritized
> > back over allocation creating a balance between each other.
> 
> I'm a bit concerned that this will introduce the latency back if vmap_lazy_nr
> is greater than half of lazy_max_pages(). Which IIUC will be more likely if
> the number of CPUs is large.
> 
The threshold that we establish is two times more than lazy_max_pages(),
i.e. in case of 4 system CPUs lazy_max_pages() is 24576, therefore the
threshold is 49152, if PAGE_SIZE is 4096.

It means that we allow rescheduling if vmap_lazy_nr < 49152. If vmap_lazy_nr 
is higher then we forbid rescheduling and free areas until it becomes lower
again to stabilize the system. By doing that, we will not allow vmap_lazy_nr
to be enormously increased.

>
> In fact, when vmap_lazy_nr is high, that's when the latency will be the worst
> so one could say that that's when you *should* reschedule since the frees are
> taking too long and hurting real-time tasks.
> 
> Could this be better solved by tweaking lazy_max_pages() such that purging is
> more aggressive?
> 
> Another approach could be to detect the scenario you brought up (allocations
> happening faster than free), somehow, and avoid a reschedule?
> 
This is what i am trying to achieve by this change. 

Thank you for your comments.

--
Vlad Rezki
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index fb4fb5fcee74..abe83f885069 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -661,23 +661,27 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
> >  	struct llist_node *valist;
> >  	struct vmap_area *va;
> >  	struct vmap_area *n_va;
> > -	bool do_free = false;
> > +	int resched_threshold;
> >  
> >  	lockdep_assert_held(&vmap_purge_lock);
> >  
> >  	valist = llist_del_all(&vmap_purge_list);
> > +	if (unlikely(valist == NULL))
> > +		return false;
> > +
> > +	/*
> > +	 * TODO: to calculate a flush range without looping.
> > +	 * The list can be up to lazy_max_pages() elements.
> > +	 */
> >  	llist_for_each_entry(va, valist, purge_list) {
> >  		if (va->va_start < start)
> >  			start = va->va_start;
> >  		if (va->va_end > end)
> >  			end = va->va_end;
> > -		do_free = true;
> >  	}
> >  
> > -	if (!do_free)
> > -		return false;
> > -
> >  	flush_tlb_kernel_range(start, end);
> > +	resched_threshold = (int) lazy_max_pages() << 1;
> >  
> >  	spin_lock(&vmap_area_lock);
> >  	llist_for_each_entry_safe(va, n_va, valist, purge_list) {
> > @@ -685,7 +689,9 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
> >  
> >  		__free_vmap_area(va);
> >  		atomic_sub(nr, &vmap_lazy_nr);
> > -		cond_resched_lock(&vmap_area_lock);
> > +
> > +		if (atomic_read(&vmap_lazy_nr) < resched_threshold)
> > +			cond_resched_lock(&vmap_area_lock);
> >  	}
> >  	spin_unlock(&vmap_area_lock);
> >  	return true;
> > -- 
> > 2.11.0
> > 
