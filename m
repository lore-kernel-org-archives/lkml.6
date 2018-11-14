Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859ADC07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6B5223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6B5223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732634AbeKNTZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:25:18 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37103 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732392AbeKNTZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:25:18 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so8213734edb.4;
        Wed, 14 Nov 2018 01:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VwB50JaiTaC2TDsw26YwsMiCnS6Ys+BF1RfBUcmBexg=;
        b=Z5u6gN9R07T7cBMfZB145VfAI1DZestx9ynVidxWafVgXQvariv/vEsoXJa7ZIrGHt
         OL2RnCVnJ4shDLZWL4Lpt7wn3J35Ib1UsIhjP89zknRMUHYXXiVNmx1E6zcKBK2+qhZI
         EGkOmcWAATJPclyvDDhXgVaVxn4zUKfJi/pg2/ZDXn6io9ZQVeUkd5D/axXwS+sayREg
         o86UEIP5Srm2x4Osk6kbdnW3x4V2o25J16oJKGSnrNjWiYcXMLfW+Ar3S3YvmDLdWG+W
         k493Fl2i1uy7jgBIlXPp2DNr8VGxE/L8uQHHCX8LoxDMHK7Qg64/mSqacex31J/81Ddv
         V6sA==
X-Gm-Message-State: AGRZ1gJu5D7p/+HQZgzyHyF4fLwxPlKzMt5F/au1V6c3o/XzOqYFuToV
        SDdLQ6Wi05qkdcTWM83z9vj5bwr6i3Y=
X-Google-Smtp-Source: AJdET5eUuvbBtExUlFLpZ0f8f3fIXDD+OBY7y+5N3rPcfy7a3Y1r075pV6Ir1c7WmsbzfxClL4ehlw==
X-Received: by 2002:a50:a4c8:: with SMTP id x8-v6mr1422164edb.210.1542187368383;
        Wed, 14 Nov 2018 01:22:48 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id z50sm1117938edz.1.2018.11.14.01.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 01:22:48 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id z13-v6so16423412wrs.3;
        Wed, 14 Nov 2018 01:22:47 -0800 (PST)
X-Received: by 2002:adf:e308:: with SMTP id b8-v6mr1129222wrj.91.1542187366940;
 Wed, 14 Nov 2018 01:22:46 -0800 (PST)
MIME-Version: 1.0
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-26-jagan@amarulasolutions.com> <20181113122204.337db8b1@donnerap.cambridge.arm.com>
 <CAMty3ZBQXcnU=490KREa=F-qctMtRep9-rrhrPd1UZStnV=hqw@mail.gmail.com> <CAGb2v669dkf2qaUDaosJEKSRKpPRVKWszb6BLL2NrAjWwp3t2Q@mail.gmail.com>
In-Reply-To: <CAGb2v669dkf2qaUDaosJEKSRKpPRVKWszb6BLL2NrAjWwp3t2Q@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 14 Nov 2018 17:22:33 +0800
X-Gmail-Original-Message-ID: <CAGb2v64YOV48UwHc8-=jDt2Bp_4mNb3iuyEzj0d+GOQE_oT-Xg@mail.gmail.com>
Message-ID: <CAGb2v64YOV48UwHc8-=jDt2Bp_4mNb3iuyEzj0d+GOQE_oT-Xg@mail.gmail.com>
Subject: Re: [PATCH v4 25/26] [DO NOT MERGE] arm64: dts: allwinner:
 bananapi-m64: Bananapi S070WV20-CT16 DSI panel
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     =?UTF-8?Q?Andr=C3=A9_Przywara?= <andre.przywara@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 2:58 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Wed, Nov 14, 2018 at 2:31 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > On Tue, Nov 13, 2018 at 5:52 PM Andre Przywara <andre.przywara@arm.com> wrote:
> > >
> > > On Tue, 13 Nov 2018 16:46:32 +0530
> > > Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > Hi,
> > >
> > > > This patch add support for Bananapi S070WV20-CT16 DSI panel to
> > > > BPI-M64 board.
> > > >
> > > > DSI panel connected via board DSI port with,
> > > > - DC1SW as AVDD supply
> > >
> > > Are you sure of that? I don't see anything in the schematic to support
> > > this. The only power lines that go to the DSI connector are DCDC1 and
> > > PS. DC1SW is only connected to PortD on the SoC and to the Ethernet PHY.
> > > Is there anything I miss?
> >
> > Thanks for the comment, yes dc1sw is connected in ephy. I have reused
> > dc1, BSP is attached lcd_power1 to axp81x_dc1sw [1]. I just looking
> > for someone to comment, may be we can skip this regulator attachment.
>
> That seems sketchy. The schematics show the connector has feeds from both
> the unregulated output IPSOUT (PS) and DCDC1. For designs with RGB LCD
> panels, we only see the PS feed. Since the LCD panel can be used in either
> RGB or MIPI DSI mode, I highly suspect the DCDC1 supply feeds the bridge
> IC.
>
> As for DC1SW, this is likely referenced because it provides power to the
> GPIO lines that are used to control the LCD panel. If you don't provide
> power, you can't pull them up.
>
> While many of us dislike FEX and the new FEX-derived device tree, they
> do provide some information, such as regulator usage. Note that each
> regulator output has multiple names, which likely denote specific
> usages.
>
> I've asked BPI for schematics on the bridge board. Hopefully we'll
> have something in more detail. In the meantime, I suggest leaving
> this panel out of your next submission, and focus on getting the bulk
> of the dsi driver and dts changes in first.

I got the schematics, but unfortunately I can't share them publicly.

It looks like VCC-MIPI on the connector is not connected to anything.
All power is provided from IPSOUT, first through a current limiter IC
turned on and off by LCD_PWR_EN, and then through some voltage regulators
to provide the voltages for various parts of the panel, including LCD,
capacitive touch, and the MIPI-DSI bridge. There's even an onboard EEPROM,
though I'm not sure what that's for.

> >
> > >
> > > > - DCDC1 as DVDD supply
> > >
> > > That seems right, but doesn't match with what you write below.
> >
> > Commit need to fix s/DCDC1/DLDO1
> >
> > >
> > > > - PD6 gpio for reset pin

This toggles reset for both the panel itself and for the MIPI-DSI bridge.

> > > > - PD5 gpio for backlight enable pin

This enables the backlight's regulator.

> > > > - PD7 gpio for backlight vdd supply

This enables power to the whole panel module.

Then you also have the two GPIOs for the capacitive touch controller.
And also the I2C bus for the controller, and the EEPROM.


ChenYu

> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > >  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 42
> > > > +++++++++++++++++++ 1 file changed, 42 insertions(+)
> > > >
> > > > diff --git
> > > > a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> > > > b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts index
> > > > ef1c90401bb2..6cb010e3bbd9 100644 ---
> > > > a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts +++
> > > > b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts @@ -45,6
> > > > +45,7 @@ #include "sun50i-a64.dtsi"
> > > >  #include <dt-bindings/gpio/gpio.h>
> > > > +#include <dt-bindings/pwm/pwm.h>
> > > >
> > > >  / {
> > > >       model = "BananaPi-M64";
> > > > @@ -56,6 +57,15 @@
> > > >               serial1 = &uart1;
> > > >       };
> > > >
> > > > +     backlight: backlight {
> > > > +             compatible = "pwm-backlight";
> > > > +             pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
> > > > +             brightness-levels = <1 2 4 8 16 32 64 128 512>;
> > > > +             default-brightness-level = <2>;
> > > > +             enable-gpios = <&pio 3 5 GPIO_ACTIVE_HIGH>; /*
> > > > LCD-BL-EN: PD5 */
> > > > +             power-supply = <&reg_vdd_backlight>;
> > > > +     };
> > > > +
> > > >       chosen {
> > > >               stdout-path = "serial0:115200n8";
> > > >       };
> > > > @@ -91,6 +101,15 @@
> > > >               };
> > > >       };
> > > >
> > > > +     reg_vdd_backlight: vdd-backlight {
> > > > +             compatible = "regulator-fixed";
> > > > +             regulator-name = "vdd-backlight";
> > > > +             regulator-min-microvolt = <3300000>;
> > > > +             regulator-max-microvolt = <3300000>;
> > > > +             gpio = <&pio 3 7 GPIO_ACTIVE_HIGH>; /* LCD-PWR-EN:
> > > > PD7 */
> > > > +             enable-active-high;
> > > > +     };
> > > > +
> > > >       wifi_pwrseq: wifi_pwrseq {
> > > >               compatible = "mmc-pwrseq-simple";
> > > >               reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
> > > > @@ -101,6 +120,23 @@
> > > >       status = "okay";
> > > >  };
> > > >
> > > > +&dphy {
> > > > +     status = "okay";
> > > > +};
> > > > +
> > > > +&dsi {
> > > > +     status = "okay";
> > > > +
> > > > +     panel@0 {
> > > > +             compatible = "bananapi,s070wv20-ct16-icn6211";
> > > > +             reg = <0>;
> > > > +             avdd-supply = <&reg_dc1sw>;
> > >
> > > As mentioned above, I don't see this on the DSI connector.
> > >
> > > > +             dvdd-supply = <&reg_dldo1>;
> > >
> > > Mmh, this line is connected to the *SoC*, to drive the DSI data lines
> > > or the DPHY, presumably. So I wouldn't expect it in the panel node, but
> > > rather in the DPHY or DSI node. Although I can't find a power-supply
> > > property in those bindings.
> >
> > Got it, this has to attach via vcc-dsi-supply.
> >
> > [1] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/bootloader/blobs/bpi-m64-lcd7.dts#L2266
