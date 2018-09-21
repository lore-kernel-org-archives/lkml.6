Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2924ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3B02086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxBfDIfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3B02086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389612AbeIUPn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:43:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55413 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeIUPn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:43:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id f21-v6so2384506wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 02:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a9guB2UTD52C96OBaJsMuP5b9WKxupKoHmvi6wmWUYo=;
        b=RxBfDIfolVJVRJAjSQH1iDPfMssBJWhPG/6snGhLq48kaD3gfpalWFNoO07RtHAIN0
         jCJjsSsGQ+cb1lRkXfRHXXghUAFgCfpSe4Xr6p/mZa37p84fa+kjXUtEuVjMHSWEYVA4
         gPw6jtCXwZFeEOYfCeTePWJ7WqUDC6DAgGSuHCIhvmwq64uJqFLd4rwr2VU49PmtUW+K
         9S45e8FdmJvVsAc30m4HHmVLRdIeXn9gXdgLiPEz0LvfGGubQY81TttOJW4Sk7YBnuTn
         IFliAGxPQAGQ35mjPI82EX5OMVYfgqKAGIrqYz3LGigPdVvgJSwysj1fOj2AVLCTFR6n
         yFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a9guB2UTD52C96OBaJsMuP5b9WKxupKoHmvi6wmWUYo=;
        b=f3zHjabBpJQkm2SbWdl1uSSqnkFJsUmhgcILeEO7KZKRlJODPRSYC4hM39Y8xMB2oe
         ozRewNPeuHmLKrKXHZTnFF9jhr61J76eQOsMBsYVTwBIS8woDtiMVD0AhI5ecyxPWSzk
         vrd53zlAw1Ng8VILvJa9DNQtQ7NUkFsJ0awssrvXr6ODWqllx5BASM26JfY+++2Po+aS
         UUxOfj/wGbzqj6t4/4Z1fHwllFLf+qsjbqhy8LHZjwPD+PF/q6DprEChhLhYxRZ/42TO
         6ZqIeEpCal2NEcgrfUutnJCo0lwOF8IekBgl99tL6edmGJil9DN2gbUdBsWtt0iDdstN
         oPcw==
X-Gm-Message-State: APzg51APO44Jf0XTe+JnGEmqnhDUo38IhkTDpGTrJF0di2igC+rCG1uw
        7xKNYjjk8+6Ukw5cIW/ZOlk=
X-Google-Smtp-Source: ANB0VdamMjkSoCkQfJhpRtYcJHq6XL9m5urBzPaOkIaHP9lAh+bBRYpeuNvStEZXvu2s2wpm6kzxcg==
X-Received: by 2002:a1c:8406:: with SMTP id g6-v6mr6082548wmd.18.1537523719195;
        Fri, 21 Sep 2018 02:55:19 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id j75-v6sm7485506wmj.8.2018.09.21.02.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 02:55:18 -0700 (PDT)
Date:   Fri, 21 Sep 2018 02:55:16 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexander Potapenko <glider@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] framewarn: expand KASAN_EXTRA exception to KASAN
Message-ID: <20180921095516.GA17326@flashbox>
References: <20180921001513.12504-1-Jason@zx2c4.com>
 <CALCETrULOFr=oQFMVT4qxPTWEQ++G82HCuxRoA=Sr4Z8kmMbYQ@mail.gmail.com>
 <5b94d2f4-eb4a-e00e-5fdf-7f770c26f0da@virtuozzo.com>
 <CACT4Y+bEf3GQ7zyfFd_PDOW3Cgh0Ot+KbUo4rHij5oSPYPJUNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bEf3GQ7zyfFd_PDOW3Cgh0Ot+KbUo4rHij5oSPYPJUNQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 11:45:07AM +0200, Dmitry Vyukov wrote:
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
> 

Hi Dmitry,

I know I'm not Nick and I hope I am not butting in but I've been
following this thread due to these warnings cropping up in Clang.
We've been tracking them on GitHub and judging from the values
there, I would argue that 3072 is a good starting value.

Link: https://github.com/ClangBuiltLinux/linux/issues/39

Cheers,
Nathan

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
