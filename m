Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbeDDL4T (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 07:56:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751216AbeDDL4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 07:56:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3198C2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Wed, 4 Apr 2018 13:56:14 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: mapphone-mdm6600: add gpiolib dependency
Message-ID: <20180404115614.o5h5k6h4hmpjxaed@earth.universe>
References: <20180404102733.3747591-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nqqjfwbtibbah4dv"
Content-Disposition: inline
In-Reply-To: <20180404102733.3747591-1-arnd@arndb.de>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nqqjfwbtibbah4dv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 04, 2018 at 12:27:19PM +0200, Arnd Bergmann wrote:
> Without gpiolib, the gpiod_get_array_value_cansleep() is an empty stub,
> so gcc notices that the resulting array is never initialized:
>=20
> drivers/phy/motorola/phy-mapphone-mdm6600.c: In function 'phy_mdm6600_sta=
tus':
> drivers/phy/motorola/phy-mapphone-mdm6600.c:188:16: error: 'values[0]' is=
 used uninitialized in this function [-Werror=3Duninitialized]
>    val |=3D values[i] << i;
>           ~~~~~~^~~
> drivers/phy/motorola/phy-mapphone-mdm6600.c:188:16: error: 'values[1]' is=
 used uninitialized in this function [-Werror=3Duninitialized]
> drivers/phy/motorola/phy-mapphone-mdm6600.c:188:16: error: 'values[2]' is=
 used uninitialized in this function [-Werror=3Duninitialized]
> cc1: all warnings being treated as errors
>=20
> With gpiolib enabled, this can't happen and we don't get the warning, so
> let's just add a Kconfig dependency for it.
>=20
> Fixes: 5d1ebbda0318 ("phy: mapphone-mdm6600: Add USB PHY driver for MDM66=
00 on Droid 4")
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> ---
>  drivers/phy/motorola/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/phy/motorola/Kconfig b/drivers/phy/motorola/Kconfig
> index 82651524ffb9..718f8729701d 100644
> --- a/drivers/phy/motorola/Kconfig
> +++ b/drivers/phy/motorola/Kconfig
> @@ -13,7 +13,7 @@ config PHY_CPCAP_USB
> =20
>  config PHY_MAPPHONE_MDM6600
>  	tristate "Motorola Mapphone MDM6600 modem USB PHY driver"
> -	depends on OF && USB_SUPPORT
> +	depends on OF && USB_SUPPORT && GPIOLIB
>  	select GENERIC_PHY
>  	help
>  	  Enable this for MDM6600 USB modem to work on Motorola phones
> --=20
> 2.9.0
>=20

--nqqjfwbtibbah4dv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrEvVUACgkQ2O7X88g7
+ppxuw//ZMEm1ePwtcw5/7uhCTxI61SrVlSNLzALZMQunk9TJs2wWVOS4U4i1CCB
PzYK7Ith326wcnhHDQljkHdlpFRjMoOC6gD3+KubtrgVlwf9rHby41D8ox4W8cyk
xKZnNiuoLjx1PxZ63QLJNoTOC4r6BTg4D/DDpct1jqyOD+wRDTxK9OxuGHU6iEZe
nnC2RqEQv4patdhRwnijmcso+k2sLZS0EDMk4u6kNG5HyoqIjAZOhv15BG+9GqiJ
7SbI8s4GrlEkQWJaYfL05sX8b7MbC4RVKF6ePVgizh9DRvUqovXHUo7oFIQHZcJe
2aDGAVYWT2UgmFP8X2vNCnxAqxXfP2svY0dmB2bH2EaHyUl5sCXif9QQUtyyh2nL
dpukoizwAniEJAqqq/dFaEEDwhxEP4Wkp7/szeLr2l6kNGbw0Py/x1yYWDN1rz7h
+KoW/Cnmq9/aTkXxaiNtxzgP6XfnDLOBZGqRh+8OD/aS4Hw+g7q/o7faMt9t+AnC
3dhq9MR45CMWptZifB9iCSzQbi2rSHtDRntqYi/rUxd4fzzzJEveV2riL6QuEAzi
hZ0Go8rOA4Xg8zBdLcLdExAQDJlIDKBYnfBS9OPwX2UY3+dUWgz2930D6+eSDRvG
wN1rBNOOQXS812q+2NpaM55rQSZn3NTmZkHCtILwVDLV4xEGsD8=
=mpBT
-----END PGP SIGNATURE-----

--nqqjfwbtibbah4dv--
