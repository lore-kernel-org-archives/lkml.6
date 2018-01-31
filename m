Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932421AbeAaQre (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 11:47:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:2795 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753782AbeAaQr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 11:47:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,440,1511856000";
   d="asc'?scan'208";a="15909237"
Date: Wed, 31 Jan 2018 22:22:04 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dma <dmaengine@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for 4.16-rc1
Message-ID: <20180131165204.GY18649@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vv4Sf/kQfcwinyKX"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Here is the PULL request for v4.16-rc1. This time is smallish update with
updates mainly to drivers.

The following changes since commit 2610acf46b9ed528ec2cacd717bc9d354e452b73:

  dmaengine: fsl-edma: disable clks on all error paths (2017-12-15 09:53:04=
 +0530)

are available in the git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-4.16-rc1

for you to fetch changes up to 330542fc1c62e51952a9b5e71bb4bf83ad60bb92:

  Merge branch 'topic/xilinx' into for-linus (2018-01-31 13:51:32 +0530)

----------------------------------------------------------------
DMAengine updates for v4.16-rc1

This cycle we have small update for:
  - updates to xilinx and zynqmp dma controllers
  - update reside calculation for rcar controller
  - more RSTify fixes for documentation
  - Add support for race free transfer termination and updating
    for users for that
  - Support for new rev of hidma with addition new APIs to
    get device match data in ACPI/OF
  - Random updates to bunch of other drivers

----------------------------------------------------------------
Colin Ian King (1):
      dmaengine: timb_dma: fix spelling mistake: "Couldnt" -> "Couldn't"

Dmitry Osipenko (1):
      dmaengine: tegra-apb: Support non-flow controlled slave configuration

Gomonovych, Vasyl (1):
      dmaengine: cppi41: Fix channel queues array size check

Kedareswara rao Appana (14):
      dmaengine: zynqmp_dma: Add runtime pm support
      dmaengine: zynqmp_dma: Fix kernel doc-format
      dmaengine: zynqmp_dma: Fix warning variable 'val' set but not used
      dmaengine: zynqmp_dma: Fix issues with overflow interrupt
      dmaengine: zynqmp_dma: Fix race condition in the probe
      dmaengine: xilinx_dma: Check for channel idle state before submitting=
 dma descriptor
      dmaeninge: xilinx_dma: Fix bug in multiple frame stores scenario in v=
dma
      dmaengine: xilinx_dma: Fix race condition in the driver for multiple =
descriptor scenario
      dmaengine: xilinx_dma: Fix kernel doc warnings
      dmaengine: xilinx_dma: fix style issues from checkpatch
      dmaengine: xilinx_dma: Differentiate probe based on the ip type
      dmaengine: xilinx_dma: properly configure the SG mode bit in the driv=
er for cdma
      dmaengine: xilinx_dma: Fix warning variable prev set but not used
      dmaengine: xilinx_dma: Free BD consistent memory

Kuninori Morimoto (2):
      dmaengine: rcar-dmac: ensure CHCR DE bit is actually 0 after clearing
      dmaengine: rcar-dmac: use TCRB instead of TCR for residue

Luca Ceresoli (2):
      dmaengine: doc: fix bullet list formatting
      dmaengine: doc: format struct fields using monospace

Nicolas Chauvet (1):
      dmaengine: imx-sdma: Add MODULE_FIRMWARE

Peter Ujfalusi (10):
      dmaengine: virt-dma: Add helper to free/reuse a descriptor
      dmaengine: virt-dma: Support for race free transfer termination
      dmaengine: omap-dma: Use vchan_terminate_vdesc() instead of desc_free
      dmaengine: edma: Use vchan_terminate_vdesc() instead of desc_free
      dmaengine: bcm2835-dma: Use vchan_terminate_vdesc() instead of desc_f=
ree
      dmaengine: dma-jz4780: Use vchan_terminate_vdesc() instead of desc_fr=
ee
      dmaengine: amba-pl08x: Use vchan_terminate_vdesc() instead of desc_fr=
ee
      dmaengine: img-mdc-dma: Use vchan_terminate_vdesc() instead of desc_f=
ree
      dmaengine: k3dma: Use vchan_terminate_vdesc() instead of desc_free
      dmaengine: s3c24xx-dma: Use vchan_terminate_vdesc() instead of desc_f=
ree

Rob Herring (1):
      dmaengine: qcom_hidma: simplify DT resource parsing

Sinan Kaya (8):
      dmaengine: qcom_hidma: check pending interrupts
      ACPI / bus: Introduce acpi_get_match_data() function
      device property: Introduce a common API to fetch device match data
      OF: properties: Implement get_match_data() callback
      ACPI: properties: Implement get_match_data() callback
      Documentation: DT: qcom_hidma: Bump HW revision for the bugfixed HW
      dmaengine: qcom_hidma: Add support for the new revision
      dmaengine: qcom_hidma: Add identity register support

Vasyl Gomonovych (1):
      dmaengine: mic_x100_dma: Use PTR_ERR_OR_ZERO()

Vignesh R (1):
      dmaengine: ti-dma-crossbar: Fix event mapping for TPCC_EVT_MUX_60_63

Vinod Koul (18):
      Merge branch 'topic/device_changes' into topic/qcom
      dmaengine: xilinx_dma: Fix typos
      dmaengine: sprd: statify 'sprd_dma_prep_dma_memcpy'
      Merge branch 'topic/cppi' into for-linus
      Merge branch 'topic/device_changes' into for-linus
      Merge branch 'topic/doc' into for-linus
      Merge branch 'topic/imx' into for-linus
      Merge branch 'topic/mic' into for-linus
      Merge branch 'topic/qcom' into for-linus
      Merge branch 'topic/qcom_hidma' into for-linus
      Merge branch 'topic/rcar' into for-linus
      Merge branch 'topic/sprd' into for-linus
      Merge branch 'topic/stm' into for-linus
      Merge branch 'topic/tegra' into for-linus
      Merge branch 'topic/ti' into for-linus
      Merge branch 'topic/timb' into for-linus
      Merge branch 'topic/virt-dma' into for-linus
      Merge branch 'topic/xilinx' into for-linus

Wei Yongjun (1):
      dmaengine: stm32-dmamux: Remove unnecessary platform_get_resource() e=
rror check

Yang Shunyong (1):
      dmaengine: dmatest: fix container_of member in dmatest_callback

 .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |   4 +-
 Documentation/driver-api/dmaengine/provider.rst    |  38 ++-
 drivers/acpi/bus.c                                 |  18 ++
 drivers/acpi/property.c                            |   8 +
 drivers/base/property.c                            |   7 +
 drivers/dma/amba-pl08x.c                           |  11 +-
 drivers/dma/bcm2835-dma.c                          |  10 +-
 drivers/dma/cppi41.c                               |   2 +-
 drivers/dma/dma-jz4780.c                           |  10 +-
 drivers/dma/dmatest.c                              |   2 +-
 drivers/dma/edma.c                                 |   7 +-
 drivers/dma/img-mdc-dma.c                          |  17 +-
 drivers/dma/imx-sdma.c                             |   6 +
 drivers/dma/k3dma.c                                |  10 +-
 drivers/dma/mic_x100_dma.c                         |   4 +-
 drivers/dma/omap-dma.c                             |   2 +-
 drivers/dma/qcom/hidma.c                           |  41 ++-
 drivers/dma/qcom/hidma_ll.c                        |   9 +-
 drivers/dma/qcom/hidma_mgmt.c                      |  61 +----
 drivers/dma/s3c24xx-dma.c                          |  11 +-
 drivers/dma/sh/rcar-dmac.c                         |  44 ++-
 drivers/dma/sprd-dma.c                             |   2 +-
 drivers/dma/stm32-dmamux.c                         |   3 -
 drivers/dma/tegra20-apb-dma.c                      |  19 +-
 drivers/dma/ti-dma-crossbar.c                      |  10 +-
 drivers/dma/timb_dma.c                             |   2 +-
 drivers/dma/virt-dma.c                             |   5 +-
 drivers/dma/virt-dma.h                             |  44 +++
 drivers/dma/xilinx/xilinx_dma.c                    | 302 ++++++++++++-----=
----
 drivers/dma/xilinx/zynqmp_dma.c                    | 179 +++++++++---
 drivers/of/property.c                              |   8 +
 include/linux/acpi.h                               |   6 +
 include/linux/fwnode.h                             |   4 +
 include/linux/property.h                           |   2 +
 34 files changed, 609 insertions(+), 299 deletions(-)

Thanks
--=20
~Vinod

--vv4Sf/kQfcwinyKX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJacfQ0AAoJEHwUBw8lI4NHJfQP/2+OfvNlnx9KPEd6VMLFkxx6
WtQM5idbQvwM1k9pvIavJF3hNmhQzjBIbxPSZqg7aEhHT1vq7veEY6Q/2KyKIxFq
5ZPVXX6f+qWY6nwoeXf+rIq35awE4R+Aoyh/UosXDO+WFKqBoqydLDYiDvgo0VmJ
d49NKyPKqu2abK62eYxZWqOJIRh11+yUZC/kgVdpNkCg+fMbyGNMPGzJnWDyWR5s
BivN4TsPpTGi1OnLLWrly2EHuemOsUnHUYRtxFhkA1qMdtN7bLnnq3v4WzLHsS+6
I5RwjofkTwfvFdhDOF35FLKP6lE/fidc3JpIndXZnqBYjPr8sVcMSICEM0ywOOzf
QabJ7myvGRl+eGi9eDtL1yjPdRM4tD4htTS7f2T/RgEqr182/Xk/gaaxxi7WGQHr
zmCEnF+RHRqINnnX4XiuIWv3Ie4XYAITkFm87KRbDIQbx0eamQmg1INUwO5Bjcpq
dVZJ66qNahAiI+ZSS98gLOaRuvZzdboUFPwOteADUhoEPELeWEuXRV2A2TGyJdiN
x6Bn+vnzwL7eDHZHUyKiTGeGKs6UVyWPdjTxYLET2nJZqryc3p1lVvH8bWxRwxoe
401L5dOC2E5YLhG9kmf43Zk1jblEOmm/bzEWFhANWzt5IKUExWvWKN605QgF3CTB
jPP+TuJhs49PjMMtgfzS
=qe8e
-----END PGP SIGNATURE-----

--vv4Sf/kQfcwinyKX--
