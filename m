Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932402AbeD0PvY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:51:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41297 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758469AbeD0PvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:51:23 -0400
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM64: dts: marvell: armada-cp110: Add mg_core_clk for ethernet node
References: <20180425181947.28755-1-maxime.chevallier@bootlin.com>
Date: Fri, 27 Apr 2018 17:51:21 +0200
In-Reply-To: <20180425181947.28755-1-maxime.chevallier@bootlin.com> (Maxime
        Chevallier's message of "Wed, 25 Apr 2018 20:19:47 +0200")
Message-ID: <8736zgd4w6.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,
 
 On mer., avril 25 2018, Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Marvell PPv2.2 controller present on CP-110 need the extra "mg_core_clk"
> clock to avoid system hangs when powering some network interfaces up.
>
> This issue appeared after a recent clock rework on Armada 7K/8K platforms.
>
> This commit adds the new clock and updates the documentation accordingly.
>
> Fixes: c7e92def1ef4 ("clk: mvebu: cp110: Fix clock tree representation")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Applied on mvebu/fixes

I also added the cc:stable tags, and use a older commit for the fixes
tag.

Thanks,

Gregory

> ---
>  Documentation/devicetree/bindings/net/marvell-pp2.txt | 9 +++++----
>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi         | 5 +++--
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/marvell-pp2.txt b/Documentation/devicetree/bindings/net/marvell-pp2.txt
> index 1814fa13f6ab..fc019df0d863 100644
> --- a/Documentation/devicetree/bindings/net/marvell-pp2.txt
> +++ b/Documentation/devicetree/bindings/net/marvell-pp2.txt
> @@ -21,9 +21,10 @@ Required properties:
>  	- main controller clock (for both armada-375-pp2 and armada-7k-pp2)
>  	- GOP clock (for both armada-375-pp2 and armada-7k-pp2)
>  	- MG clock (only for armada-7k-pp2)
> +	- MG Core clock (only for armada-7k-pp2)
>  	- AXI clock (only for armada-7k-pp2)
> -- clock-names: names of used clocks, must be "pp_clk", "gop_clk", "mg_clk"
> -  and "axi_clk" (the 2 latter only for armada-7k-pp2).
> +- clock-names: names of used clocks, must be "pp_clk", "gop_clk", "mg_clk",
> +  "mg_core_clk" and "axi_clk" (the 3 latter only for armada-7k-pp2).
>  
>  The ethernet ports are represented by subnodes. At least one port is
>  required.
> @@ -80,8 +81,8 @@ cpm_ethernet: ethernet@0 {
>  	compatible = "marvell,armada-7k-pp22";
>  	reg = <0x0 0x100000>, <0x129000 0xb000>;
>  	clocks = <&cpm_syscon0 1 3>, <&cpm_syscon0 1 9>,
> -		 <&cpm_syscon0 1 5>, <&cpm_syscon0 1 18>;
> -	clock-names = "pp_clk", "gop_clk", "gp_clk", "axi_clk";
> +		 <&cpm_syscon0 1 5>, <&cpm_syscon0 1 6>, <&cpm_syscon0 1 18>;
> +	clock-names = "pp_clk", "gop_clk", "mg_clk", "mg_core_clk", "axi_clk";
>  
>  	eth0: eth0 {
>  		interrupts = <ICU_GRP_NSR 39 IRQ_TYPE_LEVEL_HIGH>,
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> index ca22f9d100f5..ed2f1237ea1e 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> @@ -38,9 +38,10 @@
>  			compatible = "marvell,armada-7k-pp22";
>  			reg = <0x0 0x100000>, <0x129000 0xb000>;
>  			clocks = <&CP110_LABEL(clk) 1 3>, <&CP110_LABEL(clk) 1 9>,
> -				 <&CP110_LABEL(clk) 1 5>, <&CP110_LABEL(clk) 1 18>;
> +				 <&CP110_LABEL(clk) 1 5>, <&CP110_LABEL(clk) 1 6>,
> +				 <&CP110_LABEL(clk) 1 18>;
>  			clock-names = "pp_clk", "gop_clk",
> -				      "mg_clk", "axi_clk";
> +				      "mg_clk", "mg_core_clk", "axi_clk";
>  			marvell,system-controller = <&CP110_LABEL(syscon0)>;
>  			status = "disabled";
>  			dma-coherent;
> -- 
> 2.11.0
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
