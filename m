Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754817AbeCRXtm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 19:49:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33503 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754783AbeCRXth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 19:49:37 -0400
X-Google-Smtp-Source: AG47ELvy2tbA6PuyDfa8HqAesOHgODfD/ADLixQ40rb2T8l09cDurF7r5vdCIQW+e52gnvtYAh+g2Q==
Subject: Re: [PATCH v1 08/19] arm: dts: mt7623: enable three available UARTs
 on bananapi-r2
To: sean.wang@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1519378871.git.sean.wang@mediatek.com>
 <f2e72b8c9f5755ee8943dd7be7f9b9ec50f52c9b.1519378872.git.sean.wang@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <32322310-2279-03bb-3023-f3803f57b050@gmail.com>
Date: Mon, 19 Mar 2018 00:49:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f2e72b8c9f5755ee8943dd7be7f9b9ec50f52c9b.1519378872.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/23/2018 11:16 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> On bpi-r2 board, totally there're four UARTs which we usually called
> uart[0-3] helpful to extend slow-I/O devices. Among those ones, uart2 has
> dedicated pin slot which is used to console log. uart[0-1] appear at the
> 40-pins connector and uart3 has no pinout, but just has test points (TP47
> for TX and TP48 for RX, respectively) nearby uart2, but we don't enable
> uart3 in the patch. The missing pinctrl is also being supplemented for
> those newly added devices.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Pushed to v4.16-next/dts32

Thanks!

> ---
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index 8ef91d6..6b760be 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -470,6 +470,13 @@
>  				 <MT7623_PIN_82_UTXD1_FUNC_UTXD1>;
>  		};
>  	};
> +
> +	uart2_pins_a: uart@2 {
> +		pins_dat {
> +			pinmux = <MT7623_PIN_14_GPIO14_FUNC_URXD2>,
> +				 <MT7623_PIN_15_GPIO15_FUNC_UTXD2>;
> +		};
> +	};
>  };
>  
>  &pwm {
> @@ -515,16 +522,18 @@
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pins_a>;
> -	status = "disabled";
> +	status = "okay";
>  };
>  
>  &uart1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart1_pins_a>;
> -	status = "disabled";
> +	status = "okay";
>  };
>  
>  &uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2_pins_a>;
>  	status = "okay";
>  };
>  
> 
