Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754600AbeBCWaf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 17:30:35 -0500
Received: from sauhun.de ([88.99.104.3]:53472 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754297AbeBCWa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 17:30:27 -0500
Date: Sat, 3 Feb 2018 23:30:24 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 4.16
Message-ID: <20180203223020.s6iph2oe7uphoz3q@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q6dtc7g7obxwtgo3"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q6dtc7g7obxwtgo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has the following changes for you:

* new flag to mark DMA safe buffers in i2c_msg. Also, some
  infrastructure around it. And docs.
* huge refactoring of the at24 driver led by the new maintainer Bartosz
* update I2C bus recovery to send STOP after recovery
* conversion from gpio to gpiod for I2C bus recovery
* adding a fault-injector to the i2c-gpio driver
* lots of small driver improvements, and bigger ones to i2c-sh_mobile

There was a small merge conflict in MAINTAINERS in linux-next, but that
should be easy to fix.

Please pull.

Thanks,

   Wolfram


The following changes since commit 30a7acd573899fd8b8ac39236eff6468b195ac7d:

  Linux 4.15-rc6 (2017-12-31 14:47:43 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-4.16

for you to fetch changes up to e38c85644e11c6dc5a39305c96b617f63403423d:

  i2c: mv64xxx: Add myself as maintainer for this driver (2018-01-26 18:51:29 +0100)

----------------------------------------------------------------
Adrian Fiergolski (1):
      i2c: mux: pca954x: add support for NXP PCA984x family

Andrzej Hajda (1):
      i2c: exynos5: change internal transmission timeout to 100ms

Andy Shevchenko (1):
      i2c: ismt: Use %pad specifier for dma_addr_t variables

Arnd Bergmann (1):
      i2c: acorn: add MODULE_LICENSE tag

Arseny Solokha (4):
      i2c: mpc: get MPC8xxx I2C clock prescaler before using it in calculations
      i2c: mpc: unify obtaining the MPC8533/44 I2C clock prescaler w/ MPC8xxx
      i2c: mpc: fix PORDEVSR2 mask for MPC8533/44
      i2c: mpc: always determine I2C clock prescaler at runtime

Bartosz Golaszewski (12):
      MAINTAINERS: add git URL for at24
      eeprom: at24: fix coding style issues
      eeprom: at24: use a common prefix for all symbols in at24.c
      eeprom: at24: code shrink
      dt-bindings: at24: new optional property - wp-gpios
      eeprom: at24: add support for the write-protect pin
      eeprom: at24: fix a whitespace error in platform data
      dt-bindings: at24: consistently document the compatible property
      dt-bindings: at24: fix formatting and style
      dt-bindings: at24: extend the list of supported chips
      eeprom: at24: extend the list of chips supported in DT
      i2c: davinci: fix the cpufreq transition

Fugang Duan (1):
      i2c: imx-lpi2c: add runtime pm support

Gregory CLEMENT (3):
      i2c: mv64xxx: Remove useless test before clk_disable_unprepare
      i2c: mv64xxx: Fix clock resource by adding an optional bus clock
      i2c: mv64xxx: Add myself as maintainer for this driver

Gustavo A. R. Silva (1):
      i2c: mxs: use true and false for boolean values

Heiner Kallweit (7):
      eeprom: at24: add basic regmap_i2c support
      eeprom: at24: change at24_translate_offset return type
      eeprom: at24: add regmap-based write function
      eeprom: at24: remove old write functions
      eeprom: at24: add regmap-based read function
      eeprom: at24: remove old read functions
      eeprom: at24: remove now unneeded smbus-related code

Jan Kundr??t (1):
      i2c: gpio: Enable working over slow can_sleep GPIOs

Jarkko Nikula (1):
      i2c: designware: Don't set SCL timings and speed mode when in slave mode

Jian Hu (2):
      dt-bindings: i2c: update documentation for the Meson-AXG
      i2c: meson: add configurable divider factors

Julia Lawall (1):
      i2c: rk3x: account for const type of of_device_id.data

Jun Gao (3):
      dt-bindings: i2c: Add MediaTek MT2712 i2c binding
      i2c: mediatek: Add i2c compatible for MediaTek MT2712
      i2c: mediatek: Enable i2c module clock before i2c registers access.

Linus Walleij (2):
      i2c: imx: Include the right GPIO header
      i2c/ARM: davinci: Deep refactoring of I2C recovery

Phil Reid (8):
      i2c: Switch to using gpiod interface for gpio bus recovery
      i2c: designware: move i2c_dw_plat_prepare_clk to common
      i2c: designware: rename i2c_dw_plat_prepare_clk to i2c_dw_prepare_clk
      i2c: imx: switch to using gpiod for bus recovery gpios
      i2c: davinci: switch to using gpiod for bus recovery gpios
      i2c: remove legacy integer scl/sda gpio for recovery
      i2c: core: fix compile issue related to incorrect gpio header
      i2c: designware: fix building driver as module

Radu Rendec (2):
      i2c: ismt: dump registers at the end of transactions
      i2c: ismt: 16-byte align the DMA buffer address

Stefan Lengfeld (1):
      i2c: use macro IS_ENABLED in header i2c.h

Sven Van Asbroeck (4):
      dt-bindings: add eeprom "no-read-rollover" property
      eeprom: at24: support eeproms that do not auto-rollover reads
      eeprom: at24: convert magic numbers to structs
      eeprom: at24: remove temporary fix for at24mac402 size

Tim Sander (1):
      i2c: designware: add i2c gpio recovery option

Tomasz Bachorski (1):
      i2c: mux: reg: don't log an error for probe deferral

Wolfram Sang (41):
      i2c: sh_mobile: remove redundant initialization
      i2c: sh_mobile: remove redundant deinitialization
      i2c: sh_mobile: manually "inline" two short functions
      i2c: sh_mobile: use direct writes when accessing ICE bit
      i2c: sh_mobile: shorten exit of xfer routine
      i2c: sh_mobile: let RuntimePM do the clock handling
      i2c: sh_mobile: avoid unnecessary register read
      i2c: sh_mobile: send STOP according to datasheet
      i2c: sh_mobile: make sure to not accidently trigger STOP
      i2c: gpio: add fault injector
      i2c: add a message flag for DMA safe buffers
      i2c: add helpers to ease DMA handling
      i2c: dev: mark RDWR buffers as DMA_SAFE
      i2c: refactor i2c_master_{send_recv}
      i2c: add i2c_master_{send|recv}_dmasafe
      i2c: smbus: use DMA safe buffers for emulated SMBus transactions
      i2c: add docs to clarify DMA handling
      i2c: sh_mobile: use core helper to decide when to use DMA
      i2c: rcar: skip DMA if buffer is not safe
      i2c: imx: use proper GPIO directions for recovery
      i2c: algo-bit: init the bus to a known state
      Merge branch 'i2c-mux/for-next' of https://github.com/peda-r/i2c-mux into i2c/for-4.16
      dt-bindings: eeprom: rename to at24.txt
      MAINTAINERS: add DT binding docs for AT24
      Merge tag 'at24-4.16-updates-for-wolfram' of git://git.kernel.org/.../brgl/linux into i2c/for-4.16
      i2c: sh_mobile: move type detection upwards
      i2c: sh_mobile: allow setup callback to return errno
      i2c: sh_mobile: require setup callback
      i2c: sh_mobile: let RuntimePM do the clock handling
      i2c: sh_mobile: add helper to check frequency calculations
      i2c: sh_mobile: add new frequency calculation for later SoC
      i2c: sh_mobile: let r8a7790 (R-Car H2) use the new formula
      i2c: make kerneldoc about bus recovery more precise
      i2c: add identifier in declarations for i2c_bus_recovery
      i2c: add 'set_sda' to bus_recovery_info
      i2c: ensure SDA is released in recovery if SDA is controllable
      i2c: send STOP after successful bus recovery
      i2c: rcar: implement bus recovery
      i2c: acorn: remove outdated path from file header
      i2c: rk3x: add proper kerneldoc header
      i2c: rcar: fix some trivial typos in comments

Yixun Lan (1):
      i2c: meson: update doc description to fix build warnings


with much appreciated quality assurance from
----------------------------------------------------------------
Andy Shevchenko (9):
      (Rev.) eeprom: at24: add support for the write-protect pin
      (Rev.) dt-bindings: at24: new optional property - wp-gpios
      (Rev.) i2c: remove legacy integer scl/sda gpio for recovery
      (Rev.) i2c: davinci: switch to using gpiod for bus recovery gpios
      (Rev.) i2c: imx: switch to using gpiod for bus recovery gpios
      (Rev.) i2c: designware: add i2c gpio recovery option
      (Rev.) i2c: designware: rename i2c_dw_plat_prepare_clk to i2c_dw_prepare_clk
      (Rev.) i2c: designware: move i2c_dw_plat_prepare_clk to common
      (Rev.) i2c: Switch to using gpiod interface for gpio bus recovery

David Lechner (1):
      (Test) i2c: davinci: fix the cpufreq transition

Fabio Estevam (1):
      (Rev.) i2c: imx: Include the right GPIO header

Heiko Stuebner (2):
      (Rev.) i2c: rk3x: add proper kerneldoc header
      (Rev.) i2c: rk3x: account for const type of of_device_id.data

Jacopo Mondi (4):
      (Test) i2c: sh_mobile: make sure to not accidently trigger STOP
      (Test) i2c: sh_mobile: send STOP according to datasheet
      (Test) i2c: sh_mobile: avoid unnecessary register read
      (Test) i2c: sh_mobile: let RuntimePM do the clock handling

Jarkko Nikula (3):
      (Rev.) i2c: core: fix compile issue related to incorrect gpio header
      (Rev.) i2c: remove legacy integer scl/sda gpio for recovery
      (Rev.) i2c: Switch to using gpiod interface for gpio bus recovery

Javier Martinez Canillas (3):
      (Rev.) eeprom: at24: extend the list of chips supported in DT
      (Rev.) dt-bindings: at24: extend the list of supported chips
      (Rev.) dt-bindings: at24: fix formatting and style

Jonathan Cameron (8):
      (Rev.) i2c: rcar: skip DMA if buffer is not safe
      (Rev.) i2c: sh_mobile: use core helper to decide when to use DMA
      (Rev.) i2c: add docs to clarify DMA handling
      (Rev.) i2c: smbus: use DMA safe buffers for emulated SMBus transactions
      (Rev.) i2c: refactor i2c_master_{send_recv}
      (Rev.) i2c: dev: mark RDWR buffers as DMA_SAFE
      (Rev.) i2c: add helpers to ease DMA handling
      (Rev.) i2c: add a message flag for DMA safe buffers

Linus Walleij (1):
      (Rev.) i2c: add 'set_sda' to bus_recovery_info

Luis Oliveira (1):
      (Test) i2c: designware: Don't set SCL timings and speed mode when in slave mode

Mauro Carvalho Chehab (1):
      (Rev.) i2c: add docs to clarify DMA handling

Neil Armstrong (1):
      (Rev.) i2c: meson: add configurable divider factors

Niklas S??derlund (1):
      (Rev.) i2c: sh_mobile: send STOP according to datasheet

Phil Reid (6):
      (Test) i2c: send STOP after successful bus recovery
      (Test) i2c: ensure SDA is released in recovery if SDA is controllable
      (Test) i2c: add 'set_sda' to bus_recovery_info
      (Test) i2c: add identifier in declarations for i2c_bus_recovery
      (Test) i2c: make kerneldoc about bus recovery more precise
      (Rev.) i2c: imx: use proper GPIO directions for recovery

Rob Herring (9):
      (Rev.) dt-bindings: i2c: Add MediaTek MT2712 i2c binding
      (Rev.) dt-bindings: at24: extend the list of supported chips
      (Rev.) dt-bindings: at24: fix formatting and style
      (Rev.) dt-bindings: at24: consistently document the compatible property
      (Rev.) dt-bindings: at24: new optional property - wp-gpios
      (Rev.) dt-bindings: add eeprom "no-read-rollover" property
      (Rev.) MAINTAINERS: add DT binding docs for AT24
      (Rev.) dt-bindings: eeprom: rename to at24.txt
      (Rev.) i2c: mux: pca954x: add support for NXP PCA984x family

Sekhar Nori (3):
      (Rev.) i2c: davinci: fix the cpufreq transition
      (Test) i2c/ARM: davinci: Deep refactoring of I2C recovery
      (Rev.) i2c: davinci: switch to using gpiod for bus recovery gpios

 Documentation/devicetree/bindings/eeprom/at24.txt  |  78 +++
 .../devicetree/bindings/eeprom/eeprom.txt          |  47 --
 .../devicetree/bindings/i2c/i2c-meson.txt          |   6 +-
 Documentation/devicetree/bindings/i2c/i2c-mtk.txt  |   1 +
 .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    |  13 +-
 .../devicetree/bindings/i2c/i2c-mv64xxx.txt        |  20 +
 Documentation/i2c/DMA-considerations               |  67 ++
 Documentation/i2c/gpio-fault-injection             |  54 ++
 MAINTAINERS                                        |   8 +
 arch/arm/mach-davinci/board-dm355-evm.c            |  15 +-
 arch/arm/mach-davinci/board-dm644x-evm.c           |  15 +-
 drivers/i2c/algos/i2c-algo-bit.c                   |   5 +
 drivers/i2c/busses/Kconfig                         |   8 +
 drivers/i2c/busses/i2c-acorn.c                     |   8 +-
 drivers/i2c/busses/i2c-davinci.c                   |  37 +-
 drivers/i2c/busses/i2c-designware-common.c         |  20 +-
 drivers/i2c/busses/i2c-designware-core.h           |   2 +
 drivers/i2c/busses/i2c-designware-master.c         |  57 ++
 drivers/i2c/busses/i2c-designware-platdrv.c        |  29 +-
 drivers/i2c/busses/i2c-designware-slave.c          |  64 --
 drivers/i2c/busses/i2c-exynos5.c                   |   2 +-
 drivers/i2c/busses/i2c-gpio.c                      | 122 +++-
 drivers/i2c/busses/i2c-imx-lpi2c.c                 |  68 +-
 drivers/i2c/busses/i2c-imx.c                       |  20 +-
 drivers/i2c/busses/i2c-ismt.c                      |  42 +-
 drivers/i2c/busses/i2c-meson.c                     |  34 +-
 drivers/i2c/busses/i2c-mpc.c                       |  57 +-
 drivers/i2c/busses/i2c-mt65xx.c                    |  40 +-
 drivers/i2c/busses/i2c-mv64xxx.c                   |  20 +-
 drivers/i2c/busses/i2c-mxs.c                       |   4 +-
 drivers/i2c/busses/i2c-rcar.c                      |  62 +-
 drivers/i2c/busses/i2c-rk3x.c                      |  17 +-
 drivers/i2c/busses/i2c-sh_mobile.c                 | 191 +++---
 drivers/i2c/i2c-core-base.c                        | 212 +++---
 drivers/i2c/i2c-core-smbus.c                       |  45 +-
 drivers/i2c/i2c-dev.c                              |   2 +
 drivers/i2c/muxes/Kconfig                          |   6 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c                |  38 +-
 drivers/i2c/muxes/i2c-mux-reg.c                    |   3 +
 drivers/misc/eeprom/Kconfig                        |   1 +
 drivers/misc/eeprom/at24.c                         | 731 +++++++--------------
 include/linux/i2c.h                                | 112 +++-
 include/linux/platform_data/at24.h                 |   2 +
 include/linux/platform_data/i2c-davinci.h          |   5 +-
 include/uapi/linux/i2c.h                           |   3 +
 45 files changed, 1381 insertions(+), 1012 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/eeprom/at24.txt
 delete mode 100644 Documentation/devicetree/bindings/eeprom/eeprom.txt
 create mode 100644 Documentation/i2c/DMA-considerations
 create mode 100644 Documentation/i2c/gpio-fault-injection

--q6dtc7g7obxwtgo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp2N/cACgkQFA3kzBSg
KbbU5w/9Eq6IBIoDYPsFN1atdmtYr9xr01LIoyas6VtsjKHUGfbMY0AYQ8c7SckL
Y6vnG+kiCbCTwRyi3K//hrfTkHlvW+voSC0+1woktrWflCZtS+6w7BmFurNI/L5z
yLHSmzvJLnLMjNb5U2LF5ROvx5GA1benm7paPyu0g18Tk2kJs78Gl2oVeaxb4GFf
YOoAsSqOAiVptoYSUkup/exxLzZVF6eQIJ43zCGZM/AUODskw1vc9kGOtXli0F+L
PAT6fr3wIaEd70z3N36KwZ3b+yydPH48lb55E+xMJoWFfbDmofepAGusUlEStTwP
ZgA80WGPZn908SXSiJcNlPOW2ZVLkhvPHnOinrAqOAWl+2c64GCpf00p4JQBlhpR
605ny4JfkaOvbLvlAUq1BDQycielPy3f5JcMSM9SSEN/QGvdP2aOcpA+8ZwKuJyH
z4byQUNVAI4WVoTeDSmhFTQSXXVucGLZw5XAm597NEI96YiGXdl1jd4w5sp/WBmT
oxNPm8gSuoSmCzJrzPIyYO0N44dlBhlwPieLAKSUaHCEcFn9lN/vI4mUOrEtP0OL
9Nkb7x+q9M4iplripniH9BcDOG7HSp9o3oIo9+ZeFXKrdxE9Vr2riUQm4fB1Fkkj
lSPEMF5br4bL7jRSbjSPHxkdPrtpfjsgSwW99lAVvq5ow/5h/u4=
=Gdxu
-----END PGP SIGNATURE-----

--q6dtc7g7obxwtgo3--
