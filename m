Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754698AbeCRWBr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 18:01:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52903 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754342AbeCRWBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 18:01:44 -0400
X-Google-Smtp-Source: AG47ELtW+P+PJyD9YMhaU4qts4Q1fYvvYsseo8kTtnCQwkNtSkU0mff1s7ay5hZ7SAJsz1IMKFimWw==
Subject: Re: [PATCH v1 13/19] arm: dts: mt7623: move node mt6323 leds to
 mt6323.dtsi
To: sean.wang@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
References: <cover.1519378871.git.sean.wang@mediatek.com>
 <e8a515a1aeaf06a7162b8b0e390bee615b323303.1519378872.git.sean.wang@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <a4097137-4364-6ca3-ece3-1842569d7e54@gmail.com>
Date: Sun, 18 Mar 2018 23:01:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e8a515a1aeaf06a7162b8b0e390bee615b323303.1519378872.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/23/2018 11:16 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Since those LEDs are parts of PMIC MT6323, it is reasonable to merge
> those LEDs node definition back into mt6323.dtsi. This way can improve
> the reusability of those nodes among different boards with the same PMIC.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/mt6323.dtsi                 | 26 ++++++++++++++++++++++++-
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 28 ---------------------------
>  2 files changed, 25 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mt6323.dtsi b/arch/arm/boot/dts/mt6323.dtsi
> index 7c783d6..44c5642 100644
> --- a/arch/arm/boot/dts/mt6323.dtsi
> +++ b/arch/arm/boot/dts/mt6323.dtsi
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2017 MediaTek Inc.
> + * Copyright (c) 2017-2018 MediaTek Inc.
>   * Author: John Crispin <john@phrozen.org>
>   *	   Sean Wang <sean.wang@mediatek.com>
>   * This program is free software; you can redistribute it and/or modify
> @@ -237,5 +237,29 @@
>  				regulator-enable-ramp-delay = <216>;
>  			};
>  		};
> +
> +		leds {
> +			compatible = "mediatek,mt6323-led";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			led@0 {
> +				reg = <0>;
> +				label = "mt6323:isink:green";
> +				default-state = "off";
> +			};
> +
> +			led@1 {
> +				reg = <1>;
> +				label = "mt6323:isink:red";
> +				default-state = "off";
> +			};
> +
> +			led@2 {
> +				reg = <2>;
> +				label = "mt6323:isink:blue";
> +				default-state = "off";
> +			};
> +		};

The color of the leds are defined by the board and not by the PMIC. So as long
as you don't have any good arguments, I tend not to merge this one.

Regards,
Matthias

>  	};
>  };
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index 75e61c4..767b225 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -483,34 +483,6 @@
>  	status = "okay";
>  };
>  
> -&pwrap {
> -	mt6323 {
> -		mt6323led: led {
> -			compatible = "mediatek,mt6323-led";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			led@0 {
> -				reg = <0>;
> -				label = "bpi-r2:isink:green";
> -				default-state = "off";
> -			};
> -
> -			led@1 {
> -				reg = <1>;
> -				label = "bpi-r2:isink:red";
> -				default-state = "off";
> -			};
> -
> -			led@2 {
> -				reg = <2>;
> -				label = "bpi-r2:isink:blue";
> -				default-state = "off";
> -			};
> -		};
> -	};
> -};
> -
>  &spi0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&spi0_pins_a>;
> 
