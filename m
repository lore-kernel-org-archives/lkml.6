Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754776AbeCRXta (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 19:49:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53088 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754155AbeCRXt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 19:49:27 -0400
X-Google-Smtp-Source: AG47ELsNcXMYwTnxLXaikIfbyVe86Jf8JfpTtyApIOdHZNJZc4FdHBVUJbHsPMq/o5u1G7qwTI3f2g==
Subject: Re: [PATCH v1 07/19] arm: dts: mt7623: fix the regulators mmc should
 use on bananapi-r2
To: sean.wang@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1519378871.git.sean.wang@mediatek.com>
 <3745e22d89f74e97d9fab7b27d0955ec15527b93.1519378872.git.sean.wang@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <9af52844-4466-18ca-b23d-285f2fe60e48@gmail.com>
Date: Mon, 19 Mar 2018 00:49:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3745e22d89f74e97d9fab7b27d0955ec15527b93.1519378872.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/23/2018 11:16 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Both mmc devices on bananapi-r2 board should all use the fixed regulators
> as their power source instead of PMIC MT6323 exports.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Pushed to v4.16-next/dts32

Thanks!

> ---
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index f660d15..8ef91d6 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -39,6 +39,15 @@
>  		};
>  	};
>  
> +	reg_1p8v: regulator-1p8v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-1.8V";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
>  	reg_3p3v: regulator-3p3v {
>  		compatible = "regulator-fixed";
>  		regulator-name = "fixed-3.3V";
> @@ -213,8 +222,8 @@
>  	bus-width = <8>;
>  	max-frequency = <50000000>;
>  	cap-mmc-highspeed;
> -	vmmc-supply = <&mt6323_vemc3v3_reg>;
> -	vqmmc-supply = <&mt6323_vio18_reg>;
> +	vmmc-supply = <&reg_3p3v>;
> +	vqmmc-supply = <&reg_1p8v>;
>  	non-removable;
>  };
>  
> @@ -227,8 +236,8 @@
>  	max-frequency = <50000000>;
>  	cap-sd-highspeed;
>  	cd-gpios = <&pio 261 GPIO_ACTIVE_LOW>;
> -	vmmc-supply = <&mt6323_vmch_reg>;
> -	vqmmc-supply = <&mt6323_vio18_reg>;
> +	vmmc-supply = <&reg_3p3v>;
> +	vqmmc-supply = <&reg_3p3v>;
>  };
>  
>  &pcie {
> 
