Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A959FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EB820873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EB820873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeG3PZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:25:04 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:35854 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeG3PZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:25:04 -0400
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="14277181"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jul 2018 06:49:59 -0700
Received: from [10.145.4.138] (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.352.0; Mon, 30 Jul 2018
 06:49:58 -0700
Subject: Re: [PATCH v6 3/3] ARM: dts: at91: sama5d2 Xplained: add pin muxing
 for I2S
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <devicetree@vger.kernel.org>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>,
        <Cristian.Birsan@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180730114008.30464-1-codrin.ciubotariu@microchip.com>
 <20180730114008.30464-4-codrin.ciubotariu@microchip.com>
From:   Claudiu Beznea <Claudiu.Beznea@microchip.com>
Message-ID: <2e2bc99e-138e-fbc8-1db0-e37b46637af0@microchip.com>
Date:   Mon, 30 Jul 2018 16:49:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730114008.30464-4-codrin.ciubotariu@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Codrin,

On 30.07.2018 14:40, Codrin Ciubotariu wrote:
> From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> 
> This patch sets the pin muxing for the I2S controllers
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> [codrin.ciubotariu@microchip.com: added pin muxing for the second
> controller]
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
> 
> Changes in v6:
> 	- none;
> 
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 28 +++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> index fcc85d70f36e..95cbec0f8790 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> @@ -281,6 +281,11 @@
>  				status = "okay";
>  			};
>  
> +			i2s0: i2s@f8050000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_i2s0_default>;

The approach with the disabled controllers in board DTS files (for our
boards) is to use the: status = "disabled" and if there are pin conflicts
with other controllers to put a mark in there, something like:
				status = "disabled"; /* Conflict with X */

I'm seeing that i2s1 is in conflict with sdmmc1 and spi0.

Thank you,
Claudiu Beznea

> +			};
> +
>  			can0: can@f8054000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_can0_default>;
> @@ -424,6 +429,24 @@
>  					bias-disable;
>  				};
>  
> +				pinctrl_i2s0_default: i2s0_default {
> +					pinmux = <PIN_PC1__I2SC0_CK>,
> +						 <PIN_PC2__I2SC0_MCK>,
> +						 <PIN_PC3__I2SC0_WS>,
> +						 <PIN_PC4__I2SC0_DI0>,
> +						 <PIN_PC5__I2SC0_DO0>;
> +					bias-disable;
> +				};
> +
> +				pinctrl_i2s1_default: i2s1_default {
> +					pinmux = <PIN_PA15__I2SC1_CK>,
> +						 <PIN_PA14__I2SC1_MCK>,
> +						 <PIN_PA16__I2SC1_WS>,
> +						 <PIN_PA17__I2SC1_DI0>,
> +						 <PIN_PA18__I2SC1_DO0>;
> +					bias-disable;
> +				};
> +
>  				pinctrl_key_gpio_default: key_gpio_default {
>  					pinmux = <PIN_PB9__GPIO>;
>  					bias-pull-up;
> @@ -546,6 +569,11 @@
>  				status = "okay";
>  			};
>  
> +			i2s1: i2s@fc04c000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_i2s1_default>;
> +			};
> +
>  			can1: can@fc050000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_can1_default>;
> 
