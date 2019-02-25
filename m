Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375D0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40022087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfBYIpd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:45:33 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37438 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfBYIpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:45:32 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 67A3C260497;
        Mon, 25 Feb 2019 08:45:29 +0000 (GMT)
Date:   Mon, 25 Feb 2019 09:45:26 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marex@denx.de>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [GIT PULL] mtd: Changes for 5.1
Message-ID: <20190225094526.580e0dbb@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the MTD PR for 5.1. Note that you might have to fix a conflict in
MAINTAINERS (conflict between linux-arm and MTD). For the record, here is
Stephen's conflict resolution [1].

Regards,

Boris

[1]https://lkml.org/lkml/2019/2/6/925

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-mtd.git tags/mtd/for-5.1

for you to fetch changes up to 9220d7befc9c28bf714701e6e26163644750d871:

  Merge tag 'nand/for-5.1' of git://git.infradead.org/linux-mtd into mtd/next (2019-02-25 09:28:54 +0100)

----------------------------------------------------------------
MTD changes:
- Use struct_size() where appropriate
- mtd_{read,write}() as wrappers around mtd_{read,write}_oob()
- Fix misuse of PTR_ERR() in docg3
- Coding style improvements in mtdcore.c

SPI NOR changes:
  Core changes:
  - Add support of octal mode I/O transfer
  - Add a bunch of SPI NOR entries to the flash_info table

  SPI NOR controller driver changes:
  - cadence-quadspi:
    * Add support for Octal SPI controller
    * write upto 8-bytes data in STIG mode
  - mtk-quadspi:
    * rename config to a common one
    * add SNOR_HWCAPS_READ to spi_nor_hwcaps mask
  - Add Tudor as SPI-NOR co-maintainer

NAND changes
  NAND core changes:
  - Fourth batch of fixes/cleanup to the raw NAND core impacting various
    controller drivers (Sunxi, Marvell, MTK, TMIO, OMAP2).
  - Checking the return code of nand_reset() and nand_readid_op().
  - Removing ->legacy.erase and single_erase().
  - Simplifying the locking.
  - Several implicit fall through annotations.

  Raw NAND controllers drivers changes:
  - Fixing various possible object reference leaks (MTK, JZ4780, Atmel).
  - ST:
    * Adding support for STM32 FMC2 NAND flash controller.
  - Meson:
    * Adding support for Amlogic NAND flash controller.
  - Denali:
    * Several cleanup patches.
  - Sunxi:
    * Several cleanup patches.
  - FSMC:
    * Disabling NAND on remove().
    * Resetting NAND timings on resume().

  SPI-NAND drivers changes:
  - Toshiba:
    * Adding support for all Toshiba products.
  - Macronix:
    * Fixing ECC status read.
  - Gigadevice:
    * Adding support for GD5F1GQ4UExxG.

----------------------------------------------------------------
Ahmet Celenk (1):
      mtd: spi-nor: split s25fl128s into s25fl128s0 and s25fl128s1

André Valentin (1):
      mtd: spi-nor: Add support for mx25u3235f

Bean Huo (1):
      mtd: spi-nor: Fix wrong abbreviation HWCPAS

Boris Brezillon (16):
      mtd: Implement mtd_{read,write}() as wrappers around mtd_{read,write}_oob()
      mtd: rawnand: sunxi: Use a consistent name for sunxi_nand_chip objects
      mtd: rawnand: sunxi: Use struct_size()
      mtd: rawnand: sunxi: Name nand_chip objects consistently
      mtd: rawnand: sunxi: Stop passing mtd_info objects around
      mtd: rawnand: sunxi: Add an SPDX tag
      mtd: rawnand: sunxi: Migrate to ->exec_op()
      mtd: rawnand: sunxi: Fix kernel doc headers
      mtd: rawnand: sunxi: Handle the tREA > tRC / 2 case
      mtd: rawnand: mtk: Use nand_controller_init() instead of open-coding it
      mtd: rawnand: tmio: Do not abuse nand_controller->wq
      mtd: rawnand: omap2: Use nand_controller_init()
      mtd: rawnand: Stop using chip->state in drivers
      mtd: rawnand: Simplify the locking
      Merge tag 'spi-nor/for-5.1' of git://git.infradead.org/linux-mtd into mtd/next
      Merge tag 'nand/for-5.1' of git://git.infradead.org/linux-mtd into mtd/next

Christophe Kerello (3):
      dt-bindings: mtd: stm32_fmc2: add STM32 FMC2 NAND controller documentation
      mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND flash controller driver
      mtd: rawnand: stm32_fmc2: add polling mode

Colin Ian King (1):
      mtd: spi-nor: cadence-quadspi: fix spelling mistake: "Couldnt't" -> "Couldn't"

Emil Lenngren (1):
      mtd: spinand: macronix: Fix ECC Status Read

Frieder Schrempf (2):
      mtd: spi-nor: Add support for EN25Q80A
      mtd: spi-nor: Add support for MX25V8035F

Guochun Mao (1):
      mtd: spi-nor: mtk-quadspi: add SNOR_HWCAPS_READ to spi_nor_hwcaps mask

Gustavo A. R. Silva (4):
      mtd: gen_probe: Use struct_size() in kmalloc()
      mtd: cfi: cmdset_0001: Use struct_size() in kmalloc()
      mtd: lpddr: Use struct_size() in kzalloc()
      mtd: rawnand: marvell: use struct_size() in devm_kzalloc()

Jianxin Pan (1):
      MAINTAINERS: Add entry for Amlogic NAND controller driver

Liang Yang (2):
      dt-bindings: nand: meson: add Amlogic NAND controller driver
      mtd: rawnand: meson: add support for Amlogic NAND flash controller

Linus Walleij (2):
      mtd: rawnand: fsmc: Reset NAND timings on resume()
      mtd: rawnand: fsmc: Disable NAND on remove()

Masahiro Yamada (7):
      mtd: rawnand: denali: remove ->erase hook
      mtd: rawnand: remove ->legacy.erase and single_erase()
      mtd: rawnand: check return code of nand_reset() and nand_readid_op()
      mtd: rawnand: denali: remove unneeded denali_reset_irq() call
      mtd: rawnand: denali: remove unused function argument 'raw'
      mtd: rawnand: denali: remove unused dma_addr field from denali_nand_info
      mtd: rawnand: denali_dt: remove single anonymous clock support

Mathieu Malaterre (2):
      mtd: rawnand: Annotate implicit fall through in nand_command/nand_command_lp
      mtd: rawnand: Annotate implicit fall through in nand_scan_tail

Purna Chandra Mandal (1):
      mtd: spi-nor: cadence-quadspi: write upto 8-bytes data in STIG mode

Richard Weinberger (1):
      mtd: mtdram: Expose module parameters

Roger Pueyo Centelles (1):
      mtd: spi-nor: Add support for en25qh64

Ryder Lee (2):
      dt-bindings: mtd: mtk-quadspi: update bindings for MT7629 SoC
      mtd: spi-nor: mtk-quadspi: rename config to a common one

Sergei Shtylyov (2):
      mtd: spi-nor: add Spansion S25FS512S ID
      mtd: spi-nor: refine Spansion S25FL512S ID

Stefan Roese (2):
      mtd: Remove empty lines at end of sysfs related functions
      mtd: spinand: Add support for GigaDevice GD5F1GQ4UExxG

Tudor Ambarus (1):
      MAINTAINERS: add myself as SPI NOR co-maintainer

Vignesh R (2):
      dt-bindings: cadence-quadspi: Add new compatible for AM654 SoC
      mtd: spi-nor: cadence-quadspi: Add support for Octal SPI controller

Wen Yang (3):
      mtd: rawnand: atmel: fix possible object reference leak
      mtd: rawnand: jz4780: fix possible object reference leak
      mtd: rawnand: mtk: fix possible object reference leak

Yogesh Narayan Gaur (3):
      mtd: spi-nor: add opcodes for octal Read/Write commands
      mtd: spi-nor: add octal read flag for flash mt35xu512aba
      mtd: m25p80: add support of octal mode I/O transfer

Yoshio Furuyama (1):
      mtd: spinand: Add support for all Toshiba Memory products

YueHaibing (2):
      mtd: docg3: Fix passing zero to 'PTR_ERR' warning in doc_probe_device
      mtd: docg3: fix a possible memory leak of mtd->name

 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt |   60 ++
 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt    |    1 +
 Documentation/devicetree/bindings/mtd/mtk-quadspi.txt        |    3 +-
 Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt    |   61 +++
 MAINTAINERS                                                  |    8 +
 drivers/mtd/chips/cfi_cmdset_0001.c                          |    3 +-
 drivers/mtd/chips/gen_probe.c                                |    2 +-
 drivers/mtd/devices/docg3.c                                  |    7 +-
 drivers/mtd/devices/m25p80.c                                 |    9 +-
 drivers/mtd/devices/mtdram.c                                 |    2 -
 drivers/mtd/lpddr/qinfo_probe.c                              |    4 +-
 drivers/mtd/mtdcore.c                                        |   83 +--
 drivers/mtd/nand/raw/Kconfig                                 |   17 +
 drivers/mtd/nand/raw/Makefile                                |    2 +
 drivers/mtd/nand/raw/atmel/pmecc.c                           |   21 +-
 drivers/mtd/nand/raw/denali.c                                |   42 +-
 drivers/mtd/nand/raw/denali.h                                |    1 -
 drivers/mtd/nand/raw/denali_dt.c                             |   27 +-
 drivers/mtd/nand/raw/fsmc_nand.c                             |   16 +
 drivers/mtd/nand/raw/jz4780_bch.c                            |    9 +-
 drivers/mtd/nand/raw/marvell_nand.c                          |    5 +-
 drivers/mtd/nand/raw/meson_nand.c                            | 1464 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/nand/raw/mtk_ecc.c                               |    8 +-
 drivers/mtd/nand/raw/mtk_nand.c                              |    3 +-
 drivers/mtd/nand/raw/nand_base.c                             |  159 +++---
 drivers/mtd/nand/raw/nand_legacy.c                           |    3 +-
 drivers/mtd/nand/raw/omap2.c                                 |   20 +-
 drivers/mtd/nand/raw/r852.c                                  |    3 +-
 drivers/mtd/nand/raw/stm32_fmc2_nand.c                       | 2073 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/nand/raw/sunxi_nand.c                            |  732 +++++++++++++------------
 drivers/mtd/nand/raw/tmio_nand.c                             |   21 +-
 drivers/mtd/nand/spi/gigadevice.c                            |   83 +++
 drivers/mtd/nand/spi/macronix.c                              |    8 +-
 drivers/mtd/nand/spi/toshiba.c                               |   79 ++-
 drivers/mtd/spi-nor/Kconfig                                  |   16 +-
 drivers/mtd/spi-nor/Makefile                                 |    2 +-
 drivers/mtd/spi-nor/cadence-quadspi.c                        |   74 ++-
 drivers/mtd/spi-nor/mtk-quadspi.c                            |    3 +-
 drivers/mtd/spi-nor/spi-nor.c                                |   35 +-
 include/linux/mtd/rawnand.h                                  |   26 +-
 include/linux/mtd/spi-nor.h                                  |   16 +-
 41 files changed, 4536 insertions(+), 675 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt
 create mode 100644 drivers/mtd/nand/raw/meson_nand.c
 create mode 100644 drivers/mtd/nand/raw/stm32_fmc2_nand.c
