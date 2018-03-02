Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422684AbeCBIKX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:10:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:29659 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034356AbeCBIKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:10:21 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,411,1515484800";
   d="scan'208";a="179313655"
Date: Fri, 2 Mar 2018 13:44:08 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: dmaengine@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: Document the Synopsys DW AXI DMA
 bindings
Message-ID: <20180302081408.GK15443@localhost>
References: <20180226145628.11892-1-Eugeniy.Paltsev@synopsys.com>
 <20180226145628.11892-3-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226145628.11892-3-Eugeniy.Paltsev@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 05:56:28PM +0300, Eugeniy Paltsev wrote:
> This patch adds documentation of device tree bindings for the Synopsys
> DesignWare AXI DMA controller.
> 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  .../devicetree/bindings/dma/snps,dw-axi-dmac.txt   | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> new file mode 100644
> index 0000000..f237b79
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> @@ -0,0 +1,41 @@
> +Synopsys DesignWare AXI DMA Controller
> +
> +Required properties:
> +- compatible: "snps,axi-dma-1.01a"
> +- reg: Address range of the DMAC registers. This should include
> +  all of the per-channel registers.
> +- interrupt: Should contain the DMAC interrupt number.
> +- interrupt-parent: Should be the phandle for the interrupt controller
> +  that services interrupts for this device.
> +- dma-channels: Number of channels supported by hardware.
> +- snps,dma-masters: Number of AXI masters supported by the hardware.
> +- snps,data-width: Maximum AXI data width supported by hardware.
> +  (0 - 8bits, 1 - 16bits, 2 - 32bits, ..., 6 - 512bits)
> +- snps,priority: Priority of channel. Array size is equal to the number of
> +  dma-channels. Priority value must be programmed within [0:dma-channels-1]
> +  range. (0 - minimum priority)
> +- snps,block-size: Maximum block size supported by the controller channel.
> +  Array size is equal to the number of dma-channels.
> +
> +Optional properties:
> +- snps,axi-max-burst-len: Restrict master AXI burst length by value specified
> +  in this property. If this property is missing the maximum AXI burst length
> +  supported by DMAC is used. [1:256]
> +
> +Example:
> +
> +dmac: dma-controller@80000 {
> +	compatible = "snps,axi-dma-1.01a";

do we need "snps here..?

> +	reg = <0x80000 0x400>;
> +	clocks = <&core_clk>, <&cfgr_clk>;
> +	clock-names = "core-clk", "cfgr-clk";
> +	interrupt-parent = <&intc>;
> +	interrupts = <27>;
> +
> +	dma-channels = <4>;
> +	snps,dma-masters = <2>;
> +	snps,data-width = <3>;
> +	snps,block-size = <4096 4096 4096 4096>;
> +	snps,priority = <0 1 2 3>;
> +	snps,axi-max-burst-len = <16>;
> +};
> -- 
> 2.9.3
> 

-- 
~Vinod
