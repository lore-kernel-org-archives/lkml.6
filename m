Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6723FC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1AC206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1AC206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeKTTo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:44:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48765 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeKTTo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:44:27 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 69DEC80848; Tue, 20 Nov 2018 10:16:17 +0100 (CET)
Date:   Tue, 20 Nov 2018 10:16:19 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Daniel Drake <drake@endlessm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, linux@endlessm.com,
        =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita 
        <jprvita@endlessm.com>
Subject: Re: [PATCH] ACPI / battery: Fix reporting "Not charging" when
 capacity is 100%
Message-ID: <20181120091619.GC16916@amd>
References: <20181103065732.12134-1-jprvita@endlessm.com>
 <20181105091917.GD4439@amd>
 <CA+A7VXXUB2CZUyPtaMya7in7ntO_unbqVnaZyfCBT_BXtAxeQQ@mail.gmail.com>
 <CAD8Lp46Go79C_xOkzM-hq4umET1M62Ofqw48swn1JNocifET3Q@mail.gmail.com>
 <c883a2be-e772-2e18-f074-d2ad5f27f42b@redhat.com>
 <20181111122243.GB28794@amd>
 <CA+A7VXWwfh-jdiq60kwY65k29BXP6PNOc9=X7b6SYF9=T65UUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
In-Reply-To: <CA+A7VXWwfh-jdiq60kwY65k29BXP6PNOc9=X7b6SYF9=T65UUA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Anyways this ultimately is Rafael's call. If Rafael is ok with this
> > > patch then I would like to see Pavel's comment addressed and otherwise
> > > it is fine with me.
> > >
>=20
> If we can get to an agreement on this I'll send a v2 without division.
>=20
> > > Note that we will still often get the case where a laptop is charged,
> > > reports full, is unplugged for 5 minutes and then replugged and then
> > > reports a capacity of 97% combined with "not charging", so we will
> > > still need to fix userspace to handle this.
> >
>=20
> Yes, I agree that should be addressed in userspace, as it is pretty
> much a policy decision.

But it is battery hardware doing this. So you need to take it into
account.

> > For the record, I don't think I'm okay with this.
> >
> > There's nothing special about 100% charge.
> >
>=20
> I don't agree there is nothing special about 100% charge. There is a
> separate state to represent battery full for a reason, which is the
> user wanting to know when their battery is 100% charged and not being
> discharged.

Yes, there is full for a reason, and you can be full at 97%, for
example, as described above.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvz0OMACgkQMOfwapXb+vJ+igCfXlDGd4AeNoGI/VnrvjZjr2k3
j0QAn2A4PxgNbz0dlyKlmULTX7yQOJbv
=Y3VY
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
