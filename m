Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbeDYGuS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 02:50:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43747 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbeDYGuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 02:50:17 -0400
Date: Wed, 25 Apr 2018 08:50:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: John Stultz <john.stultz@linaro.org>, Genki Sky <sky@genki.is>,
        David Herrmann <dh.herrmann@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and clock
 BOOTTIME
Message-ID: <20180425065015.GA6222@amd>
References: <CANq1E4QppGAaU5PYbGpuC00S6wGQcAt70Z7CntZHiLC6748z2A@mail.gmail.com>
 <2580c734d38041e984215ccc522a4f2d@genki.is>
 <cef78d739d29410cb73072e9792598a7@genki.is>
 <CALAqxLWmcmiOgbH1Ri+Ki-OGFvgzRzRDzX3FZdUhcqu1OoCWiA@mail.gmail.com>
 <alpine.DEB.2.21.1804241007410.5261@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1804241007410.5261@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-04-24 10:09:28, Thomas Gleixner wrote:
> On Mon, 23 Apr 2018, John Stultz wrote:
>=20
> > On Mon, Apr 23, 2018 at 7:45 PM, Genki Sky <sky@genki.is> wrote:
> > > Quoting Genki Sky (2018/04/23 20:40:36 -0400)
> > >> I came across this thread for same reason as [0]: Daemons getting
> > >> killed by systemd on resume (after >WatchdogSec seconds of
> > >> suspending). I'm using master branch of systemd and the kernel. As
> > >> mentioned, systemd uses CLOCK_MONOTONIC, originally expecting it to
> > >> not include suspend time.
> > >>
> > >> Correct me if I'm mistaken, but I don't see the ambiguity of whether
> > >> this patch series breaks systemd. If it's implemented correctly, you=
'd
> > >> hope it *would* break it!
> > >
> > > This sounded a little weak on re-reading, sorry. So, I just confirmed
> > > that after booting a "git revert -m 1 680014d6d1da", the issue no
> > > longer appears. (I.e., a suspend for >WatchDog sec doesn't result in
> > > any daemon getting killed).
> > >
> > > Let me know if I can help in any way.
> >=20
> > Yea, this is the sort of thing I was worried about.
> >=20
> > Thomas: I think reverting this change is needed.
>=20
> Sigh. I hoped that something like this would be catched before I sent the
> pull request by those who were actually interested in this change...

Well, we had two regressions in -next this cycle... I reported both
but bisections were not easy and noone was really interested.

See

Re: linux-next on x60: network manager often complains "network is
        disabled" after resume

Subject: Re: CLOCK_MONOTONIC, BOOTTIME, suspend and screensaver
regression

Can we expect this to be sorted out in v4.17-rc3? -next?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrgJScACgkQMOfwapXb+vLpGwCgofFUkDRMyDGfF7w5c7uxIXZF
jZcAnAh6vVsPyUjvCL5xFcqTAwRbLHRL
=+YUM
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
