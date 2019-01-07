Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBEEC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD202173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfAGRmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:42:17 -0500
Received: from mga06.intel.com ([134.134.136.31]:62200 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbfAGRmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:42:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 09:42:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,451,1539673200"; 
   d="scan'208";a="124915585"
Received: from ray.jf.intel.com (HELO [10.7.201.126]) ([10.7.201.126])
  by orsmga001.jf.intel.com with ESMTP; 07 Jan 2019 09:42:15 -0800
Subject: Re: [RFC PATCH 4/4] x86/mm: remove bottom-up allocation style for
 x86_64
To:     Pingfan Liu <kernelfans@gmail.com>, x86@kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
References: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
 <1546849485-27933-5-git-send-email-kernelfans@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
Message-ID: <57ca63ef-ac5b-edd7-710b-f7ee698207c9@intel.com>
Date:   Mon, 7 Jan 2019 09:42:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1546849485-27933-5-git-send-email-kernelfans@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/19 12:24 AM, Pingfan Liu wrote:
> There are two acheivements by this patch.
> -1st. keep the subtree of pgtable away from movable node.
> Background about the defect of the current bottom-up allocation style, take
> the following scenario:
>   |  unmovable node |     movable node                           |
>      | kaslr-kernel |subtree of pgtable for phy<->virt |



> Although kaslr-kernel can avoid to stain the movable node. [1] But the
> pgtable can still stain the movable node. That is a probability problem,
> with low probability, but still exist. This patch tries to eliminate the
> probability. With the previous patch, at the point of init_mem_mapping(),
> memblock allocator can work with the knowledge of acpi memory hotmovable
> info, and avoid to stain the movable node. As a result,
> memory_map_bottom_up() is not needed any more.
> 
> -2nd. simplify the logic of memory_map_top_down()
> Thanks to the help of early_make_pgtable(), x86_64 can directly set up the
> subtree of pgtable at any place, hence the careful iteration in
> memory_map_top_down() can be discard.

>  void __init init_mem_mapping(void)
>  {
>  	unsigned long end;
> @@ -663,6 +540,7 @@ void __init init_mem_mapping(void)
>  
>  #ifdef CONFIG_X86_64
>  	end = max_pfn << PAGE_SHIFT;
> +	set_alloc_range(0x100000, end);
>  #else

Why is this 0x100000 open-coded?  Why is this needed *now*?


>  	/*
>  	 * If the allocation is in bottom-up direction, we setup direct mapping
>  	 * in bottom-up, otherwise we setup direct mapping in top-down.
> @@ -692,13 +577,6 @@ void __init init_mem_mapping(void)
>  	} else {
>  		memory_map_top_down(ISA_END_ADDRESS, end);
>  	}
> -
> -#ifdef CONFIG_X86_64
> -	if (max_pfn > max_low_pfn) {
> -		/* can we preseve max_low_pfn ?*/
> -		max_low_pfn = max_pfn;
> -	}
> -#else
>  	early_ioremap_page_table_range_init();
>  #endif
>  
> diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
> index 85c94f9..ecf7243 100644
> --- a/arch/x86/mm/init_32.c
> +++ b/arch/x86/mm/init_32.c
> @@ -58,6 +58,8 @@ unsigned long highstart_pfn, highend_pfn;
>  
>  bool __read_mostly __vmalloc_start_set = false;
>  
> +static unsigned long min_pfn_mapped;
> +
>  /*
>   * Creates a middle page table and puts a pointer to it in the
>   * given global directory entry. This only returns the gd entry
> @@ -516,6 +518,127 @@ void __init native_pagetable_init(void)
>  	paging_init();
>  }
>  
> +static unsigned long __init get_new_step_size(unsigned long step_size)
> +{
> +	/*
> +	 * Initial mapped size is PMD_SIZE (2M).
> +	 * We can not set step_size to be PUD_SIZE (1G) yet.
> +	 * In worse case, when we cross the 1G boundary, and
> +	 * PG_LEVEL_2M is not set, we will need 1+1+512 pages (2M + 8k)
> +	 * to map 1G range with PTE. Hence we use one less than the
> +	 * difference of page table level shifts.
> +	 *
> +	 * Don't need to worry about overflow in the top-down case, on 32bit,
> +	 * when step_size is 0, round_down() returns 0 for start, and that
> +	 * turns it into 0x100000000ULL.
> +	 * In the bottom-up case, round_up(x, 0) returns 0 though too, which
> +	 * needs to be taken into consideration by the code below.
> +	 */
> +	return step_size << (PMD_SHIFT - PAGE_SHIFT - 1);
> +}
> +
> +/**
> + * memory_map_top_down - Map [map_start, map_end) top down
> + * @map_start: start address of the target memory range
> + * @map_end: end address of the target memory range
> + *
> + * This function will setup direct mapping for memory range
> + * [map_start, map_end) in top-down. That said, the page tables
> + * will be allocated at the end of the memory, and we map the
> + * memory in top-down.
> + */
> +void __init memory_map_top_down(unsigned long map_start,
> +				       unsigned long map_end)
> +{
> +	unsigned long real_end, start, last_start;
> +	unsigned long step_size;
> +	unsigned long addr;
> +	unsigned long mapped_ram_size = 0;
> +
> +	/* xen has big range in reserved near end of ram, skip it at first.*/
> +	addr = memblock_find_in_range(map_start, map_end, PMD_SIZE, PMD_SIZE);
> +	real_end = addr + PMD_SIZE;
> +
> +	/* step_size need to be small so pgt_buf from BRK could cover it */
> +	step_size = PMD_SIZE;
> +	max_pfn_mapped = 0; /* will get exact value next */
> +	min_pfn_mapped = real_end >> PAGE_SHIFT;
> +	last_start = start = real_end;
> +
> +	/*
> +	 * We start from the top (end of memory) and go to the bottom.
> +	 * The memblock_find_in_range() gets us a block of RAM from the
> +	 * end of RAM in [min_pfn_mapped, max_pfn_mapped) used as new pages
> +	 * for page table.
> +	 */
> +	while (last_start > map_start) {
> +		if (last_start > step_size) {
> +			start = round_down(last_start - 1, step_size);
> +			if (start < map_start)
> +				start = map_start;
> +		} else
> +			start = map_start;
> +		mapped_ram_size += init_range_memory_mapping(start,
> +							last_start);
> +		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
> +		last_start = start;
> +		min_pfn_mapped = last_start >> PAGE_SHIFT;
> +		if (mapped_ram_size >= step_size)
> +			step_size = get_new_step_size(step_size);
> +	}
> +
> +	if (real_end < map_end) {
> +		init_range_memory_mapping(real_end, map_end);
> +		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
> +	}
> +}
> +
> +/**
> + * memory_map_bottom_up - Map [map_start, map_end) bottom up
> + * @map_start: start address of the target memory range
> + * @map_end: end address of the target memory range
> + *
> + * This function will setup direct mapping for memory range
> + * [map_start, map_end) in bottom-up. Since we have limited the
> + * bottom-up allocation above the kernel, the page tables will
> + * be allocated just above the kernel and we map the memory
> + * in [map_start, map_end) in bottom-up.
> + */
> +void __init memory_map_bottom_up(unsigned long map_start,
> +					unsigned long map_end)
> +{
> +	unsigned long next, start;
> +	unsigned long mapped_ram_size = 0;
> +	/* step_size need to be small so pgt_buf from BRK could cover it */
> +	unsigned long step_size = PMD_SIZE;
> +
> +	start = map_start;
> +	min_pfn_mapped = start >> PAGE_SHIFT;
> +
> +	/*
> +	 * We start from the bottom (@map_start) and go to the top (@map_end).
> +	 * The memblock_find_in_range() gets us a block of RAM from the
> +	 * end of RAM in [min_pfn_mapped, max_pfn_mapped) used as new pages
> +	 * for page table.
> +	 */
> +	while (start < map_end) {
> +		if (step_size && map_end - start > step_size) {
> +			next = round_up(start + 1, step_size);
> +			if (next > map_end)
> +				next = map_end;
> +		} else {
> +			next = map_end;
> +		}
> +
> +		mapped_ram_size += init_range_memory_mapping(start, next);
> +		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
> +		start = next;
> +
> +		if (mapped_ram_size >= step_size)
> +			step_size = get_new_step_size(step_size);
> +	}
> +}

One more suggestion:  Can you *move* the code in a separate patch?
Un-use it in this patch, but wait for one more patch to actually move it.

>  /*
>   * Build a proper pagetable for the kernel mappings.  Up until this
>   * point, we've been running on some set of pagetables constructed by
> diff --git a/arch/x86/mm/mm_internal.h b/arch/x86/mm/mm_internal.h
> index 319bde3..28006de 100644
> --- a/arch/x86/mm/mm_internal.h
> +++ b/arch/x86/mm/mm_internal.h
> @@ -8,6 +8,13 @@ static inline void *alloc_low_page(void)
>  	return alloc_low_pages(1);
>  }
>  
> +unsigned long __init init_range_memory_mapping(unsigned long r_start,
> +	unsigned long r_end);
> +void set_alloc_range(unsigned long low, unsigned long high);
> +void __init memory_map_top_down(unsigned long map_start,
> +				       unsigned long map_end);
> +void __init memory_map_bottom_up(unsigned long map_start,
> +					unsigned long map_end);

Is there a reason we can't just move all these calls into init_32.c?

Seems like we probably just want one, new function, like:

	init_mem_mapping_x86_32(end);

And then we just export *that* instead of exporting all of these helpers
that only get used on x86_32.  It also makes init_mem_mapping() more
readable since the #ifdef's are shorter.
