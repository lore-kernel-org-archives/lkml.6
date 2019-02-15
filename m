Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CA8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DD5222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QzvX1RWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbfBOTns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:43:48 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36693 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbfBOTns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:43:48 -0500
Received: by mail-pf1-f195.google.com with SMTP id n22so5311630pfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 11:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y4VPsTrJhCPr2tzOP/3m8FNofgdnkZWBfxUguKvGXlM=;
        b=QzvX1RWw9heSyUOtT0WxbJsmldDKqwlIHz3A8ysKJmSHlq2iXCky42aP+4GWBuDSjB
         mWq+0p+YKSdliN45F+MjF8L4RCmBgeQ5oRHsm7/oIeX4jAsjQpAkuegFBgNmMEa87Q4u
         +c9oXNTSpmEyUoyKxqENKbk3JfNotpTt+v1HFx47ZbnDos1XF2xxA0LDiPK/zGwponDf
         C7UX0jlnrXpHFavbZDjmYbkA0LygOEmfgY95doaQFKtZWtlTKA/RfwnjuQecOJAljHqt
         NHWTSDK3/ZUtF/RUV/vc3JzxCMG8ek213J/JCSXyOET2TIb8G2YbL3r33sdS+i6mYI6Z
         WQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4VPsTrJhCPr2tzOP/3m8FNofgdnkZWBfxUguKvGXlM=;
        b=Q34Do5ZH5jRFyntqv8qFu+ihJNm2YXEo/HoJajf3W+CJX5KPfzzGWrQ0UXGKK37abD
         x3A0vNxqs08dwjhtsz/wLqc5sW/Buipof9rTwtJcAo4mjsnl4rgtrTyEFyGkhjEuPNH0
         ms5rUFlPdivlfYDL7bbPBQ3rRiyK9nR0rb5B2S3kkoZ8AvheTY1ZYlMqnjvtq7qjXe1t
         GpVS/M0CQUTXNYsJhyC//55zWkPu0u97qVCDIPsENFNDNdS3QHMYxqnTBC7diHa/R1WX
         /cCEWdKUYjADTVlmyOJw++vT4UkcEcJ3RLbnDIpYzJXpfeZ6B1sqeT6l5UALlh3E8eV4
         Aj6w==
X-Gm-Message-State: AHQUAuZ7mjeXsYa6iBXHlpUAOp+m9/+Ru9gEhSTFXIuSfZ214FVj1dTT
        Z6o23IIFLM5dAXlhBd7RmZ2Ut2HlvbrGFtjNXBSaDQ==
X-Google-Smtp-Source: AHgI3IbiD8IbyZkLXJGGUqvXDzuWynNdDEh3ZDH7uR5ag4CwtC0t1hWcoJC+/zhlHoF+on1bKqTegSqCpQyA4wLRPWk=
X-Received: by 2002:a62:e704:: with SMTP id s4mr11361704pfh.94.1550259826624;
 Fri, 15 Feb 2019 11:43:46 -0800 (PST)
MIME-Version: 1.0
References: <20190215013959.21320-1-natechancellor@gmail.com>
 <20190215185026.GE15084@fuggles.cambridge.arm.com> <CAKv+Gu-=2C4fBPAKNrkeiOsMG0Fg3jHHGuG2rVZvjtT=0-aDkA@mail.gmail.com>
 <CAKwvOd=+_pwHStdhfB3bAYEuyMEjJ+T+gyTd9KA7GyNE2wMk7g@mail.gmail.com> <CAKv+Gu-41fhEfJF+pvfCQRqXs4vYPHs77rkJo9=X8Y23QVd6Tw@mail.gmail.com>
In-Reply-To: <CAKv+Gu-41fhEfJF+pvfCQRqXs4vYPHs77rkJo9=X8Y23QVd6Tw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Feb 2019 11:43:35 -0800
Message-ID: <CAKwvOdke_HbSrmGO5ThNy4o87G4BhA845QcgZFUTB7m6cBHTDg@mail.gmail.com>
Subject: Re: [PATCH] arm64/neon: Disable -Wincompatible-pointer-types when
 building with Clang
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Sandeep Patil <sspatil@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 11:28 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Fri, 15 Feb 2019 at 20:25, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Fri, Feb 15, 2019 at 11:20 AM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > > Provided that we stop sending Clang enablement patches to -stable:
> >
> > What does that mean?  We're trying to provide clang support back to
> > 4.4 LTS branches. (so 4.4, 4.9, 4.14, 4.19).
>
> I understand that is what you are attempting, but that does not mean
> it /belongs/ in -stable.
>
> There are rules for stable, and people that track stable kernels (such
> as the distros) should be able to rely on us to only backport bug
> fixes, not linker script changes and other updates that fix issues
> that did not exist when those kernels were released.
>
> It is unclear to me how these clang changes benefit those users.

If you're referring to
https://www.spinics.net/lists/stable/msg278381.html, that's fair (I
think those were helpful for LLD support on arm64).

Why didn't you speak up then?  Why is this coming up now?
-- 
Thanks,
~Nick Desaulniers
