Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADC3ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF99208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF99208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbeGPJDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:03:41 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33979 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeGPJDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:03:40 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 0C4B680388; Mon, 16 Jul 2018 10:37:20 +0200 (CEST)
Date:   Mon, 16 Jul 2018 10:37:20 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>, DRivshin@allworx.com
Cc:     Sebastian Reichel <sre@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net,
        merlijn@wizzup.org
Subject: Re: [PATCH] pwm-omap: handle timers not ready in probe
Message-ID: <20180716083720.GA3047@amd>
References: <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
 <20180711132739.GL99251@atomide.com>
 <20180711142526.dto6iost57zx5t5l@earth.universe>
 <20180716071323.GB23110@amd>
 <20180716075740.GT99251@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20180716075740.GT99251@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-07-16 00:57:40, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180716 07:16]:
> >=20
> > When all the drivers are built-in, timers are not ready and probing
> > fails. Fix that with -EPROBE_DEFFER.
> >=20
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >=20
> > diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmti=
mer.c
> > index 665da3c..debeb70 100644
> > --- a/drivers/pwm/pwm-omap-dmtimer.c
> > +++ b/drivers/pwm/pwm-omap-dmtimer.c
> > @@ -265,7 +271,7 @@ static int pwm_omap_dmtimer_probe(struct platform_d=
evice *pdev)
> >  	timer_pdata =3D dev_get_platdata(&timer_pdev->dev);
> >  	if (!timer_pdata) {
> >  		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
> > -		ret =3D -EINVAL;
> > +		ret =3D -EPROBE_DEFER;
> >  		goto put;
> >  	}
>=20
> There seems to be an earlier similar patch, care to take a look
> at "[PATCH] pwm: pwm-omap-dmtimer: return -EPROBE_DEFER if no
> dmtimer platform data"?

Yes, that one is equivalent.

You can add

Acked-by: Pavel Machek <pavel@ucw.cz>
Tested-by: Pavel Machek <pavel@ucw.cz>

on it.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltMWUAACgkQMOfwapXb+vI5zwCgtqHRoJVmYUG/mvzzRXErAeRS
UNYAoK7oDOTjteMR0KarRfPYlMHNvSLc
=ssz9
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
