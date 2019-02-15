Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1297AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF8B21934
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="N5ipxKWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfBOAzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:55:23 -0500
Received: from node.akkea.ca ([192.155.83.177]:44208 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfBOAzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:55:23 -0500
Received: by node.akkea.ca (Postfix, from userid 33)
        id 596B14E204B; Fri, 15 Feb 2019 00:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1550192122; bh=qSYSF5tg4Vn7jx47Iv7ML8cSM06NsDF/modrxQLizVc=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=N5ipxKWrXTvT+NhI5NrX1tuYBkKBpvZJGKLD17D9W7bxE7zwCh0v0+gipg3zclkfm
         nnMCjcgg3jpJhwROmbYj1u+VegxyL9WdYTxvTsaWY3gcztQ56bMHuyHQusMa3+VFrQ
         gxURbPTuTjt0VpwJErMV5ptEdbyP5GUcuPML0wfU=
To:     Abel Vesa <abel.vesa@nxp.com>
Subject: Re: [RFC 5/5] arm64: dts: imx8mq: Add the opp table and the  cpu-supply nodes
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 14 Feb 2019 16:55:22 -0800
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Anson Huang <anson.huang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel-owner@vger.kernel.org
In-Reply-To: <1550084693-9797-6-git-send-email-abel.vesa@nxp.com>
References: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
 <1550084693-9797-6-git-send-email-abel.vesa@nxp.com>
Message-ID: <76b2c0e4a61d022f7f798990af4dfd8b@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-13 11:05, Abel Vesa wrote:
> Add the opp table containing only non over drive opps.
> Also add the cpu-supply nodes for the A53 cores in the EVK board.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 17 +++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 23 
> +++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index 54737bf..114359e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -31,6 +31,23 @@
>  		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  	};
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
>  };
> 
>  &fec1 {
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 1a89062..89b2d5f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -91,6 +91,7 @@
>  			clocks = <&clk IMX8MQ_CLK_ARM>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			operating-points-v2 = <&a53_0_opp_table>;
>  		};
> 
>  		A53_1: cpu@1 {
> @@ -101,6 +102,7 @@
>  			clocks = <&clk IMX8MQ_CLK_ARM>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			operating-points-v2 = <&a53_0_opp_table>;
>  		};
> 
>  		A53_2: cpu@2 {
> @@ -111,6 +113,7 @@
>  			clocks = <&clk IMX8MQ_CLK_ARM>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			operating-points-v2 = <&a53_0_opp_table>;
>  		};
> 
>  		A53_3: cpu@3 {
> @@ -121,6 +124,7 @@
>  			clocks = <&clk IMX8MQ_CLK_ARM>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			operating-points-v2 = <&a53_0_opp_table>;
>  		};
> 
>  		A53_L2: l2-cache0 {
> @@ -666,6 +670,25 @@
>  			status = "disabled";
>  		};
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

Shouldn't this be

opp-microvolt = <1000000>;

> +				clock-latency-ns = <150000>;
> +				opp-suspend;
> +			};
> +		};
> +
>  		gic: interrupt-controller@38800000 {
>  			compatible = "arm,gic-v3";
>  			reg = <0x38800000 0x10000>,	/* GIC Dist */

