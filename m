Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753081AbeD3Js2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:48:28 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42885 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeD3JsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:48:25 -0400
X-Google-Smtp-Source: AB8JxZoPQPq6tLr9BQyDrN73lJ8NyLoq3773iHtyvK3U9GFe253MWIPsOT+DWmnaAXDWM/n5yV3Mow==
Date: Mon, 30 Apr 2018 11:48:21 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Marcel Ziswiler <marcel@ziswiler.com>, Marc Dietrich <marvin24@gmx.de>,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] Restore ULPI USB on Tegra20
Message-ID: <20180430094821.GC2476@ulmo>
References: <20180426235818.10018-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline
In-Reply-To: <20180426235818.10018-1-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 27, 2018 at 02:58:14AM +0300, Dmitry Osipenko wrote:
> Hello,
>=20
> This series of patches fixes ULPI USB on Tegra20. The original problem
> was reported by Marcel Ziswiler, he found that "ulpi-link" clock was
> incorrectly set to CDEV2 instead of PLL_P_OUT4. Marcel made a patch
> that changed the "ulpi-link" clock to PLL_P_OUT4 and that fixed issue
> with the USB for the devices that have CDEV2 being enabled by bootloader.
> The patch got into the kernel and later Marc Dietrich found that USB
> stopped working on the "paz00" Tegra20 board. After a bit of discussion
> was revealed that PLL_P_OUT4 is the parent clock of the CDEV2 and clock
> driver was setting CDEV2's parent incorrectly. The parent clock is actual=
ly
> determined by the pinmuxing config of CDEV2 pingroup. This patchset fixes
> the parent of CDEV2 clock by making Tegra's pinctrl driver a clock provid=
er,
> providing CDEV1/2 clock muxes (thanks to Peter De Schrijver for the
> suggestion), and then setting these clock muxes as parents for the CDEV1/2
> clocks. In the end Marcel's CDEV2->PLL_P_OUT4 change is reverted since CD=
EV2
> (aka MCLK2) is the actual clock source for "ulpi-link".
>=20
> Dmitry Osipenko (4):
>   clk: tegra20: Add DEV1/DEV2 OSC dividers
>   pinctrl: tegra20: Provide CDEV1/2 clock muxes
>   clk: tegra20: Set correct parents for CDEV1/2 clocks
>   ARM: dts: tegra20: Revert "Fix ULPI regression on Tegra20"
>=20
>  arch/arm/boot/dts/tegra20.dtsi          |  2 +-
>  drivers/clk/tegra/clk-tegra20.c         | 18 +++++++++++----
>  drivers/pinctrl/tegra/pinctrl-tegra.c   | 11 ---------
>  drivers/pinctrl/tegra/pinctrl-tegra.h   | 11 +++++++++
>  drivers/pinctrl/tegra/pinctrl-tegra20.c | 30 ++++++++++++++++++++++++-
>  5 files changed, 55 insertions(+), 17 deletions(-)

Stephen, Michael, Linus,

as far as I can tell there aren't any build dependencies between the
above, so technically these could all be merged through the individual
trees. There's a runtime dependency from patch 2 on patch 1 and from
patch 3 on patch 2, though I don't think they will cause any actual
failures at runtime.

But I can also pick this up into the Tegra tree and send out pull
requests to you for v4.18 (at around v4.17-rc6), if that's what you
prefer.

Thierry

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrm5mUACgkQ3SOs138+
s6HYZA/+Jd9SEUtBU37s8HSilhhRW0RMjH2s3kCNHRU7mK0Ub6nPk8VlHhdzn7z5
emLliMzIBxoLYlaf/msP04X2O6vtQaAlN2WBMmQxIRTHZLgSgMozxMRoimI4hAAB
7pNnWisHeukGD4lsmyCvObCy2vvYay8PljgTaGe9128WkQSJQxk29sqnzQ58vnb9
4c7dsmJ0ZXCfWAWhXnC5EJXdq0Ojhro44Vywh8XR1+TghIKwbrxjE5IzzGVD3Ydw
iEhJe3IP5Hy3awb74nnpYUDyFTHcxBpBNIqQ7cedI9xDwfoGJ+etpit0YsMU2aVF
AuhpeVUYSH3L0ZwdeMrh/KOgVuWkqP8BrPmDNxrtIBs+ZwSri6+01fv2f1MI0aCM
UcLny3r0x/+plRyeLVcb0z22QQ/eYDYMrKODF/6pIP5nUls12M+RjE/GRfeQwCmY
EvZ38fWMnCAmC9WqWaoB++kG7EZf1bCjL1lIGboBmb9MNLqWhG3EioLXKzgwl/Kj
0xZpf1dy070UJhovG4ZB83IU3UUBzo7NaLKGaQkDHwp+gJiCPlaGSfsa0ne8cOcG
7Yk3jzyRNrBE/OgeWG/9XuDYUL+6wuRG/Wgpxs6vURFXFJHxMTSeHSKe8iGgipij
l0MvB6r3nGHV2tIi+494Sa5gd4cRqqx8nm9ywOOGHL3ThIdHOUo=
=qn1g
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
