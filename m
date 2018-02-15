Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425600AbeBOQUt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:20:49 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:51904 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165279AbeBOQUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:20:46 -0500
Subject: Re: [PATCH 2/4] arm64: dts: renesas: r8a77995: add FCPVD nodes
To: Simon Horman <horms@verge.net.au>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Kieran Bingham <kbingham@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
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
References: <1518474330-8713-1-git-send-email-kbingham@kernel.org>
 <1518474330-8713-3-git-send-email-kbingham@kernel.org>
 <1541765.WkmPmS7X3L@avalon> <20180215161404.pywzt7m3ccd7gygu@verge.net.au>
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <0d235657-3b2e-7fbe-f7ba-e33756b76532@ideasonboard.com>
Date: Thu, 15 Feb 2018 16:20:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180215161404.pywzt7m3ccd7gygu@verge.net.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On 15/02/18 16:14, Simon Horman wrote:
> On Tue, Feb 13, 2018 at 02:32:22PM +0200, Laurent Pinchart wrote:
>> Hi Kieran,
>>
>> Thank you for the patch.
>>
>> On Tuesday, 13 February 2018 00:25:27 EET Kieran Bingham wrote:
>>> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>>
>>> The FCPVD handles the interface between the VSPD and memory.
>>>
>>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>
>> I would however squash this with patch 1/4 from the same series.
> 
> Thanks, I've taken the liberty of doing so when applying this patch.
> The result is as follows:

That's probably fine, but there was a follow up series which already handles this.

--
Kieran



> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Subject: [PATCH] arm64: dts: renesas: r8a77995: add FCPV[BD] node
> 
> The FCPVB handles the interface between the VSPB and memory.
> The FCPVD handles the interface between the VSPD and memory.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> [simon: squahsed FCPVB and FCPVD patches]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm64/boot/dts/renesas/r8a77995.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> index cd3c6a30fc47..196a917afea6 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> @@ -691,6 +691,33 @@
>  			#phy-cells = <0>;
>  			status = "disabled";
>  		};
> +
> +		fcpvb0: fcp@fe96f000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xfe96f000 0 0x200>;
> +			clocks = <&cpg CPG_MOD 607>;
> +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +			resets = <&cpg 607>;
> +			iommus = <&ipmmu_vp0 5>;
> +		};
> +
> +		fcpvd0: fcp@fea27000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xfea27000 0 0x200>;
> +			clocks = <&cpg CPG_MOD 603>;
> +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +			resets = <&cpg 603>;
> +			iommus = <&ipmmu_vi0 8>;
> +		};
> +
> +		fcpvd1: fcp@fea2f000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xfea2f000 0 0x200>;
> +			clocks = <&cpg CPG_MOD 602>;
> +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +			resets = <&cpg 602>;
> +			iommus = <&ipmmu_vi0 9>;
> +		};
>  	};
>  
>  	timer {
> 
