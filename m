Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752938AbeDBQeR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:34:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39818 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752627AbeDBQeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:34:16 -0400
Date: Mon, 2 Apr 2018 17:34:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: [GIT PULL] regulator updates for v4.17
Message-ID: <20180402163413.GV29239@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3ig5MTpp3LwprTX9"
Content-Disposition: inline
X-Cookie: Serenity through viciousness.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3ig5MTpp3LwprTX9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 3eb2ce825ea1ad89d20f7a3b5780df850e4be274:

  Linux 4.16-rc7 (2018-03-25 12:44:30 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v4.17

for you to fetch changes up to 36fd679f45a25a7c634b3dbec35a2d7fdb832a65:

  Merge remote-tracking branches 'regulator/topic/88pg86x', 'regulator/topic/dt', 'regulator/topic/formatting' and 'regulator/topic/gpio' into regulator-next (2018-03-28 10:33:53 +0800)

----------------------------------------------------------------
regulator: Updates for v4.17

A very small set of updates for the regulator API this time around,
there's a few bug fixes and also:

 - Conversion of the regulator API to use GPIO descriptors rather than
   numbers from Linus Walleij.
 - New drivers for Marvell 88PG86x and Qualcomm PM8998 and PMI8998.

----------------------------------------------------------------
Alexander Monakov (2):
      regulator: 88pg86x: add DT bindings document
      regulator: 88pg86x: new i2c dual regulator chip

Bjorn Andersson (1):
      regulator: qcom: smd: Add pm8998 and pmi8998 regulators

Christophe JAILLET (1):
      regulator: of: Add a missing 'of_node_put()' in an error handling path of 'of_regulator_match()'

Christophe Jaillet (1):
      regulator: gpio: Fix some error handling paths in 'gpio_regulator_probe()'

Harald Geyer (1):
      regulator: dt: regulator-name is required property

Linus Walleij (3):
      regulator: core: Support passing an initialized GPIO enable descriptor
      regulator: da9055: Pass descriptor instead of GPIO number
      regulator: da9211: Pass descriptors instead of GPIO numbers

Mark Brown (5):
      regulator: core: Add missing blank line between functions
      Merge remote-tracking branch 'regulator/topic/core' into regulator-next
      Merge remote-tracking branch 'regulator/topic/qcom' into regulator-next
      Merge remote-tracking branch 'regulator/topic/qcom_smd' into regulator-next
      Merge remote-tracking branches 'regulator/topic/88pg86x', 'regulator/topic/dt', 'regulator/topic/formatting' and 'regulator/topic/gpio' into regulator-next

Nicholas Lowell (1):
      regulator: giving regulator controlling gpios a non-empty label when used through the devicetree.

Stephen Boyd (1):
      regulator: qcom_smd: Drop regulator/{machine,of_regulator} includes

 .../devicetree/bindings/regulator/88pg86x.txt      |  22 ++++
 .../bindings/regulator/fixed-regulator.txt         |   1 +
 .../bindings/regulator/gpio-regulator.txt          |   2 +
 .../bindings/regulator/qcom,smd-rpm-regulator.txt  |  48 ++++++++
 drivers/regulator/88pg86x.c                        | 114 +++++++++++++++++++
 drivers/regulator/Kconfig                          |   9 ++
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/core.c                           |  26 +++--
 drivers/regulator/da9055-regulator.c               |   4 +-
 drivers/regulator/da9211-regulator.c               |  23 ++--
 drivers/regulator/gpio-regulator.c                 |  17 ++-
 drivers/regulator/of_regulator.c                   |   1 +
 drivers/regulator/qcom_smd-regulator.c             | 123 ++++++++++++++++++++-
 include/linux/mfd/da9055/pdata.h                   |   5 +-
 include/linux/regulator/da9211.h                   |   4 +-
 include/linux/regulator/driver.h                   |   3 +
 include/linux/soc/qcom/smd-rpm.h                   |   1 +
 17 files changed, 367 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/88pg86x.txt
 create mode 100644 drivers/regulator/88pg86x.c

--3ig5MTpp3LwprTX9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrCW4UACgkQJNaLcl1U
h9BeRgf+OtMqxPWjX+9z9IeLFQggfe3SqUG9fGyi8erxQYoEx5tU1kjyoRP/fMMs
pZoC006UuqjyFTb3blO0wX5DBouyXDMUXmJptVgJ1fFeYEorXgMjkni7y5YbfTBE
WoSVqZZnB88hKRFWWQCQKB113fUwPoHQKWsVZhLnviE+FOv89sNuhqL2Ufr/xKLL
R14ax15kzTjPQlA3umxG9sK2tfuo0sHUrYNTMGqDwlPDaC/3LRtmgok8t+SXxH/O
kbu9QPuvUi5pNZMSwx15WfXXqxgUvL9LCT0NXcSqUUDsR95LKuIgO+o8M5IU5FwU
E8LuxXAEJiMJGtQMHFPaSuVlHAOvug==
=odP2
-----END PGP SIGNATURE-----

--3ig5MTpp3LwprTX9--
