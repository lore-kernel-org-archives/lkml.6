Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F14C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 20:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E9C2530A
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 20:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E9C2530A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeFXUkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 16:40:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58078 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751352AbeFXUkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 16:40:16 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 72F3B2079C; Sun, 24 Jun 2018 22:40:14 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id F0419206A0;
        Sun, 24 Jun 2018 22:40:13 +0200 (CEST)
Date:   Sun, 24 Jun 2018 22:40:14 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <f.fainelli@gmail.com>, <mmayer@broadcom.com>, <rogerq@ti.com>,
        <ladis@linux-mips.org>, <ada@thorsis.com>,
        <honghui.zhang@mediatek.com>, <miquel.raynal@bootlin.com>,
        nagasureshkumarrelli@gmail.com, michals@xilinx.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [[LINUX PATCH v10] 1/4] Devicetree: Add pl353 smc controller
 devicetree binding information
Message-ID: <20180624224014.125cf0bc@bbrezillon>
In-Reply-To: <1529563351-2241-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1529563351-2241-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

Subject prefix should be "dt-bindings: memory: " not "Devicetree: ".

On Thu, 21 Jun 2018 12:12:28 +0530
Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:

> Add pl353 static memory controller devicetree binding information.
> 
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> ---
> Changes in v10:
>  - Corrected the typos like "should be" to "Must be" and nand to NAND etc..
>  - Removed padding to describe size-cells and address-cells
>  - Removed timing parameters from DT, and added ->setup_data_interface() hook
>    to the driver to read the SDR timings
>  - Modified label name from "pl353smcc_0: pl353smcc@e000e000" to
>    "smcc: memory-controller@e000e000" as suggested by Miquel
> Changes in v9:
>  - Addressed below comments given by Randy Dunlap and Miquel Raynal
>  - Typos
>  - Added extra documentation that explains the HW ECC limitation with SMC
>    (Comments given to v8: https://lkml.org/lkml/2018/3/22/23)
> Changes in v8:
>  - None
> Changes in v7:
>  - Corrected clocks description
>  - prefixed '#' for address and size cells
> Changes in v6:
>  - None
> Changes in v5:
>  - Removed timing properties
> Changes in v4:
>  - none
> Changes in v3:
>  - none
> Changes in v2:
>  - modified timing binding info as per onfi timing parameters
>  - add suffix nano second as timing unit
>  - modified the clock names as per the IP spec
> ---
>  .../bindings/memory-controllers/pl353-smc.txt      | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> new file mode 100644
> index 0000000..8b4c65e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> @@ -0,0 +1,41 @@
> +Device tree bindings for ARM PL353 static memory controller
> +
> +PL353 static memory controller supports two kinds of memory
> +interfaces.i.e NAND and SRAM/NOR interfaces.
> +The actual devices are instantiated from the child nodes of pl353 smc node.
> +
> +Required properties:
> +- compatible		: Must be "arm,pl353-smc-r2p1"
> +- reg			: Controller registers map and length.
> +- clock-names		: List of input clock names - "ref_clk", "aper_clk"
> +			  (See clock bindings for details).
> +- clocks		: Clock phandles (see clock bindings for details).
> +- address-cells		: Must be 1.
> +- size-cells		: Must be 1.
> +
> +Child nodes:
> + For NAND the "arm,pl353-nand-r2p1" and for NOR the "cfi-flash" drivers are
> +supported as child nodes.
> +
> +for NAND partition information please refer the below file
> +Documentation/devicetree/bindings/mtd/partition.txt
> +
> +Example:
> +	smcc: memory-controller@e000e000
> +			compatible = "arm,pl353-smc-r2p1"
> +			clock-names = "memclk", "aclk";
> +			clocks = <&clkc 11>, <&clkc 44>;
> +			reg = <0xe000e000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			nand_0: flash@e1000000 {
> +				compatible = "arm,pl353-nand-r2p1"
> +				reg = <0xe1000000 0x1000000>;
> +				(...)
> +			};
> +			nor0: flash@e2000000 {
> +				compatible = "cfi-flash";
> +				reg = <0xe2000000 0x2000000>;
> +			};
> +	};

I had a look at the PL353 TRM, and the block diagram looks very similar
to the atmel EBI/SMC one. AHB/AXI memory ranges that are used to
interact with the memories are assigned CS ids, which can then be used
to configure the timings (and other kind of stuff). I think you should
have #address-cells = <2>, the first cell encoding the CS id, and the
second one, the memory offset within the reserved range for this CS id.
See the atmel,ebi binding [1].

Regards,

Boris

[1]https://elixir.bootlin.com/linux/v4.18-rc2/source/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
