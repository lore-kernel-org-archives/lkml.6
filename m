Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757950AbeD0Jjd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:39:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53655 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeD0Jjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:39:31 -0400
X-Google-Smtp-Source: AB8JxZq2vwrXO5nvsVNgg2WVoZOlMzM5th3h6aNGgc4pLpZlaHapyjtE/vOZhy+PfoSU0bKBB84fKA==
Date: Fri, 27 Apr 2018 11:39:27 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/15] memory: tegra: Add Tegra210 memory controller
 hot resets
Message-ID: <20180427093927.GK30388@ulmo>
References: <cover.1523301400.git.digetx@gmail.com>
 <f064d034477537bfb5473c1277da07d772b0d4b5.1523301400.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3MHXEHrrXKLGx71o"
Content-Disposition: inline
In-Reply-To: <f064d034477537bfb5473c1277da07d772b0d4b5.1523301400.git.digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MHXEHrrXKLGx71o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 13, 2018 at 02:33:50PM +0300, Dmitry Osipenko wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Define the table of memory controller hot resets for Tegra210.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/memory/tegra/tegra210.c | 45 +++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/drivers/memory/tegra/tegra210.c b/drivers/memory/tegra/tegra=
210.c
> index b729f49ffc8f..d00a77160407 100644
> --- a/drivers/memory/tegra/tegra210.c
> +++ b/drivers/memory/tegra/tegra210.c
> @@ -1080,6 +1080,48 @@ static const struct tegra_smmu_soc tegra210_smmu_s=
oc =3D {
>  	.num_asids =3D 128,
>  };
> =20
> +#define TEGRA210_MC_RESET(_name, _control, _status, _bit)	\
> +	{							\
> +		.name =3D #_name,					\
> +		.id =3D TEGRA210_MC_RESET_##_name,		\
> +		.control =3D _control,				\
> +		.status =3D _status,				\
> +		.bit =3D _bit,					\
> +	}
> +
> +static const struct tegra_mc_reset tegra210_mc_resets[] =3D {
> +	TEGRA210_MC_RESET(AFI,       0x200, 0x204,  0),
> +	TEGRA210_MC_RESET(AVPC,      0x200, 0x204,  1),
> +	TEGRA210_MC_RESET(DC,        0x200, 0x204,  2),
> +	TEGRA210_MC_RESET(DCB,       0x200, 0x204,  3),
> +	TEGRA210_MC_RESET(HC,        0x200, 0x204,  6),
> +	TEGRA210_MC_RESET(HDA,       0x200, 0x204,  7),
> +	TEGRA210_MC_RESET(ISP2,      0x200, 0x204,  8),
> +	TEGRA210_MC_RESET(MPCORE,    0x200, 0x204,  9),
> +	TEGRA210_MC_RESET(NVENC,     0x200, 0x204, 11),
> +	TEGRA210_MC_RESET(PPCS,      0x200, 0x204, 14),
> +	TEGRA210_MC_RESET(SATA,      0x200, 0x204, 15),
> +	TEGRA210_MC_RESET(VI,        0x200, 0x204, 17),
> +	TEGRA210_MC_RESET(VIC,       0x200, 0x204, 18),
> +	TEGRA210_MC_RESET(XUSB_HOST, 0x200, 0x204, 19),
> +	TEGRA210_MC_RESET(XUSB_DEV,  0x200, 0x204, 20),
> +	TEGRA210_MC_RESET(A9AVP,     0x200, 0x204, 21),
> +	TEGRA210_MC_RESET(TSEC,      0x200, 0x204, 22),
> +	TEGRA210_MC_RESET(SDMMC1,    0x200, 0x204, 29),
> +	TEGRA210_MC_RESET(SDMMC2,    0x200, 0x204, 30),
> +	TEGRA210_MC_RESET(SDMMC3,    0x200, 0x204, 31),
> +	TEGRA210_MC_RESET(SDMMC4,    0x970, 0x974,  0),
> +	TEGRA210_MC_RESET(ISP2B,     0x970, 0x974,  1),
> +	TEGRA210_MC_RESET(GPU,       0x970, 0x974,  2),
> +	TEGRA210_MC_RESET(NVDEC,     0x970, 0x974,  5),
> +	TEGRA210_MC_RESET(APE,       0x970, 0x974,  6),
> +	TEGRA210_MC_RESET(SE,        0x970, 0x974,  7),
> +	TEGRA210_MC_RESET(NVJPG,     0x970, 0x974,  8),
> +	TEGRA210_MC_RESET(AXIAP,     0x970, 0x974, 11),
> +	TEGRA210_MC_RESET(ETR,       0x970, 0x974, 12),
> +	TEGRA210_MC_RESET(TSECB,     0x970, 0x974, 13),
> +};

Isn't this missing an include for the definitions? There is an include
for dt-bindings/memory/tegra20-mc.h for the Tegra20 driver, but none of
the others have it.

No need to respin, though, I can add that when applying.

Thierry

--3MHXEHrrXKLGx71o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlri788ACgkQ3SOs138+
s6G6BA//eg7x2FvSKYaYvi4HQQ7vWXbiTkJY5qutkBBHP50gRA8bb2bUgh4mdMUd
ABBex8TFR6glG0zsrWHdK58uKzw8dj3FfHlfW0L/GgsIFWN+PnEHuEsC/yCoBhkt
9WmgcR7y3tpt4W/WAyNhsIDmNzHkh/uch31VcQFBHSSgZBHqKgMr/jYllxHj0/T1
0m24rk6O8gJ2NoubCqZq+Yi//48olEAkvC6cwyvKVr/XQXeC6r8h3yzhp9dt1wUk
jVAVBGahk6U337XtXyvSdtAklS+0R54aiax3p10ucfYD+pBinp0RjYX894Qu6xwX
yqXK9CScqgjy0jPBr/TCzBqatLEmHx+JWDJ7x+hIJ2UrNuaJ6XCjb8bmc1hiukEn
D/YSe76wCFE88z9o0HyPZuNiSkBozXrvaInudljIx5UxbIJeMqWYdie4U3vrDMRS
ZM4xSscFUf5aZ0MaQXT6V2OsWMM1dgpIiQ6IsEzOTTIeBmGD8n1yL47lyuzAufrs
oZClfgAEUnU6MUZ5zn3W1hQUhTUGOx3WbdnmrvDmnUwwm3VPmE6WClyy65SJI6yE
uvWcaeF4gSxUvx2vuHDsOhv4whFOVhLGOfjK3nThzfpXJphzpSXkZFblUtvWtf0q
qZasnGx2eyfypwWA90h9d4KchbyDIT/oLrOR4CTSkLWSTquXhp8=
=jjsR
-----END PGP SIGNATURE-----

--3MHXEHrrXKLGx71o--
