Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459670-1526948155-2-1082325434802546976
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
    1526948154; b=ARcnOf9Q00g4x4YWVort6ongYbebKJuL1QpyeK/YL/BYsVcEOJ
    4oeHUqtbtGcLNni5ZX64MvFobgK3tMzuTB2Im04GdhgYWGR4+z2+lyADVWYN8ewc
    qTKw3vyfbN0bYEInNLQKFw0dHQNng0okPa4ZHu5YP1061XR+5jxUsyL+NElAD5wX
    rEHTawZc0vHTy3sfy2Z81uwa4uAj3Lo169fL+UGgYaypmWcG7uvj2aUivMg+YOTK
    SWEan6YpnOsRu5ejhMDcaaxyruMtyZ0xuDHEAXZIIdHM7tnhJGON32biSfxNQ7le
    5SbCIKt6qy2qd/YvJC2lSZoLxaY+qWQpTXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526948154;
    bh=19ixmVSOBHB88Opzu+x4T6DkRysDHJvr3igLof3ki1c=; b=dSwm55a/O21R
    oCSKd/Mo5S8UqJZoYK8gpcZVRN10QD7A8qDS8mikPhQap3VqZuDBJQLK66nqIBeg
    1Pe+vHTZkN+p6RRLZ/UjChxPzI9wn98Bh6KeqOEqimbewKzyFFAzPYWKK9I52w+N
    E1n/poIWtxH/8u5Oj4S5ofbyG+KHCobwiayHrAyhbWsiwC8JowS4+V9d9RBTlnmg
    una48OxrixZejV6sB6u3J7o1ynYJQ+2qJzpSuPFRl6lTbOK7yv6DNdVLjjgbJa+4
    SxQJMzAIVvzv0t05bo7m+RIteKh3eb54K5mCXwPd1NC9dIRbWeAewpl5r0X55qL1
    GMweOgzJ7g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=TWvui5I7 x-bits=2048
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=TWvui5I7 x-bits=2048
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
X-CM-Envelope: MS4wfJjP1yxai6urkzRUELYmdQJUmY8nWhNDqH9MskxAm1iHkTMtVf2GytGTWCYOZcZSgNQiUlKTtHi3pynL9NcK+Gsr3B4dAHhJQE4k+0h6S16XQWy7dtvq
    zn2rphpkazfEFgpQ2c8EUoRem8mYRS60BGfGv6b21IMTOwG5jQ0Wv4nfUpfE47Y7n2bYvPFoXqi6pjXyGCOYpD5i2s/PAJ3W8ClsDTD16CIt1i4OL4w20Thh
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=xNA6NYUtrUiL2TEVKJ0A:9 a=JTMAbWzWT-9sqT_7:21
    a=1y-nQHQBEfrliUb6:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbeEVAPx (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 20:15:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52704 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbeEVAPw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 21 May 2018 20:15:52 -0400
Subject: Re: [PATCH v2 0/4] Interface for higher order contiguous allocations
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
 <8ce9884c-36b0-68ea-45a4-06177c41af4a@suse.cz>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8c3906cf-ffd3-00fe-b690-2902fc5b4e5a@oracle.com>
Date: Mon, 21 May 2018 17:15:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <8ce9884c-36b0-68ea-45a4-06177c41af4a@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8900 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=951
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805220000
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/21/2018 05:00 AM, Vlastimil Babka wrote:
> On 05/04/2018 01:29 AM, Mike Kravetz wrote:
>> Vlastimil and Michal brought up the issue of allocation alignment.  The
>> routine will currently align to 'nr_pages' (which is the requested size
>> argument).  It does this by examining and trying to allocate the first
>> nr_pages aligned/nr_pages sized range.  If this fails, it moves on to the
>> next nr_pages aligned/nr_pages sized range until success or all potential
>> ranges are exhausted.
> 
> As I've noted in my patch 3/4 review, in fact nr_pages is first rounded
> up to an order, which makes this simpler, but suboptimal. I think we
> could perhaps assume that nr_pages that's a power of two should be
> aligned as such, and other values of nr_pages need no alignment? This
> should fit existing users, and can be extended to explicit alignment
> when such user appears?

I'm good with that.  I do believe that minimum alignment will be
pageblock size alignment (for > MAX_ORDER allocations).

>> If we allow an alignment to be specified, we will
>> need to potentially check all alignment aligned/nr_pages sized ranges.
>> In the worst case where alignment = PAGE_SIZE, this could result in huge
>> increase in the number of ranges to check.
>> To help cut down on the number of ranges to check, we could identify the
>> first page that causes a range allocation failure and start the next
>> range at the next aligned boundary.  I tried this, and we still end up
>> with a huge number of ranges and wasted CPU cycles.
> 
> I think the wasted cycle issues is due to the current code structure,
> which is based on the CMA use-case, which assumes that the allocations
> will succeed, because the areas are reserved and may contain only
> movable allocations
> 
> find_alloc_contig_pages()
>   __alloc_contig_pages_nodemask()
>     contig_pfn_range_valid()
>       - performs only very basic pfn validity and belongs-to-zone checks
>     alloc_contig_range()
>       start_isolate_page_range()
>        for (pfn per pageblock) - the main cycle
>          set_migratetype_isolate()
>            has_unmovable_pages() - cancel if yes
>            move_freepages_block() - expensive!
>       __alloc_contig_migrate_range()
> etc (not important)
> 
> So I think the problem is that in the main cycle we might do a number of
> expensive move_freepages_block() operations, then hit a block where
> has_unmovable_pages() is true, cancel and do more expensive
> undo_isolate_page_range() operations.
> 
> If we instead first scanned the range with has_unmovable_pages() and
> only start doing the expensive work when we find a large enough (aligned
> or not depending on caller) range, it should be much faster and there
> should be no algorithmic difference between aligned and non-aligned case.

Ok, I will give that a try.

Thanks again for looking at these.
-- 
Mike Kravetz
