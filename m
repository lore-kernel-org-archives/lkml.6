Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CE5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2592621850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5UP1RTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfBZUo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:44:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33309 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfBZUo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:44:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id y10so6816605plp.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 12:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0X8cSYKGmFW0u9F0JjUTNH83/4979FA9fPZEq9ViBiY=;
        b=G5UP1RTLPOXQAR+BvC3a+DybgKcQ6vRPqihPWCSDwt6QQecjUSMXeDyXQ8pdYEBWV6
         kSKe2u73y5ysD5TfJ31iUQBIbngmTJfV3E+/a6yDHVKWBsZ9lOnZH5r+DGh7Oeczfag6
         vXsSyH7DuzTJz1rCShkBQ0G9Vmy70IEpLa9Ls/lyYotXZm8QMpuSiKI18XDjdBB9D0Cq
         BEGrBJHo7kNwc/PlioQ1ZN2XBdDjKzuTdRFMPsQNcRGS9EX3cqX2BV7iL93jN/XwV/TS
         C+t/jLVEjQM2BF5KDPbTlwt5CIu9u6EzhdjQ2Bwyf3fNwlcxmvG3dfIwWPxzbfueB4zT
         IGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0X8cSYKGmFW0u9F0JjUTNH83/4979FA9fPZEq9ViBiY=;
        b=bvrFrtQOhr/HjeNPvrtOvV2d7bUbLmcd5UXKccfHUjXcPboozlSsJ920V8bwGEeOHR
         1bt8pBvcMv3ALBwds3JxHDlecfj+i0IVFjlS4XlrJ7ecnx/USia9ckxUj2x+y9zUTr9I
         IdD7VEnqTyoQzzd75sZqsODqJpeIDHzKk2bchILUCO1rgA3+EULQbn8i0t/ONrTl2CNp
         DFhWTvi4/F2dBtZx+Q2leB6ErYk9cTsIKWtDAAchJSoMsk4uDwd7wLx7G6pz4ljFssyP
         lyu08f9g4rjGrwW1P1njKXqeMjR13Gu7h6EWVZT+IeS6CPxZz+5paWQcxd6xABIBYR9G
         AbSw==
X-Gm-Message-State: AHQUAuazClFjbQ50USCILeKhMn7NH2j/XZeCvpg5JgYrEqEDEwUqhcwt
        cHYa8gOxhoSZyqQDcRlZ5ZG00VbC1pWGh9OpHe9Y3Q==
X-Google-Smtp-Source: AHgI3Ib3KLull6qPH/TbFZUvMpO7HReopqC+gm/Txs9vUuqy65YewyPIeJ9h1evXEkY7vAgEDPJZfaUFk9kk2kqPe3A=
X-Received: by 2002:a17:902:bb89:: with SMTP id m9mr27853522pls.320.1551213895133;
 Tue, 26 Feb 2019 12:44:55 -0800 (PST)
MIME-Version: 1.0
References: <20190226040345.202047-1-ndesaulniers@google.com> <CAKv+Gu-5DvWZL6ogLVNDEvgKe6TENX+5sF1U7QxiyYC8Wx0nXw@mail.gmail.com>
In-Reply-To: <CAKv+Gu-5DvWZL6ogLVNDEvgKe6TENX+5sF1U7QxiyYC8Wx0nXw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 26 Feb 2019 12:44:44 -0800
Message-ID: <CAKwvOdmzb1WF6NU5LYWGXK_O2cbqwMjbWGAa5xk5x+EMz7A1yw@mail.gmail.com>
Subject: Re: [PATCH] lib/raid6: use vdupq_n_u8 to avoid endianness warnings
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 11:19 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Tue, 26 Feb 2019 at 05:03, <ndesaulniers@google.com> wrote:
> >
> > Clang warns: vector initializers are not compatible with NEON intrinsics
> > in big endian mode [-Wnonportable-vector-initialization]
> >
> > While this is usually the case, it's not an issue for this case since
> > we're initializing the uint8x16_t (16x uint8_t's) with the same value.
> >
> > Instead, use vdupq_n_u8 which both compilers lower into a single movi
> > instruction: https://godbolt.org/z/vBrgzt
> >
> > This avoids the static storage for a constant value.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/214
> > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Much better, thanks,
>
> Did you double check that the intrinsic exists on 32-bit ARM as well?
> I assume it does, but please make sure if you haven't yet.

Thanks for the review!
Looking through Clang's generated arm_neon.h, vdupq_n_u8 seems to have
2 definitions predicated on __LITTLE_ENDIAN__ (not __arch64__ or
__ARM_ARCH >= 8 like some of the other types and functions).

So NEON got some additions in v8?  Is there a doc that lists them?
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0491g/BABDBBJB.html
is where I found vdupq_n_u8, but it doesn't seem to mention
compatibility (so I assume it's been around since the introduction of
NEON?).
-- 
Thanks,
~Nick Desaulniers
