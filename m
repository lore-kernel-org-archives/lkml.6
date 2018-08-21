Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EDDC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FF62064E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FF62064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeHURY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:24:56 -0400
Received: from sauhun.de ([88.99.104.3]:41908 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbeHURY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:24:56 -0400
Received: from localhost (p54B3375F.dip0.t-ipconnect.de [84.179.55.95])
        by pokefinder.org (Postfix) with ESMTPSA id A4C932D8DDB;
        Tue, 21 Aug 2018 16:04:35 +0200 (CEST)
Date:   Tue, 21 Aug 2018 16:04:35 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 4.19
Message-ID: <20180821140430.ezghempfe64nddxw@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m5swph7nsuhx2eh5"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m5swph7nsuhx2eh5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here are the I2C updates for this merge window:

* the core has now a lockless variant of i2c_smbus_xfer. Some open coded
  versions of this got removed in drivers. This also enables proper SCCB
  support in regmap.
* locking got a more precise naming. i2c_{un}lock_adapter() had to go,
  and we know use i2c_lock_bus() consistently with flags like
  I2C_LOCK_ROOT_ADAPTER and I2C_LOCK_SEGMENT to avoid ambiguity.
* the gpio fault injector got a new delicate testcase
* the bus recovery procedure got fixed to handle the new testcase
  correctly
* a new quirk flag for controllers not able to handle zero length
  messages together with driver updates to use it
* new drivers: FSI bus attached I2C masters, GENI I2C controller,
  Owl family S900
* and a good set of driver improvements and bugfixes

I will send you the promised pull request with the removal of the
deprecated attach_adapter callback seperately during this merge window.

Please pull.

Thanks,

   Wolfram


The following changes since commit d72e90f33aa4709ebecc5005562f52335e106a60:

  Linux 4.18-rc6 (2018-07-22 14:12:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-4.19

for you to fetch changes up to 19358d4488db7e6a04e940730cc75909d7d1e0d8:

  i2c: rcar: implement STOP and REP_START according to docs (2018-08-20 14:49:41 +0200)

----------------------------------------------------------------
Alan Chiang (2):
      dt-bindings: at24: Add address-width property
      eeprom: at24: Add support for address-width property

Andy Shevchenko (3):
      i2c: core: Parse SDA hold time from firmware
      i2c: designware: Convert to use struct i2c_timings
      i2c: designware: Add SPDX license tag

Darren Stevens (1):
      i2c: pasemi: remove hardcoded bus numbers on smbus

Eddie James (8):
      dt-bindings: i2c: Add FSI-attached I2C master dt binding documentation
      i2c: Add FSI-attached I2C master algorithm
      i2c: fsi: Add port structures
      i2c: fsi: Add abort and hardware reset procedures
      i2c: fsi: Add transfer implementation
      i2c: fsi: Add I2C master locking
      i2c: fsi: Add bus recovery
      MAINTAINERS: Add Eddie as the maintainer for the FSI-attached I2C driver

Esben Haabendal (2):
      i2c: imx: Fix race condition in dma read
      i2c: imx: Simplify stopped state tracking

Fabrizio Castro (2):
      dt-bindings: i2c: sh_mobile: Add r8a774a1 support
      dt-bindings: i2c: rcar: Add r8a774a1 support

Gustavo A. R. Silva (2):
      i2c: amd8111: Mark expected switch fall-through
      i2c: designware-pcidrv: Mark expected switch fall-through

Hans de Goede (2):
      i2c: core: ACPI: Properly set status byte to 0 for multi-byte writes
      i2c: core: ACPI: Make acpi_gsb_i2c_read_bytes() check i2c_transfer return value

Hiromitsu Yamasaki (1):
      i2c: rcar: Add compatible support for r8a77990 (R-Car E3)

Jae Hyun Yoo (4):
      i2c: aspeed: Add newline characters into message printings.
      i2c: aspeed: Fix initial values of master and slave state
      i2c: aspeed: Adjust spinlock scope in the irq handler
      i2c: aspeed: Add an explicit type casting for *get_clk_reg_val

Jarkko Nikula (9):
      i2c: designware: Remove needless variable from i2c_dw_init_slave()
      i2c: designware: Move register access detection to common code
      i2c: designware: Don't use internal ___constant_swab32
      i2c: designware: Call i2c_dw_clk_rate() only once in i2c_dw_init_master()
      i2c: designware: Move SDA hold time configuration to common code
      i2c: designware: Separate timing parameter setting from HW initalization
      i2c: designware: Add debug print for SDA hold time value
      i2c: designware: Add debug print for bus speed
      i2c: i801: Consolidate chipset names in documentation and Kconfig

Karthikeyan Ramasubramanian (1):
      i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C controller

Krzysztof Kozlowski (1):
      i2c: exynos5: Describe the hardware variant for readability

Linus Walleij (1):
      i2c: mux: pca954x: use helper variable in probe

Manivannan Sadhasivam (2):
      dt-bindings: i2c: Add binding for Actions Semiconductor Owl I2C controller
      i2c: Add Actions Semiconductor Owl family S900 I2C driver

Mika Westerberg (1):
      i2c: i801: Add support for Intel Ice Lake

Peter Rosin (15):
      i2c: smbus: add unlocked __i2c_smbus_xfer variant
      i2c: mux: mlxcpld: make use of __i2c_smbus_xfer
      i2c: mux: pca9541: make use of __i2c_smbus_xfer
      i2c: mux: pca954x: make use of __i2c_smbus_xfer
      i2c: mux: make use of __i2c_smbus_xfer
      tpm/tpm_i2c_infineon: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
      i2c: mux: pca9541: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
      input: rohm_bu21023: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
      media: af9013: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
      media: drxk_hard: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
      media: rtl2830: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
      media: tda1004x: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
      media: tda18271: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
      mfd: 88pm860x-i2c: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
      i2c: remove i2c_lock_adapter and use i2c_lock_bus directly

Thierry Reding (1):
      i2c: tegra: Add support for Tegra194

Wolfram Sang (23):
      i2c: gpio: fault-injector: refactor incomplete transfer
      i2c: gpio: fault-injector: add incomplete_write_byte
      Merge branch 'i2c/precise-locking-names_immutable' into i2c/for-4.19
      Merge tag 'v4.18-rc5' into i2c/for-4.19
      i2c: recovery: require either get_sda or set_sda
      i2c: recovery: refactor recovery function
      i2c: recovery: add get_bus_free callback
      i2c: rcar: use the new get_bus_free callback
      i2c: recovery: rename variable for easier understanding
      i2c: recovery: make pin init look like STOP
      i2c: rcar: handle RXDMA HW behaviour on Gen3
      Merge tag 'at24-4.19-updates-for-wolfram' of git://git.kernel.org/.../brgl/linux into i2c/for-4.19
      Merge branch 'i2c-mux/for-next' of https://github.com/peda-r/i2c-mux into i2c/for-4.19
      i2c: quirks: add zero length checks
      i2c: designware-master: use core to detect 'no zero length' quirk
      i2c: mxs: use core to detect 'no zero length' quirk
      i2c: pmcmsp: use core to detect 'no zero length' quirk
      i2c: stu300: use core to detect 'no zero length' quirk
      i2c: rcar: use core to detect 'no zero length' quirk
      i2c: xlr: use core to detect 'no zero length' quirk
      i2c: sh_mobile: use core to detect 'no zero length read' quirk
      i2c: rcar: refactor private flags
      i2c: rcar: implement STOP and REP_START according to docs


with much appreciated quality assurance from
----------------------------------------------------------------
Alexander Steffen (1):
      (Test) tpm/tpm_i2c_infineon: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)

Alexandre Belloni (4):
      (Rev.) i2c: designware: Convert to use struct i2c_timings
      (Test) i2c: designware: Convert to use struct i2c_timings
      (Test) i2c: core: Parse SDA hold time from firmware
      (Rev.) i2c: core: Parse SDA hold time from firmware

Andrzej Hajda (1):
      (Rev.) i2c: exynos5: Describe the hardware variant for readability

Andy Shevchenko (13):
      (Rev.) i2c: designware-master: use core to detect 'no zero length' quirk
      (Rev.) i2c: quirks: add zero length checks
      (Rev.) i2c: fsi: Add I2C master locking
      (Rev.) i2c: fsi: Add transfer implementation
      (Rev.) i2c: Add FSI-attached I2C master algorithm
      (Rev.) i2c: designware: Add debug print for bus speed
      (Rev.) i2c: designware: Add debug print for SDA hold time value
      (Rev.) i2c: designware: Separate timing parameter setting from HW initalization
      (Rev.) i2c: designware: Move SDA hold time configuration to common code
      (Rev.) i2c: designware: Call i2c_dw_clk_rate() only once in i2c_dw_init_master()
      (Rev.) i2c: designware: Don't use internal ___constant_swab32
      (Rev.) i2c: designware: Move register access detection to common code
      (Rev.) i2c: designware: Remove needless variable from i2c_dw_init_slave()

Biju Das (2):
      (Rev.) dt-bindings: i2c: rcar: Add r8a774a1 support
      (Rev.) dt-bindings: i2c: sh_mobile: Add r8a774a1 support

Brendan Higgins (4):
      (Rev.) i2c: aspeed: Add an explicit type casting for *get_clk_reg_val
      (Rev.) i2c: aspeed: Adjust spinlock scope in the irq handler
      (Rev.) i2c: aspeed: Fix initial values of master and slave state
      (Rev.) i2c: aspeed: Add newline characters into message printings.

Douglas Anderson (1):
      (Rev.) i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C controller

Geert Uytterhoeven (2):
      (Rev.) i2c: rcar: handle RXDMA HW behaviour on Gen3
      (Rev.) i2c: rcar: Add compatible support for r8a77990 (R-Car E3)

Jarkko Nikula (2):
      (Test) i2c: designware-master: use core to detect 'no zero length' quirk
      (Test) i2c: quirks: add zero length checks

Jarkko Sakkinen (1):
      (Rev.) tpm/tpm_i2c_infineon: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)

Jean Delvare (2):
      (Rev.) i2c: i801: Add support for Intel Ice Lake
      (Rev.) i2c: i801: Consolidate chipset names in documentation and Kconfig

Joel Stanley (6):
      (Test) i2c: fsi: Add bus recovery
      (Test) i2c: fsi: Add I2C master locking
      (Test) i2c: fsi: Add transfer implementation
      (Test) i2c: fsi: Add abort and hardware reset procedures
      (Test) i2c: fsi: Add port structures
      (Test) i2c: Add FSI-attached I2C master algorithm

Linus Walleij (1):
      (Rev.) i2c: stu300: use core to detect 'no zero length' quirk

Niklas S??derlund (3):
      (Rev.) i2c: sh_mobile: use core to detect 'no zero length read' quirk
      (Rev.) i2c: rcar: use core to detect 'no zero length' quirk
      (Rev.) i2c: quirks: add zero length checks

Peter Rosin (2):
      (Rev.) i2c: recovery: make pin init look like STOP
      (Rev.) i2c: recovery: refactor recovery function

Rob Herring (4):
      (Rev.) dt-bindings: i2c: rcar: Add r8a774a1 support
      (Rev.) dt-bindings: i2c: sh_mobile: Add r8a774a1 support
      (Rev.) dt-bindings: i2c: Add binding for Actions Semiconductor Owl I2C controller
      (Rev.) dt-bindings: at24: Add address-width property

Sekhar Nori (1):
      (Test) i2c: remove i2c_lock_adapter and use i2c_lock_bus directly

Simon Horman (2):
      (Rev.) dt-bindings: i2c: rcar: Add r8a774a1 support
      (Rev.) dt-bindings: i2c: sh_mobile: Add r8a774a1 support

Stephen Boyd (2):
      (Rev.) i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C controller
      (Test) i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C controller

Ulrich Hecht (3):
      (Rev.) i2c: rcar: implement STOP and REP_START according to docs
      (Rev.) i2c: rcar: refactor private flags
      (Rev.) i2c: recovery: make pin init look like STOP

 Documentation/devicetree/bindings/eeprom/at24.txt  |   2 +
 Documentation/devicetree/bindings/i2c/i2c-fsi.txt  |  40 ++
 Documentation/devicetree/bindings/i2c/i2c-owl.txt  |  27 +
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |   5 +-
 .../devicetree/bindings/i2c/i2c-sh_mobile.txt      |   4 +-
 Documentation/i2c/busses/i2c-i801                  |  11 +-
 Documentation/i2c/gpio-fault-injection             |  49 +-
 MAINTAINERS                                        |  16 +
 drivers/char/tpm/tpm_i2c_infineon.c                |   8 +-
 drivers/i2c/busses/Kconfig                         |  42 +-
 drivers/i2c/busses/Makefile                        |   3 +
 drivers/i2c/busses/i2c-amd8111.c                   |   1 +
 drivers/i2c/busses/i2c-aspeed.c                    |  40 +-
 drivers/i2c/busses/i2c-brcmstb.c                   |   8 +-
 drivers/i2c/busses/i2c-davinci.c                   |   4 +-
 drivers/i2c/busses/i2c-designware-baytrail.c       |  10 +-
 drivers/i2c/busses/i2c-designware-common.c         |  91 ++-
 drivers/i2c/busses/i2c-designware-core.h           |  24 +-
 drivers/i2c/busses/i2c-designware-master.c         | 223 +++---
 drivers/i2c/busses/i2c-designware-pcidrv.c         |  17 +-
 drivers/i2c/busses/i2c-designware-platdrv.c        |  68 +-
 drivers/i2c/busses/i2c-designware-slave.c          |  62 +-
 drivers/i2c/busses/i2c-exynos5.c                   |  22 +-
 drivers/i2c/busses/i2c-fsi.c                       | 752 +++++++++++++++++++++
 drivers/i2c/busses/i2c-gpio.c                      |  97 ++-
 drivers/i2c/busses/i2c-i801.c                      |   4 +
 drivers/i2c/busses/i2c-imx.c                       |  23 +-
 drivers/i2c/busses/i2c-mxs.c                       |   8 +-
 drivers/i2c/busses/i2c-owl.c                       | 495 ++++++++++++++
 drivers/i2c/busses/i2c-pasemi.c                    |   3 +-
 drivers/i2c/busses/i2c-pmcmsp.c                    |  17 +-
 drivers/i2c/busses/i2c-qcom-geni.c                 | 673 ++++++++++++++++++
 drivers/i2c/busses/i2c-rcar.c                      | 123 +++-
 drivers/i2c/busses/i2c-s3c2410.c                   |   4 +-
 drivers/i2c/busses/i2c-sh_mobile.c                 |  10 +-
 drivers/i2c/busses/i2c-sprd.c                      |   8 +-
 drivers/i2c/busses/i2c-stu300.c                    |  12 +-
 drivers/i2c/busses/i2c-tegra.c                     |  90 ++-
 drivers/i2c/busses/i2c-xlr.c                       |  11 +-
 drivers/i2c/i2c-core-acpi.c                        |  19 +-
 drivers/i2c/i2c-core-base.c                        |  85 ++-
 drivers/i2c/i2c-core-slave.c                       |   8 +-
 drivers/i2c/i2c-core-smbus.c                       |  28 +-
 drivers/i2c/i2c-mux.c                              |   4 +-
 drivers/i2c/muxes/i2c-mux-mlxcpld.c                |  28 +-
 drivers/i2c/muxes/i2c-mux-pca9541.c                |  75 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c                |  51 +-
 drivers/iio/temperature/mlx90614.c                 |   4 +-
 drivers/input/touchscreen/rohm_bu21023.c           |   4 +-
 drivers/media/dvb-frontends/af9013.c               |   8 +-
 drivers/media/dvb-frontends/drxk_hard.c            |   4 +-
 drivers/media/dvb-frontends/rtl2830.c              |  12 +-
 drivers/media/dvb-frontends/tda1004x.c             |   6 +-
 drivers/media/tuners/tda18271-common.c             |   8 +-
 drivers/mfd/88pm860x-i2c.c                         |   8 +-
 drivers/misc/eeprom/at24.c                         |  17 +
 include/linux/i2c.h                                |  44 +-
 57 files changed, 2846 insertions(+), 674 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-owl.txt
 create mode 100644 drivers/i2c/busses/i2c-fsi.c
 create mode 100644 drivers/i2c/busses/i2c-owl.c
 create mode 100644 drivers/i2c/busses/i2c-qcom-geni.c

--m5swph7nsuhx2eh5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlt8G+4ACgkQFA3kzBSg
KbarGhAAq78jBza0pBsYdA6BG+pmN8JFPn87zChMJTdtlLQOOQL0eOYFXj/b6Q+/
rc8nvOwwmA3izv3NSprI7EO+TeFEWKyNoAMV/V/LBSrZ7VwH/XTSm+YRrTlUTIrs
3k2yEaZdRXINHmzp+41rKvMnX3Mi7HzB23NtyxFJ4EQwMbSHGG5rMSkpY0LcdYjq
IYkle6bp0QuRlKt3fqb7H/FJgFfe+94vO7KU63mvYek8cRhv5/kHD/Vk9XA0uIBq
352KKZaUhNlf8H8PWXsMok5Ys4WJ1Qmlbsufw0S+rFxl62GiAVkOa6+eaYG7LXMi
9To6nycjDn5x/y8lIPeEyFAF2OWKq7kqHZRJLYX18lated9C0PXHLy0yGNAQrryy
DZUHzgobfjxxwJJ6IeQLb8HZmxSCbDl8nhWyof1tW4pS+Ko6rXjfQ64YISyPacnP
KI9Y6XSGjeyx1pytP15lDr3S2JUHVQLOh2O0LkZelxVNhK8xQY+C1nnoiRFrWXse
X3pMDezp8nFkKbhtrgIF4b3KbhakqJ+HV6IMxlUX/IVfrCzko17qzX0wkwgarjdl
CPCv9VaNjG68H2URZrFnXlmI3aLuPqEbpefO7dpR8r6VFJ7AxUV1I2SdWmom+KDQ
OkdyXiaD08osX/9EZXRcRPGtA6P9mC7ZU7er/Ea7dke1BI6HMDk=
=Hit/
-----END PGP SIGNATURE-----

--m5swph7nsuhx2eh5--
