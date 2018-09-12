Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49D1C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5229120866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asoBjp8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5229120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeILJWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 05:22:06 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36882 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725737AbeILJWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 05:22:06 -0400
Received: by mail-qt0-f194.google.com with SMTP id n6-v6so569576qtl.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 21:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T7GeEr43YbtSGx67w8rL7Oth9A/SWaWTbgP3UxdVuAU=;
        b=asoBjp8QMoyY6jvcE5naBqH169o7hy00hFcdHqISG5DJLInnahy6+uWQrGbn9sCu8a
         cJxjoBB6bqML9+KxXVa00UUN0kW3zvWWNV/rqvEI/OfVom86K9+Hz7vtElz56O+BwmiS
         Qx2KGSO7p5qAseSUtEY6j7eXtO21a47qZD7tzqB+GL/IZT9NsGyx1zYd5HLzy9Sev1L0
         AX++rMfyZxUDf0YLPzr8cZ08nubnl3HmjOG0WXA9j9XC6gyXcuyXukHsBsbKKthPxCLG
         rZKq/E5KKStiK3Dqbt5v0sJdUjAt3pf1aRXZ8PrZOsjZiRNrnFpuryA1pknBc2Q3tKEA
         s5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T7GeEr43YbtSGx67w8rL7Oth9A/SWaWTbgP3UxdVuAU=;
        b=UiMaPH88gDtFlz0qra+LTgZj0EcnTJRPy0Bye5ZEjw3xL0uqbVk0ee+OIeZoZBjc4v
         LdSFkK3I8ImGZ3bgbZvWZK4i53ZfK5nt6KnSz0mdlNBkK9rAUkhWQwrDSQiw7OTpcEnQ
         jxaLrdZzStBNa8ikCCIr1QtRxx53Rhm9Wv2JAzYeWyKc2J+P5u1Wd4Cf1keVxmXKN+IT
         SJN66AYB5WWQJ/7WkXn2Jn5vkqJHDT88FWTHlQFPhJCixGus+1DKlyUuSmhPM6oIRzvY
         joM8dQABGgBLUsGdqPU6D74vM9IH508h0KjtgPo2LSyuOfMY5etmy/NU6VDUcxewLXUg
         4XIw==
X-Gm-Message-State: APzg51CEKpfSsJv7FSDAs7OP84hdVePymkMfbA/LWNV8Ct56c8of5j7R
        NyfEIjnfAMIShi5AbncsYDfYgFy2D0/OqSvKROU=
X-Google-Smtp-Source: ANB0VdZ770/DeK/kOoKGYqDJ958prxXCPrbWHLPdFpv5n7t89Zn+wfCUPwP6UwbsdRrc0El3LThWe5mKb34Ilw8cQEo=
X-Received: by 2002:ac8:304a:: with SMTP id g10-v6mr10526qte.136.1536725969248;
 Tue, 11 Sep 2018 21:19:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 21:19:08
 -0700 (PDT)
In-Reply-To: <CAK8P3a2cc741UqFSk+hXpC2s4S+A+0FuiM1yP=Z4rC18sJHq9g@mail.gmail.com>
References: <20180910060455.20409-1-stefan@agner.ch> <CAK8P3a2cc741UqFSk+hXpC2s4S+A+0FuiM1yP=Z4rC18sJHq9g@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 12 Sep 2018 06:19:08 +0200
Message-ID: <CANiq72mGH3KW+FxVDF0PcAeaTCtnNz_oO=2-u4zZQ9kvbRDCtA@mail.gmail.com>
Subject: Re: [PATCH] include/linux/compiler-clang.h: define __naked
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stefan Agner <stefan@agner.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Will Deacon <will.deacon@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paul Lawrence <paullawrence@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Nick, Stefan,

On Mon, Sep 10, 2018 at 2:14 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Sep 10, 2018 at 8:05 AM Stefan Agner <stefan@agner.ch> wrote:
>>
>> ARM32 arch code uses the __naked attribute. This has previously been
>> defined in include/linux/compiler-gcc.h, which is no longer included
>> for Clang. Define __naked for Clang. Conservatively add all attributes
>> previously used (and supported by Clang).
>>
>> This fixes compile errors when building ARM32 using Clang:
>>   arch/arm/mach-exynos/mcpm-exynos.c:193:13: error: variable has incomplete type 'void'
>>   static void __naked exynos_pm_power_up_setup(unsigned int affinity_level)
>>               ^
>>
>> Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>
>> +/*
>> + * ARM32 is currently the only user of __naked supported by Clang. Follow
>> + * gcc: Do not trace naked functions and make sure they don't get inlined.
>> + */
>> +#define __naked __attribute__((naked)) noinline notrace
>> +
>
> Please see patches 5 and 6 of the series that Miguel posted:
>
> https://lore.kernel.org/lkml/20180908212459.19736-6-miguel.ojeda.sandonis@gmail.com/
>
> I suppose we want the patch to fix clang build as soon as possible though,
> and follow up with the cleanup for the next merge window, right?

Not sure what the plans of Linus et. al. are, if they have any; but
that would be a safe bet.

In case they want to speed this up and put the entire series into
v4.19 (instead of the two patches), I have done a binary & objdump
diff between -rc2 and v4 (based on -rc2) on all object files (with
UTS_RELEASE fixed to avoid some differences).

In a x86_64 tinyconfig with gcc 7.3, the differences I found are:

$ ./compare.py linux-rc2 linux-v4
[2018-09-12 06:16:39,483] [INFO] [arch/x86/boot/compressed/piggy.o]
Binary diff (use 'bash -c "cmp
linux-rc2/arch/x86/boot/compressed/piggy.o
linux-v4/arch/x86/boot/compressed/piggy.o"' to replicate)
[2018-09-12 06:16:39,606] [INFO] [arch/x86/boot/header.o] Binary diff
(use 'bash -c "cmp linux-rc2/arch/x86/boot/header.o
linux-v4/arch/x86/boot/header.o"' to replicate)
[2018-09-12 06:16:39,659] [INFO] [arch/x86/boot/version.o] Binary diff
(use 'bash -c "cmp linux-rc2/arch/x86/boot/version.o
linux-v4/arch/x86/boot/version.o"' to replicate)
[2018-09-12 06:16:40,483] [INFO] [init/version.o] Binary diff (use
'bash -c "cmp linux-rc2/init/version.o linux-v4/init/version.o"' to
replicate)

I will do a bigger one tomorrow or so and see if there are any
important differences. Regardless of what we do, I will send the
__naked patches separately as well (requested by Nick on GitHub).

Cheers,
Miguel
