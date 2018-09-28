Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59208C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217902168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="AqD9FcAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217902168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbeI1UGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:06:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45820 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbeI1UGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c+pHvcjT32TY2rcxCsXWn+P4BmMI15QxWRWN68EU1gw=; b=AqD9FcAZl8alJ9uxfl/w01xYl
        sWNsoP8aA7yAjNTOiDMOrJDsuMC29z8eZTl4V7P8g4Xd8E+cIE6tKiuLlZYFcHltBXSD3JEU9R0E1
        6mKlvFtBDyNYO10SFa0c/bQ5H2WViCo84vRp21+RF/S/VXc8MpVTtyrFUKL3VLBLKMZ04=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g5t2k-0008Tu-04; Fri, 28 Sep 2018 13:42:54 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 255A4440078; Fri, 28 Sep 2018 14:42:53 +0100 (BST)
Date:   Fri, 28 Sep 2018 14:42:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] regulator fixes for v4.19
Message-ID: <20180928134253.GM20825@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mzDsWmoYTs+XRn5Z"
Content-Disposition: inline
X-Cookie: Disc space -- the final frontier!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mzDsWmoYTs+XRn5Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v4.19-rc5

for you to fetch changes up to fb6de923ca3358a91525552b4907d4cb38730bdd:

  regulator: fix crash caused by null driver data (2018-09-20 09:04:51 -0700)

----------------------------------------------------------------
regulator: Fixes for 4.19

A collection of fairly minor bug fixes here, a couple of driver specific
ones plus two core fixes.  There's one fix for the new suspend state
code which fixes some confusion with constant values that are supposed
to indicate noop operation and another fixing a race condition with the
creation of sysfs files on new regulators.

----------------------------------------------------------------
Marek Szyprowski (1):
      regulator: Fix 'do-nothing' value for regulators without suspend state

Matti Vaittinen (1):
      regulator: bd71837: Disable voltage monitoring for LDO3/4

Philipp Zabel (1):
      regulator: da9063: fix DT probing with constraints

Yu Zhao (1):
      regulator: fix crash caused by null driver data

 drivers/regulator/bd71837-regulator.c | 19 +++++++++++++++++++
 drivers/regulator/core.c              |  4 ++--
 drivers/regulator/of_regulator.c      |  2 --
 include/linux/mfd/da9063/pdata.h      | 16 +++++++++-------
 include/linux/mfd/rohm-bd718x7.h      | 33 ++++++++++++++++++++++++++++++---
 include/linux/regulator/machine.h     |  6 +++---
 6 files changed, 63 insertions(+), 17 deletions(-)

--mzDsWmoYTs+XRn5Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluuL9wACgkQJNaLcl1U
h9A7VQf/YZRa6HSt6UCab3bIa+msBzmRKksoqBva4/TK2gzGdpH2sIQkCSLwDZae
qi6Q882cx7u9K179c5mHwYd/UrJK1Jwq1Gmo3ITTyGxsp7LSdC3nPjW9vtSrE3DT
0ZPbWtc7QpHYbuqIxQMuZ9Zp8RY3Yw6Dq/LL/BMBwKQhaErg4B4//IaBa/mcn6S7
SDgYRFqCyBhnvynVc34ZlsVQ79j8g72KBrqghk3l1t3KovgqjBoUid3VqV4zfJGo
/TXcUKb45sNn1f906XJiQOda08pPzfeZq5g7qz6zwPQNbBrZ6CZjaUYwJit/cBBz
vLQYd1nQSpSjVt9jrkQXvD79KwgaTg==
=W1U0
-----END PGP SIGNATURE-----

--mzDsWmoYTs+XRn5Z--
