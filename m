Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297B1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 16:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED35721019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 16:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeLaQ2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 11:28:33 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59233 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbeLaQ2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 11:28:32 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5CDDD80805; Mon, 31 Dec 2018 17:28:24 +0100 (CET)
Date:   Mon, 31 Dec 2018 17:28:28 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
Message-ID: <20181231162828.GA8846@amd>
References: <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
 <71d3ac12-5beb-0a26-71e1-5eae798e7b9f@gmail.com>
 <2bca210b-76ad-d5a9-906c-4151695050c3@gmail.com>
 <45ce01f0-af6e-1cc6-5126-fb557c7d2a82@ti.com>
 <b7c69135-1641-48cb-1770-c4c77a989efe@gmail.com>
 <20181229190726.GA29851@amd>
 <4b5a89ed-0c0b-3103-ca57-a0f97aa5ace9@gmail.com>
 <20181230173505.GA19593@amd>
 <7763a3ae-343c-0fbe-da88-afce8459e4c2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <7763a3ae-343c-0fbe-da88-afce8459e4c2@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>>>There is still HSV approach [0] in store. One problem with proposed
> >>>>implementation is fixed algorithm of RGB <-> HSV color space conversi=
on.
> >>>>Maybe allowing for some board specific adjustments in DT would add
> >>>>more flexibility.
> >>>>
> >>>>[0] https://lkml.org/lkml/2017/8/31/255
> >>>
> >>>Yes we could do HSV. Problem is that that we do not really have RGB
> >>>available. We do have integers for red, green and blue, but they do
> >>>not correspond to RGB colorspace.
> >>
> >>OK, so conversion from HSV to RGB would only increase the aberration.
> >>So, let's stick to RGB - we've got to have some stable ground and this
> >>is something that the hardware at least pretends to be compliant
> >>with.
> >
> >I'm not saying that we should stick to RGB. I'm just saying that
> >problem is complex.
> >
> >And no, hardware does not even pretend to be compliant with RGB color
> >model ( https://en.wikipedia.org/wiki/RGB_color_model ). In
> >particular, in RGB there is non-linear brightness curve.
>=20
> Quotation from the wiki page you referred to:
>=20
> "RGB is a device-dependent color model: different devices detect or
> reproduce a given RGB value differently, since the color elements (such
> as phosphors or dyes) and their response to the individual R, G, and B
> levels vary from manufacturer to manufacturer, or even in the same
> device over time. Thus an RGB value does not define the same color
> across devices without some kind of color management"
>=20
> This claim alone leaves much room for the manufacturers to pretend that
> their devices are compliant with RGB model.

Much room, but everyone agrees that R=3DG=3DB=3D255 should be some kind of
white, and what other colors "approximately" mean.=20

I have two monitors, and no, colors don't match.

Do you have access to RGB led? Try to compare two monitors, and then
RGB led with monitor. RGB led will be _way_ off.

This chart makes sense:

https://www.rapidtables.com/web/color/RGB_Color.html

Try it on your LED device...

> >I believe problem to start with is the "white" problem. Setting
> >R=3DG=3DB=3D255 will _not_ result in anything close to white light on
> >hardware I have.
>=20
> RGBW LED controllers solve this problem. For the devices without
> white/amber we cannot do more than the hardware allows for.

But the hardware can do some kind of white. It is just that R=3DG=3DB=3D255
will result in green-ish-blue and something like R=3D255, G=3D50, B=3D10 is
neccessary to get approximation of white.

IMO good start would be to specify what kind of intensities are
neccessary to approximate white. And then try converting from RGB to
led intensities, and see if it somehow works.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwqQ6wACgkQMOfwapXb+vJNZwCghwg2SD5PmRNKA//menJsT9pL
5WkAn21UrJAaED3VNBEzYGp+E3OIfzEq
=+Bi5
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
