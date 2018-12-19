Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5488C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1A420873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbeLSW1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:27:41 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56247 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbeLSW1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:27:40 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 79EF180A9F; Wed, 19 Dec 2018 23:27:33 +0100 (CET)
Date:   Wed, 19 Dec 2018 23:27:37 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
Message-ID: <20181219222737.GB30496@amd>
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20181219162626.12297-3-dmurphy@ti.com>
 <20181219193455.GA21159@amd>
 <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com>
 <20181219201047.GA23448@amd>
 <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <20181219220326.GA28244@amd>
 <a3214ab3-9281-19d6-7fcc-5abae9a60ebd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <a3214ab3-9281-19d6-7fcc-5abae9a60ebd@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

[cc list trimmed]

> >>> I don't think a user needs nor would want to have 24 different LED no=
des with 24 different brightness files.
> >>> Or with the LP5036 that would have 36 LED nodes.
> >>>
> >>> Table 1 in the data sheet shows how the outputs map to the control ba=
nks to the LED registers.
> >>
> >> Some time ago we had discussion with Vesa J=E4=E4skel=E4inen about pos=
sible
> >> approaches to RGB LEDs [0]. What seemed to be the most suitable
> >> variation of the discussed out-of-tree approach was the "color" proper=
ty
> >> and array of color triplets defined in Device Tree per each color.
> >>
> >> Please refer to [0] for the details.
> >>
> >> [0] https://lkml.org/lkml/2018/11/9/938
> >=20
> > Yes, plus I also have the set of HSV patches somewhere... and they
> > work, but I found out that HSV->RGB conversion results in loss of preci=
sion.
> >=20
> > We may want to do something like that.
> >=20
> > But we need to do it once, in a driver core. We obviously don't want
> > each driver having different version of RGB support.
>=20
> True.  But the RGB driver really should not be defining the color palette.
>=20
> Maybe a "color capability" reported to user space so that the user space =
can make the decision.
>=20
> It can report
>=20
> For GPIO or constant current situations
> static red
> static blue
> static green=20
>=20
> For adjustable configurations it can report:
> variable red
> variable blue
> variable green
>=20
> or even simpler "static" or "dynamic" as a return to report the RGB confi=
guration.
> The LED driver would just need to set the variable.

I'm not sure what static/variable is.

I have RGB leds here that can set any channel to 0-255, at
runtime. They seem to be quite common at phones.

Anyway, if your 36 channels can be set independently, I believe you
just want them to export as 36 LEDs.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwaxdkACgkQMOfwapXb+vIV3QCfcYJM8VPdCZQxaX0y9mrvxKRl
FQ0AnRIzgL0rg5Yy6TRRBbLLSJSSKWrp
=gkmt
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
