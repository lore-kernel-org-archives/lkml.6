Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeDQLRu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:17:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54692 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752048AbeDQLRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:17:49 -0400
Date: Tue, 17 Apr 2018 13:17:37 +0200
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
Message-ID: <20180417111737.6dous6eiuvjn33jf@flea>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
 <20180416215032.5023-2-mylene.josserand@bootlin.com>
 <CAGb2v67VL70yqTF7xq4T3_9zA9T3UT2AV0gGarh1mqvC17r3Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yvm7jzmek2gzjswi"
Content-Disposition: inline
In-Reply-To: <CAGb2v67VL70yqTF7xq4T3_9zA9T3UT2AV0gGarh1mqvC17r3Mg@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yvm7jzmek2gzjswi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 11:12:41AM +0800, Chen-Yu Tsai wrote:
> On Tue, Apr 17, 2018 at 5:50 AM, Myl=E8ne Josserand
> <mylene.josserand@bootlin.com> wrote:
> > Move the assembly code for cluster cache enabling and resuming
> > into an assembly file instead of having it directly in C code.
> >
> > Remove the CFLAGS because we are using the ARM directive "arch"
> > instead.
> >
> > Signed-off-by: Myl=E8ne Josserand <mylene.josserand@bootlin.com>
> > ---
> >  arch/arm/mach-sunxi/Makefile  |  4 +--
> >  arch/arm/mach-sunxi/headsmp.S | 80 +++++++++++++++++++++++++++++++++++=
++++++
> >  arch/arm/mach-sunxi/mc_smp.c  | 82 +++--------------------------------=
--------
> >  3 files changed, 85 insertions(+), 81 deletions(-)
> >  create mode 100644 arch/arm/mach-sunxi/headsmp.S
>=20
> I'm still not convinced about this whole "move ASM to separate
> file" thing, especially now that you aren't actually adding any
> sunxi-specific ASM code beyond a simple function call.
>=20
> Could you drop this for now?

I'd really like to have this merged actually. There's a significant
readibility improvement, so even if there's no particular functional
improvement, I'd still call it a win.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--yvm7jzmek2gzjswi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrV18IACgkQ0rTAlCFN
r3TUWQ/7B0JVFTu+pGkZ5LNuMgkX8vWoq7z2+YONHBId8EhllSYp9Uv8y4A9CEUR
1qk6YZvV1RHXVU1COlHt/SKMbHC57L57Q2LKxKnHKQF3OBLJW2ZZ5MukEsUIjU+C
VnHr8tlH0MlMRMdg01KJ0muDzs/tUJu4J7JZNpJTjGlrYiTX910Dvc9SkZgYVeiW
Zt8UHloyr2boWZwANdFLjNYq14C89Yqb/qubDS4o2aKX/WkS70OAFUAu2eRua8ky
nneVbq483jxLgS+AtNRFIH+DXDy2kzggOlfeQjuXJo9RdfKx37wpWDIudLYt6Cpg
/HhWApYAyUaXHUKtTKrcXj6jGL+9OBfyEXWbNDO4EEvUCzWD69DMp+EuLnUDbT5I
qVoi8pSrYAxKCtpqcLiOe65mc/rWtyvBpVMDPth5QipqRtz7n4n2y8uWyDX5EaFl
RPjgf0N9ibGT/7chPOaANcWZLsrZ6WGFwNwq9R2ZOaRlDXp+3IMVeuy/Ia/i4/i0
Jjot1rDkztsC0D9b1GXdrO34n82vDrZh0YAUj6kvyqeTEwgBIxLHkGAoDZHZpCp2
AXYZ7eaKVXHO9Cpz0AcHYfeg72VH33nHREyhos+aBg+NXnHYn+XvdSxqxarzrCJX
M5PwdlxUo6iHjLUEUBnSXou7jchdAaSPOtZmE70Yb1elEiPZnSE=
=4euM
-----END PGP SIGNATURE-----

--yvm7jzmek2gzjswi--
