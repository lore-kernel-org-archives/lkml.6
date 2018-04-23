Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754127AbeDWG7F (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 02:59:05 -0400
Received: from hermes.aosc.io ([199.195.250.187]:40484 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751535AbeDWG7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 02:59:04 -0400
Message-ID: <1524466728.25095.0.camel@aosc.io>
Subject: Re: [PATCH] arm64: allwinner: h6: restore the usage of CCU slice
 macros
From: Icenowy Zheng <icenowy@aosc.io>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Mon, 23 Apr 2018 14:58:48 +0800
In-Reply-To: <20180403134024.43156-1-icenowy@aosc.io>
References: <20180403134024.43156-1-icenowy@aosc.io>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-04-03二的 21:40 +0800，Icenowy Zheng写道：
> As the definition of CCU slice macros are already merged into the
> source
> tree, restore the usage of the macros now.

Maxime, could you check this patch and pick it?

Thanks!

> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 20 +++++++++++-------
> --
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 56563150d61a..4debc3962830 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -4,6 +4,8 @@
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/sun50i-h6-ccu.h>
> +#include <dt-bindings/reset/sun50i-h6-ccu.h>
>  
>  / {
>  	interrupt-parent = <&gic>;
> @@ -115,7 +117,7 @@
>  				     <GIC_SPI 53
> IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 54
> IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 59
> IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&ccu 26>, <&osc24M>, <&osc32k>;
> +			clocks = <&ccu CLK_APB1>, <&osc24M>,
> <&osc32k>;
>  			clock-names = "apb", "hosc", "losc";
>  			gpio-controller;
>  			#gpio-cells = <3>;
> @@ -134,8 +136,8 @@
>  			interrupts = <GIC_SPI 0
> IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
> -			clocks = <&ccu 70>;
> -			resets = <&ccu 21>;
> +			clocks = <&ccu CLK_BUS_UART0>;
> +			resets = <&ccu RST_BUS_UART0>;
>  			status = "disabled";
>  		};
>  
> @@ -145,8 +147,8 @@
>  			interrupts = <GIC_SPI 1
> IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
> -			clocks = <&ccu 71>;
> -			resets = <&ccu 22>;
> +			clocks = <&ccu CLK_BUS_UART1>;
> +			resets = <&ccu RST_BUS_UART1>;
>  			status = "disabled";
>  		};
>  
> @@ -156,8 +158,8 @@
>  			interrupts = <GIC_SPI 2
> IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
> -			clocks = <&ccu 72>;
> -			resets = <&ccu 23>;
> +			clocks = <&ccu CLK_BUS_UART2>;
> +			resets = <&ccu RST_BUS_UART2>;
>  			status = "disabled";
>  		};
>  
> @@ -167,8 +169,8 @@
>  			interrupts = <GIC_SPI 3
> IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
> -			clocks = <&ccu 73>;
> -			resets = <&ccu 24>;
> +			clocks = <&ccu CLK_BUS_UART3>;
> +			resets = <&ccu RST_BUS_UART3>;
>  			status = "disabled";
>  		};
>  	};
