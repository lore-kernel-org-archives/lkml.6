Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeDQTjI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 15:39:08 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53525 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbeDQTjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 15:39:06 -0400
Date: Tue, 17 Apr 2018 21:39:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: mutt@amd.karlin.mff.cuni.cz,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        nick@shmanahar.org, rydberg@bitmath.org, linux-input@vger.kernel.org,
        bleung@google.com
Subject: Re: atmel_mxt_ts on droid4: powersave seems to break the driver
Message-ID: <20180417193903.GA11082@amd>
References: <20180417073811.GA9450@amd>
 <20180417182021.GA67621@dtor-ws>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20180417182021.GA67621@dtor-ws>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > v4.17-rc1 on motorola droid 4.
> >=20
> > If I disable/reenable touschreen with xinput, it fails, with this in
> > the logs:
> >=20
> > [ 1633.749450] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
> > [ 1655.938751] atmel_mxt_ts 1-004a: __mxt_read_reg: i2c transfer
> > failed (-121)
> > [ 1655.945800] atmel_mxt_ts 1-004a: Failed to read T44 and T5 (-121)
> > [ 1663.829498] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
> >=20
> > Unfortunately, xscreensaver seems to break it in a similar way.
> >=20
>=20
> There were a few changes to the Atmel driver, ending with commit
> 96a938aa214e965d5b4a2f10443b29cad14289b9, but they mostly dealt with
> removal of platform data and moving to generic device properties...
> Can you try bisecting this series:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git =
ib-chrome-platform-input-atmel-mx-ts-platform-removal
>=20

To avoid any misunderstanding, I'm not saying this is
regression from v4.16. I did some testing on v4.16 (and it was first
kernel to work there at all), but I did not have good enough userland
to play with touchscreen disable/enable.

Plus, I'm not sure this is 100% reproducible, let me play some more.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrWTVcACgkQMOfwapXb+vKTxgCgq0rxKWXiC87HW2s2MJXqhYQS
bz0AoLlFWDVReOz1D9TW7cjj0YbgZRAa
=rMmw
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
