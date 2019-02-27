Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1068CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FF621850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551297952;
	bh=eDafnfobkT2tR05HR4+oM59DDBGBuCrpgimmTqfMfR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ssovjp3Is8qm1X8LQHCAX10u7J8B305+tSF+C+KPgoiro1Cap6tYyeB8xCb4mgj1f
	 y2aVwAQS69DUw28vdeCKm8USNaHl1+JS5bpB4iJNLaQCihJhj2SCfyg02hHv2ZA/FL
	 VqMi3djgoDntA9JqqQUvGjMdZENlq+oIAg0SEIvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbfB0UFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:05:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60696 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730316AbfB0UFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jOiz8C+dwOIx838o7A1aeUXxnk9nvtNdF8e/8hwyYLU=; b=ozVa8+cBMcBEZgLmgpW4bJDVx
        WXMx/iZUPYN6H1Ua9z6ZFuNLE3IBesfXJnQytKvrNTK3tJplM/nEyOI3a3r44IjFMRES3JlqHKplG
        Vong85MabQeJAuOXOYe96oYpTb4z+nxIMKqf3YBfxiBfYXGt0ieffgF6TDgk7ef+zu8EE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gz5SU-0008DH-5N; Wed, 27 Feb 2019 20:05:38 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 299641127A15; Wed, 27 Feb 2019 20:05:37 +0000 (GMT)
Date:   Wed, 27 Feb 2019 20:05:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Olliver Schinagl <oliver@schinagl.nl>
Cc:     Axel Lin <axel.lin@ingics.com>, Chen-Yu Tsai <wens@csie.org>,
        Priit Laes <plaes@plaes.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: axp20x: Get rid of AXP20X_xxx_START/END/STEPS
 defines
Message-ID: <20190227200537.GB11065@sirena.org.uk>
References: <20190220165013.12774-1-axel.lin@ingics.com>
 <24E35288-677D-4223-B94A-52A4F37792A8@schinagl.nl>
 <CAFRkauAPGEBxj7k2GvmFwhyc7ZuofhXou17b75F3G-mUWVaf9A@mail.gmail.com>
 <20190221094237.GA5970@sirena.org.uk>
 <d52c2711-71f3-9e72-f01b-e761f4a92a07@schinagl.nl>
 <CAFRkauDdx00VmqhmzohdCyWbPkctCU2D03JqkpSw2x7n-bDzHA@mail.gmail.com>
 <15e97e28-0008-cda4-176d-a3feb9ad4e8a@schinagl.nl>
 <20190225172519.GD13898@sirena.org.uk>
 <c277f7e1-09d9-b6e1-e5d6-8b2f88042e9c@schinagl.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
In-Reply-To: <c277f7e1-09d9-b6e1-e5d6-8b2f88042e9c@schinagl.nl>
X-Cookie: To teach is to learn.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 27, 2019 at 08:41:46PM +0100, Olliver Schinagl wrote:
> On 25-02-2019 18:25, Mark Brown wrote:

> > If you find you need to describe what the fields are it would be much
> > more constructive to add a comment at the top of the table saying what
> > they are.  As things are this isn't helping anyone - as a big pile of
> > defines it's hard to read the values without context for how they're
> > used and if you're looking at the table you can't tell what the
> > regulator actually supports without going and decoding the defines.

> Then the name of the define should be more constructive, which imo they
> are reasonably? But as everything with programming, naming things is the
> he hardest part, right?

I really don't think that's it - I think that sometimes a data table is
just a data table.  There are some coding styles that work to avoid
having raw numbers anywhere in code outside of defines at all costs but
I do think that goes too far in cases like this where the name of the
define is at some level just going to summarize what should go in a
given slot in a table which adds little.

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx27ZAACgkQJNaLcl1U
h9Ciwgf+NerNXaWQi+3pgVYeq9dUbDJIlJLGeFxz+fW/Hmg/laK28XYlvDctP516
oq+SCMW7xi2U5LmO+pf5x1/MSenaEFS9YQVahpcBlkyHs3PbA4KXvf5dGo+sdFgA
I7vwdSOBEd8Il8Dchja4NyBkm5Efo60vCbyZmbB+GaR/GwRVZGkFf0CRMhhk8Q+Y
2Paw5gxCKDXt+YrD5xs2os4/6GjWMInJwugiCBcZhbXh9UnhiKtzlcesFyKMF90D
4JplpxD+xusB3vh/VbzIX60bas+B2vEn85oPcBEPnlwXQqYMwhAHKgOeAXJ00yvX
Q9MrTHvV3sXA0G4QIAPnuMH2mdxP+Q==
=jVRG
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
