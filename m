Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B973FC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5849A21728
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="SPdaml75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5849A21728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbeHMMin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:38:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55408 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbeHMMim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=76AeNKzI53bMc9W/2k8gImwxxg1CqunmuaIepjBUzjE=; b=SPdaml75l1t1N+Byvsamc6O6c
        F/kJsgstBQRrGaj2Jah1nh+XZzVbKlt3lm/LUCjTZu5LO2vfsyYmcfoQfPkVFZEI9ZTFblrP1SXm8
        jCTaPeSYe2t7KBrdbDoMO1GUkg09ND7j5EE7VTFBsXG5rFXbjx/80UUXlgzttQJoyBPo8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fp9b4-0007ry-48; Mon, 13 Aug 2018 09:57:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C5651112441C; Mon, 13 Aug 2018 10:57:09 +0100 (BST)
Date:   Mon, 13 Aug 2018 10:57:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] regmap updates for v4.19
Message-ID: <20180813095709.GB6757@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
X-Cookie: Many a family tree needs trimming.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1ffaddd029c867d134a1dde39f540dcc8c52e274:

  Linux 4.18-rc8 (2018-08-05 12:37:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v4.19

for you to fetch changes up to 1dce5d849f94b90e2ed52056e7eefab3c17277b8:

  Merge branch 'regmap-4.19' into regmap-next (2018-08-09 11:17:30 +0100)

----------------------------------------------------------------
regmap: Changes for v4.19

Several small new features for regmap this time around:

 - Support for SCCB, an I2C variant used on some media cards.  This has
   also pulled in an I2C commit from Peter Rosin as a dependency.
 - Addition of an API for reading repeatedly from registers where the
   address doesn't automatically increment like some ADC outputs or GPIO
   status registers.
 - Support for bulk I/O on Slimbus.

----------------------------------------------------------------
Akinobu Mita (2):
      regmap: add SCCB support
      regmap: sccb: fix typo and sort headers alphabetically

Crestez Dan Leonard (1):
      regmap: Add regmap_noinc_read API

Mark Brown (4):
      Merge tag 'regmap-sccb' of https://git.kernel.org/.../broonie/regmap into regmap-4.19
      Merge branch 'i2c/smbus_xfer_unlock-immutable' of git://git.kernel.org/.../wsa/linux into regmap-4.19 for sccb dependency
      Merge tag 'regmap-noinc-read' into regmap-4.19
      Merge branch 'regmap-4.19' into regmap-next

Peter Rosin (1):
      i2c: smbus: add unlocked __i2c_smbus_xfer variant

Srinivas Kandagatla (1):
      regmap: slimbus: add support to multi read/write

 drivers/base/regmap/Kconfig          |   4 ++
 drivers/base/regmap/Makefile         |   1 +
 drivers/base/regmap/internal.h       |   3 +
 drivers/base/regmap/regmap-sccb.c    | 128 +++++++++++++++++++++++++++++++++++
 drivers/base/regmap/regmap-slimbus.c |  23 ++-----
 drivers/base/regmap/regmap.c         |  79 ++++++++++++++++++++-
 drivers/i2c/i2c-core-smbus.c         |  28 +++++---
 include/linux/i2c.h                  |  11 ++-
 include/linux/regmap.h               |  54 +++++++++++++++
 9 files changed, 303 insertions(+), 28 deletions(-)
 create mode 100644 drivers/base/regmap/regmap-sccb.c

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltxVfQACgkQJNaLcl1U
h9DcsAf+PX/9+Rr0hrcRRdt8OwTMTNC+kl2OevZXCUgBGEUXA6+DUR0pbCNgLEIa
NJ2L1hEiNsHHlmZ0sCQ/ACsShXoKdg8b6Nn8U0Zt48VcqlSBVUlMD6DiRQMexMTD
Td39HRsCVK/xW63gZZDub8ns5hzv4jHf8YcktWfp1NNB2GMzyUDULn6thpRGaNwy
yDTgqfpwoqCR1O+F4F4mLu1/dPgECfQe604u9u2+Mftkri+ts1YbZVrFtt1S9UiK
iE37H/7BSr8kvRvCaUS7irDc+AMysXAtCMFMXQQ53cOSxpKbNcDekMIzdOAxAqQg
UynBtqeIFZtLXlgQjpmFtV69rroiqQ==
=5/iM
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
