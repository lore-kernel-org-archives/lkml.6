Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932755AbeCMNhG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:37:06 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17818 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbeCMNhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:37:05 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 13 Mar 2018 06:37:02 -0700
Date: Tue, 13 Mar 2018 14:36:58 +0100
From: Thierry Reding <treding@nvidia.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: Jassi Brar <jassisinghbrar@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mailbox: tegra: relax TEGRA_HSP_MBOX Kconfig dependencies
Message-ID: <20180313133654.GA5374@ulmo>
References: <20180313121154.2715591-1-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20180313121154.2715591-1-arnd@arndb.de>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.21.62.192]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To UKMAIL101.nvidia.com
 (10.26.138.13)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 01:11:43PM +0100, Arnd Bergmann wrote:
> With the addition of the ARCH_TEGRA_194_SOC driver, we get a new Kconfig =
warning:
>=20
> warning: (ARCH_TEGRA_186_SOC && ARCH_TEGRA_194_SOC) selects TEGRA_HSP_MBO=
X which has unmet direct dependencies (MAILBOX && ARCH_TEGRA_186_SOC)
>=20
> It looks like the dependency is a bit too strict here, allowing the drive=
r to
> be built for any Tegra chip avoids the problem.
>=20
> Fixes: 6f9ed07fde03 ("soc/tegra: Add Tegra194 SoC configuration option")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mailbox/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The HSP does not exist on any chip prior to Tegra186, which is what the
dependency reflects. However, I agree that there is little point for an
exact list of per-chip dependencies. We don't really support non-multi-
platform kernels anymore, or at least they don't get any testing, so
relaxing the dependency is fine with me.

Acked-by: Thierry Reding <treding@nvidia.com>

Thanks for fixing this,
Thierry

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqn0+MACgkQ3SOs138+
s6HwChAAjK4QWoQQVt9W/SrGaal40X37AzJEkMgkZXoB97d5h3tvCaKDXRLoqJED
DYMRiO8muoNEY6glxf9YAPxXKq2NVvDxAUfuaVxgbw3c73XtWG7u+mS2gtLxhZLn
30IhG9T9urckxZIRrkN9HUcSYB2ZD7hXOGHSNshtFtvs3FLuRVMX5ee45X95eMPJ
rpHEZx846W2FwB3zkiSyT2Kt3flz1LYHh1nu98ysRgAEreiXbaN0BqT+ZuCPtt80
m1T4pFzMEfNuLYmPJlnsMwwDKIV4kiqNxkRZ0a+JjiR9Bsf1Of19FLQjlt5pyVHA
KnJXA0KjA7vEC8h30EUCqiI0Cfle6INbjAFiY0GzfMyWpxHzcDVpVzMdxaACD9In
u3CA4Gy3tkJm42q2hbrsIEPmXVj1OHBCAz9WkgVJ6qGUJAJDf4tZQWCFNz9GbwsY
UTlF70dXxcuEJQMyLiGrtvx722ucmhjF3P2xheiPaDfl06x77oaNikv1UbvN8Nsx
anyB76ptEHbba7B0a3V9Of+oeDizk+G+8qjzkupF49NiM4fcVUE0t4UNbNTquScR
L9ycZCROkLCchF+Cl5ajr39E/a2hLuydIQ3Or9FKR2XEdPijP+n+p+L2LUctcIkO
DFBmXB//5CJhMBbUulPwgUE+txk/ax+4xtV/Fk7z0tZmGCHXNI4=
=NcWs
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
