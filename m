Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9372C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695CB25A24
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6b/E94G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695CB25A24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932265AbeGBVuR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932079AbeGBVuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:50:13 -0400
Received: from mail-it0-f43.google.com (mail-it0-f43.google.com [209.85.214.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18AC425A08;
        Mon,  2 Jul 2018 21:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530568213;
        bh=eAJTIybtP4me5l3dBFcayUtp0BHalA6P2aS+BLOIDdA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O6b/E94GRElXuHaU2UpL36OdKQaNk5OAQAYmzyizfIpVrYvYz85GgRThAV9UMGY6l
         DAPCq1qCN7+JikXx7hnQjbChZ3UTQM0EmZMl2kLIIQgzcVY2ZDdUduYxDgjkn8vLP3
         hHfI48ZQQu4mmVD0F6CaNl37df7OsimNFM53kTi0=
Received: by mail-it0-f43.google.com with SMTP id y124-v6so1961309itc.0;
        Mon, 02 Jul 2018 14:50:13 -0700 (PDT)
X-Gm-Message-State: APt69E0qxAUKjEvpB1d+f7PLOWW+peqVLFKPyjKaa2OjyMUUTx4zvey+
        8PGsQATOZoH1Hrk9Cv3Nl8ichEuc7nqgojEANg==
X-Google-Smtp-Source: AAOMgpc9IUgbCavEPcaVGZgWm7tVPCZ8P5gGVF18Be4YxEg/79COnxVI78bveCp5XrGHSAVbRT9RQFk/n+mG49FY+ew=
X-Received: by 2002:a24:3ac3:: with SMTP id m186-v6mr7557428itm.106.1530568212513;
 Mon, 02 Jul 2018 14:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <1529978646-28976-1-git-send-email-mars.cheng@mediatek.com> <1529978646-28976-3-git-send-email-mars.cheng@mediatek.com>
In-Reply-To: <1529978646-28976-3-git-send-email-mars.cheng@mediatek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 2 Jul 2018 15:50:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKxvCxn3eb0sZVFwhUudDAkoHH5uyUgt1NY06zt-yKkQQ@mail.gmail.com>
Message-ID: <CAL_JsqKxvCxn3eb0sZVFwhUudDAkoHH5uyUgt1NY06zt-yKkQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: add mt6765 support
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Choui <loda.chou@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Jades Shih <jades.shih@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 8:04 PM Mars Cheng <mars.cheng@mediatek.com> wrote:
>
> This adds basic chip support for MT6765 SoC.
>
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile       |    1 +
>  arch/arm64/boot/dts/mediatek/mt6765-evb.dts |   33 ++++++
>  arch/arm64/boot/dts/mediatek/mt6765.dtsi    |  158 +++++++++++++++++++++++++++
>  3 files changed, 192 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765-evb.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765.dtsi
>
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index ac17f60..7506b0d 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt6765-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt6765-evb.dts b/arch/arm64/boot/dts/mediatek/mt6765-evb.dts
> new file mode 100644
> index 0000000..36dddff2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6765-evb.dts
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dts file for Mediatek MT6765
> + *
> + * (C) Copyright 2018. Mediatek, Inc.
> + *
> + * Mars Cheng <mars.cheng@mediatek.com>
> + */
> +
> +/dts-v1/;
> +#include "mt6765.dtsi"
> +
> +/ {
> +       model = "MediaTek MT6765 EVB";
> +       compatible = "mediatek,mt6765-evb", "mediatek,mt6765";
> +
> +       aliases {
> +               serial0 = &uart0;
> +       };
> +
> +       memory@40000000 {
> +               device_type = "memory";
> +               reg = <0 0x40000000 0 0x1e800000>;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:921600n8";
> +       };
> +};
> +
> +&uart0 {
> +       status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt6765.dtsi b/arch/arm64/boot/dts/mediatek/mt6765.dtsi
> new file mode 100644
> index 0000000..ab34c0f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6765.dtsi
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dts file for Mediatek MT6765
> + *
> + * (C) Copyright 2018. Mediatek, Inc.
> + *
> + * Mars Cheng <mars.cheng@mediatek.com>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +       compatible = "mediatek,mt6765";
> +       interrupt-parent = <&sysirq>;
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       psci {
> +               compatible = "arm,psci-0.2";
> +               method = "smc";
> +       };
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu0: cpu@0 {

Really need labels for cpu nodes?

> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53";
> +                       enable-method = "psci";
> +                       reg = <0x000>;
> +               };
> +
> +               cpu1: cpu@1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53";
> +                       enable-method = "psci";
> +                       reg = <0x001>;
> +               };
> +
> +               cpu2: cpu@2 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53";
> +                       enable-method = "psci";
> +                       reg = <0x002>;
> +               };
> +
> +               cpu3: cpu@3 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53";
> +                       enable-method = "psci";
> +                       reg = <0x003>;
> +               };
> +
> +               cpu4: cpu@100 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53";
> +                       enable-method = "psci";
> +                       reg = <0x100>;
> +               };
> +
> +               cpu5: cpu@101 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53";
> +                       enable-method = "psci";
> +                       reg = <0x101>;
> +               };
> +
> +               cpu6: cpu@102 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53";
> +                       enable-method = "psci";
> +                       reg = <0x102>;
> +               };
> +
> +               cpu7: cpu@103 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53";
> +                       enable-method = "psci";
> +                       reg = <0x103>;
> +               };
> +       };
> +
> +       baud_clk: dummy26m {
> +               compatible = "fixed-clock";
> +               clock-frequency = <26000000>;
> +               #clock-cells = <0>;
> +       };
> +
> +       sys_clk: dummyclk {
> +               compatible = "fixed-clock";
> +               clock-frequency = <26000000>;
> +               #clock-cells = <0>;
> +       };
> +
> +       timer {
> +               compatible = "arm,armv8-timer";
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_PPI 13
> +                            (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 14
> +                            (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 11
> +                            (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 10
> +                            (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +       };
> +
> +       soc {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               compatible = "simple-bus";
> +               ranges;
> +
> +               sysirq: intpol-controller@10200a80 {

interrupt-controller@...

> +                       compatible = "mediatek,mt6765-sysirq",
> +                                    "mediatek,mt6577-sysirq";
> +                       interrupt-controller;
> +                       #interrupt-cells = <3>;
> +                       interrupt-parent = <&gic>;
> +                       reg = <0 0x10200a80 0 0x50>;
> +               };
> +
> +               gic: interrupt-controller@0c000000 {

Drop the leading 0. Build your dts with W=12 and fix the warnings like this.

> +                       compatible = "arm,gic-v3";
> +                       #interrupt-cells = <3>;
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       #redistributor-regions = <1>;
> +                       interrupt-parent = <&gic>;
> +                       interrupt-controller;
> +                       reg = <0 0x0c000000 0 0x40000>, // distributor
> +                             <0 0x0c100000 0 0x200000>; // redistributor
> +                       interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +               };
> +
> +               uart0: serial@11002000 {
> +                       compatible = "mediatek,mt6765-uart",
> +                                    "mediatek,mt6577-uart";
> +                       reg = <0 0x11002000 0 0x400>;
> +                       interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&baud_clk>, <&sys_clk>;
> +                       clock-names = "baud", "bus";
> +                       status = "disabled";
> +               };
> +
> +               uart1: serial@11003000 {
> +                       compatible = "mediatek,mt6765-uart",
> +                                    "mediatek,mt6577-uart";
> +                       reg = <0 0x11003000 0 0x400>;
> +                       interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&baud_clk>, <&sys_clk>;
> +                       clock-names = "baud", "bus";
> +                       status = "disabled";
> +               };
> +       }; /* end of soc */
> +};
> --
> 1.7.9.5
>
