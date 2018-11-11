Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE545C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F0D208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F0D208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeKKVSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 16:18:50 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44201 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbeKKVSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 16:18:50 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id ECCD0806BB; Sun, 11 Nov 2018 12:30:27 +0100 (CET)
Date:   Sun, 11 Nov 2018 12:30:29 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, linux@endlessm.com,
        =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita 
        <jprvita@endlessm.com>
Subject: Re: [PATCH] ACPI / battery: Fix reporting "Not charging" when
 capacity is 100%
Message-ID: <20181111113029.GD27666@amd>
References: <20181103065732.12134-1-jprvita@endlessm.com>
 <20181105091917.GD4439@amd>
 <CA+A7VXXUB2CZUyPtaMya7in7ntO_unbqVnaZyfCBT_BXtAxeQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Content-Disposition: inline
In-Reply-To: <CA+A7VXXUB2CZUyPtaMya7in7ntO_unbqVnaZyfCBT_BXtAxeQQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > >        * was plugged in and the device thus did not start a new charg=
e cycle.
> > >        */
> > >       if ((battery_ac_is_broken || power_supply_is_system_supplied())=
 &&
> > > -         battery->rate_now =3D=3D 0)
> > > +         battery->rate_now =3D=3D 0) {
> > > +             if (battery->capacity_now && battery->full_charge_capac=
ity &&
> > > +                 battery->capacity_now / battery->full_charge_capaci=
ty =3D=3D 1)
> > > +                     return POWER_SUPPLY_STATUS_FULL;
> >
> > Division? Really?

>=20
> If you look further down in acpi_battery_get_property, that is how the
> capacity property is calculated. Do you have a better suggestion?

if (battery->capacity_now >=3D battery->full_charge_capacity)

?
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvoEtUACgkQMOfwapXb+vI9LACfXmYl9qips5knDC4Qb89sNEr4
gQAAn1QbGPEm+K7c74zKapszZ12q4eJc
=rdiM
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--
