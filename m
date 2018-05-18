Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752859AbeERKhk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:37:40 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41366 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752266AbeERKhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:37:37 -0400
X-Google-Smtp-Source: AB8JxZoqEaBe0eXgsQ2/MKMzXIuYufzlU4hib7XhCu2YTu16AVzZ+4FMo+9mn/CxAx76tNT9I+eofw==
Date: Fri, 18 May 2018 12:37:33 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marcel Ziswiler <marcel@ziswiler.com>, Marc Dietrich <marvin24@gmx.de>,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Restore ULPI USB on Tegra20
Message-ID: <20180518103733.GE5312@ulmo>
References: <20180508162607.3500-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Content-Disposition: inline
In-Reply-To: <20180508162607.3500-1-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2018 at 07:26:02PM +0300, Dmitry Osipenko wrote:
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
> Changelog:
>=20
> v3:
> 	- Use clk DT ID's instead of comparing clk names and make
> 	  custom of_src_onecell_get specific to Tegra20 clk provider
> 	  in the "Add quirk for getting CDEV1/2 clocks on Tegra20" patch
> 	  as was suggested by Peter De Schrijver for v2.
>=20
> v2:
> 	- Added new patch "Add quirk for getting CDEV1/2 clocks", assuring
> 	  that clk user won't get CDEV1/2 clocks until parent clk muxes
> 	  are available, i.e. resolves potential issue with CDEV-user driver
> 	  vs pinctrl driver probe order.
>=20
> 	- Factored out "pinctrl" patch from the patchset as was requested by
> 	  Linus Walleij.
>=20
> 	- Addressed v1 review comments: fixed swapped DEV1/2 clk div bits,
> 	  made DEV1/2 divs read-only, etc minor changes.
>=20
> Dmitry Osipenko (4):
>   clk: tegra20: Add DEV1/DEV2 OSC dividers
>   clk: tegra20: Correct parents of CDEV1/2 clocks
>   clk: tegra: Add quirk for getting CDEV1/2 clocks on Tegra20
>   ARM: dts: tegra20: Revert "Fix ULPI regression on Tegra20"

Patches 1-3 applied, thanks.

Thierry

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr+rO0ACgkQ3SOs138+
s6H60RAAiCLfvdhXE4xAETzkyCF5yZp9N2b/3dMIC6gxAhvXoHZqS7Ko7cgEfJL0
o+KxTf71EdOvIOZxNNvvLI/kiZBBrqdezvVUw0JkjTdrU2cRq1RPIC61Rvcpaq9F
Mz0pURAsunOr5GxysB710BqFU6IyYWMctOpiyRLZc0o4W6UuMagSEvG0savopXMD
MdWvEEmBA22TT4k1RtmB4vFgaCTya8pZYy0+Zq6DdcYUBNCT/tNazpFGjZ9Na4aM
AfBwCb64Hp1YtAEhg6dAODjy6c0cetFeE2W/8mIb44+RqFjlu/wtDwpS4Uf8BYA6
z7TUBWdfDD/HIbkdqh/rRCNu0vsNo36GpWGb0NqUWrNvkUfyyn42VLUHK3dd0LQM
omnVup0NIsdk6Tfi+N0iMe4qVLNP4JbW6FPvr0+wpphee8TygPVJ2H7Ijk5qjG30
5N165HgODS0Rr9KrjM5p1iqUVBpOx1AHxmTKazYPi5QI8OTAv9DWN3FWmZr9x50E
XlVqJA05H7m078yy0mACNwmXvumzPaYRWwt498cxiLTUHQ4tBG9jyKx5AxSpSzog
L3q+HKx70CPhBa/Ym31In2m9Zf94DIhwmGPz+8vP5fGLfJc1xKDASy+YybUTU+NS
tlvQ8VSCePRcJv9EkBeUNqYDS/mNGABgiWgMhjSp1oo1CDuu8XY=
=+hZo
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--
