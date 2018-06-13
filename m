Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DBD62C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D793208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D793208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935424AbeFMSHn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:07:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:47401 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935017AbeFMSHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:07:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2018 11:07:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,220,1526367600"; 
   d="scan'208";a="49085191"
Received: from ray.jf.intel.com (HELO [10.7.201.133]) ([10.7.201.133])
  by orsmga008.jf.intel.com with ESMTP; 13 Jun 2018 11:07:40 -0700
Subject: Re: [PATCHv3 04/17] mm/page_alloc: Handle allocation for encrypted
 memory
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
 <20180612143915.68065-5-kirill.shutemov@linux.intel.com>
Cc:     Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <e0ecf890-2621-83a0-cd01-edce4a158ff1@intel.com>
Date:   Wed, 13 Jun 2018 11:07:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612143915.68065-5-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 07:39 AM, Kirill A. Shutemov wrote:
> For encrypted memory, we need to allocated pages for a specific
> encryption KeyID.

"allocate"                         ^

> There are two cases when we need to allocate a page for encryption:
> 
>  - Allocation for an encrypted VMA;
> 
>  - Allocation for migration of encrypted page;
> 
> The first case can be covered within alloc_page_vma().

... because we know the KeyID from the VMA?

> The second case requires few new page allocation routines that would
> allocate the page for a specific KeyID.
> 
> Encrypted page has to be cleared after KeyID set. This is handled by

"An encrypted page has ... "

This description lacks a description of the performance impact of the
approach in this patch both when allocating encrypted and normal pages.

> --- a/arch/alpha/include/asm/page.h
> +++ b/arch/alpha/include/asm/page.h
> @@ -18,7 +18,7 @@ extern void clear_page(void *page);
>  #define clear_user_page(page, vaddr, pg)	clear_page(page)
>  
>  #define __alloc_zeroed_user_highpage(movableflags, vma, vaddr) \
> -	alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO | movableflags, vma, vmaddr)
> +	alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO | movableflags, vma, vaddr)
>  #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE

Does this compile?  Wouldn't "vmaddr" be undefined?

> +#define alloc_hugepage_vma(gfp_mask, vma, addr, order) \
> +	alloc_pages_vma(gfp_mask, order, vma, addr, numa_node_id(), true)

The argument addition should be broken out into a preparatory patch.

>  extern unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order);
>  extern unsigned long get_zeroed_page(gfp_t gfp_mask);
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index f2b4abbca55e..6da504bad841 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -38,9 +38,11 @@ static inline struct page *new_page_nodemask(struct page *page,
>  	unsigned int order = 0;
>  	struct page *new_page = NULL;
>  
> -	if (PageHuge(page))
> +	if (PageHuge(page)) {
> +		WARN_ON(page_keyid(page));
>  		return alloc_huge_page_nodemask(page_hstate(compound_head(page)),
>  				preferred_nid, nodemask);
> +	}

Comment on the warning, please.

> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 9ac49ef17b4e..00bccbececea 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -920,22 +920,24 @@ static void migrate_page_add(struct page *page, struct list_head *pagelist,
>  /* page allocation callback for NUMA node migration */
>  struct page *alloc_new_node_page(struct page *page, unsigned long node)
>  {
> -	if (PageHuge(page))
> +	if (PageHuge(page)) {
> +		WARN_ON(page_keyid(page));
>  		return alloc_huge_page_node(page_hstate(compound_head(page)),
>  					node);

Comments, please.

> @@ -2012,9 +2014,16 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
>  {
>  	struct mempolicy *pol;
>  	struct page *page;
> -	int preferred_nid;
> +	bool zero = false;
> +	int keyid, preferred_nid;
>  	nodemask_t *nmask;
>  
> +	keyid = vma_keyid(vma);
> +	if (keyid && gfp & __GFP_ZERO) {
> +		zero = true;
> +		gfp &= ~__GFP_ZERO;
> +	}

I totally read that wrong.

"zero" needs to be named: "page_need_zeroing".

It also badly needs a comment.

>  	pol = get_vma_policy(vma, addr);
>  
>  	if (pol->mode == MPOL_INTERLEAVE) {
> @@ -2057,6 +2066,8 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
>  	page = __alloc_pages_nodemask(gfp, order, preferred_nid, nmask);
>  	mpol_cond_put(pol);
>  out:
> +	if (page && keyid)
> +		prep_encrypted_page(page, order, keyid, zero);
>  	return page;
>  }

I'd just have prep_encrypted_page() do the keyid-0 opt-out of the prep
work.  It'll be less to patch when you

> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8c0af0f7cab1..eb8dea219dcb 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1847,7 +1847,7 @@ static struct page *alloc_misplaced_dst_page(struct page *page,
>  	int nid = (int) data;
>  	struct page *newpage;
>  
> -	newpage = __alloc_pages_node(nid,
> +	newpage = __alloc_pages_node_keyid(nid, page_keyid(page),
>  					 (GFP_HIGHUSER_MOVABLE |
>  					  __GFP_THISNODE | __GFP_NOMEMALLOC |
>  					  __GFP_NORETRY | __GFP_NOWARN) &

I thought folks asked you not to change all of the calling conventions
across the page allocator.  It seems like you're still doing that,
though.  A reviewer might think you've ignored their earlier feedback.
Did you?


> +#ifndef CONFIG_NUMA
> +struct page *alloc_pages_vma(gfp_t gfp_mask, int order,
> +		struct vm_area_struct *vma, unsigned long addr,
> +		int node, bool hugepage)
> +{
> +	struct page *page;
> +	bool zero = false;
> +	int keyid = vma_keyid(vma);
> +
> +	if (keyid && (gfp_mask & __GFP_ZERO)) {

Please at least do your parenthesis consistently. :)

> +		zero = true;
> +		gfp_mask &= ~__GFP_ZERO;
> +	}
> +
> +	page = alloc_pages(gfp_mask, order);
> +	if (page && keyid)
> +		prep_encrypted_page(page, order, keyid, zero);
> +
> +	return page;
> +}
> +#endif

I'm also confused by the #ifdef.  What is it for?

> +struct page * __alloc_pages_node_keyid(int nid, int keyid,
> +		gfp_t gfp_mask, unsigned int order)
> +{
> +	struct page *page;
> +	bool zero = false;
> +
> +	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
> +	VM_WARN_ON(!node_online(nid));
> +
> +	if (keyid && (gfp_mask & __GFP_ZERO)) {
> +		zero = true;
> +		gfp_mask &= ~__GFP_ZERO;
> +	}

OK, so this is the third time I've seen that pattern.  Are you *sure*
you don't want to consolidate the sites?

> +	page = __alloc_pages(gfp_mask, order, nid);
> +	if (page && keyid)
> +		prep_encrypted_page(page, order, keyid, zero);
> +
> +	return page;
> +}
> +
>  #ifdef CONFIG_LOCKDEP
>  struct lockdep_map __fs_reclaim_map =
>  	STATIC_LOCKDEP_MAP_INIT("fs_reclaim", &__fs_reclaim_map);
> @@ -4396,6 +4439,26 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
>  }
>  EXPORT_SYMBOL(__alloc_pages_nodemask);
>  
> +struct page *
> +__alloc_pages_nodemask_keyid(gfp_t gfp_mask, unsigned int order,
> +		int preferred_nid, nodemask_t *nodemask, int keyid)
> +{
> +	struct page *page;
> +	bool zero = false;
> +
> +	if (keyid && (gfp_mask & __GFP_ZERO)) {
> +		zero = true;
> +		gfp_mask &= ~__GFP_ZERO;
> +	}

Fourth one. :)

