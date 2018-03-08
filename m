Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934930AbeCHOPI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 09:15:08 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35793 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755026AbeCHOPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 09:15:05 -0500
X-Google-Smtp-Source: AG47ELsuht+ay9jdS+ZTw4RjzTg+McoefC6tRCTNnt8gtwyD/UyBSfMCZI4PfrcaTI+4bqf9q3BTSg==
Date: Thu, 8 Mar 2018 15:15:01 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ARM: tegra: fix ulpi regression on tegra20
Message-ID: <20180308141501.GH3529@ulmo>
References: <20180222143825.1517-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Enx9fNJ0XV5HaWRu"
Content-Disposition: inline
In-Reply-To: <20180222143825.1517-1-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Enx9fNJ0XV5HaWRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 03:38:25PM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> Since commit f8f8f1d04494 ("clk: Don't touch hardware when reparenting
> during registration") ULPI has been broken on Tegra20 leading to the
> following error message during boot:
>=20
> [    1.974698] ulpi_phy_power_on: ulpi write failed
> [    1.979384] tegra-ehci c5004000.usb: Failed to power on the phy
> [    1.985434] tegra-ehci: probe of c5004000.usb failed with error -110
>=20
> Debugging through the changes and finally also consulting the TRM
> revealed that rather than the CDEV2 clock off OSC requiring such pin
> muxing actually the PLL_P_OUT4 clock is in use. It looks like so far it
> just worked by chance of that one having been enabled which Stephen's
> commit now changed when reparenting sclk away from pll_p_out4 leaving
> that one disabled. Fix this by properly assigning the PLL_P_OUT4 clock
> as the ULPI PHY clock.
>=20
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> ---
>=20
> Changes in v2:
> - Updated device tree binding documentation as well.
> - CCing Dmitry as well.
>=20
>  Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt | 4 +++-
>  arch/arm/boot/dts/tegra20.dtsi                                   | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Applied, though I've split this into two separate patches, one going
into for-4.17/dt-bindings and the other going into for-4.17/arm/dt.

Thanks,
Thierry

--Enx9fNJ0XV5HaWRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqhRWIACgkQ3SOs138+
s6HhfBAAg0CQV4zr0TDf2no6qMG89CFANU2sd4FHRkaUAsoJw+i8Tphq+zb41kBo
b3MFA+KWqGx9cOQe7sRhc1M/mq4BhxA+EufLowo+uGe+ys/A+vFgEEwXvKFdnZzX
tucM25vzloq/9MjiSEiGAlxK3PAWFJekfK7TdfTphZ9pJjdZ0exjkLoQuRug3H2R
OQA8QCMnlcoSHeszFrImzqmc7lBATyZBVI4NDEbTixR4tRRSXJ3zQ2DpFx2zBTtD
xxZE+K3PAhEYbZQi4ANNhqfZcTlDhTL6ntkPhwalOyWPRt+HDphmOuIQTA1SmHlD
ZLDGpcrGnX2U1Zt9sgbW/urUMooRm9ckqNCCKIzngRpu9C6za7vE+7xjOrEnMSPZ
5q2465uMszlX5ggkIFZfPB/+t4ly7+35ToTVcvlkguKFSdjIxnEL2rB14mhE3IfX
/obl2BF3iAn29BXKmrqZWc4CNJfLj9+Q8beVC/3SmI+edl2SCwPPtArvxY2jTG7P
wkjjgrm7ko8BNYgIH/otdw1LtsWhGJY1GzHKBwPorq5HmYfOd2/nsIaX+SQQCiTE
J4l+orDgye1Wa92USeV0pDiG0ObuL/uBJS5/NPtXdnffEB5uyiBV6ZrY4h67zfaZ
+kxvmD7NZbfaDBQkJpZRe1UJWGSPfMKceZYt8bq16y5JcGKTlLs=
=tyQV
-----END PGP SIGNATURE-----

--Enx9fNJ0XV5HaWRu--
