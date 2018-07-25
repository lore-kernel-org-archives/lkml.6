Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB412C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9638220671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9638220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbeGYJX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:23:27 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:41362 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbeGYJX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:23:27 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23991808AbeGYIMxBmdxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 2 others);
        Wed, 25 Jul 2018 10:12:53 +0200
Date:   Wed, 25 Jul 2018 10:12:51 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Marek Belisko <marek@goldelico.com>,
        =?iso-8859-2?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH 20/32] ARM: dts: omap3-gta04: add devconf0 setup for
 mcbsp1 clock pins
Message-ID: <20180725081251.GC7467@lenoch>
References: <cover.1532501910.git.hns@goldelico.com>
 <5dbe024d9465eab668ba9aac3732ded225859e6f.1532501910.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dbe024d9465eab668ba9aac3732ded225859e6f.1532501910.git.hns@goldelico.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 08:58:52AM +0200, H. Nikolaus Schaller wrote:
> McBSP1 needs sepcial "pinctrl" for the clocks.

Nit: "special" perhaps?

> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-gta04.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index 935a2a707737..f6abdef556c1 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -187,6 +187,24 @@
>  		reset-gpios = <&tca6507 0 GPIO_ACTIVE_LOW>;	/* W2CBW003 reset through tca6507 */
>  	};
>  
> +	/* devconf0 setup for mcbsp1 clock pins */
> +	pinmux_mcbsp1@48002274 {
> +		compatible = "pinctrl-single";
> +		reg = <0x48002274 4>;   /* CONTROL_DEVCONF0 */
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-single,bit-per-mux;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0x7>;	/* MCBSP1 CLK pinmux */
> +		#pinctrl-cells = <2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mcbsp1_devconf0_pins>;
> +		mcbsp1_devconf0_pins: pinmux_mcbsp1_devconf0_pins {
> +			/*                   offset bits mask */
> +			pinctrl-single,bits = <0x00 0x08 0x1c>;	/* set MCBSP1_CLKR */
> +		};
> +	};
> +
>  	/* devconf1 setup for tvout pins */
>  	pinmux_tv_out@480022d8 {
>  		compatible = "pinctrl-single";
> -- 
> 2.12.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
