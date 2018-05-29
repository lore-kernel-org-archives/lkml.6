Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965410AbeE3J2Y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:28:24 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:38103 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753271AbeE3J2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:28:17 -0400
Date: Tue, 29 May 2018 17:19:36 +0100
From: Simon Horman <horms@verge.net.au>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 5/5] arm64: dts: renesas: r8a7795: add ccree binding
Message-ID: <20180529161936.prhp4oikzamr6u3n@verge.net.au>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
 <1527171551-21979-6-git-send-email-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527171551-21979-6-git-send-email-gilad@benyossef.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 03:19:10PM +0100, Gilad Ben-Yossef wrote:
> Add bindings for CryptoCell instance in the SoC.
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>

In so far as I can review the details of this (which is not much) this
looks fine to me. I am, however, a little unclear in when it should be
accepted.

> ---
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index d842940..3ac75db 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -528,6 +528,15 @@
>  			status = "disabled";
>  		};
>  
> +		arm_cc630p: crypto@e6601000 {
> +			compatible = "arm,cryptocell-630p-ree";
> +			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> +			reg = <0x0 0xe6601000 0 0x1000>;
> +			clocks = <&cpg CPG_MOD 229>;
> +			resets = <&cpg 229>;
> +			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
> +		};
> +
>  		i2c3: i2c@e66d0000 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -- 
> 2.7.4
> 
