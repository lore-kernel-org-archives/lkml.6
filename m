Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-522845-1527098883-2-7296231694712519393
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
    1527098883; b=fHHaIDq/1wPUmekDqFUHmioDkqIkOogDe9Pq/agSppec6J2RUs
    rfQ1qLvHJLP2unY1JpTRkT3MdKDSAKIy0zxGhz+IKbWpIqte5lVkm1KUxYSsFDiH
    ZkD67sZFcsy86Cs6D8tYNzI9qd0/uQWpDULATWeA4aQdB8jGuv39yEjBOGl6JLBv
    HqoFV8joUXpFsr1ti2GHTZ9pLvXNxdNiJcMPitd2k1Fz1TsaM+yK0BV7MP1Eu1MH
    ZT/RagYZyTUHuVZfVeAHtalMkjYfRN209yLjM5dRQH9ImZyEnNDVxiiS8EoZQoXn
    1HqVWUrzPbzu6cWDkRx/hfgacRV1gNbIUa5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527098883;
    bh=gd7QLodxc6GgBrN7fB+GabYzghW/3izmb6wuEMNQq8A=; b=dDblk3bXp5Pu
    gEQSHMeX9Azb/ZZLIvx2+jgs83tEOCLJwY3LK0uqdiDbEz3ZBOu7q+k5lq1c6iD8
    rbQbsP97HqmxyGGK8WCaxHFyGQEnmTivLdh0IoLRicSJdN6ZTo8FUJhl0DBFnb97
    8jS85xUix36fVtpoFNqsZ/hMhgteFdyRjrBVfIcOcbXfNnUhHPhJdRYcxlz4a9FZ
    dyNfbIz8TYTdNNjVXq8EztXy1uPHWAY5NRCd598UowhzK6Pg3bwOE1HzcPWBtiGE
    IRw1gt5H/WFGcBba/DqSCkkLC7ZdtMsx+huEwC8BedRk/lQ9AmVuoHDdCVaLGZLp
    HJImVYAXgg==
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
X-CM-Envelope: MS4wfAksgledoeGDj7nt74NYARiBvHgbAkYjD+X5O1Yym2JBs2D/GLm+72gXq9s0VzpBnFDso0IDQUzowwkscY6K0CuPse8e/DpVc2ohavo4yvivj033BWhN
    kOz7Ow9t3g2k7B2e5XM6Ey+CukvpQyDdkp9CRMhiSw/EP7chUI+0ZckYEC1+RifqIOhQfU/pAoKyOv19HO/5GHKLrimEhJ5S6DOY8+peqGWtcazyVeiDj5NO
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=5KZAJ698FjEBQ8-kRuUA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754681AbeEWSIB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 14:08:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:21631 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750866AbeEWSIB (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 23 May 2018 14:08:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,433,1520924400";
   d="scan'208";a="44195171"
Subject: Re: [PATCH v2 3/4] mm: add find_alloc_contig_pages() interface
To: Vlastimil Babka <vbabka@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
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
 <01793788-1870-858e-2061-a0e6ef3a3171@suse.cz>
From: Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <0db4cd65-8b03-fea5-0a30-512f10241d54@intel.com>
Date: Wed, 23 May 2018 11:07:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <01793788-1870-858e-2061-a0e6ef3a3171@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Vlastimil,

On 5/23/2018 4:18 AM, Vlastimil Babka wrote:
> On 05/22/2018 06:41 PM, Reinette Chatre wrote:
>> On 5/21/2018 4:48 PM, Mike Kravetz wrote:
>>> I'm guessing that most (?all?) allocations will be order based.  The use
>>> cases I am aware of (hugetlbfs, Intel Cache Pseudo-Locking, RDMA) are all
>>> order based.  However, as commented in previous version taking arbitrary
>>> nr_pages makes interface more future proof.
>>>
>>
>> I noticed this Cache Pseudo-Locking statement and would like to clarify.
>> I have not been following this thread in detail so I would like to
>> apologize first if my comments are out of context.
>>
>> Currently the Cache Pseudo-Locking allocations are order based because I
>> assumed it was required by the allocator. The contiguous regions needed
>> by Cache Pseudo-Locking will not always be order based - instead it is
>> based on the granularity of the cache allocation. One example is a
>> platform with 55MB L3 cache that can be divided into 20 equal portions.
>> To support Cache Pseudo-Locking on this platform we need to be able to
>> allocate contiguous regions at increments of 2816KB (the size of each
>> portion). In support of this example platform regions needed would thus
>> be 2816KB, 5632KB, 8448KB, etc.
> 
> Will there be any alignment requirements for these allocations e.g. for
> minimizing conflict misses?

Two views on the usage of the allocated memory are: On the user space
side, the kernel memory is mapped to userspace (using remap_pfn_range())
and thus need to be page aligned. On the kernel side the memory is
loaded into the cache and it is here where the requirement originates
for it to be contiguous. The memory being contiguous reduces the
likelihood of physical addresses from the allocated memory mapping to
the same cache line and thus cause cache evictions of memory we are
trying to load into the cache.

I hope I answered your question, if not, please let me know which parts
I missed and I will try again.

Reinette

