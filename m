Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeDEMZH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 08:25:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49117 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeDEMZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 08:25:05 -0400
Date: Thu, 5 Apr 2018 14:25:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rafael@kernel.org>, jikos@suse.cz
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: update-binfmts breaking suspend was Re: x32 suspend failuer in Re:
 linux-next: Tree for Apr 4
Message-ID: <20180405122503.GA28446@amd>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
 <20180404075047.GB9342@amd>
 <CAJZ5v0hxyXtyKacJufivL9HWbQBsxTBYVipnHK4+QquTYjpc+A@mail.gmail.com>
 <20180404084905.GA12303@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20180404084905.GA12303@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-04-04 10:49:05, Pavel Machek wrote:
> On Wed 2018-04-04 09:58:17, Rafael J. Wysocki wrote:
> > On Wed, Apr 4, 2018 at 9:50 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > > Hi!
> > >
> > >> Please do not add any v4.18 destined stuff to your linux-next includ=
ed
> > >> trees until after v4.17-rc1 has been released.
> > >
> > > On thinkpad x60, suspend does not suspend at all with this -next
> > > version. Previous versions suspended/resumed fine but broke networkin=
g.
> > >
> > > Any ideas? I guess bisecting on next would not be easy?
> >=20
> > Well, why would it be different from a bisect on any other git repo?
>=20
> Well, v4.16-rc4 is parent of v4.16-rc6, but next-20180304 is not
> parent of next-20180307.
>=20
> But you are right that if I do bisect between -linus and -next, it
> should work.
>=20
> Anyway, does s2ram work for you in -next? Are you testing 32bit?

Hmm. I tested on T40p. That works ok, so at least some 32bit machines
do work.

Hmm, and my test scripts were wrong.

Failure is not a hang, as they expect, but... machine locks up, but
does not suspend, and then continues running after a delay..

[   35.038766] PM: Syncing filesystems ... done.
[   35.051246] Freezing user space processes ...
[   55.060528] Freezing of tasks failed after 20.009 seconds (1 tasks
refusing to freeze, wq_busy
=3D0):
[   55.060552] update-binfmts  D    0  2727      1 0x80000004
[   55.060576] Call Trace:
[   55.060600]  __schedule+0x37a/0x7e0
[   55.060618]  schedule+0x29/0x70
[   55.060635]  autofs4_wait+0x359/0x7a0
[   55.060653]  ? wait_woken+0x70/0x70
[   55.060668]  autofs4_mount_wait+0x4a/0xe0
[   55.060684]  ? autofs4_mount_wait+0x4a/0xe0
[   55.060699]  autofs4_d_automount+0xe0/0x200
[   55.060715]  ? autofs4_d_automount+0xe0/0x200

Did the rework of freezing start already in -next?


									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrGFZ8ACgkQMOfwapXb+vKK4gCfQnOJ7D75mhKz386tUxywi8i8
lyMAnjnHozobvose7s62mzpom1kG6+mn
=DPRS
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
