Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kvYXFexRGVsOFAAAmS7hNA
	; Thu, 07 Jun 2018 15:42:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B5BA4608BA; Thu,  7 Jun 2018 15:42:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 239326074D;
	Thu,  7 Jun 2018 15:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 239326074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935358AbeFGPm0 convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Thu, 7 Jun 2018 11:42:26 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50240 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934885AbeFGPmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:42:05 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id ABB602075D; Thu,  7 Jun 2018 17:42:03 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-128-7.w90-88.abo.wanadoo.fr [90.88.9.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3CD31203B0;
        Thu,  7 Jun 2018 17:42:03 +0200 (CEST)
Date: Thu, 7 Jun 2018 17:42:03 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc: <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <wmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <f.fainelli@gmail.com>,
        <mmayer@broadcom.com>, <rogerq@ti.com>, <ladis@linux-mips.org>,
        <ada@thorsis.com>, <honghui.zhang@mediatek.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasureshkumarrelli@gmail.com>
Subject: Re: [LINUX PATCH v9 1/4] Devicetree: Add pl353 smc controller
 devicetree binding information
Message-ID: <20180607174203.035f187d@xps13>
In-Reply-To: <1528271382-21690-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1528271382-21690-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1528271382-21690-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

On Wed, 6 Jun 2018 13:19:39 +0530, Naga Sureshkumar Relli
<naga.sureshkumar.relli@xilinx.com> wrote:

> Add pl353 static memory controller devicetree binding information.
> 
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> ---
> Changes in v9:
>  - Addressed commens given by Randy Dunlap and Miquel Raynal

Can you please be more specific in your next changelog? I don't
remember what I suggested a few months ago :)

> Changes in v8:
>  - None
> Changes in v7:
> - Corrected clocks description
> - prefixed '#' for address and size cells 
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
>  .../bindings/memory-controllers/pl353-smc.txt      | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> new file mode 100644
> index 0000000..551e66b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> @@ -0,0 +1,53 @@
> +Device tree bindings for ARM PL353 static memory controller
> +
> +PL353 static memory controller supports two kinds of memory
> +interfaces.i.e NAND and SRAM/NOR interfaces.
> +The actual devices are instantiated from the child nodes of pl353 smc node.
> +
> +Required properties:
> +- compatible		: Should be "arm,pl353-smc-r2p1"

I thing Rob prefers:

- compatible: Must be one of:
  * arm, pl353-smc-r2p1

> +- reg			: Controller registers map and length.
> +- clock-names		: List of input clock names - "ref_clk", "aper_clk"
> +			  (See clock bindings for details).
> +- clocks		: Clock phandles (see clock bindings for details).
> +- address-cells		: Address cells, must be 1.
> +- size-cells		: Size cells. Must be 1.

Please avoid padding, just this is enough:

- something: And another thing.

> +
> +Child nodes:
> + For NAND the "arm,pl353-nand-r2p1" and for NOR the "cfi-flash" drivers are
> +supported as child nodes.
> +
> +Mandatory timing properties for child nodes:
> +- arm,nand-cycle-t0	: Read cycle time(t_rc).
> +- arm,nand-cycle-t1	: Write cycle time(t_wc).
> +- arm,nand-cycle-t2	: re_n assertion delay(t_rea).
> +- arm,nand-cycle-t3	: we_n de-assertion delay(t_wp).
> +- arm,nand-cycle-t4	: Status read time(t_clr)
> +- arm,nand-cycle-t5	: ID read time(t_ar)
> +- arm,nand-cycle-t6	: busy to re_n(t_rr)

I think this has nothing to do in the DT, you should handle timings
from the ->setup_data_interface() hook. If you need, you may use
different compatibles to distinguish different platform data.

> +
> +for nand partition information please refer the below file

s/nand/NAND/

> +Documentation/devicetree/bindings/mtd/partition.txt
> +
> +Example:
> +	pl353smcc_0: pl353smcc@e000e000 {

Why not something more explicit with the '-flash-controller' suffix?

> +			compatible = "arm,pl353-smc-r2p1"
> +			clock-names = "memclk", "aclk";
> +			clocks = <&clkc 11>, <&clkc 44>;
> +			reg = <0xe000e000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			nand_0: nand@e1000000 {
> +				compatible = "arm,pl353-nand-r2p1"

NAND chips do not have their own compatible.

> +				reg = <0xe1000000 0x1000000>;
> +				arm,nand-cycle-t0 = <0x4>;
> +				arm,nand-cycle-t1 = <0x4>;
> +				arm,nand-cycle-t2 = <0x1>;
> +				arm,nand-cycle-t3 = <0x2>;
> +				arm,nand-cycle-t4 = <0x2>;
> +				arm,nand-cycle-t5 = <0x2>;
> +				arm,nand-cycle-t6 = <0x4>;
> +				(...)
> +			};
> +	};


Thanks,
Miquèl
