Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B966C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA9220685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TvU7YJv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfAITJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:09:11 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41861 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfAITJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:09:11 -0500
Received: by mail-io1-f68.google.com with SMTP id s22so6889324ioc.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 11:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXZT4VHugkGKeRGT88/HaZwrBVVB394UI+pwQ6ZW+10=;
        b=TvU7YJv6x29/i+OJ0dQazYCO2iAP5BlCDpHNlVQRVV9MVuPxk9glN8i6XB6rXwEy8v
         EYHp7R6LnmmWUvLRY+Xlr5DtTGdfXiPo3svTWtK4/woWin24l7UEF/fQ1kvg6yKevzqf
         X7unrBjK32rfUEDPBnTrDfxTq4006yKtLxJ94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXZT4VHugkGKeRGT88/HaZwrBVVB394UI+pwQ6ZW+10=;
        b=Hn7AYR9z2JBf/oJMqv/izsq/6pA7XsT5RMjc0dTNHkDCI0esFssXGvxGP5Ji51MtYk
         d43zlpm2/ztSMDndfmtijw1uujAdQSK1OaE/o7/7ZWVsSyR2+RpPTfYn97FcOOQBtBRV
         XsqnwOQiivRk3txoFxthzY0CoY8zpgp/NlrgfbfhjXE0MwhnmNhNdOmIAuL26web30Xs
         nNZyGcE1QtPyEGgm6jBubASmHtoqZ/ZibKTV2X58DPVv0Gg1VSKAgiPVi8qmirOi/hkn
         7zvzqMQ/N8+JxRRjeXvM8HxoWPqdL+LFxGcu+RzEN7k0uUQxTdSGqG1KMd9KhaUOjVVN
         rS7g==
X-Gm-Message-State: AJcUuke0ADWCNJECIj6y6OUFGLh1N9RiG25oKPt29a/5X9CPkW5POLg8
        QHRy+5FH43Bdo8ZyXqQXMDXe8N+WRyt3Qt2Z/cuX0A==
X-Google-Smtp-Source: ALg8bN43NhDbxulZIkooIMEKFGCsP95uM/1+OrSso0V2jCiqcXt+OWR3aZKm/z26g+/bqd7EwK5n7PClknSDAqd504Y=
X-Received: by 2002:a6b:c8c9:: with SMTP id y192mr4398413iof.183.1547060950226;
 Wed, 09 Jan 2019 11:09:10 -0800 (PST)
MIME-Version: 1.0
References: <1547056892-16527-1-git-send-email-vincent.guittot@linaro.org> <CACRpkdbA8cvoaG_5=JCrpQd2k1HYRxUjqGsoGJLLvroGGQukkA@mail.gmail.com>
In-Reply-To: <CACRpkdbA8cvoaG_5=JCrpQd2k1HYRxUjqGsoGJLLvroGGQukkA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 9 Jan 2019 20:08:59 +0100
Message-ID: <CAKfTPtAaVXjm8sf1o=4yfRt_pyVU0T7H8jOatm6EreYVNoWj+w@mail.gmail.com>
Subject: Re: [PATCH] arm64/hisilicon: fix SDcard detection
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Xu Wei <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019 at 19:28, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Vincent!
>
> On Wed, Jan 9, 2019 at 7:01 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
>
> > commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> > has changed how cd_gpios phandle and cd-inverted are used to set gpio's flags.
> >
> > Since this change, hikey960 SDcard is not detected anymore because flags
> > are not set correctly. Updating cd-gpios to set GPIO_ACTIVE_LOW instead
> > of high, fixes the problem.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Please check if this patch fixes your problem:
> https://marc.info/?l=linux-mmc&m=154637189021211&w=2

This fix the problem

>
> > --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> > +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> > @@ -582,7 +582,7 @@
> >         sd-uhs-sdr104;
> >         disable-wp;
> >         cd-inverted;
> > -       cd-gpios = <&gpio25 3 0>;
> > +       cd-gpios = <&gpio25 3 GPIO_ACTIVE_LOW>;
>
> This is also a good change, but the old device tree should
> continue to work so we need to fix the real bug.
>
> If you also remove "cd-inverted" above, this patch should
> hopefully still work and be fine to apply as well.

ok. I'm going to send an update

>
> Yours,
> Linus Walleij
