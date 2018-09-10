Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CC4C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03FF20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ZYXl7Edu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03FF20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeIJUOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:14:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48840 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeIJUOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1o0MykD3OH18lEqlIxxUNdiwB8tDxqzb21rjViU0H4k=; b=ZYXl7EduEvx2e9WdJLITy8rhn
        ERnQxN/w8QeK8y/Plx63WxcQUy0VapbTWNMfRo7B3pRATLSfdXQe34FoTnvzWB2hOo/ckweV1Vidw
        43mYGA/o/l+JsSbuP+wf0qdutkr5AlwbnVAKgw6UxGerLQykdkKG1nX28WWai627lXPao=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fzNyK-00025e-3I; Mon, 10 Sep 2018 15:19:28 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 797271122D51; Mon, 10 Sep 2018 16:19:26 +0100 (BST)
Date:   Mon, 10 Sep 2018 16:19:26 +0100
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
Message-ID: <20180910151926.GA10889@sirena.org.uk>
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
 <20180802103425.3053-4-o.rempel@pengutronix.de>
 <20180802104443.GH9117@sirena.org.uk>
 <94d48ecb-7302-c7ed-e815-730be0426a04@pengutronix.de>
 <20180802113552.GJ9117@sirena.org.uk>
 <20180827014815.GD29208@dragon>
 <20180906101516.GA5360@sirena.org.uk>
 <20180909020021.GA18838@dragon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20180909020021.GA18838@dragon>
X-Cookie: You must be present to win.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 09, 2018 at 10:00:23AM +0800, Shawn Guo wrote:
> On Thu, Sep 06, 2018 at 11:15:17AM +0100, Mark Brown wrote:

> > I was expecting to get a pull request with the precursor patches in it -
> > the regulator driver seems to get a moderate amount of development so
> > there's a reasonable risk of conflicts.

> What about you create a stable topic branch for regulator patches and I
> pull it into IMX tree?

Sure, I can send a pull request back but the first two patches in the
series are ARM ones - are you OK with me just applying them and sending
them in the pull request or do you want to apply them first?

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluWi30ACgkQJNaLcl1U
h9DfjQf+Mzg14+HDipidgPh6Bdg+IJD1Nj7k+nkPf1Swd7eZoS05uU8JnDGs2EPD
xNvyzY4s12YQUOt5PwoTsQqa78Qi4VlkyQ64alwucoTZAqr49ohIThUfst/igMXP
7GydiWcdwcGyxgecT45qT9AU/sULkb0ygCdTgUL4Jnhcy5D2YZGeWOc7PFQ2kI4j
GDyXyQGJTGq4kSmKLtZPyyshFYcfjc/ICzU9gt8e0SerwSD5HcK/ZAleF/9HRK22
QqSg/Z4BPi1Q1dWXJcwD4QdHC+0FRLQPCOIQx20GPgOuW0hNavALc55scwkdmMgg
9t9K8G+F9Y9TjZvYapu910gdzOriJA==
=y7uB
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
