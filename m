Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935322AbeEJLRC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 07:17:02 -0400
Received: from sauhun.de ([88.99.104.3]:45538 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934002AbeEJLRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 07:17:01 -0400
Date: Thu, 10 May 2018 13:16:59 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>,
        "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] i2c: core-smbus: fix a potential missing-check bug
Message-ID: <20180510111658.sxf3mvye5q6ihxa7@ninjato>
References: <1525525341-10046-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a4rj7r37xo5co7xp"
Content-Disposition: inline
In-Reply-To: <1525525341-10046-1-git-send-email-wang6495@umn.edu>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a4rj7r37xo5co7xp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 05, 2018 at 08:02:21AM -0500, Wenwen Wang wrote:
> In i2c_smbus_xfer_emulated(), the function i2c_transfer() is invoked to
> transfer i2c messages. The number of actual transferred messages is
> returned and saved to 'status'. If 'status' is negative, that means an
> error occurred during the transfer process. In that case, the value of
> 'status' is an error code to indicate the reason of the transfer failure.
> In most cases, i2c_transfer() can transfer 'num' messages with no error.
> And so 'status' =3D=3D 'num'. However, due to unexpected errors, it is pr=
obable
> that only partial messages are transferred by i2c_transfer(). As a result,
> 'status' !=3D 'num'. This special case is not checked after the invocatio=
n of
> i2c_transfer() and can potentially lead to unexpected issues in the
> following execution since it is expected that 'status' =3D=3D 'num'.
>=20
> This patch checks the return value of i2c_transfer() and returns an error
> code -EIO if the number of actual transferred messages 'status' is not
> equal to 'num'.
>=20
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>

Applied to for-current, thanks!


--a4rj7r37xo5co7xp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlr0KiYACgkQFA3kzBSg
KbZUBA/+PP2xTiov4iCAOKU/d10p7NoCc3vspqQEPIs7aa8CA6fBP7ht34b9dhr8
A6vqF4YbZEtcTAXj6giQ+X2BwfrJRdKc7vJngAV60LiJvi05/0a6Ec3jq3Mtk2wr
RsFDcBgTT+6xAyJe6ySoG56tQ3xQxIVMyQNo8suM5va/+it9JWNgZhfU1p8lA0le
XP+og3lfMaD7JGPQLoocdgUfWCYFJd/9+UMIvvenwTzyEAtuH8PJxSMyuVwHQj88
TVboCCzSHb7IQrtNcEY7QmR8LFMP+RP8OEOd21urqmswJwtfrKnEA+bX/M9srTsM
JgXkVauTiNJ77MZUBvQoDH0b8LkHVvDG5sP1Ho0NsSH9Z7P7Z5DRlweNoUgVCsDZ
xQ+R3nDuZR07lntqJHSJGT9+VPs6ESC7pF2iL3s31lVgPL94QxNeHNXbB9P38+Jh
4yGCB8M/u8soY5N0TKsv1ECCIUg4oaxAaL2D6hARhlLhnCP7DrT/KmCyWuMH8AzL
bkw3vIVpy6U0kT78MwFeK9fldzzkv7x6C14DP0wlYsXkC42Eduv3q5tdHONAifDu
HHoN/LyYPfnwjHD1bq9IpnTCreUxm9IFb7lEV2T2C8Jkb24cdwUlHkoE6UMp2XaP
4Zn2uD6lsVLI0nQOnWjmU59R9mo5oiiaFbhzkdwFzao2Dj+nXAE=
=EPpy
-----END PGP SIGNATURE-----

--a4rj7r37xo5co7xp--
