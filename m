Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDC0C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619A82098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="wQ+eKZpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619A82098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJMARz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:17:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47986 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJMARy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PIR5VAkfWnGisumi64vqX9c8b+99ZQivVR52p2t2vw4=; b=wQ+eKZpVDndqAMd8vspazhOJk
        Km3vKM68MaG/lRZl87/z/QMjw6l6eB6Vx3pSsnR0ZpEyqb5EmGv4ozxcYIvYBd7uGRRENbtbIWMsE
        KS0iTRdkL09ySdbV18AOXGDCm1Z0ceE1X9EAZO6UO3cWWxb9oR15UgtOJTBG8ugBpviAI=;
Received: from [91.126.136.150] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gB0Y5-0006al-Ba; Fri, 12 Oct 2018 16:44:25 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D0DA6440078; Fri, 12 Oct 2018 18:44:24 +0200 (CEST)
Date:   Fri, 12 Oct 2018 18:44:24 +0200
From:   Mark Brown <broonie@kernel.org>
To:     jacopo mondi <jacopo@jmondi.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH v2] regulator/gpio: Allow nonexclusive GPIO access
Message-ID: <20181012164424.GE2340@sirena.org.uk>
References: <20181012125412.21324-1-linus.walleij@linaro.org>
 <20181012142612.GJ7677@w540>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
Content-Disposition: inline
In-Reply-To: <20181012142612.GJ7677@w540>
X-Cookie: He's dead, Jim.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 04:26:12PM +0200, jacopo mondi wrote:

> Sorry, I'm going slightly OT with this, but please read below.

> On Fri, Oct 12, 2018 at 02:54:12PM +0200, Linus Walleij wrote:
> > This allows nonexclusive (simultaneous) access to a single
> > GPIO line for the fixed regulator enable line. This happens

> I might have a use case for shared GPIO lines used as 'simple' reset
> signal for camera devices and not for regulators.

This recently came up in ASoC too with audio CODECs sharing reset lines,
there was a discussion started with the reset API maintainer though no
response yet.  CCing in Cheng-yi who had that problem.  Not deleting
context for that.

> See drivers/media/i2c/ov772x.c FIXME note in power_on() function at:
> https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/ov772x.c=
#L832
>=20
> The reset line is in this case is passed to the driver by board file:
> https://elixir.bootlin.com/linux/latest/source/arch/sh/boards/mach-migor/=
setup.c#L350
>=20
> As you can see PTT3 is used for both sensors (I know, questionable
> HW design...)
>=20
> Do you think extending gpiod_lookup_flags with this newly introduced
> NONEXCLUSIVE one is an acceptable solution to avoid handling this in
> the sensor driver like we're doing today?

One problem you've got there is that you need the two devices to know
about each other so they coordinate their use of the reset line.  This
was relatively easy in the sysetm Cheng-yi has as it's just one driver
but what if there's mutiple drivers?  That's relatively likely with
audio where you might have something like a CODEC with a separate power
amplifier.  The regulator enable stuff is handling this in the core but
it's less clear where to put that for reset lines.

> Please note this is an ancient architecture that boots from board
> files, but the same might happen in modern designs with OF support. Is
> there any clean way to handle shared GPIOs I might not be aware of for
> those systems?

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvAz2gACgkQJNaLcl1U
h9Dghgf/QYGQR+/EtUlEcvLClnxcuMJn1cmuMyRx2H9O3ZutEWX1Am9+7nfw9gEZ
cDbHLErdpR0UJ/+KqoB1pX+MSwioI/ItZ5JhaIZ6BVlQltkUs9JVAhKZ+7RrObpP
LfiZSl01xHzObb1ecJK7o9D1woPNlclRGQa4Njbjqp5kiztzDGzUH7xviR3A2I2H
LwxuJXnrtZ6Z2oGCAfyCak6j+JnlxsxfvEB0HM8xk/1A0iHGGyhOKrOby98ocxp5
FqvW3fE5t2oGltifP5aN7xEUSbbar3Wuyig3WqG7SH5eiPshkjlJGN0C82IdZXX8
C0M5Aj/0Vcz6dO77femaqzLzICtK7w==
=G3SA
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--
