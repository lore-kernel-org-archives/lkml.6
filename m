Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 27460C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD74208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD74208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935093AbeFMJVy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:21:54 -0400
Received: from sauhun.de ([88.99.104.3]:43432 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754581AbeFMJVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:21:48 -0400
Received: from localhost (softbank126012118084.bbtec.net [126.12.118.84])
        by pokefinder.org (Postfix) with ESMTPSA id B694854006A;
        Wed, 13 Jun 2018 11:21:44 +0200 (CEST)
Date:   Wed, 13 Jun 2018 18:21:36 +0900
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 4.18
Message-ID: <20180613092123.hfnx73wth7hyu3jv@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mtalkdaajebvntyi"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mtalkdaajebvntyi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has for 4.18:

* mainly feature additions to drivers (stm32f7, qup, xlp9xx, mlxcpld, ...)
* conversion to use the i2c_8bit_addr_from_msg macro consistently
* move includes to platform_data
* core updates to allow the (still in review) I3C subsystem to connect
* and the regular share of smaller driver updates

Please pull.

Thanks,

   Wolfram


The following changes since commit 67b8d5c7081221efa252e111cd52532ec6d4266f:

  Linux 4.17-rc5 (2018-05-13 16:15:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-4.18

for you to fetch changes up to 53e39628ac228fada53cc0106be62c6f65f67501:

  i2c: qup: fix building without CONFIG_ACPI (2018-05-31 23:21:00 +0200)

----------------------------------------------------------------
Alexander Monakov (2):
      i2c: designware: fix poll-after-enable regression
      i2c: designware: refactor low-level enable/disable

Anders Roxell (1):
      i2c: i801: fix unused-function warning

Andrzej Hajda (1):
      i2c: exynos5: simplify transfer function

Arnd Bergmann (1):
      i2c: qup: fix building without CONFIG_ACPI

Austin Christ (4):
      i2c: qup: add probe path for Centriq ACPI devices
      i2c: qup: Add support for Fast Mode Plus
      i2c: qup: Correct duty cycle for FM and FM+
      i2c: qup: Add command-line parameter to override SCL frequency

Bartosz Golaszewski (5):
      eeprom: at24: fix retrieving the at24_chip_data structure
      eeprom: at24: fix retrieving the at24_chip_data structure
      eeprom: at24: use devm_nvmem_register()
      eeprom: at24: provide and use a helper for releasing dummy i2c clients
      eeprom: at24: provide a separate routine for creating dummy i2c clients

Boris Brezillon (3):
      i2c: Get rid of i2c_board_info->archdata
      i2c: Retain info->of_node in i2c_new_device()
      i2c: Export of_i2c_get_board_info()

Colin Ian King (1):
      i2c: xiic: fix spelling mistake: "unexpexted" -> "unexpected"

David Engraf (1):
      i2c: at91: Read all available bytes at once

Dmitry Osipenko (1):
      i2c: tegra: Remove suspend-resume

Fabio Estevam (3):
      i2c: imx: Switch to SPDX identifier
      i2c: mxs: Switch to SPDX identifier
      i2c: imx-lpi2c: Switch to SPDX identifier

George Cherian (3):
      i2c: xlp9xx: Add support for SMBAlert
      i2c: xlp9xx: Fix issue seen when updating receive length
      i2c: xlp9xx: Make sure the transfer size is not more than I2C_SMBUS_BLOCK_SIZE

Hans de Goede (2):
      i2c: core: ACPI: Improve OpRegion read errors
      i2c: core: ACPI: Log device not acking errors at dbg loglevel

Jean Delvare (1):
      i2c: i801: Don't restore config registers on runtime PM

Julia Lawall (1):
      i2c: mux: pca954x: merge calls to of_match_device and of_device_get_match_data

Krzysztof Kozlowski (1):
      i2c: s3c2410: Remove support for Exynos5440

Markus Elfring (1):
      i2c: mux: reg: failed memory allocation is logged elsewhere

Michael Shych (5):
      i2c: mlxcpld: Add support for extended transaction length for i2c-mlxcpld
      i2c: mlxcpld: Add support for smbus block read transaction
      i2c: mlxcpld: Fix adapter functionality support callback
      i2c: mlxcpld: Allow configurable adapter id for mlxcpld
      i2c: mlxcpld: Add capability register description to documentation

Mike Looijmans (1):
      i2c: mux: pca954x: force reset on probe if available

Peter Rosin (10):
      i2c: pmcmsp: return message count on master_xfer success
      i2c: pmcmsp: fix error return from master_xfer
      i2c: viperboard: return message count on master_xfer success
      i2c: hix5hd2: remove some dead code
      i2c: synquacer: fix fence-post error in retry loop
      i2c: mux: ltc4306: switch to using .probe_new
      i2c: robotfuzz-osif: remove pointless local variable
      i2c: robotfuzz-osif: drop pointless test
      i2c: algos: make use of i2c_8bit_addr_from_msg
      i2c: busses: make use of i2c_8bit_addr_from_msg

Pierre-Yves MORDRET (7):
      i2c: i2c-stm32f7: Add 10-bit address support
      i2c: i2c-stm32f7: Add slave support
      i2c: i2c-stm32f7: Add initial SMBus protocols support
      i2c: i2c-stm32: Add generic DMA API
      i2c: i2c-stm32f7: Add DMA support
      i2c: i2c-stm32f7: Implement I2C release mechanism
      i2c: stm32f7: fix documentation typo

Ryder Lee (1):
      i2c: mediatek: use of_device_get_match_data()

Sergei Shtylyov (1):
      i2c: rcar: document R8A77980 bindings

Shawn Lin (1):
      i2c: rk3x: Don't print visible virtual mapping MMIO address

Tobias Jordan (1):
      i2c: axxia: enable clock before calling clk_get_rate()

Wenwen Wang (1):
      i2c: core: smbus: fix a potential missing-check bug

Wolfram Sang (20):
      i2c: rcar: enhance comment to avoid regressions
      i2c: busses: remove superfluous ignoring of children for RPM
      Merge tag 'at24-4.17-rc5-fixes-for-wolfram' of git://git.kernel.org/.../brgl/linux into i2c/for-current
      Merge branch 'i2c/for-current-fixed' into i2c/for-4.18
      dt-bindings: i2c: fix typo 'can by' to 'can be'
      i2c: gpio: move header to platform_data
      i2c: mux: gpio: move header to platform_data
      i2c: ocores: move header to platform_data
      i2c: omap: move header to platform_data
      i2c: pca-platform: move header to platform_data
      i2c: xiic: move header to platform_data
      i2c: pnx: move header into the driver
      Merge branch 'i2c/platform_data-immutable' into i2c/for-4.18
      i2c: mux: demux-pinctrl: disable PM user interface
      Merge tag 'at24-4.18-updates-for-wolfram' of git://git.kernel.org/.../brgl/linux into i2c/for-4.18
      i2c: mux: improve error message for failed symlink
      i2c: mux: demux-pinctrl: use proper parent device for demux adapter
      i2c: ibm_iic: don't check number of messages in the driver
      i2c: opal: don't check number of messages in the driver
      Merge branch 'i2c-mux/for-next' of https://github.com/peda-r/i2c-mux into i2c/for-4.18


with much appreciated quality assurance from
----------------------------------------------------------------
Alexander Sverdlin (1):
      (Rev.) i2c: mux: reg: failed memory allocation is logged elsewhere

Andi Shyti (1):
      (Rev.) i2c: exynos5: simplify transfer function

Andy Gross (4):
      (Rev.) i2c: qup: Add command-line parameter to override SCL frequency
      (Rev.) i2c: qup: Correct duty cycle for FM and FM+
      (Rev.) i2c: qup: Add support for Fast Mode Plus
      (Rev.) i2c: qup: add probe path for Centriq ACPI devices

Austin Christ (1):
      (Rev.) i2c: qup: fix building without CONFIG_ACPI

Ben Gardner (1):
      (Test) i2c: designware: fix poll-after-enable regression

Geert Uytterhoeven (1):
      (Rev.) i2c: rcar: document R8A77980 bindings

Guenter Roeck (1):
      (Rev.) i2c: busses: make use of i2c_8bit_addr_from_msg

Heiko Stuebner (1):
      (Rev.) i2c: rk3x: Don't print visible virtual mapping MMIO address

Jan Glauber (1):
      (Rev.) i2c: xlp9xx: Add support for SMBAlert

Jarkko Nikula (1):
      (Rev.) i2c: i801: Don't restore config registers on runtime PM

Jean Delvare (1):
      (Rev.) i2c: i801: fix unused-function warning

Linus Walleij (1):
      (Rev.) i2c: busses: remove superfluous ignoring of children for RPM

Mika Westerberg (2):
      (Rev.) i2c: core: ACPI: Log device not acking errors at dbg loglevel
      (Rev.) i2c: core: ACPI: Improve OpRegion read errors

Peter Rosin (6):
      (Rev.) i2c: opal: don't check number of messages in the driver
      (Rev.) i2c: ibm_iic: don't check number of messages in the driver
      (Rev.) eeprom: at24: provide a separate routine for creating dummy i2c clients
      (Rev.) eeprom: at24: provide and use a helper for releasing dummy i2c clients
      (Rev.) eeprom: at24: use devm_nvmem_register()
      (Rev.) i2c: exynos5: simplify transfer function

Simon Horman (2):
      (Rev.) i2c: rcar: document R8A77980 bindings
      (Rev.) i2c: mux: demux-pinctrl: use proper parent device for demux adapter

Sricharan R (4):
      (Rev.) i2c: qup: Add command-line parameter to override SCL frequency
      (Rev.) i2c: qup: Correct duty cycle for FM and FM+
      (Rev.) i2c: qup: Add support for Fast Mode Plus
      (Rev.) i2c: qup: add probe path for Centriq ACPI devices

Sylwester Nawrocki (1):
      (Rev.) i2c: s3c2410: Remove support for Exynos5440

Ulf Hansson (1):
      (Rev.) i2c: busses: remove superfluous ignoring of children for RPM

 .../devicetree/bindings/i2c/i2c-davinci.txt        |    2 +-
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |    1 +
 .../devicetree/bindings/i2c/i2c-s3c2410.txt        |    4 +-
 Documentation/i2c/busses/i2c-mlxcpld               |    4 +
 Documentation/i2c/busses/i2c-ocores                |    2 +-
 Documentation/i2c/muxes/i2c-mux-gpio               |    4 +-
 MAINTAINERS                                        |    8 +-
 arch/arm/mach-ks8695/board-acs5k.c                 |    2 +-
 arch/arm/mach-omap1/board-htcherald.c              |    2 +-
 arch/arm/mach-omap1/common.h                       |    2 +-
 arch/arm/mach-omap1/i2c.c                          |    2 +-
 arch/arm/mach-omap2/common.h                       |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |    2 +-
 arch/arm/mach-pxa/palmz72.c                        |    2 +-
 arch/arm/mach-pxa/viper.c                          |    2 +-
 arch/arm/mach-sa1100/simpad.c                      |    2 +-
 arch/mips/alchemy/board-gpr.c                      |    2 +-
 arch/sh/boards/board-sh7785lcr.c                   |    2 +-
 drivers/i2c/algos/i2c-algo-bit.c                   |    4 +-
 drivers/i2c/algos/i2c-algo-pca.c                   |    5 +-
 drivers/i2c/algos/i2c-algo-pcf.c                   |    8 +-
 drivers/i2c/busses/Kconfig                         |    1 +
 drivers/i2c/busses/Makefile                        |    3 +-
 drivers/i2c/busses/i2c-aspeed.c                    |    3 +-
 drivers/i2c/busses/i2c-at91.c                      |   12 +-
 drivers/i2c/busses/i2c-axxia.c                     |   31 +-
 drivers/i2c/busses/i2c-designware-common.c         |   20 +-
 drivers/i2c/busses/i2c-designware-core.h           |   14 +-
 drivers/i2c/busses/i2c-designware-master.c         |   11 +-
 drivers/i2c/busses/i2c-designware-slave.c          |    6 +-
 drivers/i2c/busses/i2c-diolan-u2c.c                |   11 +-
 drivers/i2c/busses/i2c-efm32.c                     |    3 +-
 drivers/i2c/busses/i2c-eg20t.c                     |    5 +-
 drivers/i2c/busses/i2c-emev2.c                     |    2 +-
 drivers/i2c/busses/i2c-exynos5.c                   |   29 +-
 drivers/i2c/busses/i2c-gpio.c                      |    2 +-
 drivers/i2c/busses/i2c-hix5hd2.c                   |   22 +-
 drivers/i2c/busses/i2c-i801.c                      |    7 +-
 drivers/i2c/busses/i2c-ibm_iic.c                   |    3 -
 drivers/i2c/busses/i2c-imx-lpi2c.c                 |   16 +-
 drivers/i2c/busses/i2c-imx.c                       |   21 +-
 drivers/i2c/busses/i2c-kempld.c                    |    7 +-
 drivers/i2c/busses/i2c-mlxcpld.c                   |   68 +-
 drivers/i2c/busses/i2c-mt65xx.c                    |    8 +-
 drivers/i2c/busses/i2c-mxs.c                       |   16 +-
 drivers/i2c/busses/i2c-nomadik.c                   |    2 -
 drivers/i2c/busses/i2c-ocores.c                    |    7 +-
 drivers/i2c/busses/i2c-omap.c                      |    2 +-
 drivers/i2c/busses/i2c-opal.c                      |    4 -
 drivers/i2c/busses/i2c-pasemi.c                    |    2 +-
 drivers/i2c/busses/i2c-pca-platform.c              |    2 +-
 drivers/i2c/busses/i2c-pmcmsp.c                    |    4 +-
 drivers/i2c/busses/i2c-pnx.c                       |   21 +-
 drivers/i2c/busses/i2c-qup.c                       |   59 +-
 drivers/i2c/busses/i2c-rcar.c                      |    4 +-
 drivers/i2c/busses/i2c-riic.c                      |    5 +-
 drivers/i2c/busses/i2c-rk3x.c                      |    2 -
 drivers/i2c/busses/i2c-robotfuzz-osif.c            |   21 +-
 drivers/i2c/busses/i2c-s3c2410.c                   |    2 -
 drivers/i2c/busses/i2c-sh_mobile.c                 |   11 -
 drivers/i2c/busses/i2c-stm32.c                     |  153 +++
 drivers/i2c/busses/i2c-stm32.h                     |   37 +
 drivers/i2c/busses/i2c-stm32f7.c                   | 1045 +++++++++++++++++++-
 drivers/i2c/busses/i2c-stu300.c                    |   22 +-
 drivers/i2c/busses/i2c-synquacer.c                 |    2 +-
 drivers/i2c/busses/i2c-tegra.c                     |   33 -
 drivers/i2c/busses/i2c-viperboard.c                |    2 +-
 drivers/i2c/busses/i2c-xiic.c                      |   17 +-
 drivers/i2c/busses/i2c-xlp9xx.c                    |   89 +-
 drivers/i2c/i2c-core-acpi.c                        |   13 +-
 drivers/i2c/i2c-core-base.c                        |   10 +-
 drivers/i2c/i2c-core-of.c                          |   51 +-
 drivers/i2c/i2c-core-smbus.c                       |    2 +
 drivers/i2c/i2c-mux.c                              |    2 +-
 drivers/i2c/muxes/i2c-demux-pinctrl.c              |    5 +-
 drivers/i2c/muxes/i2c-mux-gpio.c                   |    2 +-
 drivers/i2c/muxes/i2c-mux-ltc4306.c                |    7 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c                |   18 +-
 drivers/i2c/muxes/i2c-mux-reg.c                    |    4 +-
 drivers/media/platform/marvell-ccic/mmp-driver.c   |    2 +-
 drivers/mfd/sm501.c                                |    2 +-
 drivers/mfd/timberdale.c                           |    4 +-
 drivers/misc/eeprom/at24.c                         |   73 +-
 include/linux/i2c-pnx.h                            |   38 -
 include/linux/i2c.h                                |   12 +-
 include/linux/{ => platform_data}/i2c-gpio.h       |    0
 include/linux/{ => platform_data}/i2c-mux-gpio.h   |    0
 include/linux/{ => platform_data}/i2c-ocores.h     |    0
 include/linux/{ => platform_data}/i2c-omap.h       |    0
 .../linux/{ => platform_data}/i2c-pca-platform.h   |    0
 include/linux/{ => platform_data}/i2c-xiic.h       |    0
 97 files changed, 1700 insertions(+), 490 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-stm32.c
 delete mode 100644 include/linux/i2c-pnx.h
 rename include/linux/{ => platform_data}/i2c-gpio.h (100%)
 rename include/linux/{ => platform_data}/i2c-mux-gpio.h (100%)
 rename include/linux/{ => platform_data}/i2c-ocores.h (100%)
 rename include/linux/{ => platform_data}/i2c-omap.h (100%)
 rename include/linux/{ => platform_data}/i2c-pca-platform.h (100%)
 rename include/linux/{ => platform_data}/i2c-xiic.h (100%)

--mtalkdaajebvntyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsg4hMACgkQFA3kzBSg
KbYZAA//Rv4fKYxAHMFcTTa277WEO5pvO0Sbr0uXR1cvSh5EQ8UVuvigFRgvFmKP
6YhcXxvZUJbscF4oXf9+DKWCfaUAOnRmAPMw8jN/LX3Cele1OoXBlRWp1YrTutZy
/d/o8Zx4Z0XKlP9xz45oLxS3m/Tot7bZdRyMU2pVcev/8MpcwqzCW2XpW8/77MwF
SrMDP7Ogy6eTu9Gj1rMCj+wtLeNky04+Vr3gxIUioSQjZ+D0weL5LqrCgTrQ3rmu
l45jXPKDAWcIm9w/mYC6bJT2rl51aBB5GYZ8iHu2Oha3wD8RDWDnxyGyncTtqOjt
z3iJkuf54AkAUSZnxq3f9LK1FlzRYe5NQNcWfLYmr3FXkSRZqZDno63s3yrHykbp
g4d0rXkuwLaEjw1aJB08fiqRkNX6IR/gmI7GMK4o3rU+3Xu8mtysv1Z4WgKN/F/E
l+TBK5yWRqd0GyaeuLBj0/yE+XfcjMX3LKPuZlphifcjkFJIArwTsKJUgSotA3T/
unk8n4z1YYbhtDlSHRzcd/XKk3QPD0DuAbL+CLzZfVnn+6D403m4GubcJxit30Ll
ugBMntIb04xdwbJbgb6ol8wTCYr+00U8iwm/8aPbCye/PKueTFIXXsBWHmTXOcFq
VOHvoEfqP1f5rjpoUgfAlClg6RS2HSH43iFW9//W+WvoMMyUbGM=
=foGO
-----END PGP SIGNATURE-----

--mtalkdaajebvntyi--
