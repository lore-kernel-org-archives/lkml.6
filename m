Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7B3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81395223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FQxo6PoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81395223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbeKOFY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:24:28 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50304 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbeKOFY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 00:24:28 -0500
Received: by mail-it1-f193.google.com with SMTP id k206-v6so25676511ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 11:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lGu1tR1VCKROUdcLGGzQv5vwMmSpNf5ctsKcBTGiIV4=;
        b=FQxo6PoE68FpouxYE1uVX8s5rfc1oaEmz1ii8ufW2hxZAgn6uSzU1J/bmckdl6pou1
         eXweocMm2FiaxIgG5lW079Qezab2/S+Hs3xJtwGm/Ukpxl+0YcundsgYF8xkVuztbv6U
         yWgT5cabtVHyosVMckft08rXc3gQmL/lmYsyCB2Av0xK+vlb1mzrC7REO8mP9vGksGcl
         k5QaDSGLlh1nE9uLKbu8Dc4HdvP/lCiFsWPqp8tBAUdk764vfa+1UVry23fL5TVwU5do
         +IhcNDBFgzLq/HdtFyzHSSCzmpobxttzFGOeZd8CvIHgSDv5Q1GMIETbefZhRH8WKaGZ
         mv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lGu1tR1VCKROUdcLGGzQv5vwMmSpNf5ctsKcBTGiIV4=;
        b=SyvURMcu4Pl7e7HhbE+7lbE8s74hCHZz9W1c59fVeVL4wUJNgHBVYhJ4UtgF+pihNC
         qz7tPhPIB6hZYJ1PrYBUDX/jPZX2biw//tYac3CR4wKtkSz6M2bj/9FH0Egq8N2/T1Dh
         qh9wvXxDRC1mIJO3m194MA1787l8VO4B7dnNmV2Lve7+N2+0GTzQt17Y09uOOxQbOOkL
         EcmbZxDqI+jG+PRbyq+xN2/itwrbtZmuaji0Vm6VEbyGxd/u9bXsru8/IVsMNGzIdWYK
         obsGsepiqgOdt+F5rwrnchfSd/4Ob2Qpf/2PGV8qukTHLor1usMfFJeYVBdfXQmgGXrd
         wlBg==
X-Gm-Message-State: AGRZ1gLO3jkH3lrFTT89+68sFQm3p6W/pqYc36uJHZx3vyMxahze1l8h
        /opcO2TwqLtTS+rui+kMwk8m7JNbaENjncsEGCztKw==
X-Google-Smtp-Source: AJdET5cj+5SJMoCyaFodXdK01bd+zQNQ8azYaGmIRmDd3VTrLAAF1qLFGtgHTpxsowKrKdVreneyGfF0LvWeQJ+dK7g=
X-Received: by 2002:a24:dac7:: with SMTP id z190-v6mr2798977itg.87.1542223198716;
 Wed, 14 Nov 2018 11:19:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:7050:0:0:0:0:0 with HTTP; Wed, 14 Nov 2018 11:19:57
 -0800 (PST)
In-Reply-To: <20181107172306.3w2pjecaggsvl5z2@lakrids.cambridge.arm.com>
References: <cover.1541525354.git.andreyknvl@google.com> <b8c56d36b79eecf0c331a0a7a2df12632aefccc9.1541525354.git.andreyknvl@google.com>
 <20181107172306.3w2pjecaggsvl5z2@lakrids.cambridge.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 14 Nov 2018 20:19:57 +0100
Message-ID: <CAAeHK+wDCtL4PGmE4-XJj=wqpSHsuemKABYwpuU-=DpULtJvzA@mail.gmail.com>
Subject: Re: [PATCH v10 09/22] kasan: add tag related helper functions
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

On Wed, Nov 7, 2018 at 6:23 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Nov 06, 2018 at 06:30:24PM +0100, Andrey Konovalov wrote:
>> This commit adds a few helper functions, that are meant to be used to
>> work with tags embedded in the top byte of kernel pointers: to set, to
>> get or to reset (set to 0xff) the top byte.
>>
>> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>> ---
>>  arch/arm64/mm/kasan_init.c |  2 ++
>>  include/linux/kasan.h      | 13 +++++++++
>>  mm/kasan/kasan.h           | 55 ++++++++++++++++++++++++++++++++++++++
>>  mm/kasan/tags.c            | 37 +++++++++++++++++++++++++
>>  4 files changed, 107 insertions(+)
>>
>> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
>> index 18ebc8994a7b..370b19d0e2fb 100644
>> --- a/arch/arm64/mm/kasan_init.c
>> +++ b/arch/arm64/mm/kasan_init.c
>> @@ -249,6 +249,8 @@ void __init kasan_init(void)
>>       memset(kasan_zero_page, KASAN_SHADOW_INIT, PAGE_SIZE);
>>       cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
>>
>> +     kasan_init_tags();
>> +
>>       /* At this point kasan is fully initialized. Enable error messages */
>>       init_task.kasan_depth = 0;
>>       pr_info("KernelAddressSanitizer initialized\n");
>> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
>> index 7f6574c35c62..4c9d6f9029f2 100644
>> --- a/include/linux/kasan.h
>> +++ b/include/linux/kasan.h
>> @@ -169,6 +169,19 @@ static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
>>
>>  #define KASAN_SHADOW_INIT 0xFF
>>
>> +void kasan_init_tags(void);
>> +
>> +void *kasan_reset_tag(const void *addr);
>> +
>> +#else /* CONFIG_KASAN_SW_TAGS */
>> +
>> +static inline void kasan_init_tags(void) { }
>> +
>> +static inline void *kasan_reset_tag(const void *addr)
>> +{
>> +     return (void *)addr;
>> +}
>> +
>
>> +#ifdef CONFIG_KASAN_SW_TAGS
>> +
>> +#define KASAN_PTR_TAG_SHIFT 56
>> +#define KASAN_PTR_TAG_MASK (0xFFUL << KASAN_PTR_TAG_SHIFT)
>> +
>> +u8 random_tag(void);
>> +
>> +static inline void *set_tag(const void *addr, u8 tag)
>> +{
>> +     u64 a = (u64)addr;
>> +
>> +     a &= ~KASAN_PTR_TAG_MASK;
>> +     a |= ((u64)tag << KASAN_PTR_TAG_SHIFT);
>> +
>> +     return (void *)a;
>> +}
>> +
>> +static inline u8 get_tag(const void *addr)
>> +{
>> +     return (u8)((u64)addr >> KASAN_PTR_TAG_SHIFT);
>> +}
>> +
>> +static inline void *reset_tag(const void *addr)
>> +{
>> +     return set_tag(addr, KASAN_TAG_KERNEL);
>> +}
>
> We seem to be duplicating this functionality in several places.
>
> Could we please make it so that the arch code defines macros:
>
> arch_kasan_set_tag(addr, tag)
> arch_kasan_get_tag(addr)
> arch_kasan_reset_tag(addr)
>
> ... and use thoses consistently rather than open-coding them?
>
>> +
>> +#else /* CONFIG_KASAN_SW_TAGS */
>> +
>> +static inline u8 random_tag(void)
>> +{
>> +     return 0;
>> +}
>> +
>> +static inline void *set_tag(const void *addr, u8 tag)
>> +{
>> +     return (void *)addr;
>> +}
>> +
>> +static inline u8 get_tag(const void *addr)
>> +{
>> +     return 0;
>> +}
>> +
>> +static inline void *reset_tag(const void *addr)
>> +{
>> +     return (void *)addr;
>> +}
>
> ... these can be defined in linux/kasan.h as:
>
> #define arch_kasan_set_tag(addr, tag)   (addr)
> #define arch_kasan_get_tag(addr)        0
> #define arch_kasan_reset_tag(addr)      (addr)

Will do in v11, thanks!
