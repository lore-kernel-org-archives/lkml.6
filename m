Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeDWHNP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:13:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58357 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeDWHNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:13:13 -0400
Date: Mon, 23 Apr 2018 09:13:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Michal Hocko <mhocko@kernel.org>
Cc: vcaputo@pengaru.com, Ferry Toth <ftoth@telfort.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: DOS by unprivileged user
Message-ID: <20180423071311.GA5768@amd>
References: <9023506.UBh6vynRGa@delfion>
 <20180422101654.GA26243@amd>
 <20180422174300.srzhf3veqxfigqhg@shells.gnugeneration.com>
 <20180423002738.GF16083@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20180423002738.GF16083@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-04-22 18:27:38, Michal Hocko wrote:
> On Sun 22-04-18 10:43:00, vcaputo@pengaru.com wrote:
> > On Sun, Apr 22, 2018 at 12:16:54PM +0200, Pavel Machek wrote:
> > > On Thu 2018-04-19 21:13:35, Ferry Toth wrote:
> > > > It appears any ordinary user can easily create a DOS on linux.
> > > >=20
> > > > One sure way to reproduce this is to open gitk on the linux kernel =
repo=20
> > > > (SIC) on a machine with 8GB RAM 16 GB swap on a HDD with btrfs and =
quad core=20
> > > > + hyperthreading. But I will be easy enough to get the same effect =
with more=20
> > > > RAM, other fs etc.
> > >=20
> > > You may want to disable swap.
> > >=20
> >=20
> > I run without swap on my laptops, and still observe long periods of
> > thrashing on the road towards OOM.  What seems to occur is the active
> > file-backed mappings of executables/libraries become a sort of swap
> > area, repeatedly being discarded and faulted back in as the context
> > switches occur.
> >=20
> > If there's any good way to prevent this, I'd like to know.
>=20
> I am afraid there is none yet. Johannes had some ground work for
> page cache trashing detection https://marc.info/?i=3D20170727153010.23347=
-1-hannes%40cmpxchg.org
> but there was no version of the patchseries for quite some time and
> there was no integration into the oom detection which would be
> non-trivial as well.
>=20
> I realize this sucks. But the reality is that this is far from trivial
> to resolve without introducing pre-mature OOM killer invocations.

Another problem is that what "unusable machine" in X/web browser
situation may be normal load for build server...

I guess one way would be "hey, this is my X server; if it is waiting
for disk for more than 10 seconds, you probably want to OOM kill
someone. Ouch and same goes for my window manager".=20

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrdh4cACgkQMOfwapXb+vImNQCZAc36f8T4LvyaqdjtbZo2ki7n
lvcAnRAdvXaxteuiussAwyF8cGJFI6Yd
=OdUa
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
