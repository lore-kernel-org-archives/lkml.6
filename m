Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-398581-1526892995-2-5183246169029536875
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526892994; b=PriLEHszpUAsUYJJIuc2vjUguyLaZ0TbUl2tpCSugs/qrpw6PP
    5DHBoBUaKfUCoSfkawjy3jNP12mXrLwJH2pKWdfpKacBbbl5+4qWIeNXIg4WXVzC
    YJTb9Y9fb6vYXQMhBGO+Ebayva82bEuaVfEhUlblbQK9lEcdA98b6rMLMA+p81MC
    gYXtDTInxrurbKq89dOW+ZPZOY2eV1d+qEHC92igd3a1hXzNg+fRn35T/h0cBxqU
    2lTTZxvoY9us16sb0aAuqSz4M82Fj1FAGTtWOcL/H3WoLs2sGs3/ououfQXb6vbi
    hhTyOzTiR85gpe9wPwdVPh35EdCKngWw/E6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526892994;
    bh=n5ijR8biy0YDwMGk9pHmVi/XI1d+Gj0wDlnm01t4x2A=; b=hxFKT4cKOj7s
    sxv2CSVK1yejC6QCRLpyf/MmYmCC2v1HWwUDDqgimM1ycApgutexAniNbZv4SBP1
    z42RtFkUU1z32W6PqnO4SSpM9dd9Bfmk76Al8TTq3ONVg3h0BieFd3Z9VZIQ2OE7
    aPDFTLW7N8WEk1Qk7FgtkxwYQ0VEPHWDh5N5D/RvFAC22VFP7PAK9bWCF2fsvLiN
    ZxQ6u37v8GGHamyEgiweH8RsarHs5R2VywTIpr1JsWILOwyjEGGitwjRXtV1PI6H
    x/fkxONiXH8LmjPTS4xQhA7hEW5XWON4ElMVpuxoCNjk9BGT6EEhAh7RxyK68Hsy
    NZxuuxqmEg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKSGrJowoIvbk15Q0smeQbC0OJy75LUgCjFUktAA3Wbx04+MFisU5n6qHQkjMBLZsn9ZchBVveC4aJNgmv6B0p7DhKwDXkRjB9nNc/ARF65mRYpC4m2u
    9odInUNUx40zeeJUi8d31xor5nxCWwf4oeHVgDi8Sc3HlkDHBNGrUHQ9QwdCCpYpOlsvrPwRwX0HsSGu3xSwkeHWkDDq0DcoIOcQV9nmQ35Ua0ogmNCWkzlA
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=JCGsYyGCQpunkBPGe-MA:9
    a=Q0kCKT2Tpdn2lE7g:21 a=6RWu7V3lebuvgPbT:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeEUIyw (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 04:54:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:41503 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751434AbeEUIyt (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 21 May 2018 04:54:49 -0400
Subject: Re: [PATCH v2 3/4] mm: add find_alloc_contig_pages() interface
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
References: <20180503232935.22539-1-mike.kravetz@oracle.com>
 <20180503232935.22539-4-mike.kravetz@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
 A3XDrKOXTZil3g8D
Message-ID: <eaa40ac0-365b-fd27-e096-b171ed28888f@suse.cz>
Date: Mon, 21 May 2018 10:54:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503232935.22539-4-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/04/2018 01:29 AM, Mike Kravetz wrote:
> find_alloc_contig_pages() is a new interface that attempts to locate
> and allocate a contiguous range of pages.  It is provided as a more

How about dropping the 'find_' from the name, so it's more like other
allocator functions? All of them have to 'find' the free pages in some
sense.

> convenient interface than alloc_contig_range() which is currently
> used by CMA and gigantic huge pages.
> 
> When attempting to allocate a range of pages, migration is employed
> if possible.  There is no guarantee that the routine will succeed.
> So, the user must be prepared for failure and have a fall back plan.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  include/linux/gfp.h |  12 +++++
>  mm/page_alloc.c     | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 146 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 86a0d06463ab..b0d11777d487 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -573,6 +573,18 @@ static inline bool pm_suspended_storage(void)
>  extern int alloc_contig_range(unsigned long start, unsigned long end,
>  			      unsigned migratetype, gfp_t gfp_mask);
>  extern void free_contig_range(unsigned long pfn, unsigned long nr_pages);
> +extern struct page *find_alloc_contig_pages(unsigned long nr_pages, gfp_t gfp,
> +						int nid, nodemask_t *nodemask);
> +extern void free_contig_pages(struct page *page, unsigned long nr_pages);
> +#else
> +static inline struct page *find_alloc_contig_pages(unsigned long nr_pages,
> +				gfp_t gfp, int nid, nodemask_t *nodemask)
> +{
> +	return NULL;
> +}
> +static inline void free_contig_pages(struct page *page, unsigned long nr_pages)
> +{
> +}
>  #endif
>  
>  #ifdef CONFIG_CMA
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cb1a5e0be6ee..d0a2d0da9eae 100644
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
> @@ -7913,8 +7914,12 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  
>  	/* Make sure the range is really isolated. */
>  	if (test_pages_isolated(outer_start, end, false)) {
> -		pr_info_ratelimited("%s: [%lx, %lx) PFNs busy\n",
> -			__func__, outer_start, end);
> +#ifdef MIGRATE_CMA
> +		/* Only print messages for CMA allocations */
> +		if (migratetype == MIGRATE_CMA)

I think is_migrate_cma() can be used to avoid the #ifdef.

> +			pr_info_ratelimited("%s: [%lx, %lx) PFNs busy\n",
> +				__func__, outer_start, end);
> +#endif
>  		ret = -EBUSY;
>  		goto done;
>  	}
> @@ -7950,6 +7955,133 @@ void free_contig_range(unsigned long pfn, unsigned long nr_pages)
>  	}
>  	WARN(count != 0, "%ld pages are still in use!\n", count);
>  }
> +
> +/*
> + * Only check for obvious pfn/pages which can not be used/migrated.  The
> + * migration code will do the final check.  Under stress, this minimal set
> + * has been observed to provide the best results.  The checks can be expanded
> + * if needed.

Hm I kind of doubt this is optimal, it doesn't test almost anything
besides basic validity, so it won't exclude ranges where the allocation
will fail. I will write more in a reply to the header where complexity
is discussed.

> + */
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
> +		page = pfn_to_online_page(i);
> +
> +		if (page_zone(page) != z)
> +			return false;
> +
> +	}
> +
> +	return true;
> +}
> +
> +/*
> + * Search for and attempt to allocate contiguous allocations greater than
> + * MAX_ORDER.
> + */
> +static struct page *__alloc_contig_pages_nodemask(gfp_t gfp,
> +						unsigned long order,
> +						int nid, nodemask_t *nodemask)
> +{
> +	unsigned long nr_pages, pfn, flags;
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
> +		pgdat_resize_lock(zone->zone_pgdat, &flags);
> +		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
> +		while (zone_spans_pfn(zone, pfn + nr_pages - 1)) {
> +			if (contig_pfn_range_valid(zone, pfn, nr_pages)) {
> +				struct page *page = pfn_to_online_page(pfn);
> +				unsigned int migratetype;
> +
> +				/*
> +				 * All pageblocks in range must be of same
> +				 * migrate type.
> +				 */
> +				migratetype = get_pageblock_migratetype(page);
> +				pgdat_resize_unlock(zone->zone_pgdat, &flags);
> +
> +				rc = alloc_contig_range(pfn, pfn + nr_pages,
> +						migratetype, gfp);
> +				if (!rc) {
> +					ret_page = pfn_to_page(pfn);
> +					return ret_page;
> +				}
> +				pgdat_resize_lock(zone->zone_pgdat, &flags);
> +			}
> +			pfn += nr_pages;
> +		}
> +		pgdat_resize_unlock(zone->zone_pgdat, &flags);
> +	}
> +
> +	return ret_page;
> +}
> +
> +/**
> + * find_alloc_contig_pages() -- attempt to find and allocate a contiguous
> + *				range of pages
> + * @nr_pages:	number of pages to find/allocate
> + * @gfp:	gfp mask used to limit search as well as during compaction
> + * @nid:	target node
> + * @nodemask:	mask of other possible nodes
> + *
> + * Pages can be freed with a call to free_contig_pages(), or by manually
> + * calling __free_page() for each page allocated.
> + *
> + * Return: pointer to 'order' pages on success, or NULL if not successful.
> + */
> +struct page *find_alloc_contig_pages(unsigned long nr_pages, gfp_t gfp,
> +					int nid, nodemask_t *nodemask)
> +{
> +	unsigned long i, alloc_order, order_pages;
> +	struct page *pages;
> +
> +	/*
> +	 * Underlying allocators perform page order sized allocations.
> +	 */
> +	alloc_order = get_count_order(nr_pages);

So if takes arbitrary nr_pages but convert it to order anyway? I think
that's rather suboptimal and wasteful... e.g. a range could be skipped
because some of the pages added by rounding cannot be migrated away.

Vlastimil

> +	if (alloc_order < MAX_ORDER) {
> +		pages = __alloc_pages_nodemask(gfp, (unsigned int)alloc_order,
> +						nid, nodemask);
> +		split_page(pages, alloc_order);
> +	} else {
> +		pages = __alloc_contig_pages_nodemask(gfp, alloc_order, nid,
> +							nodemask);
> +	}
> +
> +	if (pages) {
> +		/*
> +		 * More pages than desired could have been allocated due to
> +		 * rounding up to next page order.  Free any excess pages.
> +		 */
> +		order_pages = 1UL << alloc_order;
> +		for (i = nr_pages; i < order_pages; i++)
> +			__free_page(pages + i);
> +	}
> +
> +	return pages;
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

