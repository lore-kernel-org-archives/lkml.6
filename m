Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DABC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1546C206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="sXFxT+Sd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1546C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbeK2C4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:56:13 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46474 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeK2C4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YAagMpJp3hyABKQqg5vm4cENQLdI7Z+/oQMcgiBLooY=; b=sXFxT+SdwXKjS5D0R5VXeMg47
        JmY2glC4tnnavFyhE8IcYXILs72pS8Id5nVMzMVycyjDUGh0ZYWJr5SVIIjf82deCdrturVGdc60p
        rHmIEOcCY4OIXUnkKD7iPH7ite4Qgnlp0ZAsE+rG1UCCzwSmiXiBd8L3kwE+xnQqOr1mk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gS2A8-0005u7-Gc; Wed, 28 Nov 2018 15:54:04 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 126CA112521B; Wed, 28 Nov 2018 15:54:04 +0000 (GMT)
Date:   Wed, 28 Nov 2018 15:54:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [GIT PULL] SPI fixes for v4.20
Message-ID: <20181128155404.GJ6828@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0FRtVia6Q6lt+M0P"
Content-Disposition: inline
X-Cookie: I had pancake makeup for brunch!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0FRtVia6Q6lt+M0P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0c903aafc8529f64d24d2cd6df32f2bf16aad20b:

  spi: lpspi: add imx8qxp compatible string (2018-10-21 16:55:23 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git spi-fix-v4.20-rc4

for you to fetch changes up to 91b9deefedf4c35a01027ce38bed7299605026a3:

  spi: omap2-mcspi: Add missing suspend and resume calls (2018-11-15 16:20:43 -0800)

----------------------------------------------------------------
spi: Fixes for v4.20

A few driver specific fixes here, nothing big or that stands out for
anyone other than the driver users.

----------------------------------------------------------------

Forgot to note that the mcspi thing is a fix for issues that started
showing up with a change in defconfig in this release to make cpuidle
get turned on by default.

Keiji Hayashibara (1):
      spi: uniphier: fix incorrect property items

Leilk Liu (1):
      spi: mediatek: use correct mata->xfer_len when in fifo transfer

Tony Lindgren (1):
      spi: omap2-mcspi: Add missing suspend and resume calls

 .../devicetree/bindings/spi/spi-uniphier.txt       | 14 ++++----
 drivers/spi/spi-mt65xx.c                           |  4 +--
 drivers/spi/spi-omap2-mcspi.c                      | 37 +++++++++++++++-------
 3 files changed, 35 insertions(+), 20 deletions(-)

--0FRtVia6Q6lt+M0P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv+uhsACgkQJNaLcl1U
h9CQ2Qf8Ch14TJIWzZKoqdxC0TfLYDzF4DXB0Yyc8XXKk00RGB1LFbjw7qL4M2jL
5w941OlkAdVxz6g2V4ZX5JPwl7vFeCvdXvfVCprs95BGJfrFHJv5X4QdSOqJbTAI
dWft8/QU8xk167iuf2JZdk0nmCLQxnSddktavaTwMoqqRWGRfT/kl+jP45fwYEZN
EBciJtOjTe+0if3VaX0tMnRE7cchhAvv/nS405XHDyuENPIdT/5Rq6JKQQcPiRea
bSlSx+spCGstk7rO24LkatJSSKt95kX1vgX6h5jzFX/i6fmOs9pTyHs3csXZ//jP
BFujcsR6hqJcOnyQLBMcNEDrSoaFxw==
=eYeu
-----END PGP SIGNATURE-----

--0FRtVia6Q6lt+M0P--
