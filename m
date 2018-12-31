Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10443C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 14:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EE72133F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 14:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546267999;
	bh=3Ze8h5G6HglRvpthkmVKS4bzs9t9WGNmVLVDf2+Wihg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=QIiXsjaC8WEVGOlbHlE06R5BKcA9ES0Dg51vG3f1mTEIT1uuCEmIE91olaukQE1IL
	 zgRtnm4op0Beq2YeO9I3/a3MMFvX+wZyUdLJ2pE+IGZpUJOl/yHpBgcWE7UYIZizUv
	 mQvytmisVKMRqWDLqO4VMVnDEjvJvOEXbc4Q5+5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbeLaOxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 09:53:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbeLaOxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 09:53:17 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 767522133F;
        Mon, 31 Dec 2018 14:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546267996;
        bh=3Ze8h5G6HglRvpthkmVKS4bzs9t9WGNmVLVDf2+Wihg=;
        h=Date:From:To:Cc:Subject:From;
        b=T5xXX3Dq6aZ8CscJqEK4JpxWrq9dtkwwT6VPatFHX0Ah5DmeMs0hiK5tsKQKKnErk
         5XPB1ycCmEsTCCskoUQqJZYK9wmbPpHre9+WKDh3X6+dAsrHMFhjhzxD4XVgFf2bTs
         w7jBhDvo1wsFSTG89IiQUNpgN2p13/yFDhyTwow0=
Date:   Mon, 31 Dec 2018 20:21:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>
Subject: [GIT PULL] dmaengine updates for v4.21-rc1
Message-ID: <20181231145136.GD7581@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Here is the last pull request for this year, lets see if it gets merged
this year or next one :D

Please pull to receive dmaengine updates for v4.21-rc1 which include  a
new driver, removes R-Mobile APE6 as it is no longer used, sprd cyclic
dma support, last batch of dma_slave_config direction removal and random
updates to bunch of drivers.

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-4.21-rc1

for you to fetch changes up to 660611827c03afeb0eec178dc1fb9f842332d908:

  Merge branch 'topic/xilinx' into for-linus (2018-12-31 19:32:32 +0530)

----------------------------------------------------------------
dmaengine-4.21-rc1

dmaengine updates for v4.21-rc1

 - New driver for UniPhier MIO DMA controller
 - Remove R-Mobile APE6 support
 - Sprd driver updates and support for cyclic link-list
 - Remove dma_slave_config direction usage from rest of drivers
 - Minor updates to dmatest, dw-dmac, zynqmp and bcm dma drivers

----------------------------------------------------------------
Alexandru Ardelean (3):
      dmaengine: dmatest: unmap data on a single code-path when xfer done
      dmaengine: dmatest: use dmaengine_terminate_sync() instead
      dmaengine: dmatest: move size checks earlier in function

Baolin Wang (1):
      dmaengine: sprd: Remove direction usage from struct dma_slave_config

Biju Das (2):
      dt-bindings: dmaengine: usb-dmac: Add binding for r8a77470
      dt-bindings: dmaengine: usb-dmac: Add binding for r8a774a1

Christian Lamparter (2):
      dt-bindings: dmaengine: dw-dmac: add protection control property
      dmaengine: dw-dmac: implement dma protection control setting

Dan Carpenter (1):
      dmaengine: dmatest: fix a small memory leak in dmatest_func()

Eric Long (6):
      dmaengine: sprd: Get transfer residue depending on the transfer direc=
tion
      dmaengine: sprd: Fix the last link-list configuration
      dmaengine: sprd: Set cur_desc as NULL when free or terminate one dma =
channel
      dmaengine: sprd: Support DMA link-list cyclic callback
      dmaengine: sprd: Support DMA 2-stage transfer mode
      dmaengine: sprd: Add me as one of the module authors

Fabio Estevam (1):
      dmaengine: imx-sdma: Use a single line for dma_alloc_coherent()

Fabrizio Castro (3):
      dmaengine: rcar-dmac: Document R8A774A1 bindings
      dt-bindings: dmaengine: usb-dmac: Add binding for r8a774c0
      dmaengine: rcar-dmac: Document R8A774C0 bindings

Geert Uytterhoeven (1):
      dmaengine: sh: Remove R-Mobile APE6 support

Jia-Ju Bai (1):
      dmaengine: coh901318: Fix a double-lock bug

Kuninori Morimoto (1):
      dmaengine: sh: convert to SPDX identifiers

Masahiro Yamada (2):
      dt-bindings: dmaengine: add DT binding for UniPhier MIO DMAC
      dmaengine: uniphier-mdmac: add UniPhier MIO DMAC driver

Michael Tretter (1):
      dmaengine: zynqmp_dma: replace spin_lock_bh with spin_lock_irqsave

Nathan Chancellor (1):
      dmaengine: xilinx_dma: Remove __aligned attribute on zynqmp_dma_desc_=
ll

Radhey Shyam Pandey (3):
      dmaengine: xilinx_dma: Refactor axidma channel allocation
      dmaengine: xilinx_dma: Introduce helper macro for preparing dma addre=
ss
      dmaengine: xilinx_dma: Fix 64-bit simple CDMA transfer

Russell King (1):
      dmaengine: sa11x0: unexport sa11x0_dma_filter_fn and clean up

Seraj Alijan (5):
      dmaengine: dmatest: Add support for multi channel testing
      dmaengine: dmatest: Use fixed point div to calculate iops
      dmaengine: dmatest: Add alignment parameter
      dmaengine: dmatest: Add transfer_size parameter
      dmaengine: Documentation: Add documentation for multi chan testing

Shun-Chih Yu (1):
      dmaengine: mediatek: Add MediaTek Command-Queue DMA controller for MT=
6765 SoC

Stefan Wahren (2):
      dmaengine: bcm2835: make license text and module license match
      dmaengine: bcm2835: Switch to SPDX identifier

Vinod Koul (18):
      dmaengine: mmp_pdma: remove dma_slave_config direction usage
      dmaengine: imx-sdma: remove dma_slave_config direction usage and leav=
e sdma_event_enable()
      dmaengine: pl330: remove dma_slave_config direction usage
      dmaengine: ste_dma40: remove dma_slave_config direction usage
      dmaengine: coh901318: Remove unused variable
      Merge branch 'topic/bcm' into for-linus
      Merge branch 'topic/coh' into for-linus
      Merge branch 'topic/dirn_remove' into for-linus
      Merge branch 'topic/dmatest' into for-linus
      Merge branch 'topic/dw' into for-linus
      Merge branch 'topic/ep93xx' into for-linus
      Merge branch 'topic/imx' into for-linus
      Merge branch 'topic/mtk' into for-linus
      Merge branch 'topic/sa11x0' into for-linus
      Merge branch 'topic/sh' into for-linus
      Merge branch 'topic/sprd' into for-linus
      Merge branch 'topic/uniphier' into for-linus
      Merge branch 'topic/xilinx' into for-linus

Yangtao Li (5):
      dmaengine: ep93xx: fix some typo
      dmaengine: amba-pl08x: convert to DEFINE_SHOW_ATTRIBUTE
      dmaengine: mic_x100_dma: convert to DEFINE_SHOW_ATTRIBUTE
      dmaengine: pxa: remove DBGFS_FUNC_DECL()
      dmaengine: qcom_hidma: convert to DEFINE_SHOW_ATTRIBUTE

 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |   4 +-
 .../devicetree/bindings/dma/renesas,usb-dmac.txt   |   3 +
 Documentation/devicetree/bindings/dma/snps-dma.txt |   4 +
 .../devicetree/bindings/dma/uniphier-mio-dmac.txt  |  25 +
 Documentation/driver-api/dmaengine/dmatest.rst     | 109 ++-
 MAINTAINERS                                        |   5 +-
 drivers/dma/Kconfig                                |  11 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/amba-pl08x.c                           |  14 +-
 drivers/dma/bcm2835-dma.c                          |  13 +-
 drivers/dma/coh901318.c                            |   5 -
 drivers/dma/dmatest.c                              | 299 +++++--
 drivers/dma/dw/core.c                              |   2 +
 drivers/dma/dw/platform.c                          |   6 +
 drivers/dma/dw/regs.h                              |   4 +
 drivers/dma/ep93xx_dma.c                           |   6 +-
 drivers/dma/imx-sdma.c                             |  60 +-
 drivers/dma/mediatek/Kconfig                       |  13 +
 drivers/dma/mediatek/Makefile                      |   1 +
 drivers/dma/mediatek/mtk-cqdma.c                   | 951 +++++++++++++++++=
++++
 drivers/dma/mic_x100_dma.c                         |  22 +-
 drivers/dma/mmp_pdma.c                             |  28 +-
 drivers/dma/pl330.c                                |  28 +-
 drivers/dma/pxa_dma.c                              |  36 +-
 drivers/dma/qcom/hidma_dbg.c                       |  33 +-
 drivers/dma/sa11x0-dma.c                           |  21 +-
 drivers/dma/sh/Kconfig                             |  12 +-
 drivers/dma/sh/Makefile                            |   1 -
 drivers/dma/sh/shdma-r8a73a4.c                     |  74 --
 drivers/dma/sh/shdma.h                             |   7 -
 drivers/dma/sh/shdmac.c                            |   7 -
 drivers/dma/sprd-dma.c                             | 152 +++-
 drivers/dma/ste_dma40.c                            |  31 +-
 drivers/dma/uniphier-mdmac.c                       | 506 +++++++++++
 drivers/dma/xilinx/xilinx_dma.c                    |  44 +-
 drivers/dma/xilinx/zynqmp_dma.c                    |  39 +-
 include/dt-bindings/dma/dw-dmac.h                  |  14 +
 include/linux/dma/sprd-dma.h                       |  62 +-
 include/linux/platform_data/dma-dw.h               |   6 +
 include/linux/sa11x0-dma.h                         |  24 -
 include/linux/shdma-base.h                         |   7 +-
 41 files changed, 2296 insertions(+), 394 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/uniphier-mio-dmac=
=2Etxt
 create mode 100644 drivers/dma/mediatek/mtk-cqdma.c
 delete mode 100644 drivers/dma/sh/shdma-r8a73a4.c
 create mode 100644 drivers/dma/uniphier-mdmac.c
 create mode 100644 include/dt-bindings/dma/dw-dmac.h
 delete mode 100644 include/linux/sa11x0-dma.h

--=20
~Vinod

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcKiz4AAoJEHwUBw8lI4NHwlsQAMf0NypHekvLa6KoHgo+7XFb
KjUurfEuRZHy/cGLeJf9pqOgmA2jp+Y//eMozlrvppeLqCuHapeqiEOkX+YIWymj
K3H1NR0Hwn+Vtn0K3ziPdnDaez8ZJB1466NjO83XaJnRqZlpWIErdHlnwDg1MO4y
ReJ/aurS1PNb/tZQRu3ACphP5vkj34Wp58marlAJyh/0lo6pVt4pV97rCYUVefo8
w98mtdV9wBjiXgT5sT2HFAHA98Eel+Ga6927f5lWRna/QqMzWPLhArH/TgQmRMOR
fu9gfyjR3PPjyHHGFBFkHtdYWmgcgcjzBK2axlqFS9yR6r9TOJTv50HVcSVGh6GL
pxQl6e66eAZl9boBHhV4uJSRRhAxwLkppo3ro3r1DMNG1SbsCNafiA2nATkj4Umi
cBSD7dcqjlRkoQU1Nsik0hw++EUq07va94hIO2C7P9u4mhLnOwUSdOLmnehM/kzN
JfdVQC+8uCgqVi1QXxObzOlilVvfb7owcwQeiVIIOeBKydHO+kGAr+K390xVdNL6
zQSjWgYKjwsVOtsE/euNebR+rH2gB+gnPQjn/vgc0IZCpVaukGfpHqM76L4voJng
ytqHUt0ME8NfPx1O5CUFhcg+F0nkzkhg3h1umrTGJ8tIAbm7rXqiZvAzHykenjF6
hCLhQUcAJDA3oz676iCT
=5SuO
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
