Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034246AbeBPOXb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:23:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034176AbeBPOX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:23:29 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51032175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Fri, 16 Feb 2018 15:23:26 +0100
From: Sebastian Reichel <sre@kernel.org>
To: "James A. MacInnes" <james.a.macinnes@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power:sbs-manager: Fix double shift of select reg
Message-ID: <20180216142326.aoml5ht2bix7mrkq@earth.universe>
References: <1518736413-4797-1-git-send-email-james.a.macinnes@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gme5smxso7c6bfsq"
Content-Disposition: inline
In-Reply-To: <1518736413-4797-1-git-send-email-james.a.macinnes@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gme5smxso7c6bfsq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi James,

On Thu, Feb 15, 2018 at 03:13:33PM -0800, James A. MacInnes wrote:
> 1 << BIT() causes double shift when the macro is unwrapped
> removed extra "1 <<"

No Signed-off-by... But this is already fixed:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D7d54d0d38ec42559c891526f079f1e035cd4b3ae

-- Sebastian

> ---
>  drivers/power/supply/sbs-manager.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/sb=
s-manager.c
> index ccb4217..cb6e8f6 100644
> --- a/drivers/power/supply/sbs-manager.c
> +++ b/drivers/power/supply/sbs-manager.c
> @@ -183,7 +183,7 @@ static int sbsm_select(struct i2c_mux_core *muxc, u32=
 chan)
>  		return ret;
> =20
>  	/* chan goes from 1 ... 4 */
> -	reg =3D 1 << BIT(SBSM_SMB_BAT_OFFSET + chan);
> +	reg =3D BIT(SBSM_SMB_BAT_OFFSET + chan);
>  	ret =3D sbsm_write_word(data->client, SBSM_CMD_BATSYSSTATE, reg);
>  	if (ret)
>  		dev_err(dev, "Failed to select channel %i\n", chan);
> --=20
> 2.7.4
>=20

--gme5smxso7c6bfsq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqG6VsACgkQ2O7X88g7
+ppNJg//dpnkS/zGTBl3sizCaHGouP9tkA+QBqDgvqIStfhEj6B9rAKTHD9y9JUl
UP9iShs2Wvsrjsb1BJnfQ180CaZXB6Xo9qJ5BNS8HiWvEzlA9BsWmC70JtQyml0K
X8TjM4TFZPySnPiSWDxxVn1oUbjvxwGdA2NEn0qxbw18so/6sGF/Da/jawfM8Bsq
/c3gNLC+K0qaEowaqBIkQdFj9SxN8dVNoNxQgwJxK1tj9OCqZgIQ/ppJG7UKEUMC
B6CjIwTwm7AOxhn7EUidx7RiiD+zfFT16ieCXK1tag9OhmZdEVqXev8iiSjWtH2c
luah2SlsuTVUuz4hvmR9sDYBYjXtre6RWj+CtlqpYhV/8z6jO61mQgmnXv2hqOa+
SxuubciAd0hyWBKGxkbw/KuHRCdDapI2p/CjWClG89nLClLq9MOO6PqC6iPywQQk
E6Wv4CgDuO2+f/2ySmDcjAOzIeurBd/B40tcRPE8qQUr+EFvAEf8aiTCHZ2VI5Ty
csGDsiUHBfZX49v0H67I7vxvLP+NsmQKJsPu1OWaNqHzlBIjwxByg4isHbPJcbaF
EUFjDMzjEvRkXlbjoci/+YcfIxxTnlmZAXddbk/7PUZfxZA2sBOlVsE71DLWBJ4X
9w2Cw/lBMh7LTis8JreAS5FJQcl0fe220X7NmOegN7vuPEt23xs=
=b1Zi
-----END PGP SIGNATURE-----

--gme5smxso7c6bfsq--
