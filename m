Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A09ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A862075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A862075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbeGRNWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:22:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51814 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbeGRNWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:22:46 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4DFC7207E8; Wed, 18 Jul 2018 14:44:58 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1B41F206FF;
        Wed, 18 Jul 2018 14:44:48 +0200 (CEST)
Date:   Wed, 18 Jul 2018 14:44:48 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 00/18] arm64: allwinner: Add A64 DE2 HDMI support
Message-ID: <20180718124448.2s2b3jxbsqt46cgu@flea>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cuxlnvygzpxlrpwv"
Content-Disposition: inline
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cuxlnvygzpxlrpwv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 18, 2018 at 04:24:40PM +0530, Jagan Teki wrote:
> Allwinner A64 has display engine pipeline like other Allwinner SOC's A83T=
/H3/H5.
>=20
> A64 behaviour similar to Allwinner A83T where
> Mixer0 =3D> TCON0 =3D> LVDS/RGB/MIPI-DSI
> Mixer1 =3D> TCON1 =3D> HDMI
> as per Display System Block Diagram from Allwinner_A64_User_Manual_V1.1.p=
df
>=20
> This is third patch-set followed with previous RFC[1], first and second
> series[2][3] and merely concentrated on HDMI pipeline through TCON1 and
> rest will add eventually.
>=20
> This series fixed previous version comments
> - Rebasing on linux-next
> - sqash all pipeline components in one patch
> - Enable all pipeline components in board dts
> - about documenting fallback compatibles
> - adding new compatible for mixer1

You still haven't figured out the SRAM parts. We asked you to fix this
in the v1 and the v2 already, and we're not going to merge this
without those bits figured out properly.

> Log:
> [    1.450984] Jagan: sun8i_mixer_probe
> [    1.464981] sun4i-drm display-engine: bound 1200000.mixer (ops sun8i_m=
ixer_ops)
> [    1.472572] sun4i-drm display-engine: bound 1c0d000.lcd-controller (op=
s sun4i_tcon_ops)
> [    1.480676] sun8i-dw-hdmi 1ee0000.hdmi: Linked as a consumer to regula=
tor.10
> [    1.488738] sun8i-dw-hdmi 1ee0000.hdmi: Detected HDMI TX controller v1=
=2E32a with HDCP (sun8i_dw_hdmi_phy)
> [    1.498879] sun8i-dw-hdmi 1ee0000.hdmi: registered DesignWare HDMI I2C=
 bus driver
> [    1.507372] sun4i-drm display-engine: bound 1ee0000.hdmi (ops sun8i_dw=
_hdmi_ops)
> [    1.514778] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [    1.521398] [drm] No driver support for vblank timestamp query.
> [    1.684611] random: fast init done
> [    2.011575] Console: switching to colour frame buffer device 180x56
> [    2.049858] sun4i-drm display-engine: fb0: DRM emulated frame buffer d=
evice
> [    2.057268] [drm] Initialized sun4i-drm 1.0.0 20150629 for display-eng=
ine on minor 0
>=20
> Note:
> Pine64 boards are unable to get edid by default like other A64 boards,
> but forcing 'video=3DHDMI-A-1:1920x1080@60D' kernel command line can
> create edid with display on penel

Then that needs to be figured out before it's enabled, instead of
having a hack that barely works.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--cuxlnvygzpxlrpwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltPNj8ACgkQ0rTAlCFN
r3RKag/9GRWd8FN+lvkjnLkv2Rs9BFsF0lp3dP5nR6BOCePpl4MZ5XsvhQ1HOqMz
wr5kfno4sy6gPNEyTcNvEk1Qf5sIav7y69D2Z912TghkLhz0gH4ODeMOy6RGBN7w
W/dyOMx0X1kCzchBkohMyQzfiawgU6/xhgQwdkvEeshJGG7u51+Uf2tdKeD3f8sf
gxqXDMxZn/b6h330tB9fbiGlxkpmuy6yCwjiaJcjCeXj44ZFCasOY7givMotxiSO
YgS+Q0GfDaLgA2Pc1A3xnukQrK8xuoIfNPA2g2K50prAtk8A4sI8UCUzMS+QVtVM
ESy6TQ54LcYWvC/40eMINv1VDXgERot9MmhJLfgXIDGP5NHlYUHQaej3MpdyhJQ/
Em/ywvjeSKrOyBHvB+3Jd/ddDLRTnr9/Uar808ASstHEUzg3IAsR3hHnXzzXE6n/
xVB+O+ozw17eSiVU4setiszpzvdJaJiQZARWFsKgcTzZwU2GA+xDqf0BPZyL87qp
+Pe1z+QacfukDHJyqS86ICQ6LGGHcGdcpB2zjJE9sIfkQkuElzcODXyCj5lwqtYa
BTaJhCcfqm2OsA2ilNjuVouFUd54Miat3ELd52KfUgZalI3Sn4afs0GpXPU2QD5v
4HUylHYA6GyttYED9SSBlDfj6F5gtMNG6FIhcTnHQoV8ri2xhtY=
=1N4F
-----END PGP SIGNATURE-----

--cuxlnvygzpxlrpwv--
