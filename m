Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE3AECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DAA206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="ouZ5yzQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DAA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbeGSJJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:09:32 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41460 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731443AbeGSJJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:09:32 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so3297314ply.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 01:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=duexqOYA0shh4CPteOjTUojC5jGLzKppNK3Zxxd0Wek=;
        b=ouZ5yzQ5BtAu76G90lHw10ENFqq0IAAg1Lv+CktcC7jY84tl1eFHnS0CY12J2xrO2t
         K48Rl/lyxZvhBwCzl0mSJq3jU0+FfIHO7jenAtNTX34hDGtjzDfPUClTCxv2v0lavMqX
         MzboIOjm88HmTlK6PFsWWASUjJMZpuncFhvTcd6jH02rdNsCcwcmeWB12iZoGAxSgDIU
         rFE9pCjfjC22FL4DTXnKugeU5klpMWKE1IOE4mdZIJb4oaEY4Wff4pMWNFBt5VYduTG6
         6Mnm5+GmPsIPUEGoF4r+G122h/pvFu5YUbKDFNQ39TKNNPwIvkfTmNSDc0rQfsQuEJpA
         AN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=duexqOYA0shh4CPteOjTUojC5jGLzKppNK3Zxxd0Wek=;
        b=q2LPs50GMaYa6wqK7snShbnR8lA/ojAwHfQyTj+fnyDMuk7wl2Ege/xCwojuhO0xtq
         O0tFqpl5N31Mq0V8jL1UZfRrpHygmFn3X8OF1mdBARfaJERCgY1+1aSL6LZKKFoLeoUx
         h4o+bapwbxeiLUQoYmgdZiJepws5GubAVuW7hhoqbOonB24Cpd9hbvZv5dtHWU/KYZ3C
         FyO5YbG1qb0HyIYbOhS/Wx2IO/WWSSpAyLKmVtUW2t43vGzcZygJ4sEF7fxs6exVUPIV
         JJzCZ/JJ+NGcILXFPfOA6p/jg4Q3aWToyO2I4OAfTT794jcZEg3WHrCseRuwcf2YGG5L
         6tQg==
X-Gm-Message-State: AOUpUlEu9efpg79CeZYzNOoqRsxyngcW30/TWf2ra+PWTyTcDLxuefI6
        okcrPeIFVtAWJuFdfOs7E2V6rg==
X-Google-Smtp-Source: AAOMgpfH/XI28gTRYcl2LOlgMyvKfg5X/A95TbeTbquUzGweume1iZCeBIfZkqs+91rDlkNrbSI3hw==
X-Received: by 2002:a17:902:6bc7:: with SMTP id m7-v6mr9422892plt.162.1531988851361;
        Thu, 19 Jul 2018 01:27:31 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (jfdmzpr05-ext.jf.intel.com. [134.134.139.74])
        by smtp.gmail.com with ESMTPSA id y132-v6sm8728246pfb.91.2018.07.19.01.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 01:27:30 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id D9D03300251; Thu, 19 Jul 2018 11:27:24 +0300 (+03)
Date:   Thu, 19 Jul 2018 11:27:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv5 05/19] mm/page_alloc: Handle allocation for encrypted
 memory
Message-ID: <20180719082724.4qvfdp6q4kuhxskn@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-6-kirill.shutemov@linux.intel.com>
 <95ce19cb-332c-44f5-b3a1-6cfebd870127@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95ce19cb-332c-44f5-b3a1-6cfebd870127@intel.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 04:03:53PM -0700, Dave Hansen wrote:
> I asked about this before and it still isn't covered in the description:
> You were specifically asked (maybe in person at LSF/MM?) not to modify
> allocator to pass the keyid around.  Please specifically mention how
> this design addresses that feedback in the patch description.
> 
> You were told, "don't change the core allocator", so I think you just
> added new functions that wrap the core allocator and called them from
> the majority of sites that call into the core allocator.  Personally, I
> think that misses the point of the original request.
> 
> Do I have a better way?  Nope, not really.

+Michal.

IIRC, Michal was not happy that I propagate the KeyID to very core
allcoator and we've talked about wrappers around existing APIs as a better
solution.

Michal, is it correct?

> > +/*
> > + * Encrypted page has to be cleared once keyid is set, not on allocation.
> > + */
> > +static inline bool encrypted_page_needs_zero(int keyid, gfp_t *gfp_mask)
> > +{
> > +	if (!keyid)
> > +		return false;
> > +
> > +	if (*gfp_mask & __GFP_ZERO) {
> > +		*gfp_mask &= ~__GFP_ZERO;
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
> 
> Shouldn't this be zero_page_at_alloc()?
> 
> Otherwise, it gets confusing about whether the page needs zeroing at
> *all*, vs at alloc vs. free.

I like your idea with deferred_page_zero() below. I'll go with it.

> > +static inline struct page *alloc_pages_node_keyid(int nid, int keyid,
> > +		gfp_t gfp_mask, unsigned int order)
> > +{
> > +	if (nid == NUMA_NO_NODE)
> > +		nid = numa_mem_id();
> > +
> > +	return __alloc_pages_node_keyid(nid, keyid, gfp_mask, order);
> > +}
> 
> We have an innumerable number of (__)?alloc_pages* functions.  This adds
> two more.  I'm not a big fan of making this worse.
> 
> Do I have a better idea?  Not really.  The best I have is to start being
> more careful about all of the arguments and actually formalize the list
> of things that we need to succeed in an allocation in a struct
> alloc_args or something.

Sounds like a separate project to me :)

> >  #define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)
> >  #define alloc_page_vma(gfp_mask, vma, addr)			\
> > diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> > index f2b4abbca55e..fede9bfa89d9 100644
> > --- a/include/linux/migrate.h
> > +++ b/include/linux/migrate.h
> > @@ -38,9 +38,15 @@ static inline struct page *new_page_nodemask(struct page *page,
> >  	unsigned int order = 0;
> >  	struct page *new_page = NULL;
> >  
> > -	if (PageHuge(page))
> > +	if (PageHuge(page)) {
> > +		/*
> > +		 * HugeTLB doesn't support encryption. We shouldn't see
> > +		 * such pages.
> > +		 */
> > +		WARN_ON(page_keyid(page));
> >  		return alloc_huge_page_nodemask(page_hstate(compound_head(page)),
> >  				preferred_nid, nodemask);
> > +	}
> 
> Shouldn't we be returning NULL?  Seems like failing the allocation is
> much less likely to result in bad things happening.

Okay.

> >  	if (PageTransHuge(page)) {
> >  		gfp_mask |= GFP_TRANSHUGE;
> > @@ -50,8 +56,8 @@ static inline struct page *new_page_nodemask(struct page *page,
> >  	if (PageHighMem(page) || (zone_idx(page_zone(page)) == ZONE_MOVABLE))
> >  		gfp_mask |= __GFP_HIGHMEM;
> >  
> > -	new_page = __alloc_pages_nodemask(gfp_mask, order,
> > -				preferred_nid, nodemask);
> > +	new_page = __alloc_pages_nodemask_keyid(gfp_mask, order,
> > +				preferred_nid, nodemask, page_keyid(page));
> 
> Needs a comment please.  It's totally non-obvious that this is the
> migration case from the context, new_page_nodemask()'s name, or the name
> of 'page'.
> 
> 	/* Allocate a page with the same KeyID as the source page */

Sure.

> 
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index faca45ebe62d..fd51aa32ad96 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -1187,6 +1187,7 @@ static struct page *compaction_alloc(struct page *migratepage,
> >  	list_del(&freepage->lru);
> >  	cc->nr_freepages--;
> >  
> > +	prep_encrypted_page(freepage, 0, page_keyid(migratepage), false);
> >  	return freepage;
> >  }
> 
> Comments, please.
> 
> Why is this here?

/* Prepare the page using the same KeyID as the source page */

> What other code might need prep_encrypted_page()?

Custom pages allocators if these pages can end up in encrypted VMAs.

It this case compaction creates own pool of pages to be used for
allocation during page migration.

> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 581b729e05a0..ce7b436444b5 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -921,22 +921,28 @@ static void migrate_page_add(struct page *page, struct list_head *pagelist,
> >  /* page allocation callback for NUMA node migration */
> >  struct page *alloc_new_node_page(struct page *page, unsigned long node)
> >  {
> > -	if (PageHuge(page))
> > +	if (PageHuge(page)) {
> > +		/*
> > +		 * HugeTLB doesn't support encryption. We shouldn't see
> > +		 * such pages.
> > +		 */
> > +		WARN_ON(page_keyid(page));
> >  		return alloc_huge_page_node(page_hstate(compound_head(page)),
> >  					node);
> > -	else if (PageTransHuge(page)) {
> > +	} else if (PageTransHuge(page)) {
> >  		struct page *thp;
> >  
> > -		thp = alloc_pages_node(node,
> > +		thp = alloc_pages_node_keyid(node, page_keyid(page),
> >  			(GFP_TRANSHUGE | __GFP_THISNODE),
> >  			HPAGE_PMD_ORDER);
> >  		if (!thp)
> >  			return NULL;
> >  		prep_transhuge_page(thp);
> >  		return thp;
> > -	} else
> > -		return __alloc_pages_node(node, GFP_HIGHUSER_MOVABLE |
> > -						    __GFP_THISNODE, 0);
> > +	} else {
> > +		return __alloc_pages_node_keyid(node, page_keyid(page),
> > +				GFP_HIGHUSER_MOVABLE | __GFP_THISNODE, 0);
> > +	}
> >  }
> >  
> >  /*
> > @@ -2013,9 +2019,16 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
> >  {
> >  	struct mempolicy *pol;
> >  	struct page *page;
> > -	int preferred_nid;
> > +	bool zero = false;
> > +	int keyid, preferred_nid;
> >  	nodemask_t *nmask;
> >  
> > +	keyid = vma_keyid(vma);
> > +	if (keyid && (gfp & __GFP_ZERO)) {
> > +		zero = true;
> > +		gfp &= ~__GFP_ZERO;
> > +	}
> 
> Comments, please.  'zero' should be 'deferred_zero', at least.
> 
> Also, can't we hide this a _bit_ better?
> 
> 	if (deferred_page_zero(vma))
> 		gfp &= ~__GFP_ZERO;
> 
> Then, later:
> 
> 	deferred_page_prep(vma, page, order);
> 
> and hide everything in deferred_page_zero() and deferred_page_prep().
> 
> 
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3697,6 +3697,39 @@ should_compact_retry(struct alloc_context *ac, unsigned int order, int alloc_fla
> >  }
> >  #endif /* CONFIG_COMPACTION */
> >  
> > +#ifndef CONFIG_NUMA
> > +struct page *alloc_pages_vma(gfp_t gfp_mask, int order,
> > +		struct vm_area_struct *vma, unsigned long addr,
> > +		int node, bool hugepage)
> > +{
> > +	struct page *page;
> > +	bool need_zero;
> > +	int keyid = vma_keyid(vma);
> > +
> > +	need_zero = encrypted_page_needs_zero(keyid, &gfp_mask);
> > +	page = alloc_pages(gfp_mask, order);
> > +	prep_encrypted_page(page, order, keyid, need_zero);
> > +
> > +	return page;
> > +}
> > +#endif
> 
> Is there *ever* a VMA-based allocation that doesn't need zeroing?

Sure. Any allocations for CoW.

> > +struct page * __alloc_pages_node_keyid(int nid, int keyid,
> > +		gfp_t gfp_mask, unsigned int order)
> > +{
> > +	struct page *page;
> > +	bool need_zero;
> > +
> > +	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
> > +	VM_WARN_ON(!node_online(nid));
> > +
> > +	need_zero = encrypted_page_needs_zero(keyid, &gfp_mask);
> > +	page = __alloc_pages(gfp_mask, order, nid);
> > +	prep_encrypted_page(page, order, keyid, need_zero);
> > +
> > +	return page;
> > +}
> > +
> >  #ifdef CONFIG_LOCKDEP
> >  static struct lockdep_map __fs_reclaim_map =
> >  	STATIC_LOCKDEP_MAP_INIT("fs_reclaim", &__fs_reclaim_map);
> > @@ -4401,6 +4434,20 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
> >  }
> >  EXPORT_SYMBOL(__alloc_pages_nodemask);
> >  
> > +struct page *
> > +__alloc_pages_nodemask_keyid(gfp_t gfp_mask, unsigned int order,
> > +		int preferred_nid, nodemask_t *nodemask, int keyid)
> > +{
> > +	struct page *page;
> > +	bool need_zero;
> > +
> > +	need_zero = encrypted_page_needs_zero(keyid, &gfp_mask);
> > +	page = __alloc_pages_nodemask(gfp_mask, order, preferred_nid, nodemask);
> > +	prep_encrypted_page(page, order, keyid, need_zero);
> > +	return page;
> > +}
> > +EXPORT_SYMBOL(__alloc_pages_nodemask_keyid);
> 
> That looks like three duplicates of the same code, wrapping three more
> allocator variants.  Do we really have no other alternatives?  Can you
> please go ask the folks that gave you the feedback about the allocator
> modifications and ask them if this is OK explicitly?

Michal, any feedback for the patch?

-- 
G Kirill A. Shutemov
