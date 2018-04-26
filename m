Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756052AbeDZVWV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:22:21 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59946 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754345AbeDZVWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:22:19 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/17] arm64: dts: r8a77965-salvator-xs: Add DU external dot clocks
Date: Fri, 27 Apr 2018 00:22:32 +0300
Message-ID: <2242585.ilfyDprk4a@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180426165346.494-17-kieran.bingham+renesas@ideasonboard.com>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com> <20180426165346.494-17-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Thursday, 26 April 2018 19:53:45 EEST Kieran Bingham wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> The DU1 external dot clock is provided by the fixed frequency clock
> generator X21, while the DU0 and DU3 clocks are provided by the
> programmable Versaclock6 clock generator.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
> b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts index
> a83a00deed9e..2223cc2bd6bc 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
> @@ -19,3 +19,15 @@
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

There's no LVDS clock in the DU anymore, you can drop it.

As for patch 14/17, I think you can squash this one with 17/17.

> +};

-- 
Regards,

Laurent Pinchart
