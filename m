Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75647C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D4721523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzbGPAlc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D4721523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389835AbeIUSUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:20:01 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44488 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389022AbeIUSUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:20:01 -0400
Received: by mail-oi0-f66.google.com with SMTP id l82-v6so11215587oih.11;
        Fri, 21 Sep 2018 05:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dGTtAJW1c8ZFlOQ31tLc33z2ohlpE7W2K1VJMCg81DA=;
        b=NzbGPAlc5fTpcN5pkKk3yj3BTvQlsW1w/2gvKr1DuXvg/xJJmWQjWunln2gfTcu0LS
         s3bMhS40kNEco9USoUeefxFvTqUv1ngcwZoPcsqWVFB6GAnjjnbUV7KI7bAbIGtgDTIe
         nVNMlkz/XryHh1GiNtU6ju3MO1U/gakCH3xZTfCRSSVT5gZARyCO731nRD2Exhwkz+kb
         nWLfhvMKZoHNeC39GsxFm/xpp4JmA5A2LFpmUKVNEWn1+2NZQxX0F/R27X7mM7sylq2k
         FS8WBTKdN7cV0E+L8Y1UPWI7oxXNrMDIzHV1OU2/X4AVp5edloGvmz5mTCHTGaCY8ptw
         YYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGTtAJW1c8ZFlOQ31tLc33z2ohlpE7W2K1VJMCg81DA=;
        b=OPlQjnyPViNsgRQmd+PooYcw6PNeMHs12yt9R101HDW7zkqJ6GDtGjS19kUSD/Sth2
         JbUJy8YF+BJOrNZHtjyxk/z8Y8rQohhCRXiCAwMXNQrhFqwx6hhxiXvABl5KWBxOTNeP
         HpIlDcmTLE9cEqoNNGGLs7ZfGKqf3jxY/gAO/MDe/S9BVfPgA0qg/hpfoP0sVyZKJhyP
         WPELtA4lQyuPxYNBm0GXLn2yBsGq7VauHIEDykrWkSgMkB+VgeicOvABWWpGg3pW8Bn2
         Gfsqu8bgjpG6vGuLBQiZIPv/H3ip72Wh55hBiuuthcY2Kv4wxH+aMF4+K9Sz8VAzfoos
         Ak8A==
X-Gm-Message-State: APzg51AJyTEGQbizYmCexG6htHf9AH0iizN/mIWtRbpXtMuTGaPBNKcK
        YMsEkPs1IJMT2uBN3+RxJqsHiHVyrIPI9/EzGuE=
X-Google-Smtp-Source: ANB0VdaEHZjnGP2DNjWcpJXvhplMGrEdGjssHj3lpUQ+gf4OJ8bbGhVP+wHbYWT8xrryAgRsBGPxG+jteWP8vf3yA/c=
X-Received: by 2002:aca:5043:: with SMTP id e64-v6mr1385317oib.111.1537533080644;
 Fri, 21 Sep 2018 05:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180920175826.1284-1-linux.amoon@gmail.com> <20180920175826.1284-6-linux.amoon@gmail.com>
 <CAJKOXPdUVjG1xR-q-K98RQpqsWzw-emEv2_3x3CoS+XK8cye2Q@mail.gmail.com>
In-Reply-To: <CAJKOXPdUVjG1xR-q-K98RQpqsWzw-emEv2_3x3CoS+XK8cye2Q@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 21 Sep 2018 18:01:07 +0530
Message-ID: <CANAwSgQQgObh-N0CbBM9iNxOGUd2uwoKNFVDBymEALzMtHxOhA@mail.gmail.com>
Subject: Re: [PATCHv3 5/7] ARM: dts: exynos5422: use wp-gpio method to detect sd-card
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, 21 Sep 2018 at 16:42, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, 20 Sep 2018 at 19:59, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > add the Write Protect GPIO property for sdcard, to fix
> > the warning message during boot time.
> > of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/soc/mmc@12220000[0]'
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > New patch to this series.
> > If we keep the wp-gpio GPIO_ACTIVE_LOW sdcard boot into RO mode.
> > ---
> >  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> > index 03fe02ceae66..475c38bbc99e 100644
> > --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> > +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> > @@ -370,6 +370,7 @@
> >         cap-sd-highspeed;
> >         max-frequency = <200000000>;
> >         cd-gpios = <&gpc2 2 GPIO_ACTIVE_LOW>;
> > +       wp-gpios = <&gpc4 0 GPIO_ACTIVE_HIGH>;
>
> Two issues here:
> 1. You need also proper pinctrl setting.

Thanks for pointing out. Yes proper pinctrl is needed to support this setting.
probably pinctrl sd2_wp is needed to support this feature.

> 2. On schematics the WP is not connected... so how do you know that it
From XU4_MAIN_REV0.1 schematics page 7 "Micro Socket" their is no
connection to WP pin.
but below schematics page "EXYNOS 5422 MMC UFS" it's shows
XMMC2WP/GPC4_0/EXT_INT13_0.

> is active high? How did you test it? How do you want to test it on
> microSD?

I just tested this with the DTS change to GPIO_ACTIVE_LOW which
resulted the microSD card booted into RO mode.
So I set this to GPIO_ACTIVE_HIGH just to avoid warning.

I will study the changes requires and then post proper separate patch
to support this feature.

Best Regards
-Anand
>
> Best regards,
> Krzysztof
>
> >         vmmc-supply = <&ldo19_reg>;
> >         vqmmc-supply = <&ldo13_reg>;
> >         sd-uhs-sdr50;
> > --
> > 2.17.1
> >
