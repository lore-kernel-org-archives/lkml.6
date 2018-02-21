Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754925AbeBURbM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:31:12 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:56139 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754215AbeBURbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:31:10 -0500
Date: Wed, 21 Feb 2018 18:31:06 +0100
From: Simon Horman <horms@verge.net.au>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: jacopo mondi <jacopo@jmondi.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org,
        magnus.damm@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/19] ARM64: dts: r8a77965: Add EtherAVB device node
Message-ID: <20180221173106.vgyshbz3kkc4p3cu@verge.net.au>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-20-git-send-email-jacopo+renesas@jmondi.org>
 <cf157266-5ea7-6795-1e31-0d1ccf85e7e8@cogentembedded.com>
 <20180221100716.GF7203@w540>
 <cbeb1b6b-1b02-7665-0f1f-847ab8de69e3@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbeb1b6b-1b02-7665-0f1f-847ab8de69e3@cogentembedded.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 06:48:59PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 02/21/2018 01:07 PM, jacopo mondi wrote:
> 
> >>> Populate the ethernet@e6800000 device node to enable Ethernet interface
> >>> for R-Car M3-N (r8a77965) SoC.
> >>>
> >>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>>
> >>> ---
> >>> v1 -> v2:
> >>> - Replace ALWAYS_ON power area identifier with numeric constant
> >>> ---
> >>>  arch/arm64/boot/dts/renesas/r8a77965.dtsi | 43 ++++++++++++++++++++++++++++++-
> >>>  1 file changed, 42 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> >>> index 55f05f7..c249895 100644
> >>> --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> >>> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> >>> @@ -520,7 +520,48 @@
> >>>  		};
> >>>
> >>>  		avb: ethernet@e6800000 {
> >>> -			/* placeholder */
> >>> +			compatible = "renesas,etheravb-r8a77965",
> >>> +				     "renesas,etheravb-rcar-gen3";
> >>> +			reg = <0 0xe6800000 0 0x800>, <0 0xe6a00000 0 0x10000>;
> >>> +			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
> >>> +			interrupt-names = "ch0", "ch1", "ch2", "ch3",
> >>> +					  "ch4", "ch5", "ch6", "ch7",
> >>> +					  "ch8", "ch9", "ch10", "ch11",
> >>> +					  "ch12", "ch13", "ch14", "ch15",
> >>> +					  "ch16", "ch17", "ch18", "ch19",
> >>> +					  "ch20", "ch21", "ch22", "ch23",
> >>> +					  "ch24";
> >>> +			clocks = <&cpg CPG_MOD 812>;
> >>> +			power-domains = <&sysc 32>;
> >>> +			resets = <&cpg 812>;
> >>> +			phy-mode = "rgmii-txid";
> >>
> >>    Why not just "rgmii"? TX delay is a board specific detail, no?
> >>
> > 
> > I admit I took this one straight from r8a7796 dtsi.
> > Would you like to me resend and change this?
> 
>    Yes, unless Simon would fix it while merging...

Can I confirm the desired change is s/rgmii-txid/rgmii/ ?

If so I can fix that up.
