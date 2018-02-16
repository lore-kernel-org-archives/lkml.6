Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034328AbeBPO1A (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:27:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034273AbeBPO06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:26:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2FF217C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Fri, 16 Feb 2018 15:26:55 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Carlo Caione <carlo@caione.org>
Cc: linux@endlessm.com, hdegoede@redhat.com, rjw@rjwysocki.net,
        lenb@kernel.org, wens@csie.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Carlo Caione <carlo@endlessm.com>
Subject: Re: [PATCH v2 3/3] power: supply: axp288_fuel_gauge: Do not register
 FG on ECS EF20EA
Message-ID: <20180216142655.heommid67q3g22qt@earth.universe>
References: <20180216082616.25084-1-carlo@caione.org>
 <20180216082616.25084-4-carlo@caione.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wshm6zzqjg7sveev"
Content-Disposition: inline
In-Reply-To: <20180216082616.25084-4-carlo@caione.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wshm6zzqjg7sveev
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 16, 2018 at 08:26:16AM +0000, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
>=20
> The ECS EF20EA laptop ships an AXP288 but it is actually using a
> different, separate FG chip for AC and battery monitoring. On this
> laptop we need to keep using the regular ACPI driver and disable the
> AXP288 FG to avoid reporting two batteries to userspace.
>=20
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---

It looks like this could be applied independently of the ACPI
patches to the power-supply tree?

-- Sebastian

>  drivers/power/supply/axp288_fuel_gauge.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/sup=
ply/axp288_fuel_gauge.c
> index 4cc6e038dfdd..903891a9bcf0 100644
> --- a/drivers/power/supply/axp288_fuel_gauge.c
> +++ b/drivers/power/supply/axp288_fuel_gauge.c
> @@ -708,6 +708,12 @@ static const struct dmi_system_id axp288_fuel_gauge_=
blacklist[] =3D {
>  			DMI_MATCH(DMI_BOARD_VERSION, "V1.1"),
>  		},
>  	},
> +	{
> +		/* ECS EF20EA */
> +		.matches =3D {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
> +		},
> +	},
>  	{}
>  };
> =20
> --=20
> 2.14.1
>=20

--wshm6zzqjg7sveev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqG6i8ACgkQ2O7X88g7
+poL4g/+OPnzr2lxPcaXb2Q+dNqRgWMa69O+3rKWZRGnUnYxToNTdCBvNFfKj6zJ
7kZeVYmTotevZatUiV6mDpmLxQ4JvtuwfFOsOucSXktfNIzEx50ByK3lvoLWSsxt
bAVDPXXZ6vHQ/Wx3wCQ8Jgr7QvuMC05YK5YtY/KTALoWRcD1/Pn+/rDpCsAtzxKz
aHuVQmT/fbZV42vInm49yW65NXRlLgWjgh1h0jf6o5DhA9Aya8ahHOBO92k7zmmw
4/stjP871xt80YoLl29derLI+l5UGcTTsQdxpZyCz04lZWodwVr5SbPo+nXDzXYA
zvPU3vb/EiSTL0H8UJCPZ03ZNIKtOMQQi1iokWuDzYCSZZ5qpFAM7TnzXoYULSQh
kshiT7lbRip1dSapqlJaIEFew4Z7MLMkCPlfa0n8IkBtu57hDgO3tJZ2i56nAcLo
uuU2m1Y/iWPgCl+2Awe+yeb196+7eIOH4ASBCnIx+UeGSMm8h7SaQVgnMJn6lPvc
lqR0T2af89PBGhjb/rgxLUelmK5xIpaFFNKHlMLSscTkqV/dzDsgcR4Pp4rS1gNg
XJ+sZJ2K4pLtCV5BbcQnHZ6FXpqVMB3n8MuheUJAjLL4WUxHz5Ki2MAOlI90/k/m
MGmy+Sj8aTpo+PK/ui0BZ9yf3hNKEMbbDEXO4nVSpqq1xOaRgG4=
=2r8q
-----END PGP SIGNATURE-----

--wshm6zzqjg7sveev--
