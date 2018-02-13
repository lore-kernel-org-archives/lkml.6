Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935131AbeBMMnc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:43:32 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:42256 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934971AbeBMMnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:43:31 -0500
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
Subject: Re: [PATCH 3/4] arm64: dts: renesas: r8a77995: add VSPBS instance
Date: Tue, 13 Feb 2018 14:44:01 +0200
Message-ID: <6763077.5Ag4QoQhv0@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1518474330-8713-4-git-send-email-kbingham@kernel.org>
References: <1518474330-8713-1-git-send-email-kbingham@kernel.org> <1518474330-8713-4-git-send-email-kbingham@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Tuesday, 13 February 2018 00:25:28 EET Kieran Bingham wrote:
> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> The r8a77995 has a VSPBS to support image processing such as blending of
> 2 input images.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a77995.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> b/arch/arm64/boot/dts/renesas/r8a77995.dtsi index
> 196a917afea6..50c891f6649f 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> @@ -692,6 +692,16 @@
>  			status = "disabled";
>  		};
> 
> +		vspbs: vsp@fe960000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xfe960000 0 0x4000>;

Unless I'm mistaken the VSPD instance has a CLUT on RPF2, so you need to 
extend the memory region to include it. It's probably safe to set the size to 
0x8000 to include the whole VSP memory region, even if most of the 
0x4000-0x7fff range is not used.

It seems that r8a7795 and r8a7796 suffer from the same issue upstream, they 
should be fixed.

Apart from that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +			interrupts = <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 627>;
> +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +			resets = <&cpg 627>;
> +			renesas,fcp = <&fcpvb0>;
> +		};
> +
>  		fcpvb0: fcp@fe96f000 {
>  			compatible = "renesas,fcpv";
>  			reg = <0 0xfe96f000 0 0x200>;

-- 
Regards,

Laurent Pinchart
