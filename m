Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeFDLB2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:01:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52698 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752388AbeFDLB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:01:26 -0400
Date: Mon, 4 Jun 2018 12:01:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] spi updates for v4.18
Message-ID: <20180604110124.GE7536@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9crTWz/Z+Zyzu20v"
Content-Disposition: inline
X-Cookie: One Bell System - it works.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9crTWz/Z+Zyzu20v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit bc519d9574618e47a0c788000fb78da95e18d953:

  spi: bcm2835aux: ensure interrupts are enabled for shared handler (2018-0=
5-04 08:09:02 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-=
v4.18

for you to fetch changes up to 16c10b3bf84df5564683c704039f6199b8359b16:

  Merge branch 'spi-4.17' into spi-4.18 for the merge window (2018-06-04 11=
:51:12 +0100)

----------------------------------------------------------------
spi: Updates for v4.18

Quite a busy release for SPI, mainly as a result of Boris Brezillon's
work on improving the integration with MTD for accelerated SPI flash
controllers.  He's added a new spi_mem interface which works a lot
better with general hardware and converted the users over to it, as a
result of this work we've got some MTD changes in here as well.

Other highlights include:

 - Lots of spring cleaning for the s3c64xx driver.
 - Removal of the bcm53xx, the hardware is also supported by the mspi
   driver but SoC naming had caused people to miss the duplication.
 - Conversion of the pxa2xx driver to use the standard message
   processing loop rather than open coding.
 - A bunch of improvements to the runtime PM of the OMAP McSPI driver.

----------------------------------------------------------------
Alexey Khoroshilov (2):
      spi: stm32: Fix error handling in stm32_spi_probe()
      spi: meson-spicc: Fix error handling in meson_spicc_probe()

Andy Shevchenko (1):
      spi: pxa2xx: Allow 64-bit DMA

Arvind Yadav (1):
      spi: mpc52xx: Use gpio_is_valid()

Boris Brezillon (12):
      spi: Expose spi_{map,unmap}_buf() for internal use
      spi: Add an helper to flush the message queue
      spi: Check presence the of ->transfer[_xxx]() before registering a co=
ntroller
      spi: Extend the core to ease integration of SPI memory controllers
      spi: Make support for regular transfers optional when ->mem_ops !=3D =
NULL
      spi: bcm-qspi: Implement the spi_mem interface
      spi: ti-qspi: Implement the spi_mem interface
      mtd: spi-nor: Use the spi_mem_xx() API
      spi: Get rid of the spi_flash_read() API
      spi: bcm-qspi: Fix build failure caused by spi_flash_read() API remov=
al
      spi: ti-qspi: Make sure res_mmap !=3D NULL before dereferencing it
      mtd: devices: m25p80: Use spi_mem_set_drvdata() instead of spi_set_dr=
vdata()

Fabio Estevam (4):
      spi: imx: Switch to SPDX identifier
      spi: mxs: Switch to SPDX identifier
      spi: lpspi: Switch to SPDX identifier
      spi: Fix typo on SPI_MEM help text

Geert Uytterhoeven (2):
      spi: Remove depends on HAS_DMA in case of platform dependency
      spi: sh-msiof: Fix setting SIRMDR1.SYNCAC to match SITMDR1.SYNCAC

Jarkko Nikula (3):
      spi: pxa2xx: Remove unused argument from pxa2xx_spi_dma_prepare()
      spi: pxa2xx: Remove pump_transfers string from dev_ prints
      spi: pxa2xx: Use core message processing loop

Krzysztof Kozlowski (1):
      spi: s3c64xx: samsung: Remove support for Exynos5440

Marek Szyprowski (1):
      spi: spi-s3c64xx: Fix system resume support

Mark Brown (1):
      Merge branch 'spi-4.17' into spi-4.18 for the merge window

Naga Sureshkumar Relli (1):
      spi: zynqmp: Add pm runtime support

Rafa=C5=82 Mi=C5=82ecki (2):
      spi: remove the older/duplicated bcm53xx driver
      spi: remove forgotten CONFIG_SPI_BCM53XX

Stefan Potyra (1):
      spi/bcm63xx-hspi: Enable the clock before calling clk_get_rate().

Sylwester Nawrocki (8):
      spi: spi-s3c64xx: Remove unused driver data structure tgl_spi field
      spi: spi-s3c64xx: Remove unused s3c64xx_spi_hwinit() function argument
      spi: spi-s3c64xx: Do not ignore timeout errors in polling I/O mode
      spi: spi-s3c64xx: Fix indentation in the register offset definitions
      spi: spi-s3c64xx: Drop unused enable_datapath() function argument
      spi: spi-s3c64xx: Add missing s3c64xx_ prefix to function names
      spi: spi-s3c64xx: Use local variable for FIFO length
      spi: spi-s3c64xx: Allow higher transfer lengths in polling IO mode

Tobias Jordan (1):
      spi: pxa2xx: check clk_prepare_enable() return value

Tony Lindgren (4):
      spi: omap2-mcspi: Restore context always in runtime_resume
      spi: omap2-mcspi: Idle hardware during suspend and resume
      spi: Add missing pm_runtime_put_noidle() after failed get
      spi: omap2-mcspi: Remove unnecessary pm_runtime_force_suspend()

Vladimir Zapolskiy (1):
      spi: sh-msiof: Simplify calculation of divisors for transfer rate

Wolfram Sang (1):
      spi: simplify getting .drvdata

kbuild test robot (1):
      spi: pxa2xx: pxa2xx_spi_transfer_one() can be static

 drivers/mtd/devices/Kconfig     |   1 +
 drivers/mtd/devices/m25p80.c    | 238 ++++++++---------------
 drivers/spi/Kconfig             |  27 +--
 drivers/spi/Makefile            |   2 +-
 drivers/spi/internals.h         |  43 +++++
 drivers/spi/spi-bcm-qspi.c      | 162 ++++++++--------
 drivers/spi/spi-bcm53xx.c       | 360 -----------------------------------
 drivers/spi/spi-bcm53xx.h       |  73 -------
 drivers/spi/spi-bcm63xx-hsspi.c |  25 ++-
 drivers/spi/spi-cadence.c       |   6 +-
 drivers/spi/spi-fsl-lpspi.c     |  21 +-
 drivers/spi/spi-imx.c           |  22 +--
 drivers/spi/spi-mem.c           | 410 ++++++++++++++++++++++++++++++++++++=
++++
 drivers/spi/spi-meson-spicc.c   |  11 +-
 drivers/spi/spi-mpc52xx.c       |   2 +-
 drivers/spi/spi-mxs.c           |  48 ++---
 drivers/spi/spi-omap2-mcspi.c   | 111 +++++------
 drivers/spi/spi-pxa2xx-dma.c    |  28 +--
 drivers/spi/spi-pxa2xx.c        | 257 +++++++++----------------
 drivers/spi/spi-pxa2xx.h        |  17 +-
 drivers/spi/spi-s3c64xx.c       | 160 +++++++++-------
 drivers/spi/spi-sh-msiof.c      |  73 +++----
 drivers/spi/spi-stm32.c         |   2 +-
 drivers/spi/spi-ti-qspi.c       |  87 +++++----
 drivers/spi/spi-zynqmp-gqspi.c  |  92 +++++++--
 drivers/spi/spi.c               | 145 +++++++-------
 include/linux/spi/spi-mem.h     | 249 ++++++++++++++++++++++++
 include/linux/spi/spi.h         |  60 +-----
 28 files changed, 1423 insertions(+), 1309 deletions(-)
 create mode 100644 drivers/spi/internals.h
 delete mode 100644 drivers/spi/spi-bcm53xx.c
 delete mode 100644 drivers/spi/spi-bcm53xx.h
 create mode 100644 drivers/spi/spi-mem.c
 create mode 100644 include/linux/spi/spi-mem.h

--9crTWz/Z+Zyzu20v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsVHAQACgkQJNaLcl1U
h9AcZwf+PB3k0+rL9ipOAoD/HCyuSnC5emJIh2D7VLzWmQhQFA7VyTEXLUttn7PW
TvlzQuRyVx5oXR/0lkXv5b4DARaxYenPcFB51oadwFoyPZyAk2yAZeI1t6H6Zcn+
+Tsl49qedNdwHK0McakAUPxYyOdRnkBHgAVC15ukWynX8wUyy7dMfNSBXvEeBz2R
429voEQ+2ylZKn2V5i6KhkIMyJPfQfMrlD2eoZY2TtVq3BGPBDSedTGGYC+zRn0q
ClSGw0U0j6lCX/KOhlu6A8kaMCTlFPvxYi2ByWKhl8bbiiCth9THkMeIhwCi1sId
rOwEnx+6qawwnolr6EFfc8/L6tkfWw==
=n3T0
-----END PGP SIGNATURE-----

--9crTWz/Z+Zyzu20v--
