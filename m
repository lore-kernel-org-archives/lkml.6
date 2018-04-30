Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbeD3IIn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 04:08:43 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35360 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbeD3IIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 04:08:41 -0400
X-Google-Smtp-Source: AB8JxZqCw00U7/IJpRQfvMRhWbWiJ5n0piQ2tARD6ZQVHUoM83bxoTLsfCrRHQhIN6xBqGxEfWgvhQ==
Date: Mon, 30 Apr 2018 10:08:38 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/15] memory: tegra: Add Tegra210 memory controller
 hot resets
Message-ID: <20180430080838.GC2484@ulmo>
References: <cover.1523301400.git.digetx@gmail.com>
 <f064d034477537bfb5473c1277da07d772b0d4b5.1523301400.git.digetx@gmail.com>
 <20180427093927.GK30388@ulmo>
 <935ad30c-1ade-3380-ad4d-f5ffbbe63a66@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
In-Reply-To: <935ad30c-1ade-3380-ad4d-f5ffbbe63a66@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 28, 2018 at 11:18:38AM +0300, Dmitry Osipenko wrote:
> On 27.04.2018 12:39, Thierry Reding wrote:
> > On Fri, Apr 13, 2018 at 02:33:50PM +0300, Dmitry Osipenko wrote:
> >> From: Thierry Reding <treding@nvidia.com>
> >>
> >> Define the table of memory controller hot resets for Tegra210.
> >>
> >> Signed-off-by: Thierry Reding <treding@nvidia.com>
> >> ---
> >>  drivers/memory/tegra/tegra210.c | 45 +++++++++++++++++++++++++++++++++
> >>  1 file changed, 45 insertions(+)
> >>
> >> diff --git a/drivers/memory/tegra/tegra210.c b/drivers/memory/tegra/te=
gra210.c
> >> index b729f49ffc8f..d00a77160407 100644
> >> --- a/drivers/memory/tegra/tegra210.c
> >> +++ b/drivers/memory/tegra/tegra210.c
> >> @@ -1080,6 +1080,48 @@ static const struct tegra_smmu_soc tegra210_smm=
u_soc =3D {
> >>  	.num_asids =3D 128,
> >>  };
> >> =20
> >> +#define TEGRA210_MC_RESET(_name, _control, _status, _bit)	\
> >> +	{							\
> >> +		.name =3D #_name,					\
> >> +		.id =3D TEGRA210_MC_RESET_##_name,		\
> >> +		.control =3D _control,				\
> >> +		.status =3D _status,				\
> >> +		.bit =3D _bit,					\
> >> +	}
> >> +
> >> +static const struct tegra_mc_reset tegra210_mc_resets[] =3D {
> >> +	TEGRA210_MC_RESET(AFI,       0x200, 0x204,  0),
> >> +	TEGRA210_MC_RESET(AVPC,      0x200, 0x204,  1),
> >> +	TEGRA210_MC_RESET(DC,        0x200, 0x204,  2),
> >> +	TEGRA210_MC_RESET(DCB,       0x200, 0x204,  3),
> >> +	TEGRA210_MC_RESET(HC,        0x200, 0x204,  6),
> >> +	TEGRA210_MC_RESET(HDA,       0x200, 0x204,  7),
> >> +	TEGRA210_MC_RESET(ISP2,      0x200, 0x204,  8),
> >> +	TEGRA210_MC_RESET(MPCORE,    0x200, 0x204,  9),
> >> +	TEGRA210_MC_RESET(NVENC,     0x200, 0x204, 11),
> >> +	TEGRA210_MC_RESET(PPCS,      0x200, 0x204, 14),
> >> +	TEGRA210_MC_RESET(SATA,      0x200, 0x204, 15),
> >> +	TEGRA210_MC_RESET(VI,        0x200, 0x204, 17),
> >> +	TEGRA210_MC_RESET(VIC,       0x200, 0x204, 18),
> >> +	TEGRA210_MC_RESET(XUSB_HOST, 0x200, 0x204, 19),
> >> +	TEGRA210_MC_RESET(XUSB_DEV,  0x200, 0x204, 20),
> >> +	TEGRA210_MC_RESET(A9AVP,     0x200, 0x204, 21),
> >> +	TEGRA210_MC_RESET(TSEC,      0x200, 0x204, 22),
> >> +	TEGRA210_MC_RESET(SDMMC1,    0x200, 0x204, 29),
> >> +	TEGRA210_MC_RESET(SDMMC2,    0x200, 0x204, 30),
> >> +	TEGRA210_MC_RESET(SDMMC3,    0x200, 0x204, 31),
> >> +	TEGRA210_MC_RESET(SDMMC4,    0x970, 0x974,  0),
> >> +	TEGRA210_MC_RESET(ISP2B,     0x970, 0x974,  1),
> >> +	TEGRA210_MC_RESET(GPU,       0x970, 0x974,  2),
> >> +	TEGRA210_MC_RESET(NVDEC,     0x970, 0x974,  5),
> >> +	TEGRA210_MC_RESET(APE,       0x970, 0x974,  6),
> >> +	TEGRA210_MC_RESET(SE,        0x970, 0x974,  7),
> >> +	TEGRA210_MC_RESET(NVJPG,     0x970, 0x974,  8),
> >> +	TEGRA210_MC_RESET(AXIAP,     0x970, 0x974, 11),
> >> +	TEGRA210_MC_RESET(ETR,       0x970, 0x974, 12),
> >> +	TEGRA210_MC_RESET(TSECB,     0x970, 0x974, 13),
> >> +};
> >=20
> > Isn't this missing an include for the definitions? There is an include
> > for dt-bindings/memory/tegra20-mc.h for the Tegra20 driver, but none of
> > the others have it.
>=20
> Those drivers already have dt-bindings included.

You're right. Patch applied, thanks.

Thierry

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrmzwUACgkQ3SOs138+
s6G15A/+NobhSEOf4Cdt2pVCr/kB9v2FoL9GUFVi6DYpksw1D3WaOnWCy7ymN0fP
A6V4HJXAlt9w9Zs2IRhBpMNtWCvH6xQA+tEnH3RYXnmYLYYfw/hSqvbGVM7xmn5f
I39GCwQBPTiI3c8KyGl1hhAXBoSUtclf+tQZ80Vpy+T7AU1Xv2o5ExBX13WyeQwj
nGc3IKePnHq2Rc/e7ntDpU/DcWdCDLkdiEv6cVh6RQM+rAjB8jiFzL+0gqgowgwe
cNhZHd/fEUohLKr/q6W4QC/8uNI43pjDoxXjy3JCz8bbzx6WDtLzEiCB/b9NXG/a
VXw3/LF5tpI8tCAUwbvPFD9bate79ozVqW0g4W4kwB60ZAbeJ+E6jUPpEEkulzp+
S5ZWpeupOx0gcp3erpbDKm6BwdCllCWcezWT8Dvb/dj6AwqU0wRLH8Xi8IczK6X0
6SNHLgZgBy2e3uXPR2tvbyFZu2aNrOke6AgldbL11Qg4l/NU/92h/pqalPY3U2/m
kp2ZXAc1lrJZis/1yOwgz4sWltsDNG4kgsu2Q1cuYze/0Am6CR0KHiMbXyTEiD9Q
7vMlHjpKjjexn/Gj1IGuRbWidJHAKnoEf3Y3bce24ZC3PGL1TRDI5j3nzqwWjay9
y7NbG/hTCGfNPmanajUsj7w79/zq9H2t+TpWdfEA77UO9K+yZu0=
=8TPz
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
