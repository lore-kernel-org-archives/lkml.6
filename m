Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B593C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6E120685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6E120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeJaR4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 13:56:04 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45239 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbeJaR4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 13:56:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id t10-v6so12903931eds.12;
        Wed, 31 Oct 2018 01:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrXyZxyqqnmoh9o1+n4x84Ppe6TJ6Yo5dxijHp2cnOQ=;
        b=Bv2VAQhnb+bpIAlFKISY1sROP1RluO4p8+rG7KIDKABZHTzTcgZm7tADfl6o3Ho5RT
         9ol7QojD1pspowBk74oWtG4xUjP4lEF6GGJhoPubGPi5dPE4tb4+B8q4PeMseCpz2BQQ
         uSQRCM5t68TvZprg8XSZP1ISBnlAsUoDSyAG6+8Ly/qIfl0LdMTucMXW7iQunU2qMQ0a
         1ps4xCuaAd67ql6kb8np9eG41oRJJgmdzVk+4t+TQ+esWfzr9nV0w8Zo+H26aguF7VMt
         +a7atXhLwOWRzZWrqQzpyIiprAq2UFnX3XZpY5Mwn13UcoLh8UhJ4QHP4Qb3h9g8q+ud
         y90Q==
X-Gm-Message-State: AGRZ1gKMK2/0F3JQKmNBEi2SvON7tOIsWtBzYcjfAbEmmFN9ubBdje8O
        9Fc4j5py+CX+juCYnx2ueHI5Ud5Q2MY=
X-Google-Smtp-Source: AJdET5dCZ3UHG6Y0+fkHNAO9F8yA//PKSEylY/JwFumtCGnTGSrQ0j+wbCxnM3X8F7Pbxmh7nTALNw==
X-Received: by 2002:a50:fb94:: with SMTP id e20-v6mr1330446edq.153.1540976328349;
        Wed, 31 Oct 2018 01:58:48 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id dc5-v6sm4693376ejb.13.2018.10.31.01.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 01:58:47 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id y140-v6so713980wmd.0;
        Wed, 31 Oct 2018 01:58:47 -0700 (PDT)
X-Received: by 2002:a1c:9f01:: with SMTP id i1-v6mr1565871wme.8.1540976327040;
 Wed, 31 Oct 2018 01:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <CGME20181029111305epcas5p2ee0ca644470de4e036762e000afbb71b@epcas5p2.samsung.com>
 <20181026144344.27778-18-jagan@amarulasolutions.com> <3c4c8a08-8c1e-1ac6-2b53-81389d69c97b@samsung.com>
In-Reply-To: <3c4c8a08-8c1e-1ac6-2b53-81389d69c97b@samsung.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 31 Oct 2018 16:58:34 +0800
X-Gmail-Original-Message-ID: <CAGb2v66ENhmNXPz4PfdRJjNUNdpDNZYX2a3SH8AD6SMe9g2zLA@mail.gmail.com>
Message-ID: <CAGb2v66ENhmNXPz4PfdRJjNUNdpDNZYX2a3SH8AD6SMe9g2zLA@mail.gmail.com>
Subject: Re: [PATCH v3 17/25] dt-bindings: panel: Add Bananapi S070WV20-CT16
 ICN6211 MIPI-DSI to RGB bridge
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
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
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 4:53 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> On 26.10.2018 16:43, Jagan Teki wrote:
> > Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB
> > bridge panel, which is available on same PCB with 24-bit RGB interface.
> >
> > So, this patch adds DSI specific binding details on existing
> > dt-bindings file.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v3:
> > - Use existing binding doc and update dsi details
> > Changes for v2:
> > - none
> >
> >  .../display/panel/bananapi,s070wv20-ct16.txt  | 31 +++++++++++++++++--
> >  1 file changed, 29 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> > index 35bc0c839f49..b7855dc7c66f 100644
> > --- a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> > +++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> > @@ -1,12 +1,39 @@
> >  Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
> >
> > +S070WV20-CT16 is 7" 800x480 panel connected through a 24-bit RGB interface.
> > +
> > +Depending on the variant, the PCB attached to the panel module either
> > +supports DSI, or DSI + 24-bit RGB. DSI is converted to 24-bit RGB via
> > +an onboard ICN6211 MIPI DSI - RGB bridge chip, then fed to the panel
> > +itself
>
> As I understand this is display board, which contains 'pure' RGB panel
> S070WV20-CT16 and optionally ICN6211 DSI->RGB bridge.
> These are separate devices, just connected by vendor to simplify its
> assembly. Why don't you create then bridge driver for ICN6211 and RGB
> panel driver for S070WV20-CT16 - it looks more generic.
> Then you can describe both in dts and voila.
> Creating drivers for every combo of devices (panel + bridge), just
> because some vendor sells them together seems incorrect - we have
> devicetree for it.

Rob suggested this, and also the opposite: using the same
"bananapi,s070wv20-ct16"
compatible string for both types of connections, and have the driver deal with
detecting the bus type.

The thing about the bridge chip is that there's no available datasheet that
describes all the parts of the init sequence, in fact none at all. I managed
to work out some bits, but the others remain a mystery and must be hard-coded
to match the panel. That would work against having a generic bridge driver.

ChenYu

>
> Regards
> Andrzej
>
>
> > +
> >  Required properties:
> > -- compatible: should be "bananapi,s070wv20-ct16"
> > +- compatible:
> > +  for 24-bit RGB interface, use "bananapi,s070wv20-ct16"
> > +  for ICN6211 MIPI-DSI to RGB bridge, use "bananapi,s070wv20-ct16-icn6211"
> > +
> > +Required properties for RGB:
> >  - power-supply: see ./panel-common.txt
> >
> > +Required properties for MIPI-DSI to RGB:
> > +- reg: for DSI virtual channel used by that screen
> > +- avdd-supply: analog regulator dc1 switch
> > +- dvdd-supply: 3v3 digital regulator
> > +- reset-gpios: a GPIO phandle for the reset pin
> > +
> >  Optional properties:
> > -- enable-gpios: see ./simple-panel.txt
> > +- enable-gpios: see ./simple-panel.txt(not available in MIPI-DSI to RGB bridge)
> >  - backlight: see ./simple-panel.txt
> >
> >  This binding is compatible with the simple-panel binding, which is specified
> >  in ./simple-panel.txt.
> > +
> > +Example:
> > +panel@0 {
> > +     compatible = "bananapi,s070wv20-ct16-icn6211";
> > +     reg = <0>;
> > +     avdd-supply = <&reg_dc1sw>;
> > +     dvdd-supply = <&reg_dldo1>;
> > +     reset-gpios = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
> > +     backlight = <&backlight_dsi>;
> > +};
>
>
