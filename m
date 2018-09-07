Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC69C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625B62077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625B62077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbeIGTkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:40:02 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:49181 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbeIGTkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:40:02 -0400
X-IronPort-AV: E=Sophos;i="5.53,342,1531810800"; 
   d="scan'208";a="16742532"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 07:58:44 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.352.0; Fri, 7 Sep 2018
 07:58:43 -0700
Date:   Fri, 7 Sep 2018 16:57:18 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: at91: sama5d4: add labels to soc dtsi for
 derivative boards
Message-ID: <20180907145718.hoddgyzqgxc2kol6@M43218.corp.atmel.com>
Mail-Followup-To: Eugen Hristev <eugen.hristev@microchip.com>,
        alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1536327489-22005-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1536327489-22005-1-git-send-email-eugen.hristev@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen,

On Fri, Sep 07, 2018 at 04:38:09PM +0300, Eugen Hristev wrote:
> This adds labels to commonly used device-tree nodes so that derivative
> boards can avoid ahb/apb hierarchy.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> 
> Hello,
> 
> This was already done for SoC sama5d3 and sam9x5, in commit:
> "fc37204432d" ("ARM: dts: at91: add labels to soc dtsi for derivative boards")
> 
> This commit will do basically the same thing for sama5d4 SoC.

Even if it's a mimic of what has been done for other SoCs, it could be
worth doing it for all peripherals: trng, aes, tdes and sha are still
missing a label.

Otherwise
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Regards

Ludovic

> 
> Based on top of at91-next branch of at91.git
> 
> Thanks.
> 
>  arch/arm/boot/dts/sama5d4.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index 92a35a1..7371f2a 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -1323,13 +1323,13 @@
>  				};
>  			};
>  
> -			rstc@fc068600 {
> +			reset_controller: rstc@fc068600 {
>  				compatible = "atmel,sama5d3-rstc", "atmel,at91sam9g45-rstc";
>  				reg = <0xfc068600 0x10>;
>  				clocks = <&clk32k>;
>  			};
>  
> -			shdwc@fc068610 {
> +			shutdown_controller: shdwc@fc068610 {
>  				compatible = "atmel,at91sam9x5-shdwc";
>  				reg = <0xfc068610 0x10>;
>  				clocks = <&clk32k>;
> @@ -1342,7 +1342,7 @@
>  				clocks = <&h32ck>;
>  			};
>  
> -			watchdog@fc068640 {
> +			watchdog: watchdog@fc068640 {
>  				compatible = "atmel,sama5d4-wdt";
>  				reg = <0xfc068640 0x10>;
>  				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 7>;
> @@ -1376,7 +1376,7 @@
>  			};
>  
>  
> -			pinctrl@fc06a000 {
> +			pinctrl: pinctrl@fc06a000 {
>  				#address-cells = <1>;
>  				#size-cells = <1>;
>  				compatible = "atmel,sama5d3-pinctrl", "atmel,at91sam9x5-pinctrl", "simple-bus";
> -- 
> 2.7.4
> 
