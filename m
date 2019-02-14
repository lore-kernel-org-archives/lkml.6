Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFD3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CBD218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395084AbfBNPuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:50:40 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48685 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfBNPuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:50:39 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1guJHR-00048B-AM; Thu, 14 Feb 2019 16:50:29 +0100
Message-ID: <1550159428.2546.40.camel@pengutronix.de>
Subject: Re: [RFC 5/5] arm64: dts: imx8mq: Add the opp table and the
 cpu-supply nodes
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Anson Huang <anson.huang@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Date:   Thu, 14 Feb 2019 16:50:28 +0100
In-Reply-To: <1550084693-9797-6-git-send-email-abel.vesa@nxp.com>
References: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
         <1550084693-9797-6-git-send-email-abel.vesa@nxp.com>
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

Hi Abel

Am Mittwoch, den 13.02.2019, 19:05 +0000 schrieb Abel Vesa:
> Add the opp table containing only non over drive opps.
> Also add the cpu-supply nodes for the A53 cores in the EVK board.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 17 +++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 23 +++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index 54737bf..114359e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -31,6 +31,23 @@
>  		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  	};
> +
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&sw1a_reg>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&sw1a_reg>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&sw1a_reg>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&sw1a_reg>;
>  };

This should be a separate patch.

And AFAICS this is wrong, sw1a on the MX8M-EVK is the GPU supply, the
CPU is supplied by a dedicated switcher that is controlled via a GPIO.

Regards,
Lucas

>  &fec1 {
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 1a89062..89b2d5f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -91,6 +91,7 @@
>  			clocks = <&clk IMX8MQ_CLK_ARM>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			operating-points-v2 = <&a53_0_opp_table>;
>  		};
>  
>  		A53_1: cpu@1 {
> @@ -101,6 +102,7 @@
>  			clocks = <&clk IMX8MQ_CLK_ARM>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			operating-points-v2 = <&a53_0_opp_table>;
>  		};
>  
>  		A53_2: cpu@2 {
> @@ -111,6 +113,7 @@
>  			clocks = <&clk IMX8MQ_CLK_ARM>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			operating-points-v2 = <&a53_0_opp_table>;
>  		};
>  
>  		A53_3: cpu@3 {
> @@ -121,6 +124,7 @@
>  			clocks = <&clk IMX8MQ_CLK_ARM>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			operating-points-v2 = <&a53_0_opp_table>;
>  		};
>  
>  		A53_L2: l2-cache0 {
> @@ -666,6 +670,25 @@
>  			status = "disabled";
>  		};
>  
> +
> +		a53_0_opp_table: opp-table {
> +			compatible = "operating-points-v2";
> +			opp-shared;
> +
> +			opp-800000000 {
> +				opp-hz = /bits/ 64 <800000000>;
> +				opp-microvolt = <900000>;
> +				clock-latency-ns = <150000>;
> +			};
> +
> +			opp-1000000000 {
> +				opp-hz = /bits/ 64 <1000000000>;
> +				opp-microvolt = <900000>;
> +				clock-latency-ns = <150000>;
> +				opp-suspend;
> +			};
> +		};
> +
>  		gic: interrupt-controller@38800000 {
>  			compatible = "arm,gic-v3";
>  			reg = <0x38800000 0x10000>,	/* GIC
> Dist */
