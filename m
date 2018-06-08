Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0ItjKeymGltcFQAAmS7hNA
	; Fri, 08 Jun 2018 15:55:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 80193607E4; Fri,  8 Jun 2018 15:55:24 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/uRSbUC"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D5B8E601B4;
	Fri,  8 Jun 2018 15:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5B8E601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeFHPzW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 11:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751141AbeFHPzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 11:55:20 -0400
Received: from localhost (unknown [171.76.126.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16B272086D;
        Fri,  8 Jun 2018 15:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528473320;
        bh=5d09zTkBVMACGxc2t4KUnmF0N0I5PPaZxl64myH6gnQ=;
        h=Date:From:To:Cc:Subject:From;
        b=W/uRSbUCPbgDUOppwPCMKaSNXENZR/Qg7QMW4KHB933hDSF2z1BSCY4/aVRZ4uBBP
         2cqz0wFGo8QWb8TcPLYbS0wndKIi43WxqznjCOkL4Z0wlArLnKxJI4AAphaqE9p07V
         IzggFC2+kt4yKPI+VoZVSfNOSsLJXx8/8msE7YOo=
Date: Fri, 8 Jun 2018 21:25:10 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v4.18-rc1
Message-ID: <20180608155510.GC2452@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Here is the request to PULL for v4.18-rc1 to receive updates to few
dmaengine drivers.

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-4.18-rc1

for you to fetch changes up to 67f31971e7c221c1aff7bc023a724ae284c01a14:

  Merge branch 'topic/txx' into for-linus (2018-06-04 10:29:22 +0530)

----------------------------------------------------------------
dmaengine updates for 4.18-rc1

 - Updates to sprd, bam_dma, stm drivers.
 - removal of VLAs in dmatest.
 - Move TI drivers its own subdir.
 - Switch to SPDX tags for ima/mxs dma drivers.
 - Simplify getting .drvdata on bunch of drivers by Wolfram Sang.

----------------------------------------------------------------
Baolin Wang (2):
      dmaengine: sprd: Define the DMA data width type
      dmaengine: sprd: Use devm_ioremap_resource() to map memory

Colin Ian King (1):
      dmaengine: stm32-mdma: fix spelling mistake: "avalaible" -> "availabl=
e"

Dan Carpenter (1):
      dmaengine: sprd: fix an NULL vs IS_ERR() bug

Eric Long (4):
      dmaengine: sprd: Define the DMA transfer step type
      dmaengine: sprd: Move DMA request mode and interrupt type into head f=
ile
      dmaengine: sprd: Optimize the sprd_dma_prep_dma_memcpy()
      dmaengine: sprd: Add Spreadtrum DMA configuration

Fabio Estevam (3):
      dmaengine: imx-sdma: Switch to SPDX identifier
      dmaengine: mxs-dma: Switch to SPDX identifier
      dmaengine: imx-dma: Switch to SPDX identifier

Frank Mori Hess (1):
      dmaengine: pl330: flush before wait, and add dev burst support.

Geert Uytterhoeven (1):
      dmaengine: shdmac: Change platform check to CONFIG_ARCH_RENESAS

Hiroyuki Yokoyama (1):
      dmaengine: usb-dmac: Document R8A7799{0,5} bindings

Laura Abbott (1):
      dmaengine: dmatest: Remove use of VLAs

Moritz Fischer (1):
      dmaengine: axi-dmac: Request IRQ with IRQF_SHARED

Peter Ujfalusi (1):
      dmaengine: ti: New directory for Texas Instruments DMA drivers

Pierre-Yves MORDRET (2):
      dmaengine: stm32-mdma: align TLEN and buffer length on burst
      dmaengine: stm32-mdma: Fix incomplete Hw descriptors allocator

Sinan Kaya (1):
      MAINTAINERS: add maintainer for Qualcomm HIDMA drivers

Srinivas Kandagatla (2):
      dmaengine: qcom: bam_dma: fix invalid assignment warning
      dmaengine: qcom: bam_dma: fix some doc warnings.

Ulrich Hecht (1):
      dmaengine: rcar-dmac: Document R-Car D3 bindings

Vinod Koul (17):
      dmaengine: Update email address for Vinod
      Merge branch 'topic/at' into for-linus
      Merge branch 'topic/axi' into for-linus
      Merge branch 'topic/bam' into for-linus
      Merge branch 'topic/dmatest' into for-linus
      Merge branch 'topic/dw' into for-linus
      Merge branch 'topic/fsl' into for-linus
      Merge branch 'topic/idma' into for-linus
      Merge branch 'topic/imx' into for-linus
      Merge branch 'topic/pl330' into for-linus
      Merge branch 'topic/qcom' into for-linus
      Merge branch 'topic/renesas' into for-linus
      Merge branch 'topic/sprd' into for-linus
      Merge branch 'topic/ste' into for-linus
      Merge branch 'topic/stm' into for-linus
      Merge branch 'topic/ti' into for-linus
      Merge branch 'topic/txx' into for-linus

Wei Yongjun (1):
      dmaengine: sprd: Fix potential NULL dereference in sprd_dma_probe()

Wolfram Sang (8):
      dmaengine: qcom: simplify getting .drvdata
      dmaengine: dw: simplify getting .drvdata
      dmaengine: at_hdmac: simplify getting .drvdata
      dmaengine: at_xdmac: simplify getting .drvdata
      dmaengine: fsldma: simplify getting .drvdata
      dmaengine: idma64: simplify getting .drvdata
      dmaengine: ste_dma40: simplify getting .drvdata
      dmaengine: txx9dmac: simplify getting .drvdata

 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |   1 +
 .../devicetree/bindings/dma/renesas,usb-dmac.txt   |   2 +
 MAINTAINERS                                        |  10 +-
 drivers/dma/Kconfig                                |  31 +-
 drivers/dma/Makefile                               |   5 +-
 drivers/dma/at_hdmac.c                             |   9 +-
 drivers/dma/at_xdmac.c                             |   9 +-
 drivers/dma/dma-axi-dmac.c                         |   2 +-
 drivers/dma/dmatest.c                              |  16 +-
 drivers/dma/dw/platform.c                          |   6 +-
 drivers/dma/fsldma.c                               |   6 +-
 drivers/dma/idma64.c                               |   6 +-
 drivers/dma/imx-dma.c                              |  26 +-
 drivers/dma/imx-sdma.c                             |  29 +-
 drivers/dma/mxs-dma.c                              |  14 +-
 drivers/dma/pl330.c                                | 209 +++++++++---
 drivers/dma/qcom/bam_dma.c                         |  10 +-
 drivers/dma/qcom/hidma.c                           |   3 +-
 drivers/dma/qcom/hidma_mgmt_sys.c                  |   6 +-
 drivers/dma/sh/shdmac.c                            |  50 ++-
 drivers/dma/sprd-dma.c                             | 349 ++++++++++++-----=
----
 drivers/dma/ste_dma40.c                            |  12 +-
 drivers/dma/stm32-mdma.c                           | 100 +++---
 drivers/dma/ti/Kconfig                             |  37 +++
 drivers/dma/ti/Makefile                            |   5 +
 drivers/dma/{ =3D> ti}/cppi41.c                      |   2 +-
 .../dma/{ti-dma-crossbar.c =3D> ti/dma-crossbar.c}   |   0
 drivers/dma/{ =3D> ti}/edma.c                        |   4 +-
 drivers/dma/{ =3D> ti}/omap-dma.c                    |   2 +-
 drivers/dma/txx9dmac.c                             |   8 +-
 include/linux/dma/sprd-dma.h                       |  61 ++++
 31 files changed, 632 insertions(+), 398 deletions(-)
 create mode 100644 drivers/dma/ti/Kconfig
 create mode 100644 drivers/dma/ti/Makefile
 rename drivers/dma/{ =3D> ti}/cppi41.c (99%)
 rename drivers/dma/{ti-dma-crossbar.c =3D> ti/dma-crossbar.c} (100%)
 rename drivers/dma/{ =3D> ti}/edma.c (99%)
 rename drivers/dma/{ =3D> ti}/omap-dma.c (99%)
 create mode 100644 include/linux/dma/sprd-dma.h


--=20
~Vinod

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbGqbeAAoJEHwUBw8lI4NHO44QALf5UaKJw1k7KYxAPOIYrA0+
r2EWXJ+7mUcAk71Hpd41YjDXaK6C+LwMrfs/SVE1aXYwx1BPnMzwa/TkPKMP2f3M
UVhmWujEkS+ajCMMjfUvydRPGcZopwQIfjydhBDCZB5VQDg4kNN/Tv33Npoe7ZNt
7iZqFHxqznhMODikDJAivZuYQCBgewHYUtN+kiVI6ef3ExwdMCsQT0WksMIPvV70
dT6DX9m2a23oibaseDIr69C+MYHArLpcc2/s2fhuwiQ7/FtWFFaBpwErbIy2U27m
VVqRvHBNgiSMVuw8NLaTDNtw5Sf6YpRk8w35tUEEhl3/3KaoXV+E65JRt2KB3gwG
PJORxAio1o88LtTNIcZUbqYlmz1fSbRIaZrLWfFhL50Oxks495Hu0qSFxrEeobU0
APx5EglEZLcJk1u9BL7wSVCiHKmAFgW3ZTxNf6xPiD+dNHapkKFIC2qX6oddF90m
L38HttkKuLdLoNZmPh2+spnc5oKU/Sz25GWzfpruHKngbvoy0lewEfrc6iWsSclX
H06Gpc4Km5eQUt84OLrXoVDhEHevg1+wa70EIFSkYFxUTgj2lH9YAhFA70+HtZXU
b6wr5GuOqSwHzXYEMbvlUxNJ0Q7ZlCBwyihnl2V31xRc+U1cpNovk85mJJMipOUe
CInzfmq8TI5Dgv4w7QyP
=LiL9
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
