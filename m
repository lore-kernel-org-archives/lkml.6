Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbeDRIpj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:45:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55771 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751407AbeDRIph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:45:37 -0400
Date: Wed, 18 Apr 2018 10:45:35 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Simon <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:ARM/SHMOBILE ARM..." <linux-renesas-soc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 01/11] ARM: sunxi: smp: Move assembly code into a file
Message-ID: <20180418084535.lqdvjgcbxtnwqwri@flea>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
 <20180416215032.5023-2-mylene.josserand@bootlin.com>
 <CAGb2v67VL70yqTF7xq4T3_9zA9T3UT2AV0gGarh1mqvC17r3Mg@mail.gmail.com>
 <20180417111737.6dous6eiuvjn33jf@flea>
 <CAGb2v67qvk=T7u7bOjVZ7q_qsjJuEOM6iarw7by42ga=EYuYDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o4k7srs655m3j7t2"
Content-Disposition: inline
In-Reply-To: <CAGb2v67qvk=T7u7bOjVZ7q_qsjJuEOM6iarw7by42ga=EYuYDg@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o4k7srs655m3j7t2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 07:25:15PM +0800, Chen-Yu Tsai wrote:
> On Tue, Apr 17, 2018 at 7:17 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Tue, Apr 17, 2018 at 11:12:41AM +0800, Chen-Yu Tsai wrote:
> >> On Tue, Apr 17, 2018 at 5:50 AM, Myl=E8ne Josserand
> >> <mylene.josserand@bootlin.com> wrote:
> >> > Move the assembly code for cluster cache enabling and resuming
> >> > into an assembly file instead of having it directly in C code.
> >> >
> >> > Remove the CFLAGS because we are using the ARM directive "arch"
> >> > instead.
> >> >
> >> > Signed-off-by: Myl=E8ne Josserand <mylene.josserand@bootlin.com>
> >> > ---
> >> >  arch/arm/mach-sunxi/Makefile  |  4 +--
> >> >  arch/arm/mach-sunxi/headsmp.S | 80 ++++++++++++++++++++++++++++++++=
+++++++++
> >> >  arch/arm/mach-sunxi/mc_smp.c  | 82 +++-----------------------------=
-----------
> >> >  3 files changed, 85 insertions(+), 81 deletions(-)
> >> >  create mode 100644 arch/arm/mach-sunxi/headsmp.S
> >>
> >> I'm still not convinced about this whole "move ASM to separate
> >> file" thing, especially now that you aren't actually adding any
> >> sunxi-specific ASM code beyond a simple function call.
> >>
> >> Could you drop this for now?
> >
> > I'd really like to have this merged actually. There's a significant
> > readibility improvement, so even if there's no particular functional
> > improvement, I'd still call it a win.
>=20
> What parts do you consider hard to read? The extra quotes? Trailing
> newline? Or perhaps the __stringify bits?

All of this, plus the clobbers and operands.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--o4k7srs655m3j7t2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrXBa4ACgkQ0rTAlCFN
r3SsRg//ZieKDRJoIHs9a5V8pamTZtxCiW41aetlRvlWtZOhxQkTjPxiTAtUsg4Q
M6ZVjKvPqSemN64xYMpvakIU3I6KCfmL4HMpqdYhlQBohIrS7gx12/6Vc0rAmrtU
6Ms+UvV8oo2dEjFv8p7Y3x2GBnWqD4UdC+5vnheVh9DihOiSXAo5vAZ+UqS8+JwB
dsLkmdvy5iVngIiy0vdAAGREmn/E84jLhRbZTrN+BKpiUG8zz8mOHUBIJ0lWRsmJ
mnXtuptgWJkY2W7ehPe0qp8uU+VGUsF6vegoYIauEcjBS6wuAvKKyLlLIs2npvYf
UzkR0Hk9gXFU9fvMOovgmw2PfxPD1e7Aci1MDn3bTfBoN4dM3q2wKm2lWOX2D0UK
a2Q8p4DYYw4ClaAGv0x3b4QIbH3GfFu9H0YuFV+s1spv1/cKjNwWwPQgsrSxAjYF
sbCdsaM62FLko0RXCG3DFKcYfaVkGN0p95IDk5wOUO7rQfkFX1vdKkKu7cAHCOqW
3Eg4VAH6YttyQB/4Z2UYgzj5oD3nmzG/oT5ElREVt986PjNV2/9Z529d9ZieX0jZ
rSeF4IcgKhj1EYehrJv5KvcpsiWc0Ip/EqYfUY2k4THuTIcQIJ1RclJTVyiSxqfg
oQxw+a5XltDfpau5il5nv7l1mccaGCgx6ViiS1M1OP6HT+mdWaE=
=QJnY
-----END PGP SIGNATURE-----

--o4k7srs655m3j7t2--
