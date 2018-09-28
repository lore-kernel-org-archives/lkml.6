Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33923C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC1120645
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="VjquitXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC1120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbeI1Uyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:54:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41430 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeI1Uyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2UWy1P674fdC2Qlkkie+NNLdQvgKPWXFWXsHbfa2eb4=; b=VjquitXHo0TMFc9J4VSjafzTc
        fEWxlr1GZvidL0WP1IlPCWIyIop8WGgbuqkc76tLTtX2vjSWV1pGLpjnIKxpOBwTxz8H+l+vzDZUW
        LE9hDyUJ4hOQUTjsMUNGbwMskgzXyOAkm3aDzolHway587tkWbKPln2mwC+g+5Pq4fda0=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g5tn0-00007Q-Hb; Fri, 28 Sep 2018 14:30:42 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 04096440078; Fri, 28 Sep 2018 15:30:41 +0100 (BST)
Date:   Fri, 28 Sep 2018 15:30:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] spi fixes for v4.19
Message-ID: <20180928143041.GQ20825@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xYEXny2b0/vlBQCR"
Content-Disposition: inline
X-Cookie: Disc space -- the final frontier!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xYEXny2b0/vlBQCR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 5223c9c1cbfc0cd4d0a1b50758e0949af3290fa1:

  spi: spi-fsl-dspi: fix broken DSPI_EOQ_MODE (2018-08-28 20:55:23 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v4.19-rc5

for you to fetch changes up to c949a8e8b43f2c75567269bcc9a50d704ae3c420:

  spi: spi-mem: Move the DMA-able constraint doc to the kerneldoc header (2018-09-20 12:23:31 -0700)

----------------------------------------------------------------
spi: Fixes for v4.19

Quite a few fixes for the Renesas drivers in here, plus a fix for the
Tegra driver and some documentation fixes for the recently added spi-mem
code.  The Tegra fix is relatively large but fairly straightforward and
mechanical, it runs on probe so it's been reasonably well covered in
-next testing.

----------------------------------------------------------------

There's also a small fix for error checking in the bitbanging GPIO
driver I forgot to mention above.

Boris Brezillon (2):
      spi: spi-mem: Add missing description for data.nbytes field
      spi: spi-mem: Move the DMA-able constraint doc to the kerneldoc header

Gaku Inami (1):
      spi: sh-msiof: Fix invalid SPI use during system suspend

Geert Uytterhoeven (2):
      spi: rspi: Fix invalid SPI use during system suspend
      spi: rspi: Fix interrupted DMA transfers

Hiromitsu Yamasaki (1):
      spi: sh-msiof: Fix handling of write value for SISTR register

Linus Walleij (1):
      spi: gpio: Fix copy-and-paste error

Marcel Ziswiler (1):
      spi: tegra20-slink: explicitly enable/disable clock

 drivers/spi/spi-gpio.c          |  4 ++--
 drivers/spi/spi-rspi.c          | 34 ++++++++++++++++++++++++++++++----
 drivers/spi/spi-sh-msiof.c      | 28 +++++++++++++++++++++++++++-
 drivers/spi/spi-tegra20-slink.c | 31 +++++++++++++++++++++++--------
 include/linux/spi/spi-mem.h     |  7 ++++---
 5 files changed, 86 insertions(+), 18 deletions(-)

--xYEXny2b0/vlBQCR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluuOxEACgkQJNaLcl1U
h9B7aggAgQW3GoHvmPvS9TM5XOANT/6KBbq5XAadZdUQMry0SNJx4FKtzsLFTf7G
xeMXPAC5RgYwoNrVtLkJatWATXzt5Gc7tshwlZDiARIEWFHtsL99C3PyyRhlxw5m
jVHJkyXxPXZbHRc5Ou2E0PouSB7W/ej5/53XWo92HsdaW1ld/Ll/ZYXaf9W8oT6M
Zby2XpQRFsUrlF2l4aGw2zT576rpKlueSCN17aQfzt0+mJleroP7qWy0TxIaj6/j
lCIxFxrBJcCxkJsVSD61wvFThQoOnfegXd5haeYxhb4WnTips+WMZQ3ewUCVGMbF
wGX50uh7eWi++f57H3/VprB1RrY/7Q==
=aExT
-----END PGP SIGNATURE-----

--xYEXny2b0/vlBQCR--
