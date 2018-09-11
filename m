Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E82DC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE752086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="J9svdvqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE752086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeIKUTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:19:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36930 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKUTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WYr0ZZS5I/y/azNsgS1Rz2Jb3b6oRptpx5gLnIu/ZBI=; b=J9svdvqvAQoNxgkFWvlda/C/L
        7uj3MLC7FPMJXbvZ7diThJEEoBaRPuNkcohRwYZrNafk8qh0IwmFbiHBQoruwC3w1tgaq+7925Q60
        yt7mvVlul73oGcGb/qFcHPMkqe2i3l9iTmiqH+7Jx8KJJ0ZilL+YUUB0cyB7vJ3D14K1M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fzkRs-0004xu-BX; Tue, 11 Sep 2018 15:19:28 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BA7271121B1F; Tue, 11 Sep 2018 16:19:27 +0100 (BST)
Date:   Tue, 11 Sep 2018 16:19:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>, linux-imx@nxp.com,
        yibin.gong@nxp.com, "A.s. Dong" <aisheng.dong@nxp.com>
Subject: Re: [PATCH v9 3/6] kernel/reboot.c: export pm_power_off_prepare
Message-ID: <20180911151927.GB10123@sirena.org.uk>
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
 <20180802103425.3053-4-o.rempel@pengutronix.de>
 <20180802104443.GH9117@sirena.org.uk>
 <94d48ecb-7302-c7ed-e815-730be0426a04@pengutronix.de>
 <20180802113552.GJ9117@sirena.org.uk>
 <20180827014815.GD29208@dragon>
 <20180906101516.GA5360@sirena.org.uk>
 <20180909020021.GA18838@dragon>
 <20180910151926.GA10889@sirena.org.uk>
 <20180911015320.GA25790@dragon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
In-Reply-To: <20180911015320.GA25790@dragon>
X-Cookie: Bridge ahead.  Pay troll.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 11, 2018 at 09:53:21AM +0800, Shawn Guo wrote:

> There shouldn't be any build or run time regression on either tree, and
> the feature that the series adds will be available when both trees get
> merged together on -next or Linus tree.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/pfuze100-poweroff

for you to fetch changes up to c29daffa322ad36978cbce487f8ebcd9c3c3f7c0:

  regulator: pfuze100-regulator: provide pm_power_off_prepare handler (2018-09-11 16:15:57 +0100)

----------------------------------------------------------------
regulator: pfuze100: Power off support

The pfuze100 has some innovative and creative power off support which
requires some cross tree work to handle; this tag is the regualtor bits
of that work.

----------------------------------------------------------------
Oleksij Rempel (3):
      kernel/reboot.c: export pm_power_off_prepare
      regulator: pfuze100: add fsl,pmic-stby-poweroff property
      regulator: pfuze100-regulator: provide pm_power_off_prepare handler

 .../devicetree/bindings/regulator/pfuze100.txt     |  5 ++
 drivers/regulator/pfuze100-regulator.c             | 91 ++++++++++++++++++++++
 kernel/reboot.c                                    |  1 +
 3 files changed, 97 insertions(+)

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluX3P4ACgkQJNaLcl1U
h9DYcQf/T4B8STe5DVYJ7XcIqMdP9niqyxfDHKXnaV83jPTBEbCXqBjxRlt/3JpU
vTrcDW97YDnUk2iOeq3oPER4svv5ELXiOZSQIAZnR3sQxuDCPLRxVm0HpX12rFLv
Lscfxv6LEbfbSqKG5v7w92wgYZA2ab0PdDGm4C1fbMKnq1Qs5ltpHMwtZDg48YDA
O0gz4OCzTJmcwDICQemWP04xs3XL31dvO3ysdEJNwrqNBuv4MERrRtyljpTCMrVM
gOcnWS4zKT4zTAvr8rnRVojR1kkLupoUgrPfADpYzPgMSSeL5RtuC+Ad8FOD7wDa
rfhRp0nr2va6alTLEny2NghIXdxZTg==
=bf0C
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
