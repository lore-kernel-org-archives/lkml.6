Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbeD3L2K (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 07:28:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54583 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbeD3L2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 07:28:07 -0400
X-Google-Smtp-Source: AB8JxZrkn0OBF4u4A6lGS35G6xCkvpyDHQBvBeYVO6h4IC9G0mZ2C19P7m0NakOcjMHDkt33Ak5lMg==
Date: Mon, 30 Apr 2018 13:28:04 +0200
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
Message-ID: <20180430112804.GA5770@ulmo>
References: <20180426235818.10018-1-digetx@gmail.com>
 <20180430094821.GC2476@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20180430094821.GC2476@ulmo>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 11:48:21AM +0200, Thierry Reding wrote:
> On Fri, Apr 27, 2018 at 02:58:14AM +0300, Dmitry Osipenko wrote:
> > Hello,
> >=20
> > This series of patches fixes ULPI USB on Tegra20. The original problem
> > was reported by Marcel Ziswiler, he found that "ulpi-link" clock was
> > incorrectly set to CDEV2 instead of PLL_P_OUT4. Marcel made a patch
> > that changed the "ulpi-link" clock to PLL_P_OUT4 and that fixed issue
> > with the USB for the devices that have CDEV2 being enabled by bootloade=
r.
> > The patch got into the kernel and later Marc Dietrich found that USB
> > stopped working on the "paz00" Tegra20 board. After a bit of discussion
> > was revealed that PLL_P_OUT4 is the parent clock of the CDEV2 and clock
> > driver was setting CDEV2's parent incorrectly. The parent clock is actu=
ally
> > determined by the pinmuxing config of CDEV2 pingroup. This patchset fix=
es
> > the parent of CDEV2 clock by making Tegra's pinctrl driver a clock prov=
ider,
> > providing CDEV1/2 clock muxes (thanks to Peter De Schrijver for the
> > suggestion), and then setting these clock muxes as parents for the CDEV=
1/2
> > clocks. In the end Marcel's CDEV2->PLL_P_OUT4 change is reverted since =
CDEV2
> > (aka MCLK2) is the actual clock source for "ulpi-link".
> >=20
> > Dmitry Osipenko (4):
> >   clk: tegra20: Add DEV1/DEV2 OSC dividers
> >   pinctrl: tegra20: Provide CDEV1/2 clock muxes
> >   clk: tegra20: Set correct parents for CDEV1/2 clocks
> >   ARM: dts: tegra20: Revert "Fix ULPI regression on Tegra20"
> >=20
> >  arch/arm/boot/dts/tegra20.dtsi          |  2 +-
> >  drivers/clk/tegra/clk-tegra20.c         | 18 +++++++++++----
> >  drivers/pinctrl/tegra/pinctrl-tegra.c   | 11 ---------
> >  drivers/pinctrl/tegra/pinctrl-tegra.h   | 11 +++++++++
> >  drivers/pinctrl/tegra/pinctrl-tegra20.c | 30 ++++++++++++++++++++++++-
> >  5 files changed, 55 insertions(+), 17 deletions(-)
>=20
> Stephen, Michael, Linus,
>=20
> as far as I can tell there aren't any build dependencies between the
> above, so technically these could all be merged through the individual
> trees. There's a runtime dependency from patch 2 on patch 1 and from
> patch 3 on patch 2, though I don't think they will cause any actual
> failures at runtime.
>=20
> But I can also pick this up into the Tegra tree and send out pull
> requests to you for v4.18 (at around v4.17-rc6), if that's what you
> prefer.

Marc just pointed out to me on IRC that this fixes a regression that was
introduced in v4.17-rc1.

Can you guys pick this up into your -fixes branches? Again, I volunteer
to collect these into a separate branch and submit via ARM SoC (the DTS
patch is crucial in enabling the fix) with your Acked-bys if that's the
preferred option.

Thierry

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrm/cEACgkQ3SOs138+
s6GwGhAAsBYMU6OfkVDBMYaVoDuMn0nzGwKlLnJ4idXGkoSPlVevGYqVM+mmBpoQ
Ep57Ctbq5cbs5i+4uS1dUI1pZfv7cHUsxABicSPSsvj86lh9fXepI5o9NMDJLIt+
C+xQ8IQnwCKWrn5sDQ6yhFKrA41lIkXEyoYZgGhotyxMZx9f+YA6xv/a/0Bp7nA+
EHEfu5wF+0hyQI1KDEkWpBxE9C/ptgz0c9Uc1joD5CTXdoZRmbyycDwfgBvL6vJY
WQv/y1iNsNNbSCynHnbhx9RvWBSEV61lfaZohjoI6Je5YOgj7I17ujbVSR7tHGAd
JRQ5jY1yi88t/SGaot+1ZzyjBhAHlCCm6SPZRwGnKe2BNyvVr3CW1pFDgJa+M9dn
6gjz0qxJV4eZvauHIBoqlpVKTN4UFYyjVRkyvi57iJiX9Vn5eEX+I3HnbMUTbHvD
DBJJJODc9maE8Sr0kMn4PSabYi6HLyJEKSqYSGgDT852Sc9S2vq9428eGVDJEgx7
DUnG3xgxRjmSFVr25zLQhUE5du2hNce9ZDSYQQ+g2fqa4wcFN2C0eVdkmD9cqbVh
juoPUkoXb32338MH+E46rfwT8J1jhCLb0IT7Cdis6dI57JzMVgAZMH25viUwygc9
2bG6mEfUVi9nF35raMTGadHb2AyABkousQcgOjdcs6VAfAKPk18=
=LwJ4
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
