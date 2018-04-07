Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeDGPKK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 11:10:10 -0400
Received: from sauhun.de ([88.99.104.3]:35760 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751895AbeDGPKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 11:10:08 -0400
Date: Sat, 7 Apr 2018 17:10:05 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 4.17
Message-ID: <20180407151002.z3nojsa3wdae4qfb@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w23qhgyiybnmb6p3"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w23qhgyiybnmb6p3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is the I2C pull request with the following main points:

* I2C core now reports proper OF style module alias. I'd like to repeat
  the note from the commit msg here (Thanks, Javier!):
===
NOTE: This patch may break out-of-tree drivers that were relying on this
      behavior, and only had an I2C device ID table even when the device
      was registered via OF. There are no remaining drivers in mainline
      that do this, but out-of-tree drivers have to be fixed and define
      a proper OF device ID table to have module auto-loading working.
===
* new driver for the SynQuacer I2C controller
* major refactoring of the QUP driver
* the piix4 driver now uses request_muxed_region which should fix a long
  standing resource conflict with the sp5100_tco watchdog
* a bunch of small core & driver improvements

The patch touching sh-architecture doesn't have an ack, we tried for months to
reach the maintainers. As I didn't want to block this improvement any further
and the change is small, I applied it. I am still open for any discussion about
it.

Please pull.

Thanks,

   Wolfram


The following changes since commit c698ca5278934c0ae32297a8725ced2e27585d7f:

  Linux 4.16-rc6 (2018-03-18 17:48:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-4.17

for you to fetch changes up to 0d676a6c439028b046610f7593f4ddb62680f1fb:

  i2c: add support for Socionext SynQuacer I2C controller (2018-04-04 20:33:03 +0200)

----------------------------------------------------------------
Abhishek Sahu (13):
      i2c: qup: fix copyrights and update to SPDX identifier
      i2c: qup: fixed releasing dma without flush operation completion
      i2c: qup: minor code reorganization for use_dma
      i2c: qup: remove redundant variables for BAM SG count
      i2c: qup: schedule EOT and FLUSH tags at the end of transfer
      i2c: qup: fix the transfer length for BAM RX EOT FLUSH tags
      i2c: qup: proper error handling for i2c error in BAM mode
      i2c: qup: use the complete transfer length to choose DMA mode
      i2c: qup: change completion timeout according to transfer length
      i2c: qup: fix buffer overflow for multiple msg of maximum xfer len
      i2c: qup: send NACK for last read sub transfers
      i2c: qup: reorganization of driver code to remove polling for qup v1
      i2c: qup: reorganization of driver code to remove polling for qup v2

Ahbong Chang (1):
      i2c: fix parameter of trace_i2c_result

Alexander Monakov (1):
      i2c: designware: suppress unneeded SDA hold time warnings

Andrzej Hajda (1):
      i2c: exynos5: rework HSI2C_MASTER_ST_LOSE state handling

Ard Biesheuvel (2):
      dt-bindings: i2c: add binding for Socionext SynQuacer I2C
      i2c: add support for Socionext SynQuacer I2C controller

Chris Packham (4):
      sh: sh7785lcr: add GPIO lookup table for i2c controller reset
      i2c: pca-platform: unconditionally use devm_gpiod_get_optional
      i2c: pca-platform: use device_property_read_u32
      i2c: pca-platform: drop gpio from platform data

Colin Ian King (1):
      i2c-stm32f4: remove redundant initialization of pointer reg

Davidlohr Bueso (1):
      i2c: Update i2c_trace_msg static key to modern api

Dmitry Bazhenov (1):
      i2c: xlp9xx: return ENXIO on slave address NACK

Geert Uytterhoeven (2):
      dt-bindings: i2c: sh_mobile: Document R-Car M3-N support
      dt-bindings: at24: add Renesas R1EX24128

George Cherian (3):
      i2c: xlp9xx: Handle transactions with I2C_M_RECV_LEN properly
      i2c: xlp9xx: Check for Bus state before every transfer
      i2c: xlp9xx: Handle NACK on DATA properly

Gregory CLEMENT (2):
      i2c: mv64xxx: Apply errata delay only in standard mode
      MAINTAINERS: i2c-mv64xxx: update email address for Gregory CLEMENT

Guenter Roeck (2):
      i2c: piix4: Use usleep_range()
      i2c: piix4: Use request_muxed_region

Hiromitsu Yamasaki (1):
      i2c: rcar: fix mask value of prohibited bit

Javier Martinez Canillas (1):
      i2c: core: report OF style module alias for devices registered via OF

Jean Delvare (1):
      i2c: scmi: Use standard device message logging functions

Lucas Stach (2):
      i2c: imx: use clk notifier for rate changes
      i2c: imx: avoid taking clk_prepare mutex in PM callbacks

Moritz Fischer (1):
      i2c: xiic: Make suspend function names consistent

Peter Rosin (3):
      i2c: add i2c_get_device_id() to get the standard i2c device id
      i2c: mux: pca954x: verify the device id of the pca984x chips
      dt-bindings: at24: add compatible for nxp,se97b

Ulrich Hecht (2):
      dt-bindings: i2c: document R8A77995 bindings
      dt-bindings: at24: add bindings for Rohm BR24T01

Wolfram Sang (10):
      i2c: of: change log level of failed device creation
      i2c: of: make ref counting more visible
      i2c: of: rename variable to meet expectations
      i2c: of: remove duplicated check for valid address
      i2c: of: simplify reading the "reg" property
      i2c: reformat comments around i2c_smbus_xfer_emulated()
      Merge branch 'i2c-mux/for-next' of https://github.com/peda-r/i2c-mux into i2c/for-4.17
      Merge tag 'at24-4.17-updates-for-wolfram' of git://git.kernel.org/.../brgl/linux into i2c/for-4.17
      dt-bindings: i2c: document R8A77965 bindings
      i2c: make i2c_check_addr_validity() static


with much appreciated quality assurance from
----------------------------------------------------------------
Adrian Fiergolski (2):
      (Test) i2c: mux: pca954x: verify the device id of the pca984x chips
      (Test) i2c: add i2c_get_device_id() to get the standard i2c device id

Andy Gross (8):
      (Rev.) i2c: qup: send NACK for last read sub transfers
      (Rev.) i2c: qup: fix buffer overflow for multiple msg of maximum xfer len
      (Rev.) i2c: qup: change completion timeout according to transfer length
      (Rev.) i2c: qup: use the complete transfer length to choose DMA mode
      (Rev.) i2c: qup: fix the transfer length for BAM RX EOT FLUSH tags
      (Rev.) i2c: qup: remove redundant variables for BAM SG count
      (Rev.) i2c: qup: minor code reorganization for use_dma
      (Rev.) i2c: qup: fixed releasing dma without flush operation completion

Andy Shevchenko (1):
      (Rev.) i2c: add support for Socionext SynQuacer I2C controller

Austin Christ (6):
      (Rev.) i2c: qup: send NACK for last read sub transfers
      (Rev.) i2c: qup: use the complete transfer length to choose DMA mode
      (Rev.) i2c: qup: proper error handling for i2c error in BAM mode
      (Rev.) i2c: qup: remove redundant variables for BAM SG count
      (Rev.) i2c: qup: minor code reorganization for use_dma
      (Rev.) i2c: qup: fixed releasing dma without flush operation completion

David Howells (2):
      (Rev.) i2c: Update i2c_trace_msg static key to modern api
      (Rev.) i2c: fix parameter of trace_i2c_result

Dmitry Mastykin (1):
      (Test) i2c: core: report OF style module alias for devices registered via OF

Geert Uytterhoeven (3):
      (Rev.) dt-bindings: i2c: document R8A77965 bindings
      (Rev.) dt-bindings: at24: add bindings for Rohm BR24T01
      (Rev.) dt-bindings: i2c: document R8A77995 bindings

Jan Glauber (2):
      (Rev.) i2c: xlp9xx: Handle NACK on DATA properly
      (Rev.) i2c: xlp9xx: Check for Bus state before every transfer

Jean Delvare (2):
      (Rev.) i2c: piix4: Use request_muxed_region
      (Rev.) i2c: piix4: Use usleep_range()

Peter Rosin (1):
      (Rev.) i2c: reformat comments around i2c_smbus_xfer_emulated()

Philipp Zabel (2):
      (Rev.) i2c: imx: avoid taking clk_prepare mutex in PM callbacks
      (Rev.) i2c: imx: use clk notifier for rate changes

Rafael J. Wysocki (1):
      (Rev.) i2c: scmi: Use standard device message logging functions

Rob Herring (4):
      (Rev.) dt-bindings: i2c: add binding for Socionext SynQuacer I2C
      (Rev.) dt-bindings: at24: add bindings for Rohm BR24T01
      (Rev.) dt-bindings: at24: add compatible for nxp,se97b
      (Rev.) dt-bindings: i2c: document R8A77995 bindings

Simon Horman (2):
      (Rev.) dt-bindings: i2c: sh_mobile: Document R-Car M3-N support
      (Rev.) dt-bindings: i2c: document R8A77995 bindings

Sricharan R (4):
      (Rev.) i2c: qup: reorganization of driver code to remove polling for qup v2
      (Rev.) i2c: qup: reorganization of driver code to remove polling for qup v1
      (Rev.) i2c: qup: proper error handling for i2c error in BAM mode
      (Rev.) i2c: qup: schedule EOT and FLUSH tags at the end of transfer

Todd Poynor (1):
      (Rev.) i2c: fix parameter of trace_i2c_result

Wolfram Sang (2):
      (Rev.) dt-bindings: at24: add bindings for Rohm BR24T01
      (Rev.) i2c: add i2c_get_device_id() to get the standard i2c device id

dann frazier (2):
      (Test) i2c: xlp9xx: Handle transactions with I2C_M_RECV_LEN properly
      (Test) i2c: xlp9xx: return ENXIO on slave address NACK

 Documentation/devicetree/bindings/eeprom/at24.txt  |    4 +
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |    2 +
 .../devicetree/bindings/i2c/i2c-sh_mobile.txt      |    1 +
 .../devicetree/bindings/i2c/i2c-synquacer.txt      |   29 +
 MAINTAINERS                                        |    9 +-
 arch/blackfin/mach-bf561/boards/acvilon.c          |    1 -
 arch/sh/boards/board-sh7785lcr.c                   |   11 +-
 drivers/i2c/busses/Kconfig                         |   10 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-designware-master.c         |    2 +-
 drivers/i2c/busses/i2c-exynos5.c                   |   63 +-
 drivers/i2c/busses/i2c-imx.c                       |   36 +-
 drivers/i2c/busses/i2c-mv64xxx.c                   |    8 +-
 drivers/i2c/busses/i2c-pca-platform.c              |   34 +-
 drivers/i2c/busses/i2c-piix4.c                     |   61 +-
 drivers/i2c/busses/i2c-qup.c                       | 1481 ++++++++++++--------
 drivers/i2c/busses/i2c-rcar.c                      |    4 +-
 drivers/i2c/busses/i2c-scmi.c                      |   35 +-
 drivers/i2c/busses/i2c-stm32f4.c                   |    2 +-
 drivers/i2c/busses/i2c-synquacer.c                 |  667 +++++++++
 drivers/i2c/busses/i2c-xiic.c                      |    8 +-
 drivers/i2c/busses/i2c-xlp9xx.c                    |   78 +-
 drivers/i2c/i2c-core-base.c                        |   58 +-
 drivers/i2c/i2c-core-of.c                          |   30 +-
 drivers/i2c/i2c-core-smbus.c                       |   16 +-
 drivers/i2c/i2c-core.h                             |    1 -
 drivers/i2c/muxes/i2c-mux-pca954x.c                |   55 +-
 include/linux/i2c-pca-platform.h                   |    3 -
 include/linux/i2c.h                                |   30 +
 29 files changed, 1969 insertions(+), 771 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
 create mode 100644 drivers/i2c/busses/i2c-synquacer.c

--w23qhgyiybnmb6p3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrI30YACgkQFA3kzBSg
KbYTDA//QNngD5sIRsiz0/imymCjly2PAfoDR3tOQuuqrV9iVshLbO8s6tNLxkAf
6mAKG7GYmWW9weBEBSWN9q6uimhwlK1jj/W0HYY3/AXlSYR2e1b01tORdg6aD+Kj
bH0tIu4Mgnka3Rlz5GD/lDaFDCnwM2p2/qbAY2nYX6AKusnNv82HKCRPps5g8V96
Awzh/YrktSz79KrYNO5Eqj1QKwg63gYpu0mLRm/c1WGGp91z5+XgqeIboc3gEWRC
HVpDmOIx9O3uABCm/AfcNstICHHep/FafGrePgvEI0Aejujrw4L/kZ0LCU7jlXLY
gQjIlfF8Q8U5peFYOSBM6nVN3Jtkb6yKetukSx75ChRXGI/NMpluPy7BOwxgHUVt
h7O8Gs/xuWa0X15ebRJw1O/g/0GRyVAH1UxSxp8uFJpTzUasIk64PZgiNrQzzcla
d8NgL23jwuEyM7agmQRycbi9K/p5ugpKIlA03ljmH9zk8xFik4VnSK+aQIThMa4t
qwRzeZ3+CrPy7aZlGMXwCEM/QOF+FGeV8Uwq5yPklOsiDDYbXrSZoJfAZyZg9GiV
J4KNmM54BJIG1NWMt4RjCJY/i2ZdEfRVOfYvoN8sh8V5vMYdlGk8rNoDwZ7NBMGs
zq6m5N0gSlhMmsUQt/OPhE4f7B8Z8OlgqEsrYF4C56Xay1S7C4Y=
=hDA/
-----END PGP SIGNATURE-----

--w23qhgyiybnmb6p3--
