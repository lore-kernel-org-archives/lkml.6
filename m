Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1449503-1526944277-2-5895249349949990242
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
    1526944276; b=MoffJHdclsnCJGf8HOg+2M432uqWAwHmortNRBoPYJoJvnxFDD
    Z2zUmjCvPP1dnOxYLJKCgRDjzlyscW/88qMhaXA3mzPC7VMbmB09piTOANYcOEAs
    PQKat0lXJIUCbW0bOFvQ9kfV67KyiDPClGRP5LG8Doo9Lh0YUUtL3aiCZqsa8yH+
    sWcP62xv1v1skED+WwVXFndUXEn2YEhisElVASnEkC0doNXyfbI20LL4UJ/XuSyX
    JTyeunyd26UaVJ17Lq/RTjYfWcYjOJOuyZnckQxal3IMUJLhQvRX8Xa17U+8wM7M
    EF9gvsqib5kFbdYuDTQv4DfF4h5FRzD6gIrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526944276;
    bh=dUrZpMor6IqdyGefrmB4usdCBCHNG1BNRDNTwr+YoaY=; b=OJjdBEmzZcol
    gfVduZ9eHaKHRxs8lFQOOanqBae4RTKQ0TdE/6hQFee3lDO8siZb1tgN5ONheOyc
    NoiiW8sLwAINJ+WoS/RQ7SGcV+8UKtXt1OI/auK9HpNxAR4gIP1hX63XJcaEBLgF
    ftMFo2x+Y2MiWl6OKrJbKltDUGIax6A3YJD7ob9PxeFS7uvo0stZfAvttzq/NMHF
    Jiwd98QZeCwffmkVZq4zBk268n0Z+NAL7fxYFZ8m6ntTJ4mIRCm8GbjcxxVoDzxI
    hgHgOyMhuycSKzUvTrO4G686RRU41UKcoWXcYsko1zFf9s5gFXKb2B7R/8t0Qs3N
    LIEfuxX8qQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=j4nuaFf1 x-bits=2048
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=j4nuaFf1 x-bits=2048
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
X-CM-Envelope: MS4wfFtA+Y0n+J3mTTwQ8AZCKqKtpQibSntLWeAdU0jTRKsuXXHciFGitf2q9mL3GYsxq+3E+MGPEsjlBZ4vrpJLRDiXReTmKY8AZ94LFQDmzMvcx7+/0lry
    5YREiHGI/HeJBqci0d2kBvcZEqAWQmmQEFuQ9Ci5Bix4PZ0haG5/ZEvj8yWuK04MWF48OzIGH7gU3ddsX+8pxMC5lzRADs6MlS/H6YBynirVdg8v6dh1q4LS
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=MtGsFKH40ciCg42ihfcA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751127AbeEUXLP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 19:11:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45178 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbeEUXLN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 21 May 2018 19:11:13 -0400
Subject: Re: [PATCH v2 2/4] mm: check for proper migrate type during isolation
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
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20180503232935.22539-1-mike.kravetz@oracle.com>
 <20180503232935.22539-3-mike.kravetz@oracle.com>
 <0a74f688-74fb-b841-4782-f9c96b1b9cfc@suse.cz>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <f50d6814-8bc6-80cd-c0e5-b2cfa4f9e576@oracle.com>
Date: Mon, 21 May 2018 16:10:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <0a74f688-74fb-b841-4782-f9c96b1b9cfc@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8900 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805210265
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/18/2018 03:32 AM, Vlastimil Babka wrote:
> On 05/04/2018 01:29 AM, Mike Kravetz wrote:
>> The routine start_isolate_page_range and alloc_contig_range have
>> comments saying that migratetype must be either MIGRATE_MOVABLE or
>> MIGRATE_CMA.  However, this is not enforced.
> 
> Enforced, no. But if the pageblocks really were as such, it used to
> shortcut has_unmovable_pages(). This was wrong and removed in
> d7b236e10ced ("mm: drop migrate type checks from has_unmovable_pages")
> plus 4da2ce250f98 ("mm: distinguish CMA and MOVABLE isolation in
> has_unmovable_pages()").
> 
> 
>   What is important is
>> that that all pageblocks in the range are of type migratetype.
>                                                the same
>> This is because blocks will be set to migratetype on error.
> 
> Strictly speaking this is true only for the CMA case. For other cases,
> the best thing actually would be to employ the same heuristics as page
> allocation migratetype fallbacks, and count how many pages are free and
> how many appear to be movable, see how steal_suitable_fallback() uses
> the last parameter of move_freepages_block().
> 
>> Add a boolean argument enforce_migratetype to the routine
>> start_isolate_page_range.  If set, it will check that all pageblocks
>> in the range have the passed migratetype.  Return -EINVAL is pageblock
>                                                             if
>> is wrong type is found in range.
>   of
>>
>> A boolean is used for enforce_migratetype as there are two primary
>> users.  Contiguous range allocation which wants to enforce migration
>> type checking.  Memory offline (hotplug) which is not concerned about
>> type checking.
> 
> This is missing some high-level result. The end change is that CMA is
> now enforcing. So we are making it more robust when it's called on
> non-CMA pageblocks by mistake? (BTW I still do hope we can remove
> MIGRATE_CMA soon after Joonsoo's ZONE_MOVABLE CMA conversion. Combined
> with my suggestion above we could hopefully get rid of the migratetype
> parameter completely instead of enforcing it?). Is this also a
> preparation for introducing find_alloc_contig_pages() which will be
> enforcing? (I guess, and will find out shortly, but it should be stated
> here)

Thank you for looking at these patches Vlastimil.

My primary motivation for this patch was the 'error recovery' in
start_isolate_page_range.  It takes a range and attempts to set
all pageblocks to MIGRATE_ISOLATE.  If it encounters an error after
setting some blocks to isolate, it will 'clean up' by setting the
migrate type of previously modified blocks to the passed migratetype.

So, one possible side effect of an error in start_isolate_page_range
is that the migrate type of some pageblocks could be modified.  Thinking
about it more now, that may be OK.  It just does not seem like the
right thing to do, especially with comments saying "migratetype must
be either MIGRATE_MOVABLE or MIGRATE_CMA".  I'm fine with leaving the
code as is and just cleaning up the comments if you think that may
be better.

> 
> Thanks,
> Vlastimil
> 
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  include/linux/page-isolation.h |  8 +++-----
>>  mm/memory_hotplug.c            |  2 +-
>>  mm/page_alloc.c                | 17 +++++++++--------
>>  mm/page_isolation.c            | 40 ++++++++++++++++++++++++++++++----------
>>  4 files changed, 43 insertions(+), 24 deletions(-)
>>
>> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
>> index 4ae347cbc36d..2ab7e5a399ac 100644
>> --- a/include/linux/page-isolation.h
>> +++ b/include/linux/page-isolation.h
>> @@ -38,8 +38,6 @@ int move_freepages_block(struct zone *zone, struct page *page,
>>  
>>  /*
>>   * Changes migrate type in [start_pfn, end_pfn) to be MIGRATE_ISOLATE.
>> - * If specified range includes migrate types other than MOVABLE or CMA,
>> - * this will fail with -EBUSY.
>>   *
>>   * For isolating all pages in the range finally, the caller have to
>>   * free all pages in the range. test_page_isolated() can be used for
>> @@ -47,11 +45,11 @@ int move_freepages_block(struct zone *zone, struct page *page,
>>   */
>>  int
>>  start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>> -			 unsigned migratetype, bool skip_hwpoisoned_pages);
>> +			 unsigned migratetype, bool skip_hwpoisoned_pages,
>> +			 bool enforce_migratetype);
>>  
>>  /*
>> - * Changes MIGRATE_ISOLATE to MIGRATE_MOVABLE.
>> - * target range is [start_pfn, end_pfn)
>> + * Changes MIGRATE_ISOLATE to migratetype for range [start_pfn, end_pfn)
>>   */
>>  int
>>  undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index f74826cdceea..ebc1c8c330e2 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1601,7 +1601,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
>>  
>>  	/* set above range as isolated */
>>  	ret = start_isolate_page_range(start_pfn, end_pfn,
>> -				       MIGRATE_MOVABLE, true);
>> +				       MIGRATE_MOVABLE, true, false);
>>  	if (ret)
>>  		return ret;
>>  
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 0fd5e8e2456e..cb1a5e0be6ee 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -7787,9 +7787,10 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>>   * alloc_contig_range() -- tries to allocate given range of pages
>>   * @start:	start PFN to allocate
>>   * @end:	one-past-the-last PFN to allocate
>> - * @migratetype:	migratetype of the underlaying pageblocks (either
>> - *			#MIGRATE_MOVABLE or #MIGRATE_CMA).  All pageblocks
>> - *			in range must have the same migratetype and it must
>> + * @migratetype:	migratetype of the underlaying pageblocks.  All
>> + *			pageblocks in range must have the same migratetype.
>> + *			migratetype is typically MIGRATE_MOVABLE or
>> + *			MIGRATE_CMA, but this is not a requirement.
>>   *			be either of the two.
>>   * @gfp_mask:	GFP mask to use during compaction
>>   *
>> @@ -7840,15 +7841,15 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>>  	 * allocator removing them from the buddy system.  This way
>>  	 * page allocator will never consider using them.
>>  	 *
>> -	 * This lets us mark the pageblocks back as
>> -	 * MIGRATE_CMA/MIGRATE_MOVABLE so that free pages in the
>> -	 * aligned range but not in the unaligned, original range are
>> -	 * put back to page allocator so that buddy can use them.
>> +	 * This lets us mark the pageblocks back as their original
>> +	 * migrate type so that free pages in the  aligned range but
>> +	 * not in the unaligned, original range are put back to page
>> +	 * allocator so that buddy can use them.
>>  	 */
>>  
>>  	ret = start_isolate_page_range(pfn_max_align_down(start),
>>  				       pfn_max_align_up(end), migratetype,
>> -				       false);
>> +				       false, true);
>>  	if (ret)
>>  		return ret;
>>  
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index 43e085608846..472191cc1909 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -16,7 +16,8 @@
>>  #include <trace/events/page_isolation.h>
>>  
>>  static int set_migratetype_isolate(struct page *page, int migratetype,
>> -				bool skip_hwpoisoned_pages)
>> +				bool skip_hwpoisoned_pages,
>> +				bool enforce_migratetype)
>>  {
>>  	struct zone *zone;
>>  	unsigned long flags, pfn;
>> @@ -36,6 +37,17 @@ static int set_migratetype_isolate(struct page *page, int migratetype,
>>  	if (is_migrate_isolate_page(page))
>>  		goto out;
>>  
>> +	/*
>> +	 * If requested, check migration type of pageblock and make sure
>> +	 * it matches migratetype
>> +	 */
>> +	if (enforce_migratetype) {
>> +		if (get_pageblock_migratetype(page) != migratetype) {
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>> +	}
>> +
>>  	pfn = page_to_pfn(page);
>>  	arg.start_pfn = pfn;
>>  	arg.nr_pages = pageblock_nr_pages;
>> @@ -167,14 +179,16 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>>   * to be MIGRATE_ISOLATE.
>>   * @start_pfn: The lower PFN of the range to be isolated.
>>   * @end_pfn: The upper PFN of the range to be isolated.
>> - * @migratetype: migrate type to set in error recovery.
>> + * @migratetype: migrate type of all blocks in range.
>>   *
>>   * Making page-allocation-type to be MIGRATE_ISOLATE means free pages in
>>   * the range will never be allocated. Any free pages and pages freed in the
>>   * future will not be allocated again.
>>   *
>>   * start_pfn/end_pfn must be aligned to pageblock_order.
>> - * Return 0 on success and -EBUSY if any part of range cannot be isolated.
>> + * Return 0 on success or error returned by set_migratetype_isolate.  Typical
>> + * errors are -EBUSY if any part of range cannot be isolated or -EINVAL if
>> + * any page block is not of migratetype.
>>   *
>>   * There is no high level synchronization mechanism that prevents two threads
>>   * from trying to isolate overlapping ranges.  If this happens, one thread
>> @@ -185,11 +199,13 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>>   * prevents two threads from simultaneously working on overlapping ranges.
>>   */
>>  int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>> -			     unsigned migratetype, bool skip_hwpoisoned_pages)
>> +			     unsigned migratetype, bool skip_hwpoisoned_pages,
>> +			     bool enforce_migratetype)
>>  {
>>  	unsigned long pfn;
>>  	unsigned long undo_pfn;
>>  	struct page *page;
>> +	int ret = 0;
>>  
>>  	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
>>  	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
>> @@ -198,13 +214,17 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>>  	     pfn < end_pfn;
>>  	     pfn += pageblock_nr_pages) {
>>  		page = __first_valid_page(pfn, pageblock_nr_pages);
>> -		if (page &&
>> -		    set_migratetype_isolate(page, migratetype, skip_hwpoisoned_pages)) {
>> -			undo_pfn = pfn;
>> -			goto undo;
>> +		if (page) {
>> +			ret = set_migratetype_isolate(page, migratetype,
>> +							skip_hwpoisoned_pages,
>> +							enforce_migratetype);
>> +			if (ret) {
>> +				undo_pfn = pfn;
>> +				goto undo;
>> +			}
>>  		}
>>  	}
>> -	return 0;
>> +	return ret;
>>  undo:
>>  	for (pfn = start_pfn;
>>  	     pfn < undo_pfn;
>> @@ -215,7 +235,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>>  		unset_migratetype_isolate(page, migratetype);
>>  	}
>>  
>> -	return -EBUSY;
>> +	return ret;
>>  }
>>  
>>  /*
>>
> 


-- 
Mike Kravetz
