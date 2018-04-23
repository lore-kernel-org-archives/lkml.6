Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754536AbeDWJVY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:21:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58722 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754081AbeDWJVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:21:21 -0400
Date: Mon, 23 Apr 2018 11:21:19 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: megous@megous.com
Cc: dev@linux-sunxi.org, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10"
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support"
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "drm/sun4i: add lvds mode_valid function"
Message-ID: <20180423092119.5ssii67dtvsekwze@flea>
References: <20180421045155.15332-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dl5yxfdmovtv5y4l"
Content-Disposition: inline
In-Reply-To: <20180421045155.15332-1-megous@megous.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dl5yxfdmovtv5y4l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 21, 2018 at 06:51:55AM +0200, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
>=20
> The reverted commit broke LVDS output on TBS A711 Tablet. That tablet
> has simple-panel node that has fixed pixel clock-frequency that A83T
> SoC used in the tablet can't generate exactly.
>=20
> Requested rate is 52000000 and rounded_rate is calculated as 51857142.
> It's close enough for it to work in practice, but with strict check
> in the reverted commit, the mode is rejected needlessly in this case.
>=20
> DT allows to specify a range of values for simple-panel/clock-frequency,
> but driver doesn't respect that ATM. Given that TBS A711 is the single
> user of sun4i-lvds driver, let's revert that commit for now, until
> a better solution for the problem is found.
>=20
> Also see: https://patchwork.kernel.org/patch/9446385/ for relevant
> discussion (or search for "[RFC] drm/sun4i: rgb: Add 5% tolerance
> to dot clock frequency check").
>=20
> Fixes: e4e4b7ad50cf ("drm/sun4i: add lvds mode_valid function")
> Reported-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Applied, thanks!
Maxime
--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--dl5yxfdmovtv5y4l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrdpY8ACgkQ0rTAlCFN
r3TnLg/+OWgC4KrCivmuZL6C9enhXaL8KmdqPC30MoytlXgUpVr9G6FojhUgH+Lf
LnimBYttXmur5j1ejiPlI73taeD23NBDQMlXzSDaJ6f+feyxfz+i5NStmRJ7JnTO
3VhOEgGfAf6oNzYIYWWfSiCQS9+9pARFBMzvb46bOjn9JGOM3FwnPlZrxprORR8p
LjlD9R7o+y84LmAO3Y3LW13jE/3pjc/sbLX2u91Da2BDE8+d8wRwV3THNpzEbf0S
DEMLSNGWPSmj1pfO8tr8W8LVIPeUJm+Z4piaPDvIpQTutmoMifZL7mPcERaao6qx
aEzqWkVPS2Y8jwyJMIibi114Qv7NvtfAL8eMxNBRPQzMu8b5SRktQBA1oJ5rnL/O
2pTb2XNCByGdsDcaBj6Qrljt84ifMQVwLBohMhTar7rnxomj35sfQiutHECmn8EA
g6r57mqSOaKXeOk302vOKk0LmpQ50Zk6qKwFx21PvD6qpTTz5htG//mn5aen3Im6
1jcXfutlZZmSfpsLODLkQKbrCQKErYsm9C7eWdzs5yQbnWUy+ZpG/PIHAkhGoGy/
8kH5hlGd8hS6RjREZqAbv6LfVuNYDa9EPU9gMaDgg/SPEhbI1q9bc1hcQP2clZF2
u+zGmRkIm6IKCcnALEH/UmsD2PpD62BfUDT2EK0lTNx+3uCU53s=
=3gtl
-----END PGP SIGNATURE-----

--dl5yxfdmovtv5y4l--
