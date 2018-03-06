Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752941AbeCFBpx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 20:45:53 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34363 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbeCFBpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 20:45:51 -0500
X-Google-Smtp-Source: AG47ELszDpop5kC7HLPjIwn7RD06aP7rvEhijCnO5SLi6EZGLN3JN1V0aWFe3jwC9236y0RuLgMi/Q==
Date: Mon, 5 Mar 2018 19:45:49 -0600
From: Rob Herring <robh@kernel.org>
To: Jolly Shah <jolly.shah@xilinx.com>
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, michal.simek@xilinx.com,
        mark.rutland@arm.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-kernel@vger.kernel.org, Jolly Shah <jollys@xilinx.com>,
        rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] dt-bindings: clock: Add bindings for ZynqMP clock
 driver
Message-ID: <20180306014549.6t3ae5adzc3cpi5v@rob-hp-laptop>
References: <1519856861-31384-1-git-send-email-jollys@xilinx.com>
 <1519856861-31384-3-git-send-email-jollys@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519856861-31384-3-git-send-email-jollys@xilinx.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 02:27:40PM -0800, Jolly Shah wrote:
> Add documentation to describe Xilinx ZynqMP clock driver
> bindings.
> 
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  .../devicetree/bindings/clock/xlnx,zynqmp-clk.txt  | 163 +++++++++++++++++++++
>  1 file changed, 163 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt b/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
> new file mode 100644
> index 0000000..d590330
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
> @@ -0,0 +1,163 @@
> +Device Tree Clock bindings for the Zynq Ultrascale+ MPSoC
> +
> +The Zynq Ultrascale+ MPSoC has several different clk providers,
> +each with there own bindings.
> +The purpose of this document is to document their usage.
> +
> +See clock_bindings.txt for more information on the generic clock bindings.
> +
> +== Clock Controller ==
> +The clock controller is a logical abstraction of Zynq Ultrascale+ MPSoC clock
> +tree. It reads required input clock frequencies from the devicetree and acts
> +as clock provider for all clock consumers of PS clocks.

Umm, the clock controller should correspond to a h/w block, not a 
"logical abstraction of the clock tree".

> +
> +Required properties:
> + - #clock-cells : Must be 1
> + - compatible : "xlnx,zynqmp-clk"
> + - clocks : list of clock specifiers which are external input clocks to the
> +	    given clock controller. Please refer the next section to find
> +	    the input clocks for a given controller.
> + - clock-names : list of names of clocks which are exteral input clocks to the
> +		 given clock controller. Please refer to the clock bindings
> +		 for more details
> +
> +Input clocks for zynqmp Ultrascale+ clock controller:
> +The Zynq UltraScale+ MPSoC has one primary and four alternative reference clock
> +inputs.
> +These required clock inputs are the
> + - pss_ref_clk (PS reference clock)
> + - video_clk (reference clock for video system )
> + - pss_alt_ref_clk (alternative PS reference clock)
> + - aux_ref_clk
> + - gt_crx_ref_clk (transceiver reference clock)
> +
> +The following strings are optional parameters to the 'clock-names' property in
> +order to provide an optional (E)MIO clock source.
> + - swdt0_ext_clk
> + - swdt1_ext_clk
> + - gem0_emio_clk
> + - gem1_emio_clk
> + - gem2_emio_clk
> + - gem3_emio_clk
> + - mio_clk_XX		# with XX = 00..77
> + - mio_clk_50_or_51	#for the mux clock to gem tsu from 50 or 51
> +
> +
> +Output clocks for zynqmp Ultrascale+ clock controller:
> +Output clocks are registered based on clock information received from firmware.
> +Output clock indexes are mentioned below:
> +
> +Clock ID:	Output clock name:
> +-------------------------------------

These go in header definition, not here.

> +0		iopll
> +1		rpll
> +2		apll
> +3		dpll
> +4		vpll
> +5		iopll_to_fpd
> +6		rpll_to_fpd
> +7		apll_to_lpd
> +8		dpll_to_lpd
> +9		vpll_to_lpd
> +10		acpu
> +11		acpu_half
> +12		dbf_fpd
> +13		dbf_lpd
> +14		dbg_trace
> +15		dbg_tstmp
> +16		dp_video_ref
> +17		dp_audio_ref
> +18		dp_stc_ref
> +19		gdma_ref
> +20		dpdma_ref
> +21		ddr_ref
> +22		sata_ref
> +23		pcie_ref
> +24		gpu_ref
> +25		gpu_pp0_ref
> +26		gpu_pp1_ref
> +27		topsw_main
> +28		topsw_lsbus
> +29		gtgref0_ref
> +30		lpd_switch
> +31		lpd_lsbus
> +32		usb0_bus_ref
> +33		usb1_bus_ref
> +34		usb3_dual_ref
> +35		usb0
> +36		usb1
> +37		cpu_r5
> +38		cpu_r5_core
> +39		csu_spb
> +40		csu_pll
> +41		pcap
> +42		iou_switch
> +43		gem_tsu_ref
> +44		gem_tsu
> +45		gem0_ref
> +46		gem1_ref
> +47		gem2_ref
> +48		gem3_ref
> +49		gem0_tx
> +50		gem1_tx
> +51		gem2_tx
> +52		gem3_tx
> +53		qspi_ref
> +54		sdio0_ref
> +55		sdio1_ref
> +56		uart0_ref
> +57		uart1_ref
> +58		spi0_ref
> +59		spi1_ref
> +60		nand_ref
> +61		i2c0_ref
> +62		i2c1_ref
> +63		can0_ref
> +64		can1_ref
> +65		can0
> +66		can1
> +67		dll_ref
> +68		adma_ref
> +69		timestamp_ref
> +70		ams_ref
> +71		pl0_ref
> +72		pl1_ref
> +73		pl2_ref
> +74		pl3_ref
> +75		wdt
> +76		iopll_int
> +77		iopll_pre_src
> +78		iopll_half
> +79		iopll_int_mux
> +80		iopll_post_src
> +81		rpll_int
> +82		rpll_pre_src
> +83		rpll_half
> +84		rpll_int_mux
> +85		rpll_post_src
> +86		apll_int
> +87		apll_pre_src
> +88		apll_half
> +89		apll_int_mux
> +90		apll_post_src
> +91		dpll_int
> +92		dpll_pre_src
> +93		dpll_half
> +94		dpll_int_mux
> +95		dpll_post_src
> +96		vpll_int
> +97		vpll_pre_src
> +98		vpll_half
> +99		vpll_int_mux
> +100		vpll_post_src
> +101		can0_mio
> +102		can1_mio
> +
> +Example:
> +
> +clk: clk {
> +	#clock-cells = <1>;
> +	compatible = "xlnx,zynqmp-clk";

How do you control the clocks?

> +	clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
> +	clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk"
> +};
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
