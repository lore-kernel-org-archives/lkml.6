Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81983C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4807722360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PR4OePZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4807722360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbeKNQdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 11:33:37 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37848 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbeKNQdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 11:33:37 -0500
Received: by mail-it1-f195.google.com with SMTP id j79-v6so22295545itb.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 22:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vKU19plQ0QxGJv9HTShl1PsYAdOaPOBDChZaaVzM228=;
        b=PR4OePZpMxnhPaT9pTya1ucPktib0ZsG5so2dJH5tJWAqRdeaAA7vswAbIbZp9mESr
         mgo6m046swB9FRFmDv6xvJfHYu3rgZcZb5aM9wLoZhExQvULZsVyGJx+VQ3Z9YpaQ660
         AoEr6jGPBaCmV6FS0dZdmQDVWtbX53QLDmuBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vKU19plQ0QxGJv9HTShl1PsYAdOaPOBDChZaaVzM228=;
        b=j1FOtpORIEIPEGPgNODGrxu7/K74N6dXhM/ZClRbWzYMWS6NuJKhuAA6Va8h4elJTD
         jDtg3eY4hm/5CX7/bO4gsvyFZVC2vipM2vi6pR9BSIDvfvgfidVfTKTB21tZPQa/eB0/
         z/5+CQxLExA/nnuh+w5Ry3+1Qom1K6yGz/zWPaUIEXdH7eYb3XW0g9ZAyjJ+WJK+88v/
         ZQwoTtHcL25fjCJOvnnJeUbr8KEBkVuT1PjW/AM6y+GnGG6hZa4Ei7xOXJzxm/NBS7Nc
         9xZwLFm4l/b3qu6rAxviTx2hRvb51bl/W1AYjhdqUXAJrredzWfzFONary4tt6ofhEOd
         jyqw==
X-Gm-Message-State: AGRZ1gKYHZbQ5CnQMt4daX06telA2Y1De1Ofzs2yZCBxJN3rS2L96Tc2
        gCSXeMMhO8+LJa1tC+bmE62YjQ1ccJZuwLvJkIPT1A==
X-Google-Smtp-Source: AFSGD/UIpyHyq8eOfc6V38APchtrzFQjyl2ydbTFASSo8t5fhfvHa8d2aBwiVJjUVeB3d3mq7bA1kDNR1shyJnzIx2g=
X-Received: by 2002:a24:2710:: with SMTP id g16-v6mr909269ita.107.1542177105951;
 Tue, 13 Nov 2018 22:31:45 -0800 (PST)
MIME-Version: 1.0
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-26-jagan@amarulasolutions.com> <20181113122204.337db8b1@donnerap.cambridge.arm.com>
In-Reply-To: <20181113122204.337db8b1@donnerap.cambridge.arm.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 14 Nov 2018 12:01:33 +0530
Message-ID: <CAMty3ZBQXcnU=490KREa=F-qctMtRep9-rrhrPd1UZStnV=hqw@mail.gmail.com>
Subject: Re: [PATCH v4 25/26] [DO NOT MERGE] arm64: dts: allwinner:
 bananapi-m64: Bananapi S070WV20-CT16 DSI panel
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
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

On Tue, Nov 13, 2018 at 5:52 PM Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Tue, 13 Nov 2018 16:46:32 +0530
> Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Hi,
>
> > This patch add support for Bananapi S070WV20-CT16 DSI panel to
> > BPI-M64 board.
> >
> > DSI panel connected via board DSI port with,
> > - DC1SW as AVDD supply
>
> Are you sure of that? I don't see anything in the schematic to support
> this. The only power lines that go to the DSI connector are DCDC1 and
> PS. DC1SW is only connected to PortD on the SoC and to the Ethernet PHY.
> Is there anything I miss?

Thanks for the comment, yes dc1sw is connected in ephy. I have reused
dc1, BSP is attached lcd_power1 to axp81x_dc1sw [1]. I just looking
for someone to comment, may be we can skip this regulator attachment.

>
> > - DCDC1 as DVDD supply
>
> That seems right, but doesn't match with what you write below.

Commit need to fix s/DCDC1/DLDO1

>
> > - PD6 gpio for reset pin
> > - PD5 gpio for backlight enable pin
> > - PD7 gpio for backlight vdd supply
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 42
> > +++++++++++++++++++ 1 file changed, 42 insertions(+)
> >
> > diff --git
> > a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> > b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts index
> > ef1c90401bb2..6cb010e3bbd9 100644 ---
> > a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts +++
> > b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts @@ -45,6
> > +45,7 @@ #include "sun50i-a64.dtsi"
> >  #include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/pwm/pwm.h>
> >
> >  / {
> >       model = "BananaPi-M64";
> > @@ -56,6 +57,15 @@
> >               serial1 = &uart1;
> >       };
> >
> > +     backlight: backlight {
> > +             compatible = "pwm-backlight";
> > +             pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
> > +             brightness-levels = <1 2 4 8 16 32 64 128 512>;
> > +             default-brightness-level = <2>;
> > +             enable-gpios = <&pio 3 5 GPIO_ACTIVE_HIGH>; /*
> > LCD-BL-EN: PD5 */
> > +             power-supply = <&reg_vdd_backlight>;
> > +     };
> > +
> >       chosen {
> >               stdout-path = "serial0:115200n8";
> >       };
> > @@ -91,6 +101,15 @@
> >               };
> >       };
> >
> > +     reg_vdd_backlight: vdd-backlight {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "vdd-backlight";
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +             gpio = <&pio 3 7 GPIO_ACTIVE_HIGH>; /* LCD-PWR-EN:
> > PD7 */
> > +             enable-active-high;
> > +     };
> > +
> >       wifi_pwrseq: wifi_pwrseq {
> >               compatible = "mmc-pwrseq-simple";
> >               reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
> > @@ -101,6 +120,23 @@
> >       status = "okay";
> >  };
> >
> > +&dphy {
> > +     status = "okay";
> > +};
> > +
> > +&dsi {
> > +     status = "okay";
> > +
> > +     panel@0 {
> > +             compatible = "bananapi,s070wv20-ct16-icn6211";
> > +             reg = <0>;
> > +             avdd-supply = <&reg_dc1sw>;
>
> As mentioned above, I don't see this on the DSI connector.
>
> > +             dvdd-supply = <&reg_dldo1>;
>
> Mmh, this line is connected to the *SoC*, to drive the DSI data lines
> or the DPHY, presumably. So I wouldn't expect it in the panel node, but
> rather in the DPHY or DSI node. Although I can't find a power-supply
> property in those bindings.

Got it, this has to attach via vcc-dsi-supply.

[1] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/bootloader/blobs/bpi-m64-lcd7.dts#L2266
