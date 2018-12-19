Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07318C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77062133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbeLSWDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:03:30 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55548 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbeLSWD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:03:29 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 28B3280A99; Wed, 19 Dec 2018 23:03:22 +0100 (CET)
Date:   Wed, 19 Dec 2018 23:03:26 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
Message-ID: <20181219220326.GA28244@amd>
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20181219162626.12297-3-dmurphy@ti.com>
 <20181219193455.GA21159@amd>
 <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com>
 <20181219201047.GA23448@amd>
 <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >I don't think a user needs nor would want to have 24 different LED nodes=
 with 24 different brightness files.
> >Or with the LP5036 that would have 36 LED nodes.
> >
> >Table 1 in the data sheet shows how the outputs map to the control banks=
 to the LED registers.
>=20
> Some time ago we had discussion with Vesa J=E4=E4skel=E4inen about possib=
le
> approaches to RGB LEDs [0]. What seemed to be the most suitable
> variation of the discussed out-of-tree approach was the "color" property
> and array of color triplets defined in Device Tree per each color.
>=20
> Please refer to [0] for the details.
>=20
> [0] https://lkml.org/lkml/2018/11/9/938

Yes, plus I also have the set of HSV patches somewhere... and they
work, but I found out that HSV->RGB conversion results in loss of precision.

We may want to do something like that.

But we need to do it once, in a driver core. We obviously don't want
each driver having different version of RGB support.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwawC4ACgkQMOfwapXb+vLNYACffdYFK7xGKYm+tAfbhDAE5uJs
jJ4AoLLb9z0NH5aRd7BxwnfKc5ZK2F4e
=YXOP
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
