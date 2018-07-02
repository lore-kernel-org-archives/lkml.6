Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4673C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D07725D21
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2Th4Jfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D07725D21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753684AbeGBVlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:41:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53779 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753138AbeGBVlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:41:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id b188-v6so209512wme.3;
        Mon, 02 Jul 2018 14:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gfNsHLSRELGq7E2tVCle3CGSS90mw9xoGJIZGtdO3O4=;
        b=J2Th4Jfe0cjGMnLYacA+TLAJcmEE7lIScbpBOCfUMj8Bb4K6Kc+KdrHG0HdvGq29U7
         U4dv/qo69887J7hpAh83pQzmkYXGQ6aNml6/IuqrFMbi8BN2LSjXZRhrUHtVyj+6tref
         7i//iPYK/ynxCvpyheIput5dZBNDSaTV82kP7b3dX5X1gJNoPhOYu6Z/Xi0HbH+TzlSn
         eu1hBM/Gr0BExq7yvBuvhAAk0QfCDEB0AGn93gXUSKyKWQdJsdpXNNKmabJUkqNiUgJH
         cgcjEa3ajTk4aEmOKD9DvgakiEHGqEdh8Y+SJR8l+1boEQCkucjtOu2lzkEP5floq5Ht
         tcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gfNsHLSRELGq7E2tVCle3CGSS90mw9xoGJIZGtdO3O4=;
        b=Jz66Ebk5pXH7OIRZ/pBWxzW931U+0b6HaNTx7nd3/9E+SszrWGC2QnRUl3C52p+ORr
         Vy0ii7iuk038vbrJ5fxGtW46pY7oUia5Y5sxmN+jK12oBxiDKLthvhpU37d51dr4EvER
         DZrn6VBdpt18o+0v3cwi0T2kR6KYCzH59Qe1O644q6MHuwi5Kq8JDBSGlMAYBlC5VOU9
         JbemgPctmPnzxXGFto9iyeiEZOIIjGO7AM+H8AdTaIaj7O6VrXe2XOxyVron4cgKyQ9m
         +elys8mBUFaav3dIzV0HsqIEq3k8tWheD/12eq3W3t2x6LwaOoTcqeXykwUelAA7n4xA
         8D8Q==
X-Gm-Message-State: APt69E0D5XC4CyKhyK035nTRWNPUJk4tbPY+NgHDA8U0S1oJdW/Dw6GH
        ReSfG9B4MrZROaj2al9OLpA=
X-Google-Smtp-Source: AAOMgpftmew4ntVbTmo0ONIfUd4P789WKKsX49oDbLaYarXf14MVSSbm1R0dFYbqiKKxpmuoOGC9Ug==
X-Received: by 2002:a1c:c8:: with SMTP id 191-v6mr8846264wma.115.1530567658932;
        Mon, 02 Jul 2018 14:40:58 -0700 (PDT)
Received: from jernej-laptop.localnet ([194.152.15.144])
        by smtp.gmail.com with ESMTPSA id r123-v6sm13715926wmb.21.2018.07.02.14.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 14:40:57 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: Re: [linux-sunxi] Re: [PATCH v3 23/24] ARM: dts: sun8i: r40: Add HDMI pipeline
Date:   Mon, 02 Jul 2018 23:39:24 +0200
Message-ID: <2193531.8RiXQQzuZF@jernej-laptop>
In-Reply-To: <7021261.2sGXzK4yLY@jernej-laptop>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <CAGb2v666uesMjm7HqOMmj2ij1+avedRPrQmxwHu-aY2JsSkUOw@mail.gmail.com> <7021261.2sGXzK4yLY@jernej-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 01. julij 2018 ob 21:25:57 CEST je Jernej =C5=A0krabec napisal=
(a):
> Dne nedelja, 01. julij 2018 ob 17:35:28 CEST je Chen-Yu Tsai napisal(a):
> > On Sun, Jul 1, 2018 at 11:13 PM, Jernej =C5=A0krabec <jernej.skrabec@si=
ol.net>
>=20
> wrote:
> > > Dne nedelja, 01. julij 2018 ob 15:52:55 CEST je Chen-Yu Tsai napisal(=
a):
> > >> On Sun, Jul 1, 2018 at 6:41 PM, Jernej =C5=A0krabec
> > >> <jernej.skrabec@siol.net>
> > >=20
> > > wrote:
> > >> > Dne =C4=8Detrtek, 28. junij 2018 ob 08:51:07 CEST je Chen-Yu Tsai
>=20
> napisal(a):
> > >> >> On Thu, Jun 28, 2018 at 1:15 PM, Jernej =C5=A0krabec
> > >> >> <jernej.skrabec@siol.net>
> > >> >=20
> > >> > wrote:
> > >> >> > Dne =C4=8Detrtek, 28. junij 2018 ob 04:50:09 CEST je Chen-Yu Ts=
ai
> > >=20
> > > napisal(a):
> > >> >> >> On Mon, Jun 25, 2018 at 8:03 PM, Jernej Skrabec
> > >> >> >> <jernej.skrabec@siol.net>
> > >> >> >=20
> > >> >> > wrote:
> > >> >> >> > Add all entries needed for HDMI to function properly.
> > >> >> >> >=20
> > >> >> >> > Since R40 has highly configurable pipeline, both mixers and
> > >> >> >> > both
> > >> >> >> > TCON
> > >> >> >> > TVs are added. Board specific DT should then connect them
> > >> >> >> > together
> > >> >> >> > trough TCON TOP muxers to best fit the purpose of the board.
> > >> >> >> >=20
> > >> >> >> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > >> >> >> > ---
> > >> >> >> >=20
> > >> >> >> >  arch/arm/boot/dts/sun8i-r40.dtsi | 269
> > >> >> >> >  +++++++++++++++++++++++++++++++
> > >> >> >> >  1 file changed, 269 insertions(+)
> > >> >> >> >=20
> > >> >> >> > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi
> > >> >> >> > b/arch/arm/boot/dts/sun8i-r40.dtsi index
> > >> >> >> > 173dcc1652d2..a2a75fb04caf
> > >> >> >> > 100644
> > >> >> >> > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > >> >> >> > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > >> >> >> > @@ -42,8 +42,11 @@
> > >> >> >> >=20
> > >> >> >> >   */
> > >> >> >> > =20
> > >> >> >> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > >> >> >> >=20
> > >> >> >> > +#include <dt-bindings/clock/sun8i-de2.h>
> > >> >> >> >=20
> > >> >> >> >  #include <dt-bindings/clock/sun8i-r40-ccu.h>
> > >> >> >> >=20
> > >> >> >> > +#include <dt-bindings/clock/sun8i-tcon-top.h>
> > >> >> >=20
> > >> >> > Maxime, above line breaks compilation for build robot, sorry.
> > >> >> >=20
> > >> >> >> >  #include <dt-bindings/reset/sun8i-r40-ccu.h>
> > >> >> >> >=20
> > >> >> >> > +#include <dt-bindings/reset/sun8i-de2.h>
> > >> >> >> >=20
> > >> >> >> >  / {
> > >> >> >> > =20
> > >> >> >> >         #address-cells =3D <1>;
> > >> >> >> >=20
> > >> >> >> > @@ -99,12 +102,76 @@
> > >> >> >> >=20
> > >> >> >> >                 };
> > >> >> >> >        =20
> > >> >> >> >         };
> > >> >> >> >=20
> > >> >> >> > +       de: display-engine {
> > >> >> >> > +               compatible =3D
> > >> >> >> > "allwinner,sun8i-r40-display-engine",
> > >> >> >> > +                          =20
> > >> >> >> > "allwinner,sun8i-h3-display-engine";
> > >> >> >>=20
> > >> >> >> Given that the display pipeline looks different, they should n=
ot
> > >> >> >> be
> > >> >> >> compatible.
> > >> >> >=20
> > >> >> > Ok.
> > >> >> >=20
> > >> >> >> > +               allwinner,pipelines =3D <&mixer0>, <&mixer1>;
> > >> >> >> > +               status =3D "disabled";
> > >> >> >> > +       };
> > >> >> >> > +
> > >> >> >> >=20
> > >> >> >> >         soc {
> > >> >> >> >        =20
> > >> >> >> >                 compatible =3D "simple-bus";
> > >> >> >> >                 #address-cells =3D <1>;
> > >> >> >> >                 #size-cells =3D <1>;
> > >> >> >> >                 ranges;
> > >> >> >> >=20
> > >> >> >> > +               display_clocks: clock@1000000 {
> > >> >> >> > +                       compatible =3D
> > >> >> >> > "allwinner,sun8i-r40-de2-clk",
> > >> >> >> > +
> > >> >> >> > "allwinner,sun8i-h3-de2-clk";
> > >> >> >> > +                       reg =3D <0x01000000 0x100000>;
> > >> >> >> > +                       clocks =3D <&ccu CLK_DE>,
> > >> >> >> > +                                <&ccu CLK_BUS_DE>;
> > >> >> >> > +                       clock-names =3D "mod",
> > >> >> >> > +                                     "bus";
> > >> >> >> > +                       resets =3D <&ccu RST_BUS_DE>;
> > >> >> >> > +                       #clock-cells =3D <1>;
> > >> >> >> > +                       #reset-cells =3D <1>;
> > >> >> >> > +               };
> > >> >> >> > +
> > >> >> >> > +               mixer0: mixer@1100000 {
> > >> >> >> > +                       compatible =3D
> > >> >> >> > "allwinner,sun8i-r40-de2-mixer-0";
> > >> >> >> > +                       reg =3D <0x01100000 0x100000>;
> > >> >> >> > +                       clocks =3D <&display_clocks
> > >> >> >> > CLK_BUS_MIXER0>,
> > >> >> >> > +                                <&display_clocks CLK_MIXER0=
>;
> > >> >> >> > +                       clock-names =3D "bus",
> > >> >> >> > +                                     "mod";
> > >> >> >> > +                       resets =3D <&display_clocks RST_MIXE=
R0>;
> > >> >> >> > +
> > >> >> >> > +                       ports {
> > >> >> >> > +                               #address-cells =3D <1>;
> > >> >> >> > +                               #size-cells =3D <0>;
> > >> >> >> > +
> > >> >> >> > +                               mixer0_out: port@1 {
> > >> >> >> > +                                       reg =3D <1>;
> > >> >> >> > +                                       mixer0_out_tcon_top:
> > >> >> >> > endpoint {
> > >> >> >> > +                                               remote-endpo=
int
> > >> >> >> > =3D
> > >> >> >> > <&tcon_top_mixer0_in_mixer0>; +
> > >> >> >> > };
> > >> >> >> > +                               };
> > >> >> >> > +                       };
> > >> >> >> > +               };
> > >> >> >> > +
> > >> >> >> > +               mixer1: mixer@1200000 {
> > >> >> >> > +                       compatible =3D
> > >> >> >> > "allwinner,sun8i-r40-de2-mixer-1";
> > >> >> >> > +                       reg =3D <0x01200000 0x100000>;
> > >> >> >> > +                       clocks =3D <&display_clocks
> > >> >> >> > CLK_BUS_MIXER1>,
> > >> >> >> > +                                <&display_clocks CLK_MIXER1=
>;
> > >> >> >> > +                       clock-names =3D "bus",
> > >> >> >> > +                                     "mod";
> > >> >> >> > +                       resets =3D <&display_clocks RST_WB>;
> > >> >> >> > +
> > >> >> >> > +                       ports {
> > >> >> >> > +                               #address-cells =3D <1>;
> > >> >> >> > +                               #size-cells =3D <0>;
> > >> >> >> > +
> > >> >> >> > +                               mixer1_out: port@1 {
> > >> >> >> > +                                       reg =3D <1>;
> > >> >> >> > +                                       mixer1_out_tcon_top:
> > >> >> >> > endpoint {
> > >> >> >> > +                                               remote-endpo=
int
> > >> >> >> > =3D
> > >> >> >> > <&tcon_top_mixer1_in_mixer1>; +
> > >> >> >> > };
> > >> >> >> > +                               };
> > >> >> >> > +                       };
> > >> >> >> > +               };
> > >> >> >> > +
> > >> >> >> >=20
> > >> >> >> >                 nmi_intc: interrupt-controller@1c00030 {
> > >> >> >> >                =20
> > >> >> >> >                         compatible =3D
> > >> >> >> >                         "allwinner,sun7i-a20-sc-nmi";
> > >> >> >> >                         interrupt-controller;
> > >> >> >> >=20
> > >> >> >> > @@ -451,6 +518,163 @@
> > >> >> >> >=20
> > >> >> >> >                         #size-cells =3D <0>;
> > >> >> >> >                =20
> > >> >> >> >                 };
> > >> >> >> >=20
> > >> >> >> > +               tcon_top: tcon-top@1c70000 {
> > >> >> >> > +                       compatible =3D
> > >> >> >> > "allwinner,sun8i-r40-tcon-top";
> > >> >> >> > +                       reg =3D <0x01c70000 0x1000>;
> > >> >> >> > +                       clocks =3D <&ccu CLK_BUS_TCON_TOP>,
> > >> >> >> > +                                <&ccu CLK_TCON_TV0>,
> > >> >> >> > +                                <&ccu CLK_TVE0>,
> > >> >> >> > +                                <&ccu CLK_TCON_TV1>,
> > >> >> >> > +                                <&ccu CLK_TVE1>,
> > >> >> >> > +                                <&ccu CLK_DSI_DPHY>;
> > >> >> >> > +                       clock-names =3D "bus",
> > >> >> >> > +                                     "tcon-tv0",
> > >> >> >> > +                                     "tve0",
> > >> >> >> > +                                     "tcon-tv1",
> > >> >> >> > +                                     "tve1",
> > >> >> >> > +                                     "dsi";
> > >> >> >> > +                       clock-output-names =3D "tcon-top-tv0=
",
> > >> >> >> > +                                            "tcon-top-tv1",
> > >> >> >> > +                                            "tcon-top-dsi";
> > >> >> >> > +                       resets =3D <&ccu RST_BUS_TCON_TOP>;
> > >> >> >> > +                       #clock-cells =3D <1>;
> > >> >> >> > +
> > >> >> >> > +                       ports {
> > >> >> >> > +                               #address-cells =3D <1>;
> > >> >> >> > +                               #size-cells =3D <0>;
> > >> >> >> > +
> > >> >> >> > +                               tcon_top_mixer0_in: port@0 {
> > >> >> >> > +                                       reg =3D <0>;
> > >> >> >> > +
> > >> >> >> > +
> > >> >> >> > tcon_top_mixer0_in_mixer0:
> > >> >> >> > endpoint { +
> > >> >> >> > remote-endpoint =3D <&mixer0_out_tcon_top>; +
> > >> >> >> >=20
> > >> >> >> >         };
> > >> >> >> >=20
> > >> >> >> > +                               };
> > >> >> >> > +
> > >> >> >> > +                               tcon_top_mixer0_out: port@1 {
> > >> >> >> > +                                       #address-cells =3D <=
1>;
> > >> >> >> > +                                       #size-cells =3D <0>;
> > >> >> >> > +                                       reg =3D <1>;
> > >> >> >> > +
> > >> >> >> > +
> > >> >> >> > tcon_top_mixer0_out_tcon_lcd0:
> > >> >> >> > endpoint@0 { +                                             =
=20
> > >> >> >> > reg
> > >> >> >> > =3D
> > >> >> >> > <0>;
> > >> >> >> > +                                       };
> > >> >> >> > +
> > >> >> >> > +
> > >> >> >> > tcon_top_mixer0_out_tcon_lcd1:
> > >> >> >> > endpoint@1 { +                                             =
=20
> > >> >> >> > reg
> > >> >> >> > =3D
> > >> >> >> > <1>;
> > >> >> >> > +                                       };
> > >> >> >> > +
> > >> >> >> > +
> > >> >> >> > tcon_top_mixer0_out_tcon_tv0:
> > >> >> >> > endpoint@2 { +                                             =
=20
> > >> >> >> > reg
> > >> >> >> > =3D
> > >> >> >> > <2>;
> > >> >> >> > +                                       };
> > >> >> >> > +
> > >> >> >> > +
> > >> >> >> > tcon_top_mixer0_out_tcon_tv1:
> > >> >> >> > endpoint@3 { +                                             =
=20
> > >> >> >> > reg
> > >> >> >> > =3D
> > >> >> >> > <3>;
> > >> >> >> > +                                       };
> > >> >> >> > +                               };
> > >> >> >> > +
> > >> >> >> > +                               tcon_top_mixer1_in: port@2 {
> > >> >> >> > +                                       reg =3D <2>;
> > >> >> >> > +
> > >> >> >> > +
> > >> >> >> > tcon_top_mixer1_in_mixer1:
> > >> >> >> > endpoint { +
> > >> >> >> > remote-endpoint =3D <&mixer1_out_tcon_top>; +
> > >> >> >> >=20
> > >> >> >> >         };
> > >> >> >> >=20
> > >> >> >> > +                               };
> > >> >> >> > +
> > >> >> >> > +                               tcon_top_mixer1_out: port@3 {
> > >> >> >> > +                                       #address-cells =3D <=
1>;
> > >> >> >> > +                                       #size-cells =3D <0>;
> > >> >> >> > +                                       reg =3D <3>;
> > >> >> >> > +
> > >> >> >> > +
> > >> >> >> > tcon_top_mixer1_out_tcon_lcd0:
> > >> >> >> > endpoint@0 { +                                             =
=20
> > >> >> >> > reg
> > >> >> >> > =3D
> > >> >> >> > <0>;
> > >> >> >> > +                                       };
> > >> >> >> > +
> > >> >> >> > +
> > >> >> >> > tcon_top_mixer1_out_tcon_lcd1:
> > >> >> >> > endpoint@1 { +                                             =
=20
> > >> >> >> > reg
> > >> >> >> > =3D
> > >> >> >> > <1>;
> > >> >> >> > +                                       };
> > >> >> >> > +
> > >> >> >> > +
> > >> >> >> > tcon_top_mixer1_out_tcon_tv0:
> > >> >> >> > endpoint@2 { +                                             =
=20
> > >> >> >> > reg
> > >> >> >> > =3D
> > >> >> >> > <2>;
> > >> >> >> > +                                       };
> > >> >> >> > +
> > >> >> >> > +
> > >> >> >> > tcon_top_mixer1_out_tcon_tv1:
> > >> >> >> > endpoint@3 { +                                             =
=20
> > >> >> >> > reg
> > >> >> >> > =3D
> > >> >> >> > <3>;
> > >> >> >> > +                                       };
> > >> >> >> > +                               };
> > >> >> >> > +
> > >> >> >> > +                               tcon_top_hdmi_in: port@4 {
> > >> >> >> > +                                       #address-cells =3D <=
1>;
> > >> >> >> > +                                       #size-cells =3D <0>;
> > >> >> >> > +                                       reg =3D <4>;
> > >> >> >> > +
> > >> >> >> > +
> > >> >> >> > tcon_top_hdmi_in_tcon_tv0:
> > >> >> >> > endpoint@0 { +                                             =
=20
> > >> >> >> > reg
> > >> >> >> > =3D
> > >> >> >> > <0>;
> > >> >> >> > +                                       };
> > >> >> >> > +
> > >> >> >> > +
> > >> >> >> > tcon_top_hdmi_in_tcon_tv1:
> > >> >> >> > endpoint@1 { +                                             =
=20
> > >> >> >> > reg
> > >> >> >> > =3D
> > >> >> >> > <1>;
> > >> >> >> > +                                       };
> > >> >> >> > +                               };
> > >> >> >> > +
> > >> >> >> > +                               tcon_top_hdmi_out: port@5 {
> > >> >> >> > +                                       reg =3D <5>;
> > >> >> >> > +
> > >> >> >> > +                                       tcon_top_hdmi_out_hd=
mi:
> > >> >> >> > endpoint {
> > >> >> >> > +                                               remote-endpo=
int
> > >> >> >> > =3D
> > >> >> >> > <&hdmi_in_tcon_top>; +                                      =
 };
> > >> >> >> > +                               };
> > >> >> >> > +                       };
> > >> >> >> > +               };
> > >> >> >> > +
> > >> >> >> > +               tcon_tv0: lcd-controller@1c73000 {
> > >> >> >> > +                       compatible =3D
> > >> >> >> > "allwinner,sun8i-r40-tcon-tv",
> > >> >> >> > +
> > >> >> >> > "allwinner,sun8i-a83t-tcon-tv";
> > >> >> >> > +                       reg =3D <0x01c73000 0x1000>;
> > >> >> >> > +                       interrupts =3D <GIC_SPI 51
> > >> >> >> > IRQ_TYPE_LEVEL_HIGH>;
> > >> >> >> > +                       clocks =3D <&ccu CLK_BUS_TCON_TV0>,
> > >> >> >> > <&tcon_top
> > >> >> >> > 0>;
> > >> >> >> > +                       clock-names =3D "ahb", "tcon-ch1";
> > >> >> >> > +                       resets =3D <&ccu RST_BUS_TCON_TV0>;
> > >> >> >> > +                       reset-names =3D "lcd";
> > >> >> >> > +
> > >> >> >> > +                       ports {
> > >> >> >> > +                               #address-cells =3D <1>;
> > >> >> >> > +                               #size-cells =3D <0>;
> > >> >> >> > +
> > >> >> >> > +                               tcon_tv0_in: port@0 {
> > >> >> >> > +                                       reg =3D <0>;
> > >> >> >> > +                               };
> > >> >> >> > +
> > >> >> >> > +                               tcon_tv0_out: port@1 {
> > >> >> >> > +                                       reg =3D <1>;
> > >> >> >> > +                               };
> > >> >> >> > +                       };
> > >> >> >> > +               };
> > >> >> >> > +
> > >> >> >> > +               tcon_tv1: lcd-controller@1c74000 {
> > >> >> >> > +                       compatible =3D
> > >> >> >> > "allwinner,sun8i-r40-tcon-tv",
> > >> >> >> > +
> > >> >> >> > "allwinner,sun8i-a83t-tcon-tv";
> > >> >> >> > +                       reg =3D <0x01c74000 0x1000>;
> > >> >> >> > +                       interrupts =3D <GIC_SPI 52
> > >> >> >> > IRQ_TYPE_LEVEL_HIGH>;
> > >> >> >> > +                       clocks =3D <&ccu CLK_BUS_TCON_TV1>,
> > >> >> >> > <&tcon_top
> > >> >> >> > 1>;
> > >> >> >> > +                       clock-names =3D "ahb", "tcon-ch1";
> > >> >> >> > +                       resets =3D <&ccu RST_BUS_TCON_TV1>;
> > >> >> >> > +                       reset-names =3D "lcd";
> > >> >> >> > +
> > >> >> >> > +                       ports {
> > >> >> >> > +                               #address-cells =3D <1>;
> > >> >> >> > +                               #size-cells =3D <0>;
> > >> >> >> > +
> > >> >> >> > +                               tcon_tv1_in: port@0 {
> > >> >> >> > +                                       reg =3D <0>;
> > >> >> >> > +                               };
> > >> >> >> > +
> > >> >> >> > +                               tcon_tv1_out: port@1 {
> > >> >> >> > +                                       reg =3D <1>;
> > >> >> >>=20
> > >> >> >> You are missing the remote-endpoints for all the TCON-TOP <->
> > >> >> >> TCON
> > >> >> >> connections. Also, on the driver side, there's no code to hand=
le
> > >> >> >> dynamically mapping mixers to the TCONs that are being used. In
> > >> >> >> the
> > >> >> >> past
> > >> >> >> we
> > >> >> >> had simple 1:1 mappings. This is no longer the case, and it ne=
eds
> > >> >> >> to
> > >> >> >> be
> > >> >> >> dealt with.
> > >> >> >=20
> > >> >> > How would TCON TOP driver know how to set muxes? There are no
> > >> >> > appropriate
> > >> >> > bingings for muxes, except for V4L2 subsystem, which doesn't
> > >> >> > really
> > >> >> > work
> > >> >> > here.
> > >> >>=20
> > >> >> This will end up being a bunch of custom functions exported from =
the
> > >> >> TCON
> > >> >> TOP driver to the TCON driver. As for bindings, the stuff you
> > >> >> already
> > >> >> have
> > >> >> is mostly enough. You do have to specify the endpoint ID vs
> > >> >> component
> > >> >> mapping, so you can find the correct one.
> > >> >>=20
> > >> >> For example, you would specify that the IDs for TCON LCDs be 0 and
> > >> >> 1,
> > >> >> and
> > >> >> TCON TVs be 2 and 3. Matching the actual register values is a nice
> > >> >> convenience. These would be used by the driver as the TCON ID.
> > >> >=20
> > >> > So something that's already done (minus full connections).
> > >> >=20
> > >> >> Also, we might want to consider them as two pairs of two TCONs (L=
CD
> > >> >> +
> > >> >> TV).
> > >> >> The CRTC in DRM land is actually the mixer + TCON on our platform.
> > >> >> This
> > >> >> means we only have two CRTCs. So we could have CRTC 0 =3D mixer 0=
 +
> > >> >> TCON
> > >> >> LCD
> > >> >> 0 + TCON TV 0. The "TCON_TVx_OUTSEL" and "DE_PORTx PERH Select"
> > >> >> muxes
> > >> >> would
> > >> >> be set at run time in the mode set function, selecting either LCD=
 or
> > >> >> TV
> > >> >> based on what encoder is attached.

Any suggestion how to expand sun4i_tcon_find_engine() to match TCON with=20
mixer? Now we have mixer 0 and 1, with TCONs 2 and 3. This means that simpl=
e=20
id matching like this:

https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/sun4i/
sun4i_tcon.c#L865

doesn't work anymore. As we discussed already, this is also a bit SoC=20
specific. Should I add new quirk, which would match mixer id with TCON id w=
ith=20
the SoC specific helper?

This has to be done at probe time, which means it can't be done in mux=20
callback as though earlier.

> > >> >=20
> > >> > That proposal would still limit some combinations. For example, th=
at
> > >> > would
> > >> > put DSI always on mixer1, since it can be connected to only LCD TC=
ON
> > >> > 1.
> > >> > It can also cause undesired combination in laptop solutions. Consi=
der
> > >> > that PCB designer connected LCD1 pins to panel for some reason. Pa=
nel
> > >> > is
> > >> > definetly main screen and should definetly be connected to mixer0,
> > >> > but
> > >> > in
> > >> > that case, it would be to mixer1.
> > >>=20
> > >> There's no reason we can't have dynamically assigned mixer+tcon pair=
s,
> > >> but
> > >> that would mean implementing additional scheduling code that we don't
> > >> have
> > >> yet. The current sunxi-drm and CRTC code assume static mappings.
> > >=20
> > > I just remembered that your proposed solution while should work on R4=
0,
> > > doesn't really fit in H6 case (which is the main reason for this
> > > series).
> > >=20
> > > There are only LCD TCON 0 and TV TCON 0. Their HW IDs are the same as=
 on
> > > R40 (1 and 3). Additionaly, there is also HDMI mux as on R40, although
> > > there is only one TV TCON, which can be used only for HDMI (TV output=
 is
> > > connected to LCD TCON through AC200 bridge, put on same die or glued =
in
> > > same package, not really sure and doesn't really matter).
> >=20
> > OK. So even there's only one TV TCON, you still have to program all mux=
es
> > with the correct value, to prevent a) a bad value left by the bootloader
> > and b) bad reset default values.
> >=20
> > > I would like to write something which is also going to work for H6 out
> > > of
> > > the box. For H6, following combination would work well:
> > > mixer0 =3D LCD TCON 1 + TV TCON 0
> > > mixer1 =3D LCD TCON 0 + TV TCON 1
> > >=20
> > > Or alternatively, we can leave that to mux callback in TCON which wou=
ld
> > > take care for best variant for given SoC.
> >=20
> > I think that is the ultimate goal. However, the muxing would be a bit
> > complicated. For all the past SoCs, we were dealing with muxing the
> > downstream encoder. Now we will be muxing mixer and tcon connections
> > as well. You would also have to dynamically switch around the mixer
> > and/or tcon pointers in sun4i_crtc so existing code can still work.
> >=20
> > > Once we concur on that, I'll try to implement something.
> > >=20
> > >> We could do this as a second step if you're up to it.
> > >=20
> > > For my ultimate goal, which is 1st class Kodi experience on mainline,
> > > current proposal works in any case (mixer1 is enough). I just don't l=
ike
> > > solutions which are not universal.
> > >=20
> > >> > Additionaly, since HDMI would became floating between TV TCON 0 and
> > >> > 1,
> > >> > whoever would write board DT would need to know this and enable on=
ly
> > >> > TV
> > >> > TCON1 if LCD is desired to be connected to mixer0 (or vice versa).
> > >>=20
> > >> There's no reason not to have all TCONs enabled by default. We would
> > >> consider the display-engine node controlling whether everything
> > >> actually
> > >> gets used.
> > >>=20
> > >> > If we really want universal solution with full connections, addtio=
nal
> > >> > property has to be defined and used for that.
> > >> >=20
> > >> >> This limitation is a software one, and should not bleed over into
> > >> >> the
> > >> >> hardware representation.
> > >> >>=20
> > >> >> > Additionaly, how would HDMI know which TCON belongs to it to
> > >> >> > appropriately
> > >> >> > set possible_crtcs?
> > >> >>=20
> > >> >> HDMI is connected to the two TCON TVs through the TCON TOP mux. We
> > >> >> handle
> > >> >> TCON output muxing in the TCON driver, using the set_mux callback=
 in
> > >> >> the
> > >> >> quirks. For R40, this callback would probably call into the TCON =
TOP
> > >> >> driver
> > >> >> asking it to set the mux to some value.
> > >> >>=20
> > >> >> > Currently, my idea is that board DT creates wanted connections.
> > >> >> > Since
> > >> >> > there is only one valid connection for each mux, driver knows
> > >> >> > eactly
> > >> >> > what
> > >> >> > to write into mux register. HDMI driver can simply check which
> > >> >> > TCON
> > >> >> > connection is valid in HDMI input mux and select it in
> > >> >> > possible_crtcs.
> > >> >>=20
> > >> >> But that is not how the actual hardware looks like. The device tr=
ee
> > >> >> should
> > >> >> model the hardware, not a subset of it just because one thinks the
> > >> >> implementation is difficult or won't be used at all.
> > >> >>=20
> > >> >> Furthermore, I think you have it backwards. possible_crtcs is
> > >> >> generated
> > >> >> based on (in our case) the connections between TCON and HDMI based
> > >> >> on
> > >> >> the
> > >> >> device tree graph. So if you have both hooked up, both will show =
up
> > >> >> in
> > >> >> possible_crtcs, but only one crtc will actually be selected to fe=
ed
> > >> >> the
> > >> >> HDMI encoder. If you really need to access the current crtc, the
> > >> >> drm_encoder struct contains a pointer to it.
> > >> >>=20
> > >> >> In DE 1.0 driver, we leave all the muxing to the TCON driver. See
> > >> >>=20
> > >> >>=20
> > >> >> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/su=
n4i
> > >> >> /s
> > >> >> un4
> > >> >> i_
> > >> >> tcon.c#L537
> > >> >>=20
> > >> >> So in a sense, the HDMI encoder should be and is hooked up to both
> > >> >> TCONs,
> > >> >> but only one is active at any given time.
> > >> >=20
> > >> > So something like that I had in v1 series. I'll implement something
> > >> > similar. That would also mean we need R40 specific TV TCON
> > >> > compatible.
> > >> > I'll restore that.
> > >> >=20
> > >> > Just a question on future situation when TVE driver will be
> > >> > implemented.
> > >> > Suppose that R40 board has TVE0 and HDMI as outputs. This would me=
an
> > >> > that
> > >> > TVE0 has possible crtcs set as 0b01 and HDMI 0b11. Will be DRM
> > >> > framework
> > >> > smart enough that it will put HDMI on second crtc because TVE0 can=
 be
> > >> > connected to only to first crtc?
> > >>=20
> > >> Yes. If the possible_clones setting for the encoder is not set, the =
DRM
> > >> framework will not do mirroring, and will keep each active encoder o=
n a
> > >> separate crtc.
> > >>=20
> > >> >> > Please also note that mixer0 and mixer1 don't have same
> > >> >> > capabilities
> > >> >> > and
> > >> >> > you generally want mixer0 to be connected to main output. This =
is
> > >> >> > in
> > >> >> > contrast to DE1 SoCs, where both backends and both frontends ha=
ve
> > >> >> > same
> > >> >> > capability.
> > >> >>=20
> > >> >> Yes. But who's to say the two display outputs can't be reversed or
> > >> >> swapped
> > >> >> around? With fixed singular connections, you also rule out mirror=
ed
> > >> >> output.
> > >> >=20
> > >> > I don't think there is standard way to swap around mixers at runti=
me,
> > >> > expecially if crtcs are represented as mixer + TCON pair.
> > >>=20
> > >> As I mentioned above, we will have to do this on our own.
> > >>=20
> > >> > I'm not sure what do you mean with mirrored output or at least why
> > >> > singular
> > >> > connections would prevent mirroring. HW mirroring needs DRM writeb=
ack
> > >> > support which is currently in RFC phase if I'm not mistaken. Once
> > >> > implemented in DRM framework and in sun4i-drm, it would be possible
> > >> > only
> > >> > to mirror mixer0 -> mixer1, because mixer1 doesn't support writeba=
ck
> > >> > (at
> > >> > least on existing SoCs).
> > >>=20
> > >> What I meant was it might be possible to drive two TCONs with one
> > >> mixer,
> > >> or
> > >> two encoders with one TCON. I guess the latter is not possible since
> > >> each
> > >> TCON only has one channel. Not sure about the former.
> > >=20
> > > I think neither of this two variants are possible, because outputs wo=
uld
> > > have to have exactly the same resolution and in second case even the
> > > same
> > > pixel clock, which is very unlikely.
> >=20
> > That is what mirroring is supposed to mean, right? For instance you cou=
ld
> > have VGA on one and HDMI on the other, at the same resolution and
> > dotclock.
>=20
> Actually, R40 is the first SoC with DE2 where is theoretically possible to
> connect one mixer to multiple TCONs. I didn't try it yet because BPI M2U =
has
> apart from HDMI only DSI connector and TV out on test points and neither
> have support in mainline.

Sorry, I spoke too soon. Actually it's not possible to do that even on R40.=
 So=20
both variants are not possible with current DE2/DE3 SoCs, unless there is=20
something undocumented.=20
=20
Best regards,
Jernej
>=20
> > As far as I'm concerned, the software doesn't need to have all features
> > covered. But that doesn't mean the hardware representation can lack
> > features as well. We already did that once, and now we have some legacy
> > graph parsing code to handle that.
> >=20
> > Regards
> > ChenYu




