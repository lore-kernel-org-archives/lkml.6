Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301E5C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0742E2084D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbfAHXmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:42:50 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38974 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfAHXmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:42:49 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 522F980868; Wed,  9 Jan 2019 00:42:42 +0100 (CET)
Date:   Wed, 9 Jan 2019 00:42:47 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     joeyli <jlee@suse.com>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 0/5 v2][RFC] Encryption and authentication for hibernate
 snapshot image
Message-ID: <20190108234246.GA22310@amd>
References: <20190103143227.9138-1-jlee@suse.com>
 <20190106181026.GA15256@amd>
 <20190107173743.GC4210@linux-l9pv.suse>
 <CALCETrWHjn_WN1WRc2pbFPB+H-ZL_1y=8dhhHoVqA53Q7Pj5vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <CALCETrWHjn_WN1WRc2pbFPB+H-ZL_1y=8dhhHoVqA53Q7Pj5vA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> Please explain your security goals.
> >
> > My security goals:
> >
> > - Encrypt and authicate hibernate snapshot image in kernel space. Users=
pace
> >  can only touch an encrypted and signed snapshot image.
>=20
> Signed?
>=20
> I=E2=80=99m not entirely convinced that the keyring mechanism is what you
> want. ISTM that there are two goals here:
>=20
> a) Encryption: it should be as hard as can reasonably be arranged to
> extract secrets from a hibernation image.
>=20
> b) Authentication part 1: it should not be possible for someone in
> possession of a turned-off machine to tamper with the hibernation
> image such that the image, when booted, will leak its secrets. This
> should protect against attackers who don=E2=80=99t know the encryption ke=
y.
>=20
> c) Authentication part 2: it should be to verify, to the extent
> practical, that the image came from the same machine and was really
> created using hibernation.  Or maybe by the same user.

So... this looks like "security goals" I was asking in the first
place. Thanks!

Could we get something like that (with your real goals?) in the next
version of the patch?

> As far as I can tell, there is only one reason that any of this needs
> to be in the kernel: if it=E2=80=99s all in user code, then we lose =E2=
=80=9Clockdown=E2=80=9D
> protection against compromised user code on a secure boot system.  Is
> that, in fact, true?

And this is what I'd really like answer to. Because... I'd really like
this to be in userspace if it does not provide additional security
guarantees.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw1NXYACgkQMOfwapXb+vK+qACeNG5cXLr+M4bSX4Me0sXYysM8
CIwAnAoNvfPDRrv/MT3jN/y0LdEbo0lu
=l/CK
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
