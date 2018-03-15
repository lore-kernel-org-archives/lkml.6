Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeCOK3K (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:29:10 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38462 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbeCOK3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:29:08 -0400
X-Google-Smtp-Source: AG47ELtXaxZ+oJgSYoGyPt6lLaQYbNCgne4MvT5iZawrevk0/zZTcCnzyFXW4yEP7C6tj+PUtRT9Gw==
Date: Thu, 15 Mar 2018 11:29:05 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] drm/tegra: plane: Correct legacy blending
Message-ID: <20180315102905.GB15393@ulmo>
References: <8d9c7220b1d2cf126bd2030e5d232ec06f761440.1521075485.git.digetx@gmail.com>
 <00cf4565238be471c90e5823e53e0ed504869bfe.1521075485.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <00cf4565238be471c90e5823e53e0ed504869bfe.1521075485.git.digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2018 at 04:00:24AM +0300, Dmitry Osipenko wrote:
> Keep old 'dependent' state of unaffected planes, this way new state takes
> into account current state of unaffected planes.
>=20
> Fixes: ebae8d07435a ("drm/tegra: dc: Implement legacy blending")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/tegra/plane.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
> index fc37dcf8c458..3c0cb6a04c66 100644
> --- a/drivers/gpu/drm/tegra/plane.c
> +++ b/drivers/gpu/drm/tegra/plane.c
> @@ -287,13 +287,11 @@ unsigned int tegra_plane_format_adjust(unsigned int=
 opaque)
>  	return opaque;
>  }
> =20
> -unsigned int tegra_plane_get_overlap_index(struct tegra_plane *plane,
> -					   struct tegra_plane *other)
> +static unsigned int tegra_plane_get_overlap_index(struct tegra_plane *pl=
ane,
> +						  struct tegra_plane *other)

I'd prefer this to be a separate patch to keep the diff down to make
this easier to apply to v4.16. I can do that when I apply, no need to
resend.

>  {
>  	unsigned int index =3D 0, i;
> =20
> -	WARN_ON(plane =3D=3D other);
> -

Why would this need to go away? We still shouldn't be called with plane
=3D=3D other because that makes no sense.

Thierry

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqqSvEACgkQ3SOs138+
s6E2YA//cmNW+vOYx1cn//8DcwPl391U+ZNzGmIg6uxCi3aMpBfgVdq+tRAWgX6i
cZL0XvjcNPcS/gO4IH7f2BX8sKUU5hzkEt6Bx39zqjPLOufer/0E52kzj70G6bTU
x1lWkeJDeAwbgVNSMNb7jehWKmI24U8bJNipA8DForvWFV8YmCoYtCsnbbuORCbO
rdYMGxGdF0043dFCSR7vy8YTS0UMrxXE+kmU82ehQRbTXA/BloJWXgHLCfPJfVv0
y6VGVfD4YqbSBeNyCmjMjKXcUa3779pNGvnuV9iBoOoGgBgoUsUsd7PG0HgmvXGY
nothVWmUBM2rO5swE5Vp1b9r7BXSg5mtARHWGm4A4qD5jAZZAWKuHfzvTQnaeuy8
tvPixOPMeWpgXvzxmNq/evLGeYW/AZmsRNH9tc/YcbGJGuDDCX3xBUrKN2JaofIZ
DU1MmLAZD042cHZfSe022C2RcdojLm2fhjCGBOk+/UTyKeSh6SWChD/GnTf0Psfu
uQmAf7z5A/LpwHjkXyovUNRhED/w4cU+acBeggEStLVZYBR2gfq9U2+WYiQ5tL5w
zwBWVKPDi5SkO/TcCyjQhrx9x+dsDsYsecNZ1CzpRqUjuboFLegyoqgBxQe278mK
o8s1G4hvlKiHrupf97G4bPvYafhur1iq6pUR3LAFqq8DZzWXdM4=
=R8gh
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
