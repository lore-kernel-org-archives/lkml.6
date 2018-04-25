Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4146373-1524628185-2-339245213351503093
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524628185; b=alk5mrC3SPGycjzaGMAMoozjt4o0Smns1u5yIZLAaXXhv4X1mk
    eoI8aywJV4irCO5davReQ/XltpLvnHojrhQ036+rQ3vveN8ORIYUdOMGn9iGE5Gf
    +gj6L9XXlN5vYyXLn67hENbFSqQw5q3YAuj5QEGfRBjuL4FKz/zhqW4xmBKuDDkB
    S1FEJpjWzLAas2exqeFtB2yrT7oP6XzvTZcNYPxOG/v8M0s0MTSmfseDLc0PDFJd
    tf3dF2f665DpfXSpp7bRdXZtukprvwjHnj4NN812F3ix5f8oA5zrFD6sbuPW8YX3
    uzOI6WvzudTS/ovhBX614GHBZioBu4ofOhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524628185;
    bh=NXKKoGFQozihwn4QqR6KSerGaS70ivuDMidu86qcmgQ=; b=IQ41x5AoD4m4
    OTSoUJOSmvm6Z/NHdwqo3wWg+FDd1GI8BzuaCqtfnElVKyqrKNwhciqP4kLchj2C
    IdFdxSKHbtI3doPUqZAWBrEN2tCvzuYbR5b9dEGaUqYwXZpNSl5qVQsNED/YADQf
    xTG0RIYRokLuWNR9sB3A09iwlJ+q3i1Gk6KsZ98dwIItPPRjeyLF61GUPxVHxtQf
    ygcV7sWAMZ8uWhh5Ix5ms+K0odTEH4BuXwnrgMx3VcPkmUR9HZ40enYPyjUIrkt+
    Cp4BbtjhIn3gRaUcONlnRcloPAcoAogQ/DkKJhtGKUUkZpupJwDAvTPUzJOpZB3M
    i4xwJAjPhQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=Cb9WcFbn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=kJIE/m5K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=Cb9WcFbn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=kJIE/m5K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFstWzMvDfFeNotWyDB8Iaz3ABp4xf6D30vHY8PNwIlu6uAvUJQfBJ15dw4JaXFfl45FuUeQ0uvipG6A1AMpwOLfEWRO9hQh66qdIKXynoxQ6RNzCt0V
    c4BVprKpj68BSx3BKUBMOGpjwXiSxIOWQNtirFxN2I1QnvBYoHEDbBzL1nssci9niXEa8rEIrrT59DOXO4nWEOECaAueKH9GU09l+g/OWSpO+BZ6/QoAA2b+
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=FOH2dFAWAAAA:8 a=Z4Rwk6OoAAAA:8 a=drOt6m5kAAAA:8 a=iox4zFpeAAAA:8
    a=ufHFDILaAAAA:8 a=VwQbUJbxAAAA:8 a=37rDS-QxAAAA:8 a=D19gQVrFAAAA:8
    a=psY-vJiXYU_3K4oBOBYA:9 a=uOtYhMFlS0syABsU:21 a=PyX8E-rdhMDmcsOR:21
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=i3VuKzQdj-NEYjvDI-p3:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=RMMjzBEyIzXRtoq5n5K6:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=ZmIg1sZ3JBWsdXgziEIF:22 a=AjGcO6oz07-iQ99wixmX:22 a=k1Nq6YrhK2t884LQW06G:22
    a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751201AbeDYDtl (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 23:49:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44208 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeDYDtj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Apr 2018 23:49:39 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0E88601CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH 1/3] mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES
To: vinayak menon <vinayakm.list@gmail.com>,
        Roman Gushchin <guro@fb.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Linux API <linux-api@vger.kernel.org>
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-2-guro@fb.com>
 <08524819-14ef-81d0-fa90-d7af13c6b9d5@suse.cz>
 <20180411135624.GA24260@castle.DHCP.thefacebook.com>
 <46dbe2a5-e65f-8b72-f835-0210bc445e52@suse.cz>
 <20180412145702.GB30714@castle.DHCP.thefacebook.com>
 <CAOaiJ-=JtFWNPqdtf+5uim0-LcPE9zSDZmocAa_6K3yGpW2fCQ@mail.gmail.com>
From: Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <69b4dcd8-1925-e0e8-d9b4-776f3405b769@codeaurora.org>
Date: Wed, 25 Apr 2018 09:19:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAOaiJ-=JtFWNPqdtf+5uim0-LcPE9zSDZmocAa_6K3yGpW2fCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 4/13/2018 5:43 PM, vinayak menon wrote:
> On Thu, Apr 12, 2018 at 8:27 PM, Roman Gushchin <guro@fb.com> wrote:
>> On Thu, Apr 12, 2018 at 08:52:52AM +0200, Vlastimil Babka wrote:
>>> On 04/11/2018 03:56 PM, Roman Gushchin wrote:
>>>> On Wed, Apr 11, 2018 at 03:16:08PM +0200, Vlastimil Babka wrote:
>>>>> [+CC linux-api]
>>>>>
>>>>> On 03/05/2018 02:37 PM, Roman Gushchin wrote:
>>>>>> This patch introduces a concept of indirectly reclaimable memory
>>>>>> and adds the corresponding memory counter and /proc/vmstat item.
>>>>>>
>>>>>> Indirectly reclaimable memory is any sort of memory, used by
>>>>>> the kernel (except of reclaimable slabs), which is actually
>>>>>> reclaimable, i.e. will be released under memory pressure.
>>>>>>
>>>>>> The counter is in bytes, as it's not always possible to
>>>>>> count such objects in pages. The name contains BYTES
>>>>>> by analogy to NR_KERNEL_STACK_KB.
>>>>>>
>>>>>> Signed-off-by: Roman Gushchin <guro@fb.com>
>>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>>>>>> Cc: Michal Hocko <mhocko@suse.com>
>>>>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>>>>> Cc: linux-fsdevel@vger.kernel.org
>>>>>> Cc: linux-kernel@vger.kernel.org
>>>>>> Cc: linux-mm@kvack.org
>>>>>> Cc: kernel-team@fb.com
>>>>>
>>>>> Hmm, looks like I'm late and this user-visible API change was just
>>>>> merged. But it's for rc1, so we can still change it, hopefully?
>>>>>
>>>>> One problem I see with the counter is that it's in bytes, but among
>>>>> counters that use pages, and the name doesn't indicate it.
>>>>
>>>> Here I just followed "nr_kernel_stack" path, which is measured in kB,
>>>> but this is not mentioned in the field name.
>>>
>>> Oh, didn't know. Bad example to follow :P
>>>
>>>>> Then, I don't
>>>>> see why users should care about the "indirectly" part, as that's just an
>>>>> implementation detail. It is reclaimable and that's what matters, right?
>>>>> (I also wanted to complain about lack of Documentation/... update, but
>>>>> looks like there's no general file about vmstat, ugh)
>>>>
>>>> I agree, that it's a bit weird, and it's probably better to not expose
>>>> it at all; but this is how all vm counters work. We do expose them all
>>>> in /proc/vmstat. A good number of them is useless until you are not a
>>>> mm developer, so it's arguable more "debug info" rather than "api".
>>>
>>> Yeah the problem is that once tools start rely on them, they fall under
>>> the "do not break userspace" rule, however we call them. So being
>>> cautious and conservative can't hurt.
>>>
>>>> It's definitely not a reason to make them messy.
>>>> Does "nr_indirectly_reclaimable_bytes" look better to you?
>>>
>>> It still has has the "indirecly" part and feels arbitrary :/
>>>
>>>>>
>>>>> I also kind of liked the idea from v1 rfc posting that there would be a
>>>>> separate set of reclaimable kmalloc-X caches for these kind of
>>>>> allocations. Besides accounting, it should also help reduce memory
>>>>> fragmentation. The right variant of cache would be detected via
>>>>> __GFP_RECLAIMABLE.
>>>>
>>>> Well, the downside is that we have to introduce X new caches
>>>> just for this particular problem. I'm not strictly against the idea,
>>>> but not convinced that it's much better.
>>>
>>> Maybe we can find more cases that would benefit from it. Heck, even slab
>>> itself allocates some management structures from the generic kmalloc
>>> caches, and if they are used for reclaimable caches, they could be
>>> tracked as reclaimable as well.
>>
>> This is a good catch!
>>
>>>
>>>>>
>>>>> With that in mind, can we at least for now put the (manually maintained)
>>>>> byte counter in a variable that's not directly exposed via /proc/vmstat,
>>>>> and then when printing nr_slab_reclaimable, simply add the value
>>>>> (divided by PAGE_SIZE), and when printing nr_slab_unreclaimable,
>>>>> subtract the same value. This way we would be simply making the existing
>>>>> counters more precise, in line with their semantics.
>>>>
>>>> Idk, I don't like the idea of adding a counter outside of the vm counters
>>>> infrastructure, and I definitely wouldn't touch the exposed
>>>> nr_slab_reclaimable and nr_slab_unreclaimable fields.
>>>
>>> We would be just making the reported values more precise wrt reality.
>>
>> It depends on if we believe that only slab memory can be reclaimable
>> or not. If yes, this is true, otherwise not.
>>
>> My guess is that some drivers (e.g. networking) might have buffers,
>> which are reclaimable under mempressure, and are allocated using
>> the page allocator. But I have to look closer...
>>
> 
> One such case I have encountered is that of the ION page pool. The page pool
> registers a shrinker. When not in any memory pressure page pool can go high
> and thus cause an mmap to fail when OVERCOMMIT_GUESS is set. I can send
> a patch to account ION page pool pages in NR_INDIRECTLY_RECLAIMABLE_BYTES.
> 
> Thanks,
> Vinayak
> 

As Vinayak mentioned NR_INDIRECTLY_RECLAIMABLE_BYTES can be used to solve the issue
with ION page pool when OVERCOMMIT_GUESS is set, the patch for the same can be 
found here https://lkml.org/lkml/2018/4/24/1288
