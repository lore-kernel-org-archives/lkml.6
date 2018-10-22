Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5CFC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDDE20658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="wSqu0qz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDDE20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeJVVZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 17:25:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42660 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbeJVVZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 17:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5mLeJtshy09INjfD5za9ldyyFtYB3wpNa0V4Y/sSNRk=; b=wSqu0qz26k10Sp/xz+JrKgNd/
        NkVae5CZ/puxgb/Usc+568vyWMNDO4XsPz+RdUH7N2fIJSudJtf9t6UEg09rNtY0jM6XU8aJL4yll
        /mo3Gk96Hmj7A6sDR40zbiI+NNWLnnBMgXtNdD22c0PVCsDNHmXng+km1tnnXf5h+5kIY=;
Received: from [167.98.65.38] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gEZvN-0006CL-Hn; Mon, 22 Oct 2018 13:07:13 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id CA5A2440078; Mon, 22 Oct 2018 15:07:12 +0200 (CEST)
Date:   Mon, 22 Oct 2018 14:07:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] regulator updates for the next release
Message-ID: <20181022130712.GE2103@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jKBxcB1XkHIR0Eqt"
Content-Disposition: inline
X-Cookie: Piece of cake!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 35a7f35ad1b150ddf59a41dcac7b2fa32982be0e:

  Linux 4.19-rc8 (2018-10-15 07:20:24 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.0

for you to fetch changes up to f35b1e53a66ab06e6d04cdff96f686e8b88959ef:

  Merge remote-tracking branches 'regulator/topic/bd718xx' and 'regulator/topic/pfuze100' into regulator-next (2018-10-21 17:00:05 +0100)

----------------------------------------------------------------
regulator: Regulator updates for next release

The biggest chunk of the regulator changes for this release outside of
the new drivers is the conversion of the fixed regulator to use the GPIO
descriptor API, there's a small addition to the GPIO API plus a bunch of
updates to board files to implement it.  This is some really welcome
work from Linus Walleij that's had a bunch of review and has been
sitting in -next for a while so I'm fairly happy there's no major
issues.

 - Helpers for overlapping linear ranges.
 - Display opmode and consumer requested load in the regualtor_summary
   file in debugfs, plus a fix there.
 - Support for the fun and entertaining power off mechanism that the
   pfuze100 hardware implements.
 - Conversion of the fixed regulator API to use GPIO descriptors,
   including pulling in a bunch of patches to a bunch of board files.
 - New drivers for Cirrus Logic Lochnagar, Qualcomm PMS405, Rohm
   BD71847, ST PMIC1, and TI LM363x devices.

----------------------------------------------------------------
Axel Lin (4):
      regulator: isl9305: Add missing .owner field in regulator_desc
      regulator: bd71837: Remove duplicate assignment for n_voltages of LDO2
      regulator: stpmic1: Return REGULATOR_MODE_INVALID for invalid mode
      regulator: bd718x7: Remove struct bd718xx_pmic

Bjorn Andersson (1):
      regulator: qcom: Add PMS405 regulators

Charles Keepax (2):
      regulator: lochnagar: Add support for the Cirrus Logic Lochnagar
      regulator: lochnagar: Use a consisent comment style for SPDX header

Colin Ian King (1):
      regulator: pfuze100-regulator: fix spelling mistake "standy" -> "standby"

Douglas Anderson (4):
      regulator: core: Add the opmode to regulator_summary
      regulator: core: Add consumer-requested load in regulator_summary
      regulator: core: Add locking to debugfs regulator_summary
      regulator: qcom-rpmh: Add stylistic breaks in the default cases

Gustavo A. R. Silva (1):
      regulator: axp20x: Mark expected switch fall-throughs

Linus Walleij (4):
      regulator: fixed: Convert to use GPIO descriptor only
      regulator: fixed: Default enable high on DT regulators
      regulator/gpio: Allow nonexclusive GPIO access
      regulator: Fetch enable gpiods nonexclusive

Marek Szyprowski (1):
      regulator: Fix useless O^2 complexity in suspend/resume

Mark Brown (4):
      Merge tag 'regulator-v4.19-rc5' into regulator-bd718xx
      Merge tag 'bd71847-support' into regulator-4.20
      Merge branch 'regulator-4.20' into regulator-next
      Merge remote-tracking branches 'regulator/topic/bd718xx' and 'regulator/topic/pfuze100' into regulator-next

Matti Vaittinen (10):
      regulator: regmap helpers - support overlapping linear ranges
      regulator: bd718x7: add missing linux/of.h inclusion
      regulator/mfd: Support ROHM BD71847 power management IC
      regulator: dt bindings: add BD71847 device-tree binding documentation
      mfd: dt bindings: add BD71847 device-tree binding documentation
      regulator: Support regulators where voltage ranges are selectable
      regulator/mfd: bd718xx: rename bd71837/bd71847 common instances
      regulator: bd718XX use pickable ranges
      regulator: bd718xx: rename bd71837 to 718xx
      regulator: bd718xx: fix build warning on x86_64

Nathan Chancellor (1):
      regulator: da905{2,5}: Remove unnecessary array check

Oleksij Rempel (3):
      kernel/reboot.c: export pm_power_off_prepare
      regulator: pfuze100: add fsl,pmic-stby-poweroff property
      regulator: pfuze100-regulator: provide pm_power_off_prepare handler

Randy Dunlap (1):
      regulator: fix kernel-doc for regulator_suspend()

Rob Herring (1):
      regulator: Convert to using %pOFn instead of device_node.name

pascal paillet (2):
      dt-bindings: regulator: document stpmic1 pmic regulators
      regulator: stpmic1: add stpmic1 regulator driver

 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  |   17 +-
 .../devicetree/bindings/regulator/pfuze100.txt     |    5 +
 .../bindings/regulator/qcom,smd-rpm-regulator.txt  |   23 +
 .../bindings/regulator/rohm,bd71837-regulator.txt  |   12 +-
 .../bindings/regulator/st,stpmic1-regulator.txt    |   68 ++
 arch/arm/mach-imx/mach-mx21ads.c                   |   12 +-
 arch/arm/mach-imx/mach-mx27ads.c                   |   12 +-
 arch/arm/mach-mmp/brownstone.c                     |   12 +-
 arch/arm/mach-omap1/board-ams-delta.c              |   12 +-
 arch/arm/mach-omap2/pdata-quirks.c                 |   16 +-
 arch/arm/mach-pxa/em-x270.c                        |    1 -
 arch/arm/mach-pxa/ezx.c                            |   33 +-
 arch/arm/mach-pxa/magician.c                       |    2 +-
 arch/arm/mach-pxa/raumfeld.c                       |   12 +-
 arch/arm/mach-pxa/zeus.c                           |   23 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    1 -
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    1 -
 arch/arm/mach-sa1100/assabet.c                     |   21 +-
 arch/arm/mach-sa1100/generic.c                     |    5 +-
 arch/arm/mach-sa1100/generic.h                     |    3 +-
 arch/arm/mach-sa1100/shannon.c                     |    4 +-
 arch/sh/boards/mach-ecovec24/setup.c               |   27 +-
 .../intel-mid/device_libs/platform_bcm43xx.c       |   17 +-
 drivers/gpio/gpiolib.c                             |   19 +-
 drivers/mfd/rohm-bd718x7.c                         |  162 ++-
 drivers/regulator/Kconfig                          |   21 +-
 drivers/regulator/Makefile                         |    4 +-
 drivers/regulator/arizona-ldo1.c                   |    2 +-
 drivers/regulator/axp20x-regulator.c               |    3 +-
 drivers/regulator/bd71837-regulator.c              |  645 -----------
 drivers/regulator/bd718x7-regulator.c              | 1119 ++++++++++++++++++++
 drivers/regulator/core.c                           |  124 +--
 drivers/regulator/da9052-regulator.c               |    2 +-
 drivers/regulator/da9055-regulator.c               |    2 +-
 drivers/regulator/da9211-regulator.c               |   10 +-
 drivers/regulator/fixed-helper.c                   |    1 -
 drivers/regulator/fixed.c                          |   57 +-
 drivers/regulator/helpers.c                        |  243 ++++-
 drivers/regulator/isl9305.c                        |    4 +
 drivers/regulator/lm363x-regulator.c               |    6 +-
 drivers/regulator/lochnagar-regulator.c            |  254 +++++
 drivers/regulator/lp8788-ldo.c                     |    7 +-
 drivers/regulator/max8952.c                        |    1 +
 drivers/regulator/max8973-regulator.c              |    1 +
 drivers/regulator/max8997-regulator.c              |    4 +-
 drivers/regulator/mc13xxx-regulator-core.c         |    2 +-
 drivers/regulator/of_regulator.c                   |   44 +-
 drivers/regulator/pfuze100-regulator.c             |   91 ++
 drivers/regulator/qcom-rpmh-regulator.c            |   17 +-
 drivers/regulator/qcom_smd-regulator.c             |   77 ++
 drivers/regulator/s5m8767.c                        |   25 +-
 drivers/regulator/stpmic1_regulator.c              |  674 ++++++++++++
 drivers/regulator/tps65090-regulator.c             |    1 +
 include/linux/gpio/consumer.h                      |    1 +
 include/linux/mfd/rohm-bd718x7.h                   |  331 +++---
 include/linux/regulator/driver.h                   |   20 +-
 include/linux/regulator/fixed.h                    |    3 -
 kernel/reboot.c                                    |    1 +
 58 files changed, 3205 insertions(+), 1112 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
 delete mode 100644 drivers/regulator/bd71837-regulator.c
 create mode 100644 drivers/regulator/bd718x7-regulator.c
 create mode 100644 drivers/regulator/lochnagar-regulator.c
 create mode 100644 drivers/regulator/stpmic1_regulator.c

--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvNy38ACgkQJNaLcl1U
h9A/9wf+PeGgEcJ3ZIOrzVIVX/S0dpAFZyf67ZWtV+50nKyKuIHNCuv4l3jl9a8f
RizA+pwquJBfWZPBfI1C8qo4dA0fceTfJ1+Ab2ODLhPlYZDLXntz3I7dQhPe1Mo6
OKtO2Rv2NBOvH8yQMIvX8ioLAZUM1zvbLZnhj/DTqBdWdAQDo4WbIDchxLH0bSOH
OE+En4hsP8pBjaOyUSRCN02W/2BvZHq6RQG7Hl6iCFeGdrYoaCNvp9mJgCvK6Req
FeDssz22WvL3XBrwuJPGvWbTOzLKSKH5wXVVEgry3V0Ub/zP+pqHmb7jY+EOnGzK
thXuja59IVq5WWkqa17J+JZpDa3Hhw==
=ej8e
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--
