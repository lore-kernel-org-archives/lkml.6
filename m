Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2EF23C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F21208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F21208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754908AbeFNJuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 05:50:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45041 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754636AbeFNJux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 05:50:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8B24A207BD; Thu, 14 Jun 2018 11:50:51 +0200 (CEST)
Received: from localhost (unknown [37.170.129.148])
        by mail.bootlin.com (Postfix) with ESMTPSA id 49681206A6;
        Thu, 14 Jun 2018 11:50:41 +0200 (CEST)
Date:   Thu, 14 Jun 2018 11:50:41 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ben Whitten <ben.whitten@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     devicetree@vger.kernel.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] arm: dts: add support for Laird WB50N cpu module and
 DVK
Message-ID: <20180614095041.GW10521@piout.net>
References: <1528966340-23216-1-git-send-email-ben.whitten@lairdtech.com>
 <1528966340-23216-2-git-send-email-ben.whitten@lairdtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528966340-23216-2-git-send-email-ben.whitten@lairdtech.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2018 09:51:55+0100, Ben Whitten wrote:
> Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
> ---
>  arch/arm/boot/dts/Makefile        |   3 +-
>  arch/arm/boot/dts/at91-wb50n.dts  | 116 ++++++++++++++++++++++
>  arch/arm/boot/dts/at91-wb50n.dtsi | 202 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 320 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/at91-wb50n.dts
>  create mode 100644 arch/arm/boot/dts/at91-wb50n.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 1ee94ee..fd5f8a6 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -61,7 +61,8 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
>  	at91-sama5d4_ma5d4evk.dtb \
>  	at91-sama5d4_xplained.dtb \
>  	at91-sama5d4ek.dtb \
> -	at91-vinco.dtb
> +	at91-vinco.dtb \
> +	at91-wb50n.dtb

I know we have been bad at this but this should be
at91-<soc>-<board>.dtb so at91-sama5d31-wb50n.dtb

>  dtb-$(CONFIG_ARCH_ATLAS6) += \
>  	atlas6-evb.dtb
>  dtb-$(CONFIG_ARCH_ATLAS7) += \
> diff --git a/arch/arm/boot/dts/at91-wb50n.dts b/arch/arm/boot/dts/at91-wb50n.dts
> new file mode 100644
> index 0000000..ee4f823
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-wb50n.dts
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * at91-wb50n.dts - Device Tree file for wb50n evaluation board
> + *
> + *  Copyright (C) 2018 Laird
> + *
> + */
> +
> +/dts-v1/;
> +#include "at91-wb50n.dtsi"
> +
> +/ {
> +	model = "Laird Workgroup Bridge 50N - Atmel SAMA5D";
> +	compatible = "laird,wb50n", "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";
> +
> +	ahb {
> +		apb {
> +			watchdog@fffffe40 {

I don't mind if you want to have a preparation patch adding the
necessary labels in the soc dtsi so you don't have to reproduce the
ahb/apb hierarchy here.

> +	ahb {
> +		apb {
> +			pinctrl@fffff200 {

Ditto

> +				board {
> +					pinctrl_mmc0_cd: mmc0_cd {
> +						atmel,pins = <AT91_PIOC 26 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>; /* PC26 GPIO with pullup deglitch */
> +					};
> +
> +					pinctrl_usba_vbus: usba_vbus {
> +						atmel,pins = <AT91_PIOB 13 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>; /* PB13 GPIO with deglitch */
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&slow_osc {
> +	atmel,osc-bypass;
> +};

After the clock binding rework, this will have to be moved to the pmc
node (the rework is not posted, this is just to remind me that this will
have to be done).

> +
> +&usart1_clk {
> +	atmel,clk-output-range = <0 132000000>;
> +};

The datasheet explicitly states that 66 MHz is the maximum allowed
frequency for the USART. Note that the new binding will not allow you to
do that.

However, I see the table disappeared from the latest datasheet. Maybe
Nicolas can comment on that?

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
