Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1965625-1527166755-2-4382986783461762971
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527166754; b=ToLh2JUBmuIHsG13CuPANCs5UBhp1aqqu1kVLKQtXtK81O5xUE
    b9EBcyxYm+iveyjLMGM2VTTRo/1qjaPjhhnE9vYlXoZtq958GoK/URB2fprAJ3ry
    AquOsFvR4jq1KbthLaOo2w/hGFnToY8bGcY44XxS9fcXsxMmJUAKgmEpKErJaipR
    oMwLgZX66zyzsnq/SprcDNUZjAxdu62RmFYlLCEG+7mPX5gIVy1Al3ArR+gGklVu
    h2+Tu4cXSH0F+h8WnjVeQw/xv28xYlf5wsWIbTFtq0CVneUImvgK1rOLUR0zwpkF
    qu2TSRsA6bcJPPMxFPjMDlWMLUn7jDCfbkwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527166754;
    bh=4g/rz4kCutrLTuHjhr3oepzVww284571fmf2IcADQd8=; b=VFpfj2fQlkyA
    reNDI92MNAsJoTNPErL3bdYdmdhiF0u0qi1BI02Gqh2v1vrrXK5p7PQcKiDLBUbX
    KMqR+uF3zDtH4C//dTogjbS0glMRNdKPyuRMLfFsG9HTzkhPXi9NO0LpN2GuuHYa
    suxkFKoMsYTdSojsT1rGEkt6R9ji/q7BEhRMlaOTer5uzJOygKDoyVl8GFQHftU5
    HksCsM6pDsHlwNfsgJ4aVPAkEZ298p35rwSdKfSiwEbx5eaPAlb5VMwfIVU3pat0
    3sW55StMwqpWoQFOmP/d+/Lf9OW47We4ZsOvu/UF0SLX1SL0fHUTn6poLYQKIpF/
    luCuNB2d+A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ascade.co.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ascade.co.jp header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ascade.co.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ascade.co.jp header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJiNMBACxGzx3efWsES/XvtyEHIlkZzCazMMl+FGhqkETgBDJpJm68q7yaPCgJ6m4+Lf/lJyXfuDRb7697RBU38SjFsy8a14i3HL/BUAw5DrGETS2I/o
    mkBwDO8l8Da013nb/u1OJTHtV/7UXZ2/wz83ZFzIpNZE2NIB8/zFTuSp4JqdXCfJvYjxmW9z8a1mwQaPMOtfBWaa8NSR+anUaXDCKmHECr8/xoOy3porJWvw
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=3YSco1D3qQSef1lE_40A:9 a=AlXV-We4tjNcMto4:21
    a=6UNi7Ykcv7EBDJBM:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967814AbeEXM7M (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 08:59:12 -0400
Received: from ext-host0001.ascade.co.jp ([218.224.228.194]:63384 "EHLO
        ns.ascade.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964789AbeEXM7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 May 2018 08:59:10 -0400
Subject: Re: [PATCH v2 0/7] mm: pages for hugetlb's overcommit may be able to
 charge to memcg
To: Michal Hocko <mhocko@kernel.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Marc-Andre Lureau <marcandre.lureau@redhat.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
References: <e863529b-7ce5-4fbe-8cff-581b5789a5f9@ascade.co.jp>
 <240f1b14-ed7d-4983-6c52-be4899d4caa5@oracle.com>
 <8711fed5-fc35-a11a-3a17-740a9dca1f2a@ascade.co.jp>
 <20180522185407.GC20441@dhcp22.suse.cz>
 <455b1a07-d7e3-102b-65e7-3892947b7675@ascade.co.jp>
 <20180524082044.GW20441@dhcp22.suse.cz>
From: TSUKADA Koutaro <tsukada@ascade.co.jp>
Message-ID: <b2afbff6-b59f-7105-3808-64d41bd4a3a8@ascade.co.jp>
Date: Thu, 24 May 2018 21:58:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180524082044.GW20441@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018/05/24 17:20, Michal Hocko wrote:
> On Thu 24-05-18 13:39:59, TSUKADA Koutaro wrote:
>> On 2018/05/23 3:54, Michal Hocko wrote:
> [...]
>>> I am also quite confused why you keep distinguishing surplus hugetlb
>>> pages from regular preallocated ones. Being a surplus page is an
>>> implementation detail that we use for an internal accounting rather than
>>> something to exhibit to the userspace even more than we do currently.
>>
>> I apologize for having confused.
>>
>> The hugetlb pages obtained from the pool do not waste the buddy pool.
> 
> Because they have already allocated from the buddy allocator so the end
> result is very same.
> 
>> On
>> the other hand, surplus hugetlb pages waste the buddy pool. Due to this
>> difference in property, I thought it could be distinguished.
> 
> But this is simply not correct. Surplus pages are fluid. If you increase
> the hugetlb size they will become regular persistent hugetlb pages.

I really can not understand what's wrong with this. That page is obviously
released before being added to the persistent pool, and at that time it is
uncharged from memcg to which the task belongs(This assumes my patch-set).
After that, the same page obtained from the pool is not surplus hugepage
so it will not be charged to memcg again.

>> Although my memcg knowledge is extremely limited, memcg is accounting for
>> various kinds of pages obtained from the buddy pool by the task belonging
>> to it. I would like to argue that surplus hugepage has specificity in
>> terms of obtaining from the buddy pool, and that it is specially permitted
>> charge requirements for memcg.
> 
> Not really. Memcg accounts primarily for reclaimable memory. We do
> account for some non-reclaimable slabs but the life time should be at
> least bound to a process life time. Otherwise the memcg oom killer
> behavior is not guaranteed to unclutter the situation. Hugetlb pages are
> simply persistent. Well, to be completely honest tmpfs pages have a
> similar problem but lacking the swap space for them is kinda
> configuration bug.

Absolutely you are saying the right thing, but, for example, can mlock(2)ed
pages be swapped out by reclaim?(What is the difference between mlock(2)ed
pages and hugetlb page?)

>> It seems very strange that charge hugetlb page to memcg, but essentially
>> it only charges the usage of the compound page obtained from the buddy pool,
>> and even if that page is used as hugetlb page after that, memcg is not
>> interested in that.
> 
> Ohh, it is very much interested. The primary goal of memcg is to enforce
> the limit. How are you going to do that in an absence of the reclaimable
> memory? And quite a lot of it because hugetlb pages usually consume a
> lot of memory.

Simply kill any of the tasks belonging to that memcg. Maybe, no one wants
reclaim at the time of account of with surplus hugepages.

[...]
>> I could not understand the intention of this question, sorry. When resize
>> the pool, I think that the number of surplus hugepages in use does not
>> change. Could you explain what you were concerned about?
> 
> It does change when you change the hugetlb pool size, migrate pages
> between per-numa pools (have a look at adjust_pool_surplus).

As I looked at, what kind of fatal problem is caused by charging surplus
hugepages to memcg by just manipulating counter of statistical information?

-- 
Thanks,
Tsukada
