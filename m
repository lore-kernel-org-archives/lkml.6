Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753614AbeBSTE6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 14:04:58 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53112 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753560AbeBSTE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 14:04:57 -0500
Date: Mon, 19 Feb 2018 20:04:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: pali.rohar@gmail.com, sre@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
        aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
        patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com,
        clayton@craftyguy.net, martijn@brixit.nl,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
Subject: Re: v4.13 on nokia n900: oops during tethering
Message-ID: <20180219190454.GB19366@amd>
References: <20180212201000.GA25608@amd>
 <20180213222412.GA1116@mara.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline
In-Reply-To: <20180213222412.GA1116@mara.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Mon, Feb 12, 2018 at 09:10:00PM +0100, Pavel Machek wrote:
> > Hi!
> >=20
> > During tethering, I got oops in ssi_stop_tx(), followed by failure of
> > GPRS. I used GPRS tethering a lot with some older kernel, and it was
> > stable for hours.
> >=20
> > It seems v4.12 has the same problem. In v4.15 usb networking does not
> > work at all, so I can't test... v4.10 seems to have similar problem. (T=
esting is
> > slighlty tricky, as my internet connection is ... tethering using
> > N900.)
>=20
> Based on a quick look ssi_stop_tx() is called too many times (i.e. once
> more than ssi_start_tx()). This would appear to be an interal problem
> with the SSI codebase (or whatever lies there; I don't know the current
> codebase).

If I change BUG_ON in ssi_stop_tx() to warning and return, I see the
warning and system survives it.

> Did this work in the past? When? There appear to have been changes in IRQ
> handling some time in 2016...

Actually, I'm not sure any more :-(. I did have tethering running
overnight some time ago, but it was on slower mobile data, and over
wifi.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqLH9YACgkQMOfwapXb+vIHsACdHeFJXa7lW8T4XvB/Fmk9W9xp
0v0AniVhg8FnM63kPy+jXVlcHtH0eGvO
=dZOh
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
