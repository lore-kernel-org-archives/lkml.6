Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3081717-1527021401-2-16256138594054442364
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
    1527021400; b=g/3Y4P2yrCrz8A8C2ApshPeoPgDBOxrYDyO+cJmrt7P9UO5bQe
    2Nft7fXASKBBUCB4Q6olEyiepnvrNigjCeG2JGuPUvFQSlmpG+Kdj9EuxlQw4K9J
    LOTsyfa3Vgc6U0rwAge4EDgJS0CTC1wP9L6cVXR2wyvIMUIcnSfSLZA4rvk6CSsA
    NDUGkp8i6gQlu9uXpcMjrzrl4BAuYqA/ay+qTU1c2tdKiYsxhQekdLitHSV9ZV6z
    bq1apoSfuSN/WI32CWffHnYP1paRhiOyuxlF5CVP0QVdA/RETngLO2bOMPkrFxvn
    jaBboEWHQzsWDsVEQHJD94I2ynWjai/ccccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527021400;
    bh=3a82xlH/5AL5T/bma6viqdtuR6ENBb7EkymOkoeugnM=; b=Qoq8Pkr800rt
    peUxZVJ7mcON3SLWxDRe5+6JiHKH69u2xQdBtkhErRMrf5e9Y6IFIfA/EuJRTo78
    7/n3UJ9XQhP/K81Nnw26tkeZ7RSmpUhZpIBWy/bs1QPfjvT5P81tjWTOYE204U+b
    iGWl0TSmYNYsq2p7StpxlijJSMqzDmaB8wRYvtIvlYOmLsKk6/mYECKUcEwZbMiM
    gK9ftnCGnhBXCAbhna7MwT6h47KvdV8/boZtjFzbhUiJq9/b3gVe8+P8J5UM3Lxf
    JmGVQXNrDOj4fnACIXNUby02jQ8qZFX3kyM7iQG+HOQLT3H0cF1uXPineq2/lwtn
    8zGGD31N6g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=VZIKFG0s x-bits=2048
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=VZIKFG0s x-bits=2048
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
X-CM-Envelope: MS4wfGwxKLWjuDQh+C8U91Lyk2VtJ6YGfQ8f16U6qVY1xTFFnT46oIb8mFDR2my453IE0yRlzsssDkU0pOE3y1teq8GrMybITCfIIBwmYqxGyZJwIcPiHFA1
    m2h9/ydSxJrCwNlfIl9tkHdXsYvSigq3Xebupf67UWGzJ3rgovui/M3SaVTxVNB4a+hxZDnNg+D3FBC/RaaX62968bqAdpZK6I53mzXuy7pITt81rz2JaZuf
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=0p__B1ZDiwlFXYf_60AA:9 a=5jNi-goleJEaNsVV:21
    a=qwzkVgp1V22_afJP:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752663AbeEVUgj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 16:36:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43792 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeEVUgi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 16:36:38 -0400
Subject: Re: [PATCH v2 3/4] mm: add find_alloc_contig_pages() interface
To: Reinette Chatre <reinette.chatre@intel.com>,
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
 <c7972da1-a908-7550-7253-9de9a963174c@intel.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <652bb498-8393-4738-a987-9bed31786261@oracle.com>
Date: Tue, 22 May 2018 13:35:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <c7972da1-a908-7550-7253-9de9a963174c@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8901 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805220212
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/22/2018 09:41 AM, Reinette Chatre wrote:
> On 5/21/2018 4:48 PM, Mike Kravetz wrote:
>> On 05/21/2018 01:54 AM, Vlastimil Babka wrote:
>>> On 05/04/2018 01:29 AM, Mike Kravetz wrote:
>>>> +/**
>>>> + * find_alloc_contig_pages() -- attempt to find and allocate a contiguous
>>>> + *				range of pages
>>>> + * @nr_pages:	number of pages to find/allocate
>>>> + * @gfp:	gfp mask used to limit search as well as during compaction
>>>> + * @nid:	target node
>>>> + * @nodemask:	mask of other possible nodes
>>>> + *
>>>> + * Pages can be freed with a call to free_contig_pages(), or by manually
>>>> + * calling __free_page() for each page allocated.
>>>> + *
>>>> + * Return: pointer to 'order' pages on success, or NULL if not successful.
>>>> + */
>>>> +struct page *find_alloc_contig_pages(unsigned long nr_pages, gfp_t gfp,
>>>> +					int nid, nodemask_t *nodemask)
>>>> +{
>>>> +	unsigned long i, alloc_order, order_pages;
>>>> +	struct page *pages;
>>>> +
>>>> +	/*
>>>> +	 * Underlying allocators perform page order sized allocations.
>>>> +	 */
>>>> +	alloc_order = get_count_order(nr_pages);
>>>
>>> So if takes arbitrary nr_pages but convert it to order anyway? I think
>>> that's rather suboptimal and wasteful... e.g. a range could be skipped
>>> because some of the pages added by rounding cannot be migrated away.
>>
>> Yes.  My idea with this series was to use existing allocators which are
>> all order based.  Let me think about how to do allocation for arbitrary
>> number of allocations.
>> - For less than MAX_ORDER size we rely on the buddy allocator, so we are
>>   pretty much stuck with order sized allocation.  However, allocations of
>>   this size are not really interesting as you can call existing routines
>>   directly.
>> - For sizes greater than MAX_ORDER, we know that the allocation size will
>>   be at least pageblock sized.  So, the isolate/migrate scheme can still
>>   be used for full pageblocks.  We can then use direct migration for the
>>   remaining pages.  This does complicate things a bit.
>>
>> I'm guessing that most (?all?) allocations will be order based.  The use
>> cases I am aware of (hugetlbfs, Intel Cache Pseudo-Locking, RDMA) are all
>> order based.  However, as commented in previous version taking arbitrary
>> nr_pages makes interface more future proof.
>>
> 
> I noticed this Cache Pseudo-Locking statement and would like to clarify.
> I have not been following this thread in detail so I would like to
> apologize first if my comments are out of context.
> 
> Currently the Cache Pseudo-Locking allocations are order based because I
> assumed it was required by the allocator. The contiguous regions needed
> by Cache Pseudo-Locking will not always be order based - instead it is
> based on the granularity of the cache allocation. One example is a
> platform with 55MB L3 cache that can be divided into 20 equal portions.
> To support Cache Pseudo-Locking on this platform we need to be able to
> allocate contiguous regions at increments of 2816KB (the size of each
> portion). In support of this example platform regions needed would thus
> be 2816KB, 5632KB, 8448KB, etc.

Thank you Reinette.  I was not aware of these details.  Yours is the most
concrete new use case.

This certainly makes more of a case for arbitrary sized allocations.

-- 
Mike Kravetz
