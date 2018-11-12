Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9289C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D66722504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yovy5vBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D66722504
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbeKMDpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:45:15 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34300 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbeKMDpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:45:15 -0500
Received: by mail-it1-f196.google.com with SMTP id t189-v6so11307233itf.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 09:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Yuhm40KnEZUrSEnNaJTrbWjgjoKtFVH25M0DerGMlzM=;
        b=Yovy5vBWs1xNVc/RIqArOYIKMurvoUM0sompqG5WfXfGNcyjB78EYCwFkBeS51B1lQ
         UsDHXJRIWVlzCbpQ0K8PGJXl0UXteZRbbJBAABO+71dJOrkbdht/EpVUL+KSrT2gE39h
         sveBX/G5FmV/8bjqGnpm9YD6V6VPn0E88ofIiFY2MaRM0ifxR+fXVpg4SnynE9Jx4cH3
         yGFl90KTnwMBbm2TEIm/T0TtiQyoF8jleQlr9PPeGoq3SCRluE327lS8TueWyYlyoj9e
         dRt3FQjTLm5hSAaSwPs/vZImrosRlGNKPsG6dRsMX7+mE6CAxF8jlqWi2SBFAc3qN4qe
         fxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Yuhm40KnEZUrSEnNaJTrbWjgjoKtFVH25M0DerGMlzM=;
        b=XqVK0CiT/j59uioNh3CQ5FAslRQ86FBo413OviIsJ3bGB9S4yS/hWx2dSCcxf1wWJC
         h/ywQ8IDZFRqBkpSkYc9C0P1jOWoCTzw8Qcv/iJK2AVpqd9XnUMVZetkS5WJ2bTnRuij
         CbiSyUW9U1ID1JM+1TZL0Pzzn//dG+Y4gEPxXPbtN7Mx17tXLucATGdbM37Pl2ZtH4h6
         YArnsgyIHa7ezwBNKNhZ28Sd34u/5PV2oUSqENegBfTXYHF4EwWUER1B6pUopBT6bFhY
         Y+U3OkG7RWRtwDqlFj1PI5S5w19AreUR9dzZi0FX4HJC0JC1ukPEQzgXKgqoloevNhIh
         /2Rg==
X-Gm-Message-State: AGRZ1gLfy0mJKxk14e88Zbf6I6NMyRlC8ifkDAIyEVpi/DD+DDaYvG/e
        6kD9czrzfdqRG8GO5aK8FxPzhKKinous0t0NgOSVQw==
X-Google-Smtp-Source: AJdET5ftxzn+UTj+xjMkKi7eZMwljKq/XcFglDQNykDpjKy7LsXHgar9zzUUKX8SOXrvc5qZwz4WjayujyGp0OPXEb4=
X-Received: by 2002:a02:4f88:: with SMTP id r8mr1697508jad.69.1542045058298;
 Mon, 12 Nov 2018 09:50:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:7050:0:0:0:0:0 with HTTP; Mon, 12 Nov 2018 09:50:57
 -0800 (PST)
In-Reply-To: <20181107165438.34kb5ufoe5ve2f6i@lakrids.cambridge.arm.com>
References: <cover.1541525354.git.andreyknvl@google.com> <86d1b17c755d8bfd6e44e6869a16f4a409e7bd06.1541525354.git.andreyknvl@google.com>
 <20181107165438.34kb5ufoe5ve2f6i@lakrids.cambridge.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 12 Nov 2018 18:50:57 +0100
Message-ID: <CAAeHK+zOk9SDzUE38d2dJBE+mbwPwYr2pawV1JYEZFUCmR=ViA@mail.gmail.com>
Subject: Re: [PATCH v10 06/22] kasan, arm64: adjust shadow size for tag-based mode
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

On Wed, Nov 7, 2018 at 5:54 PM, Mark Rutland <mark.rutland@arm.com> wrote:

[...]

>> --- a/arch/arm64/Makefile
>> +++ b/arch/arm64/Makefile
>> @@ -94,7 +94,7 @@ endif
>>  # KASAN_SHADOW_OFFSET = VA_START + (1 << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
>>  #                             - (1 << (64 - KASAN_SHADOW_SCALE_SHIFT))
>>  # in 32-bit arithmetic
>> -KASAN_SHADOW_SCALE_SHIFT := 3
>> +KASAN_SHADOW_SCALE_SHIFT := $(if $(CONFIG_KASAN_SW_TAGS), 4, 3)
>
>
> We could make this something like:
>
> ifeq ($(CONFIG_KASAN_SW_TAGS), y)
> KASAN_SHADOW_SCALE_SHIFT := 4
> else
> KASAN_SHADOW_SCALE_SHIFT := 3
> endif
>
> KBUILD_CFLAGS += -DKASAN_SHADOW_SCALE_SHIFT=$(KASAN_SHADOW_SCALE_SHIFT)

Seems that we need the same for KBUILD_CPPFLAGS and KBUILD_AFLAGS.


>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index b96442960aea..0f1e024a951f 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -74,12 +74,17 @@
>>  #define KERNEL_END        _end
>>
>>  /*
>> - * KASAN requires 1/8th of the kernel virtual address space for the shadow
>> - * region. KASAN can bloat the stack significantly, so double the (minimum)
>> - * stack size when KASAN is in use.
>> + * Generic and tag-based KASAN require 1/8th and 1/16th of the kernel virtual
>> + * address space for the shadow region respectively. They can bloat the stack
>> + * significantly, so double the (minimum) stack size when they are in use.
>>   */
>> -#ifdef CONFIG_KASAN
>> +#ifdef CONFIG_KASAN_GENERIC
>>  #define KASAN_SHADOW_SCALE_SHIFT 3
>> +#endif
>> +#ifdef CONFIG_KASAN_SW_TAGS
>> +#define KASAN_SHADOW_SCALE_SHIFT 4
>> +#endif
>> +#ifdef CONFIG_KASAN
>
> ... and remove the constant entirely here, avoiding duplication.
>
> Maybe factor that into a Makefile.kasan if things are going to get much
> more complicated.

Will do in v11, thanks!
