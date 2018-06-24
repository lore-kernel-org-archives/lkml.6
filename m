Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6491DC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 20:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B44025311
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 20:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B44025311
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeFXUyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 16:54:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58174 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751352AbeFXUy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 16:54:29 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D405F20834; Sun, 24 Jun 2018 22:54:27 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 675C920741;
        Sun, 24 Jun 2018 22:54:27 +0200 (CEST)
Date:   Sun, 24 Jun 2018 22:54:27 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <f.fainelli@gmail.com>, <mmayer@broadcom.com>, <rogerq@ti.com>,
        <ladis@linux-mips.org>, <ada@thorsis.com>,
        <honghui.zhang@mediatek.com>, <miquel.raynal@bootlin.com>,
        nagasureshkumarrelli@gmail.com, michals@xilinx.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [[LINUX PATCH v10] 3/4] Documentation: nand: pl353: Add
 documentation for controller and driver
Message-ID: <20180624225427.67c4d9c3@bbrezillon>
In-Reply-To: <1529563351-2241-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1529563351-2241-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 12:12:30 +0530
Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:

> Added notes about the controller and driver.
> 
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> ---
> Changes in v10:
>  - None
> Changes in v9:
>  - Addressed the comments given by Miquel and Randy
> Changes in v8
>  - None
> Changes in v7:
> - None
> Changes in v6:
> - None
> Changes in v5:
> - Fixed the review comments
> Changes in v4:
> - None
> ---
>  Documentation/mtd/nand/pl353-nand.txt | 99 +++++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/mtd/nand/pl353-nand.txt

Can we put these information directly in the driver instead of having
yet another place where we have things partially documented? I just
discovered a doc for the pxa NAND controller in this directory because
of this patch, which kind of proves my point :-).

> 
> diff --git a/Documentation/mtd/nand/pl353-nand.txt b/Documentation/mtd/nand/pl353-nand.txt
> new file mode 100644
> index 0000000..c352c87
> --- /dev/null
> +++ b/Documentation/mtd/nand/pl353-nand.txt
> @@ -0,0 +1,99 @@
> +This document provides some notes about the ARM pl353 SMC controller used in
> +Zynq SOC and confined to NAND specific details.
> +
> +Overview of the controller
> +==========================
> +	The SMC (PL353) supports two memory interfaces:
> +	Interface 0 type SRAM.
> +	Interface 1 type NAND.
> +	This configuration supports the following configurable options:
> +	   . 32-bit or 64-bit AXI data width
> +	   . 8-bit, 16-bit, or 32-bit memory data width for interface 0
> +	   . 8-bit, or 16-bit memory data width for interface 1
> +	   . 1-4 chip selects on each interface
> +	   . SLC ECC block for interface 1
> +
> +For more information, refer the below link for TRM
> +http://infocenter.arm.com/help/topic/com.arm.doc.ddi0380g/DDI0380G_smc_pl350_series_r2p1_trm.pdf
> +
> +NAND memory accesses
> +====================
> +	. Two phase NAND accesses
> +	. NAND command phase transfers
> +	. NAND data phase transfers
> +
> +Two phase NAND accesses
> +	The SMC defines two phases of commands when transferring data to or from
> +NAND flash.
> +
> +Command phase
> +	Commands and optional address information are written to the NAND flash.
> +The command and address can be associated with either a data phase operation to
> +write to or read from the array, or a status/ID register transfer.
> +
> +Data phase
> + Data is either written to or read from the NAND flash. This data can be either
> +data transferred to or from the array, or status/ID register information.
> +
> +NAND AXI address setup
> +       AXI address      Command phase      Data phase
> +	[31:24]         Chip address       Chip address
> +	[23]            NoOfAddCycles_2    Reserved
> +	[22]            NoOfAddCycles_1    Reserved
> +	[21]            NoOfAddCycles_0    ClearCS
> +	[20]            End command valid  End command valid
> +	[19]            0                  1
> +	[18:11]         End command        End command
> +	[10:3]          Start command      [10] ECC Last
> +					   [9:3] Reserved
> +	[2:0]           Reserved           Reserved
> +
> +ECC
> +===
> +    It operates on a number of 512 byte blocks of NAND memory and can be
> +programmed to store the ECC codes after the data in memory. For writes,
> +the ECC is written to the spare area of the page. For reads, the result of
> +a block ECC check are made available to the device driver.
> +
> +------------------------------------------------------------------------
> +|               n * 512 blocks                  | extra  | ecc    |     |
> +|                                               | block  | codes  |     |
> +------------------------------------------------------------------------
> +
> +The ECC calculation uses a simple Hamming code, using 1-bit correction 2-bit
> +detection. It starts when a valid read or write command with a 512 byte aligned
> +address is detected on the memory interface.
> +
> +Driver details
> +==============
> +	The NAND driver has dependency with the pl353_smc memory controller
> +driver for initializing the NAND timing parameters, bus width, ECC modes,
> +control and status information.
> +
> +Since the controller expects that the chip select bit would be cleared for the
> +last data transfer i.e last 4 data bytes, the existing nand page
> +read/write routines for soft ECC and ECC none modes will not work. So, in order
> +to make this driver work, it always updates the ECC mode as HW ECC and
> +implements the page read/write functions for supporting the SW ECC.
> +i.e. There is a limitation in SMC controller, that we must set ECC LAST on
> +last data phase access, to tell ECC block not to expect any data further.
> +Ex:  When number of ECC STEPS are 4, then till 3 we will write to flash
> +using SMC with HW ECC enabled. And for the last ECC STEP, we will subtract
> +4bytes from page size, and will initiate a transfer. And the remaining 4 as
> +one more transfer with ECC_LAST bit set in NAND data phase register to notify
> +ECC block not to expect any more data. The last block should be align with end
> +of 512 byte block. Because of this limitation, we are not using core routines.
> +
> +HW ECC mode:
> +	Up to 2K page size is supported and beyond that it returns
> +-ENOTSUPPORT error. If the flash has on-die ECC controller then the
> +priority is given to the on-die ECC controller. Also the current
> +implementation has support for up to 64 bytes of OOB data.
> +
> +SW ECC mode:
> +	It supports all the page sizes. But since, Zynq SOC bootrom uses
> +HW ECC for the devices that have page <= 2K. so, When the kernel is not
> +aware of the ECC mode, it uses HW ECC by default.
> +
> +For devicetree binding information please refer to the below dt binding file
> +Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt.

