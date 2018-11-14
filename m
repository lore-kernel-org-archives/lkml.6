Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD765C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF7F2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF7F2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732766AbeKNUYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:24:35 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42100 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbeKNUYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:24:35 -0500
Received: by mail-ed1-f67.google.com with SMTP id j6so8159327edp.9;
        Wed, 14 Nov 2018 02:21:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NyI4zlt3ENMEtsl6srjlGkp8VgEV9Zi81V1qPxmM7FM=;
        b=MgeP7dECTA8mLZriMN7pzKkZE6euxL/WSIhBOIpRDK7alKbvUp7EIrwoJNZvAB4XgT
         1ogz47nTEuuV6fLm4H2/3gnthNHbYk9UJM3oAHDC4XCJne8ku/Pb7Z44gqNeTpxSBoZ0
         1vZrqpG/enxootW12fOUsqjHZQLARw8j49KoNh0nWQoskbYYO7xSafCGWvkLgqg7Q3O0
         kvmHB5MAb/sUpoJ8LvfJHbYdHaBPLYxk9VJsFFioKiCNnYxCKWIYWIkQwiEsdLN27l6P
         WEgPQIFEoL3836x0C5mltrdyzmnsvFyFiScevNSSLHbrj4Mqa0LwE/G+3nqD+yJ1JvAC
         hirA==
X-Gm-Message-State: AGRZ1gIIBA0aHT2Ow58zPITdsFwXV/NquXzTyvlvPrBGd+Lj1fkUfe8E
        5tuA0Js5Ws9A/bv2F++1qkRKADXTR60=
X-Google-Smtp-Source: AJdET5eSJYTqFrAdzl6q0SOvlSiHNBRvf4joIg6GzZytJT6c9oGcGv86A/CIyDRPJsLo12HKmdd5SA==
X-Received: by 2002:a50:ccdd:: with SMTP id b29mr1595990edj.102.1542190915042;
        Wed, 14 Nov 2018 02:21:55 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id o31-v6sm6049526eda.72.2018.11.14.02.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 02:21:54 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id f1-v6so13129642wmg.1;
        Wed, 14 Nov 2018 02:21:54 -0800 (PST)
X-Received: by 2002:a1c:9f01:: with SMTP id i1-v6mr1316165wme.8.1542190914018;
 Wed, 14 Nov 2018 02:21:54 -0800 (PST)
MIME-Version: 1.0
References: <20181004122855.22981-1-icenowy@aosc.io> <20181004122855.22981-5-icenowy@aosc.io>
In-Reply-To: <20181004122855.22981-5-icenowy@aosc.io>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 14 Nov 2018 18:21:33 +0800
X-Gmail-Original-Message-ID: <CAGb2v668dozjLm9mWUw_Y12AZ6DM2ku9dgQ8B8feABNeFf3QSw@mail.gmail.com>
Message-ID: <CAGb2v668dozjLm9mWUw_Y12AZ6DM2ku9dgQ8B8feABNeFf3QSw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v4 04/10] arm64: allwinner: dts: h6: add
 USB2-related device nodes
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 4, 2018 at 8:30 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> Allwinner H6 has two USB2 ports, one OTG and one host-only.
>
> Add device tree nodes related to them.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> ---
> No changes in v4.
>
> Changes in v3:
> - Removed the wrongly introduced usb3phy node.
> - Added Chen-Yu's Review tag.
>
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 81 ++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 040828d2e2c0..3d60af6cb3ae 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -258,6 +258,87 @@
>                         status = "disabled";
>                 };
>
> +               usb2otg: usb@5100000 {
> +                       compatible = "allwinner,sun8i-a33-musb";

I added an SoC-specific compatible: "allwinner,sun50i-h6-musb".

I'm also curious as to whether the MUSB controller was tested or not,
since Allwinner now has EHCI/OHCI host pairs for host mode, and the Pine H64
only does host mode.

> +                       reg = <0x05100000 0x0400>;
> +                       clocks = <&ccu CLK_BUS_OTG>;
> +                       resets = <&ccu RST_BUS_OTG>;
> +                       interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "mc";
> +                       phys = <&usb2phy 0>;
> +                       phy-names = "usb";
> +                       extcon = <&usb2phy 0>;
> +                       status = "disabled";
> +               };
> +
> +               usb2phy: phy@5100400 {
> +                       compatible = "allwinner,sun50i-h6-usb-phy";
> +                       reg = <0x05100400 0x14>,
> +                             <0x05101800 0x4>,
> +                             <0x05311800 0x4>;
> +                       reg-names = "phy_ctrl",
> +                                   "pmu0",
> +                                   "pmu3";
> +                       clocks = <&ccu CLK_USB_PHY0>,
> +                                <&ccu CLK_USB_PHY3>;
> +                       clock-names = "usb0_phy",
> +                                     "usb3_phy";
> +                       resets = <&ccu RST_USB_PHY0>,
> +                                <&ccu RST_USB_PHY3>;
> +                       reset-names = "usb0_reset",
> +                                     "usb3_reset";
> +                       status = "disabled";
> +                       #phy-cells = <1>;
> +               };
> +
> +               ehci0: usb@5101000 {
> +                       compatible = "allwinner,sun50i-h6-ehci", "generic-ehci";
> +                       reg = <0x05101000 0x100>;
> +                       interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_OHCI0>,
> +                                <&ccu CLK_BUS_EHCI0>,
> +                                <&ccu CLK_USB_OHCI0>;
> +                       resets = <&ccu RST_BUS_OHCI0>,
> +                                <&ccu RST_BUS_EHCI0>;
> +                       status = "disabled";
> +               };
> +
> +               ohci0: usb@5101400 {
> +                       compatible = "allwinner,sun50i-h6-ohci", "generic-ohci";
> +                       reg = <0x05101400 0x100>;
> +                       interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_OHCI0>,
> +                                <&ccu CLK_USB_OHCI0>;
> +                       resets = <&ccu RST_BUS_OHCI0>;
> +                       status = "disabled";
> +               };
> +
> +               ehci3: usb@5311000 {
> +                       compatible = "allwinner,sun50i-h6-ehci", "generic-ehci";
> +                       reg = <0x05311000 0x100>;
> +                       interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_OHCI3>,
> +                                <&ccu CLK_BUS_EHCI3>,
> +                                <&ccu CLK_USB_OHCI3>;
> +                       resets = <&ccu RST_BUS_OHCI3>,
> +                                <&ccu RST_BUS_EHCI3>;
> +                       phys = <&usb2phy 3>;
> +                       phy-names = "usb";
> +                       status = "disabled";
> +               };
> +
> +               ohci3: usb@5311400 {
> +                       compatible = "allwinner,sun50i-h6-ohci", "generic-ohci";
> +                       reg = <0x05311400 0x100>;
> +                       interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_OHCI3>,
> +                                <&ccu CLK_USB_OHCI3>;
> +                       resets = <&ccu RST_BUS_OHCI3>;
> +                       phys = <&usb2phy 3>;
> +                       phy-names = "usb";
> +                       status = "disabled";
> +               };
> +

This didn't apply cleanly due to the new HDMI nodes. I fixed it up locally.

ChenYu

>                 r_ccu: clock@7010000 {
>                         compatible = "allwinner,sun50i-h6-r-ccu";
>                         reg = <0x07010000 0x400>;
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
