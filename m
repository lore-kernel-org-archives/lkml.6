Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbeDHHek (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 03:34:40 -0400
Received: from www.zeus03.de ([194.117.254.33]:38702 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750892AbeDHHej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 03:34:39 -0400
X-UD-Smtp-Session: l3s3148p1@1mQ5UlFpHI8gAwDPW+3FAAId4P/+oMhl
Date: Sun, 8 Apr 2018 09:34:36 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] i2c: Add i2c_verify_device_id() to verify device
 id
Message-ID: <20180408073435.i5nq2ngx2fslaz6a@katana>
References: <1521475859-16765-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="355pi5ptdjvmh26z"
Content-Disposition: inline
In-Reply-To: <1521475859-16765-1-git-send-email-linux@roeck-us.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--355pi5ptdjvmh26z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 19, 2018 at 09:10:58AM -0700, Guenter Roeck wrote:
> Commit dde67eb1beeb ("i2c: add i2c_get_device_id() to get the standard
> I2C device id") added a function to return the standard I2C device ID.
> Use that function to verify the device ID of a given device.

I am very open to these patches, just...

>=20
> Cc: Peter Rosin <peda@axentia.se>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> RFC:
> - Compile tested only

=2E.. I would really like to have them tested. After that happened, Peter
and I can figure out who should apply them for seamless upstreaming.

> - Should there also be I2C_DEVICE_PART_ID_ANY to enable maching
>   against all parts from a given manufacturer ?

Can't we just add it when we need it?

> +		dev_err(&client->dev, "unexpected device id %03x-%03x-%x\n",
> +			real_id.manufacturer_id, real_id.part_id,
> +			real_id.die_revision);
> +		return -ENODEV;

I wonder about the ERR loglevel. ENODEV is not an error, I'd think?

Regards,

   Wolfram


--355pi5ptdjvmh26z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrJxgYACgkQFA3kzBSg
Kba2jw//W3l6XYe8D3Pl8nu2sG/38e6Xv8qPeqYe5phtDPxWvoZ0Ts0FgOCZF9If
DqYPIuscqH1AIWxE1UpQtoS0zNqYS/fuBbXY/yA9zM+ybx/Vz3zKLpVVgPE3IxkQ
cAd2OdgIRte9w9waDxPHbcLbsASxwsPhmKItCrtXZKtKenKhsy4ryucEBtKyoiio
y1TiBE8R/3iZFnQReda1KPsAb3zx11lhXjAUT27nxhmf7amATzMFCvfHJTdcecTI
yCQMzdRULuoowNX0TVxqBw6ZKRTFhOsV95gJMNN17B4Jx2RUh99eIe8FcnpfGfjr
vMHefXVRqwFYWhU6EV0F07SrAV6EWULbvYzr4TqJSkMZiIgahVleh3XIlgrMCC3y
VeJ3rMpv+IqHKN9l0tGvvyiZrkiKcneYlVU/Oi5qkGTQBnsDtO42bztKcP2bGmzy
i97fbmxYPRTqcAYg+YSH4QMUDkL+dwEdfsKC533y+B+MTAQ5+e9EC97bmDUq4VZK
nYZM+/sobtHT0SACcttBDZvpe9yK0dSIDbGvTTD8gakSxb12ftbrfhmH/4ipFvBX
TQ7YhvbLyFZjRdw7ha9Fbn7Nr38h6pjPk03ZyCKbxLNBTkO8vLHZcRxCsUkVnv5J
wMw1PSEr6Z2U8SNrUhAEln7VlW0+FT5yaSm4YsSUvOCd5n1/RM4=
=PmkI
-----END PGP SIGNATURE-----

--355pi5ptdjvmh26z--
