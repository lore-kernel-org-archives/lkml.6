Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E99C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F27D2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F27D2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbeJXQ6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:58:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47995 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJXQ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:58:54 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2E50680699; Wed, 24 Oct 2018 10:31:43 +0200 (CEST)
Date:   Wed, 24 Oct 2018 10:31:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>, rteysseyre@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 1/2] leds: core: Introduce LED pattern trigger
Message-ID: <20181024083143.GA24165@amd>
References: <9794969ab8a5a6f62d8ac54cdebcaa3caedfc6d6.1539230481.git.baolin.wang@linaro.org>
 <d90397dd-429f-4f3f-307c-b69dccc360e0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <d90397dd-429f-4f3f-307c-b69dccc360e0@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > +
> > +		The gradual dimming format of the software pattern values should be:
> > +		"brightness_1 duration_1 brightness_2 duration_2 brightness_3
> > +		duration_3 ...". For example:
> > +
> > +		echo 0 1000 255 2000 > pattern
> > +
> > +		It will make the LED go gradually from zero-intensity to max (255)
> > +		intensity in 1000 milliseconds, then back to zero intensity in 2000
> > +		milliseconds:
> > +
> > +		LED brightness
> > +		    ^
> > +		255-|       / \            / \            /
> > +		    |      /    \         /    \         /
> > +		    |     /       \      /       \      /
> > +		    |    /          \   /          \   /
> > +		  0-|   /             \/             \/
> > +		    +---0----1----2----3----4----5----6------------> time (s)
> > +

Ok, so I got around to testing this.

echo "0 1000 10 2550 0 1000 0 100" > pattern

makes expected pattern [  .-xXx-.  ].

But when I do

echo "0 1000 10 2550 0 1000" > pattern

I only get expected pattern on the first iteration, then I get
[    Xx-.   ].

I'm using led-controller:flash on nokia n900 (so everything in
software).

> OK, let's abide by constant update interval for now.
>=20
> Thank you for your work on this patch set throughout
> all these months. We will have -rc8, so one week of testing
> before sending upstream should be enough.
>=20
> Patch set applied to the for-next branch of linux-leds.git.

Thanks!
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvQLe8ACgkQMOfwapXb+vJv3wCcCzjCiv8b5zBW5DE6MWaAQVjS
oxUAn3rZi5MI0deWIzolnVib0O+1VRRC
=4v+J
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
