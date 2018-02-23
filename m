Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbeBWPQo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:16:44 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:53563 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbeBWPQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:16:41 -0500
Date: Fri, 23 Feb 2018 16:16:39 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 1/7] pinctrl: sunxi: refactor irq related register
 function to have desc
Message-ID: <20180223151639.wru7b67byksefxpk@flea.lan>
References: <20180223122552.58049-1-icenowy@aosc.io>
 <20180223122552.58049-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d5vslvnq23qzf7rm"
Content-Disposition: inline
In-Reply-To: <20180223122552.58049-2-icenowy@aosc.io>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d5vslvnq23qzf7rm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 23, 2018 at 08:25:46PM +0800, Icenowy Zheng wrote:
> As the new H6 SoC has holes in the IRQ registers, refactor the IRQ
> related register function for getting the full pinctrl desc structure.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> New patch in v3.
>=20
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 18 ++++++++----------
>  drivers/pinctrl/sunxi/pinctrl-sunxi.h | 29 +++++++++++++++++++++--------
>  2 files changed, 29 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunx=
i/pinctrl-sunxi.c
> index 341312d66512..31bd99f7df50 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -835,7 +835,7 @@ static void sunxi_pinctrl_irq_release_resources(struc=
t irq_data *d)
>  static int sunxi_pinctrl_irq_set_type(struct irq_data *d, unsigned int t=
ype)
>  {
>  	struct sunxi_pinctrl *pctl =3D irq_data_get_irq_chip_data(d);
> -	u32 reg =3D sunxi_irq_cfg_reg(d->hwirq, pctl->desc->irq_bank_base);
> +	u32 reg =3D sunxi_irq_cfg_reg(d->hwirq, pctl->desc);

That's better, but it makes more sense to have the desc as the first
argument.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--d5vslvnq23qzf7rm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqQMFYACgkQ0rTAlCFN
r3QTOA/9Fy72LvYP4pol6xWqxteUbvn45KolMI2tOMVh9aTvs5CyZzrljAIkcCwn
R9yR2J4HKWDD0nucHpO/1DomqAhmKo2DF7oFj/r71E/K6uirySM6Dqh7rMmqFN0p
fwZlBEGbz2WZk1U9HtDfKc9XJuu2+z3bYiysxyla0cQmAScSnkNSTDfQtoMt8G9R
E7JhenAdANX7c+s1Iq0IJVD42foOWnodh+/Qcg/rWKxG2+FjrhfdZow2BwakvFbv
FV3UyqaZKyn8SjUycgW117qn/OZIGPG5/cD6LqdY0M+rzzpahG58JNNCNykzahiv
ajdQEynL0+lS03Nx42Cm4S6jnZyd1e1jlGeoA3ew9Ii4+3Nj9fTswch6Y8r2UUh3
Nw0lb7E9YAAH9wCpxDToC91ZXQTIS9Kb1bK4bmoc6skLXyJRJu90dF7AskTh3Sda
YjSwkJ8LP/aKxQsArUEdTdiMoZRkkE4fyZGMGSFyUfCmdv8rrl7Gh0iQTQv5xcEH
fVAiACoHy5nGwqIbrUguMqreMuxOt1XvzFggvyYprPhnI0Q7QFPJjjU1kypL6rfP
6P44C7/4W8b1ZT5SUhRFBsi2eti3JGbytr+xYQ1PoaHrK0SE/Mlw2NKr9IT5LOUY
km9Vq31bp5fYjWIaT8PV1DDVWmbx8lfLbBjS+w+cdo9utBjmmDQ=
=Y8jB
-----END PGP SIGNATURE-----

--d5vslvnq23qzf7rm--
