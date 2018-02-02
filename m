Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeBBNff (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:35:35 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:42686 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeBBNf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:35:28 -0500
Date: Fri, 2 Feb 2018 14:35:16 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: ccu-sun4i-a10: Fix mali changing dclk
 frequency
Message-ID: <20180202133516.uoy7ppuozd6cnldm@flea.lan>
References: <1517354639-92978-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180131084349.du2ijvhh5rxa5vvt@flea.lan>
 <7be1e297-4fac-a7a2-a8cc-54061d4e2fde@micronovasrl.com>
 <20180201124551.kfyz6frx4lcx4wbz@flea.lan>
 <8c2fef37-8eb6-38c6-de3d-547edafac8b7@micronovasrl.com>
 <20180202105304.gow2znzgxqmuxgol@flea.lan>
 <1b3d96ae-c6e6-4f58-b140-7b1738c12adc@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l4rzk2xpisn644pn"
Content-Disposition: inline
In-Reply-To: <1b3d96ae-c6e6-4f58-b140-7b1738c12adc@micronovasrl.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l4rzk2xpisn644pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2018 at 11:57:20AM +0100, Giulio Benetti wrote:
> Il 02/02/2018 11:53, Maxime Ripard ha scritto:
> > Hi,
> >=20
> > On Thu, Feb 01, 2018 at 05:17:11PM +0100, Giulio Benetti wrote:
> > > > > > What kernel version did you use?
> > > > >=20
> > > > > Latest mainline.
> > > >=20
> > > > I guess this patch could fix it:
> > > > http://code.bulix.org/1kitrq-268936?raw
> > >=20
> > > This should prevent from modifying parent clock. But my problem was
> > > different.
> > >=20
> > > On A20, gpu_clk can have different PLL, not I've found out the way
> > > to choose right one with assigned-parent-clocks.
> > >=20
> > > I have patchset ready for adding A20 mali node, but I need some more
> > > time to complete with OPP, then I will submit entire patchset.
> > >=20
> > > Now it works correctly, using right pll(dedicated PLL8), setting
> > > right frequency.
> >=20
> > The point is that we really don't care about which PLL is actually
> > being used, as long as the rate is correct and we don't break anything
> > else. If the GPU rate is accessible through one of the other PLL, it
> > makes even more sense to not use the GPU PLL and keep it disabled,
> > since it will result in some power savings.
>=20
> Ah! I see the point now, very clever system for power saving.
> I'm going to check if it's resolutive,
> but it sounds good.
>=20
> >=20
> > > Btw, do I need to add a board using it, or can I add only Mali node
> > > to sun7i-a20.dtsi(plus other little patches)?
> >=20
> > You can add it to the DTSI without a board using it (and actually,
> > nothing should be in the board DTS, everything in the DT for the Mali
> > applies to all boards).
>=20
> Sure. So I would also add the patch you've addressed me:
> http://code.bulix.org/1kitrq-268936?raw
> as a commit. Can I submit it in patchset to complete the whole job?

I already sent that patch quite some time ago, I'll just apply it. You
can send the DT patch :)

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--l4rzk2xpisn644pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlp0aRMACgkQ0rTAlCFN
r3SAcBAAhhPt0DtFatN1dtDWCDvuHw3pA63c7pDGWLGG6gHckzoxZvGiVEjyXaJ7
mZgqeR70ZATpgHPWBP2apnnFOTfq2MQp/TksO6dePlt9BFJpwKPy2rMjfnJFK5qE
a03oItlMFem1deR8/MxotfcdUE3GyMBQTpo2NqEv/9EoxRi7t3SnDvUaLTdLnSom
cFHFGECOHqC4wBSD/B7EMqysgNQ68AHslIgy7qJ9dprFrIqvlnK+/KsxywTrTpdz
H+I2KdGKLmdVTBjsA3Gme3DPyuDwrIspPAbH8oddmVarih9C3pFfck+TQJbjb8Bh
25HABSyRJVQFbOwNvhaPp8AEw1WGwM5hxGbC8XzQqpKgLf+4vtxNsV9CuK2cY7ZE
LHzkb424tRB2PUnH0paigx+gCH97seZezYPQR9zIc1EovwTOwIdjqWsn5RNNM5Fa
T6iKJYj/TxD6+mj0lSkerG+9/GwJsJO8g6/8Bm5irSdGDua1p5gK7uGRl++BYYaL
pnSHG/I4jRH8Ocq1KpiWKJOQYA77rVONiLV5ob6t/Fm7yL7pp3k5Cp5s9VN4kXRN
Yny8ycM0spWws35avmFqKCbT+lO42B1oxfG5xi6BmA74epewoWz749Iaq2lUFmyv
0nsExkCTXXN6xk6JpetYo+j+X/q8YLesaaLW5JFgCiaWKm39m7g=
=X7sj
-----END PGP SIGNATURE-----

--l4rzk2xpisn644pn--
