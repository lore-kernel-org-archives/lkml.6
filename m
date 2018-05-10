Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AB8JxZoTnjRvpKX+RBmwjJxTpVKvnskgPEwHh3SVvY2wqim64fzJohGOGwmxWrpdF0PiN8cLnx9M
ARC-Seal: i=1; a=rsa-sha256; t=1525941370; cv=none;
        d=google.com; s=arc-20160816;
        b=PZgDrCPz+haAAHhx/YQ+qytL22dtHFp7vBXIX+TU5LF2RDRhSoXVqbYi3zB+YUkOt1
         AfjoDX6F+/UT7wgXCC8VP9Q6JDfFgwJ4dRcJQ8dONYAajMLcnmTMEkBn6V1Y9IyF7RHt
         wnWm91P4m9DKh4irVlWOxivciNn/f4LUYofzupeBoSA//P2VH6JfzTMUPTtRYF7Ln3JY
         ALtp52JcVMqvzLBJ5mrtBLnGYcJoz4wYvlS7NnW18rUvOAhM81akOrfRYxanS7NHTwbD
         prQbsBm8v0ALeqbV56m42nR5ayys2A8YsyzbmIAegIjm6ruyNKm6oGoFdBv9jf8IaAaw
         WigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=Lej+TvnSHElBpYUkYnZNoKj5ZYb4Qj8g+MpvvG/qLB4=;
        b=iZ6/wam9jRtemgUQLSWyWEA1ZhUIZRYA5WmVYB0r29mR2DR5w/ZA+pcbli8AJxDJ0b
         +VyUr8SvZvymnJfZlD8YY6EkYxsGPU3m4noWjmr0JxDCfJxBQjVNRAg8kvBEw5P6OQrN
         hS4zLQb0qf6XgqBcAAC4vI2GNgfBQDyZ/DKvy1oL8OPuYsBHxA8Rbj3XMgM5JVAIbn48
         9vFo9Gz1I9SxOq2GO+lZ1hxEAwB4Ppi7MdNkN0zm18FwmfbwnXplnfes8Ah6nvuOI9cU
         CMm/d8F2Xtnh62XfMCwv21sF1goC76gn3igwPYgn4Oe+LSSWfojBMIbNKL34sGMBmKnC
         ptwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning mhocko@kernel.org does not designate 195.135.220.15 as permitted sender) smtp.mailfrom=mhocko@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning mhocko@kernel.org does not designate 195.135.220.15 as permitted sender) smtp.mailfrom=mhocko@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 10 May 2018 10:36:04 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Mathieu Malaterre <malat@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Reza Arbab <arbab@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mel Gorman <mgorman@techsingularity.net>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: move =?utf-8?Q?function?=
 =?utf-8?B?IOKAmGlzX3BhZ2VibG9ja19yZW1vdmFibGVfbm9sb2Nr?= =?utf-8?B?4oCZ?= to
 mm/memory_hotplug.c
Message-ID: <20180510083604.GI32366@dhcp22.suse.cz>
References: <20180505201107.21070-1-malat@debian.org>
 <20180509190001.24789-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180509190001.24789-1-malat@debian.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600014160898520786?=
X-GMAIL-MSGID: =?utf-8?q?1600065498073197084?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed 09-05-18 20:59:57, Mathieu Malaterre wrote:
> Function ‘is_pageblock_removable_nolock’ is not used outside of
> mm/memory_hotplug.c. Move it next to unique caller:
> ‘is_mem_section_removable’ and make it static.
> Remove prototype in <linux/memory_hotplug.h>. Silence gcc warning (W=1):
> 
>   mm/page_alloc.c:7704:6: warning: no previous prototype for ‘is_pageblock_removable_nolock’ [-Wmissing-prototypes]
> 
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
> v2: this function can be made static, make it so
> 
>  include/linux/memory_hotplug.h |  1 -
>  mm/memory_hotplug.c            | 23 +++++++++++++++++++++++
>  mm/page_alloc.c                | 23 -----------------------
>  3 files changed, 23 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index e0e49b5b1ee1..9566d551a41b 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -107,7 +107,6 @@ static inline bool movable_node_is_enabled(void)
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTREMOVE
> -extern bool is_pageblock_removable_nolock(struct page *page);
>  extern int arch_remove_memory(u64 start, u64 size,
>  		struct vmem_altmap *altmap);
>  extern int __remove_pages(struct zone *zone, unsigned long start_pfn,
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index f74826cdceea..9342e120518a 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1237,6 +1237,29 @@ static struct page *next_active_pageblock(struct page *page)
>  	return page + pageblock_nr_pages;
>  }
>  
> +static bool is_pageblock_removable_nolock(struct page *page)
> +{
> +	struct zone *zone;
> +	unsigned long pfn;
> +
> +	/*
> +	 * We have to be careful here because we are iterating over memory
> +	 * sections which are not zone aware so we might end up outside of
> +	 * the zone but still within the section.
> +	 * We have to take care about the node as well. If the node is offline
> +	 * its NODE_DATA will be NULL - see page_zone.
> +	 */
> +	if (!node_online(page_to_nid(page)))
> +		return false;
> +
> +	zone = page_zone(page);
> +	pfn = page_to_pfn(page);
> +	if (!zone_spans_pfn(zone, pfn))
> +		return false;
> +
> +	return !has_unmovable_pages(zone, page, 0, MIGRATE_MOVABLE, true);
> +}
> +
>  /* Checks if this range of memory is likely to be hot-removable. */
>  bool is_mem_section_removable(unsigned long start_pfn, unsigned long nr_pages)
>  {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 905db9d7962f..52731601ca5a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7701,29 +7701,6 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>  	return false;
>  }
>  
> -bool is_pageblock_removable_nolock(struct page *page)
> -{
> -	struct zone *zone;
> -	unsigned long pfn;
> -
> -	/*
> -	 * We have to be careful here because we are iterating over memory
> -	 * sections which are not zone aware so we might end up outside of
> -	 * the zone but still within the section.
> -	 * We have to take care about the node as well. If the node is offline
> -	 * its NODE_DATA will be NULL - see page_zone.
> -	 */
> -	if (!node_online(page_to_nid(page)))
> -		return false;
> -
> -	zone = page_zone(page);
> -	pfn = page_to_pfn(page);
> -	if (!zone_spans_pfn(zone, pfn))
> -		return false;
> -
> -	return !has_unmovable_pages(zone, page, 0, MIGRATE_MOVABLE, true);
> -}
> -
>  #if (defined(CONFIG_MEMORY_ISOLATION) && defined(CONFIG_COMPACTION)) || defined(CONFIG_CMA)
>  
>  static unsigned long pfn_max_align_down(unsigned long pfn)
> -- 
> 2.11.0
> 

-- 
Michal Hocko
SUSE Labs
