Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1449503-1526946571-2-10453348366308147614
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526946570; b=NIjCu+VJ+6gDTIs/qsV5w/c/fwyT6oJ6ufH7RPL+VQFIc0JBpW
    qBVyqeR5OOL+GfQgIdbAsnkZeG7xhMbudz6RCiZUrBNw3h99AMXdWy6xrkU2KFUs
    gy7MEvT6KLzvHOWv3lqmbeYx7OF7RQOCkQX0RBKaeQk61BGC3QeGL4ND8r8p6X9E
    23Z3IUHas+yBSU58F7z2is+5qJUpny55EPn2b//OoqrjCQfeNPC45fzTkuPi85zi
    KkQ0rxMPxIRiGAoLV8ZpyuioRWizawTh6arKjNU/CHj3IT5dFYkrlzWpFTZ6KzFV
    C0daz1PLXUzNv9oy0VJCjEXXw+JX6ujcYPHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526946570;
    bh=fKVw4NI9zBmQYloCzWMcsjLH3fjnfVFmqMEqrcu6hMg=; b=GESnsFgw6CaW
    NXq+dSELPellvKgDYynNbna5ad2shsO4gzXxKRz+jVNcZqdZ53frlr8uBdrWNQvJ
    D5J5G5/YZ4efZ9vkUTf8GgsmI1/yNUkJ9haj1RdDJog2zoALZ4f8PLKq7s9EgVw1
    9NNgvjwUWvnMr/UWWZSbJ0YLfmABn9gFdaicc3f5btULnyi9qHQxaZs1VKjsXWOu
    zm6WbuSJWekkgIN5CIhpU6gsvieetAKqw8C9RLvGA57APMjjwoUV5x8fPVfrdywF
    LQGrqjAxW4SG7uzOQRDf6HVrv5mKU6fTwH9D6+GeP7NJ5mxmemrBhAGpqXYB2Ekv
    Cqw9xNKy3A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=pbiqAcBz x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=pbiqAcBz x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHJFS+fikvtXTJcXeka3QgCvJiBHU0WkvPlgxjohEOhqiq5EptlOHqgiLoYRUlxDJFspVgynwT5XKZoSJCc1yuQrxYxsnyP7bvsSN6S839+4+1AU3agW
    DFL7OjWgBlTRCqvaMW5WFqTpJLlRFysc0gvxxR4NET+7wpfqK+JCrWodhbsknX/lwLtrYtIT+UKT2MzjmRv3C0DwlGgnNuLeJbdqvlqDH2Qe7E9nNUz3yEbj
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=Hq1J561--tRduizTDNQA:9
    a=yh81Mmlrnk-J4TbG:21 a=Wp4GhgG65Dr3Sl3J:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751504AbeEUXt1 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 19:49:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35856 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751368AbeEUXt0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 21 May 2018 19:49:26 -0400
Subject: Re: [PATCH v2 3/4] mm: add find_alloc_contig_pages() interface
To: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
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
 <eaa40ac0-365b-fd27-e096-b171ed28888f@suse.cz>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <57dfd52c-22a5-5546-f8f3-848f21710cc1@oracle.com>
Date: Mon, 21 May 2018 16:48:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <eaa40ac0-365b-fd27-e096-b171ed28888f@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8900 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805210270
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/21/2018 01:54 AM, Vlastimil Babka wrote:
> On 05/04/2018 01:29 AM, Mike Kravetz wrote:
>> find_alloc_contig_pages() is a new interface that attempts to locate
>> and allocate a contiguous range of pages.  It is provided as a more
> 
> How about dropping the 'find_' from the name, so it's more like other
> allocator functions? All of them have to 'find' the free pages in some
> sense.

Sure

> 
>> convenient interface than alloc_contig_range() which is currently
>> used by CMA and gigantic huge pages.
>>
>> When attempting to allocate a range of pages, migration is employed
>> if possible.  There is no guarantee that the routine will succeed.
>> So, the user must be prepared for failure and have a fall back plan.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  include/linux/gfp.h |  12 +++++
>>  mm/page_alloc.c     | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 146 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index 86a0d06463ab..b0d11777d487 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -573,6 +573,18 @@ static inline bool pm_suspended_storage(void)
>>  extern int alloc_contig_range(unsigned long start, unsigned long end,
>>  			      unsigned migratetype, gfp_t gfp_mask);
>>  extern void free_contig_range(unsigned long pfn, unsigned long nr_pages);
>> +extern struct page *find_alloc_contig_pages(unsigned long nr_pages, gfp_t gfp,
>> +						int nid, nodemask_t *nodemask);
>> +extern void free_contig_pages(struct page *page, unsigned long nr_pages);
>> +#else
>> +static inline struct page *find_alloc_contig_pages(unsigned long nr_pages,
>> +				gfp_t gfp, int nid, nodemask_t *nodemask)
>> +{
>> +	return NULL;
>> +}
>> +static inline void free_contig_pages(struct page *page, unsigned long nr_pages)
>> +{
>> +}
>>  #endif
>>  
>>  #ifdef CONFIG_CMA
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index cb1a5e0be6ee..d0a2d0da9eae 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -67,6 +67,7 @@
>>  #include <linux/ftrace.h>
>>  #include <linux/lockdep.h>
>>  #include <linux/nmi.h>
>> +#include <linux/mmzone.h>
>>  
>>  #include <asm/sections.h>
>>  #include <asm/tlbflush.h>
>> @@ -7913,8 +7914,12 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>>  
>>  	/* Make sure the range is really isolated. */
>>  	if (test_pages_isolated(outer_start, end, false)) {
>> -		pr_info_ratelimited("%s: [%lx, %lx) PFNs busy\n",
>> -			__func__, outer_start, end);
>> +#ifdef MIGRATE_CMA
>> +		/* Only print messages for CMA allocations */
>> +		if (migratetype == MIGRATE_CMA)
> 
> I think is_migrate_cma() can be used to avoid the #ifdef.
> 

Thanks.  I missed that and did not want to create something new.

>> +			pr_info_ratelimited("%s: [%lx, %lx) PFNs busy\n",
>> +				__func__, outer_start, end);
>> +#endif
>>  		ret = -EBUSY;
>>  		goto done;
>>  	}
>> @@ -7950,6 +7955,133 @@ void free_contig_range(unsigned long pfn, unsigned long nr_pages)
>>  	}
>>  	WARN(count != 0, "%ld pages are still in use!\n", count);
>>  }
>> +
>> +/*
>> + * Only check for obvious pfn/pages which can not be used/migrated.  The
>> + * migration code will do the final check.  Under stress, this minimal set
>> + * has been observed to provide the best results.  The checks can be expanded
>> + * if needed.
> 
> Hm I kind of doubt this is optimal, it doesn't test almost anything
> besides basic validity, so it won't exclude ranges where the allocation
> will fail. I will write more in a reply to the header where complexity
> is discussed.
> 

Ok.  This 'appeared' to work best in testing where I had all CPUs in tight
loops calling this new interface to allocate and then free contiguous pages.
I was somewhat surprised at the result, and it may just be due to the nature
of my testing.

>> + */
>> +static bool contig_pfn_range_valid(struct zone *z, unsigned long start_pfn,
>> +					unsigned long nr_pages)
>> +{
>> +	unsigned long i, end_pfn = start_pfn + nr_pages;
>> +	struct page *page;
>> +
>> +	for (i = start_pfn; i < end_pfn; i++) {
>> +		if (!pfn_valid(i))
>> +			return false;
>> +
>> +		page = pfn_to_online_page(i);
>> +
>> +		if (page_zone(page) != z)
>> +			return false;
>> +
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +/*
>> + * Search for and attempt to allocate contiguous allocations greater than
>> + * MAX_ORDER.
>> + */
>> +static struct page *__alloc_contig_pages_nodemask(gfp_t gfp,
>> +						unsigned long order,
>> +						int nid, nodemask_t *nodemask)
>> +{
>> +	unsigned long nr_pages, pfn, flags;
>> +	struct page *ret_page = NULL;
>> +	struct zonelist *zonelist;
>> +	struct zoneref *z;
>> +	struct zone *zone;
>> +	int rc;
>> +
>> +	nr_pages = 1 << order;
>> +	zonelist = node_zonelist(nid, gfp);
>> +	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp),
>> +					nodemask) {
>> +		pgdat_resize_lock(zone->zone_pgdat, &flags);
>> +		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
>> +		while (zone_spans_pfn(zone, pfn + nr_pages - 1)) {
>> +			if (contig_pfn_range_valid(zone, pfn, nr_pages)) {
>> +				struct page *page = pfn_to_online_page(pfn);
>> +				unsigned int migratetype;
>> +
>> +				/*
>> +				 * All pageblocks in range must be of same
>> +				 * migrate type.
>> +				 */
>> +				migratetype = get_pageblock_migratetype(page);
>> +				pgdat_resize_unlock(zone->zone_pgdat, &flags);
>> +
>> +				rc = alloc_contig_range(pfn, pfn + nr_pages,
>> +						migratetype, gfp);
>> +				if (!rc) {
>> +					ret_page = pfn_to_page(pfn);
>> +					return ret_page;
>> +				}
>> +				pgdat_resize_lock(zone->zone_pgdat, &flags);
>> +			}
>> +			pfn += nr_pages;
>> +		}
>> +		pgdat_resize_unlock(zone->zone_pgdat, &flags);
>> +	}
>> +
>> +	return ret_page;
>> +}
>> +
>> +/**
>> + * find_alloc_contig_pages() -- attempt to find and allocate a contiguous
>> + *				range of pages
>> + * @nr_pages:	number of pages to find/allocate
>> + * @gfp:	gfp mask used to limit search as well as during compaction
>> + * @nid:	target node
>> + * @nodemask:	mask of other possible nodes
>> + *
>> + * Pages can be freed with a call to free_contig_pages(), or by manually
>> + * calling __free_page() for each page allocated.
>> + *
>> + * Return: pointer to 'order' pages on success, or NULL if not successful.
>> + */
>> +struct page *find_alloc_contig_pages(unsigned long nr_pages, gfp_t gfp,
>> +					int nid, nodemask_t *nodemask)
>> +{
>> +	unsigned long i, alloc_order, order_pages;
>> +	struct page *pages;
>> +
>> +	/*
>> +	 * Underlying allocators perform page order sized allocations.
>> +	 */
>> +	alloc_order = get_count_order(nr_pages);
> 
> So if takes arbitrary nr_pages but convert it to order anyway? I think
> that's rather suboptimal and wasteful... e.g. a range could be skipped
> because some of the pages added by rounding cannot be migrated away.

Yes.  My idea with this series was to use existing allocators which are
all order based.  Let me think about how to do allocation for arbitrary
number of allocations.
- For less than MAX_ORDER size we rely on the buddy allocator, so we are
  pretty much stuck with order sized allocation.  However, allocations of
  this size are not really interesting as you can call existing routines
  directly.
- For sizes greater than MAX_ORDER, we know that the allocation size will
  be at least pageblock sized.  So, the isolate/migrate scheme can still
  be used for full pageblocks.  We can then use direct migration for the
  remaining pages.  This does complicate things a bit.

I'm guessing that most (?all?) allocations will be order based.  The use
cases I am aware of (hugetlbfs, Intel Cache Pseudo-Locking, RDMA) are all
order based.  However, as commented in previous version taking arbitrary
nr_pages makes interface more future proof.
-- 
Mike Kravetz

> 
> Vlastimil
> 
>> +	if (alloc_order < MAX_ORDER) {
>> +		pages = __alloc_pages_nodemask(gfp, (unsigned int)alloc_order,
>> +						nid, nodemask);
>> +		split_page(pages, alloc_order);
>> +	} else {
>> +		pages = __alloc_contig_pages_nodemask(gfp, alloc_order, nid,
>> +							nodemask);
>> +	}
>> +
>> +	if (pages) {
>> +		/*
>> +		 * More pages than desired could have been allocated due to
>> +		 * rounding up to next page order.  Free any excess pages.
>> +		 */
>> +		order_pages = 1UL << alloc_order;
>> +		for (i = nr_pages; i < order_pages; i++)
>> +			__free_page(pages + i);
>> +	}
>> +
>> +	return pages;
>> +}
>> +EXPORT_SYMBOL_GPL(find_alloc_contig_pages);
>> +
>> +void free_contig_pages(struct page *page, unsigned long nr_pages)
>> +{
>> +	free_contig_range(page_to_pfn(page), nr_pages);
>> +}
>> +EXPORT_SYMBOL_GPL(free_contig_pages);
>>  #endif
>>  
>>  #if defined CONFIG_MEMORY_HOTPLUG || defined CONFIG_CMA
>>
> 
