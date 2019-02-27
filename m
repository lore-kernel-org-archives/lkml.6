Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF753C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6A920C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MYjvQKza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbfB0QTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:19:36 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35304 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfB0QTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:19:35 -0500
Received: by mail-it1-f196.google.com with SMTP id 188so10765236itb.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 08:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Og9A9bYUy/MyMtOP3Wtz7MhFcTOqKPfpnS6nwjVx/hc=;
        b=MYjvQKzavvbbMa2BCdrtI7O8W7XCrGEb1ggTM9JptOX0chzI/VsAlDDo2OR8ZjMKlQ
         qSz5ia/FsYj86vp+9BoZq777tOWYykxko8SqNkaMiqrmwT8oSJFDM1UbqnhQKlgFPKWt
         scV0Ab+AN9WjUeJ4419YbSmLvlYSFuxM3FCfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Og9A9bYUy/MyMtOP3Wtz7MhFcTOqKPfpnS6nwjVx/hc=;
        b=OddPueLCEseJOo2GBEbMK1EPrjBfwNVKBkxvyfynF2NCZJcOUMTOZZGdM0DIExP1AL
         /FqitKVgJSNT19rUV8Za/dqeUtfc7jH8SxVwwcgBrlGO/HX1LXv4WUcYeJnn1Xlt8TMP
         9ljQvbUtrlZ4Kl8GUz3iacSGEqED4c38zsRUBj23PlPFfIoH9QG5jdwLuLImfPGaNDXo
         i+gwsoM4AZdxYnjIkbw749ZMF72RK9Wq+4MVR5DxTk0ccKs3sYEEaxQY5FEqvDuVmO4I
         9P9WgR/iVixkBq58/SOkv8h74xCvlaAwUdl/CmeENHDML9Dq1O9bTFljF3YMfoN3KKWX
         z2oA==
X-Gm-Message-State: APjAAAWcFgLevqmHJAd38F5+zubkfOYzQRh9jtGAQCz+6SQWafyWe+Nm
        trMZnz9s0VAOU83GllUM1wzzADTW31989jywxlvc3Q==
X-Google-Smtp-Source: APXvYqwTALR+i1dh0igEzhafigfIp0UNj2DmOcoHgne22OBdYGoUxulj9tym4ImcrEufIFfwQ+XTyDEy8nGisN7Dbvc=
X-Received: by 2002:a24:3655:: with SMTP id l82mr31378itl.107.1551284374499;
 Wed, 27 Feb 2019 08:19:34 -0800 (PST)
MIME-Version: 1.0
References: <20190226060240.8783-1-jagan@amarulasolutions.com>
 <20190226060240.8783-2-jagan@amarulasolutions.com> <20190227153346.dwd3stsbsvf7rwly@flea>
In-Reply-To: <20190227153346.dwd3stsbsvf7rwly@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 27 Feb 2019 21:49:23 +0530
Message-ID: <CAMty3ZDSZvaxMjcQJLNaTDJQ5OjJ9NbjpOJKWMUE5PhRCzYvqw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: allwinner: a64: Add Oceanic A64-5inMFD initial support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Pannell <ryan@osukl.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 9:03 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Tue, Feb 26, 2019 at 11:32:40AM +0530, Jagan Teki wrote:
> > Oceanic A64-5inMFD is a 5 inch Multi function display baseboard
> > designed to mount SoPine SOM.
> >
> > Key features:
> > - Allwinner A64 Cortex-A53
> > - Mali-400MP2 GPU
> > - AXP803 PMIC
> > - 2GB DDR3 RAM
> > - SD Slot
> > - SPI-NOR flash
> > - EMAC, RTL8211E
> > - MCP2515 CAN
> > - MIPI-DSI
> > - Goodix 911 CTP
> > - USB Host
> > - 12V DC power supply
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
> >  .../allwinner/sun50i-a64-oceanic-5inmfd.dts   | 46 +++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> > index a5fb1eaa8acf..ec39fe856117 100644
> > --- a/arch/arm64/boot/dts/allwinner/Makefile
> > +++ b/arch/arm64/boot/dts/allwinner/Makefile
> > @@ -2,6 +2,7 @@
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-amarula-relic.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-bananapi-m64.dtb sun50i-a64-bananapi-m64-icn6211.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-nanopi-a64.dtb
> > +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-oceanic-5inmfd.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-olinuxino.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-orangepi-win.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-lts.dtb
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts
> > new file mode 100644
> > index 000000000000..d73d1f55acb9
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts
> > @@ -0,0 +1,46 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (C) 2019 Oceanic Systems (UK) Ltd.
> > + * Copyright (C) 2019 Amarula Solutions B.V.
> > + * Author: Jagan Teki <jagan@amarulasolutions.com>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sun50i-a64-sopine.dtsi"
> > +
> > +/ {
> > +     model = "Oceanic A64-5inMFD";
> > +     compatible = "oceanic,a64-5inmfd", "allwinner,sun50i-a64";
>
> The name of the DT is Oceanic 5inMFD, while you call the board
> A64-5inMFD here, which name is the actual name?

Yes, this is something that we discussed during "Amarula A64-Relic"
naming convention.

Since these boards are not famous like teres-i we agreed to add vendor
name after sun50i-a64- followed by real board name.

Here A64 already covered during sun50i-a64- so the dts name simply the
<vendor_name>-<real_board_name>

>
> > +
> > +     aliases {
> > +             serial0 = &uart0;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path = "serial0:115200n8";
> > +     };
> > +};
> > +
> > +&ehci0 {
> > +     status = "okay";
> > +};
> > +
> > +&ohci0 {
> > +     status = "okay";
> > +};
> > +
> > +&uart0 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&uart0_pb_pins>;
> > +     status = "okay";
> > +};
> > +
> > +&usb_otg {
> > +     dr_mode = "host";
> > +     status = "okay";
> > +};
> > +
> > +&usbphy {
> > +     status = "okay";
> > +};
>
> Is the OTG controller really is only capable of running in host mode?

Yes, USB on baseboard is similar like sopine-baseboard
