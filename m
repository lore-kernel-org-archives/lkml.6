Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeBBPxL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:53:11 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46663 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbeBBPxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:53:04 -0500
Date: Fri, 2 Feb 2018 16:52:52 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: ccu-sun4i-a10: Fix mali changing dclk
 frequency
Message-ID: <20180202155252.vhlih33ju6zh26oh@flea.lan>
References: <1517354639-92978-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180131084349.du2ijvhh5rxa5vvt@flea.lan>
 <7be1e297-4fac-a7a2-a8cc-54061d4e2fde@micronovasrl.com>
 <20180201124551.kfyz6frx4lcx4wbz@flea.lan>
 <8c2fef37-8eb6-38c6-de3d-547edafac8b7@micronovasrl.com>
 <20180202105304.gow2znzgxqmuxgol@flea.lan>
 <1b3d96ae-c6e6-4f58-b140-7b1738c12adc@micronovasrl.com>
 <20180202133516.uoy7ppuozd6cnldm@flea.lan>
 <aa43a02a-3ea9-2f61-eaf6-ddc7980f78a5@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2u7rx4ilwrnxrueh"
Content-Disposition: inline
In-Reply-To: <aa43a02a-3ea9-2f61-eaf6-ddc7980f78a5@micronovasrl.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2u7rx4ilwrnxrueh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2018 at 04:38:13PM +0100, Giulio Benetti wrote:
> Hi,
>=20
> Il 02/02/2018 14:35, Maxime Ripard ha scritto:
> > On Fri, Feb 02, 2018 at 11:57:20AM +0100, Giulio Benetti wrote:
> > > Il 02/02/2018 11:53, Maxime Ripard ha scritto:
> > > > Hi,
> > > >=20
> > > > On Thu, Feb 01, 2018 at 05:17:11PM +0100, Giulio Benetti wrote:
> > > > > > > > What kernel version did you use?
> > > > > > >=20
> > > > > > > Latest mainline.
> > > > > >=20
> > > > > > I guess this patch could fix it:
> > > > > > http://code.bulix.org/1kitrq-268936?raw
> > > > >=20
> > > > > This should prevent from modifying parent clock. But my problem w=
as
> > > > > different.
> > > > >=20
> > > > > On A20, gpu_clk can have different PLL, not I've found out the way
> > > > > to choose right one with assigned-parent-clocks.
> > > > >=20
> > > > > I have patchset ready for adding A20 mali node, but I need some m=
ore
> > > > > time to complete with OPP, then I will submit entire patchset.
> > > > >=20
> > > > > Now it works correctly, using right pll(dedicated PLL8), setting
> > > > > right frequency.
> > > >=20
> > > > The point is that we really don't care about which PLL is actually
> > > > being used, as long as the rate is correct and we don't break anyth=
ing
> > > > else. If the GPU rate is accessible through one of the other PLL, it
> > > > makes even more sense to not use the GPU PLL and keep it disabled,
> > > > since it will result in some power savings.
> > >=20
> > > Ah! I see the point now, very clever system for power saving.
> > > I'm going to check if it's resolutive,
> > > but it sounds good.
> > >=20
> > > >=20
> > > > > Btw, do I need to add a board using it, or can I add only Mali no=
de
> > > > > to sun7i-a20.dtsi(plus other little patches)?
> > > >=20
> > > > You can add it to the DTSI without a board using it (and actually,
> > > > nothing should be in the board DTS, everything in the DT for the Ma=
li
> > > > applies to all boards).
> > >=20
> > > Sure. So I would also add the patch you've addressed me:
> > > http://code.bulix.org/1kitrq-268936?raw
> > > as a commit. Can I submit it in patchset to complete the whole job?
> >=20
> > I already sent that patch quite some time ago, I'll just apply it. You
> > can send the DT patch :)
>=20
> Thanks. Sorry for my ignorance, but where are you applying patches?
> Because I've tried to check sunxi-next and a lot of other Repo but I can't
> find this and neither "Re: [PATCH] clk: sunxi-ng: ccu-sun4i-a10: Fix mali
> changing dclk frequency"

Usually, in the git tree listed in MAINTAINERS :)

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--2u7rx4ilwrnxrueh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlp0iVMACgkQ0rTAlCFN
r3SBOhAAhvKgr1w2vSuofD4w74vz1RYfXREsAdExevFdD+5oWx+raQDuk1mMS6Fv
ZNTdXPx1ytbtuBbNuRjumhUUJEyohM3wKuutRzkd/FXV4FNyKwZYfUUHXEekPTbt
VLPynr58dKroCXBmrgRl90kxO7uAwX42a/VnutSX+dRVY1b0ubEOg6qPtsnW10h1
Lg+3DYTNBXV/XCMagBAQHb0clzrPnqc3ZMTi1aJ2ZWZTqpQkj0doktYb+fbNmPmB
aP9ZBT/+L5yEdQFjL2hai/RDYkLHzdc0AE9SZfVQAC6QQ2IlEkhGiIHfn1OECszF
VioTZ/n+1YGqtiJwT9Rw10+gjOLak9HXqIuOgvcbFlAeK50potGjIoeZnnLPVn2Z
d2J1aqRFoD30iDpkSEmwH35f2Rua3CDssIA59b2a7bmyUBXGH7r/eqnx7L2Y/pnJ
OJf831MMIw9KwJeS2paRHGNuu6BgYuF6C0rz6LhZZofCWNROXjtMdE/YjlyOygfC
2xfdgzD97LJ8VUTv5cHSywXbylIZDzlTm9MunIO3KNkxX3NfIKzPmouLarf22bw0
WTS8loYeK7KlqHbe4jAmA1V0igIOeYG8JbR68fCDFNbqh/QVfzoeglgfx0F5EqGS
naHACBBrdk1neR6b31wYFqlUTh5vQUt8eo7k59P+7vSMJSzk3g4=
=fabT
-----END PGP SIGNATURE-----

--2u7rx4ilwrnxrueh--
