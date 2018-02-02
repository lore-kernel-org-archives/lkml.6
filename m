Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbeBBKxP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 05:53:15 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:39280 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbeBBKxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 05:53:06 -0500
Date: Fri, 2 Feb 2018 11:53:04 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: ccu-sun4i-a10: Fix mali changing dclk
 frequency
Message-ID: <20180202105304.gow2znzgxqmuxgol@flea.lan>
References: <1517354639-92978-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180131084349.du2ijvhh5rxa5vvt@flea.lan>
 <7be1e297-4fac-a7a2-a8cc-54061d4e2fde@micronovasrl.com>
 <20180201124551.kfyz6frx4lcx4wbz@flea.lan>
 <8c2fef37-8eb6-38c6-de3d-547edafac8b7@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sfqjnlte6ae4g5v4"
Content-Disposition: inline
In-Reply-To: <8c2fef37-8eb6-38c6-de3d-547edafac8b7@micronovasrl.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sfqjnlte6ae4g5v4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 01, 2018 at 05:17:11PM +0100, Giulio Benetti wrote:
> > > > What kernel version did you use?
> > >=20
> > > Latest mainline.
> >=20
> > I guess this patch could fix it:
> > http://code.bulix.org/1kitrq-268936?raw
>=20
> This should prevent from modifying parent clock. But my problem was
> different.
>
> On A20, gpu_clk can have different PLL, not I've found out the way
> to choose right one with assigned-parent-clocks.
>=20
> I have patchset ready for adding A20 mali node, but I need some more
> time to complete with OPP, then I will submit entire patchset.
>
> Now it works correctly, using right pll(dedicated PLL8), setting
> right frequency.

The point is that we really don't care about which PLL is actually
being used, as long as the rate is correct and we don't break anything
else. If the GPU rate is accessible through one of the other PLL, it
makes even more sense to not use the GPU PLL and keep it disabled,
since it will result in some power savings.

> Btw, do I need to add a board using it, or can I add only Mali node
> to sun7i-a20.dtsi(plus other little patches)?

You can add it to the DTSI without a board using it (and actually,
nothing should be in the board DTS, everything in the DT for the Mali
applies to all boards).

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--sfqjnlte6ae4g5v4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlp0Qw8ACgkQ0rTAlCFN
r3R60w/+OryJIZIypTsduJLs4gmV6yQnKOshv/+GTHtldVdAaqcKfqvhEgnahNS8
ykMmMh0mD7nrI/pclNa9Eg4AEi3PBc/BuI1vlAFnSpwKey6+yO2b8SpHmsC2fYNs
5kALXb+sWF9T983dXhF0IfWgjulUefJq87B7+u67zlUmBTpq2ukaeI5ZaS3fW/Zv
9TA/2l2qYa3NFPkJv7IGIfvyRMbzDBHNJpBWuAFPU3PsayI5Ik+4157djnfcrYX0
k8ei0wfrgq8G6tB9cVadTmi3q2jbFz6waQOAUejJJKnmtJb69xUJoYEk7aR76Hxa
gjv6oCvibhHhRFsIbMRJicf1G3veaYCzqeybpakuXIbWaOxe1Gq25fkOt+GQFp78
PlIUUR5msaYq0rGwSgHUkjcEFb3bBxh7MR73NxIv6WXaNePRETxHVnE3btMWdzds
dHNpa+EDpJ51x0VNBosqKkbMrrQtKbGgCTYGjDb/nZVqlcKUkeZPOIbaJufBq/DI
ruqBuFqBZ9E2OVss1T9ZZ3yszmkMrt6SfOfzJim+Y1v3r71S6+l6ZccOm1MJ6nvG
et7s1RLS/fNpjP19od8pY6CFMXO+rKN3LOoqMcl4fh2tEAE5ZlG5YgwgHd9hHU/h
FNatNSiPpDUwtNsJHZKICbAG2d619tveupbNF66T5Fqv4lGLhjM=
=9Kj3
-----END PGP SIGNATURE-----

--sfqjnlte6ae4g5v4--
