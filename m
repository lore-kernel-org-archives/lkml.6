Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7ECC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A003C20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A003C20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392861AbeKVStY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:49:24 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44765 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733146AbeKVStY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:49:24 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6F00420D29; Thu, 22 Nov 2018 09:11:02 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1EEB920510;
        Thu, 22 Nov 2018 09:10:52 +0100 (CET)
Date:   Thu, 22 Nov 2018 09:10:51 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Marek Vasut <marex@denx.de>
Subject: [GIT PULL] mtd: Fixes for 4.20-rc4
Message-ID: <20181122091051.70407bcd@bbrezillon>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the MTD fixes PR for 4.20-rc4.

Regards,

Boris

The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  git://git.infradead.org/linux-mtd.git tags/mtd/fixes-for-4.20-rc4

for you to fetch changes up to e8828ec1c003727fc001eab06aa19bd2ca9b677e:

  mtd: spi-nor: fix selection of uniform erase type in flexible conf (2018-11-20 14:26:59 +0100)

----------------------------------------------------------------
SPI NOR fixes:
- Various fixes related to the SFDP parsing code merged in 4.20
- Fix for a page fault in the cadence-qspi

NAND fixes:
- Fix a macro name conflict between the QCOM NAND controller driver
  and the RISC-V asm headers
- Fix of-node handling in the atmel driver

----------------------------------------------------------------
Johan Hovold (1):
      mtd: rawnand: atmel: fix OF child-node lookup

Olof Johansson (1):
      mtd: rawnand: qcom: Namespace prefix some commands

Thor Thayer (1):
      mtd: spi-nor: Fix Cadence QSPI page fault kernel panic

Tudor.Ambarus@microchip.com (5):
      mtd: spi-nor: don't drop sfdp data if optional parsers fail
      mtd: spi-nor: fix iteration over smpt array
      mtd: spi-nor: don't overwrite errno in spi_nor_get_map_in_use()
      mtd: spi_nor: pass DMA-able buffer to spi_nor_read_raw()
      mtd: spi-nor: fix selection of uniform erase type in flexible conf

 drivers/mtd/nand/raw/atmel/nand-controller.c |  11 +++--
 drivers/mtd/nand/raw/qcom_nandc.c            |  32 ++++++-------
 drivers/mtd/spi-nor/cadence-quadspi.c        |  19 ++++++--
 drivers/mtd/spi-nor/spi-nor.c                | 130 +++++++++++++++++++++++++++++++++++++++-------------
 4 files changed, 137 insertions(+), 55 deletions(-)
