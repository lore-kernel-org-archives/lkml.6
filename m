Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754574AbeDJP3I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:29:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:7465 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754557AbeDJP3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:29:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,432,1517904000";
   d="asc'?scan'208";a="36054861"
Date: Tue, 10 Apr 2018 21:03:34 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dma <dmaengine@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v4.17-rc1
Message-ID: <20180410153333.GR6014@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Here is the pull request for dmaengine updates for v4.17-rc1. Two new
drivers, updates to couple and off updates to many summarise this request.
Details below:

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-4.17-rc1

for you to fetch changes up to 2ffb850e23a943acfbeda62599397c863cdd854c:

  Merge branch 'topic/stm' into for-linus (2018-04-10 08:55:58 +0530)

----------------------------------------------------------------
DMAengine updates for v4.17-rc1

This time we have couple of new drivers along with updates to drivers.

 - new driver for DesignWare AXI DMAC and MediaTek High-Speed DMA controller
 - stm32 dma and qcom bam dma driver updates
 - norandom test option for dmatest

----------------------------------------------------------------
Biju Das (1):
      dt-bindings: rcar-dmac: Document r8a77470 support

Colin Ian King (1):
      dmaengine: dw-axi-dmac: fix spelling mistake: "catched" -> "caught"

Eugeniy Paltsev (2):
      dmaengine: Introduce DW AXI DMAC driver
      dt-bindings: Document the Synopsys DW AXI DMA bindings

Geert Uytterhoeven (1):
      dmaengine: rcar-dmac: Fix too early/late system suspend/resume callba=
cks

Maxime Jayat (1):
      dmaengine: at_xdmac: fix rare residue corruption

Peter Ujfalusi (1):
      dmaengine: edma: Check the memory allocation for the memcpy dma device

Pierre Yves MORDRET (7):
      dmaengine: stm32-dma: threshold manages with bitfield feature
      dmaengine: stm32-dma: fix incomplete configuration in cyclic mode
      dmaengine: stm32-dma: fix typo and reported checkpatch warnings
      dmaengine: stm32-dma: Improve memory burst management
      dmaengine: stm32-dma: fix DMA IRQ status handling
      dmaengine: stm32-dma: fix max items per transfer
      dmaengine: stm32-dma: properly mask irq bits

Pierre-Yves MORDRET (1):
      dt-bindings: stm32-dma: introduce DMA features bitfield

Qi Hou (1):
      dmaengine: pl330: fix a race condition in case of threaded irqs

Sean Wang (3):
      dt-bindings: dmaengine: Add MediaTek High-Speed DMA controller bindin=
gs
      dmaengine: mediatek: Add MediaTek High-Speed DMA controller for MT762=
2 and MT7623 SoC
      dmaengine: mediatek: update MAINTAINERS entry with MediaTek DMA driver

Sergei Shtylyov (1):
      DT: dmaengine: renesas,rcar-dmac: document R8A77980 support

Srinivas Kandagatla (5):
      dmaengine: qcom: bam_dma: make bam clk optional
      dt-bindings: dmaengine: bam_dma: add remote controlled bindings
      dmaengine: qcom: bam_dma: get num-channels and num-ees from dt
      dmaengine: qcom: bam_dma: do not write to global regs in remote mode
      dmaengine: qcom: bam_dma: disable runtime pm on remote controlled

Thierry Bultel (1):
      dmaengine: imx-sdma: fix pagefault when channel is disabled during in=
terrupt

Vinod Koul (10):
      Merge branch 'topic/dmatest' into for-linus
      Merge branch 'topic/dw_axi' into for-linus
      Merge branch 'topic/edma' into for-linus
      Merge branch 'topic/imx' into for-linus
      Merge branch 'topic/mtek' into for-linus
      Merge branch 'topic/pl330' into for-linus
      Merge branch 'topic/qcom' into for-linus
      Merge branch 'topic/raid' into for-linus
      Merge branch 'topic/renesas' into for-linus
      Merge branch 'topic/stm' into for-linus

Yang Shunyong (1):
      dmaengine: dmatest: add norandom option

Yoshihiro Shimoda (2):
      dmaengine: usb-dmac: add binding for r8a77965
      dmaengine: rcar-dmac: Check the done lists in rcar_dmac_chan_get_resi=
due()

Zi Yan (1):
      dmaengine: avoid map_cnt overflow with CONFIG_DMA_ENGINE_RAID

 .../devicetree/bindings/dma/mtk-hsdma.txt          |   33 +
 .../devicetree/bindings/dma/qcom_bam_dma.txt       |    4 +
 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |    2 +
 .../devicetree/bindings/dma/renesas,usb-dmac.txt   |    1 +
 .../devicetree/bindings/dma/snps,dw-axi-dmac.txt   |   41 +
 .../devicetree/bindings/dma/stm32-dma.txt          |    6 +-
 MAINTAINERS                                        |   15 +
 drivers/dma/Kconfig                                |   12 +
 drivers/dma/Makefile                               |    2 +
 drivers/dma/at_xdmac.c                             |    4 +-
 drivers/dma/dmatest.c                              |   16 +-
 drivers/dma/dw-axi-dmac/Makefile                   |    1 +
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     | 1008 ++++++++++++++++=
+++
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h              |  334 +++++++
 drivers/dma/edma.c                                 |    6 +
 drivers/dma/imx-sdma.c                             |   21 +
 drivers/dma/mediatek/Kconfig                       |   13 +
 drivers/dma/mediatek/Makefile                      |    1 +
 drivers/dma/mediatek/mtk-hsdma.c                   | 1056 ++++++++++++++++=
++++
 drivers/dma/pl330.c                                |    6 +-
 drivers/dma/qcom/bam_dma.c                         |   59 +-
 drivers/dma/sh/rcar-dmac.c                         |   13 +-
 drivers/dma/stm32-dma.c                            |  287 +++++-
 include/linux/dmaengine.h                          |    4 +
 24 files changed, 2871 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/mtk-hsdma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.=
txt
 create mode 100644 drivers/dma/dw-axi-dmac/Makefile
 create mode 100644 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
 create mode 100644 drivers/dma/dw-axi-dmac/dw-axi-dmac.h
 create mode 100644 drivers/dma/mediatek/Kconfig
 create mode 100644 drivers/dma/mediatek/Makefile
 create mode 100644 drivers/dma/mediatek/mtk-hsdma.c

--=20
~Vinod

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJazNlNAAoJEHwUBw8lI4NHM2kP/jxxDjq6it3mpWNJHFQahRZU
+jb/bNn5J+uYMo1w4Ex4mAlybviFgiMRyeFIPVWLL+KSVPWXHgFC/SRKSQpvp4Xk
52o8gp0SC7IIve+ciItZJzS+D8aKnoDE6NuA5b0WWbpJ9Mua9JjXPHpg1VMT4N1E
K+rmoJ55CCGxJgBXUBJsIefe/RTnj9p3hHKGVFJTFgCQTEWaXVdTEuPrChwKWp+x
rHSFOGAVlq7BTM5/gvTl/KvrHTgAwIBNR/17yGG7k+xmUOoNPkwWiQS8+WrsDlSo
40jKfiDGBiM5qItNmMsaNKDszyjEyz8ahqus8IkYvb/5CdyDLs6NjTPEbjC6aYd1
eSynT2P1RE626dGQ4krKBCZpSF5K80CNWvPzP9UtZNyq4S+vfQVh3gv8NmGBW7nS
4biaIkeItcAmpDDBTjwntspszXvHl8l9d9sKUHaNI4wRV6S8qZr54RD6b/cN06Yj
HqXGRNUPhsbn+13sGgqtYgvDF8/Us3MHSC52XvpmoWpPbU3RGmgjYWy1DasCrzTE
JED1JWAvGEnaFZ6y8BuqPwJ1hXWt/hL+qzU1eAtmQ7z+Np++Bx8RCwFNSMl5rUbR
+VnGu8vMiaFZnULJKls2BhUotN/fFxEeT76I+OIxsWTe1FHYeBeTRTCVydPlfkML
6XcEcpsoSwD5CBUefqvH
=gc6o
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
