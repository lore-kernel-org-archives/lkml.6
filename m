Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC35C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F5321473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F5321473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbeHTPtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:49:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39624 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbeHTPtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:49:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6293420DEC; Mon, 20 Aug 2018 14:33:35 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 04FE620618;
        Mon, 20 Aug 2018 14:33:25 +0200 (CEST)
Date:   Mon, 20 Aug 2018 14:33:24 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <kyungmin.park@samsung.com>,
        <absahu@codeaurora.org>, <peterpandong@micron.com>,
        <frieder.schrempf@exceet.de>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michals@xilinx.com>,
        <nagasureshkumarrelli@gmail.com>
Subject: Re: [LINUX PATCH v10 1/2] dt-bindings: mtd: arasan: Add device tree
 binding documentation
Message-ID: <20180820143324.61af9027@bbrezillon>
In-Reply-To: <1534511964-20342-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1534511964-20342-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 18:49:23 +0530
Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:

> This patch adds the dts binding document for arasan nand flash
> controller.
> 
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> ---
> Changes in v10:
> - None
> Changes in v9:
> - None
> Changes in v8:
> - Updated compatible and clock-names as per Boris comments
> Changes in v7:
> - Corrected the acronyms those should be in caps 
> changes in v6:
> - Removed num-cs property
> - Separated nandchip from nand controller
> changes in v5:
> - None
> Changes in v4:
> - Added num-cs property
> - Added clock support
> Changes in v3:
> - None
> Changes in v2:
> - None
> ---
>  .../devicetree/bindings/mtd/arasan_nand.txt        | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/arasan_nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/arasan_nand.txt b/Documentation/devicetree/bindings/mtd/arasan_nand.txt
> new file mode 100644
> index 0000000..234d7ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/arasan_nand.txt
> @@ -0,0 +1,38 @@
> +Arasan NAND Flash Controller with ONFI 3.1 support
> +
> +Required properties:
> +- compatible:		Should be "xlnx,zynqmp-nand" or "arasan,nfc-v3p10"

In your example it's not an "or" since both are defined.

> +- reg:			Memory map for module access
> +- interrupt-parent:	Interrupt controller the interrupt is routed through
> +- interrupts:		Should contain the interrupt for the device
> +- clock-name:		List of input clocks - "sys", "flash"

     clock-names

> +			(See clock bindings for details)
> +- clocks:		Clock phandles (see clock bindings for details)
> +
> +Optional properties:
> +- arasan,has-mdma: Enables DMA support

Can't you detect that based on the compatible (or thanks to a
register). If it's something you choose when configuring the IP and
can't detect at runtime I guess it's fine.

> +
> +For NAND partition information please refer the below file
> +Documentation/devicetree/bindings/mtd/partition.txt
> +
> +Example:
> +	nand0: nand@ff100000 {
> +		compatible = "xlnx,zynqmp-nand", "arasan,nfc-v3p10"
> +		reg = <0x0 0xff100000 0x1000>;
> +		clock-name = "sys", "flash"
> +		clocks = <&misc_clk &misc_clk>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 14 4>;
> +		arasan,has-mdma;
> +		#address-cells = <1>;
> +		#size-cells = <0>
> +
> +		nand@0 {
> +			reg = <0>
> +			partition@0 {
> +				label = "filesystem";
> +				reg = <0x0 0x0 0x1000000>;
> +			};

Hm, not sure you need to define partitions in this example, but if
you do, please define your partitions in a 'partitions' subnode:

			partitions {
				compatible = "fixed-partitions";
				#address-cells = <1>;
				#size-cells = <1>;

				partition@0 {
					reg = <0x0 0x1000000>;
					...
				};
				...
			};

> +			(...)
> +		};
> +	};

