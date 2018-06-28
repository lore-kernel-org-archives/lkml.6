Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E417C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1622327282
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1622327282
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753535AbeF1LT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:19:58 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34207 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbeF1LT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:19:57 -0400
Received: by mail-wr0-f195.google.com with SMTP id a12-v6so5129138wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 04:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wukRn35/Gqa7cQcFvgfdyixlX7iSdLObJORFKfzlyeE=;
        b=YiSBd4XMOSadpZMqAhWSCJ31OKgwqTGPYLIPOLB50i7qOfTzPh0Xk0OzFQ/foKa3XT
         /+/6YoIQ+OJ1sMEhGZyqRgSsWLMOdC6V8fnYwf7u7CSQnRbh7QCjfyfWQWSvG6zBJVQI
         pUuERygNvQry4Pnrk+b8U/twi8iou8O07mSdPuI1vqffuncZa3CtHY3uApAEoBrg5HVv
         yopZNr5tjoH2+MgEkg99j2HohWvaJmpqGvqJjy37e5zQEErMzVgU4US3TI1jkSikpxM6
         dcMM7e4kNz02o3PPtbZFB36dKPoVh4Gl/5Hgt1EyHTDPuFWp4bT7glGGve07bdghUreh
         kAXQ==
X-Gm-Message-State: APt69E25gzelHp+n7CksW7LGQs7CrBWnMrP0uRG8yimxcs3GcG8DmE4G
        p0JBxqkyHudEdJsDoJB2WW0=
X-Google-Smtp-Source: AAOMgpcwH4z6V2YCFsBvKOvDcsaf3lJ1GIzTW/aioS6EU3Y4qOimYdL0UDyEuv6zwuDMKm6yv3GIOw==
X-Received: by 2002:adf:ef50:: with SMTP id c16-v6mr7860569wrp.182.1530184796260;
        Thu, 28 Jun 2018 04:19:56 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id l15-v6sm8952596wrs.95.2018.06.28.04.19.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 04:19:55 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 19CCA12390C; Thu, 28 Jun 2018 13:19:54 +0200 (CEST)
Date:   Thu, 28 Jun 2018 13:19:54 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, pagupta@redhat.com,
        Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v6 2/5] mm/sparsemem: Defer the ms->section_mem_map
 clearing
Message-ID: <20180628111954.GA12956@techadventures.net>
References: <20180628062857.29658-1-bhe@redhat.com>
 <20180628062857.29658-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628062857.29658-3-bhe@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 02:28:54PM +0800, Baoquan He wrote:
> In sparse_init(), if CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y, system
> will allocate one continuous memory chunk for mem maps on one node and
> populate the relevant page tables to map memory section one by one. If
> fail to populate for a certain mem section, print warning and its
> ->section_mem_map will be cleared to cancel the marking of being present.
> Like this, the number of mem sections marked as present could become
> less during sparse_init() execution.
> 
> Here just defer the ms->section_mem_map clearing if failed to populate
> its page tables until the last for_each_present_section_nr() loop. This
> is in preparation for later optimizing the mem map allocation.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Looks good to me.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/sparse-vmemmap.c |  4 ----
>  mm/sparse.c         | 15 ++++++++-------
>  2 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index bd0276d5f66b..68bb65b2d34d 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -292,18 +292,14 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
>  	}
>  
>  	for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
> -		struct mem_section *ms;
> -
>  		if (!present_section_nr(pnum))
>  			continue;
>  
>  		map_map[pnum] = sparse_mem_map_populate(pnum, nodeid, NULL);
>  		if (map_map[pnum])
>  			continue;
> -		ms = __nr_to_section(pnum);
>  		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
>  		       __func__);
> -		ms->section_mem_map = 0;
>  	}
>  
>  	if (vmemmap_buf_start) {
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 6314303130b0..6a706093307d 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -441,17 +441,13 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
>  
>  	/* fallback */
>  	for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
> -		struct mem_section *ms;
> -
>  		if (!present_section_nr(pnum))
>  			continue;
>  		map_map[pnum] = sparse_mem_map_populate(pnum, nodeid, NULL);
>  		if (map_map[pnum])
>  			continue;
> -		ms = __nr_to_section(pnum);
>  		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
>  		       __func__);
> -		ms->section_mem_map = 0;
>  	}
>  }
>  #endif /* !CONFIG_SPARSEMEM_VMEMMAP */
> @@ -479,7 +475,6 @@ static struct page __init *sparse_early_mem_map_alloc(unsigned long pnum)
>  
>  	pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
>  	       __func__);
> -	ms->section_mem_map = 0;
>  	return NULL;
>  }
>  #endif
> @@ -583,17 +578,23 @@ void __init sparse_init(void)
>  #endif
>  
>  	for_each_present_section_nr(0, pnum) {
> +		struct mem_section *ms;
> +		ms = __nr_to_section(pnum);
>  		usemap = usemap_map[pnum];
> -		if (!usemap)
> +		if (!usemap) {
> +			ms->section_mem_map = 0;
>  			continue;
> +		}
>  
>  #ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
>  		map = map_map[pnum];
>  #else
>  		map = sparse_early_mem_map_alloc(pnum);
>  #endif
> -		if (!map)
> +		if (!map) {
> +			ms->section_mem_map = 0;
>  			continue;
> +		}
>  
>  		sparse_init_one_section(__nr_to_section(pnum), pnum, map,
>  								usemap);
> -- 
> 2.13.6
> 

-- 
Oscar Salvador
SUSE L3
