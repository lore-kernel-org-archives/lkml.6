Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DCDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF31D20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcelSDhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF31D20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbeK1DLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:11:11 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37004 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbeK1DLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:11:11 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so34784282iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 08:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=usBQLnzCgLG9xMN/jf7TRbAC3JcbyRRiIRhWQwWAFs8=;
        b=mcelSDhczCE74bUm3umFlxwckmZYNzxR1G7Sm1A1pubTVp4rN//jVaFSLDHWImYm2O
         QswR3ZNytzZ8d3nydLzWli7pwy3h0d+4x+rJYDJ3WOV7FUMoi1QzPKjEglRWgF9S1bMi
         nebIMMWXup1sPPcko0xffPqavlJqJldjLVhOsOChQ9fHufoq+LljQqkGh6hNpiE48bY3
         F4Fwc5zElfw4tL2D3nwgXGwmCN3yz4F/rYuMsS+L7ZmVpba18Qt9oDtmpBLphp8l85R2
         H+8IwIHQj+VTCbIrHLvh9LWIy7vKP8JC+cQz3JIBliAC7mRcfCpSgXp/PaXhvxY5ohdC
         hSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=usBQLnzCgLG9xMN/jf7TRbAC3JcbyRRiIRhWQwWAFs8=;
        b=hjHz2QOC+Bjk41v7vnRAKadedISYoteOa0H9GRHNfAenkR6w0PDVsIsnWjlxquVSPf
         /dxpWfqHcYRuipQEp2GK/+Mhbg0h+kFDc0F/utxpTyD8zY450Z7sAcz2792U5kVfKy4W
         Hl0vb++9JN6g6nZ6VaEwLSpvSpB0saTcPldAMSAQGz9iPbOu6lEH4zySQkgPk9qD4ydL
         KhyduBJ5voy5dxtvH+KRwycXRspfTiaXeMi4AesCco7YKztlm1fZuu8umKeNs/2ZToDe
         ZnOBDLOkoSnTq1GwdtzTO75J12tPc3JrZ2urgs/55Kfe3pi5Xkz3FI1g2p2+gUpHIyLF
         Q6+Q==
X-Gm-Message-State: AA+aEWZMiS2zmEQYwh/xR0kluC14XwOHlzTx5irXFjZ16gB1lRBimiAy
        FYoK4iaychnWZu4RTTEfzlIXU8pDxJZzZikba3zXDA==
X-Google-Smtp-Source: AJdET5dc0LuLvV9oJDSJTsEw0QmNUny0y+p/R9bS9GdMbIEqvmnDdnN+TCDOove2bRSmwddtj4gB1qjlW6cCg6ywuaM=
X-Received: by 2002:a24:dac7:: with SMTP id z190-v6mr24911364itg.87.1543335166822;
 Tue, 27 Nov 2018 08:12:46 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:7050:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 08:12:45
 -0800 (PST)
In-Reply-To: <20181123174352.ri3qo3wx2irm6hzj@lakrids.cambridge.arm.com>
References: <cover.1542648335.git.andreyknvl@google.com> <356c34c9a2ae8348a6cbd1de53135a28187fa120.1542648335.git.andreyknvl@google.com>
 <20181123174352.ri3qo3wx2irm6hzj@lakrids.cambridge.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 27 Nov 2018 17:12:45 +0100
Message-ID: <CAAeHK+y7Ya25+pzLTxBbin5HkirPyw3Fbz5Tb-HU1GeUnhDMjA@mail.gmail.com>
Subject: Re: [PATCH v11 05/24] kasan: add CONFIG_KASAN_GENERIC and CONFIG_KASAN_SW_TAGS
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

On Fri, Nov 23, 2018 at 6:43 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Nov 19, 2018 at 06:26:21PM +0100, Andrey Konovalov wrote:
>> This commit splits the current CONFIG_KASAN config option into two:
>> 1. CONFIG_KASAN_GENERIC, that enables the generic KASAN mode (the one
>>    that exists now);
>> 2. CONFIG_KASAN_SW_TAGS, that enables the software tag-based KASAN mode.
>>
>> The name CONFIG_KASAN_SW_TAGS is chosen as in the future we will have
>> another hardware tag-based KASAN mode, that will rely on hardware memory
>> tagging support in arm64.
>>
>> With CONFIG_KASAN_SW_TAGS enabled, compiler options are changed to
>> instrument kernel files with -fsantize=kernel-hwaddress (except the ones
>> for which KASAN_SANITIZE := n is set).
>>
>> Both CONFIG_KASAN_GENERIC and CONFIG_KASAN_SW_TAGS support both
>> CONFIG_KASAN_INLINE and CONFIG_KASAN_OUTLINE instrumentation modes.
>>
>> This commit also adds empty placeholder (for now) implementation of
>> tag-based KASAN specific hooks inserted by the compiler and adjusts
>> common hooks implementation to compile correctly with each of the
>> config options.
>>
>> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>> ---
>>  arch/arm64/Kconfig                  |  1 +
>>  include/linux/compiler-clang.h      |  5 +-
>>  include/linux/compiler-gcc.h        |  6 ++
>>  include/linux/compiler_attributes.h | 13 ----
>>  include/linux/kasan.h               | 16 +++--
>>  lib/Kconfig.kasan                   | 96 +++++++++++++++++++++++------
>>  mm/kasan/Makefile                   |  6 +-
>>  mm/kasan/generic.c                  |  2 +-
>>  mm/kasan/kasan.h                    |  3 +-
>>  mm/kasan/tags.c                     | 75 ++++++++++++++++++++++
>>  mm/slub.c                           |  2 +-
>>  scripts/Makefile.kasan              | 53 +++++++++-------
>>  12 files changed, 216 insertions(+), 62 deletions(-)
>>  create mode 100644 mm/kasan/tags.c
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 787d7850e064..8b331dcfb48e 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -111,6 +111,7 @@ config ARM64
>>       select HAVE_ARCH_JUMP_LABEL
>>       select HAVE_ARCH_JUMP_LABEL_RELATIVE
>>       select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
>> +     select HAVE_ARCH_KASAN_SW_TAGS if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
>
>> --- a/lib/Kconfig.kasan
>> +++ b/lib/Kconfig.kasan
>> @@ -1,35 +1,95 @@
>> +# This config refers to the generic KASAN mode.
>>  config HAVE_ARCH_KASAN
>>       bool
>>
>> +config HAVE_ARCH_KASAN_SW_TAGS
>> +     bool
>> +
>> +config CC_HAS_KASAN_GENERIC
>> +     def_bool $(cc-option, -fsanitize=kernel-address)
>> +
>> +config CC_HAS_KASAN_SW_TAGS
>> +     def_bool $(cc-option, -fsanitize=kernel-hwaddress)
>
>> +if HAVE_ARCH_KASAN_SW_TAGS
>> +
>> +config KASAN_SW_TAGS
>> +     bool "Software tag-based mode"
>> +     depends on CC_HAS_KASAN_SW_TAGS
>> +     depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
>> +     select SLUB_DEBUG if SLUB
>> +     select CONSTRUCTORS
>> +     select STACKDEPOT
>> +     help
>> +       Enables software tag-based KASAN mode.
>> +       This mode requires Top Byte Ignore support by the CPU and therefore
>> +       is only supported for arm64.
>> +       This mode requires Clang version 7.0.0 or later.
>> +       This mode consumes about 1/16th of available memory at kernel start
>> +       and introduces an overhead of ~20% for the rest of the allocations.
>> +       This mode may potentially introduce problems relating to pointer
>> +       casting and comparison, as it embeds tags into the top byte of each
>> +       pointer.
>> +       For better error detection enable CONFIG_STACKTRACE.
>> +       Currently CONFIG_KASAN_SW_TAGS doesn't work with CONFIG_DEBUG_SLAB
>> +       (the resulting kernel does not boot).
>> +
>> +endif
>
> IIUC as of this patch a user can select KASAN_SW_TAGS...
>
>> +ifdef CONFIG_KASAN_SW_TAGS
>> +
>> +ifdef CONFIG_KASAN_INLINE
>> +    instrumentation_flags := -mllvm -hwasan-mapping-offset=$(KASAN_SHADOW_OFFSET)
>> +else
>> +    instrumentation_flags := -mllvm -hwasan-instrument-with-calls=1
>> +endif
>> +
>> +CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
>> +             -mllvm -hwasan-instrument-stack=0 \
>> +             $(instrumentation_flags)
>> +
>> +endif # CONFIG_KASAN_SW_TAGS
>
> ... and therefore we start using the compiler option, even though we
> haven't introduced all of the necessary infrastructure yet.
>
> That doesn't sound right to me. At the very least, that breaks
> randconfig builds.
>
> What we can do, in-order, is:
>
> 1) introduce the core refactoring, dependent on HAVE_ARCH_KASAN_SW_TAGS
> 2) instroduce the new infrastructure and arch code
> 3) select HAVE_ARCH_KASAN_SW_TAGS
>
> ... such that at (3), all KASAN configurations are known to work.
>
> Thanks,
> Mark.

Will do in v12, thanks!
