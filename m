Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_RHS_DOB autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E76C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A6A20661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PTojt70g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A6A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbeLFRIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:08:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40802 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeLFRIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:08:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so1226863wrt.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 09:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n1Wh1MYeW4IZXesY5bRiGqpWcwQezW04aN8+hh/Gqas=;
        b=PTojt70gYUvsg4CCC7Ug8CT9Tf2NSiNiZqBST0WBsI2JpbK9qOvvl28vPqHjy0lA7N
         t1LKwAIYNov6QHn7q+f2KudQbiau6VZXdDBL32N61TUT0+3mOjPUtYdQMTxv9S61MxfN
         YQ5td830pChNCppVFe9JSf+CkpUHhJVd8r/t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n1Wh1MYeW4IZXesY5bRiGqpWcwQezW04aN8+hh/Gqas=;
        b=hFyxm3rKUwPl3+xpQ3iiPGjomUQxHlpGWSeXYuuf6iKOlsvSn9s89vkELsCisLaZvp
         xLninfwi0X8iUv7EQW1O0aukt66Xc0LtqWZwXKPXpnGJkRYPpJujSfOuFjvE4TmiAMbM
         htLKPOF/fgDA0GOVxszTd4earqe4qjbi1jhWJVxwZHzbus8wmSWjvCVh3RrHqAuJOPDi
         xeAvR25QG9Uo+dTP3DQ4dxvQImmp4W58r7FzFg9gDtnbZKEHKTh56AQIexl+WUf3Z61p
         X+zuztrkF6SCzjteW8wTl9XTi8Qie2pA9UcnKZ3hWEhIPvXeMe3Vni4Q6Mzs4D5p0mdP
         L77Q==
X-Gm-Message-State: AA+aEWZs8+wyx1VKYFh+Yb1aXaHtUvmILvGSDXHfhD5zZhVkp/zbarKm
        AwKknbyEWxmxn3ubH4udawlNETs0VJGkXsDVT2OqmA==
X-Google-Smtp-Source: AFSGD/V/S1uynPvxft/BTBJeHJ8bwDFcJBB57C0H8kh7CS8NSEdgBc9Xetv4WSG9+1doJQfPSTbt2tQIbSKI9mlZiHI=
X-Received: by 2002:adf:e891:: with SMTP id d17mr28032263wrm.140.1544116090511;
 Thu, 06 Dec 2018 09:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20181206132306.11843-1-jagan@amarulasolutions.com>
 <20181206132306.11843-2-jagan@amarulasolutions.com> <20181206153445.kqu2pep5orktr6yv@flea>
In-Reply-To: <20181206153445.kqu2pep5orktr6yv@flea>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Thu, 6 Dec 2018 18:07:59 +0100
Message-ID: <CAOf5uwk_k-Y8ZZFbtjUup5U27wN_E+fvqEDs5m3csnzdneN1KQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: allwinner: a64: Add A64 CSI controller
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Thu, Dec 6, 2018 at 4:34 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Dec 06, 2018 at 06:53:05PM +0530, Jagan Teki wrote:
> > Allwinner A64 CSI controller has similar features as like in
> > H3, So add support for A64 via H3 fallback.
> >
> > Also updated CSI_SCLK to use 300MHz via assigned-clocks, since
> > the default clock 600MHz seems unable to drive the sensor(ov5640)
> > to capture the image.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v2:
> > - Use CSI_SCLK to 300MHz
> >
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 23 +++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > index 384c417cb7a2..d7ab0006ebce 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > @@ -532,6 +532,12 @@
> >                       interrupt-controller;
> >                       #interrupt-cells = <3>;
> >
> > +                     csi_pins: csi-pins {
> > +                             pins = "PE0", "PE2", "PE3", "PE4", "PE5", "PE6",
> > +                                    "PE7", "PE8", "PE9", "PE10", "PE11";
> > +                             function = "csi0";
> > +                     };
> > +
> >                       i2c0_pins: i2c0_pins {
> >                               pins = "PH0", "PH1";
> >                               function = "i2c0";
> > @@ -899,6 +905,23 @@
> >                       status = "disabled";
> >               };
> >
> > +             csi: csi@1cb0000 {
> > +                     compatible = "allwinner,sun50i-a64-csi",
> > +                                  "allwinner,sun8i-h3-csi";
> > +                     reg = <0x01cb0000 0x1000>;
> > +                     interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&ccu CLK_BUS_CSI>,
> > +                              <&ccu CLK_CSI_SCLK>,
> > +                              <&ccu CLK_DRAM_CSI>;
> > +                     clock-names = "bus", "mod", "ram";
> > +                     resets = <&ccu RST_BUS_CSI>;
> > +                     pinctrl-names = "default";
> > +                     pinctrl-0 = <&csi_pins>;
> > +                     assigned-clocks = <&ccu CLK_CSI_SCLK>;
> > +                     assigned-clock-rates = <300000000>;
>
> That should be enforced in the driver.
>

We are not really sure what is the best here. Our first idea was to
put in the board file and then Jagan
decide to put in dtsi. We don't have enough coverage of camera on this
CPU and I prefer to stay with this
minimal change that does not impact the driver.

Michael

> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
