Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AD5C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F64D20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gzQI7IPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F64D20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbeGYSnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:43:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51229 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbeGYSne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:43:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so6246736wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aotTB/o3bhgq3wEB9ArU9O9fYaNWiBOChYPwLzlAD4g=;
        b=gzQI7IPYbwobfOR/CKYNcsNiHneSrWxoAuHXywKjGMe5kH4+oYI57uxKV7VsnjWUoj
         FlvBXUiRknqULFO3+QQwOwPnQcQOK36hJoD6uNUEQ0jzD0a+pPPHKa7WkaPc+krYAHPp
         EnEBIKk1Cl/diaKLSkYOvNueSZqDLZUbAMi5cLM/dZYn8xk+fDPkcngRpoopEwclYsr9
         oR3YyNwQsfqF3wcNB8HZ14uOvucCN5aYWLFvcaFfeo3HmV8qmvJY1vZm0JO7zRBDHkQo
         Ve04zBAQX60Zg1jKtE1ZYmLXJx7Lj3cSnw83Hac8jeJEkMj9d+nLNW1CZREagvn9Cr1S
         XQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aotTB/o3bhgq3wEB9ArU9O9fYaNWiBOChYPwLzlAD4g=;
        b=ZbaqORCSmDFRTadHxiavxYoQX57H8h9UO5zN1QWywv+w6M9JeZVdac5Vv9fh1lmc2/
         yGFoxmuYuQMNDGKC58WJiOs2/l6VtyY0cERpVI5BjihTuXGa8ohM509L5inHayr3R6Ha
         Qw39ukrgTr1BL0RB53vHDJiha1kDHqy3aP0ljLAiLSX1q/ZaYKJ4cNqIdhXF0lbtYDVt
         kSAHqeksreXSRP/extzB5oIWQF3KdCaw7S7CKCDo7o5RfVhE36L2L/FQCGMXHoXbh1Gl
         ieo6tozYDF3NJGMjV/PEp89HwYLwjQpSX/t+u6X2a4/Bt0K//QHC4GspCCl81LcfYGfG
         ZmmQ==
X-Gm-Message-State: AOUpUlGpD/ADR/1rK7TcroX2igaxFYMkcWm1HHu/sj3ri1WEWpMhNZ3N
        rWLtVbsUmt5StrfnHqFyds1ABHPBPm/4ojRnsmkxOw==
X-Google-Smtp-Source: AAOMgpdlV2u4vqhghplq8D7XaoQR1XwgSdwGn76TKwwNFo/6rzMOsKe+3StBtniA/WHV0OTyYKJrfoypHmoQSXL/KYs=
X-Received: by 2002:a1c:ae8d:: with SMTP id x135-v6mr5272072wme.20.1532539853123;
 Wed, 25 Jul 2018 10:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180724210923.GA20168@bombadil.infradead.org>
 <20180725023728.44630-1-cannonmatthews@google.com> <DF4PR8401MB11806B9D2A7FE04B1F5ECBF8AB540@DF4PR8401MB1180.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <DF4PR8401MB11806B9D2A7FE04B1F5ECBF8AB540@DF4PR8401MB1180.NAMPRD84.PROD.OUTLOOK.COM>
From:   Cannon Matthews <cannonmatthews@google.com>
Date:   Wed, 25 Jul 2018 10:30:40 -0700
Message-ID: <CAJfu=Uf98_FBNkULq5RD6dapY5K6gL=Xm7DOSJJVscDfKkwq0Q@mail.gmail.com>
Subject: Re: [PATCH v2] RFC: clear 1G pages with streaming stores on x86
To:     elliott@hpe.com
Cc:     mhocko@kernel.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andres Lagar-Cavilla <andreslc@google.com>, sqazi@google.com,
        Paul Turner <pjt@google.com>,
        David Matlack <dmatlack@google.com>,
        Peter Feiner <pfeiner@google.com>, nullptr@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback!
On Tue, Jul 24, 2018 at 10:02 PM Elliott, Robert (Persistent Memory)
<elliott@hpe.com> wrote:
>
>
>
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> > owner@vger.kernel.org> On Behalf Of Cannon Matthews
> > Sent: Tuesday, July 24, 2018 9:37 PM
> > Subject: Re: [PATCH v2] RFC: clear 1G pages with streaming stores on
> > x86
> >
> > Reimplement clear_gigantic_page() to clear gigabytes pages using the
> > non-temporal streaming store instructions that bypass the cache
> > (movnti), since an entire 1GiB region will not fit in the cache
> > anyway.
> >
> > Doing an mlock() on a 512GiB 1G-hugetlb region previously would take
> > on average 134 seconds, about 260ms/GiB which is quite slow. Using
> > `movnti` and optimizing the control flow over the constituent small
> > pages, this can be improved roughly by a factor of 3-4x, with the
> > 512GiB mlock() taking only 34 seconds on average, or 67ms/GiB.
>
> ...
> > - Are there any obvious pitfalls or caveats that have not been
> > considered?
>
> Note that Kirill attempted something like this in 2012 - see
> https://www.spinics.net/lists/linux-mm/msg40575.html
>

Oh very interesting I had not seen this before. So it seems like that was an
attempt to implement this more generally for THP and smaller page sizes,
but the performance numbers just weren't there to fully motivate it?

However, from the last follow up, it's suggested it might be a better fit
for hugetlbfs 1G pages:

> It would make a whole lot more sense for hugetlbfs giga pages than for
> THP (unlike for THP, cache trashing with giga pages is guaranteed),
> but even with giga pages, it's not like they're allocated frequently
> (maybe once per OS reboot) so that's also sure totally lost in the
> noise as it only saves a few accesses after the cache copy is
> finished.

I'm obviously inclined to agree with that, but I think that moreover,
the increase
in DRAM sizes in the last 6 years makes this more attractive as now you can
build systems with thousands of 1GiB pages, those time savings add up more.

Of course 1G pages are still unlikely to be reallocated frequently (though there
certainly use cases for more than once per reboot), but taking a long time to
clear them can add 10s of minutes to application startup or cause quarter
second long page faults later, neither is particularly desirable.


> ...
> > +++ b/arch/x86/lib/clear_gigantic_page.c
> > @@ -0,0 +1,29 @@
> > +#include <asm/page.h>
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/mm.h>
> > +#include <linux/sched.h>
> > +
> > +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) ||
> > defined(CONFIG_HUGETLBFS)
> > +#define PAGES_BETWEEN_RESCHED 64
> > +void clear_gigantic_page(struct page *page,
> > +                             unsigned long addr,
>
> The previous attempt used cacheable stores in the page containing
> addr to prevent an inevitable cache miss after the clearing completes.
> This function is not using addr at all.

Ah that's a good idea, I admittedly do not have a good understanding of what
the arguments were supposed to represent, as there are no comments, and
tracing through the existing codepath via clear_user_highpage() it seems like
the addr/vaddr argument was passed around only to be ultimately ignored by
clear_user_page()

While that's generally true about the cache miss being inevitable, if you are
preallocating a lot of 1G pages to avoid long page faults later via mlock()
or MAP_POPULATE will there still be an immediate cache miss, or will those
paths just build the page tables without touching anything?

Regardless I'm not sure how you would detect that here, and this seems like
an inexpensive optimization in anycase.

>
> > +                             unsigned int pages_per_huge_page)
> > +{
> > +     int i;
> > +     void *dest = page_to_virt(page);
> > +     int resched_count = 0;
> > +
> > +     BUG_ON(pages_per_huge_page % PAGES_BETWEEN_RESCHED != 0);
> > +     BUG_ON(!dest);
>
> Are those really possible conditions?  Is there a safer fallback
> than crashing the whole kernel?

Perhaps not, I hope not anyhow,  this was something of a first pass
with paranoid
invariant checking, and initially I wrote this outside of the x86
specific directory.

I suppose that would depend on:

Is page_to_virt() always available and guaranteed to return something valid?
Will `page_per_huge_page` ever be anything other than 262144, and if so
anything besides 512 or 1?

It seems like on x86 these conditions will always be true, but I don't know
enough to say for 100% certain.

>
> > +
> > +     for (i = 0; i < pages_per_huge_page; i +=
> > PAGES_BETWEEN_RESCHED) {
> > +             __clear_page_nt(dest + (i * PAGE_SIZE),
> > +                             PAGES_BETWEEN_RESCHED * PAGE_SIZE);
> > +             resched_count += cond_resched();
> > +     }
> > +     /* __clear_page_nt requrires and `sfence` barrier. */
>
> requires an
>
Good catch thanks.
> ...
> > diff --git a/arch/x86/lib/clear_page_64.S
> ...
> > +/*
> > + * Zero memory using non temporal stores, bypassing the cache.
> > + * Requires an `sfence` (wmb()) afterwards.
> > + * %rdi - destination.
> > + * %rsi - page size. Must be 64 bit aligned.
> > +*/
> > +ENTRY(__clear_page_nt)
> > +     leaq    (%rdi,%rsi), %rdx
> > +     xorl    %eax, %eax
> > +     .p2align 4,,10
> > +     .p2align 3
> > +.L2:
> > +     movnti  %rax, (%rdi)
> > +     addq    $8, %rdi
>
> Also consider using the AVX vmovntdq instruction (if available), the
> most recent of which does 64-byte (cache line) sized transfers to
> zmm registers. There's a hefty context switching overhead (e.g.,
> 304 clocks), but it might be worthwhile for 1 GiB (which
> is 16,777,216 cache lines).
>
> glibc memcpy() makes that choice for transfers > 75% of the L3 cache
> size divided by the number of cores.  (last I tried, it was still
> selecting "rep stosb" for large memset()s, although it has an
> AVX-512 function available)
>
> Even with that, one CPU core won't saturate the memory bus; multiple
> CPU cores (preferably on the same NUMA node as the memory) need to
> share the work.
>

Before I started this I experimented with all of those variants, and
interestingly found that I could equally saturate the memory bandwidth with
64,128, or 256bit wide instructions on a broadwell CPU ( I did not have a
skylake/AVX-512 machine available to run the tests on, would be a curious
thing to see it it holds for that as well).

From userspace I did a mmap(MAP_POPULATE), then measured the time
 to zero a 100GiB region:

mmap(MAP_POPULATE):     27.740127291
memset [libc, AVX]:     19.318307069
rep stosb:              19.301119348
movntq:                 5.874515236
movnti:                 5.786089655
movtndq:                5.837171599
vmovntdq:               5.798766718

It was interesting also that both the libc memset using AVX
instructions
(confirmed with gdb, though maybe it's more dynamic/tricksy than I know) was
almost identical to the `rep stosb` implementation.

I had some conversations with some platforms engineers who thought this made
sense, but that it is likely to be highly CPU dependent, and some CPUs might be
able to do larger bursts of transfers in parallel and get better
performance from
the wider instructions, but this got way over my head into hardware SDRAM
controller design. More benchmarking would tell however.

Another thing to consider about AVX instructions is that they affect core
frequency and power/thermals, though I can't really speak to specifics but I
understand that using 512/256 bit instructions and zmm registers can use more
power and limit the  frequency of other cores or something along those
lines.
Anyone with expertise feel free to correct me on this though. I assume this is
also highly CPU dependent.

But anyway, since the wide instructions were no faster than `movnti` on a
single core it didn't seem worth the FPU context saving in the kernel.

Perhaps AVX-512 goes further however, it might be worth testing there too.
> ---
> Robert Elliott, HPE Persistent Memory
>
>
>
