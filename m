Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759338AbeD0Vcj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:32:39 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:37544 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757815AbeD0Vch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:32:37 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/11] arm64: dts: r8a77965-salvator-xs: Enable DU external clocks and HDMI
Date: Sat, 28 Apr 2018 00:32:49 +0300
Message-ID: <35470587.gVktJpfmq0@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180427165722.19445-12-kieran.bingham+renesas@ideasonboard.com>
References: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com> <20180427165722.19445-12-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Friday, 27 April 2018 19:57:22 EEST Kieran Bingham wrote:
> The DU1 external dot clock is provided by the fixed frequency clock
> generator X21, while the DU0 and DU3 clocks are provided by the
> programmable Versaclock6 clock generator.
> 
> Enable the clocks, and the HDMI encoder for the M3-N Salvator-XS, and
> hook it up to the HDMI connector
> 
> Based on patches from Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  .../boot/dts/renesas/r8a77965-salvator-xs.dts | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
> b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts index
> a83a00deed9e..dcf1849f1a67 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
> @@ -19,3 +19,32 @@
>  		reg = <0x0 0x48000000 0x0 0x78000000>;
>  	};
>  };
> +
> +&du {
> +	clocks = <&cpg CPG_MOD 724>,
> +		 <&cpg CPG_MOD 723>,
> +		 <&cpg CPG_MOD 721>,
> +		 <&cpg CPG_MOD 727>,
> +		 <&versaclock6 1>,
> +		 <&x21_clk>,
> +		 <&versaclock6 2>;
> +	clock-names = "du.0", "du.1", "du.3", "lvds.0",
> +		      "dclkin.0", "dclkin.1", "dclkin.3";

You should remove the LVDS clock from here too.

Apart from that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +};
> +
> +&hdmi0 {
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			rcar_dw_hdmi0_out: endpoint {
> +				remote-endpoint = <&hdmi0_con>;
> +			};
> +		};
> +	};
> +};
> +
> +&hdmi0_con {
> +	remote-endpoint = <&rcar_dw_hdmi0_out>;
> +};

-- 
Regards,

Laurent Pinchart
