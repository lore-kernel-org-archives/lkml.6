Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 68CB3C07D5C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3E1208BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3E1208BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934525AbeFMB4w (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:56:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36816 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S933577AbeFMB4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:56:50 -0400
X-UUID: 676123d323f742db86d7da1f517cc904-20180613
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1704438647; Wed, 13 Jun 2018 09:56:46 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 13 Jun 2018 09:56:44 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 13 Jun 2018 09:56:38 +0800
Message-ID: <1528854998.5296.7.camel@mtkswgap22>
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: add mt6765 support
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Jades Shih <jades.shih@mediatek.com>,
        "Yingjoe Chen" <yingjoe.chen@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Wed, 13 Jun 2018 09:56:38 +0800
In-Reply-To: <CAL_JsqJX3VF0YPMqcYAG53ib1SO8eFfFsFP39XMHO5YiHLWq1Q@mail.gmail.com>
References: <1528843243-29782-1-git-send-email-mars.cheng@mediatek.com>
         <1528843243-29782-3-git-send-email-mars.cheng@mediatek.com>
         <CAL_JsqJX3VF0YPMqcYAG53ib1SO8eFfFsFP39XMHO5YiHLWq1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt6765-evb.dts
> > @@ -0,0 +1,39 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2018 MediaTek Inc.
> > + * Author: Mars.C <mars.cheng@mediatek.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> 
> With the SPDX tag, you can drop the license text.

Got it, will fix it.
> 
> > + */
> > +
> > +/dts-v1/;
> > +#include "mt6765.dtsi"
> > +
> > +/ {
> > +       model = "MediaTek MT6765 EVB";
> > +       compatible = "mediatek,mt6765-evb", "mediatek,mt6765";
> > +
> > +       aliases {
> > +               serial0 = &uart0;
> > +       };
> > +
> > +       memory@40000000 {
> > +               device_type = "memory";
> > +               reg = <0 0x40000000 0 0x1e800000>;
> > +       };
> > +
> > +       chosen {
> > +               stdout-path = "serial0:921600n8";
> > +       };
> > +};
> > +
> > +&uart0 {
> > +       status = "okay";
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt6765.dtsi b/arch/arm64/boot/dts/mediatek/mt6765.dtsi
> > new file mode 100644
> > index 0000000..7222a5e
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt6765.dtsi
> > @@ -0,0 +1,148 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2018 MediaTek Inc.
> > + * Author: Mars.C <mars.cheng@mediatek.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> 
> ditto

Got it.

> 
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +/ {
> > +       compatible = "mediatek,mt6765";
> > +       interrupt-parent = <&sysirq>;
> > +       #address-cells = <2>;
> > +       #size-cells = <2>;
> > +
> > +       psci {
> > +               compatible = "arm,psci-0.2";
> > +               method = "smc";
> > +       };
> > +
> > +       cpus {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               cpu0: cpu@0 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       enable-method = "psci";
> > +                       reg = <0x000>;
> > +               };
> > +
> > +               cpu1: cpu@1 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       enable-method = "psci";
> > +                       reg = <0x001>;
> > +               };
> > +
> > +               cpu2: cpu@2 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       enable-method = "psci";
> > +                       reg = <0x002>;
> > +               };
> > +
> > +               cpu3: cpu@3 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       enable-method = "psci";
> > +                       reg = <0x003>;
> > +               };
> > +
> > +               cpu4: cpu@100 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       enable-method = "psci";
> > +                       reg = <0x100>;
> > +               };
> > +
> > +               cpu5: cpu@101 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       enable-method = "psci";
> > +                       reg = <0x101>;
> > +               };
> > +
> > +               cpu6: cpu@102 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       enable-method = "psci";
> > +                       reg = <0x102>;
> > +               };
> > +
> > +               cpu7: cpu@103 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       enable-method = "psci";
> > +                       reg = <0x103>;
> > +               };
> > +       };
> > +
> > +       uart_clk: dummy26m {
> > +               compatible = "fixed-clock";
> > +               clock-frequency = <26000000>;
> > +               #clock-cells = <0>;
> > +       };
> > +
> > +       timer {
> > +               compatible = "arm,armv8-timer";
> > +               interrupt-parent = <&gic>;
> > +               interrupts = <GIC_PPI 13
> > +                            (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > +                            <GIC_PPI 14
> > +                            (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > +                            <GIC_PPI 11
> > +                            (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > +                            <GIC_PPI 10
> > +                            (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> > +       };
> > +
> > +       sysirq: intpol-controller@10200a80 {
> 
> This and others with an address should go under a simple-bus node.
> 
> Node name should be 'interrupt-controller@...'

Got it, will fix them.

> 
> > +               compatible = "mediatek,mt6765-sysirq",
> > +                            "mediatek,mt6577-sysirq";
> > +               interrupt-controller;
> > +               #interrupt-cells = <3>;
> > +               interrupt-parent = <&gic>;
> > +               reg = <0 0x10200a80 0 0x50>;
> > +       };
> > +
> > +       gic: interrupt-controller@0c000000 {
> 
> Drop the leading 0.

Got it, will fix it.

> 
> > +               compatible = "arm,gic-v3";
> > +               #interrupt-cells = <3>;
> > +               #address-cells = <2>;
> > +               #size-cells = <2>;
> > +               #redistributor-regions = <1>;
> > +               interrupt-parent = <&gic>;
> > +               interrupt-controller;
> > +               reg = <0 0x0c000000 0 0x40000>, // distributor
> > +                     <0 0x0c100000 0 0x200000>; // redistributor
> > +               interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +       };
> > +
> > +       uart0: serial@11002000 {
> > +               compatible = "mediatek,mt6765-uart",
> > +                            "mediatek,mt6577-uart";
> > +               reg = <0 0x11002000 0 0x400>;
> > +               interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
> > +               clocks = <&uart_clk>;
> > +               status = "disabled";
> > +       };
> > +
> > +       uart1: serial@11003000 {
> > +               compatible = "mediatek,mt6765-uart",
> > +                            "mediatek,mt6577-uart";
> > +               reg = <0 0x11003000 0 0x400>;
> > +               interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
> > +               clocks = <&uart_clk>;
> > +               status = "disabled";
> > +       };
> > +};
> > --
> > 1.7.9.5
> >


