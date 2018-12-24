Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01357C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50B02184A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545677934;
	bh=jWJRzuA0scQaq/Sef8uCJFttk6UtwumTnB0KjXP7X1A=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=E1jsGbASkvnh/H7glGNHGfskmp5FruZ8j3yL/YN6WonnwN3Z9LxsJ84Q2xDvB7zc7
	 sqEEDR0aykt/bEl8yubbhnER5lcaNPMV5JBmSORvp7TRixyl+fzxnvoYLP1gnfG84S
	 r8QB5bFKI9ib1KkWIQH2Rs+u6jFPNEPRjXzcnj8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbeLXS6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 13:58:53 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49604 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbeLXS6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 13:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1gJ/Uou1hIyY4qCiggNu+UpSSLjmZEyoi67Rmufoc0Q=; b=izmmCivRgAbnsR+vIsUKQfiok
        XlBQf97iIT44vBRo3CtQmXfWSA24GduTVSRg0NPfSdLHHpE5JjJ62rqJ3a99czYS9QOE/lICtENUZ
        Bk78EqxMsjzL11q8WuxR1gh9HJ0v7uUlIhYFMEaqnehIxG8X7+Mpak2+/hL7miEB7TWJU=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gbVRB-00076A-Ok; Mon, 24 Dec 2018 18:58:49 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id E8E3A440080; Mon, 24 Dec 2018 18:58:48 +0000 (GMT)
Date:   Mon, 24 Dec 2018 18:58:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] regulator updates for v4.21
Message-ID: <20181224185848.GA1846@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
X-Cookie: knowledge, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:

  Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v4.21

for you to fetch changes up to c3b5725965228014215de553eed3492dbd80a4bd:

  Merge remote-tracking branch 'regulator/topic/coupled' into regulator-next (2018-12-21 13:43:35 +0000)

----------------------------------------------------------------
regulator: Updates for v4.20

This has been a very busy release for the core, some fixes, one large new
feature and a big bit of refactoring to update the GPIO API:

 - Support for coupled regulators from Dmitry Osipenko based on a prior
   attempt by Maciej Purski, allowing us to handle situations where the
   voltages on two regulators can't be too far apart from each other.
 - Conversion of the GPIO support in both drivers and the core to use
   GPIO descriptors rather than numbers, part of the overall project to
   remove GPIO numbers.
 - Support for standby mode suspend states from Andrei Stefanescu.
 - New drivers for Allwinner AXP209, Cirrus Logic Lochnagar and
   Microchip MPC16502.

----------------------------------------------------------------
Adam Ford (1):
      regulator: pfuze100-regulator: add coin support to PF0100

Andrei.Stefanescu@microchip.com (7):
      regulator: dt-bindings: add regulator-state-standby bindings
      regulator: of: add support for parsing regulator-state-standby
      regulator: dt-bindings: add MCP16502 regulator bindings
      MAINTAINERS: add maintainer for MCP16502 PMIC driver
      regulator: mcp16502: add regulator driver for MCP16502
      regulator: mcp16502: add support for suspend
      regulator: mcp16502: code cleanup

Axel Lin (4):
      regulator: bd718x7: Use regulator_map_voltage_ascend for buck5 and buck7
      regulator: mcp16502: Use #ifdef CONFIG_PM_SLEEP around mcp16502_suspend/resume_noirq
      regulator: mcp16502: Fix missing n_voltages setting
      regulator: mcp16502: Select REGMAP_I2C to fix build error

Boris Brezillon (1):
      regulator: act8945a-regulator: Implement PM functionalities

Charles Keepax (6):
      regulator: lochnagar: Explicitly include register headers
      regulator: lochnagar: Move driver to binding from DT
      regulator: lochnagar: Add initial binding documentation
      regulator: wm8994: Don't use devres for enable GPIOs
      regulator: Factor out location of init data OF node
      regulator: Allow regulator nodes to contain their own init data

Claudiu Beznea (5):
      regulator: act8945a-regulator: unlock expert registers
      regulator: act8945a-regulator: fix line over 80 chars warning
      regulator: act8945a-regulator: add shutdown function
      regulator: add documentation for regulator modes and suspend states
      regulator: act8945a-regulator: fix 'defined but not used' compiler warning

Dmitry Osipenko (12):
      regulator: core: Mutually resolve regulators coupling
      regulator: core: Don't allow to get regulator until all couples resolved
      regulator: Change regulator-coupled-max-spread property
      regulator: core: Limit regulators coupling to a single couple
      regulator: Document new regulator-max-step-microvolt property
      regulator: core: Add new max_uV_step constraint
      regulator: core: Decouple regulators on regulator_unregister()
      regulator: core: Use ww_mutex for regulators locking
      regulator: core: Properly handle case where supply is the couple
      regulator: core: Keep regulators-list locked while traversing the list
      regulator: Change regulator-coupled-max-spread property
      regulator: core: Export regulator_lock and regulator_unlock

Douglas Anderson (6):
      regulator: core: Properly expose requested_microamps in sysfs
      regulator: core: Don't double-disable supplies in regulator_disable_deferred()
      regulator: core: Only count load for enabled consumers
      regulator: core: Avoid propagating to supplies when possible
      regulator: core: Apply system load even if no consumer loads
      regulator: core: Clean enabling always-on regulators + their supplies

Geert Uytterhoeven (1):
      regulator: bd718x7: Remove double indirection for bd718xx_pmic_inits.rdatas

Kangjie Lu (2):
      drivers/regulator: fix a missing check of return value
      regulator: tps65910: fix a missing check of return value

Kuninori Morimoto (2):
      regulator: bd9571mwv: convert to SPDX identifiers
      regulator: as3711: convert to SPDX identifiers

Linus Walleij (20):
      regulator: s2mps11: Pass descriptor instead of GPIO number
      regulator: wm8994: Pass descriptor instead of GPIO number
      regulator: max77686: Pass descriptor instead of GPIO number
      regulator: core: Track dangling GPIO descriptors
      regulator: fixed: Let core handle GPIO descriptor
      regulator: lm363x: Let core handle GPIO descriptor
      regulator: lp8788-ldo: Let core handle GPIO descriptor
      regulator: max8952: Let core handle GPIO descriptor
      gpio: Export gpiod_get_from_of_node()
      regulator: max77686: Let core handle GPIO descriptor
      gpio: Enable nonexclusive gpiods from DT nodes
      gpio: devres: Handle nonexclusive GPIOs
      gpio: Add devm_gpiod_unhinge()
      regulator: max8973: Let core handle GPIO descriptor
      regulator: da9211: Hand over GPIO to regulator core
      regulator: s5m8767: Hand over GPIO to regulator core
      regulator: tps65090: Hand over GPIO to regulator core
      regulator: s2mps11: Hand over GPIO to regulator core
      regulator: wm8994: Rely on core to handle GPIO descriptor
      regulator: arizona-ldo1: Rely on core to handle GPIO descriptor

Maciej Purski (2):
      regulator: core: Add voltage balancing mechanism
      regulator: core: Change voltage setting path

Marek Szyprowski (1):
      regulator: s2mps11: Fix GPIO descriptor initialization

Mark Brown (8):
      Merge branch 'topic/coupled' of https://git.kernel.org/.../broonie/regulator into regulator-4.21 for trivial conflict
      regulator: Fix return value of _set_load() stub
      Merge branch 'regulator-4.20' into regulator-linus
      Merge branch 'for-linus' of https://git.kernel.org/.../broonie/regulator into regulator-4.21
      Merge branch 'topic/axp20x' of https://git.kernel.org/.../broonie/regulator into regulator-4.21
      Merge branch 'regulator-4.20' into regulator-linus
      Merge branch 'regulator-4.21' into regulator-next
      Merge remote-tracking branch 'regulator/topic/coupled' into regulator-next

Matti Vaittinen (2):
      regulator: bd718x7: add missing linux/of.h inclusion (deja-vu)
      regulator: bd718x7: Change next state after poweroff to ready

Olliver Schinagl (10):
      regulator: core: enable power when setting up constraints
      regulator: axp20x: use defines for masks
      mfd: axp20x: name voltage ramping define properly
      regulator: axp20x: add support for set_ramp_delay for AXP209
      dt-bindings: mfd: axp20x: add support for regulator-ramp-delay for AXP209
      regulator: axp20x: add software based soft_start for AXP209 LDO3
      dt-bindings: mfd: axp20x: Add software based soft_start for AXP209 LDO3
      regulator: dts: enable soft-start and ramp delay for the OLinuXino Lime2
      mfd: axp20x: Clean up included headers
      mfd: axp20x: use explicit bit defines

Pascal PAILLET-LME (1):
      regulator: stpmic1: fix regulator_lock usage

Priit Laes (1):
      regulator: axp20x: fix set_ramp_delay for AXP209/dcdc2

Rob Herring (1):
      regulator: Use of_node_name_eq for node name comparisons

Ryan Case (1):
      spi: spi-qcom-qspi: Fix remaining driver nits

Wei Yongjun (1):
      regulator: act8945a-regulator: make symbol act8945a_pm static

Yangtao Li (1):
      regulator: convert to DEFINE_SHOW_ATTRIBUTE

zoro (1):
      regulator/of_get_regulator: add child path to find the regulator supplier

 Documentation/devicetree/bindings/mfd/axp20x.txt   |    9 +
 .../bindings/regulator/act8945a-regulator.txt      |   34 +
 .../bindings/regulator/cirrus,lochnagar.txt        |   82 ++
 .../bindings/regulator/mcp16502-regulator.txt      |  143 +++
 .../devicetree/bindings/regulator/regulator.txt    |   12 +-
 Documentation/driver-model/devres.txt              |    1 +
 MAINTAINERS                                        |    7 +
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts    |    2 +
 arch/arm/mach-s3c64xx/mach-crag6410-module.c       |   17 +-
 drivers/gpio/gpiolib-devres.c                      |   80 +-
 drivers/gpio/gpiolib.c                             |    2 +
 drivers/gpio/gpiolib.h                             |    6 -
 drivers/mfd/axp20x.c                               |   13 +-
 drivers/mfd/wm8994-core.c                          |    9 -
 drivers/regulator/88pm8607.c                       |    2 +-
 drivers/regulator/Kconfig                          |   10 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/act8945a-regulator.c             |  205 +++-
 drivers/regulator/arizona-ldo1.c                   |    3 -
 drivers/regulator/as3711-regulator.c               |    5 +-
 drivers/regulator/axp20x-regulator.c               |  876 +++++++++++---
 drivers/regulator/bd718x7-regulator.c              |   33 +-
 drivers/regulator/bd9571mwv-regulator.c            |   10 +-
 drivers/regulator/core.c                           | 1199 ++++++++++++++++----
 drivers/regulator/da9052-regulator.c               |    2 +-
 drivers/regulator/da9210-regulator.c               |    4 +-
 drivers/regulator/da9211-regulator.c               |    6 +
 drivers/regulator/dbx500-prcmu.c                   |   35 +-
 drivers/regulator/fixed.c                          |    6 +-
 drivers/regulator/internal.h                       |    2 +
 drivers/regulator/lm363x-regulator.c               |    8 +-
 drivers/regulator/lochnagar-regulator.c            |   50 +-
 drivers/regulator/lp8788-ldo.c                     |    8 +-
 drivers/regulator/max77686-regulator.c             |   29 +-
 drivers/regulator/max8952.c                        |   10 +-
 drivers/regulator/max8973-regulator.c              |    8 +-
 drivers/regulator/max8997-regulator.c              |    2 +-
 drivers/regulator/mc13xxx-regulator-core.c         |    2 +-
 drivers/regulator/mcp16502.c                       |  552 +++++++++
 drivers/regulator/of_regulator.c                   |   81 +-
 drivers/regulator/palmas-regulator.c               |    5 +-
 drivers/regulator/pfuze100-regulator.c             |    2 +
 drivers/regulator/qcom-rpmh-regulator.c            |    2 +-
 drivers/regulator/s2mps11.c                        |   54 +-
 drivers/regulator/s5m8767.c                        |   11 +-
 drivers/regulator/stpmic1_regulator.c              |    4 +-
 drivers/regulator/tps65090-regulator.c             |    6 +
 drivers/regulator/tps65910-regulator.c             |    4 +-
 drivers/regulator/wm8350-regulator.c               |    4 +-
 drivers/regulator/wm8994-regulator.c               |   33 +-
 drivers/spi/spi-qcom-qspi.c                        |    8 +-
 .../regulator/active-semi,8945a-regulator.h        |   30 +
 include/linux/gpio/consumer.h                      |   23 +
 include/linux/mfd/axp20x.h                         |    4 +-
 include/linux/mfd/wm8994/pdata.h                   |    3 -
 include/linux/regulator/consumer.h                 |    2 +-
 include/linux/regulator/driver.h                   |    9 +-
 include/linux/regulator/machine.h                  |    3 +
 include/linux/regulator/pfuze100.h                 |    3 +-
 59 files changed, 3141 insertions(+), 635 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
 create mode 100644 drivers/regulator/mcp16502.c
 create mode 100644 include/dt-bindings/regulator/active-semi,8945a-regulator.h

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwhLGgACgkQJNaLcl1U
h9CYJAf/QpPM4odibMuF8bZpDOPc9GyknRLUZ/LkHCc5aeZpGBxmAKx2yiZXtmQZ
0rfElXmLR1t2qbCQCnb5G5cdhBg6HmOHUdTYhuj8ds2u9Fm7+q5a4/zbgMDWoxlB
iQBcWPsZ2JC+nv+bOIyjuleLz3l4GtggLKxccrNyQLV3BirIgGWDUwvFN/ghendX
fUf+2/uGhnHR8NMmpq8NBNC1RIk6cxbghWkDZRphxrU9gShHB+7LnMfJmJXsVNrw
UestAtn0qIjIYhidqkDxs8sJBm5eNV/EZCIEKKXElIhCEZ6yKgmNbM9XWJArxm8M
BvYacoDdTVZQU7JtnRTf8vDCdRei3Q==
=F5HL
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
