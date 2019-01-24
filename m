Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D25C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35500218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548325520;
	bh=5rnJF7lJB6IUTZDaBdhg15C9A/kYKyWxbcx9BKPRzeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N1hpnq4V7d+JYBMPYReo5T9y+saf1MehF7mW5dXJqA3N1I09S29wFBqKSCkxp5C/y
	 57+EP6srrMTIJwmPPyilPII/lNRZ/uTfnFC1cLxm27jyNmOMVaIKz6ZQj4quQWQ2lY
	 /5TxvuvxqAhGz5F3qo41J0ZVzIsttqDhHIoorb3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfAXKZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:25:17 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37514 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfAXKZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5rnJF7lJB6IUTZDaBdhg15C9A/kYKyWxbcx9BKPRzeE=; b=rz0Hj8E30Q+LDzScl3H2q3FTz
        I1qbD+yO7kuoHc8dc1c6Lf5pkoaZgVGJjRY9iXo0hx6lkSrIU3QGDf0vOOAzds6ptOecPj7djg6Cw
        IIqCjNDFe3pOMXkipOih7bIfg/GACreP0eJTNUDlXneYq5r9TBT2bsRUIVI6Q8DQXZ+Ow=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmcBr-0005Zp-FJ; Thu, 24 Jan 2019 10:24:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B2B9C1127480; Thu, 24 Jan 2019 10:24:54 +0000 (GMT)
Date:   Thu, 24 Jan 2019 10:24:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [RFC PATCH v1 03/13] regulator: bd718x7 use chip specific and
 generic data structs
Message-ID: <20190124102454.GA5641@sirena.org.uk>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <3fb3eab3a8a2767404588d0a0a531273fddfc659.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <20190123155121.GB7503@sirena.org.uk>
 <20190124071635.GE2559@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20190124071635.GE2559@localhost.localdomain>
X-Cookie: Love America -- or give it back.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 24, 2019 at 09:16:35AM +0200, Matti Vaittinen wrote:

> Yes. If we don't want to break the compilation between commits then
> the patches 2, 3 and 4 should be squashed into one. I sent them as
> separare changes for easier review. I can squash them and send them
> squashed if they are Ok to Lee and Stephen. Please just let me know
> whose tree I should use as the basis so I can do rebasing if needed.
> (Or is there some better way to do changes like this?)

I'd guess Lee's but check with him and Stephen.

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxJknMACgkQJNaLcl1U
h9Dtlgf/SsJMyLuFfn78Xh+NzwTORnNG0kgbZhy+ZOar3p3fo+pGb9I3n38ZSfnm
Yjr++oIq5gaGs8+0r+FsSQ0EuTOZfFkiq0zC7syPSP4JfRl67gAocUi0/drX6mxU
O9HzjoF+57LKb0a40VTVwBxy4cHxJ2fBVBabVgXpaSyR8F93P2E3USs6CbzKo0AP
KxFOXFeVwmRA4y/Jl7doUHKpEOFW6ey99iG11j3pXojvMamjEN8JMMYkaW2BBUqM
KTXbSb4GLqTQBjF9KESSZrz+nccDutK2XqUnHrg+7si69AWpkbxlfvyOv995BLXY
2XtqxvG+S+MrH1Kghsn7giXoZl6KlA==
=o2ie
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
