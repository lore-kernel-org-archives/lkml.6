Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41F0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BF520818
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbHEzpOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfBSKf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:35:26 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40840 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfBSKfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:35:25 -0500
Received: by mail-it1-f194.google.com with SMTP id i2so4965113ite.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 02:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dVMkSZoa7cxW+/Jifvbauk0hPZDlxt4PXjBCgpfObjk=;
        b=pbHEzpOT1QEmqioT1Fkn/FX2RiGs2HlYAujT5f8bjBCHC4Ib/qqAc5/Yq9Na7R3b0o
         6FzbvgB5nOPF+dBVxXq75VySvOXgnYUeKaEqCAmduH4dljDXg9rTCTpS5ZNY1mS8XFDm
         Zp8Ev6udf0TMUBdCm5bsXJgqrhFAEhFmZU2h0LiP+5LC563MfrCi6gbVjUhSuqfN70/M
         vQrYhSZuRBG1Coqdm9GjU5Uk40fR6Lix8fjqObGSM/8Ny9MMVP5Z1dy/pIXg3hvgFOC9
         QnMjb8SPvYVJhgYbD6xfjWLrAgfiADulLFcBYpGIkmhzP7q/aDnLv2HrCT4foOfNOuAh
         lEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVMkSZoa7cxW+/Jifvbauk0hPZDlxt4PXjBCgpfObjk=;
        b=HZqMtwUo1GdeP8o8n9TQX6hQPgYnVpuLvlmpHAv3ObIKTBZDqTtdTJw2XXdzTv4BBd
         eJjod3D1HQ3H7O+kU0gSwd7bZkNoa9EAueDO/U0E6NbbOtb/pxO30yu8D36CqFBHPO4H
         bokaPxNzvDNeiKMSFOBoDHuG7R55mjYvhSsTre9g3lItesJx3Ds6hjZViNPSbPiIMU1Y
         25JQ47vFlyRQLpvPqD8ZiPLUS7cBgKUggK7is4ipY/E471gZFrLI3VWONO+Fu6aDkjX/
         sb6jXDtjY2+fsBbwUtJu/ulScJwX9gQszCggMJTq5DILQ/J7mu7o++BoM/Qdfraj/t3Y
         5yaw==
X-Gm-Message-State: AHQUAuYZVDbKVYlTx+oEFyvfs9I18C2PF0G53eh75obFaqRTgPrTzlRH
        BniStt8DaZUEnqrxj+ao2YsSENYe6/3I3DQZ2yIx+w==
X-Google-Smtp-Source: AHgI3IZsjPFyb46JQZlNBDcdTm96xta98AkxHRRE9ibVq6i+iC9Ai0WHn7eNrHNzxP2R/hPlbCcJCiciqCu2cNiBC1A=
X-Received: by 2002:a24:1947:: with SMTP id b68mr1586794itb.121.1550572524402;
 Tue, 19 Feb 2019 02:35:24 -0800 (PST)
MIME-Version: 1.0
References: <20190215013959.21320-1-natechancellor@gmail.com>
 <20190215185026.GE15084@fuggles.cambridge.arm.com> <CAKv+Gu-=2C4fBPAKNrkeiOsMG0Fg3jHHGuG2rVZvjtT=0-aDkA@mail.gmail.com>
 <CAKwvOd=+_pwHStdhfB3bAYEuyMEjJ+T+gyTd9KA7GyNE2wMk7g@mail.gmail.com>
 <CAKv+Gu-41fhEfJF+pvfCQRqXs4vYPHs77rkJo9=X8Y23QVd6Tw@mail.gmail.com>
 <CAKwvOdke_HbSrmGO5ThNy4o87G4BhA845QcgZFUTB7m6cBHTDg@mail.gmail.com> <CAKv+Gu-Aj68gXoi9CXLyw96iRychWjqX=XtMCQxcZqOv0jhsLw@mail.gmail.com>
In-Reply-To: <CAKv+Gu-Aj68gXoi9CXLyw96iRychWjqX=XtMCQxcZqOv0jhsLw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 19 Feb 2019 11:35:12 +0100
Message-ID: <CAKv+Gu_nwKr65zLG0p0dSW4sQtN4dwEkevCMPe5s9U++SaDezg@mail.gmail.com>
Subject: Re: [PATCH] arm64/neon: Disable -Wincompatible-pointer-types when
 building with Clang
To:     Nick Desaulniers <ndesaulniers@google.com>
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

On Fri, 15 Feb 2019 at 20:45, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Fri, 15 Feb 2019 at 20:43, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Fri, Feb 15, 2019 at 11:28 AM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > >
> > > On Fri, 15 Feb 2019 at 20:25, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > >
> > > > On Fri, Feb 15, 2019 at 11:20 AM Ard Biesheuvel
> > > > <ard.biesheuvel@linaro.org> wrote:
> > > > > Provided that we stop sending Clang enablement patches to -stable:
> > > >
> > > > What does that mean?  We're trying to provide clang support back to
> > > > 4.4 LTS branches. (so 4.4, 4.9, 4.14, 4.19).
> > >
> > > I understand that is what you are attempting, but that does not mean
> > > it /belongs/ in -stable.
> > >
> > > There are rules for stable, and people that track stable kernels (such
> > > as the distros) should be able to rely on us to only backport bug
> > > fixes, not linker script changes and other updates that fix issues
> > > that did not exist when those kernels were released.
> > >
> > > It is unclear to me how these clang changes benefit those users.
> >
> > If you're referring to
> > https://www.spinics.net/lists/stable/msg278381.html, that's fair (I
> > think those were helpful for LLD support on arm64).
> >
> > Why didn't you speak up then?  Why is this coming up now?
>
> That is just one example, and I failed to realise it at the time.
>
> I think the Clang/LLVM work you are doing is very important, but I
> simply don't think any of it belongs in -stable kernels.

OK, to clarify my position:

I have no problem whatsoever with taking this patch into v5.x, so

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

but going forward, I will push back on -stable backports for
Clang/LLVM specific changes, since they are obviously in violation of
the stable kernel rules.
