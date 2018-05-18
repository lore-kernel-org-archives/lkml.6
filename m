Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-405191-1526680941-2-10386917943995951352
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
    1526680939; b=B8M5JO4WqzCvXSJuOMbRprobiCigJNwOrOo/P2T7eNO0/7h4Am
    HaGD/CnR7BdHRPI/StoJ+nhTBcA5r5jhqsj2PK1tqjlEVuFFclMC+po8tMqAk3mH
    SJuvywiGKuRKJi4lPkNskVwHqW6+j8A8aw6y55qg3o8vhQ6Xw2GyvswBdAjWXAfn
    5LODgn9m9EQo6VZuJaUowHymxak07RRjvSqM7qezkEOcWva/GtUVLK/YExXPX18Q
    oUop9IJ8zrMGsICX2P7UWM3bS9+8Mb/8gZUvxlFf4RUFoNJalMzBDbviotY+YIwc
    SPIGG5SCi8glX7PtunnOyFvOTjY8hhmdkOow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526680939;
    bh=lSCxTCSYmkRJCBx/ccX5RyU3XPtJnOzkCcZCSDiUQBk=; b=c+fXNUIuO6rv
    zk3zfRR03Y7/hV/6/nBcfDsIDJsD+x3+5i4F06Uy57YH6RV8bTOq2SYroJwlzmM8
    qqhRXpzwHA8jJ5HlJsVpO9vUDVJBxNxvKRTq6ctMTYOzCqYE/+XuaybhUCRrLUKa
    1VkWT8fLKlT3wVa/rTRGlBtdC6pTWAEVL+uk4brxMrIscsYzm4O3zQv83TozVzUn
    yvSGnov46ZXO9NLKEvJWvmyGJT0rKcumdWerFSLejB9iqbGLUXs8diwkEqWFZO6h
    F6+Fmaw1oO/1T/CRafAmEmxOKNV28d9rPQj8Cx2KMgTVrdPMQDbB7hdCl329D/+P
    i3MpF4iWbQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=hIb3Ys5b x-bits=2048
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
      header.d=oracle.com header.i=@oracle.com header.b=hIb3Ys5b x-bits=2048
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
X-CM-Envelope: MS4wfF89btQyaYE0wDG64Jg7lMUTAqFsNNXHXsm8jQnYk4u1ll3VvwKqI9q/liXE1qyZKR/3IIuQE7RAaWTP3BZHfQnsCwQaJnqb4IGxg6NBYE9Qf/OmkGW+
    z9OKhzRCPF1O5UcLfYe5yELUZCVCCa77C7z9zrFiK0ew2+WatW0VqXvK/vvwCf8/ZcpFNR+pGyhf6+TpEgRjunGt1Q4ksYPXvgH8V3v0Ot+jsucDrulWSOi3
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=LaumIZOzMYq83LVRXwoA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeERWCS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 18:02:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36788 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbeERWCR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 18 May 2018 18:02:17 -0400
Subject: Re: [PATCH v2 1/4] mm: change type of free_contig_range(nr_pages) to
 unsigned long
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20180503232935.22539-1-mike.kravetz@oracle.com>
 <20180503232935.22539-2-mike.kravetz@oracle.com>
 <87d74ce0-b135-064d-a589-64235e44c388@suse.cz>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <87943a21-4465-31bd-ed37-69253879ec47@oracle.com>
Date: Fri, 18 May 2018 15:01:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87d74ce0-b135-064d-a589-64235e44c388@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8897 signatures=668699
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805180232
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/18/2018 02:12 AM, Vlastimil Babka wrote:
> On 05/04/2018 01:29 AM, Mike Kravetz wrote:
>> free_contig_range() is currently defined as:
>> void free_contig_range(unsigned long pfn, unsigned nr_pages);
>> change to,
>> void free_contig_range(unsigned long pfn, unsigned long nr_pages);
>>
>> Some callers are passing a truncated unsigned long today.  It is
>> highly unlikely that these values will overflow an unsigned int.
>> However, this should be changed to an unsigned long to be consistent
>> with other page counts.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  include/linux/gfp.h | 2 +-
>>  mm/cma.c            | 2 +-
>>  mm/hugetlb.c        | 2 +-
>>  mm/page_alloc.c     | 6 +++---
>>  4 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index 1a4582b44d32..86a0d06463ab 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -572,7 +572,7 @@ static inline bool pm_suspended_storage(void)
>>  /* The below functions must be run on a range from a single zone. */
>>  extern int alloc_contig_range(unsigned long start, unsigned long end,
>>  			      unsigned migratetype, gfp_t gfp_mask);
>> -extern void free_contig_range(unsigned long pfn, unsigned nr_pages);
>> +extern void free_contig_range(unsigned long pfn, unsigned long nr_pages);
>>  #endif
>>  
>>  #ifdef CONFIG_CMA
>> diff --git a/mm/cma.c b/mm/cma.c
>> index aa40e6c7b042..f473fc2b7cbd 100644
>> --- a/mm/cma.c
>> +++ b/mm/cma.c
>> @@ -563,7 +563,7 @@ bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
>>  
>>  	VM_BUG_ON(pfn + count > cma->base_pfn + cma->count);
>>  
>> -	free_contig_range(pfn, count);
>> +	free_contig_range(pfn, (unsigned long)count);
> 
> I guess this cast from uint to ulong doesn't need to be explicit? But
> instead, cma_release() signature could be also changed to ulong, because
> some of its callers do pass those?

Correct, that cast is not needed.

I like the idea of changing cma_release() to take ulong.  Until you mentioned
this, I did not realize that some callers were passing in a truncated ulong.
As noted in my commit message, this truncation is unlikely to be an issue.
But, I think we should 'fix' them if we can.

I'll spin another version with this change.

> 
>>  	cma_clear_bitmap(cma, pfn, count);
>>  	trace_cma_release(pfn, pages, count);
>>  
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 218679138255..c81072ce7510 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1055,7 +1055,7 @@ static void destroy_compound_gigantic_page(struct page *page,
>>  
>>  static void free_gigantic_page(struct page *page, unsigned int order)
>>  {
>> -	free_contig_range(page_to_pfn(page), 1 << order);
>> +	free_contig_range(page_to_pfn(page), 1UL << order);
>>  }
>>  
>>  static int __alloc_gigantic_page(unsigned long start_pfn,
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 905db9d7962f..0fd5e8e2456e 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -7937,9 +7937,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>>  	return ret;
>>  }
>>  
>> -void free_contig_range(unsigned long pfn, unsigned nr_pages)
>> +void free_contig_range(unsigned long pfn, unsigned long nr_pages)
>>  {
>> -	unsigned int count = 0;
>> +	unsigned long count = 0;
>>  
>>  	for (; nr_pages--; pfn++) {
>>  		struct page *page = pfn_to_page(pfn);
>> @@ -7947,7 +7947,7 @@ void free_contig_range(unsigned long pfn, unsigned nr_pages)
>>  		count += page_count(page) != 1;
>>  		__free_page(page);
>>  	}
>> -	WARN(count != 0, "%d pages are still in use!\n", count);
>> +	WARN(count != 0, "%ld pages are still in use!\n", count);
> 
> Maybe change to %lu while at it?

Yes

> BTW, this warning can theoretically produce false positives, because
> page users have to deal with page_count() being incremented by e.g.
> parallel pfn scanners using get_page_unless_zero(). We also don't detect
> refcount leaks in general. Should we remove it or change it to VM_WARN
> if it's still useful for debugging?

Added Marek on Cc: as he is the one who originally added this message (although
it has been a long time).  I do not know what specific issue he was concerned
with.  A search found a few bug reports related to this warning.  In these
cases, it clearly was not a false positive but some other issue.  It 'appears'
the message helped in those cases.

However, I would hate for a support organization to spend a bunch of time
doing investigation for a false positive.  At the very least, I think we
should add a message/comment about the possibility of false positives in the
code.  I would be inclined to change it to VM_WARN, but it would be good
to get input from others who might find it useful as it.

-- 
Mike Kravetz

> 
>>  }
>>  #endif
>>  
>>
> 
