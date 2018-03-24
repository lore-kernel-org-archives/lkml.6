Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeCXJnM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 05:43:12 -0400
Received: from narfation.org ([79.140.41.39]:46670 "EHLO v3-1039.vlinux.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751797AbeCXJnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 05:43:10 -0400
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Colin King <colin.king@canonical.com>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [B.A.T.M.A.N.] [PATCH][next] batman-adv: don't pass a NULL hard_iface to batadv_hardif_put
Date: Sat, 24 Mar 2018 10:36:15 +0100
Message-ID: <1552330.yTaGxcYA6e@sven-edge>
In-Reply-To: <20180323225350.7350-1-colin.king@canonical.com>
References: <20180323225350.7350-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1524434.qlbeyyzbMd"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1524434.qlbeyyzbMd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Freitag, 23. M=E4rz 2018 23:53:50 CET Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> In the case where hard_iface is NULL, the error path may pass a null
> pointer to batadv_hardif_put causing a null pointer dereference error.
> Avoid this by only calling the function if  hard_iface not null.
>=20
> Detected by CoverityScan, CID#1466456 ("Explicit null dereferenced")
>=20
> Fixes: 53dd9a68ba68 ("batman-adv: add multicast flags netlink support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  net/batman-adv/multicast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Queued up for David in batadv/net-next as d5863c47d725 [1]

Now I only have to find out why I didn't receive the mail about this=20
from coverity.

Thanks,
	Sven

[1] https://git.open-mesh.org/linux-merge.git/commit/d5863c47d7255448ec0171=
3cbdb4f94b370d86ad
--nextPart1524434.qlbeyyzbMd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlq2HA8ACgkQXYcKB8Em
e0a3UhAA1jf+py/wrYYigdPHLlWb8Sbh6grH14VWxKIvqbAoTegxIp6i97/HuoJ/
CHZoOzFzzGm7zpuNDTLIMhn9ltRKiYLdG4gOWqc/zQnwQvegaA9GGxUN6rn2qCo9
B49zyESlAS7AReauoGJVycydYvp7RspbMRamYOd2g6HE0J1N8BquHdyJqIhYUs8c
lXSZ90GCrguSjWIOzJfm2YOqKKDNRLxqOLEuO+UsqjEN9T/ZA6wn8pdWcH32aRPt
sG2RuP4p1mEPpsRksxPr4XbNvqfWnQfybuqLf3WCq/4yMbkA9s4O2hRiqKc/wj5o
fcQXd3fobm+5dHHd9uhBqz0Pop30lmrULhwv3zrzysu+yVHekGMlHf9696wsuXAD
ibOhgFOCkFELgDVAkrDZWVM9r2igFYMbc5igmNZx7gzRPWk04IBWAEyi28K/ptrN
AsieFJ13vbfSGcvCK972MUTKrUJSuYhyd67GToMvN3fx/l2gaiwFllh1jMeTIU5B
Xc0zhtOWocBqJaw4UKPJ5OodxBKINmfJ0JJYyrb7LejIWksxBygcxHeGUnJPmrYu
MsOnQDmq5fgeeQz6KUZRxC1dNu3CTetXFWOC2cep7Isl1P3qBmnxwUIVSoXXVNEw
OdIPtMwX1NLwVSz+wVAWRQE0JriUbSR/R/5J8/AdzsdpSjQ9WS4=
=IINO
-----END PGP SIGNATURE-----

--nextPart1524434.qlbeyyzbMd--
