Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8F5C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E084720B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWVz58AX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbfAaKB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:01:58 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37952 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfAaKB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:01:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so1845750wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 02:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CDc/1G//BLGGopklIxuWKTJaFf+TxcjGlh453cFYSFk=;
        b=DWVz58AXH3vdiNPpIvICNWCw/ImKQhiGeFpWQkVlZaRepwqnWYTD2QWspOkkGnKdpz
         0c8KHzyrwYek9/LJay/+qYKDhT3uWYspXTnkfpszTCx5rOCUQaCo8dPJsTLM5Pa4T/L/
         YNKrRrutFbJZj1xnOHLBh/O1W0VigxuHZdvqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CDc/1G//BLGGopklIxuWKTJaFf+TxcjGlh453cFYSFk=;
        b=jKkaNd1Ef0h3eZLWbn3mzuG6x2YR99bUdaIYTbZsgzF0eKCvJPAJO021qmolqwoyqv
         aVXZjq1mYX/xr3gqwESd0xVaUdsWY271c8BV4uUE1ysYN/OzDnOrw5zd5Qk/y2nqu/qX
         rewPrHVSdEYLCD4jWHLoOXWuPGXCkzAbc2i4lPYkgOfnpcMtnRDkyIVp2wRnrkx/5ZLE
         j6U0BjVeFXHLSMvwA7ZTayGpS4/Y+b6fK5Jhu2tteHbqQBKCPp74ykRaJi+pByOsohoc
         z1a0btx40k5icVZ/TrnnFs6UMTkuIFQbc8bqEPb1yPAreqDsmdqsf5q+pi3cbvsfO68u
         s0Cg==
X-Gm-Message-State: AJcUukflSiHNyi9E8GBVPxiy6UmuRmc99V78Vo8U/xu3610+xRebXCji
        AXfN7xO3FQQH7vWoxsOGKIRv+g==
X-Google-Smtp-Source: ALg8bN7ZdAF+crje5IcNy+QU1s8G/u5MU/at78CbChuCoCQvMfQWuHBVZMPCjqK8Hln1E6IGWAkQUw==
X-Received: by 2002:a1c:6243:: with SMTP id w64mr28198677wmb.153.1548928915409;
        Thu, 31 Jan 2019 02:01:55 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id k128sm7878891wmd.37.2019.01.31.02.01.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 02:01:54 -0800 (PST)
Date:   Thu, 31 Jan 2019 10:01:53 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH 4/6] mfd: Add support for the MediaTek MT6358 PMIC
Message-ID: <20190131100153.GJ4701@dell>
References: <1548839891-20932-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1548839891-20932-5-git-send-email-hsin-hsiung.wang@mediatek.com>
 <CANdKZ0csqmTFj7+03yRAM25z4jGEQYQvOuSWggDY81spGqhgfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANdKZ0csqmTFj7+03yRAM25z4jGEQYQvOuSWggDY81spGqhgfA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019, Pi-Hsun Shih wrote:

> On Wed, Jan 30, 2019 at 5:19 PM Hsin-Hsiung Wang
> <hsin-hsiung.wang@mediatek.com> wrote:
> >
> > This adds support for the MediaTek MT6358 PMIC. This is a
> > multifunction device with the following sub modules:
> >
> > - Regulator
> > - RTC
> > - Codec
> > - Interrupt
> >
> > It is interfaced to the host controller using SPI interface
> > by a proprietary hardware called PMIC wrapper or pwrap.
> > MT6358 MFD is a child device of the pwrap.
> >
> > Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> > ---
> >  drivers/mfd/Makefile                 |    2 +-
> >  drivers/mfd/mt6358-irq.c             |  236 +++++
> >  drivers/mfd/mt6397-core.c            |   62 +-
> >  include/linux/mfd/mt6358/core.h      |  158 +++
> >  include/linux/mfd/mt6358/registers.h | 1926 ++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/mt6397/core.h      |    3 +
> >  6 files changed, 2385 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/mfd/mt6358-irq.c
> >  create mode 100644 include/linux/mfd/mt6358/core.h
> >  create mode 100644 include/linux/mfd/mt6358/registers.h

[100's (hundreds) of lines of code cut]

> > +static const struct mfd_cell mt6358_devs[] = {
> > +       {
> > +               .name = "mt6358-regulator",
> > +               .of_compatible = "mediatek,mt6358-regulator"
> > +       }, {
> > +               .name = "mt6397-rtc",
> 
> Should this be "mt6358-rtc"?

[1000's (thousands) of lines of code cut]

When replying to a patch, especially one as large as this, you should
cut all of the irrelevant quotes.  Put another way, you should only
quote what you are replying to, and maybe a small section before/after
to keep the context.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
