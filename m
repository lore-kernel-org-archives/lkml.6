Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393B9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E770F218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545235650;
	bh=i2R7Wx0UP+3whfdTuU9lwlQC57anO6PKV/9mtniIxV8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=etvAl7+HlvNDfbZmngMjAhdAPU+VJ/O0sx0EddoldfWsMT+8DWirilCI4s1CvDI3e
	 b+/d+ZnvGTxnyMrkSk7nHOgmOzIAQpdZ6Sb54Q29WGQ0AdHmi1Du8VTO6LCxHi5YHB
	 SwPtI8FM921NatOdzfOY2GCz/uAOG1dLAfGh4uq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbeLSQH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:07:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbeLSQH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:07:28 -0500
Received: from bbrezillon (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr [90.88.157.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22CD52084A;
        Wed, 19 Dec 2018 16:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545235647;
        bh=i2R7Wx0UP+3whfdTuU9lwlQC57anO6PKV/9mtniIxV8=;
        h=Date:From:To:Cc:Subject:From;
        b=oLc9+KAGtEgC70iAE1vbczxqsHhZ4ZWff/iq+qRQoZBnMCfqUXCAFqcV3wvF/Mp0C
         D7hCGwdGqKgOkcm/9UcgP8U47/g9/nCYz3lD2c4ENtSVNuJ07tznE4VF9ny9bZY2Hf
         FuHpZ8Gyy+hBiYIsa2FrQM9UEurfT6fKZOvEfhPs=
Date:   Wed, 19 Dec 2018 17:07:22 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marex@denx.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>
Subject: [GIT PULL] mtd: Changes for 4.21
Message-ID: <20181219170722.349d7b61@bbrezillon>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the MTD PR for 4.21 coming a bit earlier than usual (hope this
is not a problem).

Regards,

Boris

The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:

  Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-mtd.git tags/mtd/for-4.21

for you to fetch changes up to f366d3854ec0fec0f9949dac46431598614a956b:

  Merge tag 'spi-nor/for-4.21' of git://git.infradead.org/linux-mtd into mt=
d/next (2018-12-18 20:00:52 +0100)

----------------------------------------------------------------
SPI NOR Changes
  Core changes:
  - Parse the 4BAIT SFDP section
  - Add a bunch of SPI NOR entries to the flash_info table
  - Add the concept of SFDP fixups and use it to fix a bug on MX25L25635F
  - A bunch of minor cleanups/comestic changes

NAND changes:
  NAND core changes:
  - kernel-doc miscellaneous fixes.
  - Third batch of fixes/cleanup to the raw NAND core impacting various
    controller drivers (ams-delta, marvell, fsmc, denali, tegra, vf610):
    * Stopping to pass mtd_info objects to internal functions
    * Reorganizing code to avoid forward declarations
    * Dropping useless test in nand_legacy_set_defaults()
    * Moving nand_exec_op() to internal.h
    * Adding nand_[de]select_target() helpers
    * Passing the CS line to be selected in struct nand_operation
    * Making ->select_chip() optional when ->exec_op() is implemented
    * Deprecating the ->select_chip() hook
    * Moving the ->exec_op() method to nand_controller_ops
    * Moving ->setup_data_interface() to nand_controller_ops
    * Deprecating the dummy_controller field
    * Fixing JEDEC detection
    * Providing a helper for polling GPIO R/B pin

  Raw NAND chip drivers changes:
  - Macronix:
    * Flagging 1.8V AC chips with a broken GET_FEATURES(TIMINGS)

  Raw NAND controllers drivers changes:
  - Ams-delta:
    * Fixing the error path
    * SPDX tag added
    * May be compiled with COMPILE_TEST=3Dy
    * Conversion to ->exec_op() interface
    * Dropping .IOADDR_R/W use
    * Use GPIO API for data I/O
  - Denali:
    * Removing denali_reset_banks()
    * Removing ->dev_ready() hook
    * Including <linux/bits.h> instead of <linux/bitops.h>
    * Changes to comply with the above fixes/cleanup done in the core.
  - FSMC:
    * Adding an SPDX tag to replace the license text
    * Making conversion from chip to fsmc consistent
    * Fixing unchecked return value in fsmc_read_page_hwecc
    * Changes to comply with the above fixes/cleanup done in the core.
  - Marvell:
    * Preventing timeouts on a loaded machine (fix)
    * Changes to comply with the above fixes/cleanup done in the core.
  - OMAP2:
    * Pass the parent of pdev to dma_request_chan() (fix)
  - R852:
    * Use generic DMA API
  - sh_flctl:
    * Converting to SPDX identifiers
  - Sunxi:
    * Write pageprog related opcodes to the right register: WCMD_SET (fix)
  - Tegra:
    * Stop implementing ->select_chip()
  - VF610:
    * Adding an SPDX tag to replace the license text
    * Changes to comply with the above fixes/cleanup done in the core.
  - Various trivial/spelling/coding style fixes.

  SPI-NAND drivers changes:
  - Removing the depreacated mt29f_spinand driver from staging.
  - Adding support for:
    * Toshiba TC58CVG2S0H
    * GigaDevice GD5FxGQ4xA
    * Winbond W25N01GV

JFFS2 changes:
- Fix a lockdep issue

MTD changes:
- Rework the physmap driver to merge gpio-addr-flash and physmap_of
  in it
- Add a new compatible for RedBoot partitions
- Make sub-partitions RW if the parent partition was RO because of a
  mis-alignment
- Add pinctrl support to the
- Addition of /* fall-through */ comments where appropriate
- Various minor fixes and cleanups

Other changes:
- Update my email address

----------------------------------------------------------------
Alexander Sverdlin (1):
      mtd: spi-nor: Add support for mx25u12835f

Boris Brezillon (61):
      mtd: maps: physmap: Add SPDX header
      mtd: maps: physmap: Rename ->map and ->mtd into ->maps and ->mtds
      mtd: maps: physmap: Use platform_get_resource() to retrieve iomem res=
ources
      mtd: maps: physmap: Use dev_notice() and a %pR specifier
      mtd: maps: physmap: Use devm_ioremap_resource()
      mtd: maps: physmap: Remove the MAX_RESOURCES limitation
      mtd: maps: physmap: Check mtd_device_{parse_register, unregister}() r=
et code
      mtd: maps: physmap: Return -ENOMEM directly when info allocation fails
      mtd: maps: physmap: Fix coding style issues reported by checkpatch
      mtd: maps: Prepare merging of physmap and physmap_of
      mtd: maps: Merge physmap_of.c into physmap-core.c
      mtd: maps: Rename physmap_of_{versatile, gemini} into physmap-{versat=
ile, gemini}
      mtd: maps: Merge gpio-addr-flash.c into physmap-core.c
      staging: Remove the mt29f_spinand driver
      mtd: maps: Get rid of the latch-addr-flash driver
      mtd: rawnand: Stop passing mtd_info objects to internal functions
      mtd: rawnand: Reorganize code to avoid forward declarations
      mtd: rawnand: legacy: Drop useless test in nand_legacy_set_defaults()
      mtd: rawnand: Move nand_exec_op() to internal.h
      mtd: rawnand: Remove unused NAND_CONTROLLER_ALLOC flag
      mtd: rawnand: ams-delta: Allow this driver to be compiled when COMPIL=
E_TEST=3Dy
      mtd: rawnand: ams-delta: Add an SPDX tag to replace the license text
      mtd: rawnand: ams-delta: Fix various coding style issues
      mtd: rawnand: ams-delta: cleanup ams_delta_init() error path
      mtd: rawnand: ams-delta: Check mtd_device_register() return code
      mtd: rawnand: ams-delta: Explicitly inherit from nand_controller
      mtd: rawnand: Add nand_[de]select_target() helpers
      mtd: rawnand: Pass the CS line to be selected in struct nand_operation
      mtd: rawnand: Make ->select_chip() optional when ->exec_op() is imple=
mented
      mtd: rawnand: fsmc: Stop implementing ->select_chip()
      mtd: rawnand: marvell: Stop implementing ->select_chip()
      mtd: rawnand: tegra: Stop implementing ->select_chip()
      mtd: rawnand: vf610: Stop implementing ->select_chip()
      mtd: rawnand: ams-delta: Stop implementing ->select_chip()
      mtd: rawnand: Deprecate the ->select_chip() hook
      mtd: rawnand: Move the ->exec_op() method to nand_controller_ops
      mtd: rawnand: Move ->setup_data_interface() to nand_controller_ops
      mtd: rawnand: fsmc: Stop passing mtd_info objects to internal functio=
ns
      mtd: rawnand: fsmc: Fix the fsmc_nand_data kernel-doc
      mtd: rawnand: fsmc: Make conversion from chip to fsmc consistent
      mtd: rawnand: fsmc: Stop using the dummy controller obj
      mtd: rawnand: fsmc: Add an SPDX tag to replace the license text
      mtd: rawnand: fsmc: Fix all coding style issues reported by checkpatch
      mtd: rawnand: vf610: Stop passing mtd_info to internal functions
      mtd: rawnand: vf610: Stop using the dummy controller obj
      mtd: rawnand: vf610: Add an SPDX tag to replace the license text
      mtd: rawnand: Deprecate the dummy_controller field
      mtd: spi-nor: Add the SNOR_F_4B_OPCODES flag
      mtd: spi-nor: Add a post BFPT parsing fixup hook
      mtd: spi-nor: Add a post BFPT fixup for MX25L25635E
      mtd: spi-nor: Drop inline on all internal helpers
      mtd: spi-nor: Avoid forward declaration of internal functions
      mtd: spi-nor: Stop passing flash_info around
      mtd: spi-nor: Make the enable argument passed to set_byte() a bool
      mtd: spi-nor: Add an SPDX tag to spi-nor.{c,h}
      mtd: rawnand: Fix JEDEC detection
      mtd: rawnand: omap2: Pass the parent of pdev to dma_request_chan()
      MAINTAINERS: Update my email address
      mtd: rawnand: sunxi: Write pageprog related opcodes to WCMD_SET
      Merge tag 'nand/for-4.21' of git://git.infradead.org/linux-mtd into m=
td/next
      Merge tag 'spi-nor/for-4.21' of git://git.infradead.org/linux-mtd int=
o mtd/next

Christoph Hellwig (1):
      mtd: rawnand: r852: use generic DMA API

Chuanhong Guo (1):
      mtd: spinand: add support for GigaDevice GD5FxGQ4xA

Colin Ian King (2):
      mtd: Kconfig: fix spelling mistake "partions" -> "partition"
      mtd: nftl: clean up indentation, remove extraneous tabs

Cyrille Pitchen (1):
      mtd: spi-nor: parse SFDP 4-byte Address Instruction Table

Daniel Santos (1):
      jffs2: Fix use of uninitialized delayed_work, lockdep breakage

Fabrizio Castro (1):
      mtd: spi-nor: Add support for is25lp016d

Gustavo A. R. Silva (3):
      mtd: rawnand: fsmc: Fix unchecked return value in fsmc_read_page_hwecc
      mtd: block2mtd: mark expected switch fall-throughs
      mtd: cfi_cmdset_0020: Mark expected switch fall-throughs

Janusz Krzysztofik (7):
      mtd: rawnand: Provide helper for polling GPIO R/B pin
      mtd: rawnand: ams-delta: Stop using legacy .IOADDR_R/W
      mtd: rawnand: ams-delta: Convert the driver to ->exec_op()
      ARM: OMAP1: ams-delta: Provide GPIO lookup table for NAND data port
      mtd: rawnand: ams-delta: Request data port GPIO resource
      mtd: rawnand: ams-delta: Use GPIO API for data I/O
      ARM: OMAP1: ams-delta: Drop obsolete NAND resources

Kuninori Morimoto (1):
      mtd: rawnand: sh_flctl: convert to SPDX identifiers

Linus Walleij (5):
      mtd: Move Redboot partition parser
      mtd: partitions: Add RedBoot FIS DT bindings
      mtd: partitions: Add OF support to RedBoot partitions
      mtd: maps: physmap: Leave assigned complex mappings
      mtd: physmap_of_gemini: Handle pin control

Liu Xiang (1):
      mtd: spi-nor: Add 4B_OPCODES flag to is25lp256

Masahiro Yamada (3):
      mtd: rawnand: denali: include <linux/bits.h> instead of <linux/bitops=
.h>
      mtd: rawnand: denali: remove ->dev_ready() hook
      mtd: rawnand: denali: remove denali_reset_banks()

Mason Yang (1):
      mtd: rawnand: Flag 1.8V AC chips with a broken GET_FEATURES(TIMINGS)

Mathieu Malaterre (1):
      mtd: rawnand: jz4780: annotate implicit fall throughs

Miquel Raynal (5):
      Merge tag 'v4.20-rc2' of git://git.kernel.org/.../torvalds/linux into=
 nand/next
      mtd: fix mtd_oobavail() incoherent returned value
      mtd: fix Coverity integer handling issue
      mtd: rawnand: marvell: fix spelling mistake in kernel doc
      mtd: rawnand: marvell: prevent timeouts on a loaded machine

Rafa=C5=82 Mi=C5=82ecki (2):
      mtd: keep original flags for every struct mtd_info
      mtd: improve calculating partition boundaries when checking for align=
ment

Ricardo Ribalda Delgado (2):
      dt-binding: mtd: physmap: Document the addr-gpios property
      mtd: maps: physmap: Invert logic on if/else branch

Robert Marko (2):
      mtd: spinand: winbond: Add support for W25N01GV
      mtd: spi-nor: Add Winbond w25q128jv support

Schrempf Frieder (1):
      mtd: spinand: Add initial support for Toshiba TC58CVG2S0H

Tudor.Ambarus@microchip.com (2):
      mtd: spi-nor: remove unneeded smpt zeroization
      mtd: spi-nor: mark desirable switch case fall through

Uwe Kleine-K=C3=B6nig (1):
      mtd: spi-nor: Add support for IS25LP032/064

Yangtao Li (1):
      mtd: use DEFINE_SHOW_ATTRIBUTE() instead of open-coding it

Yogesh Narayan Gaur (2):
      mtd: spi-nor: add macros related to MICRON flash
      mtd: spi-nor: add entry for mt35xu512aba flash

huijin.park (2):
      mtd: change len type from signed to unsigned type
      mtd: spi-nor: cast to u64 to avoid uint overflows

 .mailmap                                                         |    7 +-
 Documentation/devicetree/bindings/mtd/mtd-physmap.txt            |    2 +
 Documentation/devicetree/bindings/mtd/partitions/redboot-fis.txt |   27 +
 MAINTAINERS                                                      |    8 +-
 arch/arm/mach-omap1/board-ams-delta.c                            |   22 +-
 drivers/mtd/Kconfig                                              |   52 +-
 drivers/mtd/Makefile                                             |    1 -
 drivers/mtd/chips/cfi_cmdset_0020.c                              |    6 +
 drivers/mtd/devices/block2mtd.c                                  |    2 +
 drivers/mtd/devices/docg3.c                                      |   16 +-
 drivers/mtd/devices/docg3.h                                      |   11 -
 drivers/mtd/maps/Kconfig                                         |   37 +-
 drivers/mtd/maps/Makefile                                        |   11 +-
 drivers/mtd/maps/gpio-addr-flash.c                               |  281 --=
-----
 drivers/mtd/maps/latch-addr-flash.c                              |  229 --=
----
 drivers/mtd/maps/physmap-core.c                                  |  665 ++=
+++++++++++++
 drivers/mtd/maps/{physmap_of_gemini.c =3D> physmap-gemini.c}       |  112 =
++-
 drivers/mtd/maps/{physmap_of_gemini.h =3D> physmap-gemini.h}       |    2 =
+-
 drivers/mtd/maps/{physmap_of_versatile.c =3D> physmap-versatile.c} |    2 =
+-
 drivers/mtd/maps/{physmap_of_versatile.h =3D> physmap-versatile.h} |    2 =
+-
 drivers/mtd/maps/physmap.c                                       |  280 --=
-----
 drivers/mtd/maps/physmap_of_core.c                               |  368 --=
-------
 drivers/mtd/mtdblock.c                                           |    2 +-
 drivers/mtd/mtdcore.c                                            |    8 +-
 drivers/mtd/mtdpart.c                                            |   16 +-
 drivers/mtd/mtdswap.c                                            |   13 +-
 drivers/mtd/nand/raw/Kconfig                                     |    2 +-
 drivers/mtd/nand/raw/ams-delta.c                                 |  267 ++=
+---
 drivers/mtd/nand/raw/atmel/nand-controller.c                     |    9 +-
 drivers/mtd/nand/raw/au1550nd.c                                  |    2 +-
 drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c                 |    2 +-
 drivers/mtd/nand/raw/cafe_nand.c                                 |    4 +-
 drivers/mtd/nand/raw/davinci_nand.c                              |    4 +-
 drivers/mtd/nand/raw/denali.c                                    |   59 +-
 drivers/mtd/nand/raw/denali.h                                    |    2 +-
 drivers/mtd/nand/raw/diskonchip.c                                |    4 +-
 drivers/mtd/nand/raw/fsl_elbc_nand.c                             |    2 +-
 drivers/mtd/nand/raw/fsl_ifc_nand.c                              |    2 +-
 drivers/mtd/nand/raw/fsl_upm.c                                   |    2 +-
 drivers/mtd/nand/raw/fsmc_nand.c                                 |  303 ++=
++---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c                       |   29 +-
 drivers/mtd/nand/raw/hisi504_nand.c                              |    4 +-
 drivers/mtd/nand/raw/internals.h                                 |   33 +
 drivers/mtd/nand/raw/jz4740_nand.c                               |    8 +-
 drivers/mtd/nand/raw/jz4780_bch.c                                |    2 +
 drivers/mtd/nand/raw/jz4780_nand.c                               |    2 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c                               |    2 +-
 drivers/mtd/nand/raw/lpc32xx_slc.c                               |    2 +-
 drivers/mtd/nand/raw/marvell_nand.c                              |   51 +-
 drivers/mtd/nand/raw/mpc5121_nfc.c                               |    4 +-
 drivers/mtd/nand/raw/mtk_nand.c                                  |    4 +-
 drivers/mtd/nand/raw/mxc_nand.c                                  |   16 +-
 drivers/mtd/nand/raw/nand_base.c                                 |  771 ++=
++++++++--------
 drivers/mtd/nand/raw/nand_bbt.c                                  |  285 ++=
+----
 drivers/mtd/nand/raw/nand_hynix.c                                |    8 +-
 drivers/mtd/nand/raw/nand_jedec.c                                |    2 +
 drivers/mtd/nand/raw/nand_legacy.c                               |   35 +-
 drivers/mtd/nand/raw/nand_macronix.c                             |    7 +
 drivers/mtd/nand/raw/nandsim.c                                   |   19 +-
 drivers/mtd/nand/raw/ndfc.c                                      |    2 +-
 drivers/mtd/nand/raw/omap2.c                                     |    2 +-
 drivers/mtd/nand/raw/plat_nand.c                                 |    2 +-
 drivers/mtd/nand/raw/qcom_nandc.c                                |    2 +-
 drivers/mtd/nand/raw/r852.c                                      |   30 +-
 drivers/mtd/nand/raw/s3c2410.c                                   |    7 +-
 drivers/mtd/nand/raw/sh_flctl.c                                  |   21 +-
 drivers/mtd/nand/raw/sm_common.c                                 |    2 +-
 drivers/mtd/nand/raw/sunxi_nand.c                                |    6 +-
 drivers/mtd/nand/raw/tango_nand.c                                |    4 +-
 drivers/mtd/nand/raw/tegra_nand.c                                |   34 +-
 drivers/mtd/nand/raw/vf610_nfc.c                                 |   98 ++-
 drivers/mtd/nand/raw/xway_nand.c                                 |    2 +-
 drivers/mtd/nand/spi/Makefile                                    |    2 +-
 drivers/mtd/nand/spi/core.c                                      |    2 +
 drivers/mtd/nand/spi/gigadevice.c                                |  148 ++=
++
 drivers/mtd/nand/spi/toshiba.c                                   |  137 ++=
++
 drivers/mtd/nand/spi/winbond.c                                   |    8 +
 drivers/mtd/nftlmount.c                                          |   33 +-
 drivers/mtd/parsers/Kconfig                                      |   50 ++
 drivers/mtd/parsers/Makefile                                     |    1 +
 drivers/mtd/{ =3D> parsers}/redboot.c                              |   32 =
+-
 drivers/mtd/spi-nor/spi-nor.c                                    | 1342 ++=
++++++++++++++++-------------
 drivers/staging/Kconfig                                          |    2 -
 drivers/staging/Makefile                                         |    1 -
 drivers/staging/mt29f_spinand/Kconfig                            |   16 -
 drivers/staging/mt29f_spinand/Makefile                           |    1 -
 drivers/staging/mt29f_spinand/TODO                               |   13 -
 drivers/staging/mt29f_spinand/mt29f_spinand.c                    |  980 --=
--------------------
 drivers/staging/mt29f_spinand/mt29f_spinand.h                    |  106 ---
 fs/jffs2/super.c                                                 |    3 +-
 include/linux/mtd/cfi.h                                          |    1 +
 include/linux/mtd/mtd.h                                          |    3 +-
 include/linux/mtd/rawnand.h                                      |  158 ++=
--
 include/linux/mtd/sh_flctl.h                                     |   16 +-
 include/linux/mtd/spi-nor.h                                      |   11 +-
 include/linux/mtd/spinand.h                                      |    2 +
 96 files changed, 3302 insertions(+), 4108 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/redboo=
t-fis.txt
 delete mode 100644 drivers/mtd/maps/gpio-addr-flash.c
 delete mode 100644 drivers/mtd/maps/latch-addr-flash.c
 create mode 100644 drivers/mtd/maps/physmap-core.c
 rename drivers/mtd/maps/{physmap_of_gemini.c =3D> physmap-gemini.c} (50%)
 rename drivers/mtd/maps/{physmap_of_gemini.h =3D> physmap-gemini.h} (90%)
 rename drivers/mtd/maps/{physmap_of_versatile.c =3D> physmap-versatile.c} =
(99%)
 rename drivers/mtd/maps/{physmap_of_versatile.h =3D> physmap-versatile.h} =
(90%)
 delete mode 100644 drivers/mtd/maps/physmap.c
 delete mode 100644 drivers/mtd/maps/physmap_of_core.c
 create mode 100644 drivers/mtd/nand/spi/gigadevice.c
 create mode 100644 drivers/mtd/nand/spi/toshiba.c
 rename drivers/mtd/{ =3D> parsers}/redboot.c (92%)
 delete mode 100644 drivers/staging/mt29f_spinand/Kconfig
 delete mode 100644 drivers/staging/mt29f_spinand/Makefile
 delete mode 100644 drivers/staging/mt29f_spinand/TODO
 delete mode 100644 drivers/staging/mt29f_spinand/mt29f_spinand.c
 delete mode 100644 drivers/staging/mt29f_spinand/mt29f_spinand.h
