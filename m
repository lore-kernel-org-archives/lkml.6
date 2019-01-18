Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B4EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E5520823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547815263;
	bh=9CH3dAtWHwcryskrwf13vBKGKCd/TVTCQEqgfvywqxc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=z/oyjI2ydfiPJFA7g4d29gq75wvggmuINklD0duayXlLqiP79FyjYQRGOwPyNF+OI
	 ST8otSVawckePcU2PRm27eUrV2jcTtBcqxf85B7j2wM5yLGnrWjZkmloNVst610qtq
	 Pe4F09qo072v9t2F6vEIj91kIDCFq9USZFRjEAds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfARMlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:41:01 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50126 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfARMlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hn25taJyev5FSxQgkZGRHYJQssCz3N4+pkT7TukcqEo=; b=CknDnCl/UgTFdHmRl69A2Eux6
        IPJwoWZMF3rE1PBBEBZiKKkv3PoOxd0oEq8MF2fqNexnbyTdXoQgh8RhQr9OxN0ZCAZKC5POn35gm
        ON1wSpKUenBjcy9Y5D5T8cEO+dSUGbz2Ez6wKDCsiBkfwMJYpCqrMKI9c5JZvj66V/h0s=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gkTSF-0004a5-IN; Fri, 18 Jan 2019 12:40:59 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1A6E3112767C; Fri, 18 Jan 2019 12:40:59 +0000 (GMT)
Date:   Fri, 18 Jan 2019 12:40:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Fixes for v5.0
Message-ID: <20190118124059.GA6260@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
X-Cookie: You can't get there from here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v5.0-rc2

for you to fetch changes up to 7151449fe7fa5962c6153355f9779d6be99e8e97:

  regmap-irq: do not write mask register if mask_base is zero (2019-01-14 22:11:22 +0000)

----------------------------------------------------------------
regmap: Fixes for v5.0

The cleanups for the way we handle type information introduced during
the merge window revealed that we'd been abusing the irq APIs for a long
time, causing breakage for systems.  This pull request has a couple of
minimal fixes for that which restore the previous behaviour for the time
being, we'll fix it properly for v5.1 but that'd be a bit much to do as
a bug fix.

----------------------------------------------------------------

There's also this extra merge here which I forgot to get rid of when I
was cleaning up for the major version number change, I only realized
just as I was preparing this and decided it was better to leave it be
rather than rebasing it out and making it look like this stuff hadn't
been sitting in -next.

Mark Brown (1):
      Merge branch 'regmap-4.21' into regmap-5.0

Mark Zhang (1):
      regmap-irq: do not write mask register if mask_base is zero

Matti Vaittinen (1):
      regmap: regmap-irq: silently ignore unsupported type settings

 drivers/base/regmap/regmap-irq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxByVoACgkQJNaLcl1U
h9Da7Qf+NK5EXLoTbwZbGwGmsjkw6A0UuhR8N3TRgcPE9fj0cBjySTOGO0oNkoLB
FSHhykdZ5qJgDgG44Dbk9Ycv7xGmLTYeboALBLzXR2HRaY80+mAumUjyOnLTU+tT
XtHbBr5cp2QFrFzL9yb4xyc6Oky//SLy4w3mgw6CWPY9HaEnO6LEqfP28nAlvJm2
fo9sqTOioLU34DBh4x+c5oZAc/gMV+6WbPGvrIS0pGqZMqPqFVqS5kT+Nk+ABZJv
GwEHDEKsvt5YCjc/V8WRi2E8DpVk0uBS3NJRrY/WYlVvpoSSAP/qQdNN09CoWv+9
YKw25/N3l6JmU5GBUf38l6U4FS5WZw==
=2SHY
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
