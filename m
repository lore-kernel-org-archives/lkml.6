Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeEATxv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 15:53:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40935 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750823AbeEATxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 15:53:50 -0400
Date: Tue, 1 May 2018 21:53:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultanxda@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180501195348.GA6880@amd>
References: <20180429170541.lrzwyihrd6d75rql@sultan-box>
 <20180429184101.GA31156@amd>
 <20180429202033.ysmc42mj2rrk3h7p@sultan-box>
 <20180429220519.GQ5965@thunk.org>
 <20180429222625.35tedjzkizchudcm@sultan-box>
 <CAHmME9r5XNS_AU234vKbt9PoHGN3PooFSA8EqNfDRpBHREdQAQ@mail.gmail.com>
 <20180429224928.teg6zyfjxndbcnsn@sultan-box>
 <20180430001106.GS5965@thunk.org>
 <20180430043445.t7wkykxzkhex2isi@sultan-box>
 <20180430161143.GA20585@thunk.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20180430161143.GA20585@thunk.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-04-30 12:11:43, Theodore Y. Ts'o wrote:
> On Sun, Apr 29, 2018 at 09:34:45PM -0700, Sultan Alsawaf wrote:
> >=20
> > What about abusing high-resolution timers to get entropy? Since hrtimer=
s can't
> > make guarantees down to the nanosecond, there's always a skew between t=
he
> > requested expiry time and the actual expiry time.
> >=20
> > Please see the attached patch and let me know just how horrible it is.
>=20
> So think about exactly where the possible causes of the skew might be
> coming from.  Look very closely at the software implemntation.  The
> important thing here is to not get hung up on the software
> abstraction, but to look at the *implementation*.  (And if it's an
> implementation in architecture specific code, we need to look at all
> architectures.)
>=20
> This applies on the hardware level as hard, but that gets harder
> because there many possible hardware implemntations in use out there.
> Remember that that on many systems there may be only single clock
> crystal, and all other hardware timers maybe derived from that clock
> using frequency dividers.  (At least for everything on the mainboard.)

On "many" systems? No, sorry, computers usually do not behave like
this (CMOS RTC has separate clock, for example). I'm pretty sure that
not a single machine problems were reported on has this problem.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlroxcwACgkQMOfwapXb+vLCDwCfaX1nz8VWJ8DHAXlFs96kJ8lG
3rwAn0GyWzM+GSxgIZB47kaU8ztLJ5D+
=ig3V
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
