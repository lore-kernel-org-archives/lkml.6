Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EF9C0C5CFF1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904842086D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQOYhSfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904842086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935022AbeFMA6v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 20:58:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934873AbeFMA6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 20:58:49 -0400
Received: from mail-it0-f48.google.com (mail-it0-f48.google.com [209.85.214.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3591F2086D;
        Wed, 13 Jun 2018 00:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528851529;
        bh=buzK2ilUfmUUt4bukUGi7TizpqIyFfV8Td4QI8rjAk8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=MQOYhSfUyzGtEzdFlHuyePq5W64doizfQNVZEbcr+w5AL1ZBU0ypLsYGM39SfZAVN
         3nZazo6WJskJVhf7fdRkcn4AN6OXr6KSFoLED0mysgStxP5v2ehqnl+jDZpq7GrpNI
         T8MhbtKrjmzFMNEQMs+WO+SszVRwhNJWjqfBATwk=
Received: by mail-it0-f48.google.com with SMTP id 188-v6so1715672ita.5;
        Tue, 12 Jun 2018 17:58:49 -0700 (PDT)
X-Gm-Message-State: APt69E3a5jSmW7O2vCDj7epSxmmoRZj6Z1+2CTv6BH9CdVAXzB52FIvC
        LZdLgcWHKOFigOiYF+ja5zLiqRN/yPjWSahs4Q==
X-Google-Smtp-Source: ADUXVKJ2jEd/fcEoLxVk4wyYaXjVO28T6W9nRuoeVu+4QtjQRtYOnEQPUy6dV0mdoHpCqpVg+xtGW/piCQyevLNET8g=
X-Received: by 2002:a24:f04e:: with SMTP id p14-v6mr2763444iti.106.1528851528623;
 Tue, 12 Jun 2018 17:58:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 17:58:28
 -0700 (PDT)
In-Reply-To: <1528843243-29782-3-git-send-email-mars.cheng@mediatek.com>
References: <1528843243-29782-1-git-send-email-mars.cheng@mediatek.com> <1528843243-29782-3-git-send-email-mars.cheng@mediatek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 12 Jun 2018 18:58:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJX3VF0YPMqcYAG53ib1SO8eFfFsFP39XMHO5YiHLWq1Q@mail.gmail.com>
Message-ID: <CAL_JsqJX3VF0YPMqcYAG53ib1SO8eFfFsFP39XMHO5YiHLWq1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: add mt6765 support
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Jades Shih <jades.shih@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 4:40 PM, Mars Cheng <mars.cheng@mediatek.com> wrote:
> This adds basic chip support for MT6765 SoC.
>
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile       |    1 +
>  arch/arm64/boot/dts/mediatek/mt6765-evb.dts |   39 +++++++
>  arch/arm64/boot/dts/mediatek/mt6765.dtsi    |  148 +++++++++++++++++++++++++++
>  3 files changed, 188 insertions(+)
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
> index 0000000..e5efbe5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6765-evb.dts
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Mars.C <mars.cheng@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

With the SPDX tag, you can drop the license text.

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
> index 0000000..7222a5e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6765.dtsi
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Mars.C <mars.cheng@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

ditto

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
> +       uart_clk: dummy26m {
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
> +       sysirq: intpol-controller@10200a80 {

This and others with an address should go under a simple-bus node.

Node name should be 'interrupt-controller@...'

> +               compatible = "mediatek,mt6765-sysirq",
> +                            "mediatek,mt6577-sysirq";
> +               interrupt-controller;
> +               #interrupt-cells = <3>;
> +               interrupt-parent = <&gic>;
> +               reg = <0 0x10200a80 0 0x50>;
> +       };
> +
> +       gic: interrupt-controller@0c000000 {

Drop the leading 0.

> +               compatible = "arm,gic-v3";
> +               #interrupt-cells = <3>;
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               #redistributor-regions = <1>;
> +               interrupt-parent = <&gic>;
> +               interrupt-controller;
> +               reg = <0 0x0c000000 0 0x40000>, // distributor
> +                     <0 0x0c100000 0 0x200000>; // redistributor
> +               interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
> +       uart0: serial@11002000 {
> +               compatible = "mediatek,mt6765-uart",
> +                            "mediatek,mt6577-uart";
> +               reg = <0 0x11002000 0 0x400>;
> +               interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
> +               clocks = <&uart_clk>;
> +               status = "disabled";
> +       };
> +
> +       uart1: serial@11003000 {
> +               compatible = "mediatek,mt6765-uart",
> +                            "mediatek,mt6577-uart";
> +               reg = <0 0x11003000 0 0x400>;
> +               interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
> +               clocks = <&uart_clk>;
> +               status = "disabled";
> +       };
> +};
> --
> 1.7.9.5
>
