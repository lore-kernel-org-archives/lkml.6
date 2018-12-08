Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22D4C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886A020837
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886A020837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeLHMaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 07:30:39 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56912 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbeLHMaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 07:30:39 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 49DEE20C94; Sat,  8 Dec 2018 13:30:37 +0100 (CET)
Received: from localhost.localdomain (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 061AC20723;
        Sat,  8 Dec 2018 13:30:37 +0100 (CET)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Tudor.Ambarus@microchip.com, marek.vasut@gmail.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, richard@nod.at,
        Cyrille.Pitchen@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] mtd: spi-nor: parse SFDP 4-byte Address Instruction Table
Date:   Sat,  8 Dec 2018 13:30:35 +0100
Message-Id: <20181208123035.9924-1-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: ea3ce745426a96252f755aebd8a716c4dabc7450
In-Reply-To: <20181206144330.30860-1-tudor.ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-06 at 14:43:39 UTC,  wrote:
> From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> 
> Add support for SFDP (JESD216B) 4-byte Address Instruction Table. This
> table is optional but when available, we parse it to get the 4-byte
> address op codes supported by the memory.
> Using these op codes is stateless as opposed to entering the 4-byte
> address mode or setting the Base Address Register (BAR).
> 
> Flashes that have the 4BAIT table declared can now support
> SPINOR_OP_PP_1_1_4_4B and SPINOR_OP_PP_1_4_4_4B opcodes.
> 
> Tested on MX25L25673G.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> [tudor.ambarus@microchip.com:
> - rework erase and page program logic,
> - pass DMA-able buffer to spi_nor_read_sfdp(),
> - introduce SPI_NOR_HAS_4BAIT
> - various minor updates.]
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied to http://git.infradead.org/linux-mtd.git spi-nor/next, thanks.

Boris
