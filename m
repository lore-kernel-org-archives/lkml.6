Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeAaP2Q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:28:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:50756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932066AbeAaPZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:25:48 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6EE82178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Wed, 31 Jan 2018 16:25:45 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 4.16
Message-ID: <20180131152545.ue2jyhglncfe3brr@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bih3zmmmjmqduvbq"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bih3zmmmjmqduvbq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v4.16

for you to fetch changes up to 2d7e6a8376c0eaf260f54b265acadd2e185d7b82:

  power: supply: max17042_battery: Always fall back to default platform-data (2018-01-23 16:51:22 +0100)

----------------------------------------------------------------
power supply and reset changes for the v4.16 series

 * bq27xxx: add bq27521 support
 * drop unused imx-snvs-poweroff driver
 * improve axp288 driver
 * misc. fixes

----------------------------------------------------------------
Arvind Yadav (1):
      power: supply: cpcap-battery: Fix platform_get_irq_byname's error checking

Bjorn Andersson (1):
      power: reset: msm: Clarify restart and poweroff

Christophe JAILLET (2):
      power: supply: ab8500_charger: Fix an error handling path
      power: supply: ab8500_charger: Bail out in case of error in 'ab8500_charger_init_hw_registers()'

Dan Carpenter (1):
      power: supply: sbs-message: double left shift bug in sbsm_select()

Dong Aisheng (1):
      power: reset: remove unused imx-snvs-poweroff driver

Hans de Goede (19):
      power: supply: bq24190_charger: Remove extcon handling
      power: supply: axp288_charger: Do not stop + restart charging at boot
      power: supply: axp288_charger: Add missing newlines to some messages
      power: supply: axp288_charger: Remove charger-enabled state tracking
      power: supply: axp288_charger: Cleanup some double empty lines
      power: supply: axp288_charger: Use regmap_update_bits to set the input limits
      power: supply: axp288_charger: Remove no longer needed locking
      power: supply: axp288_charger: Do not cache input current limit value
      power: supply: axp288_charger: Pick lower input current limit not higher
      power: supply: axp288_charger: Use the right property for the input current limit
      power: supply: axp288_charger: Simplify extcon cable handling
      power: supply: axp288_charger: Properly stop work on probe-error / remove
      power: supply: axp288_fuel_gauge: Get iio-channels once during boot
      power: supply: axp288_fuel_gauge: Rework get_status()
      power: supply: axp288_fuel_gauge: Optimize get_current()
      power: supply: axp288_fuel_gauge: Do not register our psy on (some) HDMI sticks
      MAINTAINERS: Add AXP288 PMIC entry
      power: supply: max17042_battery: Check battery current for status when supplied
      power: supply: max17042_battery: Always fall back to default platform-data

Jesse Chan (1):
      power: reset: zx-reboot: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Julia Lawall (2):
      power: supply: account for const type of of_device_id.data
      power: reset: account for const type of of_device_id.data

Mike Looijmans (1):
      power: ltc2941-battery-gauge: Disable continuous monitoring on shutdown

Pavel Machek (2):
      Add support for bq27521 battery monitor
      bq24190: Simplify code in property_is_writeable

Ryosuke Saito (1):
      power: supply: charger-manager: Fix typo in condition

Sebastian Reichel (1):
      Merge branch 'fixes' into for-next

 .../bindings/power/reset/imx-snvs-poweroff.txt     |  23 --
 .../devicetree/bindings/power/supply/bq27xxx.txt   |   1 +
 MAINTAINERS                                        |   6 +
 drivers/power/reset/Kconfig                        |   9 -
 drivers/power/reset/Makefile                       |   1 -
 drivers/power/reset/at91-sama5d2_shdwc.c           |   4 +-
 drivers/power/reset/imx-snvs-poweroff.c            |  66 -----
 drivers/power/reset/msm-poweroff.c                 |   7 +-
 drivers/power/reset/zx-reboot.c                    |   4 +
 drivers/power/supply/ab8500_charger.c              |   6 +-
 drivers/power/supply/axp20x_ac_power.c             |   8 +-
 drivers/power/supply/axp288_charger.c              | 290 +++++++++------------
 drivers/power/supply/axp288_fuel_gauge.c           | 203 +++++++++------
 drivers/power/supply/bq24190_charger.c             | 126 +--------
 drivers/power/supply/bq27xxx_battery.c             |  39 ++-
 drivers/power/supply/bq27xxx_battery_i2c.c         |   2 +
 drivers/power/supply/charger-manager.c             |   2 +-
 drivers/power/supply/cpcap-battery.c               |   4 +-
 drivers/power/supply/ltc2941-battery-gauge.c       |  25 ++
 drivers/power/supply/max17042_battery.c            |  54 +++-
 drivers/power/supply/sbs-manager.c                 |   2 +-
 include/linux/power/bq27xxx_battery.h              |   1 +
 22 files changed, 394 insertions(+), 489 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/imx-snvs-poweroff.txt
 delete mode 100644 drivers/power/reset/imx-snvs-poweroff.c

--bih3zmmmjmqduvbq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlpx3/kACgkQ2O7X88g7
+prlug//d8Do/6GhK8by/ZEQj9PoQN/I19JfFJq38Km4k+/EACgY9Ptth/Ykfo3X
/j69qqBtQYurnG3sD4WnlrjMjlxWLm6hbznyHNuGwZo/kw1UMGXzV4bwxu8i+JpN
kE00uqGU7uxKfQ0NXckzKsFJ4kC7fZik4OSLKkS2hOUfB+ALyoyEy6dvm37d5mMt
BK4ugL4QGzUE6BFH5P/E/DmJcBeUzkfEzq7NwfTkuitA3vUuCyXRk+EI8UxW05Ty
WvLhn2i6xBncrItEBeaoa1UiknCNx+qlRLmG/9egN0HfFJZZZ7fTXjtd0dlrxnae
u2X0B1VpoypaOKC2hNApxr/UOrPfQQNKS11H14xNOclX4yv7I6i8AgUbbPoSb7DO
P0y8qJwnzXhyD8xIJGuA0bRW90A7Lojd0kV3toFTde3InzlTnL5eoJY8l499MIvn
dt6x2J5CsyU2GLUvVJmVADcwHQfaHmLAxG/lMdApEghVE4qrGN6Te+MBc4YHWHE1
8v4MXP+SP+N9hohTeAHzATBnIarhmEpyoujVayOckPGX4qWeLLrJajWjjUUjIfpF
XMfiduhkWuLGtbsLaaNZvd58gbi7MMpIWBVxvqAnak73anTb4Wmk0xrpftCWrGcD
0ng1BUDNdX/K4Jn6k2jEKGO7rEWwReNwlDU9bmCV98giOlyNFAU=
=K0TO
-----END PGP SIGNATURE-----

--bih3zmmmjmqduvbq--
