Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932159AbeDCKuv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 06:50:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55455 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754975AbeDCKtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 06:49:20 -0400
X-Google-Smtp-Source: AIpwx49flTLCG6kxJLCsKbSwLB42iXEFc5d/rG0qkzDnLQui667OgaRl2hGgoNJ26xGRshR+gkJUog==
Date: Tue, 3 Apr 2018 12:49:16 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2] phy: tegra: Remove self cast in
 tegra_xusb_port_find_lane
Message-ID: <20180403104916.GC27789@ulmo>
References: <20180401110410.GA3405@flashbox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline
In-Reply-To: <20180401110410.GA3405@flashbox>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 01, 2018 at 04:04:10AM -0700, Nathan Chancellor wrote:
> Clang warns about casting variables to themselves because it is rarely
> necessary. Removing the cast should not change anything regarding the
> code and silences the warning.
>=20
> ../drivers/phy/tegra/xusb.c:421:11: warning: explicitly assigning value
> of variable of type 'const struct tegra_xusb_lane_map *' to itself
> [-Wself-assign]
>         for (map =3D map; map->type; map++) {
>              ~~~ ^ ~~~
>=20
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> I am not entirely sure if this is the correct solution, especially since
> I don't have the hardware and I am not too familiar with this code. If
> there is a better solution, please let me know.
>=20
> Changes from v1 -> v2: Fix spelling error in commit title
>=20
>  drivers/phy/tegra/xusb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index 63e916d4d069..11aa5902a9ac 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -418,7 +418,7 @@ tegra_xusb_port_find_lane(struct tegra_xusb_port *por=
t,
>  {
>  	struct tegra_xusb_lane *lane, *match =3D ERR_PTR(-ENODEV);
> =20
> -	for (map =3D map; map->type; map++) {
> +	for (; map->type; map++) {
>  		if (port->index !=3D map->port)
>  			continue;
> =20

An equivalent patch seems to already have been merged. See:

	https://patchwork.kernel.org/patch/10072641/

You can avoid duplication of effort such as this by basing any patches
you send on top of a recent linux-next. The above patch, for example,
was added in next-20180223.

Thanks,
Thierry

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrDXCoACgkQ3SOs138+
s6Gr2w/+My2KWPLOFuypqkLTZAxs3/M7dgRG421JggT1yOSucGu/avZEVpfW1yKw
YGlpWoKIc/aTDgYvJh8ZsXm2XXY8agRiQPQM/Poxre0z6S+jR4JXCbRXl2fyrYoz
Wdr30vZxOlHczWpqjwflrwgXi/bPFFdwn9gTDwJ9ICBOou3ptBXtgPr/uzybtC92
zjCfWKe04n4hpUOEpe3C0UoG8CQ4JdLOlKGV+ICY48yvCK4PDcVcKiUtKZY4g8lK
+Uqkocve2IYt2ShliYjwwJzvwitpSQYkfOI8MFSCIEYgjNxWKpr2vF4QiHfHgWUk
U38Ohw6+29xZj+7blGEx3fixA4kdQjgZUtY/wV1TjLfahe+R0F7QGKqTg+1ka3cq
imOYNtN2wi9sJ+GrGsY1guB5PqQ8WzBBEnKQCYofYf6Gftps5pPO+kSoJcu8CDXM
mPNHijmL7JxBcSkk8Ftke7YBqOZhOG0vjqbvsSAALi2xDf1N0APUXzwh5PMAYoar
/UTracKT5D6guzjg7uneMZJxliz7OJrTXZfTRK69CELeVT/y/8TIEHaMTKcunf4w
WjhDHsHlJFUL5xaVyXL1LNVEv8Z5aLMc/EMFBXcjkb8HCKWCW+XMbIzBZAuQkZ8J
4Qv6Ynl2kLeSKye1huMIB2yDAxNmNSvRXpxbRKWYbdvZIwJ/BUc=
=E9Lt
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
