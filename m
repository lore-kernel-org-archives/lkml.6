Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43C5C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEE421781
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="O6iG8+wP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DEE421781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbeHMQeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:34:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53778 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbeHMQeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=03vbchIdhoA490wdeNyJiZzGUUgOvvKYxofZ5xgVJaE=; b=O6iG8+wPPrxzbwvXVWFMRTibi
        hN5Kr6q6BA4jYlUY9J6pZgHBhMGkj4CH871pFv5Cwvu8Z2Fzvdqu8CaAVV1xt8r7Nt7qjk2wsgc42
        MEIV5irj4xihDgoiJlPDNWe0v6FlmqR7mnfJSTZPbvcRqnMtSMd2noT2/amw06zhIe+Mk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fpDGC-00083b-19; Mon, 13 Aug 2018 13:51:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8CD29112441F; Mon, 13 Aug 2018 14:51:51 +0100 (BST)
Date:   Mon, 13 Aug 2018 14:51:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: [GIT PULL] regulator updates for v4.19
Message-ID: <20180813135151.GF6757@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Content-Disposition: inline
X-Cookie: Many a family tree needs trimming.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1ffaddd029c867d134a1dde39f540dcc8c52e274:

  Linux 4.18-rc8 (2018-08-05 12:37:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v4.19

for you to fetch changes up to d22d59362b7b2c749245f1269d447011c76ca41d:

  Merge branch 'regulator-4.19' into regulator-next (2018-08-10 17:31:24 +0100)

----------------------------------------------------------------
regulator: Changes for v4.19

The biggest set of changes in here is the addition of the Qualcomm RPMH
driver.  As well as the regualtor driver itself being quite large due to
the usual involved Qualcomm regulator stuff there's also some code
shared with the arm-soc tree, a bus driver required to communicate with
the hardware that actually winds up being much larger than the regulator
driver itself and a LLCC driver that was part of the same signed tag
used with the arm-soc tree.

Other than that it's a fairly standard and quiet release, highlights
include:

 - Addition of device links from regulator consumers to their
   regulators, helping the core avoid dependency issues during suspend.
 - Support for the entertainingly innovative suspend implementation in
   the BD9571MWV.
 - Support for switch regulators on the PFUZE100, this required two goes
   due to backwards compatibility issues with old DTs that were
   discovered.
 - Support for Freescale PFUZE3001 and SocioNext UniPhier.
 - The aforementioned Qualcomm RPMH driver together with the driver
   changes required to support it.

----------------------------------------------------------------
Anton Vasilyev (1):
      regulator: tps65217: Fix NULL pointer dereference on probe

Axel Lin (2):
      regulator: bd71837: Staticize ldo_2_volts
      regulator: bd71837: Simplify bd71837_set_voltage_sel_restricted implementation

Bjorn Andersson (1):
      soc: qcom: smem: Correct check for global partition

Charles Keepax (1):
      regulator: arizona-ldo1: Use correct device to get enable GPIO

Dan Carpenter (1):
      regulator: max8997: clean up a condition in max8997_list_voltage()

David Collins (2):
      regulator: dt-bindings: add QCOM RPMh regulator bindings
      regulator: add QCOM RPMh regulator driver

Douglas Anderson (1):
      drivers: qcom: rpmh-rsc: Check cmd_db_ready() to help children

Fabio Estevam (1):
      regulator: Revert "regulator: pfuze100: add enable/disable for switch"

Geert Uytterhoeven (3):
      regulator: bd9571mwv: Use "backup_mode" sysfs file instead of "wake_up"
      regulator: bd9571mwv: Add support for toggle power switches
      regulator: bd9571mwv: Document "backup_mode" sysfs file

Johan Hovold (1):
      soc: qcom: rmtfs-mem: fix memleak in probe error paths

Krzysztof Kozlowski (2):
      regulator: maxim: Add SPDX license identifiers
      regulator: samsung: Add SPDX license identifiers

Kunihiko Hayashi (2):
      dt-bindings: regulator: add DT bindings for UniPhier regulator
      regulator: uniphier: add regulator driver for UniPhier SoC

Lina Iyer (10):
      drivers: qcom: rpmh-rsc: add RPMH controller for QCOM SoCs
      dt-bindings: introduce RPMH RSC bindings for Qualcomm SoCs
      drivers: qcom: rpmh-rsc: log RPMH requests in FTRACE
      drivers: qcom: rpmh: add RPMH helper functions
      drivers: qcom: rpmh-rsc: write sleep/wake requests to TCS
      drivers: qcom: rpmh-rsc: allow invalidation of sleep/wake TCS
      drivers: qcom: rpmh: cache sleep/wake state requests
      drivers: qcom: rpmh: allow requests to be sent asynchronously
      drivers: qcom: rpmh: add support for batch RPMH request
      drivers: qcom: rpmh-rsc: allow active requests from wake TCS

Marco Felsch (2):
      regulator: pfuze100: add optional disable switch-regulators binding
      regulator: pfuze100: add support to en-/disable switch regulators

Mark Brown (3):
      Merge tag 'qcom-drivers-for-4.19' of git://git.kernel.org/.../agross/linux into regulator-4.19 for RPMH
      Merge branch 'regulator-4.18' into regulator-linus
      Merge branch 'regulator-4.19' into regulator-next

Matthias Kaehlcke (1):
      regulator: Fix typo in comment of struct regulator_linear_range

Matti Vaittinen (3):
      regulator: bd71837: Editorial cleanups.
      regulator: bd71837: Remove duplicate description from DT bindings
      regulator: bd71837: adobt MFD changes to regulator driver

Niklas Cassel (6):
      regulator: qcom_spmi: Fix warning Bad of_node_put()
      regulator: qcom_spmi: Use correct regmap when checking for error
      regulator: qcom_spmi: Do not initialise static to NULL
      regulator: qcom_spmi: Indent with tabs instead of spaces
      firmware: qcom: scm: add a dummy qcom_scm_assign_mem()
      soc: qcom: llc-slice: Add missing MODULE_LICENSE()

Peter Geis (2):
      regulator: Add sw2_sw4 voltage table to cpcap regulator.
      regulator: Add support for CPCAP regulators on Motorola Xoom devices.

Raju P.L.S.S.S.N (2):
      drivers: qcom: rpmh-rsc: fix the loop index check in get_req_from_tcs
      drivers: qcom: rpmh: fix unwanted error check for get_tcs_of_type()

Rishabh Bhatnagar (2):
      dt-bindings: Documentation for qcom, llcc
      drivers: soc: Add LLCC driver

Stefan Wahren (2):
      regulator: pfuze100: add pfuze3001 support
      regulator: pfuze100: add pfuze3001 support

Wei Yongjun (1):
      regulator: bd9571mwv: Make symbol 'dev_attr_backup_mode' static

pascal paillet (3):
      regulator: core: Change suspend_late to suspend
      driver core: Add device_link_remove function
      regulator: core: Link consumer with regulator driver

 .../ABI/testing/sysfs-driver-bd9571mwv-regulator   |  27 +
 .../devicetree/bindings/arm/msm/qcom,llcc.txt      |  26 +
 .../bindings/regulator/cpcap-regulator.txt         |   1 +
 .../devicetree/bindings/regulator/pfuze100.txt     |  86 ++-
 .../bindings/regulator/qcom,rpmh-regulator.txt     | 160 +++++
 .../bindings/regulator/rohm,bd71837-regulator.txt  |   8 -
 .../bindings/regulator/uniphier-regulator.txt      |  57 ++
 .../devicetree/bindings/soc/qcom/rpmh-rsc.txt      | 137 ++++
 drivers/base/core.c                                |  30 +
 drivers/regulator/Kconfig                          |  25 +-
 drivers/regulator/Makefile                         |   4 +-
 drivers/regulator/arizona-ldo1.c                   |  27 +-
 drivers/regulator/bd71837-regulator.c              |  44 +-
 drivers/regulator/bd9571mwv-regulator.c            |  72 +-
 drivers/regulator/core.c                           |  44 +-
 drivers/regulator/cpcap-regulator.c                | 103 +++
 drivers/regulator/max14577-regulator.c             |  22 +-
 drivers/regulator/max77686-regulator.c             |  32 +-
 drivers/regulator/max77693-regulator.c             |  32 +-
 drivers/regulator/max77802-regulator.c             |  34 +-
 drivers/regulator/max8997-regulator.c              |  33 +-
 drivers/regulator/max8998.c                        |  28 +-
 drivers/regulator/pfuze100-regulator.c             | 112 ++-
 drivers/regulator/qcom-rpmh-regulator.c            | 769 +++++++++++++++++++++
 drivers/regulator/qcom_spmi-regulator.c            |  38 +-
 drivers/regulator/s2mpa01.c                        |  14 +-
 drivers/regulator/s2mps11.c                        |  21 +-
 drivers/regulator/s5m8767.c                        |  16 +-
 drivers/regulator/tps65217-regulator.c             |   2 +
 drivers/regulator/uniphier-regulator.c             | 213 ++++++
 drivers/soc/qcom/Kconfig                           |  27 +
 drivers/soc/qcom/Makefile                          |   6 +
 drivers/soc/qcom/llcc-sdm845.c                     |  94 +++
 drivers/soc/qcom/llcc-slice.c                      | 338 +++++++++
 drivers/soc/qcom/rmtfs_mem.c                       |   3 +-
 drivers/soc/qcom/rpmh-internal.h                   | 114 +++
 drivers/soc/qcom/rpmh-rsc.c                        | 693 +++++++++++++++++++
 drivers/soc/qcom/rpmh.c                            | 513 ++++++++++++++
 drivers/soc/qcom/smem.c                            |  10 +-
 drivers/soc/qcom/trace-rpmh.h                      |  82 +++
 include/dt-bindings/regulator/maxim,max77802.h     |   5 +-
 .../dt-bindings/regulator/qcom,rpmh-regulator.h    |  36 +
 include/dt-bindings/soc/qcom,rpmh-rsc.h            |  14 +
 include/linux/device.h                             |   1 +
 include/linux/qcom_scm.h                           |   4 +
 include/linux/regulator/driver.h                   |   4 +-
 include/linux/regulator/pfuze100.h                 |  11 +
 include/linux/soc/qcom/llcc-qcom.h                 | 180 +++++
 include/soc/qcom/rpmh.h                            |  51 ++
 include/soc/qcom/tcs.h                             |  56 ++
 50 files changed, 4187 insertions(+), 272 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
 create mode 100644 drivers/regulator/qcom-rpmh-regulator.c
 create mode 100644 drivers/regulator/uniphier-regulator.c
 create mode 100644 drivers/soc/qcom/llcc-sdm845.c
 create mode 100644 drivers/soc/qcom/llcc-slice.c
 create mode 100644 drivers/soc/qcom/rpmh-internal.h
 create mode 100644 drivers/soc/qcom/rpmh-rsc.c
 create mode 100644 drivers/soc/qcom/rpmh.c
 create mode 100644 drivers/soc/qcom/trace-rpmh.h
 create mode 100644 include/dt-bindings/regulator/qcom,rpmh-regulator.h
 create mode 100644 include/dt-bindings/soc/qcom,rpmh-rsc.h
 create mode 100644 include/linux/soc/qcom/llcc-qcom.h
 create mode 100644 include/soc/qcom/rpmh.h
 create mode 100644 include/soc/qcom/tcs.h

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltxjPYACgkQJNaLcl1U
h9AGlQf/ZgWxOFND4m0AnHGlC2wrvfL1+7l2QZKu2r98fr7/wpac/+Gm7cIdZ3yc
t7WSCASWyD/wdWnK2g+e/iU4b7kMaF/JUygLKNd4GcrSFdeVeW5rtTruGrDUzrQN
lDmOAzZRrI3w0Aa2qaCQKv9aLCM5JtCJ+kScJ0OoYNZjWfg5Y0zln4WFpb6DDRVu
LR2WCJyjabIOVp47rS5Od5WPSEwTyqA79AcnyUzQUIgiKWo/N8hbj6NPjS95qXvQ
+yRKkl2S6R2/pHkurag1/0Q6wVB3OSE4mr1hwyhXTkwl6mmI0uDVRpuIgTkl549R
hFkR2drUnPjT8LGcnWZBAW4Nq/IvJw==
=hSYE
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--
