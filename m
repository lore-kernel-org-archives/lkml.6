Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6645EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C19921B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWCVcY60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfBOTUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:20:34 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:56209 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfBOTUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:20:34 -0500
Received: by mail-it1-f194.google.com with SMTP id z131so16335807itf.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 11:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxXs7EFia3UGZTtea4ysL8T/MI3aFTdEE5T5wxkHCBI=;
        b=tWCVcY60cyW7itYZmBVXL0WEEuAhgyWIhem5mAe5vo8w0VoQ72GvB4TNha9fdBc6tD
         vhDiUfSGfu8xt8UGpTWS7uLApbWyTFkKbcjx+H45vQAi7qDY9L9dTQbPdh1wMrAquWhM
         bZJnUHddIRNi/pzxYN37oc8+nnC8dalJCrCSxzcA7THoVamqniZjkgxHd2pZJZeg+WQp
         TSJPS1XNSk7M6Y0jHIbeO5BWpufjSUqXs7sBlF+LRgwkCIRmwrEECPN4adk/RiEecv3v
         lGu3vBconTY0o88n4fqqsv4AValHHOzlYiBe3FLYA/vzGaM8P38gOSEV0LzHbnIwLp2X
         A+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxXs7EFia3UGZTtea4ysL8T/MI3aFTdEE5T5wxkHCBI=;
        b=FB5Si8S+6vyomITic7vNA9LwgI3jdfIawcpl5iJYs1WOCRVLlfuhn621+7mYNq8t9h
         Pj9aauRamHlQnsrLCgXQYCxcSupUgU6b0DyantQiQs4CK0WULfs8XNY67swyHgUKzstR
         6i7BwfzC8z83D/BykV8yEUcC2l3b6FwlF8gw+Ehp1sfzrdvVKWBccDCzuBMGFCbcvFgm
         6gNi+AFrRhS4FMfQhSeEEKFZeIV4ThXxD7gdsOiWkAHsJ+MAGOg9fN8Xb3C7RCMBhNAI
         WQn8BC/QdQWf2rDgnhEnDyM/BZvxWo3wvPhsBrNcKqzq7iFWweuLhcgB/TT5VJJlp5qe
         GWKA==
X-Gm-Message-State: AHQUAuZhvHlwaspHwQCIWhG2v/H2jUW/NDWFF3AcI8ME0uVArXH8lMkM
        JEiniv89RT5uNiUjSuGZlYIpecGerOAJuGqDpigilg==
X-Google-Smtp-Source: AHgI3Ib5Yd/PiGtDeCLjpSRZuRfr/2nDtW2ops6C+vA23BUArVcG6tIK1TPhQoxSymVeKW3B4t5pJ5cv9Q5TCOr2iSc=
X-Received: by 2002:a5e:d609:: with SMTP id w9mr6440825iom.170.1550258433186;
 Fri, 15 Feb 2019 11:20:33 -0800 (PST)
MIME-Version: 1.0
References: <20190215013959.21320-1-natechancellor@gmail.com> <20190215185026.GE15084@fuggles.cambridge.arm.com>
In-Reply-To: <20190215185026.GE15084@fuggles.cambridge.arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 15 Feb 2019 20:20:22 +0100
Message-ID: <CAKv+Gu-=2C4fBPAKNrkeiOsMG0Fg3jHHGuG2rVZvjtT=0-aDkA@mail.gmail.com>
Subject: Re: [PATCH] arm64/neon: Disable -Wincompatible-pointer-types when
 building with Clang
To:     Will Deacon <will.deacon@arm.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 at 19:50, Will Deacon <will.deacon@arm.com> wrote:
>
> On Thu, Feb 14, 2019 at 06:39:59PM -0700, Nathan Chancellor wrote:
> > After commit cc9f8349cb33 ("arm64: crypto: add NEON accelerated XOR
> > implementation"), Clang builds for arm64 started failing with the
> > following error message.
> >
> > arch/arm64/lib/xor-neon.c:58:28: error: incompatible pointer types
> > assigning to 'const unsigned long *' from 'uint64_t *' (aka 'unsigned
> > long long *') [-Werror,-Wincompatible-pointer-types]
> >                 v3 = veorq_u64(vld1q_u64(dp1 +  6), vld1q_u64(dp2 + 6));
> >                                          ^~~~~~~~
> > /usr/lib/llvm-9/lib/clang/9.0.0/include/arm_neon.h:7538:47: note:
> > expanded from macro 'vld1q_u64'
> >   __ret = (uint64x2_t) __builtin_neon_vld1q_v(__p0, 51); \
> >                                               ^~~~
> >
> > There has been quite a bit of debate and triage that has gone into
> > figuring out what the proper fix is, viewable at the link below, which
> > is still ongoing. Ard suggested disabling this warning with Clang with a
> > pragma so no neon code will have this type of error. While this is not
> > at all an ideal solution, this build error is the only thing preventing
> > KernelCI from having successful arm64 defconfig and allmodconfig builds
> > on linux-next. Getting continuous integration running is more important
> > so new warnings/errors or boot failures can be caught and fixed quickly.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/283
> > Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  arch/arm64/include/asm/neon-intrinsics.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/neon-intrinsics.h b/arch/arm64/include/asm/neon-intrinsics.h
> > index 2ba6c6b9541f..71abfc7612b2 100644
> > --- a/arch/arm64/include/asm/neon-intrinsics.h
> > +++ b/arch/arm64/include/asm/neon-intrinsics.h
> > @@ -36,4 +36,8 @@
> >  #include <arm_neon.h>
> >  #endif
> >
> > +#ifdef CONFIG_CC_IS_CLANG
> > +#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
> > +#endif
>
> I'd like Ard's ack on this one, please.
>

Provided that we stop sending Clang enablement patches to -stable:

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
