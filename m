Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeDOQPz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 12:15:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47830 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752371AbeDOQPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 12:15:53 -0400
Date: Sun, 15 Apr 2018 18:15:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Woody Suwalski <terraluna977@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Netdev list <netdev@vger.kernel.org>
Subject: Re: linux-next on x60: network manager often complains "network is
 disabled" after resume
Message-ID: <20180415161551.GF10802@amd>
References: <20180318104023.GA10392@amd>
 <70721f83-344a-0f23-223b-9c81f6e9e32a@gmail.com>
 <20180319092106.GA5683@amd>
 <6e43123a-5227-96c4-a1f5-4416bdb5b0db@gmail.com>
 <c7d96582-e2e6-d9c8-1140-3f1dab836132@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="l+goss899txtYvYf"
Content-Disposition: inline
In-Reply-To: <c7d96582-e2e6-d9c8-1140-3f1dab836132@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l+goss899txtYvYf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-03-20 21:11:54, Woody Suwalski wrote:
> Woody Suwalski wrote:
> >Pavel Machek wrote:
> >>On Mon 2018-03-19 05:17:45, Woody Suwalski wrote:
> >>>Pavel Machek wrote:
> >>>>Hi!
> >>>>
> >>>>With recent linux-next, after resume networkmanager often claims that
> >>>>"network is disabled". Sometimes suspend/resume clears that.
> >>>>
> >>>>Any ideas? Does it work for you?
> >>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Pavel
> >>>Tried the 4.16-rc6 with nm 1.4.4 - I do not see the issue.
> >>Thanks for testing... but yes, 4.16 should be ok. If not fixed,
> >>problem will appear in 4.17-rc1.
> >>
> >Works here OK. Tried ~10 suspends, all restarted OK.
> >kernel next-20180320
> >nmcli shows that Wifi always connects OK
> >
> >Woody
> >
> Contrary, it just happened to me on a 64-bit build 4.16-rc5 on T440.
> I think that Dan's suspicion is correct - it is a snafu in the PM: trying=
 to
> hibernate results in a message:
> Failed to hibernate system via logind: There's already a shutdown or sleep
> operation in progress.
>=20
> And ps shows "Ds /lib/systemd/systemd-sleep suspend"...

Problem now seems to be in the mainline.

But no, I don't see systemd-sleep in my process list :-(.

I guess you can't reproduce it easily? I tried bisecting, but while it
happens often enough to make v4.17 hard to use, it does not permit
reliable bisect.

These should be bad according to my notes

b04240a33b99b32cf6fbdf5c943c04e505a0cb07=20
 ed80dc19e4dd395c951f745acd1484d61c4cfb20
 52113a0d3889d6e2738cf09bf79bc9cac7b5e1c6
 4fc97ef94bbfa185d16b3e44199b7559d0668747
 14ebdb2c814f508936fe178a2abc906a16a3ab48
 639adbeef5ae1bb8eeebbb0cde0b885397bde192

bisection claimed

c16add24522547bf52c189b3c0d1ab6f5c2b4375

is first bad commit, but I'm not sure if I trust that.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--l+goss899txtYvYf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrTercACgkQMOfwapXb+vKx9ACgiDP2CHhqiPMvrneTl75lVeoJ
xQ8AnidZqh2Z02oIM6FKUUY/RCiK18wp
=uP0j
-----END PGP SIGNATURE-----

--l+goss899txtYvYf--
