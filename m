Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB86C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 19:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B582173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 19:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545678936;
	bh=ofk3ijuFXphn93CZikPNxcrK8cEFthsfhS6N4yUJomY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=B7/tuVgaQpS+bACKRF+GgP37yTeG+p0UptFCJQ+JkM3ArFL19TkuljW9Z5fpVgDrA
	 E+VBqdUfLSp2VxpvnfU9Bl5WOUCWRztjDO/FcBxX/5tkhgfK1QYZn3XY6Qr+h+h9NQ
	 uvx/G6hZLt5s9Ac/QkCMKucRHQ792Klz2Mi+h7Uc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbeLXTPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 14:15:35 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49434 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbeLXTPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 14:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+4uhFlln5/mEmrpS5Zh9uYA+RaR8bxg3jzRCjI6DQoI=; b=YP3mMaI8zgx/3jZ6Kig223414
        6qnMciuz7W5Dwcr7t0cHc5xhUctnO45rUiydNmufZM9hT7CwXWK7DAuwjog92zcUMNuDH0QjFJ8hZ
        mEDKcskG/OiuYoDJ22eFZKdD999QogJfuuncOhOJKPybxxWuU2iXPQKmOy+US8sCnsH14=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gbVhM-00078M-Rn; Mon, 24 Dec 2018 19:15:32 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 4E574440080; Mon, 24 Dec 2018 19:15:32 +0000 (GMT)
Date:   Mon, 24 Dec 2018 19:15:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] regmap updates for v4.21
Message-ID: <20181224191532.GC1846@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline
X-Cookie: knowledge, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:

  Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v4.21

for you to fetch changes up to 58331d618bd9ced88a21a9b68c7743b84c2f4803:

  Merge remote-tracking branch 'regmap/topic/irq' into regmap-next (2018-12-19 18:38:33 +0000)

----------------------------------------------------------------
regmap: Updates for v4.21

This has been a busy release for the regmap-irq code, there's several
new features been added, including an API cleanup for how we specify
types that affected one existing driver (gpio-max77620):

 - Support for hardware that flags rising and falling edges on separate
   status bits from Bartosz Golaszewski.
 - Support for explicitly clearing interrupts before unmasking from
   Bartosz Golaszewski.
 - Support for level triggered IRQs from Matti Vaittinen.

----------------------------------------------------------------
Bartosz Golaszewski (2):
      regmap: irq: handle HW using separate rising/falling edge interrupts
      regmap: irq: add an option to clear status registers on unmask

Mark Brown (2):
      Merge branch 'regmap-4.21' into regmap-next
      Merge remote-tracking branch 'regmap/topic/irq' into regmap-next

Matti Vaittinen (2):
      regmap: regmap-irq: Remove default irq type setting from core
      regmap: regmap-irq/gpio-max77620: add level-irq support

Tony Xie (1):
      regmap: add a new macro:REGMAP_IRQ_REG_LINE(_id, _reg_bits)

Yangtao Li (2):
      regmap: rbtree: convert to DEFINE_SHOW_ATTRIBUTE
      regmap: debugfs: convert to DEFINE_SHOW_ATTRIBUTE

 drivers/base/regmap/regcache-rbtree.c |  12 +--
 drivers/base/regmap/regmap-debugfs.c  |  12 +--
 drivers/base/regmap/regmap-irq.c      | 142 ++++++++++++++++++++++++----------
 drivers/gpio/gpio-max77620.c          |  96 +++++++++++++++--------
 include/linux/regmap.h                |  41 ++++++++--
 5 files changed, 200 insertions(+), 103 deletions(-)

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwhMFMACgkQJNaLcl1U
h9Bcagf8DBrmm4WJ0RVhKGKd2zoawb7p+Sfahz29I2Qpe6jTd8T/DHMyeat9NrG8
aRJJsuKnO2PQ03MPZ3VKUiLNwVJNU+jYC926kib9gL3u/DUW4vZPa989jzlf04xZ
BA4DQV9nQfQxPL0nkiM31dEPl5BRiPeWQrpwUG++NIeXfu43TQzpIm5PCEGlH5Io
/pduXLHedZhVKBFs49vQUHpl5QsZJw07P8llk+q+a8T1pYc4Vb9xLDuQ2IyoBFAY
FUzqN8Iz5vd312OaHchTHvgoHcDIOJvusieOA44hm525kKwyGdsoWwtMhD9I9BlG
mySvXgZQgoM2x5TMclWW+Xomgssbnw==
=rhtL
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
