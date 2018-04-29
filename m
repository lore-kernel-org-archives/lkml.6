Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754343AbeD2VTA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 17:19:00 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60663 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754300AbeD2VS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 17:18:56 -0400
Date: Sun, 29 Apr 2018 23:18:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sultan Alsawaf <sultanxda@gmail.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180429211855.GA17525@amd>
References: <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
 <20180426192524.GD5965@thunk.org>
 <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
 <20180426235630.GG5965@thunk.org>
 <3eb5761e-7b25-4178-0560-fba5eb43ce6a@gmail.com>
 <20180427201036.GL5965@thunk.org>
 <20180429143205.GD13475@amd>
 <20180429170541.lrzwyihrd6d75rql@sultan-box>
 <20180429184101.GA31156@amd>
 <20180429202033.ysmc42mj2rrk3h7p@sultan-box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20180429202033.ysmc42mj2rrk3h7p@sultan-box>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-04-29 13:20:33, Sultan Alsawaf wrote:
> On Sun, Apr 29, 2018 at 08:41:01PM +0200, Pavel Machek wrote:
> > Umm. No. https://www.youtube.com/watch?v=3DxneBjc8z0DE
>=20
> Okay, but /dev/urandom isn't a solution to this problem because it isn't =
usable
> until crng init is complete, so it suffers from the same init lag as
> /dev/random.

So -- I'm pretty sure systemd and friends should be using
/dev/urandom. Maybe gpg wants to use /dev/random. _Maybe_.

[    2.948192] random: systemd: uninitialized urandom read (16 bytes
read)
[    2.953526] systemd[1]: systemd 215 running in system mode. (+PAM
+AUDIT +SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ
-SECCOMP -APPARMOR)
[    2.980278] systemd[1]: Detected architecture 'x86'.
[    3.115072] usb 5-2: New USB device found, idVendor=3D0483,
idProduct=3D2016, bcdDevice=3D 0.01
[    3.119633] usb 5-2: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D0
[    3.124147] usb 5-2: Product: Biometric Coprocessor
[    3.128621] usb 5-2: Manufacturer: STMicroelectronics
[    3.163839] systemd[1]: Failed to insert module 'ipv6'
[    3.181266] systemd[1]: Set hostname to <amd>.
[    3.267243] random: systemd-sysv-ge: uninitialized urandom read (16
bytes read)
[    3.669590] random: systemd-sysv-ge: uninitialized urandom read (16
bytes read)
[    3.696242] random: systemd: uninitialized urandom read (16 bytes
read)
[    3.700066] random: systemd: uninitialized urandom read (16 bytes
read)
[    3.703716] random: systemd: uninitialized urandom read (16 bytes
read)

Anyway, urandom should need to be seeded once, and then provide random
data forever... which is not impression I get from the dmesg output
above. Boot clearly proceeds... somehow. So now I'm confused.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrmNr8ACgkQMOfwapXb+vK3iQCff9UKx1/reD2i2tNzIG19G6Ut
/ZwAoKyPt0awKR8UwZ5LUBGbmVCF1I48
=zKgL
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
