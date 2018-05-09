Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756170AbeEIHMa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 03:12:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46651 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755888AbeEIHM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 03:12:28 -0400
Date: Wed, 9 May 2018 09:12:26 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <contact@paulk.fr>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v4 1/3] drm/panel: Add RGB666 variant of Innolux AT070TN90
Message-ID: <20180509071226.ivh4s3wtczg2u7zw@flea>
References: <20180507220413.21990-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="erirrsr4rgg7d5ew"
Content-Disposition: inline
In-Reply-To: <20180507220413.21990-1-contact@paulk.fr>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--erirrsr4rgg7d5ew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2018 at 12:04:11AM +0200, Paul Kocialkowski wrote:
> This adds timings for the RGB666 variant of the Innolux AT070TN90 panel,
> as found on the Ainol AW1 tablet.
>=20
> The panel also supports RGB888 output. When RGB666 mode is used instead,
> the two extra lanes per component are grounded.
>=20
> In the future, it might become necessary to introduce a dedicated
> device-tree property to specify the bus format to use instead of the
> default one for the panel. This will allow supporting different bus
> formats for the same panel modes.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel=
/panel-simple.c
> index cbf1ab404ee7..32e30d5a8f08 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1063,6 +1063,29 @@ static const struct panel_desc innolux_at043tn24 =
=3D {
>  	.bus_flags =3D DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
>  };
> =20
> +static const struct drm_display_mode innolux_at070tn90_mode =3D {
> +	.clock =3D 40000,
> +	.hdisplay =3D 800,
> +	.hsync_start =3D 800 + 112,
> +	.hsync_end =3D 800 + 112 + 1,
> +	.htotal =3D 800 + 112 + 1 + 87,
> +	.vdisplay =3D 480,
> +	.vsync_start =3D 480 + 141,
> +	.vsync_end =3D 480 + 141 + 1,
> +	.vtotal =3D 480 + 141 + 1 + 38,
> +	.vrefresh =3D 60,
> +};
> +
> +static const struct panel_desc innolux_at070tn90 =3D {
> +	.modes =3D &innolux_at070tn90_mode,
> +	.num_modes =3D 1,
> +	.size =3D {
> +		.width =3D 154,
> +		.height =3D 86,
> +	},
> +	.bus_format =3D MEDIA_BUS_FMT_RGB666_1X18,
> +};
> +

I'm not really convinced this is the right approach. You said it
yourself, the panel is using a 24-bits interface, and you just happen
to have a tablet that routed it using a 18-bits interface instead.

That doesn't belong in the driver, especially associated to the
compatible, but where the routing is described: in the device
tree. And given that the panel interface is a 24 bits panel, if we
were to have a default, we should have this one, and not the one
fitting your use case.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--erirrsr4rgg7d5ew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlryn1oACgkQ0rTAlCFN
r3RvdA/7BjX0ZueUchmHOJAEt91UXR+Bl8/G1+pc49m/euGXRQLAUccK/ynKcPxy
UrF0BPaPE3S7uC7LQhb13xhwU03POzId6BlCkXCs1ykkTKnKxc/PQN/fg1Pq2Tz8
QWkSgsjgS2FAAFUqXQOukIVXJVtKbFg0VD4PgVAmHyes+7Mut51qzFCsvNBC+6eK
DCODof1H4DtkNncQup2q8gjTNqWWjpwVz3JTQc91qYjwKEKHSCkdZcRsFx3dfm0u
1ReVaKfXx0SVKDv303PV6d2QNfpDVBfWsfQwIoHqWvQyitsW0prqzSWwADZegRs0
6k76x0+2Z3QqObCm0wppCFdl/2s6QZ8Oz1vOqhga46sAUVdKRiZr+qjJXIxdqmCP
xu/7GY3TW0GQM/Sjfuvnc8iyAxP4DUEMZP0kCd6Yz8zhomBnGuT2bGM1kPc5LdCm
CNtJP7f/PK1+XsmWcWiuM+2U90HFuwHPx1XNuRlXBtIJls4jAYpORtEzf3WCwgbr
rBU0oUTxDqFxyvxO0t8CfeQqRgroOiQ5tNjWTylTHhY9yq+xc+R0FPbQmusUPuto
k1l/FW577R3jl3zpcFifwxnbp9AFkNH1QMEFugpC9UtVKKTkH73r0mLhowQa94xf
FVaO2mnhLtY+axqo/9ppQTub4tZEF3gV3+3XoGmj4ulcy5o40C8=
=1Qnq
-----END PGP SIGNATURE-----

--erirrsr4rgg7d5ew--
