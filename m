Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936D2C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578632070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeCtv/mU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbfBDKuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:50:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44770 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731493AbfBDKuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:50:09 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so9927335lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 02:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dY3R/Ow+sIeuZQPXwSYWif9PqrB6TJOohx4Dod2DIvA=;
        b=XeCtv/mUeqzkTh01QL+ztLqKkSGxZSSHaolQOQgZBJyRDLdpRq/wncEv1xCU+8CTPM
         2G6/i84SrLKFQx14BMMEdXqb08cdjmhG3qY81sS8SJ8Q6iz1sum4nrmm9TOolTvUrz/h
         2BheaPoj+yEhAlS2Bgv/mXtEC22AL/0gPGE3YnbMMJj7mOpKug9rbrTGzxXJGfRE+eEF
         GZBPExq32YEeNGTFJRluLRe+g0PujL7oStTCi/5jZEdngDw192gzOGiy34/bOgb6RBwA
         on38OJkUdt59LOuA4tVCUq4IVRB0RCu65m/GiodOMqa+yLoegPJdhjvouGHRMnt157z2
         8gaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dY3R/Ow+sIeuZQPXwSYWif9PqrB6TJOohx4Dod2DIvA=;
        b=L0IM9dWZUBFiEBJq+oMwyh4Lund5LXMl1yUMs3u2LhHDmYKAEeKeXSM6Ro6k5+50s5
         Rbn8CX4bY/+pqM3CYsSmzChyeTGWYWCgE2+3hxTABLuhRyQApz6EJ4B20pICjpGegoMB
         Z0GM/0fRR5/sM1KlmRz9Clb4BRuPmPNgYeJIviiyYMSF+Y6T1CXtLZA0q53N7/GdTCt9
         a/7HzQecXOHxWgWeCfhw+VOlaBhHhRNq70TAhpeNaiw8uFwB3UuM1gcdxev19rmMdfjT
         tkoRkuFm6cb72LUcZ7P4E3dMFIxtMk7KR+H37ZkYTBWBug4Vf2MRMLfWY4QiX06fi5Gh
         6mQg==
X-Gm-Message-State: AHQUAuarw6xpqw7Sz7bbc9tkUCY2aTUr/aiSdyw9Y18maiGrghi8IK2h
        XUovUf6hJSxvWM0YPWfKYE0=
X-Google-Smtp-Source: AHgI3IZvNEuGctW3VgPzvNS4djJz9FWP3UoGaXwEspLnSmHhO0+hIYAbeglQFF5KtdamJr8dL0sjfA==
X-Received: by 2002:a19:df41:: with SMTP id q1mr19208298lfj.25.1549277406384;
        Mon, 04 Feb 2019 02:50:06 -0800 (PST)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id v9sm3010048lfg.15.2019.02.04.02.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 02:50:05 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 4 Feb 2019 11:49:56 +0100
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] mm/vmalloc: convert vmap_lazy_nr to atomic_long_t
Message-ID: <20190204104956.vg3u4jlwsjd2k7jn@pc636>
References: <20190131162452.25879-1-urezki@gmail.com>
 <20190201124528.GN11599@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201124528.GN11599@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Michal.

On Fri, Feb 01, 2019 at 01:45:28PM +0100, Michal Hocko wrote:
> On Thu 31-01-19 17:24:52, Uladzislau Rezki (Sony) wrote:
> > vmap_lazy_nr variable has atomic_t type that is 4 bytes integer
> > value on both 32 and 64 bit systems. lazy_max_pages() deals with
> > "unsigned long" that is 8 bytes on 64 bit system, thus vmap_lazy_nr
> > should be 8 bytes on 64 bit as well.
> 
> But do we really need 64b number of _pages_? I have hard time imagine
> that we would have that many lazy pages to accumulate.
> 
That is more about of using the same type of variables thus the same size
in 32/64 bit address space.

<snip>
static void free_vmap_area_noflush(struct vmap_area *va)
{
    int nr_lazy;
 
    nr_lazy = atomic_add_return((va->va_end - va->va_start) >> PAGE_SHIFT,
                                &vmap_lazy_nr);
...
    if (unlikely(nr_lazy > lazy_max_pages()))
        try_purge_vmap_area_lazy();
<snip>

va_end/va_start are "unsigned long" whereas atomit_t(vmap_lazy_nr) is "int". 
The same with lazy_max_pages(), it returns "unsigned long" value.

Answering your question, in 64bit, the "vmalloc" address space is ~8589719406
pages if PAGE_SIZE is 4096, i.e. a regular 4 byte integer is not enough to hold
it. I agree it is hard to imagine, but it also depends on physical memory a
system has, it has to be terabytes. I am not sure if such systems exists.

Thank you.

--
Vlad Rezki

> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index abe83f885069..755b02983d8d 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -632,7 +632,7 @@ static unsigned long lazy_max_pages(void)
> >  	return log * (32UL * 1024 * 1024 / PAGE_SIZE);
> >  }
> >  
> > -static atomic_t vmap_lazy_nr = ATOMIC_INIT(0);
> > +static atomic_long_t vmap_lazy_nr = ATOMIC_LONG_INIT(0);
> >  
> >  /*
> >   * Serialize vmap purging.  There is no actual criticial section protected
> > @@ -650,7 +650,7 @@ static void purge_fragmented_blocks_allcpus(void);
> >   */
> >  void set_iounmap_nonlazy(void)
> >  {
> > -	atomic_set(&vmap_lazy_nr, lazy_max_pages()+1);
> > +	atomic_long_set(&vmap_lazy_nr, lazy_max_pages()+1);
> >  }
> >  
> >  /*
> > @@ -658,10 +658,10 @@ void set_iounmap_nonlazy(void)
> >   */
> >  static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
> >  {
> > +	unsigned long resched_threshold;
> >  	struct llist_node *valist;
> >  	struct vmap_area *va;
> >  	struct vmap_area *n_va;
> > -	int resched_threshold;
> >  
> >  	lockdep_assert_held(&vmap_purge_lock);
> >  
> > @@ -681,16 +681,16 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
> >  	}
> >  
> >  	flush_tlb_kernel_range(start, end);
> > -	resched_threshold = (int) lazy_max_pages() << 1;
> > +	resched_threshold = lazy_max_pages() << 1;
> >  
> >  	spin_lock(&vmap_area_lock);
> >  	llist_for_each_entry_safe(va, n_va, valist, purge_list) {
> > -		int nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
> > +		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
> >  
> >  		__free_vmap_area(va);
> > -		atomic_sub(nr, &vmap_lazy_nr);
> > +		atomic_long_sub(nr, &vmap_lazy_nr);
> >  
> > -		if (atomic_read(&vmap_lazy_nr) < resched_threshold)
> > +		if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
> >  			cond_resched_lock(&vmap_area_lock);
> >  	}
> >  	spin_unlock(&vmap_area_lock);
> > @@ -727,10 +727,10 @@ static void purge_vmap_area_lazy(void)
> >   */
> >  static void free_vmap_area_noflush(struct vmap_area *va)
> >  {
> > -	int nr_lazy;
> > +	unsigned long nr_lazy;
> >  
> > -	nr_lazy = atomic_add_return((va->va_end - va->va_start) >> PAGE_SHIFT,
> > -				    &vmap_lazy_nr);
> > +	nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>
> > +				PAGE_SHIFT, &vmap_lazy_nr);
> >  
> >  	/* After this point, we may free va at any time */
> >  	llist_add(&va->purge_list, &vmap_purge_list);
> > -- 
> > 2.11.0
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs
