Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeDBRrW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 13:47:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752900AbeDBRrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 13:47:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BD92178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Mon, 2 Apr 2018 19:47:17 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 4.17
Message-ID: <20180402174717.4amt2b6doeewzrch@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cdmmkdptx3slpbm7"
Content-Disposition: inline
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cdmmkdptx3slpbm7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The pull request has one devicetree change for the Nokia N900,
that has been Acked-by Tony Lindgren. All patches have been in
linux-next for 3 weeks without any problems reported to me.

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v4.17

for you to fetch changes up to fd73a3e618889877d32e338622a363d04d9be709:

  power: reset: at91-reset: Switch from the pr_*() to the dev_*() logging functions (2018-03-19 20:51:17 +0100)

----------------------------------------------------------------
power supply and reset changes for the v4.17 series

* Microsemi Ocelot reset support
* Spreadtrum SC27xx reset support
* generic gpio charger: lot's of cleanups
* axp20x fuel gauge: add AXP813 support
* misc. fixes

----------------------------------------------------------------
Alexandre Belloni (2):
      dt-bindings: power: reset: Document ocelot-reset binding
      power: reset: Add a driver for the Microsemi Ocelot reset

Baolin Wang (1):
      power: reset: Add Spreadtrum SC27xx PMIC power off support

Carlo Caione (1):
      power: supply: axp288_fuel_gauge: Do not register FG on ECS EF20EA

Colin Ian King (1):
      power: reset: make function sc27xx_poweroff_shutdown static

Gustavo A. R. Silva (1):
      power: supply: da9150-fg: remove VLA usage

Hans de Goede (1):
      power: supply: axp288_fuel_gauge: Fix full status reporting

Ladislav Michl (10):
      power: supply: ltc2941-battery-gauge: Add charge empty and full properties
      power: supply: gpio-charger: Drop driver remove function
      power: supply: gpio-charger: use helper variable to access device info
      power: supply: ltc2941-battery-gauge: Fix temperature units
      power: supply: gpio-charger: Remove redundant dev_err call in probe function
      power: supply: gpio-charger: Use GPIOF_ACTIVE_LOW for legacy setup
      power: supply: gpio-charger: Remove pdata from gpio_charger
      power: reset: at91-poweroff: Switch from the pr_*() to the dev_*() logging functions
      power: reset: at91-poweroff: Remove redundant dev_err call in at91_poweroff_probe()
      power: reset: at91-reset: Switch from the pr_*() to the dev_*() logging functions

Linus Walleij (1):
      power: gemini-poweroff: Avoid spurious poweroff

Moritz Fischer (2):
      dt-bindings: power: reset: gpio-poweroff: Add 'timeout-ms' property
      power: reset: gpio-poweroff: Support for timeout from device property

Pierre Bourdon (1):
      max17042: propagate of_node to power supply device

Quentin Schulz (3):
      power: supply: axp20x_battery: use data struct for variant specific code
      dt-bindings: power: supply: axp20x: add AXP813 battery DT binding
      power: supply: axp20x_battery: add support for AXP813

Sebastian Reichel (4):
      power: supply: bq27xxx: support missing supplier device
      power: supply: bq2415x: add DT referencing support
      ARM: dts: omap3-n900: Add link between battery and charger
      Merge branch 'fixes' into for-next

 .../bindings/power/reset/gpio-poweroff.txt         |   3 +
 .../bindings/power/reset/ocelot-reset.txt          |  14 ++
 .../bindings/power/supply/axp20x_battery.txt       |   8 +-
 arch/arm/boot/dts/omap3-n900.dts                   |   1 +
 drivers/power/reset/Kconfig                        |  16 ++
 drivers/power/reset/Makefile                       |   2 +
 drivers/power/reset/at91-poweroff.c                |  14 +-
 drivers/power/reset/at91-reset.c                   |   4 +-
 drivers/power/reset/gemini-poweroff.c              |  30 ++--
 drivers/power/reset/gpio-poweroff.c                |   8 +-
 drivers/power/reset/ocelot-reset.c                 |  88 ++++++++++
 drivers/power/reset/sc27xx-poweroff.c              |  66 ++++++++
 drivers/power/supply/axp20x_battery.c              | 136 ++++++++++++----
 drivers/power/supply/axp288_fuel_gauge.c           |  53 ++++--
 drivers/power/supply/bq2415x_charger.c             |   5 +-
 drivers/power/supply/bq27xxx_battery.c             |   2 +-
 drivers/power/supply/da9150-fg.c                   |   4 +-
 drivers/power/supply/gpio-charger.c                | 179 ++++++++-------------
 drivers/power/supply/ltc2941-battery-gauge.c       |  67 ++++++--
 drivers/power/supply/max17042_battery.c            |   1 +
 20 files changed, 500 insertions(+), 201 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
 create mode 100644 drivers/power/reset/ocelot-reset.c
 create mode 100644 drivers/power/reset/sc27xx-poweroff.c

--cdmmkdptx3slpbm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrCbJkACgkQ2O7X88g7
+poDPg/9GCX/bapKN7lKFgO8JrJPyGXcGhqmmkv0S+nr0+Idubd5R1oCH2xOyPKW
o+nf/WysdsUq9n16bu2srxYVAQIL5nQsteZA+VCLE2rAukjWPtXtSEs6+Xw1ahX+
R0A9oFAH7AwveNQ6Q3SsaRAbL5rdCmc4tHSERddApvM1FvZWjFc3Laiq37A0xhPr
D5NePFk/NvyeDIXTSxM10Aap7BSOIEFQ8ptihgCEOYlhRmM1PqHz9/QrR+ICsaAO
vVapjL/yBdc/vbUf27Qi3YnIe9z1YKELB4NSFY+uRzkeNfBrxWMH+THR4xTcu+CQ
Rb8TBdq0Xm1BRRVZ9/yVizZo+Gexi0I/P2NXKHAIwxMKmxy9QxN8FA815RfQQURy
WyJni4Y90cnql0iOfyNogukc8RdLNfLW+qYoqz9od1DKeZGeK0vKGMIdWRRO3/P4
NJSzbqzDI80VnFbL3fwOImIzGs2Qy1J7LgPF6QI8CC+e4ne/TvkDYfXBFaKMblSg
A36O84YzPuLL50cGZ6wN7wVn7wjuYBls4XQPs0waOyE4xHp+n366U+RQSlbTicNF
NDjgHmHHwZYV9cKOOdVIk+qNZ3Zzt0WCTVJoyVnkzryc4mbDbayYH5v7taH7zmHi
Xn0ZBrgAuTihyb66OXjkiPXG9QsqeO7XE250RsCdDwQnHR48vVM=
=7cEE
-----END PGP SIGNATURE-----

--cdmmkdptx3slpbm7--
