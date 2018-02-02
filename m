Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbeBBWAV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 17:00:21 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:52839 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbeBBWAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 17:00:12 -0500
Date: Fri, 2 Feb 2018 22:59:52 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: ccu-sun4i-a10: Fix mali changing dclk
 frequency
Message-ID: <20180202215952.fockc3b3vvs7nu4o@flea.lan>
References: <20180131084349.du2ijvhh5rxa5vvt@flea.lan>
 <7be1e297-4fac-a7a2-a8cc-54061d4e2fde@micronovasrl.com>
 <20180201124551.kfyz6frx4lcx4wbz@flea.lan>
 <8c2fef37-8eb6-38c6-de3d-547edafac8b7@micronovasrl.com>
 <20180202105304.gow2znzgxqmuxgol@flea.lan>
 <1b3d96ae-c6e6-4f58-b140-7b1738c12adc@micronovasrl.com>
 <20180202133516.uoy7ppuozd6cnldm@flea.lan>
 <aa43a02a-3ea9-2f61-eaf6-ddc7980f78a5@micronovasrl.com>
 <20180202155252.vhlih33ju6zh26oh@flea.lan>
 <ee1f5d36-5b85-f770-1670-527632367f01@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ffxrrig6ypogcr5p"
Content-Disposition: inline
In-Reply-To: <ee1f5d36-5b85-f770-1670-527632367f01@micronovasrl.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ffxrrig6ypogcr5p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2018 at 06:21:18PM +0100, Giulio Benetti wrote:
> Hi,
>=20
> Il 02/02/2018 16:52, Maxime Ripard ha scritto:
> > On Fri, Feb 02, 2018 at 04:38:13PM +0100, Giulio Benetti wrote:
> > > Hi,
> > >=20
> > > Il 02/02/2018 14:35, Maxime Ripard ha scritto:
> > > > On Fri, Feb 02, 2018 at 11:57:20AM +0100, Giulio Benetti wrote:
> > > > > Il 02/02/2018 11:53, Maxime Ripard ha scritto:
> > > > > > Hi,
> > > > > >=20
> > > > > > On Thu, Feb 01, 2018 at 05:17:11PM +0100, Giulio Benetti wrote:
> > > > > > > > > > What kernel version did you use?
> > > > > > > > >=20
> > > > > > > > > Latest mainline.
> > > > > > > >=20
> > > > > > > > I guess this patch could fix it:
> > > > > > > > http://code.bulix.org/1kitrq-268936?raw
> > > > > > >=20
> > > > > > > This should prevent from modifying parent clock. But my probl=
em was
> > > > > > > different.
> > > > > > >=20
> > > > > > > On A20, gpu_clk can have different PLL, not I've found out th=
e way
> > > > > > > to choose right one with assigned-parent-clocks.
> > > > > > >=20
> > > > > > > I have patchset ready for adding A20 mali node, but I need so=
me more
> > > > > > > time to complete with OPP, then I will submit entire patchset.
> > > > > > >=20
> > > > > > > Now it works correctly, using right pll(dedicated PLL8), sett=
ing
> > > > > > > right frequency.
> > > > > >=20
> > > > > > The point is that we really don't care about which PLL is actua=
lly
> > > > > > being used, as long as the rate is correct and we don't break a=
nything
> > > > > > else. If the GPU rate is accessible through one of the other PL=
L, it
> > > > > > makes even more sense to not use the GPU PLL and keep it disabl=
ed,
> > > > > > since it will result in some power savings.
> > > > >=20
> > > > > Ah! I see the point now, very clever system for power saving.
> > > > > I'm going to check if it's resolutive,
> > > > > but it sounds good.
> > > > >=20
> > > > > >=20
> > > > > > > Btw, do I need to add a board using it, or can I add only Mal=
i node
> > > > > > > to sun7i-a20.dtsi(plus other little patches)?
> > > > > >=20
> > > > > > You can add it to the DTSI without a board using it (and actual=
ly,
> > > > > > nothing should be in the board DTS, everything in the DT for th=
e Mali
> > > > > > applies to all boards).
> > > > >=20
> > > > > Sure. So I would also add the patch you've addressed me:
> > > > > http://code.bulix.org/1kitrq-268936?raw
> > > > > as a commit. Can I submit it in patchset to complete the whole jo=
b?
> > > >=20
> > > > I already sent that patch quite some time ago, I'll just apply it. =
You
> > > > can send the DT patch :)
> > >=20
> > > Thanks. Sorry for my ignorance, but where are you applying patches?
> > > Because I've tried to check sunxi-next and a lot of other Repo but I =
can't
> > > find this and neither "Re: [PATCH] clk: sunxi-ng: ccu-sun4i-a10: Fix =
mali
> > > changing dclk frequency"
> >=20
> > Usually, in the git tree listed in MAINTAINERS :)
>=20
> Please don't laugh at me! :)
>=20
> I've tried to check for your patch(drivers/gpu/drm/sun4i/sun4i_tcon.c) on:
> https://cgit.freedesktop.org/drm/drm-misc/
> according to MAINTAINERS file and nothing found.

I haven't applied that one yet, so it's not suprising :)

> For the other one(arch/arm/boot/dts/sun7i-a20.dtsi), I've checked
> on:
> https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.gi=
t/
> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-reb=
asing.git/
>=20
> Nothing neither here!
>=20
> In MAINTANERS file there's no arch/arm/boot/dts/sun* association.

I forgot to push that one:
https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/log/?h=3Dsu=
nxi/dt-for-4.17

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--ffxrrig6ypogcr5p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlp031cACgkQ0rTAlCFN
r3TSJw//XFYQqMqFrYyx6bBFnHQoSzmxH4bh7a357Sckj4N2LWTrW0UsnzEF4wWL
iK8LcwLMCgsMyB2CiwhYeVZDJXgr8G7HQwWk7Kk9KoVom4Zah5RqZ7EhvzaIQRXm
5iZjcQvWzIQdwpUizSABSa1kjZF9Cw4Y7I0jhbwRbuuUNbl+x+kdk81f79ZkEjox
DpDQs8Majg4Rh5ZOiCjKctoaw8F2J1QPfjrGgRjSjD/sls5KJfZ4cPtl0k8uuwTN
vco5Gm4A495pkYIXAnHNvw2KztfmBcQxGg4rc9pdrWDxkJzSVR1w2mwNXtMTHObz
q4pbflk1L4QSSGniyPjPNVoY2I80h91O+bDMBAm5+aLOrD5148s5McXcOYhQ4QgC
7kvf9uHRikXOTbaIaQS0saudtyjv/VCoYK9u2Wbfdj76FRw8/pOZFgx8+kvA0lAM
/y7pC5qtOriAL3ES3y8abFHqrPzRp33R0Q15QaKgpkqcBSvEhgLIuk0a2RCE3z32
IgtpLEjQm/mAPYOkYv0v4GbAuUkveNM/yVnUyUp7WWu8mymRWsLT3czbDO95XVrr
CE0NCliYlxJaKC0ZdCVf9dE7Eywk5yw3H9D9sJA+/htTDBrHqiYnpsP8HLHrmoei
XJ2Te1vxMKlQIIFvHguoilvNNVgZPv7ctnaRpIT1L6o1/EV9MT0=
=/Tmg
-----END PGP SIGNATURE-----

--ffxrrig6ypogcr5p--
