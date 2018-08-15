Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0986C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC61215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="mwEzniFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC61215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbeHON56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 09:57:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35368 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeHON56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 09:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OJ877SZY1ZktoTT6yI6epDGPYDCit5ffhV9TN7QDIvY=; b=mwEzniFPIIvaVBmSF7UvW+Y+s
        xpJKfNRsvDxkMqB9fcZqwkRA0maC6S0uX/9YkfAlkhB6GUbg5oIngtqSOUYCcUvPqzn/7vpF7iW91
        MonjPfKogG84MiKKEm4V2bgp93qfOukIqu+57qtv5PRqNc8U/PbEj5wZA84Hca7yLfKn0=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fptcx-0001bL-Uy; Wed, 15 Aug 2018 11:06:12 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id A8509440078; Wed, 15 Aug 2018 12:06:10 +0100 (BST)
Date:   Wed, 15 Aug 2018 12:06:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     David Collins <collinsd@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] regulator: core: If consumers don't call
 regulator_set_load() assume max
Message-ID: <20180815110610.GX2414@sirena.org.uk>
References: <20180814170617.100087-1-dianders@chromium.org>
 <20180814170617.100087-2-dianders@chromium.org>
 <bf70f01d-41ac-dcdc-b503-5e0eb1e70329@codeaurora.org>
 <CAD=FV=VNCOyyq5+xvSudTmtBgPm4-s7gj7GRCvuL5vSmA6yDVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ulNsWUvGrZAj8PMr"
Content-Disposition: inline
In-Reply-To: <CAD=FV=VNCOyyq5+xvSudTmtBgPm4-s7gj7GRCvuL5vSmA6yDVA@mail.gmail.com>
X-Cookie: Many are called, few volunteer.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ulNsWUvGrZAj8PMr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 14, 2018 at 01:03:07PM -0700, Doug Anderson wrote:

> Specifically I will note that there are boatloads of drivers out there
> that use the regulator framework but don't have a call to
> regulator_set_load() in them.  Are these drivers all broken?  I don't
> think so.  IMO the regulator_set_load() API is an optional call for
> drivers that they can use to optimize power usage, not a required API.

Very few systems dynamically change modes in the first place, if we were
doing this as a matter of course you could claim the drivers were buggy
but really it's unusual for it to even be a useful thing to do - as it
is it's more an accomodation for a small subset of systems.  This does
mean that those systems have to pay attention to making sure that
everything works well which is unfortunate but it's not unreasonable.

Forcing the mode to the highest available would be a step backwards for
most systems.

--ulNsWUvGrZAj8PMr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlt0CSEACgkQJNaLcl1U
h9CWwwf8DyzU0sVGYVNbSZw2aH0SSUeW2Cuy6SmKta24xpoxewOvCTw46iAUMj6X
qD4Et23y79goGt6sunMLGFOSgz08lMzzVHD0ffMLKVLm6oLpGUoNtioV5MEruL68
6C6EU69K464hbdYPXYS5k6eRzmyhTVdvpZlq1ncdKv7egRchons8vtoeVf1RHVRG
DHuDq+B/rNGmQDjoP4LTiow/j3yC5QQ6oqRVOhx6bXg7oj/LBCJSXWo4B6a+40Vd
NiQHLJUJBl2x2GySt4S7puxDlP4dDhlpWYe4rScKTHI1TPLgqzRx0Zn4Fv7yHrEb
9G+2TBSBbGYN6R8nf1o/AtNalTXlfA==
=4lkN
-----END PGP SIGNATURE-----

--ulNsWUvGrZAj8PMr--
