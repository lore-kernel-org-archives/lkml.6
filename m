Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7C2C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA2B2080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfBETIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:08:53 -0500
Received: from sauhun.de ([88.99.104.3]:59762 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfBETIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 14:08:53 -0500
Received: from localhost (p54B3337A.dip0.t-ipconnect.de [84.179.51.122])
        by pokefinder.org (Postfix) with ESMTPSA id 5759C2C0509;
        Tue,  5 Feb 2019 20:08:51 +0100 (CET)
Date:   Tue, 5 Feb 2019 20:08:50 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     John Sperbeck <jsperbeck@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: core-smbus: don't trace smbus_reply data on errors
Message-ID: <20190205190849.GA2686@kunai>
References: <20190104004203.116155-1-jsperbeck@google.com>
 <20190103214927.2bf947ca@vmware.local.home>
 <20190205121353.GC1045@kunai>
 <CAFNjLiU_KOmcBHykHt5JTr439DJVf=j=aGKpnObZfMx6nLreRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <CAFNjLiU_KOmcBHykHt5JTr439DJVf=j=aGKpnObZfMx6nLreRQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > Hmm, instead of tracing nothing, as this is already a "conditional
> > > trace event", why not add to that condition:
> > >
> > >       TP_CONDITION(res >=3D 0 && read_write =3D=3D I2C_SMBUS_READ),
> > >
> > > Unless you want to still trace some data on failure.
> >
> > John, any comment to this?
> >
>=20
> The issue we were dealing with was access to uninitialized memory on the =
stack.
> The change '30f939feaeee i2c: fix kernel memory disclosure in dev interfa=
ce'
> does the initialization, so the tracing code is no longer affected.
> We just didn't
> have that change in the particular kernel we were testing.
>=20
> Still, Steven's suggestion seems fine to me.  Would you like me to create=
 a new
> patch based on that?

I am not a tracing expert, but all that was said here tell me that it
would be better to have the change. So, yes, please, that would be
appreciated.


--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxZ3z0ACgkQFA3kzBSg
KbZSnRAAse5m17YZ87jPvZW5/jzAYKc8+HNDT+dPU858YQKZ+Cun6dRL9WXVd3pr
3tQXdDZ8/L6ruCeIegq32ZD5ogP1T3aZBpn/nYbehT+wn2lKklrbk76exBcpy6+x
jmBv9DX4vPdMslFxOAHTTIoe70y3wGhIYZSP77U4qhtd5REB4NlbVjNRf0ley56L
iqi5VB6GmsHBHgr6x8Wj/qb1/52FFvqFBnelDYttNfb3dBBGbAJV9Bgg23YmM2bw
FeR+3ofSEhvaK3fnsNqNpclNHtciyGtKAkukHArTpdLsjYmZ5AanIihPHPRV7vVD
dNq52DKALQ7A+XOp9vBDTMQBWPvEW9U9ykUyWSGqgnQgkzsjN1p37g/FAqDcf/zb
Xa/6RvFnBa+MiQpiwWZoD5/VDzcbfGTdN+IHAXfhYKa5Ip7A8GRlnCofA+kW5jrT
aCgTsWosKPsP1YNb0jv8novwOvFplxhQWlQmJRdGQia9hP5+N9+k/MbpkwtIP9Ln
5z34sVQ5CvuUQ/UMEnKGSrp7ox3E6WV1IBu2ZUELUcUicv8P518qUtCulx8YWtPV
IMdvvg1vM5K9DT3XSZIlGf2ZjsGZbQFzLcQsAB/gazx6XuvwrPxN21B98STNPrcf
axyHXpfYM2d6aUfPqKlg8EfhgdcIHxIDEmwW/2oZjtXlRuMyMDk=
=S5W0
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
