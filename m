Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92F7C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9640E2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9640E2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeK3Tvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:51:52 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36153 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeK3Tvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:51:52 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D6034808FF; Fri, 30 Nov 2018 09:43:12 +0100 (CET)
Date:   Fri, 30 Nov 2018 09:43:15 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH RFC 4/5] gnss: sirf: add a separate supply for a lna
Message-ID: <20181130084315.GA25587@amd>
References: <20181118215801.12280-1-andreas@kemnade.info>
 <20181118215801.12280-5-andreas@kemnade.info>
 <20181127180356.GA32751@localhost>
 <20181130073804.1e57226f@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20181130073804.1e57226f@kemnade.info>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-11-30 07:38:04, Andreas Kemnade wrote:
> Hi,
>=20
> On Tue, 27 Nov 2018 19:03:57 +0100
> Pavel Machek <pavel@ucw.cz> wrote:
>=20
> > Hi!
> >=20
> > > Devices might have a separate lna between antenna output of the gps
> > > chip and the antenna which might have a separate supply =20
> >=20
> > Might have.
> >=20
> > > @@ -340,6 +349,12 @@ static int sirf_probe(struct serdev_device *serd=
ev)
> > >  		goto err_put_device;
> > >  	}
> > > =20
> > > +	data->lna =3D devm_regulator_get(dev, "lna");
> > > +	if (IS_ERR(data->lna)) {
> > > +		ret =3D PTR_ERR(data->lna);
> > > +		goto err_put_device;
> > > +	}
> > > + =20
> >=20
> > But it is not optional in the code. Probably should be?
>=20
> well, if it no lna regulator is defined in the dtb, the regulator
> framework will return a dummy

Aha, did not know that detail. It is ok, then...

> would not do that and would require more error checking in the code.
> But if there is some rule which says that devm_regulator_get_optional()
> should be used here, I can of course change that.
> Before sending a v2, is that the only issue here?

Quick look did not reveal anything else.

Best regards,
							Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwA+CMACgkQMOfwapXb+vKJxACgoJeecgtF1KtFCjEppOxKBsxy
OIUAn1ov1xofhbf3qXKyY8ipAR43iEIe
=3odg
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
