Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1050911-1524352532-2-870789345792698565
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DATE_IN_PAST_06_12 1.543,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524352531; b=o7C0t0E2Y+/2fXTFpDrzeHjwzYN8UfEvcLoHmX/2NUdOxy+Luh
    ICTc9e7vgnzq/4ZqyhUfOtw3vmP1/3YtlfyjDgtAicPFKMcI8fB14xX4FJI4iagZ
    QJNnvyfTlEJWN+c5ZVLWDpKG01v1epwmL0yAXgFkNs2qU+Kn4N6PsdBwInwYFFXO
    dr3FcJveYnEa3AGp5F4IgbbhZ7i/mR3lMwAe1dVXAc+EOXtZOHY7fjVAydy5TKaQ
    poZA+Z/rReNU+oD4OpTHmv5rk8lvkS10PUtflVR678rtNA2/mw514EEQYWAGKf75
    Py5SqOwXljZLFIJqR4gw91p5eH+uAfIpKH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:subject:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524352531;
    bh=5VNGK9C3nMbcQCuhrEVIdxSu4837rUU2p8ljzLzFPgk=; b=DQJcBvhvMsPd
    HxxZhXYyUEC07DvV6thobQ5mthGXV3qmPQSs3+g6iOawAigJkJNKglB/GnZX8qU3
    cxg/0UqcgY2HujBNR6NKLilw56YkfvpfmEGHm0VcCCTNDss5vt1TGzSObtZLW3xo
    hcUHadjcI3QQqDV9/2qQoPcPYPbOvLzNkIZUgMg5bWUMEFCgWDZdA5XtUmi+KT6C
    ekZqT3Qa6Vk9amXhe8/Gx6uWERXW60jlp58iN7/UTc1O3hx04Ju1na4rtlAHVDAg
    wr7Ovy7NsAp4ryX+CG83w/AQbKY7HYVkUvnzAr7dnw7LqCUfh1WnRPHeaJLbWjv3
    UIY3oP+DyQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHmaE4rXxABkc2nCC0tlW+jDfNUq8mmcOeU/gZpb13kKe3rlnD7ghcBQHgrkGye9ZgjGz5f61QIKY2uHOgU4chH9eMTwTVskcmC2JPlLwGKo1J4Gd/9j
    ejjJngOZ3FfaLsAlvXWSeNEOfVcktWKehtDQ+0I+EoSHtvExVLIDpr4Xi+7Qvhh+KKGWrq+MDocmuWtSPVlBO3iMyynSJE2tpGGAr9pskXMUdkPc3JipMyQP
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=HMCGxLQ2B_VLhreLiSkA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753280AbeDUXP3 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 21 Apr 2018 19:15:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:46354 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753272AbeDUXP2 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 21 Apr 2018 19:15:28 -0400
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 2/3] mm: add find_alloc_contig_pages() interface
To: Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Guy Shattah <sguy@mellanox.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        David Nellans <dnellans@nvidia.com>,
        Laura Abbott <labbott@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180417020915.11786-1-mike.kravetz@oracle.com>
 <20180417020915.11786-3-mike.kravetz@oracle.com>
Message-ID: <deb9dd1d-84bf-75c7-2880-a7bcec880d47@suse.cz>
Date: Sat, 21 Apr 2018 18:16:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417020915.11786-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/17/2018 04:09 AM, Mike Kravetz wrote:
> find_alloc_contig_pages() is a new interface that attempts to locate
> and allocate a contiguous range of pages.  It is provided as a more
> convenient interface than alloc_contig_range() which is currently
> used by CMA and gigantic huge pages.
> 
> When attempting to allocate a range of pages, migration is employed
> if possible.  There is no guarantee that the routine will succeed.
> So, the user must be prepared for failure and have a fall back plan.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Hi, just two quick observations, maybe discussion pointers for the
LSF/MM session:
- it's weird that find_alloc_contig_pages() takes an order, and
free_contig_pages() takes a nr_pages. I suspect the interface would be
more future-proof with both using nr_pages? Perhaps also minimum
alignment for the allocation side? Order is fine for hugetlb, but what
about other potential users?
- contig_alloc_migratetype_ok() says that MIGRATE_CMA blocks are OK to
allocate from. This silently assumes that everything allocated by this
will be migratable itself, or it might eat CMA reserves. Is it the case?
Also you then call alloc_contig_range() with MIGRATE_MOVABLE, so it will
skip/fail on MIGRATE_CMA anyway IIRC.

Vlastimil

> ---
>  include/linux/gfp.h | 12 ++++++++
>  mm/page_alloc.c     | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 99 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 86a0d06463ab..528b194cc266 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -573,6 +573,18 @@ static inline bool pm_suspended_storage(void)
>  extern int alloc_contig_range(unsigned long start, unsigned long end,
>  			      unsigned migratetype, gfp_t gfp_mask);
>  extern void free_contig_range(unsigned long pfn, unsigned long nr_pages);
> +extern struct page *find_alloc_contig_pages(unsigned int order, gfp_t gfp,
> +						int nid, nodemask_t *nodemask);
> +extern void free_contig_pages(struct page *page, unsigned long nr_pages);
> +#else
> +static inline page *find_alloc_contig_pages(unsigned int order, gfp_t gfp,
> +						int nid, nodemask_t *nodemask)
> +{
> +	return NULL;
> +}
> +static void free_contig_pages(struct page *page, unsigned long nr_pages)
> +{
> +}
>  #endif
>  
>  #ifdef CONFIG_CMA
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0fd5e8e2456e..81070fe55c44 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -67,6 +67,7 @@
>  #include <linux/ftrace.h>
>  #include <linux/lockdep.h>
>  #include <linux/nmi.h>
> +#include <linux/mmzone.h>
>  
>  #include <asm/sections.h>
>  #include <asm/tlbflush.h>
> @@ -2010,9 +2011,13 @@ static __always_inline struct page *__rmqueue_cma_fallback(struct zone *zone,
>  {
>  	return __rmqueue_smallest(zone, order, MIGRATE_CMA);
>  }
> +#define contig_alloc_migratetype_ok(migratetype) \
> +	((migratetype) == MIGRATE_CMA || (migratetype) == MIGRATE_MOVABLE)
>  #else
>  static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
>  					unsigned int order) { return NULL; }
> +#define contig_alloc_migratetype_ok(migratetype) \
> +	((migratetype) == MIGRATE_MOVABLE)
>  #endif
>  
>  /*
> @@ -7822,6 +7827,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  	};
>  	INIT_LIST_HEAD(&cc.migratepages);
>  
> +	if (!contig_alloc_migratetype_ok(migratetype))
> +		return -EINVAL;
> +
>  	/*
>  	 * What we do here is we mark all pageblocks in range as
>  	 * MIGRATE_ISOLATE.  Because pageblock and max order pages may
> @@ -7912,8 +7920,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  
>  	/* Make sure the range is really isolated. */
>  	if (test_pages_isolated(outer_start, end, false)) {
> -		pr_info_ratelimited("%s: [%lx, %lx) PFNs busy\n",
> -			__func__, outer_start, end);
> +		if (!(migratetype == MIGRATE_MOVABLE)) /* only print for CMA */
> +			pr_info_ratelimited("%s: [%lx, %lx) PFNs busy\n",
> +				__func__, outer_start, end);
>  		ret = -EBUSY;
>  		goto done;
>  	}
> @@ -7949,6 +7958,82 @@ void free_contig_range(unsigned long pfn, unsigned long nr_pages)
>  	}
>  	WARN(count != 0, "%ld pages are still in use!\n", count);
>  }
> +
> +static bool contig_pfn_range_valid(struct zone *z, unsigned long start_pfn,
> +					unsigned long nr_pages)
> +{
> +	unsigned long i, end_pfn = start_pfn + nr_pages;
> +	struct page *page;
> +
> +	for (i = start_pfn; i < end_pfn; i++) {
> +		if (!pfn_valid(i))
> +			return false;
> +
> +		page = pfn_to_page(i);
> +
> +		if (page_zone(page) != z)
> +			return false;
> +
> +	}
> +
> +	return true;
> +}
> +
> +/**
> + * find_alloc_contig_pages() -- attempt to find and allocate a contiguous
> + *				range of pages
> + * @order:	number of pages
> + * @gfp:	gfp mask used to limit search as well as during compaction
> + * @nid:	target node
> + * @nodemask:	mask of other possible nodes
> + *
> + * Pages can be freed with a call to free_contig_pages(), or by manually
> + * calling __free_page() for each page allocated.
> + *
> + * Return: pointer to 'order' pages on success, or NULL if not successful.
> + */
> +struct page *find_alloc_contig_pages(unsigned int order, gfp_t gfp,
> +					int nid, nodemask_t *nodemask)
> +{
> +	unsigned long pfn, nr_pages, flags;
> +	struct page *ret_page = NULL;
> +	struct zonelist *zonelist;
> +	struct zoneref *z;
> +	struct zone *zone;
> +	int rc;
> +
> +	nr_pages = 1 << order;
> +	zonelist = node_zonelist(nid, gfp);
> +	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp),
> +					nodemask) {
> +		spin_lock_irqsave(&zone->lock, flags);
> +		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
> +		while (zone_spans_pfn(zone, pfn + nr_pages - 1)) {
> +			if (contig_pfn_range_valid(zone, pfn, nr_pages)) {
> +				spin_unlock_irqrestore(&zone->lock, flags);
> +
> +				rc = alloc_contig_range(pfn, pfn + nr_pages,
> +							MIGRATE_MOVABLE, gfp);
> +				if (!rc) {
> +					ret_page = pfn_to_page(pfn);
> +					return ret_page;
> +				}
> +				spin_lock_irqsave(&zone->lock, flags);
> +			}
> +			pfn += nr_pages;
> +		}
> +		spin_unlock_irqrestore(&zone->lock, flags);
> +	}
> +
> +	return ret_page;
> +}
> +EXPORT_SYMBOL_GPL(find_alloc_contig_pages);
> +
> +void free_contig_pages(struct page *page, unsigned long nr_pages)
> +{
> +	free_contig_range(page_to_pfn(page), nr_pages);
> +}
> +EXPORT_SYMBOL_GPL(free_contig_pages);
>  #endif
>  
>  #if defined CONFIG_MEMORY_HOTPLUG || defined CONFIG_CMA
> 

