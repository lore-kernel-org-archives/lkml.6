Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FD2C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 23:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A6E2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 23:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="grYQtJSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A6E2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeHVDHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 23:07:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbeHVDHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 23:07:30 -0400
Received: from mail.kernel.org (unknown [185.216.33.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5B302098B;
        Tue, 21 Aug 2018 23:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534895113;
        bh=I0BU8w9Z2Yf01AZwXAR1v7yXH6p4Egdom0VSzru1O1o=;
        h=Date:From:To:Cc:Subject:From;
        b=grYQtJSapQcwll+Y39rrZvWWMK3YAN66Az0aNkOcClYWWZy1SCV2xzxUQAg6QD7jY
         ul27+g3PU+G32/5AyxpSURh7RcDILE+kxJWuB3JuGAg6uXnA9Fws09x0AkvGiOoS3Z
         JN0G/6zGu4u0vJs/i5n9+D2BqSeZKiXQmwsiu85A=
Date:   Wed, 22 Aug 2018 01:45:10 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 4.19
Message-ID: <20180821234510.dpoycz5uffigz7ul@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kwafn5acwuscsjxi"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kwafn5acwuscsjxi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

I was too busy for reviewing patches the last few weeks, so
everything has been in linux-next for a multiple weeks (except
for some fixes, that I initially planned to send for 4.18-rc,
but even those have been in -next for some time now). Stephen
Rothwell noticed a merge conflict in MAINTAINERS file, should
be trivial to figure out.

-- Sebastian

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v4.19

for you to fetch changes up to 5198a48381455969aa1053a0ca2e4ce409be2fc2:

  Merge branch 'psy-fixes' into psy-next (2018-08-16 22:19:22 +0200)

----------------------------------------------------------------
power supply and reset changes for the v4.19 series

* Improve support for TI bq20z75 in sbs-battery
* Add Qualcomm PM8xxx reboot driver
* Add cros-ec USBPD charger driver
* Add adp5061 battery driver
* Move ds2760 battery driver from w1 to power-supply and add DT support
* Misc. fixes

----------------------------------------------------------------
Alexey Khoroshilov (1):
      power: reset: zx-reboot: put device node in zx_reboot_probe()

Arnd Bergmann (1):
      power: supply: ab8500: stop using getnstimeofday64()

Benjamin Tissoires (1):
      power: remove possible deadlock when unregistering power_supply

Brian Norris (2):
      power: supply: sbs-battery: don't assume MANUFACTURER_DATA formats
      dt-bindings: power: sbs-battery: re-document "ti,bq20z75"

Colin Ian King (1):
      power: supply: max1721x: fix spelling mistake "RSenese" -> "RSense"

Dan Carpenter (1):
      power: supply: adp5061: Fix a couple off by ones

Daniel Mack (5):
      dt-bindings: w1: document generic onewire bindings
      dt-bindings: w1: document bindings for ds2760 battery monitor
      w1: core: match sub-nodes of bus masters in devicetree
      power: supply: ds2760_battery: merge ds2760 supply driver with its w1 slave companion
      power: supply: ds2760_battery: add devicetree probing

David Lechner (2):
      power: supply: lego_ev3_battery: Don't ignore iio_read_channel_processed() return value
      power: supply: lego_ev3_battery: fix Vce offset

Enric Balletbo i Serra (2):
      power: supply: tps65217: Switch to SPDX identifier.
      mfd: cros_ec_dev: Register cros_usbpd-charger driver as a subdevice.

Gustavo A. R. Silva (2):
      power: supply: mark expected switch fall-throughs
      power: supply: max77693_charger: fix unintentional fall-through

H. Nikolaus Schaller (2):
      power: generic-adc-battery: fix out-of-bounds write when copying channel properties
      power: generic-adc-battery: check for duplicate properties copied from iio channels

Hans de Goede (1):
      power: supply: axp288_charger: Fix initial constant_charge_current value

Linus Walleij (1):
      power: gemini-poweroff: Avoid more spurious poweroffs

Liu Xiang (1):
      power: supply: bq27xxx: Update comments

Sameer Nanda (2):
      mfd: cros_ec: Add USBPD charger commands and struct definitions.
      power: supply: add cros-ec USBPD charger driver.

Sebastian Reichel (3):
      Merge tag 'ib-mfd-v4.19' into psy-next
      Merge tag 'ds2760-for-v4.19-signed' into psy-next
      Merge branch 'psy-fixes' into psy-next

Stefan Popa (1):
      adp5061: New driver for ADP5061 I2C battery charger

Sudeep Holla (1):
      power: vexpress: fix corruption in notifier registration

Vinod Koul (3):
      dt-bindings: power: reset: Add qcom pon binding
      power: reset: qcom-pon: Add Qcom PON driver
      dt-bindings: power: reset: qcom: Add resin binding

 .../bindings/input/qcom,pm8941-pwrkey.txt          |   1 +
 .../devicetree/bindings/power/reset/qcom,pon.txt   |  45 ++
 .../bindings/power/supply/maxim,ds2760.txt         |  26 +
 .../bindings/power/supply/sbs_sbs-battery.txt      |  12 +-
 Documentation/devicetree/bindings/w1/w1-gpio.txt   |  11 +-
 Documentation/devicetree/bindings/w1/w1.txt        |  25 +
 MAINTAINERS                                        |   7 +
 drivers/mfd/cros_ec_dev.c                          |  16 +
 drivers/power/reset/Kconfig                        |  11 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/gemini-poweroff.c              |  12 +-
 drivers/power/reset/qcom-pon.c                     |  91 +++
 drivers/power/reset/vexpress-poweroff.c            |  12 +-
 drivers/power/reset/zx-reboot.c                    |   1 +
 drivers/power/supply/Kconfig                       |  23 +-
 drivers/power/supply/Makefile                      |   2 +
 drivers/power/supply/ab8500_fg.c                   |  14 +-
 drivers/power/supply/adp5061.c                     | 745 +++++++++++++++++++++
 drivers/power/supply/axp20x_usb_power.c            |   1 +
 drivers/power/supply/axp288_charger.c              |   2 +-
 drivers/power/supply/bq27xxx_battery.c             |   3 +-
 drivers/power/supply/cros_usbpd-charger.c          | 545 +++++++++++++++
 drivers/power/supply/ds2760_battery.c              | 348 +++++++---
 drivers/power/supply/generic-adc-battery.c         |  25 +-
 drivers/power/supply/lego_ev3_battery.c            |  20 +-
 drivers/power/supply/max1721x_battery.c            |   2 +-
 drivers/power/supply/max77693_charger.c            |   1 +
 drivers/power/supply/power_supply_core.c           |  11 +-
 drivers/power/supply/sbs-battery.c                 |  67 +-
 drivers/power/supply/tps65217_charger.c            |  22 +-
 drivers/power/supply/wm8350_power.c                |   3 +-
 drivers/w1/slaves/Kconfig                          |  12 -
 drivers/w1/slaves/Makefile                         |   1 -
 drivers/w1/slaves/w1_ds2760.c                      | 175 -----
 drivers/w1/slaves/w1_ds2760.h                      |  59 --
 drivers/w1/w1.c                                    |   3 +
 include/linux/mfd/cros_ec_commands.h               | 132 +++-
 include/linux/power_supply.h                       |   1 +
 include/linux/w1.h                                 |   2 +
 39 files changed, 2077 insertions(+), 413 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/qcom,pon.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt
 create mode 100644 Documentation/devicetree/bindings/w1/w1.txt
 create mode 100644 drivers/power/reset/qcom-pon.c
 create mode 100644 drivers/power/supply/adp5061.c
 create mode 100644 drivers/power/supply/cros_usbpd-charger.c
 delete mode 100644 drivers/w1/slaves/w1_ds2760.c
 delete mode 100644 drivers/w1/slaves/w1_ds2760.h

--kwafn5acwuscsjxi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlt8pAMACgkQ2O7X88g7
+poBnw/+O8MoiTHGdPbXXoN5Y6ua3V8lGXDY7B7Fjj7gA3OimABtVATIo4ZoulS1
ORJOxDVK4LEx3aAtfTtFySi13HcoEKHRoIA2O2Ym/XbNtyIB6Zw7ZxMPxP9doP9T
ubBLrzGr96aXnmJ7nfaHey3NJRXqUIrOojLxpxngm8lV2g6rTT3xZeFJL9KltJkb
1eurhVEnBeN4Ethiy2MtiFjTJaVa8BGFc+lhtlqxU7JBfehQZFnt0n9wr7+IfO/A
fnOWlgvQAwiy5QUIQ0LVYSk9/MOOqZHX2e1ciMxMcjutHqvoyGzP3dheU25ReRSU
Lo/7KoW0/bR0KhVqQF1whCbrDglFrN5YYfeVfCZijWW6cvwMEdgaeMUtGhmaNjBV
qpUAbe/Rsjmp6/MX1wH74HeorqgVNgs09J+Mfj97bDlGR70ZD5wHpPvPygVzfNug
H8xBl1Sz8p7HDbTriT636VNZVh4evhb6mC5NOmKNvefYiDVFb2Sv3jrqK7SPlMha
pAQ51UOi8UYlwcJDB4CQ4fKSwuOxAKyewhx8nc7ZjJ2fUcHkzAeA6EcI0lNnQixG
yEa+0xmoEN4V1YQqU43F65hQUfzM63Jakc8Vn6QXEHYKcp6jFMiIWmLDLkz7Yd9c
NnwJ6kdbq3GxZD7ZJ+4tU/BvGn8cr6f3duKE2fiBD53vAmMBhtI=
=xGpU
-----END PGP SIGNATURE-----

--kwafn5acwuscsjxi--
