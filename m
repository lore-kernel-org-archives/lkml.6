Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2783972-1527007277-2-12194372020567267285
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527007276; b=EIfQKgqiT0hbe8EaGuJ76zCknWGrvwxkRX/Ta4QrP+ZDigPKbU
    zNasEMnJbllvcybE0tcESSISNPbEbZHNYiyRZlAExijeTod0eohI8Yyv++fKe0nF
    YJwYfPXJpIyPQxmF99K2Rf6A/C2LJ6JxHmcbd6Mf17UuTaZAQcClEZEA/ma5zpv8
    sUfOKpll15HrCOwfWF87s5ZIPoBiHpk0eegBGEdPYUCnEtQkKAt9k1PzmU6do1iO
    db34jDhgobOCknGZlg06R+0TiDWDpv1OVX/2xSbwrRQ1itNrfGon9cXAbM8pdik/
    B37UHjPlv6PI5AKbyROirXQjA/u8siWVfJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527007276;
    bh=7vVxtmZXeLzVO+K2xhW+jWREcpnkmGKFSw6WDds5d/8=; b=JuAHDXRuNsSz
    k3Moe4qRR5lGuLSuoxmSDEtNQwYzo3MiiyMfAk+lJ7DLzcdb/0wKOm463SpeTFbk
    Mxk3HeS6UFgNV36Ju/c+6EmlTs6hwbsia7IiMgloeP8Xpu3v++YA/TNohBSIo2zB
    8gHapyXzB4pDw4FPnaY9NvNZj1bJgJwN84Sm610xOOM82YEz9BEplS8sNpVuIv5b
    AvDsGzUgS2QYzXnWtz3bDk8urab4aGtgjjQr5AgBaYwgqi/Bv+HlPsYOJI69be8C
    ds2YpetnqweWZ5CPBoJ1j7G0wL5gYqvPlKDvbpChnGomjKfMh3oS1FE9h1aUkojS
    ABIdSm6Zyg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKN0rVPxyxNv7PjWspBoZTVey9qijy7gX+tA3J1sTz5+XFRefXKMSyHwiQMls8O/6RaLvCTfxoQVd4gJ9SW3gDCtKlNcwnoohvzOT/ekhTHbpZh49+6b
    svrpHHInX9cBcoZ7bfdvqZX0IwJ3p6zqC0V6FGYVtOnCjdCz5vYa3Da3HihQFHTgJbngWsQHzjDeq2XMnLne4MJhQMnjUxtX14LIfYuKeIqCKM/DvHEPqn32
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=MMzTYygAIVsXonW-H-MA:9 a=doSlooWZE3lqXCBg:21
    a=q6iS6txciq9TAJD-:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeEVQlO (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 12:41:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:37025 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751196AbeEVQlO (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 22 May 2018 12:41:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="43336583"
Subject: Re: [PATCH v2 3/4] mm: add find_alloc_contig_pages() interface
To: Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: Michal Hocko <mhocko@kernel.org>,
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
 <57dfd52c-22a5-5546-f8f3-848f21710cc1@oracle.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <c7972da1-a908-7550-7253-9de9a963174c@intel.com>
Date: Tue, 22 May 2018 09:41:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <57dfd52c-22a5-5546-f8f3-848f21710cc1@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/21/2018 4:48 PM, Mike Kravetz wrote:
> On 05/21/2018 01:54 AM, Vlastimil Babka wrote:
>> On 05/04/2018 01:29 AM, Mike Kravetz wrote:
>>> +/**
>>> + * find_alloc_contig_pages() -- attempt to find and allocate a contiguous
>>> + *				range of pages
>>> + * @nr_pages:	number of pages to find/allocate
>>> + * @gfp:	gfp mask used to limit search as well as during compaction
>>> + * @nid:	target node
>>> + * @nodemask:	mask of other possible nodes
>>> + *
>>> + * Pages can be freed with a call to free_contig_pages(), or by manually
>>> + * calling __free_page() for each page allocated.
>>> + *
>>> + * Return: pointer to 'order' pages on success, or NULL if not successful.
>>> + */
>>> +struct page *find_alloc_contig_pages(unsigned long nr_pages, gfp_t gfp,
>>> +					int nid, nodemask_t *nodemask)
>>> +{
>>> +	unsigned long i, alloc_order, order_pages;
>>> +	struct page *pages;
>>> +
>>> +	/*
>>> +	 * Underlying allocators perform page order sized allocations.
>>> +	 */
>>> +	alloc_order = get_count_order(nr_pages);
>>
>> So if takes arbitrary nr_pages but convert it to order anyway? I think
>> that's rather suboptimal and wasteful... e.g. a range could be skipped
>> because some of the pages added by rounding cannot be migrated away.
> 
> Yes.  My idea with this series was to use existing allocators which are
> all order based.  Let me think about how to do allocation for arbitrary
> number of allocations.
> - For less than MAX_ORDER size we rely on the buddy allocator, so we are
>   pretty much stuck with order sized allocation.  However, allocations of
>   this size are not really interesting as you can call existing routines
>   directly.
> - For sizes greater than MAX_ORDER, we know that the allocation size will
>   be at least pageblock sized.  So, the isolate/migrate scheme can still
>   be used for full pageblocks.  We can then use direct migration for the
>   remaining pages.  This does complicate things a bit.
> 
> I'm guessing that most (?all?) allocations will be order based.  The use
> cases I am aware of (hugetlbfs, Intel Cache Pseudo-Locking, RDMA) are all
> order based.  However, as commented in previous version taking arbitrary
> nr_pages makes interface more future proof.
> 

I noticed this Cache Pseudo-Locking statement and would like to clarify.
I have not been following this thread in detail so I would like to
apologize first if my comments are out of context.

Currently the Cache Pseudo-Locking allocations are order based because I
assumed it was required by the allocator. The contiguous regions needed
by Cache Pseudo-Locking will not always be order based - instead it is
based on the granularity of the cache allocation. One example is a
platform with 55MB L3 cache that can be divided into 20 equal portions.
To support Cache Pseudo-Locking on this platform we need to be able to
allocate contiguous regions at increments of 2816KB (the size of each
portion). In support of this example platform regions needed would thus
be 2816KB, 5632KB, 8448KB, etc.

Regards,

Reinette

