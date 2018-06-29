Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F8CC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9388027FB1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9388027FB1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936261AbeF2Ofd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:35:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54980 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753194AbeF2Ofa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:35:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id i139-v6so2421963wmf.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 07:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uYMKZLxS4W6ccUxImTLeYXT60/yfnhEPGcF0bagPwvc=;
        b=OYloNzATRPjLGBRueBjGUwNgZlpulSFZmRLFpJzK+tsDU4lhZdo9wJLlyh4/PQw9nV
         9H/KFicdvXxrbKZEF9taK18rV7Mv/jRvoYt/LudWv+hEtz0kE2T5pWypa+gRYOx339V5
         3wzHmJZKjn54jqSx7ZSgOKYHRghls5cF8CeXX/BiBGWEfBWuGT8Uhu8ah3MRGEGSobQj
         PkTT3Ra3DHsJH25MFGzFZpyfT5nkKVxQ/9uEuoBN8dVjvCZwLQXSQc8pBGc+/KGJI1vz
         E4SXiaKvl0zm6ZADTk7IB+TieUPKHA8W0t1Xz9pn1NJV5LAiQIxvjpm8Y2afsPWfSsNQ
         DhDQ==
X-Gm-Message-State: APt69E2RankodFwbjq4VSEfw51RJjgQuB0eGLRfGKzXOrIFY/8QL1dFL
        Q7bIjydCxaG3taMH0EA/afo=
X-Google-Smtp-Source: AAOMgpdJPc4NJgWyyJqqPXv/GOX+tkaGp2LhqQjq+EqKpNHbGgP6wBoSQVzR3RsGH/z5P8TkhZUdjw==
X-Received: by 2002:a1c:e041:: with SMTP id x62-v6mr1867702wmg.155.1530282929153;
        Fri, 29 Jun 2018 07:35:29 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id b1-v6sm2487553wma.23.2018.06.29.07.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 07:35:28 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 8E91F123976; Fri, 29 Jun 2018 16:35:27 +0200 (CEST)
Date:   Fri, 29 Jun 2018 16:35:27 +0200
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
Subject: Re: [PATCH v1 1/2] mm/sparse: add sparse_init_nid()
Message-ID: <20180629143527.GA23545@techadventures.net>
References: <20180628173010.23849-1-pasha.tatashin@oracle.com>
 <20180628173010.23849-2-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628173010.23849-2-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 01:30:09PM -0400, Pavel Tatashin wrote:
> sparse_init() requires to temporary allocate two large buffers:
> usemap_map and map_map. Baoquan He has identified that these buffers are so
> large that Linux is not bootable on small memory machines, such as a kdump
> boot.
> 
> Baoquan provided a fix, which reduces these sizes of these buffers, but it
> is much better to get rid of them entirely.
> 
> Add a new way to initialize sparse memory: sparse_init_nid(), which only
> operates within one memory node, and thus allocates memory either in large
> contiguous block or allocates section by section. This eliminates the need
> for use of temporary buffers.
> 
> For simplified bisecting and review, the new interface is going to be
> enabled as well as old code removed in the next patch.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  include/linux/mm.h  |  8 ++++
>  mm/sparse-vmemmap.c | 49 ++++++++++++++++++++++++
>  mm/sparse.c         | 90 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 147 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a0fbb9ffe380..ba200808dd5f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2651,6 +2651,14 @@ void sparse_mem_maps_populate_node(struct page **map_map,
>  				   unsigned long pnum_end,
>  				   unsigned long map_count,
>  				   int nodeid);
> +struct page * sparse_populate_node(unsigned long pnum_begin,
> +				   unsigned long pnum_end,
> +				   unsigned long map_count,
> +				   int nid);
> +struct page * sprase_populate_node_section(struct page *map_base,
> +				   unsigned long map_index,
> +				   unsigned long pnum,
> +				   int nid);
>  
>  struct page *sparse_mem_map_populate(unsigned long pnum, int nid,
>  		struct vmem_altmap *altmap);
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index e1a54ba411ec..4655503bdc66 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -311,3 +311,52 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
>  		vmemmap_buf_end = NULL;
>  	}
>  }
> +
> +struct page * __init sparse_populate_node(unsigned long pnum_begin,
> +					  unsigned long pnum_end,
> +					  unsigned long map_count,
> +					  int nid)
> +{
> +	unsigned long size = sizeof(struct page) * PAGES_PER_SECTION;
> +	unsigned long pnum, map_index = 0;
> +	void *vmemmap_buf_start;
> +
> +	size = ALIGN(size, PMD_SIZE) * map_count;
> +	vmemmap_buf_start = __earlyonly_bootmem_alloc(nid, size,
> +						      PMD_SIZE,
> +						      __pa(MAX_DMA_ADDRESS));
> +	if (vmemmap_buf_start) {
> +		vmemmap_buf = vmemmap_buf_start;
> +		vmemmap_buf_end = vmemmap_buf_start + size;
> +	}
> +
> +	for (pnum = pnum_begin; map_index < map_count; pnum++) {
> +		if (!present_section_nr(pnum))
> +			continue;
> +		if (!sparse_mem_map_populate(pnum, nid, NULL))
> +			break;
> +		map_index++;
> +		BUG_ON(pnum >= pnum_end);
> +	}

Besides the typos, I could not find anything wrong in the patch.
Only cosmetic:

Could not the loop above be converted to a for_each_present_section_nr() or would it be
less readable?

> +
> +	if (vmemmap_buf_start) {
> +		/* need to free left buf */
> +		memblock_free_early(__pa(vmemmap_buf),
> +				    vmemmap_buf_end - vmemmap_buf);
> +		vmemmap_buf = NULL;
> +		vmemmap_buf_end = NULL;
> +	}
> +	return pfn_to_page(section_nr_to_pfn(pnum_begin));
> +}
> +
> +/*
> + * Return map for pnum section. sparse_populate_node() has populated memory map
> + * in this node, we simply do pnum to struct page conversion.
> + */
> +struct page * __init sprase_populate_node_section(struct page *map_base,
> +						  unsigned long map_index,
> +						  unsigned long pnum,
> +						  int nid)
> +{
> +	return pfn_to_page(section_nr_to_pfn(pnum));
> +}
> diff --git a/mm/sparse.c b/mm/sparse.c
> index d18e2697a781..60eaa2a4842a 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -456,6 +456,43 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
>  		       __func__);
>  	}
>  }
> +
> +static unsigned long section_map_size(void)
> +{
> +	return PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
> +}
> +
> +/*
> + * Try to allocate all struct pages for this node, if this fails, we will
> + * be allocating one section at a time in sprase_populate_node_section().
> + */
> +struct page * __init sparse_populate_node(unsigned long pnum_begin,
> +					  unsigned long pnum_end,
> +					  unsigned long map_count,
> +					  int nid)
> +{
> +	return memblock_virt_alloc_try_nid_raw(section_map_size() * map_count,
> +					       PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
> +					       BOOTMEM_ALLOC_ACCESSIBLE, nid);
> +}
> +
> +/*
> + * Return map for pnum section. map_base is not NULL if we could allocate map
> + * for this node together. Otherwise we allocate one section at a time.
> + * map_index is the index of pnum in this node counting only present sections.
> + */
> +struct page * __init sprase_populate_node_section(struct page *map_base,
> +						  unsigned long map_index,
> +						  unsigned long pnum,
> +						  int nid)
> +{
> +	if (map_base) {
> +		unsigned long offset = section_map_size() * map_index;
> +
> +		return (struct page *)((char *)map_base + offset);
> +	}
> +	return sparse_mem_map_populate(pnum, nid, NULL);
> +}
>  #endif /* !CONFIG_SPARSEMEM_VMEMMAP */
>  
>  static void __init sparse_early_mem_maps_alloc_node(void *data,
> @@ -520,6 +557,59 @@ static void __init alloc_usemap_and_memmap(void (*alloc_func)
>  						map_count, nodeid_begin);
>  }
>  
> +/*
> + * Initialize sparse on a specific node. The node spans [pnum_begin, pnum_end)
> + * And number of present sections in this node is map_count.
> + */
> +void __init sparse_init_nid(int nid, unsigned long pnum_begin,
> +				   unsigned long pnum_end,
> +				   unsigned long map_count)
> +{
> +	unsigned long pnum, usemap_longs, *usemap, map_index;
> +	struct page *map, *map_base;
> +	struct mem_section *ms;

What about moving "struct mem_section" into the second for_each_present_section_nr() loop.
It is only being used there.
And we could move "struct page *map" into the first loop as well.

But the patch looks good to me anyway.
Maybe I am missing something, but so far:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
