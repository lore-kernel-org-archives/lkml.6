Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id b4stC6epGltFSQAAmS7hNA
	; Fri, 08 Jun 2018 16:07:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1B462601B4; Fri,  8 Jun 2018 16:07:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E0C3A606FA;
	Fri,  8 Jun 2018 16:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0C3A606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbeFHQG7 convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Fri, 8 Jun 2018 12:06:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43898 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752364AbeFHQG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 12:06:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E9AE82072C; Fri,  8 Jun 2018 18:06:55 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 99E3120731;
        Fri,  8 Jun 2018 18:06:45 +0200 (CEST)
Date: Fri, 8 Jun 2018 18:06:44 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marex@denx.de>
Subject: [GIT PULL] mtd: Changes for 4.18
Message-ID: <20180608180644.34b1f625@bbrezillon>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the MTD pull-request for 4.18.

Regards,

Boris

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mtd.git tags/mtd/for-4.18

for you to fetch changes up to b771327a4530e7ff05ae173d4903cd70357bb803:

  Merge tag 'spi-nor/for-4.18' of git://git.infradead.org/linux-mtd into mtd/next (2018-06-07 22:53:15 +0200)

----------------------------------------------------------------
MTD changes:
  Core changes:
  - Add a sysfs attribute to expose available OOB size

  Driver changes:
  - Remove HAS_DMA dependency on various drivers
  - Use dev_get_drvdata() instead of platform_get_drvdata() in docg3
  - Replace msleep by usleep_range() in the dataflash driver
  - Avoid VLA usage in nftl layers
  - Remove useless .owner assignment in pismo
  - Fix various issues in the CFI driver
  - Improve TRX partition handling expose a DT compat for this part
    parser
  - Clarify OFFSET_CONTINUOUS meaning

NAND changes:
  Core changes:
  - Add Miquel as a NAND maintainer
  - Add access mode to the nand_page_io_req struct
  - Fix kernel-doc in rawnand.h
  - Support bit-wise majority to recover from corrupted ONFI parameter
    pages
  - Stop checking FAIL bit after a SET_FEATURES, as documented in the
    ONFI spec

  Raw NAND Driver changes:
  - Fix and cleanup the error path of many NAND controller drivers
  - GPMI:
    * Cleanup/simplification of a few aspects in the driver
    * Take ECC setup specified in the DT into account
  - sunxi: remove support for GPIO-based R/B polling
  - MTK:
    * Use of_device_get_match_data() instead of of_match_device()
    * Add an entry in MAINTAINERS for this driver
    * Fix nand-ecc-step-size and nand-ecc-strength description in the DT
      bindings doc
  - fsl_ifc: fix ->cmdfunc() to read more than one ONFI parameter page

  OneNAND driver changes:
  - samsung: use dev_get_drvdata() instead of platform_get_drvdata()

SPI NOR changes:
  Core changes:
  - Add support for a bunch of SPI NOR chips
  - Clear EAR reg when switching to 3-byte addressing mode on Winbond
    chips

  SPI NOR controller driver changes:
  - cadence: Add DMA support for direct mode reads
  - hisi: Prefix a few functions with hisi_
  - intel:
    * Mark the driver as "dangerous" in Kconfig
    * Fix atomic sequence handling
    * Pass a 40us delay (instead of 0us) to readl_poll_timeout()
  - fsl:
    * fix a typo in a function name
    * add support for IP variants embedded in the ls2080a and ls1080a
      SoCs
  - stm32: request exclusive control of the reset line

----------------------------------------------------------------
Aaron Sierra (2):
      mtd: cfi: Support early CFI fixups
      mtd: cfi: Add early fixup for S70GL02GS

Boris Brezillon (6):
      Merge tag 'nand/davinci-clock' of git://git.infradead.org/linux-mtd into HEAD
      mtd: rawnand: sunxi: Remove support for GPIO-based Ready/Busy polling
      mtd: rawnand: Do not check FAIL bit when executing a SET_FEATURES op
      mtd: nand: Pass mode information to nand_page_io_req
      Merge tag 'nand/for-4.18' of git://git.infradead.org/linux-mtd into mtd/next
      Merge tag 'spi-nor/for-4.18' of git://git.infradead.org/linux-mtd into mtd/next

Ezequiel Garcia (1):
      mtd: spi-nor: hisi: Avoid generic function names

Fabio Estevam (1):
      mtd: maps: pismo: Remove owner assignment from i2c_driver

Geert Uytterhoeven (2):
      mtd: Remove depends on HAS_DMA in case of platform dependency
      mtd: cmdlinepart: Update comment for introduction of OFFSET_CONTINUOUS

Hauke Mehrtens (1):
      mtd: spi-nor: Add support for XM25QH64A and XM25QH128A

Jane Wan (1):
      mtd: rawnand: fsl_ifc: fix FSL NAND driver to read all ONFI parameter pages

Jia-Ju Bai (1):
      mtd: rawnand: diskonchip: Replace mdelay with usleep_range in doc_probe

Kees Cook (1):
      mtd: nftl: Remove VLA usage

Kimmo Rautkoski (1):
      mtd: spi-nor: Add support for is25wp series chips

Luca Ellero (1):
      mtd: dataflash: replace msleep with usleep_range

Marek Vasut (1):
      mtd: spi-nor: add support for ISSI is25lp256

Mauro Carvalho Chehab (1):
      mtd: rawnand.h: use nested union kernel-doc markups

Mika Westerberg (2):
      mtd: spi-nor: intel-spi: Fix atomic sequence handling
      mtd: spi-nor: intel-spi: Explicitly mark the driver as dangerous in Kconfig

Miquel Raynal (12):
      mtd: rawnand: fsl_elbc: fix probe function error path
      mtd: rawnand: fsl_ifc: fix probe function error path
      mtd: rawnand: fsmc: clean the probe function style
      mtd: rawnand: fsmc: fix the probe function error path
      mtd: rawnand: hisi504: clean the probe function error path
      mtd: rawnand: hisi504: fix the probe function error path
      mtd: rawnand: lpc32xx_mlc: clean the probe function
      mtd: rawnand: lpc32xx_mlc: fix the probe function error path
      mtd: rawnand: lpc32xx_slc: clean the probe function
      mtd: rawnand: lpc32xx_slc: fix the probe function error path
      mtd: rawnand: add a way to pass an ID table with nand_scan()
      mtd: nand: add myself as NAND co-maintainer

NeilBrown (1):
      mtd: spi-nor: clear Winbond Extended Address Reg on switch to 3-byte addressing.

Nicholas Mc Guire (1):
      mtd: spi-nor: intel: provide a range for poll_timout

Philipp Zabel (1):
      mtd: spi-nor: stm32-quadspi: explicitly request exclusive reset control

Rafał Miłecki (4):
      mtd: move code adding (registering) partitions to the parse_mtd_partitions()
      mtd: bcm47xxpart: improve handling TRX partition size
      dt-bindings: mtd: document Broadcom's BCM47xx partitions
      mtd: bcm47xxpart: add of_match_table with a new DT binding

Ryder Lee (1):
      mtd: rawnand: mtk: use of_device_get_match_data()

Sascha Hauer (6):
      mtd: rawnand: gpmi: drop dma_ops_type
      mtd: rawnand: gpmi: pass buffer and len around
      mtd: rawnand: gpmi: put only once used functions inline
      mtd: rawnand: gpmi: remove direct_dma_map_ok from driver data struct
      mtd: rawnand: gpmi: return valid value from bch_set_geometry()
      mtd: rawnand: gpmi: remove unnecessary variables

Sekhar Nori (1):
      mtd: rawnand: davinci: don't acquire and enable clock

Stefan Agner (2):
      mtd: rawnand: gpmi: add support for specific ECC strength
      dt-bindings: mtd: rawnand: gpmi: document specific ECC strength

Stephen Douthit (1):
      mtd: spi-nor: Add Winbond w25q32jv support

Thor Thayer (1):
      mtd: spi-nor: Add Micron MT25QU02 support

Tokunori Ikegami (6):
      mtd: cfi_cmdset_0002: Fix coding style issues
      mtd: cfi_cmdset_0002: Change write buffer to check correct value
      mtd: cfi_cmdset_0002: Change definition naming to retry write operation
      mtd: cfi_cmdset_0002: Change erase functions to retry for error
      mtd: cfi_cmdset_0002: Change erase functions to check chip good only
      mtd: cfi_cmdset_0002: Change erase one block to enable XIP once

Vignesh R (1):
      mtd: spi-nor: cadence-quadspi: Add DMA support for direct mode reads

Wan, Jane (Nokia - US/Sunnyvale) (1):
      mtd: rawnand: use bit-wise majority to recover the ONFI param page

Wolfram Sang (2):
      mtd: devices: simplify getting .drvdata
      mtd: onenand: simplify getting .drvdata

Xiaolei Li (3):
      mtd: Add sysfs attribute for mtd OOB available size
      MAINTAINERS: Add entry for Mediatek NAND controller driver
      dt-bindings: mtd: mtk-nand: Update properties description

Yogesh Gaur (2):
      mtd: spi-nor: fsl-quadspi: fix api naming typo _init_ahb_read
      mtd: spi-nor: fsl-quadspi: add support for ls2080a/ls1080a

YuheiOKAWA (1):
      mtd: spi-nor: Add support for EN25QH32

 Documentation/ABI/testing/sysfs-class-mtd                         |   8 ++
 Documentation/devicetree/bindings/mtd/gpmi-nand.txt               |   5 +
 Documentation/devicetree/bindings/mtd/mtk-nand.txt                |  24 +++-
 Documentation/devicetree/bindings/mtd/partition.txt               |   2 +-
 .../bindings/mtd/partitions/brcm,bcm947xx-cfe-partitions.txt      |  42 +++++++
 Documentation/devicetree/bindings/mtd/sunxi-nand.txt              |   2 -
 MAINTAINERS                                                       |   8 ++
 drivers/mtd/bcm47xxpart.c                                         |  29 ++++-
 drivers/mtd/chips/cfi_cmdset_0002.c                               |  62 +++++-----
 drivers/mtd/chips/cfi_probe.c                                     |  42 +++++++
 drivers/mtd/cmdlinepart.c                                         |   5 +-
 drivers/mtd/devices/docg3.c                                       |   3 +-
 drivers/mtd/devices/mtd_dataflash.c                               |   2 +-
 drivers/mtd/inftlmount.c                                          |  23 ++--
 drivers/mtd/maps/pismo.c                                          |   1 -
 drivers/mtd/mtdcore.c                                             |  24 ++--
 drivers/mtd/mtdcore.h                                             |   1 -
 drivers/mtd/mtdpart.c                                             |  44 +++----
 drivers/mtd/nand/onenand/samsung.c                                |   6 +-
 drivers/mtd/nand/raw/Kconfig                                      |   8 +-
 drivers/mtd/nand/raw/davinci_nand.c                               |  25 +---
 drivers/mtd/nand/raw/diskonchip.c                                 |   4 +-
 drivers/mtd/nand/raw/fsl_elbc_nand.c                              |  13 ++-
 drivers/mtd/nand/raw/fsl_ifc_nand.c                               |  29 +++--
 drivers/mtd/nand/raw/fsmc_nand.c                                  |  27 +++--
 drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c                         |  54 +++++----
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c                        | 188 ++++++++++--------------------
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h                        |  25 +---
 drivers/mtd/nand/raw/hisi504_nand.c                               |  35 ++----
 drivers/mtd/nand/raw/lpc32xx_mlc.c                                |  38 +++---
 drivers/mtd/nand/raw/lpc32xx_slc.c                                |  26 +++--
 drivers/mtd/nand/raw/mtk_ecc.c                                    |   7 +-
 drivers/mtd/nand/raw/mtk_nand.c                                   |  10 +-
 drivers/mtd/nand/raw/nand_base.c                                  |  89 +++++++++-----
 drivers/mtd/nand/raw/sunxi_nand.c                                 |  91 +++------------
 drivers/mtd/nftlmount.c                                           |  23 ++--
 drivers/mtd/spi-nor/Kconfig                                       |   6 +-
 drivers/mtd/spi-nor/cadence-quadspi.c                             |  96 ++++++++++++++-
 drivers/mtd/spi-nor/fsl-quadspi.c                                 |  15 ++-
 drivers/mtd/spi-nor/hisi-sfc.c                                    |  12 +-
 drivers/mtd/spi-nor/intel-spi.c                                   |  80 +++++++++++--
 drivers/mtd/spi-nor/spi-nor.c                                     |  33 ++++++
 drivers/mtd/spi-nor/stm32-quadspi.c                               |   2 +-
 include/linux/mtd/nand.h                                          |   3 +
 include/linux/mtd/rawnand.h                                       |  35 ++++--
 include/linux/mtd/spi-nor.h                                       |   2 +
 46 files changed, 773 insertions(+), 536 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/brcm,bcm947xx-cfe-partitions.txt
