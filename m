Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934977AbeE2Of2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:35:28 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37008 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934533AbeE2Of0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:35:26 -0400
X-Google-Smtp-Source: AB8JxZpmHQpHrNevo29HojJGH7q1FGBU9n+GswAqpyARzSMl5Za3HU0EgYrY4BV65OC/DIPb64Kwnw==
Date: Tue, 29 May 2018 16:35:23 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, arm@kernel.org,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: tegra: fix compile-testing PCI host driver
Message-ID: <20180529143523.GC22634@ulmo>
References: <20180528155603.2897776-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
In-Reply-To: <20180528155603.2897776-1-arnd@arndb.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 28, 2018 at 05:55:29PM +0200, Arnd Bergmann wrote:
> The tegra_cpuidle_pcie_irqs_in_use() function is stubbed out for non-ARM
> builds, but now we can compile-test the Tegra pci driver on non-Tegra
> ARM platforms as well, which results in a new link error:
>=20
> drivers/pci/host/pci-tegra.o: In function `tegra_pcie_map_irq':
> pci-tegra.c:(.text+0x288): undefined reference to `tegra_cpuidle_pcie_irq=
s_in_use'
> drivers/pci/host/pci-tegra.o: In function `tegra_msi_map':
> pci-tegra.c:(.text+0xba0): undefined reference to `tegra_cpuidle_pcie_irq=
s_in_use'
>=20
> This adapts the #ifdef statement to match the exact condition under which
> the function can be called.
>=20
> Fixes: 51bc085d6454 ("PCI: Improve host drivers compile test coverage")
> Cc: Rob Herring <robh@kernel.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/soc/tegra/cpuidle.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsNZSoACgkQ3SOs138+
s6Ec3A//Zw0zUyLLCkCndx7u2+S72eIFGD3MuGqe0POjx0YF6R5XOtJRjlIoFW2s
9L9srM7kuRjDCcfRamywQA28RbqHm9nrfP7ZrC9bMg2nUsN6rY43OexWNRuko1Z5
F490DiSy7OmJWklqaoUEyKTfJlhAHA+P+ybLniW7tA6swsG/yvVnPjwB/QtsDsnH
nP7e2BupmuQkwqP6BZiPVgfmAPRE1oqFTkqthQr6Y7g5T7ruo/5RqYl3kSuK9Jwq
+QBRbO6H+S0rfmiehhN6dpdeU79W6t4kKipiLQ1lxim04zh0je8owxcUjtP44I9V
LFImmaoHCGNCX/sQDSYeT+pN6fyIZV9YZeUsHpF7epCL3f3HO8hIRV+FG8pNHF9t
BxhefiwMH4P2d6B5/NzsLAEZzHS/FaWYygUTiFRaa3RoUhs28HXmcNiOzpEj1nTB
VvYTc0RKGI82CBSuXt75BQPbOcWqKW0dgM/dwQIqVkagDqgiRisys1FcgAOzUkII
hAfjs6Qg9rHeMR3Eecb7GbFrxvw7OeLobSCznGow0uP1aI3J/n537AeTZ1UCENEl
0EDbgdd/fLNvGBGSdSFapM5HsyAHtVZss50qdPjBr95/XjySNOMroVCgzC+F8Ewv
lNuKbfI79fjmRi3N7RhVb6lcjkX+h0RhiWsQbH9SI5eu0MAP7wU=
=dY5R
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
