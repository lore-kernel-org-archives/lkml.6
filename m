Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vNJxEqzXGlv3SgAAmS7hNA
	; Fri, 08 Jun 2018 19:23:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2F931607DC; Fri,  8 Jun 2018 19:23:24 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="SvApyw3T"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3F3E0605A5;
	Fri,  8 Jun 2018 19:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F3E0605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752969AbeFHTXU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 15:23:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57592 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752775AbeFHTXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 15:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2so2QA0nacOOW1HlcNktgtB3gCSCLQsoIyNdd5888Bg=; b=SvApyw3T0rW+AK2TzCCW2EKgO
        hDNgC4wUpPjNWG+5dlGJYPD/u+rpegEfs1Abu2sizqmJSSIHN2NswVKnGMnuPS5ibVViNk4oAm8Fb
        2Kgk3Jup9Jl/0/dR320K1xVxQeo5F7zEGsCOy+2zIozJHZeFvlfkuUK+jnSIomXcg+wSI=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fRMyh-0004Uy-Fk; Fri, 08 Jun 2018 19:23:15 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fRMyg-0004xw-CM; Fri, 08 Jun 2018 20:23:14 +0100
Date: Fri, 8 Jun 2018 20:23:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, lgirdwood@gmail.com
Subject: [GIT PULL] regulator updates for v4.18
Message-ID: <20180608192314.GA8616@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
X-Cookie: It is your destiny.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tag=
s/regulator-v4.18

for you to fetch changes up to 13ed4964057e5ad183da9f7f8160841d261e9517:

  Merge branch 'regulator-4.17' into regulator-4.18 merge window (2018-06-0=
8 16:27:56 +0100)

----------------------------------------------------------------
regulator: Updates for v4.18

Quite a lot of core work this time around, though not 100% successful.

We gained support for runtime mode changes thanks to David Collins and
improved support for write only regulators (ones where we can't read
back the configuration) from Douglas Anderson.

There's been quite a bit of work from Linus Walleij on converting from
specfying GPIOs by numbers to descriptors.  Sadly the testing turned out
to be less good than we had hoped and so a lot of this had to be
reverted.

We also have the start of updates to use coupled regulators from Maciej
Purski, unfortunately there are further problems there so the last
couple of patches have been reverted.

We also have new drivers for BD71837 and SY8106A devices, SAW regulators
on Qualcomm SPMI and dropped support for some preproduction chips
that never made it to market from the AB8500 driver.

----------------------------------------------------------------

Probably also worth pointing out that the MFD changes come from Linus'
descriptor refactoring.

Anson Huang (3):
      regulator: pfuze100: update voltage setting for pfuze3000 sw1a
      regulator: pfuze100: add enable/disable for switch
      regulator: pfuze100: add .is_enable() for pfuze100_swb_regulator_ops

Arnd Bergmann (1):
      ARM: pxa, regulator: fix building ezx e680

Changbin Du (1):
      regulator: add dummy function of_find_regulator_by_node

Colin Ian King (1):
      regulator: wm8350: fix missing increment of loop index i

David Collins (2):
      regulator: of: add property for allowed modes specification
      regulator: of: add support for allowed modes configuration

Douglas Anderson (2):
      regulator: Don't return or expect -errno from of_map_mode()
      regulator: core: Allow for regulators that can't be read at bootup

Fabio Estevam (6):
      regulator: pfuze100: Make the node name generic
      regulator: pfuze100: Switch to SPDX identifier
      regulator: anatop: Switch to SPDX identifier
      regulator: mc13783: Switch to SPDX identifier
      regulator: mc13892: Switch to SPDX identifier
      regulator: mc13xxx-core: Switch to SPDX identifier

Geert Uytterhoeven (4):
      dt-bindings: mfd: bd9571mwv: Document DDR Backup Mode properties
      mfd: bd9571mwv: Add DDR Backup Power register bit definitions
      mfd: bd9571mwv: Allow DDR Backup Power register access
      regulator: bd9571mwv: Add support for backup mode

Ilia Lin (2):
      regulator: qcom_spmi: Add support for SAW
      dt-bindings: qcom_spmi: Document SAW support

Jagan Teki (1):
      regulator: axp20x: add drivevbus support for axp803

Keerthy (2):
      regulator: lp87565: Add margin while populating ramp_delay
      regulator: lp87565: Enable LP87565_BUCK_CTRL_1_FPWM_MP_0_2

Linus Walleij (14):
      regulator: ab8500: Drop AB8540/9540 support
      regulator: arizona-ldo1: Look up a descriptor and pass to the core
      regulator: max77686: Pass descriptor instead of GPIO number
      regulator: s2mps11: Pass descriptor instead of GPIO number
      regulator: wm8994: Pass descriptor instead of GPIO number
      regulator: max8973: Pass descriptor instead of GPIO number
      regulator: lm363x: Pass descriptor instead of GPIO number
      regulator: lp8788-ldo: Pass descriptor instead of GPIO number
      regulator: max8952: Pass descriptor instead of GPIO number
      regulator: pfuze100: Delete reference to ena_gpio
      regulator: s5m8767: Pass descriptor instead of GPIO number
      regulator: tps65090: Pass descriptor instead of GPIO number
      regulator: fixed: Convert to use GPIO descriptor only
      regulator: gpio: Get enable GPIO using GPIO descriptor

Maciej Purski (6):
      regulator: core: Make locks re-entrant
      regulator: bindings: Add properties for coupled regulators
      regulator: core: Parse coupled regulators properties
      regulator: core: Resolve coupled regulators
      regulator: core: Add voltage balancing mechanism
      regulator: core: Change voltage setting path

Marek Vasut (1):
      regulator: ltc3676: Assure PGOOD mask is set before changing voltage

Mark Brown (7):
      Merge branch 'topic/bd9571mwv' of https://git.kernel.org/.../broonie/=
regulator into regulator-4.18
      regulator: s2mps11: Fix boot on Odroid XU3
      regulator: max77686: Fix shared GPIOs
      regulator: wm8994: Fix shared GPIOs
      regulator: Revert coupled regulator support again
      regulator: gpio: Revert
      Merge branch 'regulator-4.17' into regulator-4.18 merge window

Matti Vaittinen (2):
      regulator: bd71837: Devicetree bindings for BD71837 regulators
      regulator: bd71837: BD71837 PMIC regulator driver

Ondrej Jirman (2):
      regulator: add binding for the SY8106A voltage regulator
      regulator: add support for SY8106A regulator

Pawe=C5=82 Chmiel (1):
      regulator: max8998: Fix platform data retrieval.

ryang (1):
      regulator: tps6586x: Add support for TPS658624

 Documentation/devicetree/bindings/mfd/axp20x.txt   |    3 +-
 .../devicetree/bindings/mfd/bd9571mwv.txt          |   21 +
 .../devicetree/bindings/regulator/pfuze100.txt     |    6 +-
 .../bindings/regulator/qcom,spmi-regulator.txt     |   45 +
 .../devicetree/bindings/regulator/regulator.txt    |   10 +
 .../bindings/regulator/rohm,bd71837-regulator.txt  |  126 ++
 .../bindings/regulator/sy8106a-regulator.txt       |   23 +
 MAINTAINERS                                        |    6 +
 arch/arm/mach-s3c64xx/mach-crag6410-module.c       |   28 +-
 drivers/mfd/bd9571mwv.c                            |    2 +
 drivers/regulator/Kconfig                          |   18 +
 drivers/regulator/Makefile                         |    3 +-
 drivers/regulator/ab8500.c                         | 1779 ++--------------=
----
 drivers/regulator/anatop-regulator.c               |   22 +-
 drivers/regulator/arizona-ldo1.c                   |   19 +-
 drivers/regulator/axp20x-regulator.c               |    2 +
 drivers/regulator/bd71837-regulator.c              |  640 +++++++
 drivers/regulator/bd9571mwv-regulator.c            |  127 +-
 drivers/regulator/core.c                           |  244 ++-
 drivers/regulator/cpcap-regulator.c                |    2 +-
 drivers/regulator/internal.h                       |   37 +-
 drivers/regulator/lm363x-regulator.c               |   20 +-
 drivers/regulator/lp87565-regulator.c              |   17 +-
 drivers/regulator/lp8788-ldo.c                     |   32 +-
 drivers/regulator/ltc3676.c                        |   20 +-
 drivers/regulator/max8952.c                        |   18 +-
 drivers/regulator/max8973-regulator.c              |   54 +-
 drivers/regulator/max8998.c                        |    3 +-
 drivers/regulator/mc13783-regulator.c              |   18 +-
 drivers/regulator/mc13892-regulator.c              |   18 +-
 drivers/regulator/mc13xxx-regulator-core.c         |   28 +-
 drivers/regulator/of_regulator.c                   |  193 ++-
 drivers/regulator/pfuze100-regulator.c             |   40 +-
 drivers/regulator/qcom_spmi-regulator.c            |  133 +-
 drivers/regulator/s5m8767.c                        |   26 +-
 drivers/regulator/sy8106a-regulator.c              |  167 ++
 drivers/regulator/tps65090-regulator.c             |   50 +-
 drivers/regulator/tps6586x-regulator.c             |    1 +
 drivers/regulator/twl-regulator.c                  |    2 +-
 drivers/regulator/wm8350-regulator.c               |    1 +
 include/linux/mfd/bd9571mwv.h                      |    5 +
 include/linux/mfd/lp8788.h                         |   16 -
 include/linux/mfd/samsung/core.h                   |    4 +-
 include/linux/mfd/tps65090.h                       |    8 +-
 include/linux/mfd/tps6586x.h                       |    1 +
 include/linux/regulator/ab8500.h                   |  157 +-
 include/linux/regulator/arizona-ldo1.h             |    3 -
 include/linux/regulator/consumer.h                 |    1 +
 include/linux/regulator/driver.h                   |   27 +-
 include/linux/regulator/machine.h                  |    4 +
 include/linux/regulator/max8952.h                  |    1 -
 51 files changed, 2196 insertions(+), 2035 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd7183=
7-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/sy8106a-reg=
ulator.txt
 create mode 100644 drivers/regulator/bd71837-regulator.c
 create mode 100644 drivers/regulator/sy8106a-regulator.c

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsa16EACgkQJNaLcl1U
h9AVlQf5AbxilgWZsHgPXKknuPUV2PPP7kBFwKxpS6sU6Q4iF35Nzy6A1dvvsj7/
26cudThGqpav1rUddc86JdGAGslVC+iP1YSHeHPUBllUlp2GTRe0jnQvKnCKmE3T
aVHHKUNbrxb3ZWGplalvceT5H//BIYdLsWmF2UxaGyRf0KjREB2QuQbsh3CtIhVL
ndpRT7zom0oxzqTXeqhYcHtR6mPw1RYLUiD5uhxriiTYrGa/kYEgo4fu4BqOMMaZ
+bBNl0y/ok1kwfw1+dF+ASY8rgLZG/xDYZQ9zT8eq5zlp0NzR6PWCRv4kgT/MG14
vrYs0DZFvN1SnlpmZPOl6oUjzCIzlg==
=wu1z
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
