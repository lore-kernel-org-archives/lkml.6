Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BCBC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B5721523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B5721523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388365AbeIUAxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:53:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51896 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbeIUAxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:53:54 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A4C26805F4; Thu, 20 Sep 2018 21:08:55 +0200 (CEST)
Date:   Thu, 20 Sep 2018 21:08:55 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 2/4] [media] ad5820: Add support for enable pin
Message-ID: <20180920190855.GC26589@amd>
References: <20180920161912.17063-2-ricardo.ribalda@gmail.com>
 <20180920184552.4919-1-ricardo.ribalda@gmail.com>
 <20180920185405.GA26589@amd>
 <CAPybu_2hjrq=r+kpAHKxX59gOXfbqGf9CUPh9CNqv7WGqJsrQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline
In-Reply-To: <CAPybu_2hjrq=r+kpAHKxX59gOXfbqGf9CUPh9CNqv7WGqJsrQQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-09-20 21:06:16, Ricardo Ribalda Delgado wrote:
> Hi Pavel
>=20
> On Thu, Sep 20, 2018 at 8:54 PM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > On Thu 2018-09-20 20:45:52, Ricardo Ribalda Delgado wrote:
> > > This patch adds support for a programmable enable pin. It can be used=
 in
> > > situations where the ANA-vcc is not configurable (dummy-regulator), or
> > > just to have a more fine control of the power saving.
> > >
> > > The use of the enable pin is optional.
> > >
> > > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> >
> > Do we really want to do that?
> >
> > Would it make more sense to add gpio-regulator and connect ad5820 to
> > it in such case?
> >
>=20
> My board (based on db820c)  has both:
>=20
> ad5820: dac@0c {
>    compatible =3D "adi,ad5820";
>    reg =3D <0x0c>;
>=20
>    VANA-supply =3D <&pm8994_l23>;
>    enable-gpios =3D <&msmgpio 26 GPIO_ACTIVE_HIGH>;
> };

Well, I'm sure you could have gpio-based regulator powered from
pm8994_l23, and outputting to ad5820.

Does ad5820 chip have a gpio input for enable?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluj8EYACgkQMOfwapXb+vIppQCfZMS0Dn9kQEGRE+8Is0TzxyAW
yeoAn1lB3o8EY1sfO3UhWQQ7vbNMdGvc
=An5N
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
