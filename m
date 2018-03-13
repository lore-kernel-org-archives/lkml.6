Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751620AbeCMBfz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 21:35:55 -0400
Received: from foss.arm.com ([217.140.101.70]:60488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751526AbeCMBfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 21:35:51 -0400
Subject: Re: [PATCH 1/5] arm64: dts: allwinner: a64: Add i2c0 pins
To: Harald Geyer <harald@ccbib.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
References: <20180312161050.7647-1-harald@ccbib.org>
 <20180312161050.7647-2-harald@ccbib.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        info@olimex.com
From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <5b7f1a15-011f-c386-4813-f0fb8a91dfd8@arm.com>
Date: Tue, 13 Mar 2018 01:35:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180312161050.7647-2-harald@ccbib.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/18 16:10, Harald Geyer wrote:
> Add the proper pin group node to reference in board files.
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>

That looks correct to me, so:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

But out of curiosity, what is this used for? In patch 5/5 I see it being
used, but without a clue for what? Shouldn't enabling an I2C node be
accompanied by some child node, presenting the device on the bus?
I guess this I2C is not on some kind of "header" on that laptop?

Cheers,
Andre.

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 1b6dc31e7d91..64e452a758fa 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -309,6 +309,11 @@
>  			interrupt-controller;
>  			#interrupt-cells = <3>;
>  
> +			i2c0_pins: i2c0_pins {
> +				pins = "PH0", "PH1";
> +				function = "i2c0";
> +			};
> +
>  			i2c1_pins: i2c1_pins {
>  				pins = "PH2", "PH3";
>  				function = "i2c1";
> 
