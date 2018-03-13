Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932359AbeCMBtX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 21:49:23 -0400
Received: from foss.arm.com ([217.140.101.70]:60600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932211AbeCMBtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 21:49:21 -0400
Subject: Re: [PATCH 2/5] arm64: dts: allwinner: a64: Add watchdog
To: Harald Geyer <harald@ccbib.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
References: <20180312161050.7647-1-harald@ccbib.org>
 <20180312161050.7647-3-harald@ccbib.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        info@olimex.com
From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <29bb31fc-dd3d-e9c5-c78e-f8e80f7a95fa@arm.com>
Date: Tue, 13 Mar 2018 01:39:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180312161050.7647-3-harald@ccbib.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/18 16:10, Harald Geyer wrote:

Hi,

> Add a watchdog node for the A64, automatically enabled on all boards.
> Tested on Olimex Teres I.
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 64e452a758fa..ca1b365bc722 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -665,5 +665,11 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  		};
> +
> +		wdt0: watchdog@1c20ca0 {
> +			compatible = "allwinner,sun6i-a31-wdt";

Please use the recommended way, adding a specific compatible first:

			compatible = "allwinner,sun50i-a64-wdt",
				     "allwinner,sun6i-a31-wdt";

The rest looks correct.

I am just a bit puzzled what's the use of a watchdog on a laptop? I
would expect it being more used in embedded systems? Or is that patch
here actually independent from the Teres I?

Cheers,
Andre.

> +			reg = <0x01c20ca0 0x20>;
> +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +		};
>  	};
>  };
> 
