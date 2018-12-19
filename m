Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0540DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7F020811
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbeLSUKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 15:10:50 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52410 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbeLSUKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 15:10:50 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 720B080A8C; Wed, 19 Dec 2018 21:10:43 +0100 (CET)
Date:   Wed, 19 Dec 2018 21:10:47 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
Message-ID: <20181219201047.GA23448@amd>
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20181219162626.12297-3-dmurphy@ti.com>
 <20181219193455.GA21159@amd>
 <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-12-19 13:41:18, Dan Murphy wrote:
> Pavel
>=20
> Thanks for the review.
>=20
> On 12/19/2018 01:34 PM, Pavel Machek wrote:
> > Hi!
> >=20
> >> +static DEVICE_ATTR_WO(ctrl_bank_a_mix);
> >> +static DEVICE_ATTR_WO(ctrl_bank_b_mix);
> >> +static DEVICE_ATTR_WO(ctrl_bank_c_mix);
> >> +
> >> +static struct attribute *lp5024_ctrl_bank_attrs[] =3D {
> >> +	&dev_attr_ctrl_bank_a_mix.attr,
> >> +	&dev_attr_ctrl_bank_b_mix.attr,
> >> +	&dev_attr_ctrl_bank_c_mix.attr,
> >> +	NULL
> >> +};
> >> +ATTRIBUTE_GROUPS(lp5024_ctrl_bank);
> >=20
> > ...
> >> +
> >> +static DEVICE_ATTR_WO(led1_mix);
> >> +static DEVICE_ATTR_WO(led2_mix);
> >> +static DEVICE_ATTR_WO(led3_mix);
> >> +
> >> +static struct attribute *lp5024_led_independent_attrs[] =3D {
> >> +	&dev_attr_led1_mix.attr,
> >> +	&dev_attr_led2_mix.attr,
> >> +	&dev_attr_led3_mix.attr,
> >> +	NULL
> >> +};
> >> +ATTRIBUTE_GROUPS(lp5024_led_independent);
> >=20
> > Ok, so you are adding new sysfs files. Are they _really_ neccessary?
> > We'd like to have uniform interfaces for the leds.
>=20
> Yes I am adding these for this driver.
> They adjust the individual brightness of each LED connected (what the HW =
guys called mixing).
>=20
> The standard brightness sysfs adjusts all 3 LEDs simultaneously so that a=
ll 3 LEDs brightness are
> uniform.

1 LED, 1 brightness file... that's what we do. Why should this one be diffe=
rent?

> I did not think these belonged in the dt as they should be user space con=
figurable
>=20
> >=20
> > If they are neccessary, we need documentation for them.
>=20
> Sure I have no problem documenting them but where do I do that?
> I am assuming Documentation/leds/leds-lp5024.txt

Documentation/abi/...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwapccACgkQMOfwapXb+vKbmACfdrR6iMX5b7SewUD8Q44amTHK
TQUAnieGmLLgxm7S3o05Eg8KzrAOxw5j
=mBmG
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
