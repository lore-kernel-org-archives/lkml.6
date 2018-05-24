Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965448AbeEXIoG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:44:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44483 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965007AbeEXIoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:44:03 -0400
Date: Thu, 24 May 2018 10:43:51 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc: wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 05/15] drm/sun4i: Add TCON TOP driver
Message-ID: <20180524084351.x4ugbbsz3mqv6fh7@flea>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
 <20180519183127.2718-6-jernej.skrabec@siol.net>
 <20180521080517.3qmlfajqpn4uw7jv@flea>
 <5965231.6ucpJrPIQ5@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kvr5sekewcbcwxr4"
Content-Disposition: inline
In-Reply-To: <5965231.6ucpJrPIQ5@jernej-laptop>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kvr5sekewcbcwxr4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 21, 2018 at 05:15:15PM +0200, Jernej =C5=A0krabec wrote:
> > > +	/*
> > > +	 * Default register values might have some reserved bits set, which
> > > +	 * prevents TCON TOP from working properly. Set them to 0 here.
> > > +	 */
> > > +	writel(0, tcon_top->regs + TCON_TOP_PORT_SEL_REG);
> > > +	writel(0, tcon_top->regs + TCON_TOP_GATE_SRC_REG);
> > > +
> > > +	for (i =3D 0; i < CLK_NUM; i++) {
> > > +		const char *parent_name =3D "bus-tcon-top";
> >=20
> > I guess retrieving the parent's clock name at runtime would be more
> > flexible.
>=20
> It is, but will it ever be anything else?

Probably not, but when the complexity is exactly the same (using
__clk_get_name), we'd better use the more appropriate solution. If we
ever need to change that clock name, or to use the driver with an SoC
that wouldn't have the same clock name for whatever reason, it will
just work.

> > > +		struct clk_init_data init;
> > > +		struct clk_gate *gate;
> > > +
> > > +		gate =3D devm_kzalloc(dev, sizeof(*gate), GFP_KERNEL);
> > > +		if (!gate) {
> > > +			ret =3D -ENOMEM;
> > > +			goto err_disable_clock;
> > > +		}
> > > +
> > > +		init.name =3D gates[i].name;
> > > +		init.ops =3D &clk_gate_ops;
> > > +		init.flags =3D CLK_IS_BASIC;
> > > +		init.parent_names =3D &parent_name;
> > > +		init.num_parents =3D 1;
> > > +
> > > +		gate->reg =3D tcon_top->regs + TCON_TOP_GATE_SRC_REG;
> > > +		gate->bit_idx =3D gates[i].bit;
> > > +		gate->lock =3D &tcon_top->reg_lock;
> > > +		gate->hw.init =3D &init;
> > > +
> > > +		ret =3D devm_clk_hw_register(dev, &gate->hw);
> > > +		if (ret)
> > > +			goto err_disable_clock;
> >=20
> > Isn't it what clk_hw_register_gate is doing?
>=20
> Almost, but not exactly. My goal was to use devm_* functions, so there is=
 no=20
> need to do any special cleanup.

Is it the only difference? If so, you can just create a
devm_clk_hw_register gate.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--kvr5sekewcbcwxr4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsGe0YACgkQ0rTAlCFN
r3SvMRAAintWbKcM2W88tuLS7//ZtN3s+bLHkyZKOlgtObyic0uHw767yRdiY6Ye
Z2hiqBp6oLDCjVmsHbF1OrhLnsvpPngyjf4WUWhvXb0zfipjYJOCuFnX0p21C0/A
kfcryXXpsoALkLeKWpY1fJx86wUYhNGvnIwJDe8YSRPtyLNRkEHVT9YXixw4EN5L
uyyE2fh9uhGW89sFrBX43ZtB84SNxTspDr1wdRc8mYBwmtgWrJo5U7dR9/pTTAk8
zleDd63x0vETbqwcCfWQIUGTfsjhhfKpcIqAbctrmtGjeBm9tyOtDLNj3D2WBbQU
AhQrRZd6m+fL02N5lAFQDtd+9Nlz3j51UxJGw4Ii65BiQJpxsNEdLXdcbBGbJdr8
lsiENAbm8Qs8atFSkLJ7kiP6qUnZ+DQL+LqIn5aNM2HvGy6pqMEqAlqzq14aVlq9
T9PbqhFnKEEFuK1W5IzNS4q3mN9Iri0lvk2MlCceAoO/whYVQ5B+gXT8gQd3q/UL
c0oprMYZFUgkLYw8bPdhFdSfeqeeM00aIaLwNuWInlUxHVWQ/poASf5CGmOAVtQe
+3hZ29jSVmWEPSVA6LbLknVaTzw4++bJoDqbXilelPD4zz6fBIqnwqLqRot6hwqs
FxwtTql2d4M8Sdeto79m44fhXnU8NVQWRwGmvtGHwziF/nCXR/M=
=Z5mI
-----END PGP SIGNATURE-----

--kvr5sekewcbcwxr4--
