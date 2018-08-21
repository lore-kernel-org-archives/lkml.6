Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC01C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B71120837
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cZwAsAuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B71120837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeHUUfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:35:42 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:36307 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeHUUfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:35:42 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w7LHEWXJ010878
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:14:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w7LHEWXJ010878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534871673;
        bh=MDvsiiJ9XaLqAljq0qyR++mP3TkgV+0DPh+aeblEEEQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=cZwAsAuclnNIR/uV4H9dMXTVA7u03NSA0AwN40vDlARNkGisVS4xDmLEblP4G3KCa
         vocNQ4Gwvb6dY929i0vLLBCdM56qQvIi5JebKA8wXO8pE4YaQ3luP9YXeZAKl93M2d
         OECIcoFol15qmLXChVT6UzBEQv3wYhQRXCMF2r3lQo1t68b1zm/cQvAXHi97a5+gwe
         cphfuIOFIzHZs/hembxfYiHawxRPpEWM8Y5iDel6bwIjWHLxN5RclepH2+LNKWy84u
         0wCwORw8pobcKULrLNFcBchAWxaPP5KjKdNfa9tVfQ9gR3k2vwgaCbYhYswO9tpKBa
         a/Iilsstmy+hA==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id m13-v6so12282603uaq.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:14:32 -0700 (PDT)
X-Gm-Message-State: AOUpUlGRbVywPEfHp5OHkr1ctOJ8a4HdyK96dlLcwkioW2AeMCD+euxQ
        F+LmYx861sqRdFfJkHvB0ZK7AylEM2UJq15xZ9Y=
X-Google-Smtp-Source: AA+uWPzwgK05Y7uFV85zSIJCjUIJvsWbY7F9Aui7MUEPiTW/wiJ8klNME7R89z9AdJcbDjcZPqxAhJxrQ2ZEbPQE8NI=
X-Received: by 2002:ab0:6a6:: with SMTP id g35-v6mr34042715uag.16.1534871671562;
 Tue, 21 Aug 2018 10:14:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 10:13:51
 -0700 (PDT)
In-Reply-To: <7bbf0a3c97f817c81df2316fca0ec88d5a6b4302.camel@perches.com>
References: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com> <7bbf0a3c97f817c81df2316fca0ec88d5a6b4302.camel@perches.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 22 Aug 2018 02:13:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT39aFpgs0iAudYwpA4x6+B_8WZ0ftQ2Mff3-cTOd3Diw@mail.gmail.com>
Message-ID: <CAK7LNAT39aFpgs0iAudYwpA4x6+B_8WZ0ftQ2Mff3-cTOd3Diw@mail.gmail.com>
Subject: Re: [PATCH] compiler-gcc: get back Clang build
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,


2018-08-21 19:39 GMT+09:00 Joe Perches <joe@perches.com>:
> On Tue, 2018-08-21 at 15:48 +0900, Masahiro Yamada wrote:
>> Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
>> missed the fact that <linux/compiler-gcc.h> is included by Clang
>> as well as by GCC.
>>
>> Clang actually defines __GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__
>> and it looks like GCC 4.2.1.
>>
>>   $ scripts/gcc-version.sh -p clang
>>   040201
>
> Perhaps this would work, but I can't test it as
> my clang version doesn't otherwise build a defconfig
> and errors out with
>
> $ make CC=clang
> arch/x86/Makefile:179: *** Compiler lacks asm-goto support..  Stop.
>
> ---
>  include/linux/compiler-gcc.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 3e70b7d4e9ed..3a06ad823fa4 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -3,6 +3,23 @@
>  #error "Please don't include <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
>  #endif
>
> +/*
> + * Override clang compiler version #defines
> + *
> + * compiler_types.h always #includes compiler-gcc.h before compiler-clang,h
> + * but clang sets these __GNUC version #defines to 4.2.1.
> + * This breaks the gcc minimum version of 4.6.0, so override the clang
> + * definitions to 4.6.0
> + */
> +#ifdef __clang__
> +    #undef __GNUC__
> +    #undef __GNUC_MINOR__
> +    #undef __GNUC_PATCHLEVEL__
> +    #define __GNUC__ 4
> +    #define __GNUC_MINOR__ 6
> +    #define __GNUC_PATCHLEVEL__ 0
> +#endif
> +
>

This patch does not work.

It only addresses the
"# error Sorry, your compiler is too old - please upgrade it." part.


Attributes unsupported by Clang
must be ifdef'ed  out.

Otherwise, you will see lots of unknown attribute warnings.

-- 
Best Regards
Masahiro Yamada
