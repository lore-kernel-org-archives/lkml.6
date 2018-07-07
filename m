Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D939C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF1A2251A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF1A2251A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932824AbeGGDcE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 23:32:04 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37261 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932635AbeGGDcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 23:32:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id v22-v6so9948733edq.4;
        Fri, 06 Jul 2018 20:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3/6cDOYK3avrZU0/Z4dpzyxffBKRhO/20+otxQkI8lU=;
        b=UFSSdVzYmf1hQsIdOKv4c+EiJEERqeQt4K4DG7ktZzba3gtrBdM2OuSQmWIR5eReZB
         0J7R3Qie7g9vmP79PuUqR4JBbD9owJn74pjFE1bEOda2dTF3k56WNoViUyRleX1DOK0Y
         Njch8JMAMzTbc4zzqKvMP/fme2Ol5vame15pC7PyDUT0U7rBb/QNdt373c55cqjp8alg
         5c8nGxSELFHXAzeAxGjTR5//6EGiXImV1y9jmguTHOg2GkeeKPQpJxwzjvnC7aT5kq8s
         N+r2z2DozKmfcwuz2/a/+7K6q0O3UdCC+F6LYgGmvzwMHvPYfxrEpUNyRfa/DXIpy8tJ
         sYdw==
X-Gm-Message-State: APt69E2ZbpZ7xcZoMs/MS1pgtyLSY+z/HhBA3tSpVxaATc4MvN8zGnV0
        oz8mfMoS5v+WYs0+1ejXkLBcwVq5
X-Google-Smtp-Source: AAOMgpc5UwRk84j5pETPnal7VjvAr6nntTew41WTSWiQfxBC57RIDek2OEEE9qArkHF6sTUAKuvoBw==
X-Received: by 2002:a50:93c5:: with SMTP id o63-v6mr13319625eda.154.1530934321231;
        Fri, 06 Jul 2018 20:32:01 -0700 (PDT)
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com. [74.125.82.50])
        by smtp.gmail.com with ESMTPSA id d11-v6sm5394405edo.63.2018.07.06.20.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 20:32:00 -0700 (PDT)
Received: by mail-wm0-f50.google.com with SMTP id z13-v6so15971447wma.5;
        Fri, 06 Jul 2018 20:32:00 -0700 (PDT)
X-Received: by 2002:a1c:8c12:: with SMTP id o18-v6mr7256331wmd.120.1530934320222;
 Fri, 06 Jul 2018 20:32:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 20:31:39 -0700 (PDT)
In-Reply-To: <20180706153805.25842-4-icenowy@aosc.io>
References: <20180706153805.25842-1-icenowy@aosc.io> <20180706153805.25842-4-icenowy@aosc.io>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 7 Jul 2018 11:31:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v663fgFQTHGCMmKwuf4RyW59YSbhtyr5nLBRRxakkEfRzw@mail.gmail.com>
Message-ID: <CAGb2v663fgFQTHGCMmKwuf4RyW59YSbhtyr5nLBRRxakkEfRzw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 3/9] arm64: allwinner: dts: h6: add
 USB2-related device nodes
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 11:37 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Allwinner H6 has two USB2 ports, one OTG and one host-only.
>
> Add device tree nodes related to them.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 90 ++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index c72da8cd9ef5..62fc0f5e10ba 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -174,6 +174,96 @@
>                         status = "disabled";
>                 };
>
> +               usb2otg: usb@5100000 {
> +                       compatible = "allwinner,sun8i-a33-musb";
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
> +               usb3phy: phy@5210000 {

Maybe you should split this one out and put it in the USB 3.0 patch?

ChenYu

> +                       compatible = "allwinner,sun50i-h6-usb3-phy";
> +                       reg = <0x5210000 0x10000>;
> +                       clocks = <&ccu CLK_USB_PHY1>;
> +                       resets = <&ccu RST_USB_PHY1>;
> +                       #phy-cells = <0>;
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
>                 r_ccu: clock@7010000 {
>                         compatible = "allwinner,sun50i-h6-r-ccu";
>                         reg = <0x07010000 0x400>;
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
