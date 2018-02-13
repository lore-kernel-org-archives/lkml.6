Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935167AbeBMMpM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:45:12 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:42278 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934971AbeBMMpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:45:10 -0500
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kieran Bingham <kbingham@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] arm64: dts: renesas: r8a77995: add VSPD instances
Date: Tue, 13 Feb 2018 14:45:41 +0200
Message-ID: <4151746.tevFeqBdEH@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1518474330-8713-5-git-send-email-kbingham@kernel.org>
References: <1518474330-8713-1-git-send-email-kbingham@kernel.org> <1518474330-8713-5-git-send-email-kbingham@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Tuesday, 13 February 2018 00:25:29 EET Kieran Bingham wrote:
> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> The r8a77995 has two VSPDs to handle display pipelines with a DU.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a77995.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> b/arch/arm64/boot/dts/renesas/r8a77995.dtsi index
> 50c891f6649f..2c14a8dfd201 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> @@ -711,6 +711,16 @@
>  			iommus = <&ipmmu_vp0 5>;
>  		};
> 
> +		vspd0: vsp@fea20000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xfea20000 0 0x4000>;

Same issue as in patch 3/4 (for which I have incorrectly mentioned VSPD 
instead of VSPBS). I'd just extend the region size to 0x8000 for both VSPDs.

Apart from that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 623>;
> +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +			resets = <&cpg 623>;
> +			renesas,fcp = <&fcpvd0>;
> +		};
> +
>  		fcpvd0: fcp@fea27000 {
>  			compatible = "renesas,fcpv";
>  			reg = <0 0xfea27000 0 0x200>;
> @@ -720,6 +730,16 @@
>  			iommus = <&ipmmu_vi0 8>;
>  		};
> 
> +		vspd1: vsp@fea80000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xfea28000 0 0x4000>;
> +			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 622>;
> +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +			resets = <&cpg 622>;
> +			renesas,fcp = <&fcpvd1>;
> +		};
> +
>  		fcpvd1: fcp@fea2f000 {
>  			compatible = "renesas,fcpv";
>  			reg = <0 0xfea2f000 0 0x200>;

-- 
Regards,

Laurent Pinchart
