Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27614C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F4122218D9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfBHJrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:47:20 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50193 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfBHJrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:47:20 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gs2kb-0000fu-LA; Fri, 08 Feb 2019 10:47:13 +0100
Message-ID: <1549619233.2544.87.camel@pengutronix.de>
Subject: Re: [RFC v2 4/5] arm64: dts: imx8mq: Add nodes for PCIe IP blocks
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 08 Feb 2019 10:47:13 +0100
In-Reply-To: <20190208002941.30343-5-andrew.smirnov@gmail.com>
References: <20190208002941.30343-1-andrew.smirnov@gmail.com>
         <20190208002941.30343-5-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 07.02.2019, 16:29 -0800 schrieb Andrey Smirnov:
> Add nodes for two PCIe controllers found on i.MX8MQ.
> 
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

One minor thing below, otherwise:

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 58 +++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 89babc531380..8ceab748ed04 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -6,6 +6,7 @@
>  
>  #include <dt-bindings/clock/imx8mq-clock.h>
>  #include <dt-bindings/power/imx8mq-power.h>
> +#include <dt-bindings/reset/imx8mq-reset.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include "imx8mq-pinfunc.h"
> @@ -539,6 +540,63 @@
> >  			};
> >  		};
>  
> > > +		pcie0: pcie@33800000 {
> > +			compatible = "fsl,imx8mq-pcie";
> > +			reg = <0x33800000 0x400000>,
> > +			      <0x1ff00000 0x80000>;
> > +			reg-names = "dbi", "config";
> > +			#address-cells = <3>;
> > +			#size-cells = <2>;
> > +			device_type = "pci";
> > +			bus-range = <0x00 0xff>;
> > +			ranges = <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000 /* downstream I/O 64KB */
> > +			          0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
> > +			num-lanes = <1>;
> > +			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "msi";
> > +			#interrupt-cells = <1>;
> > +			interrupt-map-mask = <0 0 0 0x7>;
> > +			interrupt-map = <0 0 0 1 &gic GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> > +			                <0 0 0 2 &gic GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> > +			                <0 0 0 3 &gic GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> > +			                <0 0 0 4 &gic GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> > +			fsl,max-link-speed = <2>;
> > +			power-domains = <&pgc_pcie>;
> > +			resets = <&src IMX8MQ_RESET_PCIEPHY>,
> > +			         <&src IMX8MQ_RESET_PCIE_CTRL_APPS_EN>,
> > +			         <&src IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF>;
> > +			reset-names = "pciephy", "apps", "turnoff";
> > +			status = "disabled";
> > +		};
> +
> +		pcie1: pcie@0x33c00000 {
                            ^
Node name should not have the hex prefix in the address.

> +			compatible = "fsl,imx8mq-pcie";
> > +			reg = <0x33c00000 0x400000>,
> > +			      <0x27f00000 0x80000>;
> > +			reg-names = "dbi", "config";
> > +			#address-cells = <3>;
> > +			#size-cells = <2>;
> > +			device_type = "pci";
> > +			ranges =  <0x81000000 0 0x00000000 0x27f80000 0 0x00010000 /* downstream I/O 64KB */
> > +				   0x82000000 0 0x20000000 0x20000000 0 0x07f00000>; /* non-prefetchable memory */
> > +			num-lanes = <1>;
> > +			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "msi";
> > +			#interrupt-cells = <1>;
> > +			interrupt-map-mask = <0 0 0 0x7>;
> > +			interrupt-map = <0 0 0 1 &gic GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
> > +					<0 0 0 2 &gic GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> > +					<0 0 0 3 &gic GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> > +					<0 0 0 4 &gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> > +			fsl,max-link-speed = <2>;
> > +			power-domains = <&pgc_pcie>;
> > +			resets = <&src IMX8MQ_RESET_PCIEPHY2>,
> > +			         <&src IMX8MQ_RESET_PCIE2_CTRL_APPS_EN>,
> > +			         <&src IMX8MQ_RESET_PCIE2_CTRL_APPS_TURNOFF>;
> > +			reset-names = "pciephy", "apps", "turnoff";
> > +			status = "disabled";
> > +		};
> +
> > >  		gic: interrupt-controller@38800000 {
> >  			compatible = "arm,gic-v3";
> > >  			reg = <0x38800000 0x10000>,	/* GIC Dist */
