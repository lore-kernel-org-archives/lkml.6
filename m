Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE9FC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411BF208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amSvrknR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411BF208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933129AbeGJCOW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 22:14:22 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:45192 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932620AbeGJCOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 22:14:14 -0400
Received: by mail-oi0-f47.google.com with SMTP id q11-v6so14117626oic.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 19:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qfpmsPsTpDkZx7mgdGlkQTKKpCuCy1lQG1ZIKf/NcxI=;
        b=amSvrknRX+Rv/rOg/Vm/IQBtF5MiF3n74mHB3HmtXsCoe8fDWwLZf5tRQw9SlTsSPu
         Kdlh9xXZ5t4u26U9h1NLCKR4e9CZlEhFjb2mUUsg0T+BpupR3QWYdUOkG1G/m9YX76qO
         kSB4xP7V50JMouJatCbf7VMzGhO/DCi9enkYoldL+d3M2bc4T+L+mXvufU72wi2TtX7k
         9J2HGE50sKnmDZ0pg4vAU/yjQ/6NpSh+RZWLFxLArbHufoKRjoYes4mtAZxNkDzKhlP3
         v3BfUJV5pAS+Ysg1OyT7PO8eFNWWKVEppCCY2qr9GhIDQeAkBjQ1n5lHDNO9dbQi+x9r
         9FqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qfpmsPsTpDkZx7mgdGlkQTKKpCuCy1lQG1ZIKf/NcxI=;
        b=PJfJgZWM79ldo4ZxDs0VT9TaimgItEC6bM9MT66/uYFLFFkZIuhSxw6M8fejgkldqy
         hgU+Iqsk5BkUcJU6OX3IqGabkmn/hUbzzNTVyA3MS3pUiRuh/ZjSaRDiJfNJa/sVpc0d
         0TrKKTg05sMaC6ncWR/ArkjFfNXSGBdEN/Lc5+kql+iMWtBoYKujIh0kQW/r0mAg8GiK
         GU+kVlMbeE+bUVgcqww5Q7eB5Fu2cCqU0J8KLSH9d1L+/D9/rhue82TgFRuJb7lKLhTQ
         jl8v45bqmmiEDu0yh93Z01Vsuo/jatOOsOopV1eECsvgQKgV/paRbRUm0lhoc+2UvpBT
         yQQw==
X-Gm-Message-State: APt69E1q16A1/jCvKgWx3um8w8UaKApiFMG9TrvVo89lrnL47/H0mfjE
        aLL+KcOUkdBbdnutcQ619jDC0/rvaVPeLZJgwIA=
X-Google-Smtp-Source: AAOMgpfygn7A6iA5Hs4/7OKcW4cWwYqbt3R0esd3Dzvd62jpSAKHB1J5hMZDbhHWy3pNPAiuHgCLFcmS+wKABzUSLk4=
X-Received: by 2002:aca:1a0b:: with SMTP id a11-v6mr24017475oia.316.1531188853899;
 Mon, 09 Jul 2018 19:14:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c984:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 19:14:13 -0700 (PDT)
In-Reply-To: <7db385ef-0940-8f28-87b0-828921dd2f1d@intel.com>
References: <CAMe9rOqXsQ4Onv8_-kYE_yVYVfN0Hsg81XM0sq9k2cVYE_LvaQ@mail.gmail.com>
 <50d6bb50-5fa4-33d1-1f88-3844d0237f16@intel.com> <CAMe9rOoA=OoyaUfOvWuHGTp_ii9-A_ecR5tj8CefBKx_Hmi50g@mail.gmail.com>
 <7db385ef-0940-8f28-87b0-828921dd2f1d@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 9 Jul 2018 19:14:13 -0700
Message-ID: <CAMe9rOoZ=8ROyR6U3-JY+4hib2Bb5LGhBYzY5S_Xp38coj16aQ@mail.gmail.com>
Subject: Re: Kernel 4.17.4 lockup
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 5:44 PM, Dave Hansen <dave.hansen@intel.com> wrote:
> ...  cc'ing a few folks who I know have been looking at this code
> lately.  The full oops is below if any of you want to take a look.
>
> OK, well, annotating the disassembly a bit:
>
>> (gdb) disass free_pages_and_swap_cache
>> Dump of assembler code for function free_pages_and_swap_cache:
>>    0xffffffff8124c0d0 <+0>: callq  0xffffffff81a017a0 <__fentry__>
>>    0xffffffff8124c0d5 <+5>: push   %r14
>>    0xffffffff8124c0d7 <+7>: push   %r13
>>    0xffffffff8124c0d9 <+9>: push   %r12
>>    0xffffffff8124c0db <+11>: mov    %rdi,%r12         // %r12 = pages
>>    0xffffffff8124c0de <+14>: push   %rbp
>>    0xffffffff8124c0df <+15>: mov    %esi,%ebp         // %ebp = nr
>>    0xffffffff8124c0e1 <+17>: push   %rbx
>>    0xffffffff8124c0e2 <+18>: callq  0xffffffff81205a10 <lru_add_drain>
>>    0xffffffff8124c0e7 <+23>: test   %ebp,%ebp         // test nr==0
>>    0xffffffff8124c0e9 <+25>: jle    0xffffffff8124c156 <free_pages_and_swap_cache+134>
>>    0xffffffff8124c0eb <+27>: lea    -0x1(%rbp),%eax
>>    0xffffffff8124c0ee <+30>: mov    %r12,%rbx         // %rbx = pages
>>    0xffffffff8124c0f1 <+33>: lea    0x8(%r12,%rax,8),%r14 // load &pages[nr] into %r14?
>>    0xffffffff8124c0f6 <+38>: mov    (%rbx),%r13       // %r13 = pages[i]
>>    0xffffffff8124c0f9 <+41>: mov    0x20(%r13),%rdx   //<<<<<<<<<<<<<<<<<<<< GPF here.
> %r13 is 64-byte aligned, so looks like a halfway reasonable 'struct page *'.
>
> %R14 looks OK (0xffff93d4abb5f000) because it points to the end of a
> dynamically-allocated (not on-stack) mmu_gather_batch page.  %RBX is
> pointing 50 pages up from the start of the previous page.  That makes it
> the 48th page in pages[] after a pointer and two integers in the
> beginning of the structure.  That 48 is important because it's way
> larger than the on-stack size of 8.
>
> It's hard to make much sense of %R13 (pages[48] / 0xfffbf0809e304bc0)
> because the vmemmap addresses get randomized.  But, I _think_ that's too
> high of an address for a 4-level paging vmemmap[] entry.  Does anybody
> else know offhand?
>
> I'd really want to see this reproduced without KASLR to make the oops
> easier to read.  It would also be handy to try your workload with all
> the pedantic debugging: KASAN, slab debugging, DEBUG_PAGE_ALLOC, etc...
> and see if it still triggers.

How can I turn them on at boot time?

> Some relevant functions and structures below for reference.
>
> void free_pages_and_swap_cache(struct page **pages, int nr)
> {
>         for (i = 0; i < nr; i++)
>                 free_swap_cache(pages[i]);
> }
>
>
> static void tlb_flush_mmu_free(struct mmu_gather *tlb)
> {
>         for (batch = &tlb->local; batch && batch->nr;
>              batch = batch->next) {
>                 free_pages_and_swap_cache(batch->pages, batch->nr);
> }
>
> zap_pte_range()
> {
>         if (force_flush)
>                 tlb_flush_mmu_free(tlb);
> }
>
> ... all the way up to the on-stack-allocated mmu_gather:
>
> void zap_page_range(struct vm_area_struct *vma, unsigned long start,
>                 unsigned long size)
> {
>         struct mmu_gather tlb;
>
>
> #define MMU_GATHER_BUNDLE       8
>
> struct mmu_gather {
> ...
>         struct mmu_gather_batch local;
>         struct page             *__pages[MMU_GATHER_BUNDLE];
> }
>
> struct mmu_gather_batch {
>         struct mmu_gather_batch *next;
>         unsigned int            nr;
>         unsigned int            max;
>         struct page             *pages[0];
> };
>
> #define MAX_GATHER_BATCH        \
>         ((PAGE_SIZE - sizeof(struct mmu_gather_batch)) / sizeof(void *))
>



-- 
H.J.
