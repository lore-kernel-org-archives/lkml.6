Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC69C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4194E20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VY+vkwOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4194E20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeJYSEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbeJYSEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:04:32 -0400
Received: from localhost (unknown [185.7.230.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9665D2082E;
        Thu, 25 Oct 2018 09:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540459956;
        bh=hOQRXZ7X317jOGq3bAVqR/fPrM1pZVF3gNEXR7cItw0=;
        h=Date:From:To:Cc:Subject:From;
        b=VY+vkwOVC635QglYfmXxDB7CkFz/KfN7R0AzXsRfvdah4U3uvArwPl/6VfjKZFJWm
         UfVXjcfU5H5hfRU7ZsYpbfdOIYd4YlXRs0dzo8JpmmssdSNHKEtNg/AXA64ptAjqdL
         dbBS9Eeyp7qXkPTmy208sK4z6X6P112OPlgOUGJ4=
Date:   Thu, 25 Oct 2018 10:32:33 +0100
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] dmaengine updates for v4.20/5.0
Message-ID: <20181025093233.GB3089@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

First, good to have you back!

Please PULL to receive updates for this v5.0 (?) which contain:
 - Support for ColdFire mcf5441x edma controller
 - Support for link list mode in sprd dma
 - More users of managed dmaenginem_async_device_register API
 - Cyclic mode support in owl dma driver
 - DT updates for renesas drivers, dma-jz4780 updates and support for
   JZ4770, JZ4740 and JZ4725B controllers
 - Removal of deprecated dma_slave_config direction in dmaengine drivers,
   few more users will be removed in next cycle and eventually users.
 - Minor updates to idma64, ioat, pxa, ppc drivers

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-4.20-rc1

for you to fetch changes up to 71f021cf6de822ac49a790509683fbb4a06ce4bf:

  Merge branch 'topic/stm' into for-linus (2018-10-24 09:16:33 +0100)

----------------------------------------------------------------
DMAengine updates for v4.20-rc1

Change this time round are:
 - Support for ColdFire mcf5441x edma controller
 - Support for link list mode in sprd dma
 - More users of managed dmaenginem_async_device_register API
 - Cyclic mode support in owl dma driver
 - DT updates for renesas drivers, dma-jz4780 updates and support for
   JZ4770, JZ4740 and JZ4725B controllers
 - Removal of deprecated dma_slave_config direction in dmaengine drivers,
   few more users will be removed in next cycle and eventually users.
 - Minor updates to idma64, ioat, pxa, ppc drivers

----------------------------------------------------------------
Angelo Dureghello (5):
      dmaengine: fsl-edma: extract common fsl-edma code (no changes in beha=
vior intended)
      dmaengine: fsl-edma: add edma version and configurable registers
      dmaengine: fsl-edma: fix macros
      dmaengine: fsl-edma: add ColdFire mcf5441x edma support
      dmaengine: mcf-edma: avoid warning for wrong pointer cast

Barry Song (3):
      dmaengine: fsldma: move spin_lock_bh to spin_lock in tasklet
      dmaengine: mv_xor: move spin_lock_bh to spin_lock in tasklet
      dmaengine: at_xdmac: move spin_lock_bh to spin_lock in tasklet

Biju Das (2):
      dt-bindings: rcar-dmac: Document r8a7744 support
      dt-bindings: dmaengine: usb-dmac: Add binding for r8a7744

Christian Lamparter (1):
      dmaengine: ppc4xx: fix off-by-one build failure

Daniel Silsby (5):
      dmaengine: dma-jz4780: Add missing residue DTC mask
      dmaengine: dma-jz4780: Simplify jz4780_dma_desc_residue()
      dmaengine: dma-jz4780: Set DTCn register explicitly
      dmaengine: dma-jz4780: Further residue status fix
      dmaengine: dma-jz4780: Use dma_set_residue()

Eric Long (1):
      dmaengine: sprd: Support DMA link-list mode

Hans de Goede (1):
      dmaengine: dw: Add alternative ACPI HIDs for Cherry Trail DMA control=
lers

Huang Shijie (9):
      dmaengine: st_fdma: use dmaenginem_async_device_register to simplify =
the code
      dmaengine: dw-axi-dmac: use dmaenginem_async_device_register to simpl=
ify the code
      dmaengine: stm32-mdma: use dmaenginem_async_device_register to simpli=
fy the code
      dmaengine: mmp_tdma: use dmaenginem_async_device_register to simplify=
 the code
      dmaengine: ste_dma40: use dmaenginem_async_device_register to simplif=
y the code
      dmaengine: dma-jz4780: use dmaenginem_async_device_register to simpli=
fy the code
      dmaengine: pxa_dma: use dmaenginem_async_device_register to simplify =
the code
      dmaengine: mxs-dma: use dmaenginem_async_device_register to simplify =
the code
      dmaengine: add COMPILE_TEST for the drivers

Manivannan Sadhasivam (2):
      dmaengine: owl: Add Slave and Cyclic mode support for Actions Semi Ow=
l S900 SoC
      dmaengine: owl: Fix warnings generated during build

Nathan Chancellor (2):
      dmaengine: ep93xx: Return proper enum in ep93xx_dma_chan_direction
      dmaengine: timb_dma: Use proper enum in td_prep_slave_sg

Paul Cercueil (13):
      dt-bindings: jz4780-dma: Update bindings to reflect driver changes
      dmaengine: dma-jz4780: Return error if not probed from DT
      dmaengine: dma-jz4780: Avoid hardcoding number of channels
      dmaengine: dma-jz4780: Separate chan/ctrl registers
      dmaengine: dma-jz4780: Use 4-word descriptors
      dmaengine: dma-jz4780: Don't depend on MACH_JZ4780
      dmaengine: dma-jz4780: Add support for the JZ4770 SoC
      dmaengine: dma-jz4780: Add support for the JZ4740 SoC
      dmaengine: dma-jz4780: Add support for the JZ4725B SoC
      dmaengine: dma-jz4780: Enable Fast DMA to the AIC
      MIPS: JZ4780: DTS: Update DMA node to match driver changes
      MIPS: JZ4770: DTS: Add DMA nodes
      MIPS: JZ4740: DTS: Add DMA nodes

Pierre-Yves MORDRET (1):
      dmaengine: stm32-dma: check whether length is aligned on FIFO thresho=
ld

Rami Rosen (1):
      dmaengine: ioat: fix prototype of ioat_enumerate_channels

Rob Herring (1):
      dmaengine: Convert to using %pOFn instead of device_node.name

Vinod Koul (27):
      dmaengine: Revert "dmaengine: add COMPILE_TEST for the drivers"
      dmaengine: at_hdmac: remove dma_slave_config direction usage
      dmaengine: bcm2835: remove dma_slave_config direction usage
      dmaengine: coh901318: remove dma_slave_config direction usage
      dmaengine: jz4740: remove dma_slave_config direction usage
      dmaengine: dw: remove dma_slave_config direction usage
      dmaengine: hsu: remove dma_slave_config direction usage
      dmaengine: idma: remove dma_slave_config direction usage
      dmaengine: imx-dma: remove dma_slave_config direction usage
      dmaengine: k3dma: dont use direction for memcpy
      dmaengine: k3dma: remove dma_slave_config direction usage
      dmaengine: ep93xx_dma: remove dma_slave_config direction usage
      dmaengine: mmp_tdma: remove dma_slave_config direction usage
      dmaengine: fsl-edma: remove dma_slave_config direction usage
      Merge branch 'topic/at' into for-linus
      Merge branch 'topic/dirn_remove' into for-linus
      Merge branch 'topic/dmam' into for-linus
      Merge branch 'topic/dw' into for-linus
      Merge branch 'topic/fsl' into for-linus
      Merge branch 'topic/intel' into for-linus
      Merge branch 'topic/jz' into for-linus
      Merge branch 'topic/mv' into for-linus
      Merge branch 'topic/of' into for-linus
      Merge branch 'topic/owl' into for-linus
      Merge branch 'topic/renesas' into for-linus
      Merge branch 'topic/sprd' into for-linus
      Merge branch 'topic/stm' into for-linus

Waiman Long (1):
      driver/dma/ioat: Call del_timer_sync() without holding prep_lock

Wolfram Sang (2):
      dmaengine: use SPDX identifier for Renesas drivers
      dmaengine: rcar-dmac: set scatter/gather max segment size

Zhaoxiong Yuan (1):
      dmaengine: idma64: replace spin_lock_irqsave with spin_lock

kbuild test robot (1):
      dmaengine: pxa: fix semicolon.cocci warnings

 .../devicetree/bindings/dma/jz4780-dma.txt         |  14 +-
 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |   1 +
 .../devicetree/bindings/dma/renesas,usb-dmac.txt   |   1 +
 arch/mips/boot/dts/ingenic/jz4740.dtsi             |  15 +
 arch/mips/boot/dts/ingenic/jz4770.dtsi             |  30 +
 arch/mips/boot/dts/ingenic/jz4780.dtsi             |   3 +-
 drivers/dma/Kconfig                                |  13 +-
 drivers/dma/Makefile                               |   3 +-
 drivers/dma/at_hdmac.c                             |   2 +-
 drivers/dma/at_xdmac.c                             |   4 +-
 drivers/dma/bcm2835-dma.c                          |   8 -
 drivers/dma/coh901318.c                            |  28 +-
 drivers/dma/dma-jz4740.c                           |  21 +-
 drivers/dma/dma-jz4780.c                           | 289 +++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |   4 +-
 drivers/dma/dw/core.c                              |   5 -
 drivers/dma/dw/platform.c                          |   2 +
 drivers/dma/ep93xx_dma.c                           |  21 +-
 drivers/dma/fsl-edma-common.c                      | 626 ++++++++++++++++++
 drivers/dma/fsl-edma-common.h                      | 233 +++++++
 drivers/dma/fsl-edma.c                             | 729 +----------------=
----
 drivers/dma/fsldma.c                               |   4 +-
 drivers/dma/hsu/hsu.c                              |   4 -
 drivers/dma/idma64.c                               |   9 +-
 drivers/dma/imx-dma.c                              |  20 +-
 drivers/dma/ioat/init.c                            |  16 +-
 drivers/dma/k3dma.c                                |  36 +-
 drivers/dma/mcf-edma.c                             | 317 +++++++++
 drivers/dma/mmp_tdma.c                             |  29 +-
 drivers/dma/mv_xor.c                               |   4 +-
 drivers/dma/mxs-dma.c                              |   3 +-
 drivers/dma/nbpfaxi.c                              |   9 +-
 drivers/dma/owl-dma.c                              | 283 +++++++-
 drivers/dma/ppc4xx/adma.c                          |   2 +-
 drivers/dma/pxa_dma.c                              |   5 +-
 drivers/dma/sh/rcar-dmac.c                         |   3 +
 drivers/dma/sh/shdma-arm.h                         |   5 +-
 drivers/dma/sh/shdma-base.c                        |   5 +-
 drivers/dma/sh/shdma-of.c                          |   5 +-
 drivers/dma/sh/shdma-r8a73a4.c                     |   5 +-
 drivers/dma/sh/shdma.h                             |   6 +-
 drivers/dma/sh/shdmac.c                            |   6 +-
 drivers/dma/sh/sudmac.c                            |   5 +-
 drivers/dma/sh/usb-dmac.c                          |   5 +-
 drivers/dma/sprd-dma.c                             |  81 ++-
 drivers/dma/st_fdma.c                              |   7 +-
 drivers/dma/ste_dma40.c                            |  14 +-
 drivers/dma/stm32-dma.c                            |  20 +-
 drivers/dma/stm32-mdma.c                           |   4 +-
 drivers/dma/timb_dma.c                             |   2 +-
 include/linux/dma/sprd-dma.h                       |  69 ++
 include/linux/platform_data/dma-ep93xx.h           |   2 +-
 include/linux/platform_data/dma-mcf-edma.h         |  38 ++
 53 files changed, 2108 insertions(+), 967 deletions(-)
 create mode 100644 drivers/dma/fsl-edma-common.c
 create mode 100644 drivers/dma/fsl-edma-common.h
 create mode 100644 drivers/dma/mcf-edma.c
 create mode 100644 include/linux/platform_data/dma-mcf-edma.h
--=20
~Vinod

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJb0Y2xAAoJEHwUBw8lI4NHacIP/0ohBaDYRDbWaRyhvWG7pH9s
CD5ab8lrNMHZnmh70muZrkKOrWxz8jCuShXJMdJD+0B1v/4dO02axU8TVE/lBIFW
WLU2fvqJnKGIy3YaBmIs4y38H3x0rRzLmJ3UXJj7wUkDSlgikTflHNhLV8BWzlMZ
LR4nn5hMUncFeNYAcDjujyD8GhpIdIToJjK3X/oRFwmleOFko/T1bAL1CRKC+2TT
HctvOeSD925enqsxjwwakSig9fTub6drLsEw1srd6iAAU2tDO6fAa5fSOHKLlTF0
+i+K4dy46j7wx7o6kwxrIMtROIft4QzBKT67nZ5EgJHJjaCTVMwpexCAgE0OXiYq
lelfryxFsU9DiHojCt4DsUJxm/jtp4D1pcujIB+QN2WgYk3tXaraaIvRVEXT2xrP
CeJGv2tG2vkAV33wHHlKuJ/fgWFaSKYqQCj7C58oFa/jn0WbTMKmzDMWDrVA8Ziz
PSkT7oRW9izuTEuVACZLCDYcyMKo1BkjkzfuO/Kpp7RsoGMZG82BPdIPnUWIKELK
44CfVkpoy8zrEgsvagdpsLiB1xSjNs7rJDDdiX1GjZCDfMPKor1+8uJmW4q/PXSo
JZZtwFR3bguKpiGBa5670uCxePbTeQli97Rnyg3COHkfgwdmg2y3IrlgFSlHK0Yo
mVGvw/TVZHlmKBd6YyBe
=Q+/T
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
