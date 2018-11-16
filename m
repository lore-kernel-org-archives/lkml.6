Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC8AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AEA2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AEA2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbeKQIzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:55:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:18914 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbeKQIzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:55:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 14:41:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,242,1539673200"; 
   d="scan'208";a="108957197"
Received: from ray.jf.intel.com (HELO [10.7.201.15]) ([10.7.201.15])
  by orsmga001.jf.intel.com with ESMTP; 16 Nov 2018 14:41:26 -0800
Subject: Re: [RFC PATCH 3/4] mm, memory_hotplug: allocate memmap from the
 added memory range for sparse-vmemmap
To:     Oscar Salvador <osalvador@suse.com>, linux-mm@kvack.org
Cc:     mhocko@suse.com, david@redhat.com, rppt@linux.vnet.ibm.com,
        akpm@linux-foundation.org, arunks@codeaurora.org, bhe@redhat.com,
        dan.j.williams@intel.com, Pavel.Tatashin@microsoft.com,
        Jonathan.Cameron@huawei.com, jglisse@redhat.com,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
References: <20181116101222.16581-1-osalvador@suse.com>
 <20181116101222.16581-4-osalvador@suse.com>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <87e29d18-c1f7-05b6-edda-1848fb2a1a03@intel.com>
Date:   Fri, 16 Nov 2018 14:41:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181116101222.16581-4-osalvador@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/18 2:12 AM, Oscar Salvador wrote:
> Physical memory hotadd has to allocate a memmap (struct page array) for
> the newly added memory section. Currently, kmalloc is used for those
> allocations.

Did you literally mean kmalloc?  I thought we had a bunch of ways of
allocating memmaps, but I didn't think kmalloc() was actually used.

Like vmemmap_alloc_block(), for instance, uses alloc_pages_node().

So, can the ZONE_DEVICE altmaps move over to this infrastructure?
Doesn't this effectively duplicate that code?

...
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index 7a9886f98b0c..03f014abd4eb 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -278,6 +278,8 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
>  			continue;
>  
>  		page = pfn_to_page(addr >> PAGE_SHIFT);
> +		if (PageVmemmap(page))
> +			continue;
>  		section_base = pfn_to_page(vmemmap_section_start(start));
>  		nr_pages = 1 << page_order;

Reading this, I'm wondering if PageVmemmap() could be named better.
From this is reads like "skip PageVmemmap() pages if freeing vmemmap",
which does not make much sense.

This probably at _least_ needs a comment to explain why the pages are
being skipped.

> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 4139affd6157..bc1523bcb09d 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -231,6 +231,12 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	unsigned long size_pages = PFN_DOWN(size);
>  	int rc;
>  
> +	/*
> +	 * Physical memory is added only later during the memory online so we
> +	 * cannot use the added range at this stage unfortunatelly.

					unfortunately ^

> +	 */
> +	restrictions->flags &= ~MHP_MEMMAP_FROM_RANGE;

Could you also add to the  comment about this being specific to s390?

>  	rc = vmem_add_mapping(start, size);
>  	if (rc)
>  		return rc;
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index fd06bcbd9535..d5234ca5c483 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -815,6 +815,13 @@ static void __meminit free_pagetable(struct page *page, int order)
>  	unsigned long magic;
>  	unsigned int nr_pages = 1 << order;
>  
> +	/*
> +	 * runtime vmemmap pages are residing inside the memory section so
> +	 * they do not have to be freed anywhere.
> +	 */
> +	if (PageVmemmap(page))
> +		return;

Thanks for the comment on this one, this one is right on.

> @@ -16,13 +18,18 @@ struct device;
>   * @free: free pages set aside in the mapping for memmap storage
>   * @align: pages reserved to meet allocation alignments
>   * @alloc: track pages consumed, private to vmemmap_populate()
> + * @flush_alloc_pfns: callback to be called on the allocated range after it
> + * @nr_sects: nr of sects filled with memmap allocations
> + * is mapped to the vmemmap - see mark_vmemmap_pages
>   */

I think you split up the "@flush_alloc_pfns" comment accidentally.

>  struct vmem_altmap {
> -	const unsigned long base_pfn;
> +	unsigned long base_pfn;
>  	const unsigned long reserve;
>  	unsigned long free;
>  	unsigned long align;
>  	unsigned long alloc;
> +	int nr_sects;
> +	void (*flush_alloc_pfns)(struct vmem_altmap *self);
>  };
>  
>  /*
> @@ -133,8 +140,62 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
>  struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
>  		struct dev_pagemap *pgmap);
>  
> -unsigned long vmem_altmap_offset(struct vmem_altmap *altmap);
> +static inline unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
> +{
> +	/* number of pfns from base where pfn_to_page() is valid */
> +	return altmap->reserve + altmap->free;
> +}
>  void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns);
> +
> +static inline void mark_vmemmap_pages(struct vmem_altmap *self)
> +{
> +	unsigned long pfn = self->base_pfn + self->reserve;
> +	unsigned long nr_pages = self->alloc;
> +	unsigned long align = PAGES_PER_SECTION * sizeof(struct page);
> +	struct page *head;
> +	unsigned long i;
> +
> +	pr_debug("%s: marking %px - %px as Vmemmap\n", __func__,
> +						pfn_to_page(pfn),
> +						pfn_to_page(pfn + nr_pages - 1));
> +	/*
> +	 * We keep track of the sections using this altmap by means
> +	 * of a refcount, so we know how much do we have to defer
> +	 * the call to vmemmap_free for this memory range.
> +	 * The refcount is kept in the first vmemmap page.
> +	 * For example:
> +	 * We add 10GB: (ffffea0004000000 - ffffea000427ffc0)
> +	 * ffffea0004000000 will have a refcount of 80.
> +	 */

The example is good, but it took me a minute to realize that 80 is
because 10GB is roughly 80 sections.

> +	head = (struct page *)ALIGN_DOWN((unsigned long)pfn_to_page(pfn), align);

Is this ALIGN_DOWN() OK?  It seems like it might be aligning 'pfn' down
into the reserved are that lies before it.

> +	head = (struct page *)((unsigned long)head - (align * self->nr_sects));
> +	page_ref_inc(head);
> +
> +	/*
> +	 * We have used a/another section only with memmap allocations.
> +	 * We need to keep track of it in order to get the first head page
> +	 * to increase its refcount.
> +	 * This makes it easier to compute.
> +	 */
> +	if (!((page_ref_count(head) * PAGES_PER_SECTION) % align))
> +		self->nr_sects++;
> +
> +	/*
> +	 * All allocations for the memory hotplug are the same sized so align
> +	 * should be 0
> +	 */
> +	WARN_ON(self->align);
> +        for (i = 0; i < nr_pages; i++, pfn++) {
> +                struct page *page = pfn_to_page(pfn);
> +                __SetPageVmemmap(page);
> +		init_page_count(page);
> +        }

Looks like some tabs vs. space problems.

> +	self->alloc = 0;
> +	self->base_pfn += nr_pages + self->reserve;
> +	self->free -= nr_pages;
> +}
>  #else
>  static inline void *devm_memremap_pages(struct device *dev,
>  		struct dev_pagemap *pgmap)
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 50ce1bddaf56..e79054fcc96e 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -437,6 +437,24 @@ static __always_inline int __PageMovable(struct page *page)
>  				PAGE_MAPPING_MOVABLE;
>  }
>  
> +#define VMEMMAP_PAGE ~PAGE_MAPPING_FLAGS
> +static __always_inline int PageVmemmap(struct page *page)
> +{
> +	return PageReserved(page) && (unsigned long)page->mapping == VMEMMAP_PAGE;
> +}
> +
> +static __always_inline void __ClearPageVmemmap(struct page *page)
> +{
> +	ClearPageReserved(page);
> +	page->mapping = NULL;
> +}
> +
> +static __always_inline void __SetPageVmemmap(struct page *page)
> +{
> +	SetPageReserved(page);
> +	page->mapping = (void *)VMEMMAP_PAGE;
> +}

Just curious, but why are these __ versions?  I thought we used that for
non-atomic bit operations, but this uses the atomic SetPageReserved().

> diff --git a/mm/compaction.c b/mm/compaction.c
> index 7c607479de4a..c94a480e01b5 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -768,6 +768,9 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  
>  		page = pfn_to_page(low_pfn);
>  
> +		if (PageVmemmap(page))
> +			goto isolate_fail;

Comments, please.

...
> +static int __online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
> +{
> +	if (PageReserved(pfn_to_page(start_pfn)))
> +		return online_pages_blocks(start_pfn, nr_pages);
> +
> +	return 0;
> +}

Why is it important that 'start_pfn' is PageReserved()?

>  static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
> -			void *arg)
> +								void *arg)
>  {
>  	unsigned long onlined_pages = *(unsigned long *)arg;
> +	unsigned long pfn = start_pfn;
> +	unsigned long end_pfn = start_pfn + nr_pages;
> +	bool vmemmap_page = false;
>  
> -	if (PageReserved(pfn_to_page(start_pfn)))
> -		onlined_pages = online_pages_blocks(start_pfn, nr_pages);
> +	for (; pfn < end_pfn; pfn++) {
> +		struct page *p = pfn_to_page(pfn);
> +
> +		/*
> +		 * Let us check if we got vmemmap pages.
> +		 */
> +		if (PageVmemmap(p)) {
> +			vmemmap_page = true;
> +			break;
> +		}
> +	}

OK, so we did the hot-add, and allocated some of the memmap[] inside the
area being hot-added.  Now, we're onlining the page.  We search every
page in the *entire* area being onlined to try to find a PageVmemmap()?
 That seems a bit inefficient, especially for sections where we don't
have a PageVmemmap().

> +	if (!vmemmap_page) {
> +		/*
> +		 * We can send the whole range to __online_pages_range,
> +		 * as we know for sure that there are not vmemmap pages.
> +		 */
> +		onlined_pages += __online_pages_range(start_pfn, nr_pages);
> +	} else {
> +		/*
> +		 * We need to strip the vmemmap pages here,
> +		 * as we do not want to send them to the buddy allocator.
> +		 */
> +		unsigned long sections = nr_pages / PAGES_PER_SECTION;
> +		unsigned long sect_nr = 0;
> +
> +		for (; sect_nr < sections; sect_nr++) {
> +			unsigned pfn_end_section;
> +			unsigned long memmap_pages = 0;
> +
> +			pfn = start_pfn + (PAGES_PER_SECTION * sect_nr);
> +			pfn_end_section = pfn + PAGES_PER_SECTION;
> +
> +			while (pfn < pfn_end_section) {
> +				struct page *p = pfn_to_page(pfn);
> +
> +				if (PageVmemmap(p))
> +					memmap_pages++;
> +				pfn++;
> +			}

... and another lienar search through the entire area being added.

> +			pfn = start_pfn + (PAGES_PER_SECTION * sect_nr);
> +			if (!memmap_pages) {
> +				onlined_pages += __online_pages_range(pfn, PAGES_PER_SECTION);

If I read this right, this if() and the first block are unneeded.  The
second block is funcationally identical if memmap_pages==0.  Seems like
we can simplify the code.  Also, is this _really_ under 80 columns?
Seems kinda long.

> +		if (PageVmemmap(page))
> +			continue;

FWIW, all these random-looking PageVmemmap() calls are a little
worrying.  What happens when we get one wrong?  Seems like we're kinda
bringing back all the PageReserved() checks we used to have scattered
all over.

> @@ -8138,6 +8146,16 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
>  			continue;
>  		}
>  		page = pfn_to_page(pfn);
> +
> +		/*
> +		 * vmemmap pages are residing inside the memory section so
> +		 * they do not have to be freed anywhere.
> +		 */
> +		if (PageVmemmap(page)) {
> +			pfn++;
> +			continue;
> +		}


> +static struct page *current_vmemmap_page = NULL;
> +static bool vmemmap_dec_and_test(void)
> +{
> +	bool ret = false;
> +
> +	if (page_ref_dec_and_test(current_vmemmap_page))
> +			ret = true;
> +	return ret;
> +}

That's a bit of an obfuscated way to do:

	return page_ref_dec_and_test(current_vmemmap_page));

:)

But, I also see a global variable, and this immediately makes me think
about locking and who "owns" this.  Comments would help.

> +static void free_vmemmap_range(unsigned long limit, unsigned long start, unsigned long end)
> +{
> +	unsigned long range_start;
> +	unsigned long range_end;
> +	unsigned long align = sizeof(struct page) * PAGES_PER_SECTION;
> +
> +	range_end = end;
> +	range_start = end - align;
> +	while (range_start >= limit) {
> +		vmemmap_free(range_start, range_end, NULL);
> +		range_end = range_start;
> +		range_start -= align;
> +	}
> +}

This loop looks like it's working from the end of the range back to the
beginning.  I guess that it works, but it's a bit unconventional to go
backwards.  Was there a reason?

Overall, there's a lot of complexity here.  This certainly doesn't make
the memory hotplug code simpler.
