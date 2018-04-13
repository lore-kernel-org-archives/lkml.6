Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3617952-1523621638-2-15305523794521168121
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523621637; b=V5VVvfcHCRJoJgINuny+7K2VNAlC0G4sO3buAZPCwCdgMVJJAC
    kiUadHQe9kxNA/epj5FwE2jqoYgWDjMz1f3EQDiJc5yfosY5BqHmW9LH1mm5aj4V
    fzcu2YMPW/EQeke+0buceU58VaA7t6pLX1J+LDluPbQSZZpDM7ERHysn/M+gMb9e
    t+KD2ptmebCUTYDgKEd7p84XqmtnqDgrWGGEHiPnOvvg88ri5XmkkKI1fXwzxsKR
    k/iiiIUPvpuSMV8BDGcyVa9Kka6dfCSbTH9SK7E2XnLHCPsYZkSYmigSFhCy/jkQ
    F9V90+/L2CH9xOb4JCtzkS36c26AQgi9QWog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523621637; bh=7AL2Zm5sIxugePzKEPeNEW6krygJBlkYeIlgav9AMm
    E=; b=ugKXnEwPPJmR4sV6AiQXeAncqrV9F4P8DljWSuiOFSOQGgWWkCWZfw3anV
    lQRLjTGPzrc82hYUjuEl/VxIc82zDxrcyevxOLEiUaXnqdy5Enh3ZIIono72e7dg
    KcXfil1zU5bhnsiD7Ocj/7eiJib01b2MuTFnx8j9HROSWLoGW4jpY/KZFsleO5PG
    OaWs1g9zM8DfMEOZOVMaKegMZ9EdZ8/X7Cepx+FDqX53rkArA9tRSDvgiI9/OkPm
    dAuBFyr74jtGfL4pO/hHS6mRqUUUIaySxtDTrL4gxzK/rff12IQZcJQ+OJ1Vz2Yi
    YVkpdP9QOY9PUINAk8u1CEaTe99A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uqa9u6ji x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UuXz321N;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uqa9u6ji x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UuXz321N;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOz/yNVe9ikzIWktSU1qfyXuuYBRKZMbxDONxAVfuHQujI6mndvTk0GLl5N1488wss7aWi5mQG3hyXdFHIyMBjV3qGrnDX7jMraeiybNrEY423AogYK5
    eOANZyu1X5j3KnjwCQmDMXin0g73Itzt1JSPY3g4r7NBYhOS1r0IiUwNQgvNBBiTydRKVfQ/5YYR2goUbl1u09eqqTRuf1KoScH5gxpDh0D78kMH3J1IaIv5
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=iZGDJTNm2NwA:10 a=Kd1tUaAdevIA:10 a=FOH2dFAWAAAA:8 a=Z4Rwk6OoAAAA:8
    a=drOt6m5kAAAA:8 a=iox4zFpeAAAA:8 a=ufHFDILaAAAA:8 a=VwQbUJbxAAAA:8
    a=37rDS-QxAAAA:8 a=PsEQHI_mUF1SIxgwgc0A:9 a=tK8qyAR_YJz5LTdZ:21
    a=5kQOaz0cU5YH6blG:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=i3VuKzQdj-NEYjvDI-p3:22 a=HkZW87K1Qel5hWWM3VKY:22 a=RMMjzBEyIzXRtoq5n5K6:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=ZmIg1sZ3JBWsdXgziEIF:22 a=AjGcO6oz07-iQ99wixmX:22
    a=k1Nq6YrhK2t884LQW06G:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754655AbeDMMNo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 08:13:44 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:52338 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753958AbeDMMNl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Apr 2018 08:13:41 -0400
X-Google-Smtp-Source: AIpwx4+y5WHIM+Mpv2QGT1KgKcLhXzn5EsgLZrnk/lJ2+KMx55606QSjlO8uMXhqqMnWUHRSMdrCtel2VxJJ3O6LYGI=
MIME-Version: 1.0
In-Reply-To: <20180412145702.GB30714@castle.DHCP.thefacebook.com>
References: <20180305133743.12746-1-guro@fb.com> <20180305133743.12746-2-guro@fb.com>
 <08524819-14ef-81d0-fa90-d7af13c6b9d5@suse.cz> <20180411135624.GA24260@castle.DHCP.thefacebook.com>
 <46dbe2a5-e65f-8b72-f835-0210bc445e52@suse.cz> <20180412145702.GB30714@castle.DHCP.thefacebook.com>
From: vinayak menon <vinayakm.list@gmail.com>
Date: Fri, 13 Apr 2018 17:43:39 +0530
Message-ID: <CAOaiJ-=JtFWNPqdtf+5uim0-LcPE9zSDZmocAa_6K3yGpW2fCQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES
To: Roman Gushchin <guro@fb.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 8:27 PM, Roman Gushchin <guro@fb.com> wrote:
> On Thu, Apr 12, 2018 at 08:52:52AM +0200, Vlastimil Babka wrote:
>> On 04/11/2018 03:56 PM, Roman Gushchin wrote:
>> > On Wed, Apr 11, 2018 at 03:16:08PM +0200, Vlastimil Babka wrote:
>> >> [+CC linux-api]
>> >>
>> >> On 03/05/2018 02:37 PM, Roman Gushchin wrote:
>> >>> This patch introduces a concept of indirectly reclaimable memory
>> >>> and adds the corresponding memory counter and /proc/vmstat item.
>> >>>
>> >>> Indirectly reclaimable memory is any sort of memory, used by
>> >>> the kernel (except of reclaimable slabs), which is actually
>> >>> reclaimable, i.e. will be released under memory pressure.
>> >>>
>> >>> The counter is in bytes, as it's not always possible to
>> >>> count such objects in pages. The name contains BYTES
>> >>> by analogy to NR_KERNEL_STACK_KB.
>> >>>
>> >>> Signed-off-by: Roman Gushchin <guro@fb.com>
>> >>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> >>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> >>> Cc: Michal Hocko <mhocko@suse.com>
>> >>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> >>> Cc: linux-fsdevel@vger.kernel.org
>> >>> Cc: linux-kernel@vger.kernel.org
>> >>> Cc: linux-mm@kvack.org
>> >>> Cc: kernel-team@fb.com
>> >>
>> >> Hmm, looks like I'm late and this user-visible API change was just
>> >> merged. But it's for rc1, so we can still change it, hopefully?
>> >>
>> >> One problem I see with the counter is that it's in bytes, but among
>> >> counters that use pages, and the name doesn't indicate it.
>> >
>> > Here I just followed "nr_kernel_stack" path, which is measured in kB,
>> > but this is not mentioned in the field name.
>>
>> Oh, didn't know. Bad example to follow :P
>>
>> >> Then, I don't
>> >> see why users should care about the "indirectly" part, as that's just an
>> >> implementation detail. It is reclaimable and that's what matters, right?
>> >> (I also wanted to complain about lack of Documentation/... update, but
>> >> looks like there's no general file about vmstat, ugh)
>> >
>> > I agree, that it's a bit weird, and it's probably better to not expose
>> > it at all; but this is how all vm counters work. We do expose them all
>> > in /proc/vmstat. A good number of them is useless until you are not a
>> > mm developer, so it's arguable more "debug info" rather than "api".
>>
>> Yeah the problem is that once tools start rely on them, they fall under
>> the "do not break userspace" rule, however we call them. So being
>> cautious and conservative can't hurt.
>>
>> > It's definitely not a reason to make them messy.
>> > Does "nr_indirectly_reclaimable_bytes" look better to you?
>>
>> It still has has the "indirecly" part and feels arbitrary :/
>>
>> >>
>> >> I also kind of liked the idea from v1 rfc posting that there would be a
>> >> separate set of reclaimable kmalloc-X caches for these kind of
>> >> allocations. Besides accounting, it should also help reduce memory
>> >> fragmentation. The right variant of cache would be detected via
>> >> __GFP_RECLAIMABLE.
>> >
>> > Well, the downside is that we have to introduce X new caches
>> > just for this particular problem. I'm not strictly against the idea,
>> > but not convinced that it's much better.
>>
>> Maybe we can find more cases that would benefit from it. Heck, even slab
>> itself allocates some management structures from the generic kmalloc
>> caches, and if they are used for reclaimable caches, they could be
>> tracked as reclaimable as well.
>
> This is a good catch!
>
>>
>> >>
>> >> With that in mind, can we at least for now put the (manually maintained)
>> >> byte counter in a variable that's not directly exposed via /proc/vmstat,
>> >> and then when printing nr_slab_reclaimable, simply add the value
>> >> (divided by PAGE_SIZE), and when printing nr_slab_unreclaimable,
>> >> subtract the same value. This way we would be simply making the existing
>> >> counters more precise, in line with their semantics.
>> >
>> > Idk, I don't like the idea of adding a counter outside of the vm counters
>> > infrastructure, and I definitely wouldn't touch the exposed
>> > nr_slab_reclaimable and nr_slab_unreclaimable fields.
>>
>> We would be just making the reported values more precise wrt reality.
>
> It depends on if we believe that only slab memory can be reclaimable
> or not. If yes, this is true, otherwise not.
>
> My guess is that some drivers (e.g. networking) might have buffers,
> which are reclaimable under mempressure, and are allocated using
> the page allocator. But I have to look closer...
>

One such case I have encountered is that of the ION page pool. The page pool
registers a shrinker. When not in any memory pressure page pool can go high
and thus cause an mmap to fail when OVERCOMMIT_GUESS is set. I can send
a patch to account ION page pool pages in NR_INDIRECTLY_RECLAIMABLE_BYTES.

Thanks,
Vinayak
