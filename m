Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeBZK0C (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:26:02 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44941 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752336AbeBZK0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 05:26:00 -0500
Date: Mon, 26 Feb 2018 11:25:57 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH 01/15] clk: sunxi-ng: Add check for minimal rate to NM
 PLLs
Message-ID: <20180226102557.7bgjs3txp7cbridn@flea.lan>
References: <20180224214545.3740-1-jernej.skrabec@siol.net>
 <20180224214545.3740-2-jernej.skrabec@siol.net>
 <20180226093800.uwbo54wrdcwmsyzh@flea.lan>
 <CAGb2v64fxs5Ne5=orQxNcg70Z_N0NJyyC7MPuNH6pxcqrsUq4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dxrtdxft72nv6clt"
Content-Disposition: inline
In-Reply-To: <CAGb2v64fxs5Ne5=orQxNcg70Z_N0NJyyC7MPuNH6pxcqrsUq4g@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dxrtdxft72nv6clt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 05:43:01PM +0800, Chen-Yu Tsai wrote:
> On Mon, Feb 26, 2018 at 5:38 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > Hi,
> >
> > On Sat, Feb 24, 2018 at 10:45:31PM +0100, Jernej Skrabec wrote:
> >> Some NM PLLs doesn't work well when their output clock rate is set bel=
ow
> >> certain rate.
> >>
> >> Add support for that constrain.
> >
> > In such a case, you should round the rate to the minimum the clock can
> > operate at, and not return an error.
>=20
> That's true for round_rate. But what's the expected behavior of set_rate?
> AFAIK we presume all users call round_rate before set_rate, but that does=
n't
> seem to be true all the time.

One of the first things that happens during a set_rate is a round_rate:
https://elixir.bootlin.com/linux/v4.16-rc3/source/drivers/clk/clk.c#L1873

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--dxrtdxft72nv6clt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqT4LQACgkQ0rTAlCFN
r3T82Q//XfVSf/LYhtSjfNluMQUsBGgfDZcrFQEQfFSe5p1v72zjU292NQonhjQa
EPas8HKpm1lpKz8b1cEzT8VSdi4/JgkES4FXDfdGfzkZFKgU/EQUljAgMyrVmgpJ
2kKgKtOVg3PO0VlzFXcTBcqPn/5TVDnPNG7w6BjmLMhpkhSKiZ9XqxGdZNMBEfcW
ck+Nhg6wd/vTbBxRyWmuZIh+Dp2Wk2upzejNG/vm7OS7z0AMW85FoA6LrtbEnkD9
v9lcEdJhDmAEy9lhl8vZ2qdjNbbqtIN4UXd4p3nUVyyOiEULFdN7OBRNSZYnOFrI
9Ac1X8LSfK1/1N6kHdoinIgEv/ZMT7vHXk6WG8x80YS8mAv/nh4HRfTdTNnWP9mg
JeUYl9KNQ0cUJsTxPGTOfyduv6mAgQRgwYrHJgVF5WI7ovrU+MX7hJAKp/YlXbhn
mHugHcCTJh4OO/sLhq/f8zH+ZX+HxuEOreReRl0scWbnFLV1Okck7DU1aNT77LK1
B5Qj0mnerD1bqBZtxxAuj+v/wA1CE+W+iMwi7O+YBawuyDu4naO9WTlpZsfkNS9H
8ZAFzYZbcebdO3JO6+To9tq2KdGYijYz5OpCnhMJsvZb/z9AgeBaOHNuJnWgIkBt
r9m734o5BlBk172h2J44SxN6HoZ3Q540EuS2T6xJJV2Hr9cyySE=
=7CGv
-----END PGP SIGNATURE-----

--dxrtdxft72nv6clt--
