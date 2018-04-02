Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753077AbeDBQ4G (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:56:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48100 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752878AbeDBQ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:56:02 -0400
Date: Mon, 2 Apr 2018 17:56:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] SPI updates for v4.17
Message-ID: <20180402165600.GW29239@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QCC2I/2CckNfI+Tr"
Content-Disposition: inline
X-Cookie: Serenity through viciousness.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QCC2I/2CckNfI+Tr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 0adb32858b0bddf4ada5f364a84ed60b196dbcda:

  Linux 4.16 (2018-04-01 14:20:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-=
v4.17

for you to fetch changes up to 0930437e8f9d1f513ca7f130a650b608358f8805:

  Merge remote-tracking branches 'spi/topic/sh-msiof', 'spi/topic/sprd' and=
 'spi/topic/tegra20-slink' into spi-next (2018-04-02 15:56:45 +0100)

----------------------------------------------------------------
spi: SPI updates for v4.17

A quiet release for SPI, some fixes and small updates for individual
drivers with one bigger change from Linus Walleij which coverts the
bitbanging SPI driver to use the GPIO descriptor API from Linus Walleij.
Since GPIO descriptors were used by platform data this means there's a
few changes in arch/ making relevant updates for a few platforms and one
misc driver that are affected.

----------------------------------------------------------------
Alexey Khoroshilov (1):
      spi: jcore: disable ref_clk after getting its rate

Andi Shyti (1):
      MAINTAINERS: update Andi's e-mail

Baolin Wang (2):
      spi: sprd: Simplify the transfer function
      spi: sprd: Add the support of restarting the system

Christophe Jaillet (1):
      spi: bcm-qspi: fIX some error handling paths

Eugen Hristev (1):
      spi: atmel: init FIFOs before spi enable

Geert Uytterhoeven (2):
      spi: sh-msiof: Use correct enum for DMA transfer direction
      spi: sh-msiof: Document R-Car M3-N support

Gustavo A. R. Silva (1):
      spi: tegra20-slink: use true and false for boolean values

Jan Kundr=E1t (3):
      spi: orion: Rework GPIO CS handling
      spi: orion: Make the error message greppable
      spi: orion: Prepare space for per-child options

Jarkko Nikula (5):
      spi: pxa2xx: Move SSP idle waiting to cs_deassert()
      spi: dw: Convert to generalized SPI controller API
      spi: pxa2xx: Convert to generalized SPI controller API
      spi: pxa2xx: Disable runtime PM if controller registration fails
      spi: Fix unregistration of controller with fixed SPI bus number

Linus Walleij (2):
      spi: spi-gpio: Rewrite to use GPIO descriptors
      spi: spi-gpio: Augment device tree bindings

Mark Brown (6):
      Merge remote-tracking branch 'spi/fix/dma' into spi-linus
      Merge remote-tracking branches 'spi/fix/atmel', 'spi/fix/pxa2xx' and =
'spi/fix/unregiser' into spi-linus
      Merge remote-tracking branch 'spi/topic/samsung' into spi-next
      Merge remote-tracking branches 'spi/topic/atmel', 'spi/topic/bcm-qspi=
', 'spi/topic/bcm2835aux', 'spi/topic/dw' and 'spi/topic/gpio' into spi-next
      Merge remote-tracking branches 'spi/topic/jcore', 'spi/topic/kconfig'=
, 'spi/topic/orion', 'spi/topic/pxa2xx' and 'spi/topic/rspi' into spi-next
      Merge remote-tracking branches 'spi/topic/sh-msiof', 'spi/topic/sprd'=
 and 'spi/topic/tegra20-slink' into spi-next

Maxime Chevallier (1):
      spi: Fix scatterlist elements size in spi_map_buf

Stefan Agner (2):
      spi: rspi: use correct enum for DMA transfer direction
      spi: spi-atmel: Use correct enum for DMA transfer direction

Trent Piepho (1):
      spi: bcm2835aux: Avoid 64-bit arithmetic in xfer len calc

Ulf Magnusson (1):
      spi: kconfig: Remove AVR32 dep. from SPI_ATMEL

 .mailmap                                           |   1 +
 Documentation/devicetree/bindings/spi/sh-msiof.txt |   1 +
 Documentation/devicetree/bindings/spi/spi-gpio.txt |  24 +-
 MAINTAINERS                                        |   2 +-
 arch/arm/mach-pxa/cm-x300.c                        |  21 +-
 arch/arm/mach-pxa/raumfeld.c                       |  26 +-
 arch/arm/mach-s3c24xx/mach-jive.c                  |  55 +++--
 arch/arm/mach-s3c24xx/mach-qt2410.c                |  26 +-
 arch/arm/mach-s3c64xx/mach-smartq.c                |  22 +-
 arch/mips/alchemy/devboards/db1000.c               |  24 +-
 arch/mips/jz4740/board-qi_lb60.c                   |  26 +-
 drivers/misc/eeprom/digsy_mtc_eeprom.c             |  29 ++-
 drivers/spi/Kconfig                                |   4 +-
 drivers/spi/spi-atmel.c                            |  16 +-
 drivers/spi/spi-bcm-qspi.c                         |   4 +-
 drivers/spi/spi-bcm2835aux.c                       |  18 +-
 drivers/spi/spi-dw-mid.c                           |   6 +-
 drivers/spi/spi-dw.c                               |  26 +-
 drivers/spi/spi-dw.h                               |   4 +-
 drivers/spi/spi-gpio.c                             | 270 +++++++----------=
----
 drivers/spi/spi-jcore.c                            |  11 +-
 drivers/spi/spi-orion.c                            |  65 ++++-
 drivers/spi/spi-pxa2xx-dma.c                       |   4 +-
 drivers/spi/spi-pxa2xx.c                           |  56 +++--
 drivers/spi/spi-pxa2xx.h                           |   2 +-
 drivers/spi/spi-rspi.c                             |   4 +-
 drivers/spi/spi-sh-msiof.c                         |   4 +-
 drivers/spi/spi-sprd-adi.c                         | 176 +++++++++++---
 drivers/spi/spi-tegra20-slink.c                    |   4 +-
 drivers/spi/spi.c                                  |  19 +-
 include/linux/spi/spi_gpio.h                       |  49 +---
 31 files changed, 580 insertions(+), 419 deletions(-)

--QCC2I/2CckNfI+Tr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrCYJ8ACgkQJNaLcl1U
h9DPGQf9FKYaTbOZhpP4oL1L8Rw5y+bxJ3y/+2lDS9CF7vAmOJZbfcBVtTxm+Brl
OS5go3DDC1dztcNjZ/Z5e4jnfKkH21xUF0E52PXwbKrJVMTIyr59LRgZjBJj6kXp
jRrLozZr/4ygS/W/l6f+gytWC6/zfqQAQxSNpFlkp5kLpY/bNTPpx0c5TgO7bOdg
0m3U+YkOjiaJjOPBt7LW9lN4j6Fu2IAO3ho2NhivbLF44c0nQI/zPo8IqTLxU7LK
wfQA5rcz2UlnODCSmJifAqDV9I3W6cdZR5skjoNwVns1XAcaGoD4ehILt6z+wWbJ
Tg5SBVYJyljXi4VqmjhE5rWv+fmBbw==
=yeId
-----END PGP SIGNATURE-----

--QCC2I/2CckNfI+Tr--
