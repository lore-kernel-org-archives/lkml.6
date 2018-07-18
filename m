Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A86DECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1828720854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1828720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbeGRXoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:44:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:23154 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728929AbeGRXoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:44:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2018 16:03:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,371,1526367600"; 
   d="scan'208";a="73928997"
Received: from ray.jf.intel.com (HELO [10.7.201.15]) ([10.7.201.15])
  by orsmga001.jf.intel.com with ESMTP; 18 Jul 2018 16:03:56 -0700
Subject: Re: [PATCHv5 05/19] mm/page_alloc: Handle allocation for encrypted
 memory
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-6-kirill.shutemov@linux.intel.com>
Cc:     Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <95ce19cb-332c-44f5-b3a1-6cfebd870127@intel.com>
Date:   Wed, 18 Jul 2018 16:03:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180717112029.42378-6-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I asked about this before and it still isn't covered in the description:
You were specifically asked (maybe in person at LSF/MM?) not to modify
allocator to pass the keyid around.  Please specifically mention how
this design addresses that feedback in the patch description.

You were told, "don't change the core allocator", so I think you just
added new functions that wrap the core allocator and called them from
the majority of sites that call into the core allocator.  Personally, I
think that misses the point of the original request.

Do I have a better way?  Nope, not really.

> +/*
> + * Encrypted page has to be cleared once keyid is set, not on allocation.
> + */
> +static inline bool encrypted_page_needs_zero(int keyid, gfp_t *gfp_mask)
> +{
> +	if (!keyid)
> +		return false;
> +
> +	if (*gfp_mask & __GFP_ZERO) {
> +		*gfp_mask &= ~__GFP_ZERO;
> +		return true;
> +	}
> +
> +	return false;
> +}

Shouldn't this be zero_page_at_alloc()?

Otherwise, it gets confusing about whether the page needs zeroing at
*all*, vs at alloc vs. free.

> +static inline struct page *alloc_pages_node_keyid(int nid, int keyid,
> +		gfp_t gfp_mask, unsigned int order)
> +{
> +	if (nid == NUMA_NO_NODE)
> +		nid = numa_mem_id();
> +
> +	return __alloc_pages_node_keyid(nid, keyid, gfp_mask, order);
> +}

We have an innumerable number of (__)?alloc_pages* functions.  This adds
two more.  I'm not a big fan of making this worse.

Do I have a better idea?  Not really.  The best I have is to start being
more careful about all of the arguments and actually formalize the list
of things that we need to succeed in an allocation in a struct
alloc_args or something.

>  #define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)
>  #define alloc_page_vma(gfp_mask, vma, addr)			\
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index f2b4abbca55e..fede9bfa89d9 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -38,9 +38,15 @@ static inline struct page *new_page_nodemask(struct page *page,
>  	unsigned int order = 0;
>  	struct page *new_page = NULL;
>  
> -	if (PageHuge(page))
> +	if (PageHuge(page)) {
> +		/*
> +		 * HugeTLB doesn't support encryption. We shouldn't see
> +		 * such pages.
> +		 */
> +		WARN_ON(page_keyid(page));
>  		return alloc_huge_page_nodemask(page_hstate(compound_head(page)),
>  				preferred_nid, nodemask);
> +	}

Shouldn't we be returning NULL?  Seems like failing the allocation is
much less likely to result in bad things happening.

>  	if (PageTransHuge(page)) {
>  		gfp_mask |= GFP_TRANSHUGE;
> @@ -50,8 +56,8 @@ static inline struct page *new_page_nodemask(struct page *page,
>  	if (PageHighMem(page) || (zone_idx(page_zone(page)) == ZONE_MOVABLE))
>  		gfp_mask |= __GFP_HIGHMEM;
>  
> -	new_page = __alloc_pages_nodemask(gfp_mask, order,
> -				preferred_nid, nodemask);
> +	new_page = __alloc_pages_nodemask_keyid(gfp_mask, order,
> +				preferred_nid, nodemask, page_keyid(page));

Needs a comment please.  It's totally non-obvious that this is the
migration case from the context, new_page_nodemask()'s name, or the name
of 'page'.

	/* Allocate a page with the same KeyID as the source page */

> diff --git a/mm/compaction.c b/mm/compaction.c
> index faca45ebe62d..fd51aa32ad96 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1187,6 +1187,7 @@ static struct page *compaction_alloc(struct page *migratepage,
>  	list_del(&freepage->lru);
>  	cc->nr_freepages--;
>  
> +	prep_encrypted_page(freepage, 0, page_keyid(migratepage), false);
>  	return freepage;
>  }

Comments, please.

Why is this here?  What other code might need prep_encrypted_page()?

> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 581b729e05a0..ce7b436444b5 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -921,22 +921,28 @@ static void migrate_page_add(struct page *page, struct list_head *pagelist,
>  /* page allocation callback for NUMA node migration */
>  struct page *alloc_new_node_page(struct page *page, unsigned long node)
>  {
> -	if (PageHuge(page))
> +	if (PageHuge(page)) {
> +		/*
> +		 * HugeTLB doesn't support encryption. We shouldn't see
> +		 * such pages.
> +		 */
> +		WARN_ON(page_keyid(page));
>  		return alloc_huge_page_node(page_hstate(compound_head(page)),
>  					node);
> -	else if (PageTransHuge(page)) {
> +	} else if (PageTransHuge(page)) {
>  		struct page *thp;
>  
> -		thp = alloc_pages_node(node,
> +		thp = alloc_pages_node_keyid(node, page_keyid(page),
>  			(GFP_TRANSHUGE | __GFP_THISNODE),
>  			HPAGE_PMD_ORDER);
>  		if (!thp)
>  			return NULL;
>  		prep_transhuge_page(thp);
>  		return thp;
> -	} else
> -		return __alloc_pages_node(node, GFP_HIGHUSER_MOVABLE |
> -						    __GFP_THISNODE, 0);
> +	} else {
> +		return __alloc_pages_node_keyid(node, page_keyid(page),
> +				GFP_HIGHUSER_MOVABLE | __GFP_THISNODE, 0);
> +	}
>  }
>  
>  /*
> @@ -2013,9 +2019,16 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
>  {
>  	struct mempolicy *pol;
>  	struct page *page;
> -	int preferred_nid;
> +	bool zero = false;
> +	int keyid, preferred_nid;
>  	nodemask_t *nmask;
>  
> +	keyid = vma_keyid(vma);
> +	if (keyid && (gfp & __GFP_ZERO)) {
> +		zero = true;
> +		gfp &= ~__GFP_ZERO;
> +	}

Comments, please.  'zero' should be 'deferred_zero', at least.

Also, can't we hide this a _bit_ better?

	if (deferred_page_zero(vma))
		gfp &= ~__GFP_ZERO;

Then, later:

	deferred_page_prep(vma, page, order);

and hide everything in deferred_page_zero() and deferred_page_prep().


> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3697,6 +3697,39 @@ should_compact_retry(struct alloc_context *ac, unsigned int order, int alloc_fla
>  }
>  #endif /* CONFIG_COMPACTION */
>  
> +#ifndef CONFIG_NUMA
> +struct page *alloc_pages_vma(gfp_t gfp_mask, int order,
> +		struct vm_area_struct *vma, unsigned long addr,
> +		int node, bool hugepage)
> +{
> +	struct page *page;
> +	bool need_zero;
> +	int keyid = vma_keyid(vma);
> +
> +	need_zero = encrypted_page_needs_zero(keyid, &gfp_mask);
> +	page = alloc_pages(gfp_mask, order);
> +	prep_encrypted_page(page, order, keyid, need_zero);
> +
> +	return page;
> +}
> +#endif

Is there *ever* a VMA-based allocation that doesn't need zeroing?

> +struct page * __alloc_pages_node_keyid(int nid, int keyid,
> +		gfp_t gfp_mask, unsigned int order)
> +{
> +	struct page *page;
> +	bool need_zero;
> +
> +	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
> +	VM_WARN_ON(!node_online(nid));
> +
> +	need_zero = encrypted_page_needs_zero(keyid, &gfp_mask);
> +	page = __alloc_pages(gfp_mask, order, nid);
> +	prep_encrypted_page(page, order, keyid, need_zero);
> +
> +	return page;
> +}
> +
>  #ifdef CONFIG_LOCKDEP
>  static struct lockdep_map __fs_reclaim_map =
>  	STATIC_LOCKDEP_MAP_INIT("fs_reclaim", &__fs_reclaim_map);
> @@ -4401,6 +4434,20 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
>  }
>  EXPORT_SYMBOL(__alloc_pages_nodemask);
>  
> +struct page *
> +__alloc_pages_nodemask_keyid(gfp_t gfp_mask, unsigned int order,
> +		int preferred_nid, nodemask_t *nodemask, int keyid)
> +{
> +	struct page *page;
> +	bool need_zero;
> +
> +	need_zero = encrypted_page_needs_zero(keyid, &gfp_mask);
> +	page = __alloc_pages_nodemask(gfp_mask, order, preferred_nid, nodemask);
> +	prep_encrypted_page(page, order, keyid, need_zero);
> +	return page;
> +}
> +EXPORT_SYMBOL(__alloc_pages_nodemask_keyid);

That looks like three duplicates of the same code, wrapping three more
allocator variants.  Do we really have no other alternatives?  Can you
please go ask the folks that gave you the feedback about the allocator
modifications and ask them if this is OK explicitly?
