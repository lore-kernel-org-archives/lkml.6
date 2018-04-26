Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756989AbeDZVO4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:14:56 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59806 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754777AbeDZVOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:14:54 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/17] arm64: dts: r8a77965: Populate the DU instance placeholder
Date: Fri, 27 Apr 2018 00:15:07 +0300
Message-ID: <1778997.DCq8dSVpMV@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180426165346.494-13-kieran.bingham+renesas@ideasonboard.com>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com> <20180426165346.494-13-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Thursday, 26 April 2018 19:53:41 EEST Kieran Bingham wrote:
> The DU entity node has been previously added but only as a placeholder.
> Populate the node with the properties to use the device.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a77965.dtsi | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> b/arch/arm64/boot/dts/renesas/r8a77965.dtsi index
> e92e6b03333a..8a40bba53027 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> @@ -1106,9 +1106,21 @@
>  		};
> 
>  		du: display@feb00000 {
> +			compatible = "renesas,du-r8a77965";
>  			reg = <0 0xfeb00000 0 0x80000>,
>  			      <0 0xfeb90000 0 0x14>;
> -			/* placeholder */
> +			reg-names = "du", "lvds.0";

The LVDS encoder has been split to a separate node in current bindings. You 
can remove the reg-names property and the second reg entry.

> +			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 724>,
> +				 <&cpg CPG_MOD 723>,
> +				 <&cpg CPG_MOD 721>,
> +				 <&cpg CPG_MOD 727>;
> +			clock-names = "du.0", "du.1", "du.3", "lvds.0";

And you can remove the LVDS clock as well (from both clocks and clock-names).

With this fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +			status = "disabled";
> +
> +			vsps = <&vspd0 0 &vspd1 0 &vspd0 1>;
> 
>  			ports {
>  				#address-cells = <1>;

-- 
Regards,

Laurent Pinchart
