Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeEKH7T (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 03:59:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60247 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750852AbeEKH7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 03:59:18 -0400
Date: Fri, 11 May 2018 09:59:13 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marex@denx.de>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [GIT PULL] mtd: Fixes for 4.17-rc5
Message-ID: <20180511095913.27878f1f@bbrezillon>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the MTD fixes PR for 4.17-rc5.

Regards,

Boris

The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mtd.git tags/mtd/fixes-for-4.17-rc5

for you to fetch changes up to 3057fcef385348fe85173f1b0c824d89f1176f72:

  mtd: rawnand: Make sure we wait tWB before polling the STATUS reg (2018-05-10 08:40:39 +0200)

----------------------------------------------------------------
NAND fixes:
- Make nand_soft_waitrdy() wait tWB before polling the status REG
- Fix BCH write in the the Marvell NAND controller driver
- Fix wrong picosec to msec conversion in the Marvell NAND controller
  driver
- Fix DMA handling in the TI OneNAND controllre driver

----------------------------------------------------------------
Boris Brezillon (1):
      mtd: rawnand: Make sure we wait tWB before polling the STATUS reg

Chris Packham (1):
      mtd: rawnand: marvell: pass ms delay to wait_op

Ladislav Michl (1):
      mtd: onenand: omap2: Disable DMA for HIGHMEM buffers

Miquel Raynal (1):
      mtd: rawnand: marvell: fix command xtype in BCH write hook

 drivers/mtd/nand/onenand/omap2.c    | 105 ++++++++++++++++++++++---------------------------------------
 drivers/mtd/nand/raw/marvell_nand.c |  12 +++++--
 drivers/mtd/nand/raw/nand_base.c    |   5 +++
 3 files changed, 52 insertions(+), 70 deletions(-)
