Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065D6C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C490520820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="TBo8cXhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C490520820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeKAVEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:04:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38206 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbeKAVEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9+x+q/gTPOaB/E48b+KYJQc8O7pe8JZf6u5qoAu4kdw=; b=TBo8cXhVzPxg7xuccQX0QaySv
        iY5zd4lxRniV8n/MWaG2rTVoOiUwn3ov5jFujXmfDMy5jOM4IZxE1GKBMmTfViM7i7+At1W5CXP5G
        DO8iPJ5Suilb1FfXs8DUXq4ZkYfCk2wV2H/lzYGMvqpgzdTZ6w6mpj33z4Sf6QQ7wFkJs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gIBfI-0005Si-Mp; Thu, 01 Nov 2018 12:01:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 51B76112260E; Thu,  1 Nov 2018 12:01:32 +0000 (GMT)
Date:   Thu, 1 Nov 2018 12:01:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mfd: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20181101120132.GB6425@sirena.org.uk>
References: <20181008132542.19775-2-ckeepax@opensource.cirrus.com>
 <20181025074459.GF4939@dell>
 <20181025082621.GD16508@imbe.wolfsonmicro.main>
 <b2f85f45-cbe9-5a27-e9e8-ad28f2bd9bd6@opensource.cirrus.com>
 <20181025114205.GC4870@dell>
 <33ea391c-aa6e-2709-6faf-4905e84229e4@opensource.cirrus.com>
 <20181026080051.GK4870@dell>
 <20181026203223.GC27137@sirena.org.uk>
 <20181029110439.GS4870@dell>
 <20181101102828.GM16508@imbe.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <20181101102828.GM16508@imbe.wolfsonmicro.main>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 01, 2018 at 10:28:28AM +0000, Charles Keepax wrote:

>      1.2) Read all the registers from the device on boot
>           + Uses less memory
>           - Potentially very slow boot time
>      1.3) Only read values as you touch registers
>           + Uses less memory
>           + Usually no significant impact on boot time
>           - Can't do read or read/write/modify operations on
>             previously untouched registers whilst chip is off

Both of these options also require that you be able to reset the device
which isn't possible with all devices and systems.

> I think this really the crux of my concerns here about updating
> the regmap API are that it feels like almost any path we take
> from here results in worse runtime performance and probably
> equal or worse memory usage. In return we gain a reduction of
> some, whilst admittedly large, very simple data tables from
> the driver. Which is a trade it feels hard to get invested in.

Right, I don't see an urgent problem either - if the tables were
complicated to think about it'd be a bit different but they aren't
particularly and like you say there's tradeoffs both at runtime and
at development time for trying to make the source code smaller.

Equally if there are useful things we can add to the API for some use
cases I'm all for that so long as they don't get in the way of other
users, most of the extensions in the API have come from someone having
problems and coming up with a fix that meets their needs.

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlva6xsACgkQJNaLcl1U
h9AUYwf+IUmDzPcdlodvzcs+ZOUhcBjC7S/MICFtj7twgXZi+BO5NgW1PaM8h7Lf
AS37zt9SaHAuEIiSjUMx4NCrVxyJde5vXCIpTgMSZDtcRcIkZupkoXhK7Wsugdou
gNPlXZTCn05PUocMgD+krPxt82X5mvaFwIQN82YATqZ35FAdGGAX60r+aJUIfqdQ
Qdk0TpfiAbbigxC9r440lOdx0SD96GNrOhNF8bpF97AyGUQbwDMrgDWMxYewjxKI
hdY8rsQjteyNl9OrD8efCfTsMzdv3Oc+ttdOqWuC7sLtEO60FCvwUWc48cDw1KOl
oKDtYPqeEHWjNjT6JMzsjsrH8w2FqQ==
=w1Pu
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
