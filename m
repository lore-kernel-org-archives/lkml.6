Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB70C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0C5222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltk25wYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbfBOTqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:46:05 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52517 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730717AbfBOTqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:46:04 -0500
Received: by mail-it1-f194.google.com with SMTP id r11so26921429itc.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 11:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k/QNZrrA9gIl9m4OOZ50vuvlSP/vFiW92/lwzjJqF4s=;
        b=ltk25wYNpnjzMBazQSK2lfM1LaTef6VP03D5pFSG/02cN9U6Qr+nKBlQuMC62Q52Yv
         u7+KKjGTbK16GCkgRv0IsMc6mDqCILe0ywd5Lmix+D2BP8MuoPLW4r9Af+ytf0vS5QUJ
         JvYZWyQxt/hlSa89YpIvhNEvNrQvM72rXZwSVeIZgus14/QyUzQvW40Rbp3E1NHLzs4Z
         NAvmD1nFUKyxJDLycXxAI32bJVc2EH0/Z15s4d44NJEgbzZMiyjjaBMoVNBBKz6R/oBm
         QzN9a7tLCiKxfcvbVOFAdnEPOvr7e0IXD0qXR0usV5UzzuGhVXLBWAgUtDTUWKMUMDyi
         92aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/QNZrrA9gIl9m4OOZ50vuvlSP/vFiW92/lwzjJqF4s=;
        b=eZ/BduIbKbQ2mGKgsq54wQGOOaSJuu/p49amE+ocp4LA5qnGogvS7Zt3qcp+f7bylS
         GLoe1UdeDH3IoqCQqQeX/MdSlIGDNo4J82WyF79zmMh/Qyxm0fJSlWDt015Eheexvsqx
         OAwcaDg2aIC/c6ae/9bXu0ME3MIF2bdiyVTY/cVfETYkh3b2WMgrc6td2muKz1KniYvo
         /IwdD1+xXIFwgsNe4qZI33P8QXep8GWjhGw9Ql6XEFYPxJDFVUsxLGxndlEBUhV/XKa5
         MuuqC2AGH267a+8kPRnEuERTJrW8vE9GwNAnU5nlajZeWtqD0m4Nx/tEKiAzWd1Zl+G6
         LLTQ==
X-Gm-Message-State: AHQUAuZ1AMtp9U4svZbac/x8+q6q/D+EzHc2jp6cAmNWgJQyy5CD7TL5
        z2ynbwNBlrVkSLMHQQbGG4PO/Rj95ukxRfuy5lMCIw==
X-Google-Smtp-Source: AHgI3IYCTajExcLW690HgFkieyLBYTA9H+LEoLc/rUaVnmNlhBeRQh/G/x6FbgcQS/GAAFANPLxz8PPdB33E039UcM8=
X-Received: by 2002:a6b:6511:: with SMTP id z17mr6781738iob.173.1550259963814;
 Fri, 15 Feb 2019 11:46:03 -0800 (PST)
MIME-Version: 1.0
References: <20190215013959.21320-1-natechancellor@gmail.com>
 <20190215185026.GE15084@fuggles.cambridge.arm.com> <CAKv+Gu-=2C4fBPAKNrkeiOsMG0Fg3jHHGuG2rVZvjtT=0-aDkA@mail.gmail.com>
 <CAKwvOd=+_pwHStdhfB3bAYEuyMEjJ+T+gyTd9KA7GyNE2wMk7g@mail.gmail.com>
 <CAKv+Gu-41fhEfJF+pvfCQRqXs4vYPHs77rkJo9=X8Y23QVd6Tw@mail.gmail.com> <CAKwvOdke_HbSrmGO5ThNy4o87G4BhA845QcgZFUTB7m6cBHTDg@mail.gmail.com>
In-Reply-To: <CAKwvOdke_HbSrmGO5ThNy4o87G4BhA845QcgZFUTB7m6cBHTDg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 15 Feb 2019 20:45:52 +0100
Message-ID: <CAKv+Gu-Aj68gXoi9CXLyw96iRychWjqX=XtMCQxcZqOv0jhsLw@mail.gmail.com>
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

On Fri, 15 Feb 2019 at 20:43, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Fri, Feb 15, 2019 at 11:28 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Fri, 15 Feb 2019 at 20:25, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > On Fri, Feb 15, 2019 at 11:20 AM Ard Biesheuvel
> > > <ard.biesheuvel@linaro.org> wrote:
> > > > Provided that we stop sending Clang enablement patches to -stable:
> > >
> > > What does that mean?  We're trying to provide clang support back to
> > > 4.4 LTS branches. (so 4.4, 4.9, 4.14, 4.19).
> >
> > I understand that is what you are attempting, but that does not mean
> > it /belongs/ in -stable.
> >
> > There are rules for stable, and people that track stable kernels (such
> > as the distros) should be able to rely on us to only backport bug
> > fixes, not linker script changes and other updates that fix issues
> > that did not exist when those kernels were released.
> >
> > It is unclear to me how these clang changes benefit those users.
>
> If you're referring to
> https://www.spinics.net/lists/stable/msg278381.html, that's fair (I
> think those were helpful for LLD support on arm64).
>
> Why didn't you speak up then?  Why is this coming up now?

That is just one example, and I failed to realise it at the time.

I think the Clang/LLVM work you are doing is very important, but I
simply don't think any of it belongs in -stable kernels.
