Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753336AbeEURtG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:49:06 -0400
Received: from anholt.net ([50.246.234.109]:49828 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753097AbeEURtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:49:02 -0400
From: Eric Anholt <eric@anholt.net>
To: Yisheng Xie <xieyisheng1@huawei.com>, linux-kernel@vger.kernel.org
Cc: Yisheng Xie <xieyisheng1@huawei.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 12/33] clk: bcm2835: use match_string() helper
In-Reply-To: <1526903890-35761-13-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-13-git-send-email-xieyisheng1@huawei.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Mon, 21 May 2018 10:48:58 -0700
Message-ID: <874lj0ew6t.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Yisheng Xie <xieyisheng1@huawei.com> writes:

> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-rpi-kernel@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  drivers/clk/bcm/clk-bcm2835.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index fa0d5c8..a27c0d2 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -1395,8 +1395,7 @@ static struct clk_hw *bcm2835_register_clock(struct=
 bcm2835_cprman *cprman,
>  	struct bcm2835_clock *clock;
>  	struct clk_init_data init;
>  	const char *parents[1 << CM_SRC_BITS];
> -	size_t i, j;
> -	int ret;
> +	int i, ret;
>=20=20
>  	/*
>  	 * Replace our strings referencing parent clocks with the
> @@ -1405,12 +1404,11 @@ static struct clk_hw *bcm2835_register_clock(stru=
ct bcm2835_cprman *cprman,
>  	for (i =3D 0; i < data->num_mux_parents; i++) {
>  		parents[i] =3D data->parents[i];
>=20=20
> -		for (j =3D 0; j < ARRAY_SIZE(cprman_parent_names); j++) {
> -			if (strcmp(parents[i], cprman_parent_names[j]) =3D=3D 0) {
> -				parents[i] =3D cprman->real_parent_names[j];
> -				break;
> -			}
> -		}
> +		ret =3D match_string(cprman_parent_names,
> +				   ARRAY_SIZE(cprman_parent_names),
> +				   parents[i]);
> +		if (ret >=3D 0)
> +			parents[i] =3D cprman->real_parent_names[ret];

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlsDBooACgkQtdYpNtH8
nug3LA//aZmSSf68qHXjBV33bop6na0WcGK0p+BArUD+EgndyLAliFCB+uEHQ0or
RvMSkUcikTSaqurCLOBZpzOEYEDWtGTFY4HPgvqoKTbHm4+PKJfoCGdBgzb1BxJ6
ctLeglj8+YsBBluR4+1Dn0MJBNYaG7fifk9JeLNXE5PLkFkb1SYHtGqlkXyL0w/1
8jZM+WXmRjR637Xlxc7DReqx/x1pI03Ec5OAjkX4fX1a0inCr4Wm6hN9yEQlrZki
1XTZsPFW87+XZyUFwm6IBkGr4FsPglreeyjYAEdRTj+ymMJUJaY6BI1yj8v+H4I5
ZvLFJFXDuL7nbru0nMw/F5a1pewf5/UJMqDGH7AO3lBjnUMESQOtCjvaPbeIBpy8
jyYgwNfjwdSU8SaY99aMgr3WQcy9Uzlcof2Nmd2pgDOPBD3dJR1nSWQUbRX7v1Rw
vrlYo0r0+cZZoUmoztj5bpaSOHf+mLpC4SBY6y+5PEL8FeHW9UoWZe5Zug3ZM1ZJ
Eehp/9S+dMsEt5y8lphBNaKz40MGa2PpSrywEOeAowVKnxIj58borW1lK4r4riG+
GA84bDB904R/VUQetjdKxcAZvwN6k6VkEL9//M447m3WM+p4O/I7PfeDo9BhSqFf
OS34GAVHTbp4GIV/Taq9MH0rEckYyr9FSPFy6jqMmLh1Fv2oNEw=
=lr2s
-----END PGP SIGNATURE-----
--=-=-=--
