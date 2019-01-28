Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDB8C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6CA2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfA1XEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:04:12 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58927 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfA1XEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:04:11 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E3B50801AD; Tue, 29 Jan 2019 00:04:02 +0100 (CET)
Date:   Tue, 29 Jan 2019 00:04:08 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dachaac@gmail.com, robh+dt@kernel.org
Subject: Re: RGB LED class Re: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX
 family of the RGB LED driver
Message-ID: <20190128230408.GB5728@amd>
References: <ce911fdf-c7c2-63e8-5c7a-b0be965ab69b@gmail.com>
 <20190115222223.GA17363@amd>
 <79394d17-3124-75b2-ccac-dc1046499d14@ti.com>
 <20190116105537.GA1803@amd>
 <86299268-3202-814a-134b-04bd2170faab@ti.com>
 <8dfa2854-2814-6874-ab8e-1858e9a18acf@gmail.com>
 <20190118000235.GB27661@amd>
 <61fa89eb-c12e-8f9c-9457-9d6d17ba7717@gmail.com>
 <20190119213629.GA3654@amd>
 <9d2e0220-69f0-faaa-adb9-13d905f9c51d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <9d2e0220-69f0-faaa-adb9-13d905f9c51d@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>What algorithm would be used for mapping brightness levels to RGB values
> >>in case of devices without hardware support for that?
> >
> >Output power =3D brightness / max_brightness * pwm_channel[x].
>=20
> IIUC you mean it as a formula for calculating r,g,b, values?
> I.e., on brightness setting we would have to do this calculation for
> each of three channels?
>=20
> Then, it will result in changing hue as well. That's why we're
> discussing HSV.

It should not change the hue, AFAICT, modulo the rounding errors.

> >>s/pwm/color/
> >
> >s/pwm/power/ would work for me.
>=20
> Power implies physical units. I'd prefer "intensity".

Intensity would work for me, too.

> >>Besides white also other color presets could be defined in DT.
> >
> >They should not be neccessary. When userspace knows what is white and
> >that power is linear with values in power_channels, it should be able
> >to do colorspace conversion itself.
>=20
> Have you verified it in practice? Would it allow to convert RGB values
> of the color displayed on the monitor to LED RGB class intensities,
> allowing to achieve similar color on the LED?

Yes, I think so.

My code is in unicsy_demo repository, in monitor/notint.py .


									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxPimgACgkQMOfwapXb+vLTPACeMpWgjVPi9frKciJFP7fvH/CE
8v8AoIBkFjvwbnPWsHWUoVfg3EEBw3XX
=cqao
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
