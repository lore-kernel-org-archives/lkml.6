Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAB8C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E75E27FCA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E75E27FCA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935057AbeF2OlE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:41:04 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43776 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934656AbeF2OlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:41:02 -0400
Received: by mail-wr0-f194.google.com with SMTP id c5-v6so9084744wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 07:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kK5zLA09ZH7sr/d3n5x+E7GKsOPk96p9NAtwvzZvSzo=;
        b=f2NF1uZSNpXC8xKeFdsa68mvItUbXdgHpksYUivVWg2ShpMOp1CDFuvjylTSBPySLh
         a3oACl2IUxI+1mHtN0/HKOI7Xe5o8ipfKuN8UZDc4Y52PLh/ppFdkHFTLXeoXkUChsh3
         iuAjkKvw5/PeXVstj8oGYv/iFce99k6KNInSlBJiNo764RstXgQDjCkxMtqwPjZia2d9
         uI1lK0mSpnqSGd83kY1/14REu4UKJ0RgGT+xPsrSuuD6fePvUc107NXU8ivf50vZ9i/T
         05lotLFl5N0mrFx+fsaUImzXNDWf9D/cNNQe0m6Z1+uWUeloF4UC3NLOaMITcfVdxgyu
         0j7Q==
X-Gm-Message-State: APt69E1qiw9GZyNVHvmHstxIPhJ4xjpqiIcDb2sz688P3YOrahHfs/DA
        ZOTAlOuvFSoJZm0TULu1S0E=
X-Google-Smtp-Source: AAOMgpdl/WHYeMvqlO/p1DMJvXaUOqc9VxHJBczPTG9vhcaKGMmnSH2pxHEm0Q1yQ0oimmXPebjMig==
X-Received: by 2002:adf:d84a:: with SMTP id k10-v6mr12281131wrl.26.1530283261219;
        Fri, 29 Jun 2018 07:41:01 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id g75-v6sm2144981wmd.38.2018.06.29.07.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 07:41:00 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id C553B12397B; Fri, 29 Jun 2018 16:40:59 +0200 (CEST)
Date:   Fri, 29 Jun 2018 16:40:59 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, dan.j.williams@intel.com, jack@suse.cz,
        jglisse@redhat.com, jrdr.linux@gmail.com, bhe@redhat.com,
        gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org
Subject: Re: [PATCH v1 2/2] mm/sparse: start using sparse_init_nid(), and
 remove old code
Message-ID: <20180629144059.GB23545@techadventures.net>
References: <20180628173010.23849-1-pasha.tatashin@oracle.com>
 <20180628173010.23849-3-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628173010.23849-3-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 01:30:10PM -0400, Pavel Tatashin wrote:
> Change sprase_init() to only find the pnum ranges that belong to a specific
> node and call sprase_init_nid() for that range from sparse_init().
> 
> Delete all the code that became obsolete with this change.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  include/linux/mm.h  |   5 -
>  mm/sparse-vmemmap.c |  39 --------
>  mm/sparse.c         | 223 ++++----------------------------------------
>  3 files changed, 16 insertions(+), 251 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ba200808dd5f..a25395071a13 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2646,11 +2646,6 @@ extern int randomize_va_space;
>  const char * arch_vma_name(struct vm_area_struct *vma);
>  void print_vma_addr(char *prefix, unsigned long rip);
>  
> -void sparse_mem_maps_populate_node(struct page **map_map,
> -				   unsigned long pnum_begin,
> -				   unsigned long pnum_end,
> -				   unsigned long map_count,
> -				   int nodeid);
>  struct page * sparse_populate_node(unsigned long pnum_begin,
>  				   unsigned long pnum_end,
>  				   unsigned long map_count,
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 4655503bdc66..0adda7c32feb 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -273,45 +273,6 @@ struct page * __meminit sparse_mem_map_populate(unsigned long pnum, int nid,
>  	return map;
>  }
>  
> -void __init sparse_mem_maps_populate_node(struct page **map_map,
> -					  unsigned long pnum_begin,
> -					  unsigned long pnum_end,
> -					  unsigned long map_count, int nodeid)
> -{
> -	unsigned long pnum;
> -	unsigned long size = sizeof(struct page) * PAGES_PER_SECTION;
> -	void *vmemmap_buf_start;
> -	int nr_consumed_maps = 0;
> -
> -	size = ALIGN(size, PMD_SIZE);
> -	vmemmap_buf_start = __earlyonly_bootmem_alloc(nodeid, size * map_count,
> -			 PMD_SIZE, __pa(MAX_DMA_ADDRESS));
> -
> -	if (vmemmap_buf_start) {
> -		vmemmap_buf = vmemmap_buf_start;
> -		vmemmap_buf_end = vmemmap_buf_start + size * map_count;
> -	}
> -
> -	for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
> -		if (!present_section_nr(pnum))
> -			continue;
> -
> -		map_map[nr_consumed_maps] = sparse_mem_map_populate(pnum, nodeid, NULL);
> -		if (map_map[nr_consumed_maps++])
> -			continue;
> -		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
> -		       __func__);
> -	}
> -
> -	if (vmemmap_buf_start) {
> -		/* need to free left buf */
> -		memblock_free_early(__pa(vmemmap_buf),
> -				    vmemmap_buf_end - vmemmap_buf);
> -		vmemmap_buf = NULL;
> -		vmemmap_buf_end = NULL;
> -	}
> -}
> -
>  struct page * __init sparse_populate_node(unsigned long pnum_begin,
>  					  unsigned long pnum_end,
>  					  unsigned long map_count,
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 60eaa2a4842a..ad2522e733bb 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -200,12 +200,6 @@ static inline int next_present_section_nr(int section_nr)
>  	      (section_nr <= __highest_present_section_nr));	\
>  	     section_nr = next_present_section_nr(section_nr))
>  
> -/*
> - * Record how many memory sections are marked as present
> - * during system bootup.
> - */
> -static int __initdata nr_present_sections;
> -
>  /* Record a memory area against a node. */
>  void __init memory_present(int nid, unsigned long start, unsigned long end)
>  {
> @@ -235,7 +229,6 @@ void __init memory_present(int nid, unsigned long start, unsigned long end)
>  			ms->section_mem_map = sparse_encode_early_nid(nid) |
>  							SECTION_IS_ONLINE;
>  			section_mark_present(ms);
> -			nr_present_sections++;
>  		}
>  	}
>  }
> @@ -377,34 +370,6 @@ static void __init check_usemap_section_nr(int nid, unsigned long *usemap)
>  }
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>  
> -static void __init sparse_early_usemaps_alloc_node(void *data,
> -				 unsigned long pnum_begin,
> -				 unsigned long pnum_end,
> -				 unsigned long usemap_count, int nodeid)
> -{
> -	void *usemap;
> -	unsigned long pnum;
> -	unsigned long **usemap_map = (unsigned long **)data;
> -	int size = usemap_size();
> -	int nr_consumed_maps = 0;
> -
> -	usemap = sparse_early_usemaps_alloc_pgdat_section(NODE_DATA(nodeid),
> -							  size * usemap_count);
> -	if (!usemap) {
> -		pr_warn("%s: allocation failed\n", __func__);
> -		return;
> -	}
> -
> -	for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
> -		if (!present_section_nr(pnum))
> -			continue;
> -		usemap_map[nr_consumed_maps] = usemap;
> -		usemap += size;
> -		check_usemap_section_nr(nodeid, usemap_map[nr_consumed_maps]);
> -		nr_consumed_maps++;
> -	}
> -}
> -
>  #ifndef CONFIG_SPARSEMEM_VMEMMAP
>  struct page __init *sparse_mem_map_populate(unsigned long pnum, int nid,
>  		struct vmem_altmap *altmap)
> @@ -418,44 +383,6 @@ struct page __init *sparse_mem_map_populate(unsigned long pnum, int nid,
>  					  BOOTMEM_ALLOC_ACCESSIBLE, nid);
>  	return map;
>  }
> -void __init sparse_mem_maps_populate_node(struct page **map_map,
> -					  unsigned long pnum_begin,
> -					  unsigned long pnum_end,
> -					  unsigned long map_count, int nodeid)
> -{
> -	void *map;
> -	unsigned long pnum;
> -	unsigned long size = sizeof(struct page) * PAGES_PER_SECTION;
> -	int nr_consumed_maps;
> -
> -	size = PAGE_ALIGN(size);
> -	map = memblock_virt_alloc_try_nid_raw(size * map_count,
> -					      PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
> -					      BOOTMEM_ALLOC_ACCESSIBLE, nodeid);
> -	if (map) {
> -		nr_consumed_maps = 0;
> -		for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
> -			if (!present_section_nr(pnum))
> -				continue;
> -			map_map[nr_consumed_maps] = map;
> -			map += size;
> -			nr_consumed_maps++;
> -		}
> -		return;
> -	}
> -
> -	/* fallback */
> -	nr_consumed_maps = 0;
> -	for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
> -		if (!present_section_nr(pnum))
> -			continue;
> -		map_map[nr_consumed_maps] = sparse_mem_map_populate(pnum, nodeid, NULL);
> -		if (map_map[nr_consumed_maps++])
> -			continue;
> -		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
> -		       __func__);
> -	}
> -}
>  
>  static unsigned long section_map_size(void)
>  {
> @@ -495,73 +422,15 @@ struct page * __init sprase_populate_node_section(struct page *map_base,
>  }
>  #endif /* !CONFIG_SPARSEMEM_VMEMMAP */
>  
> -static void __init sparse_early_mem_maps_alloc_node(void *data,
> -				 unsigned long pnum_begin,
> -				 unsigned long pnum_end,
> -				 unsigned long map_count, int nodeid)
> -{
> -	struct page **map_map = (struct page **)data;
> -	sparse_mem_maps_populate_node(map_map, pnum_begin, pnum_end,
> -					 map_count, nodeid);
> -}
> -
>  void __weak __meminit vmemmap_populate_print_last(void)
>  {
>  }
>  
> -/**
> - *  alloc_usemap_and_memmap - memory alloction for pageblock flags and vmemmap
> - *  @map: usemap_map for pageblock flags or mmap_map for vmemmap
> - *  @unit_size: size of map unit
> - */
> -static void __init alloc_usemap_and_memmap(void (*alloc_func)
> -					(void *, unsigned long, unsigned long,
> -					unsigned long, int), void *data,
> -					int data_unit_size)
> -{
> -	unsigned long pnum;
> -	unsigned long map_count;
> -	int nodeid_begin = 0;
> -	unsigned long pnum_begin = 0;
> -
> -	for_each_present_section_nr(0, pnum) {
> -		struct mem_section *ms;
> -
> -		ms = __nr_to_section(pnum);
> -		nodeid_begin = sparse_early_nid(ms);
> -		pnum_begin = pnum;
> -		break;
> -	}
> -	map_count = 1;
> -	for_each_present_section_nr(pnum_begin + 1, pnum) {
> -		struct mem_section *ms;
> -		int nodeid;
> -
> -		ms = __nr_to_section(pnum);
> -		nodeid = sparse_early_nid(ms);
> -		if (nodeid == nodeid_begin) {
> -			map_count++;
> -			continue;
> -		}
> -		/* ok, we need to take cake of from pnum_begin to pnum - 1*/
> -		alloc_func(data, pnum_begin, pnum,
> -						map_count, nodeid_begin);
> -		/* new start, update count etc*/
> -		nodeid_begin = nodeid;
> -		pnum_begin = pnum;
> -		data += map_count * data_unit_size;
> -		map_count = 1;
> -	}
> -	/* ok, last chunk */
> -	alloc_func(data, pnum_begin, __highest_present_section_nr+1,
> -						map_count, nodeid_begin);
> -}
> -
>  /*
>   * Initialize sparse on a specific node. The node spans [pnum_begin, pnum_end)
>   * And number of present sections in this node is map_count.
>   */
> -void __init sparse_init_nid(int nid, unsigned long pnum_begin,
> +static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
>  				   unsigned long pnum_end,
>  				   unsigned long map_count)
>  {
> @@ -616,87 +485,27 @@ void __init sparse_init_nid(int nid, unsigned long pnum_begin,
>   */
>  void __init sparse_init(void)
>  {
> -	unsigned long pnum;
> -	struct page *map;
> -	struct page **map_map;
> -	unsigned long *usemap;
> -	unsigned long **usemap_map;
> -	int size, size2;
> -	int nr_consumed_maps = 0;
> +	unsigned long pnum_begin, pnum_end, map_count;
> +	int nid, nid_begin;
>  
> -	/* see include/linux/mmzone.h 'struct mem_section' definition */
> -	BUILD_BUG_ON(!is_power_of_2(sizeof(struct mem_section)));
> -
> -	/* Setup pageblock_order for HUGETLB_PAGE_SIZE_VARIABLE */
> -	set_pageblock_order();
> -
> -	/*
> -	 * map is using big page (aka 2M in x86 64 bit)
> -	 * usemap is less one page (aka 24 bytes)
> -	 * so alloc 2M (with 2M align) and 24 bytes in turn will
> -	 * make next 2M slip to one more 2M later.
> -	 * then in big system, the memory will have a lot of holes...
> -	 * here try to allocate 2M pages continuously.
> -	 *
> -	 * powerpc need to call sparse_init_one_section right after each
> -	 * sparse_early_mem_map_alloc, so allocate usemap_map at first.
> -	 */
> -	size = sizeof(unsigned long *) * nr_present_sections;
> -	usemap_map = memblock_virt_alloc(size, 0);
> -	if (!usemap_map)
> -		panic("can not allocate usemap_map\n");
> -	alloc_usemap_and_memmap(sparse_early_usemaps_alloc_node,
> -				(void *)usemap_map,
> -				sizeof(usemap_map[0]));
> -
> -	size2 = sizeof(struct page *) * nr_present_sections;
> -	map_map = memblock_virt_alloc(size2, 0);
> -	if (!map_map)
> -		panic("can not allocate map_map\n");
> -	alloc_usemap_and_memmap(sparse_early_mem_maps_alloc_node,
> -				(void *)map_map,
> -				sizeof(map_map[0]));
> -
> -	/* The numner of present sections stored in nr_present_sections
> -	 * are kept the same since mem sections are marked as present in
> -	 * memory_present(). In this for loop, we need check which sections
> -	 * failed to allocate memmap or usemap, then clear its
> -	 * ->section_mem_map accordingly. During this process, we need
> -	 * increase 'nr_consumed_maps' whether its allocation of memmap
> -	 * or usemap failed or not, so that after we handle the i-th
> -	 * memory section, can get memmap and usemap of (i+1)-th section
> -	 * correctly. */
> -	for_each_present_section_nr(0, pnum) {
> -		struct mem_section *ms;
> -
> -		if (nr_consumed_maps >= nr_present_sections) {
> -			pr_err("nr_consumed_maps goes beyond nr_present_sections\n");
> -			break;
> -		}
> -		ms = __nr_to_section(pnum);
> -		usemap = usemap_map[nr_consumed_maps];
> -		if (!usemap) {
> -			ms->section_mem_map = 0;
> -			nr_consumed_maps++;
> -			continue;
> -		}
> +	for_each_present_section_nr(0, pnum_begin)
> +		break;

Hi Pavel,

besides this first for_each_present_section_nr(), what about writing a static inline
function that returns next_present_section_nr(-1) ?

Something like:

static inline int first_present_section_nr(void)
{
	return next_present_section_nr(-1);
}

pnum_begin = first_present_section_nr();

I think it will generate the same code, but maybe it is more readable?

>  
> -		map = map_map[nr_consumed_maps];
> -		if (!map) {
> -			ms->section_mem_map = 0;
> -			nr_consumed_maps++;
> +	nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
> +	map_count = 1;
> +	for_each_present_section_nr(pnum_begin + 1, pnum_end) {
> +		nid = sparse_early_nid(__nr_to_section(pnum_end));
> +		if (nid == nid_begin) {
> +			map_count++;
>  			continue;
>  		}
> -
> -		sparse_init_one_section(__nr_to_section(pnum), pnum, map,
> -								usemap);
> -		nr_consumed_maps++;
> +		sparse_init_nid(nid, pnum_begin, pnum_end, map_count);
> +		nid_begin = nid;
> +		pnum_begin = pnum_end;
> +		map_count = 1;
>  	}
> -
> +	sparse_init_nid(nid_begin, pnum_begin, pnum_end, map_count);
>  	vmemmap_populate_print_last();
> -
> -	memblock_free_early(__pa(map_map), size2);
> -	memblock_free_early(__pa(usemap_map), size);
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -- 
> 2.18.0
> 

-- 
Oscar Salvador
SUSE L3
