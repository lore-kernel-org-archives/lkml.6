Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933360AbeDXOIz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:08:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51791 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758221AbeDXOIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:08:52 -0400
Date: Tue, 24 Apr 2018 16:08:50 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [RFC 00/13] arm64: allwinner: Add A64 DE2 pipeline support
Message-ID: <20180424140850.ptxpmtusour7u6nb@flea>
References: <20180424133425.24291-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pqvbqcet3rmln5gs"
Content-Disposition: inline
In-Reply-To: <20180424133425.24291-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pqvbqcet3rmln5gs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 07:04:12PM +0530, Jagan Teki wrote:
> Allwinner A64 has display engine pipeline like other Allwinner SOC's A83T=
/H3/H5.
>=20
> A64 DE2 behaviour similar to Allwinner A83T where mixer0, connected to tc=
on0 with
> RGB, LVDS MIPI-DSI and mixer1, connected to tcon1 with HDMI.
> This series merely concentrated on HDMI pipeline and rest will add eventu=
ally.
>=20
> patch 1: dt-bindings for a64 DE2 CCU
>=20
> patch 2: a64 DE2 CCU node addition
>=20
> patch 3: dt-bindings for a64 DE2 pipeline
>=20
> patch 4 - 5: dt-bindings for a64 mixer0 and tcon-lcd
>=20
> patch 6: a64 DE2 pipeline node addition
>=20
> patch 7 - 8: dt-bindings for a64 HDMI and HDMI PHY
>=20
> patch 9: a64 HDMI nodes addition
>=20
> patch 10 - 11: dt-bindings for a64 mixer1 and tcon-tv
>=20
> patch 12: a64 HDMI pipeline
>=20
> patch 13: enable HDMI out on bananpi-m64
>=20
> Tested HDMI on bananapi-m64 (along with DE2 SRAM C changes from [1]
> thread), able to detect the HDMI but, no penguins on screen.
>=20
> Request for any suggestions.
>=20
> Test log on Bananpi-m64:
> [    0.247631] sun4i-drm display-engine: bound 1100000.mixer (ops sun8i_m=
ixer_ops)
> [    0.256717] sun4i-drm display-engine: bound 1200000.mixer (ops sun8i_m=
ixer_ops)
> [    0.256783] sun4i-tcon 1c0c000.lcd-controller: Missing LVDS properties=
, Please upgrade your DT
> [    0.256792] sun4i-tcon 1c0c000.lcd-controller: LVDS output disabled

That doesn't seem to work so well for LVDS.

> [    0.257081] sun4i-drm display-engine: No panel or bridge found... RGB =
output disabled
> [    0.257099] sun4i-drm display-engine: bound 1c0c000.lcd-controller (op=
s sun4i_tcon_ops)
> [    0.257273] sun4i-drm display-engine: No panel or bridge found... RGB =
output disabled
> [    0.257288] sun4i-drm display-engine: bound 1c0d000.lcd-controller (op=
s sun4i_tcon_ops)
> [    0.258176] sun8i-dw-hdmi 1ee0000.hdmi: Detected HDMI TX controller v1=
=2E32a with HDCP (sun8i_dw_hdmi_p)
> [    0.258596] sun8i-dw-hdmi 1ee0000.hdmi: registered DesignWare HDMI I2C=
 bus driver
> [    0.259188] sun4i-drm display-engine: bound 1ee0000.hdmi (ops sun8i_dw=
_hdmi_ops)
> [    0.259199] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [    0.259205] [drm] No driver support for vblank timestamp query.
> [    0.259308] [drm] Cannot find any crtc or sizes

A good guess would be that you can't get the EDIDs for some
reason. Have you tried forcing a mode to see if the display part
already works?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--pqvbqcet3rmln5gs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrfOnEACgkQ0rTAlCFN
r3Qvlg/+MjOva/LMdrvxZ4DeYIpYzXEKG9plq6mlcc2jGvVFtBBBUew3QunX9b2G
bnPOYwqywqAbXeASbcU+7A+Srf11gDfCs8T3Zd7SX8aqCEGIsWeCv5HDoJM9yVA6
tB7g/hROvXPomkGrqH6HrRzYyqVue0gCYbUWQICg2Lm++Jg/zxuv/kOkpUX50hvC
1ScNaFaLE2yfYF3ZajXHBUotvFA+0fmj8/UEZxuSMc0STFegvYnPLIKb7FXWfO3Q
WS/QSqZ2N30xi5FbdyLBB3mkDFosOR1Bn+Ws0npuFxhCc6JiZyvopmQ8bNL7uJfi
arfVgDUgfsYeFSAO1fPwimQkIUouh+TMNJcRvpogf7dqIh5gsMLw20g5o+O3H4MV
3E+468Pi6cV9mbWDbgEZks/FGjmfI3tFzH8sUDBgOR75+8bsnck+O6a0B49Cp/DX
cJ/8bgbRsiW0VmQ/oXc5XKe1FYOm0lLkjnBb5NNkAlvZWRo/w9iQcBujVZndtNDM
LXenocnL8hVjTIfVf2XxhSX026eRFV0OeOSd7Mmvrbx3IjMuSOPhp+WcBnorvkGX
XvMLUfKT3iEcG1PyoGOgTR+1+3LjhbWqycGtkV2OanF+FHx4Ne7KXZbXiu4eNe16
YeCmHfhoQdOp2y65XpY+PnByS8iz+OF0wuRjT8ugDzEpDNc6FOM=
=gYwQ
-----END PGP SIGNATURE-----

--pqvbqcet3rmln5gs--
