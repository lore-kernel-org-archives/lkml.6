Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4326FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9C121569
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMaW8Vug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9C121569
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390953AbeIUXtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:49:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44791 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbeIUXtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:49:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so6296777pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 10:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=udNOJ/bqBgzqSpg5osX8UPWNlb1fRdlvc9pRFOu3yLI=;
        b=EMaW8VuguPBGQ2FECUlV697aGc0aGfVuC9JaJwgBvIpVswPJrXyzFPVMS43ulaATWm
         N/5uW1nH5Xa0/DzQ0JvQ8fy88C0IWgPQ7UuUNjWyLyBZXyx2c2JnW7k5hip3VGUk+vrs
         nihu1E1R79UJ0xUZuH759viOsYO7EFkj59aXt9O7Xkj41fnNDoxaaucU4uc6dLtUCark
         SVNTcEnCaQrmbOZ8LWBIZgc7bCo4cpu32O5MH1n+dG8HqgM+tp5wHb54VRXi9hYd6BQl
         BybEb4p8+mLM8y/0ljneaQFYemaCKAu3gPunqEUbBfZFmlI7QNZIoiNmrzx9HixjHos4
         rrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=udNOJ/bqBgzqSpg5osX8UPWNlb1fRdlvc9pRFOu3yLI=;
        b=jDHdVqAZaVHkiMED2t8LdcrEov8xVLjRShNbSH1beyPiAuXNX2iDpKpRd77mj1Feib
         iE4b/48Rj/sg9ZKSEf/es9VIL4+rqzVEs+fT03zJapYPVZssC1TW7h/JLIayGXUFvWgW
         UZiJG3XEmMXmI/BZmAU9eT8i6yWBGm4lYmKBqdV/N4GhU/4/kcT/6HXHu0Q9Whf1JRaN
         SSs1SGgeRtmLR658NdKYOcRq2rvFX1V8MPXvMzLwvEFwl1qh9LcUCKeD87pnn9jf0Dsx
         vVvvxwNUnOg3RWoaarDQAa1TajUpuAPaKChCLIbOmcV7utkMpGEg0bMe8FUjzHBd7AOR
         BpPA==
X-Gm-Message-State: APzg51A2I+ScziHt2by5CSooDnQ/JbUElwXCtMwnnQDLFrYGVC/k0POe
        uo7NcHVbS//rHQIzeszWRZJrdTitBibF/SCra59JCA==
X-Google-Smtp-Source: ANB0VdYr1MHfygzNZrHqrUetTCeNJ1YYvJF6TfA/b4CRWWMdD1fsnOK9W3LkjOl5ZoldT8S76iKa4fRmaDRF+pU1wvU=
X-Received: by 2002:a63:1921:: with SMTP id z33-v6mr43323702pgl.302.1537552759252;
 Fri, 21 Sep 2018 10:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180921001513.12504-1-Jason@zx2c4.com> <CALCETrULOFr=oQFMVT4qxPTWEQ++G82HCuxRoA=Sr4Z8kmMbYQ@mail.gmail.com>
 <5b94d2f4-eb4a-e00e-5fdf-7f770c26f0da@virtuozzo.com> <CACT4Y+bEf3GQ7zyfFd_PDOW3Cgh0Ot+KbUo4rHij5oSPYPJUNQ@mail.gmail.com>
In-Reply-To: <CACT4Y+bEf3GQ7zyfFd_PDOW3Cgh0Ot+KbUo4rHij5oSPYPJUNQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 21 Sep 2018 10:59:07 -0700
Message-ID: <CAKwvOd=g2cyFa6MF+Zr6Sg5wPticby8BBxWN7_Zb4aKihJ3_Yw@mail.gmail.com>
Subject: Re: [PATCH] framewarn: expand KASAN_EXTRA exception to KASAN
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>, luto@kernel.org,
        Jason@zx2c4.com, Alexander Potapenko <glider@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 2:45 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Sep 21, 2018 at 11:25 AM, Andrey Ryabinin
> <aryabinin@virtuozzo.com> wrote:
> > On 09/21/2018 04:50 AM, Andy Lutomirski wrote:
> >> This patch seems reasonable, but you emailed the wrong people :)
> >>
> >> On Thu, Sep 20, 2018 at 5:15 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >>>
> >>> It turns out that KASAN in general will bloat stack frames in unexpected
> >>> ways, not just KASAN_EXTRA. So, this patch trivially changes that
> >>> default to be associated with KASAN instead of KASAN_EXTRA.
> >>>
> >
> > KASAN_EXTRA bloats stack more than just KASAN, that's why the limit is higher than just for KASAN.
> > If want more details, tead the changelog from commit e7c52b84fb18f08ce49b6067ae6285aca79084a8
> >
> > If anything causes "stack frame > 2048" warning for KASAN we should at least try to fix it,
> > I mean reduce stack usage.
>
>
> +Nick who is also hitting these warnings on clang/arm64 build. As far
> as I understand the situation there is much worse.
>
> I would be good to understand/fix the worst offenders. But the stack
> size increase with KASAN is a real, inherent thing. So if we live very
> close the edge, we can get people using different compilers and/or
> versions of compilers constantly breaking each other. And clang hits
> this warnings in lots of places today just because the current code
> was tailored to gcc over long period, i.e. allowing more locals where
> gcc happened to handle that better and having fewer locals where gcc
> happened to handle it worse. But for another compiler all these
> assumptions are significantly perturbed.
>
> Nick, do you know what frame size limit eliminates the bulk of
> warnings on clang? Is 3072 a reasonable limit allowing to fix the
> remaining outliners?

Here's a plot of the distribution from an arm64 clang build with
allyesconfig minus LSE_ATOMICS, BIG_ENDIAN, and GCOV:
https://github.com/ClangBuiltLinux/linux/issues/39#issuecomment-423621655

A value of 3072 would ignore 79 out of the 128 instances (62%).

Some values are huge outliers.

>
>
> >>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> >>> ---
> >>>  lib/Kconfig.debug | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> >>> index 4966c4fbe7f7..39078a080e29 100644
> >>> --- a/lib/Kconfig.debug
> >>> +++ b/lib/Kconfig.debug
> >>> @@ -222,7 +222,7 @@ config ENABLE_MUST_CHECK
> >>>  config FRAME_WARN
> >>>         int "Warn for stack frames larger than (needs gcc 4.4)"
> >>>         range 0 8192
> >>> -       default 3072 if KASAN_EXTRA
> >>> +       default 3072 if KASAN
> >>>         default 2048 if GCC_PLUGIN_LATENT_ENTROPY
> >>>         default 1280 if (!64BIT && PARISC)
> >>>         default 1024 if (!64BIT && !PARISC)
> >>> --
> >>> 2.19.0



-- 
Thanks,
~Nick Desaulniers
