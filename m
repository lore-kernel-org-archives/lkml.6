Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215BCC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1DE20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1DE20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeKHUAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:00:13 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60670 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbeKHUAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:00:13 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5A951224CB; Thu,  8 Nov 2018 11:25:24 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0B46820970;
        Thu,  8 Nov 2018 11:25:14 +0100 (CET)
Date:   Thu, 8 Nov 2018 11:25:13 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marex@denx.de>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>
Subject: [GIT PULL] mtd: Fixes for 4.20-rc2
Message-ID: <20181108112513.3daf0053@bbrezillon>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the MTD fixes PR for 4.20-rc2.

Regards,

Boris

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-mtd.git tags/mtd/fixes-for-4.20-rc2

for you to fetch changes up to 98ee3fc7ef8395f8b7a379e6608aee91efc66d48:

  mtd: nand: Fix nanddev_pos_next_page() kernel-doc header (2018-11-06 17:40:31 +0100)

----------------------------------------------------------------
MTD changes:
* Kill a VLA in sa1100

SPI NOR changes:
* Make sure ->addr_width is restored when SFDP parsing fails
* Propate errors happening in cqspi_direct_read_execute()

NAND changes:
* Fix kernel-doc mismatch
* Fix nanddev_neraseblocks() to return the correct value
* Avoid selection of BCH_CONST_PARAMS when some users require
  dynamic BCH settings

----------------------------------------------------------------
Arnd Bergmann (1):
      mtd: docg3: don't set conflicting BCH_CONST_PARAMS option

Boris Brezillon (4):
      mtd: nand: Fix nanddev_neraseblocks()
      mtd: spi-nor: Reset nor->addr_width when SFDP parsing failed
      mtd: sa1100: avoid VLA in sa1100_setup_mtd
      mtd: nand: Fix nanddev_pos_next_page() kernel-doc header

Christophe JAILLET (1):
      mtd: spi-nor: cadence-quadspi: Return error code in cqspi_direct_read_execute()

Randy Dunlap (1):
      mtd: nand: drop kernel-doc notation for a deleted function parameter

 drivers/mtd/devices/Kconfig           |  2 +-
 drivers/mtd/maps/sa1100-flash.c       | 10 +++++++++-
 drivers/mtd/nand/raw/nand_base.c      |  1 -
 drivers/mtd/spi-nor/cadence-quadspi.c |  2 +-
 drivers/mtd/spi-nor/spi-nor.c         |  6 ++++--
 include/linux/mtd/nand.h              |  7 +++----
 6 files changed, 18 insertions(+), 10 deletions(-)
