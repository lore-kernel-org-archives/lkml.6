Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F26C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B512722360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UvxQKAAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B512722360
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbeKNALo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:11:44 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54585 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732380AbeKNALo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:11:44 -0500
Received: by mail-it1-f194.google.com with SMTP id a205-v6so12762817itd.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QPsfCm8O0Mz2LyiUqKExaZZeAo+P0C/QYVDqe04KS0I=;
        b=UvxQKAACUFKKj3OA7IpCbUmOg9Ed1n0veUvs1szBkdCwDoF8aXtb7MMjyMD0eAdZSq
         fLoCVRvxmlvcvgJXx9dyD3BCzvTarK/w3xT/W31AGG9Vtxs63bIwjCql3SStxtlbpmrK
         2FSCWPprE/c1tEAewgggeJsWRrDidLWPDEpxPqUk3tmgJIA63Gmsbdqr7O+u7EFr7a2j
         /ox6XjSdQ4LK7aLugeW5DXB5rznhigtzInLnKE2CLTPkM7TJMn403JYRF8JueQiSMDuV
         qGwq/wTZBj2ZjuQw4cR/noQBiU7jsMAKEshHXWhAIDxwE5//uB6TzzHeWmzsLpdXubk9
         EMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QPsfCm8O0Mz2LyiUqKExaZZeAo+P0C/QYVDqe04KS0I=;
        b=phwuy16w2/FsSZHCFi9QfybFOtgmtck70pL1AF+jj0WabHNiO7jVrLJLuFB053i9b/
         EquK4Nz0Ed+ErAyf5KQjRL7wTnfzxlEyPCBc8ro6EcF7H1O6PNwHg1YmMHDQZKt7NHwZ
         sXQVJKEPYTaQZyyzypSa71eJpU7x1OkZQCKfm2l7lSAoOOQomtnIOQZ+z2F6JsZljG4Y
         mO2oOBbh8F33HYHc5zT57Pu7USwKhWn0gIstYborHFzCsMJCsgusAniCC0CLeHehCeJG
         FazWUk5xVcSK0OwlzdIRy7PGos2xV9BYqmDhLs7TmN3xQaKHhIgpaeX1fNPFcN5XPyZO
         qSIQ==
X-Gm-Message-State: AGRZ1gJDWjDXNEuTzfC1/ICJBYJkJKPDMHCm79khHKAAI5RiuprGKvHw
        lMh2/up/RpAMqPNfFvRN4inLk91B6JO2t30YtGM8Pw==
X-Google-Smtp-Source: AJdET5eYV/VDo8klSdXx7p4GkU4CgRUR679j5nsawVDqHx2VPBVhdwQxNEgVSz9NGE6ZMha2fM8nfXdG9YY51nYpCps=
X-Received: by 2002:a02:5f18:: with SMTP id r24-v6mr4919439jab.10.1542118403260;
 Tue, 13 Nov 2018 06:13:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:7050:0:0:0:0:0 with HTTP; Tue, 13 Nov 2018 06:13:22
 -0800 (PST)
In-Reply-To: <20181107170855.n4ertf5qv7ff5btl@lakrids.cambridge.arm.com>
References: <cover.1541525354.git.andreyknvl@google.com> <9405f32797b52616cd0746bcea37df94e8e4256a.1541525354.git.andreyknvl@google.com>
 <20181107170855.n4ertf5qv7ff5btl@lakrids.cambridge.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 13 Nov 2018 15:13:22 +0100
Message-ID: <CAAeHK+wDTDiwT_vcu8tTZyNkqHDdgAtSWF4pp=2mngMaJt44bA@mail.gmail.com>
Subject: Re: [PATCH v10 07/22] kasan: initialize shadow to 0xff for tag-based mode
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 6:08 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Nov 06, 2018 at 06:30:22PM +0100, Andrey Konovalov wrote:
>> A tag-based KASAN shadow memory cell contains a memory tag, that
>> corresponds to the tag in the top byte of the pointer, that points to that
>> memory. The native top byte value of kernel pointers is 0xff, so with
>> tag-based KASAN we need to initialize shadow memory to 0xff.
>>
>> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>> ---
>>  arch/arm64/mm/kasan_init.c | 16 ++++++++++++++--
>>  include/linux/kasan.h      |  8 ++++++++
>>  mm/kasan/common.c          |  3 ++-
>>  3 files changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
>> index 63527e585aac..18ebc8994a7b 100644
>> --- a/arch/arm64/mm/kasan_init.c
>> +++ b/arch/arm64/mm/kasan_init.c
>> @@ -43,6 +43,15 @@ static phys_addr_t __init kasan_alloc_zeroed_page(int node)
>>       return __pa(p);
>>  }
>>
>> +static phys_addr_t __init kasan_alloc_raw_page(int node)
>> +{
>> +     void *p = memblock_alloc_try_nid_raw(PAGE_SIZE, PAGE_SIZE,
>> +                                             __pa(MAX_DMA_ADDRESS),
>> +                                             MEMBLOCK_ALLOC_ACCESSIBLE,
>> +                                             node);
>> +     return __pa(p);
>> +}
>> +
>>  static pte_t *__init kasan_pte_offset(pmd_t *pmdp, unsigned long addr, int node,
>>                                     bool early)
>>  {
>> @@ -88,7 +97,9 @@ static void __init kasan_pte_populate(pmd_t *pmdp, unsigned long addr,
>>
>>       do {
>>               phys_addr_t page_phys = early ? __pa_symbol(kasan_zero_page)
>> -                                           : kasan_alloc_zeroed_page(node);
>> +                                           : kasan_alloc_raw_page(node);
>> +             if (!early)
>> +                     memset(__va(page_phys), KASAN_SHADOW_INIT, PAGE_SIZE);
>>               next = addr + PAGE_SIZE;
>>               set_pte(ptep, pfn_pte(__phys_to_pfn(page_phys), PAGE_KERNEL));
>>       } while (ptep++, addr = next, addr != end && pte_none(READ_ONCE(*ptep)));
>> @@ -138,6 +149,7 @@ asmlinkage void __init kasan_early_init(void)
>>               KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
>>       BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_START, PGDIR_SIZE));
>>       BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_END, PGDIR_SIZE));
>> +
>>       kasan_pgd_populate(KASAN_SHADOW_START, KASAN_SHADOW_END, NUMA_NO_NODE,
>>                          true);
>>  }
>> @@ -234,7 +246,7 @@ void __init kasan_init(void)
>>               set_pte(&kasan_zero_pte[i],
>>                       pfn_pte(sym_to_pfn(kasan_zero_page), PAGE_KERNEL_RO));
>>
>> -     memset(kasan_zero_page, 0, PAGE_SIZE);
>> +     memset(kasan_zero_page, KASAN_SHADOW_INIT, PAGE_SIZE);
>
> If this isn't going to contain zero, can we please have a preparatory
> patch renaming this to something which isn't misleading?
>
> Perhaps kasan_common_shadow_page?

Will rename to kasan_early_shadow_page in v11, thanks!

>
> Thanks,
> Mark.
