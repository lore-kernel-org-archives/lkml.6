Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C6EC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5794720892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gwlITWmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5794720892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeLGJQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:16:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52658 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGJQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:16:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so3591325wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 01:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fclhWpJWTszcwfU4YUajRq4eqA2SoHkWc1KbhcPPrKo=;
        b=gwlITWmJjx2stbazuOJ8msEBQ4qdBf3HM//K/nUB/O4b3FPuKC1t8tSmCzi/U2MxH1
         Z6kFhSWCpME4OdVVctw0IemmIxbQQ2xVWe/pCXp12WRlnZM/M5UFAdiB75EzEPwrE6Pj
         dW57gcQcd3b+XIKUT5Au0qEtQeV/6q1goqHDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fclhWpJWTszcwfU4YUajRq4eqA2SoHkWc1KbhcPPrKo=;
        b=bNpXQI8DKfZhoIlKjfbpiO7fpN6PFisYxmSkDdzjgCH4an5V6bsSTpG0jNrzb+/t2W
         6uK/8Zzm5t+DlpqvnRxJutpugvci7NZ5Axi7lDvsTYEh+9FjFYtWH/pyFAgA0P2Dmiri
         +oTvyKZgyiO2njby0T/5Q8C0MPfKKrTFiR+ppgl6Ih8BA43ckfQeL0e1s0RHhmJ41NSq
         Q0F6StFHYkJ0cafgis2fMDbXrKjgRkhQfrhclicx4lziDWd2KETZj+4SNgQ69j3GzA67
         CWOkUxDgaAUEldZ1gGHGTJ+EtYlnhQAPOxM8tHocJTKZUVCWvB3UvhrzWFsHpTvxy0iu
         iC4w==
X-Gm-Message-State: AA+aEWatnHAUe77JC6VRIlmd0fdMfJggOh37qt6oN6w/BZMgUBjOSRk6
        mROnwk7+QxcHA8nQG5+guaXDNhoAYjoklyD6BBh6Lg==
X-Google-Smtp-Source: AFSGD/X8KW7s+Wwp+tR/GM2mLriUXOf5B3fpqMKoBaC16G7/tomtQCdBaHg9Z2L8DBoMnpSJ80M9A02Se/HB4QHcJJ4=
X-Received: by 2002:a1c:b456:: with SMTP id d83mr1570250wmf.115.1544174178482;
 Fri, 07 Dec 2018 01:16:18 -0800 (PST)
MIME-Version: 1.0
References: <20181206132306.11843-1-jagan@amarulasolutions.com>
 <20181206132306.11843-2-jagan@amarulasolutions.com> <20181206153445.kqu2pep5orktr6yv@flea>
 <CAOf5uwk_k-Y8ZZFbtjUup5U27wN_E+fvqEDs5m3csnzdneN1KQ@mail.gmail.com> <20181207074723.l3ykhqojfkd4y4ie@flea>
In-Reply-To: <20181207074723.l3ykhqojfkd4y4ie@flea>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Fri, 7 Dec 2018 10:16:07 +0100
Message-ID: <CAOf5uwk7xM=QmG_wzKYNEvudwDLh-ypLxPZZsDiUEjdbymCiUQ@mail.gmail.com>
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

On Fri, Dec 7, 2018 at 8:47 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Dec 06, 2018 at 06:07:59PM +0100, Michael Nazzareno Trimarchi wrote:
> > On Thu, Dec 6, 2018 at 4:34 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > On Thu, Dec 06, 2018 at 06:53:05PM +0530, Jagan Teki wrote:
> > > > Allwinner A64 CSI controller has similar features as like in
> > > > H3, So add support for A64 via H3 fallback.
> > > >
> > > > Also updated CSI_SCLK to use 300MHz via assigned-clocks, since
> > > > the default clock 600MHz seems unable to drive the sensor(ov5640)
> > > > to capture the image.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > > Changes for v2:
> > > > - Use CSI_SCLK to 300MHz
> > > >
> > > >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 23 +++++++++++++++++++
> > > >  1 file changed, 23 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > > index 384c417cb7a2..d7ab0006ebce 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > > @@ -532,6 +532,12 @@
> > > >                       interrupt-controller;
> > > >                       #interrupt-cells = <3>;
> > > >
> > > > +                     csi_pins: csi-pins {
> > > > +                             pins = "PE0", "PE2", "PE3", "PE4", "PE5", "PE6",
> > > > +                                    "PE7", "PE8", "PE9", "PE10", "PE11";
> > > > +                             function = "csi0";
> > > > +                     };
> > > > +
> > > >                       i2c0_pins: i2c0_pins {
> > > >                               pins = "PH0", "PH1";
> > > >                               function = "i2c0";
> > > > @@ -899,6 +905,23 @@
> > > >                       status = "disabled";
> > > >               };
> > > >
> > > > +             csi: csi@1cb0000 {
> > > > +                     compatible = "allwinner,sun50i-a64-csi",
> > > > +                                  "allwinner,sun8i-h3-csi";
> > > > +                     reg = <0x01cb0000 0x1000>;
> > > > +                     interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> > > > +                     clocks = <&ccu CLK_BUS_CSI>,
> > > > +                              <&ccu CLK_CSI_SCLK>,
> > > > +                              <&ccu CLK_DRAM_CSI>;
> > > > +                     clock-names = "bus", "mod", "ram";
> > > > +                     resets = <&ccu RST_BUS_CSI>;
> > > > +                     pinctrl-names = "default";
> > > > +                     pinctrl-0 = <&csi_pins>;
> > > > +                     assigned-clocks = <&ccu CLK_CSI_SCLK>;
> > > > +                     assigned-clock-rates = <300000000>;
> > >
> > > That should be enforced in the driver.
> > >
> >
> > We are not really sure what is the best here. Our first idea was to
> > put in the board file and then Jagan
> > decide to put in dtsi. We don't have enough coverage of camera on this
> > CPU and I prefer to stay with this
> > minimal change that does not impact the driver.
>
> The thing is that:
>   - in this commit log, you're stating that it depends on the sensor,
>     which indicates that this would be a board level addition
>   - In another patch series, Jagan reported IIRC that it actually
>     depends on the resolution, so it doesn't belong in the DT at all
>   - And then, you don't even have any guarantee on the clock rate. The
>     sole guarantee you have is that when your driver will probe, the
>     rate will be close to those 300MHz. That's it. It might completely
>     change after the driver has probed, or be rounded to something
>     else entirely, who knows.

I'm not so interested in the story but it's clear what you ask but in
short having one
sensor up to 5M pixel we can be sure where the reason is but make it
more pratical.

We have a parent clock that is the peripheral clock on clock
tree that run at 600Mhz. With a clock divider of 0 the driver work but
the acquisition
as problem on quality. Now the same sensor seems to work when the
logic is clocked
as half of the speed. If I remind in the right way the divider can be
only possible so
you can get pclk / (n + 1) without reparent to a different input.
Now I don't find any nice documentation that state that 600Mhz
is not supported but anyway, you suggest to do the same that is done
in fimc driver so
set there the rate there and offcourse x platform change like:

#define A64_CSI_FREQUENCY 600

ret = clk_set_rate(csk_core_clk, A64_CSI_FREQUENCY);

>
> So really, putting it in the DT is nothing but a hack.
>

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
