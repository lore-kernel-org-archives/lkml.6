Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753514AbeD2O37 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 10:29:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52280 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752895AbeD2O36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 10:29:58 -0400
Date: Sun, 29 Apr 2018 16:29:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultanxda@gmail.com>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180429142956.GB13475@amd>
References: <d92d049a-8810-a765-d57a-2a7a805fadaf@gmail.com>
 <20180426050056.GF18803@thunk.org>
 <b902d9f5-300e-2611-289d-f6d49dd43f11@gmail.com>
 <20180426073255.GH18803@thunk.org>
 <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
 <20180426192524.GD5965@thunk.org>
 <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
 <20180426235630.GG5965@thunk.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <20180426235630.GG5965@thunk.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
On Thu 2018-04-26 19:56:30, Theodore Y. Ts'o wrote:
> On Thu, Apr 26, 2018 at 01:22:02PM -0700, Sultan Alsawaf wrote:
> >=20
> > Also, regardless of what's hanging on CRNG init, CRNG should be able to=
 init on its own in a timely
> > manner without the need for user-provided entropy. Userspace was workin=
g fine before the recent CRNG
> > kernel changes, so I don't think this is a userspace bug.
>=20
> The CRNG changes were needed because were erroneously saying that the
> entropy pool was securely initialized before it really was.  Saying
> that CRNG should be able to init on its own is much like saying, "Ted
> should be able to fly wherever he wants in his own personal Gulfstream
> V."  It would certainly be _nice_ if I could afford my personal jet.
> I certainly wish I were that rich.  But the problem is that dollars
> (or Euro's) are like entropy, they don't just magically drop out of
> the sky.
>=20
> If there isn't user-provided entropy, and the hardware isn't providing
> sufficient entropy, where did you think the kernel is supposed to get
> the entropy from?  Should it dial 1-800-TRUST-NSA?

Yes, we could dial 1-800-TRUST-NSA. Then nicely ask them to provide us
some unbackdoored randomness. Then we'd ignore whatever they say, but
would collect randomness from timing and noise on the telephone line.

> The other approach would be to compile the kernel with
> CONFIG_HW_RANDOM_TPM and to modify drivers/char/tpm/tpm-chip.c tot
> initalize chip->hwrng.quality =3D 500.  We've historically made this
> something that the system administrator must set via sysfs.  This is
> because we wanted system adminisrators to explicitly say that they
> trust the any hardware manufacturer that (a) they haven't been paid by
> your choice of the Chinese MSS or the US NSA to introduce a backdoor,i
> and (b) they are competent to actually implemnt a _secure_ hardware
> random number generator.  Sadly, this has not always been the case.

Well, we could actively start accessing suitable device (SD card ? HDD
? CMOS RTC?) when we detect entropy is low. Yes, that would eat power,
but that would be better than machine that hangs at boot.

We could also access the hwrng, then collect entropy from the
timing. TPM is slow chip...
                                                                        Pav=
el
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrl1uQACgkQMOfwapXb+vJg6gCfSaQ4ccTbDjF3fz8H+dm9PPQ1
CO8An3zEePRGgPTlgLaRafOwnx/tg0lC
=07R6
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
