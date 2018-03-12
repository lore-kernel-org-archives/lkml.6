Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932480AbeCLJou (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:44:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47950 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752315AbeCLJoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:44:46 -0400
Date: Mon, 12 Mar 2018 10:44:34 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: megous@megous.com
Cc: dev@linux-sunxi.org, Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10"
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support"
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/sun4i: Fix exclusivity of the TCON clocks
Message-ID: <20180312094434.uucwvqy6pykxpbl7@flea>
References: <20180310110511.14697-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kxorl7wmyoc5euui"
Content-Disposition: inline
In-Reply-To: <20180310110511.14697-1-megous@megous.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kxorl7wmyoc5euui
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 10, 2018 at 12:05:11PM +0100, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
>=20
> Currently the exclusivity is enabled when the rate is set by
> the mode setting functions. These functions are called by
> mode_set_nofb callback of drm_crc_helper. Then exclusivity
> is disabled when tcon is disabled by atomic_disable
> callback.
>=20
> What happens is that mode_set_nofb can be called once when
> mode chnages, and afterwards the system can call atomic_enable
> and atomic_disable multiple times without further calls to
> mode_set_nofb.
>=20
> This happens:
>=20
> mode_set_nofb   - clk exclusivity is enabled
> atomic_enable
> atomic_disable  - clk exclusivity is disabled
> atomic_enable
> atomic_disable  - clk exclusivity is already disabled, leading to WARN
>                   in clk_rate_exclusive_put
>=20
> Solution is to enable exclusivity in sun4i_tcon_channel_set_status.
>=20
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Cc: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--kxorl7wmyoc5euui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqmTAEACgkQ0rTAlCFN
r3TPwg//b7vKYKfMhDWGAMmVXElwe+zPE9T44HYyPmAog0/IQ21ozLhDHamXuwLI
uKsnX34srxGU1ap7qrUDuOlCVNJqB5HYS72KhS/h2E12JWtQe/qBy1whPyVU7on6
qlfVHRIuLr/m1rV9VJqmSqQvTtA6mBJ4J1+yRAUbhVR3ll7Wlq0Y5s9KzK4qsBn/
wxki064FqJaj00JpQNwiAsffmtsVnJs+XW+ibEBEFzkhBEGlnL7nyvIuu6Pa+4Ub
StwN8/FngArIB16USOgJZJsGu4WQpN8aICwbagpvaH6BvaHVLSNmkU0IqCcWQUqg
nLJXLYanA/033Of0AgWqmt4tmvc5bhdvPv1Jwe6QcY8ueVK5YFlRBLexWDVTXPDm
T2G3tB3Z4JxEEq+X/CLC4ERgkZMmXgGEtYmcgDuUapruGQ7cAHNPETY/OxfzKWX9
2MXuYd6gXNMrSqZTCCVm3EpeGquyW5QKXycsd8evfLybshXwbHoZrErkB6ApAR7f
CuJa6BN+1VRL6dlHX9vegAYbVKQbQQTu7ecZA4NBFRv+FrjNhP4NbntJnRIuaVAF
5YYiU3PGF+LQFma8Kd0RXEsodXK0elGCZZdDUHCxWhynlEJTMSYWDdg3VS5i4bwE
f7OYV3ikYgEQEXP1f5frZqEbaFdgoldS049G2uTRzdWsJDzIUtE=
=eBVF
-----END PGP SIGNATURE-----

--kxorl7wmyoc5euui--
