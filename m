Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCFEC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E066821550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E066821550
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390065AbeIUUHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:07:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41135 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727392AbeIUUHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:07:23 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2B96F20714; Fri, 21 Sep 2018 16:18:15 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id E952B203DA;
        Fri, 21 Sep 2018 16:18:04 +0200 (CEST)
Date:   Fri, 21 Sep 2018 16:18:05 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Witos <kwitos@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>
Subject: Re: [PATCH 02/10] phy: Add configuration interface
Message-ID: <20180921141805.s4u224xzmtii66dg@flea>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
 <a739a2d623c3e60373a73e1ec206c2aa35c4a742.1536138624.git-series.maxime.ripard@bootlin.com>
 <1ed01c1f-76d5-fa96-572b-9bfd269ad11b@ti.com>
 <20180906145622.kwxvkcuerbeqsj6b@flea>
 <1a169fad-72b7-fac0-1254-cac5d8304740@ti.com>
 <20180912084242.skxbwbgluakakyg6@flea>
 <e0d7db11-7ec1-cb98-4e62-12d78d1ba65b@ti.com>
 <20180919121436.ztjnxofe66quddeq@flea>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zldsfftxvy2fxfnd"
Content-Disposition: inline
In-Reply-To: <20180919121436.ztjnxofe66quddeq@flea>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zldsfftxvy2fxfnd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2018 at 02:14:36PM +0200, Maxime Ripard wrote:
> > I'm sorry but I'm not convinced a consumer driver should have all the d=
etails
> > that are added in phy_configure_opts_mipi_dphy.
>=20
> If it can convince you, here is the parameters that are needed by all
> the MIPI-DSI drivers currently in Linux to configure their PHY:
>=20
>   - cdns-dsi (drivers/gpu/drm/bridge/cdns-dsi.c)
>     - hs_clk_rate
>     - lanes
>     - videomode
>=20
>   - kirin (drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c)
>     - hs_exit
>     - hs_prepare
>     - hs_trail
>     - hs_zero
>     - lpx
>     - ta_get
>     - ta_go
>     - wakeup
>=20
>   - msm (drivers/gpu/drm/msm/dsi/*)
>     - clk_post
>     - clk_pre
>     - clk_prepare
>     - clk_trail
>     - clk_zero
>     - hs_clk_rate
>     - hs_exit
>     - hs_prepare
>     - hs_trail
>     - hs_zero
>     - lp_clk_rate
>     - ta_get
>     - ta_go
>     - ta_sure
>=20
>   - mtk (drivers/gpu/drm/mediatek/mtk_dsi.c)
>     - hs_clk_rate
>     - hs_exit
>     - hs_prepare
>     - hs_trail
>     - hs_zero
>     - lpx
>=20
>   - sun4i (drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c)
>     - clk_post
>     - clk_pre
>     - clk_prepare
>     - clk_zero
>     - hs_prepare
>     - hs_trail
>     - lanes
>     - lp_clk_rate
>=20
>   - tegra (drivers/gpu/drm/tegra/dsi.c)
>     - clk_post
>     - clk_pre
>     - clk_prepare
>     - clk_trail
>     - clk_zero
>     - hs_exit
>     - hs_prepare
>     - hs_trail
>     - hs_zero
>     - lpx
>     - ta_get
>     - ta_go
>     - ta_sure
>=20
>   - vc4 (drivers/gpu/drm/vc4/vc4_dsi.c)
>     - hs_clk_rate
>     - lanes
>=20
> Now, for MIPI-CSI receivers:
>=20
>   - marvell-ccic (drivers/media/platform/marvell-ccic/mcam-core.c)
>     - clk_term_en
>     - clk_settle
>     - d_term_en
>     - hs_settle
>     - lp_clk_rate
>=20
>   - omap4iss (drivers/staging/media/omap4iss/iss_csiphy.c)
>     - clk_miss
>     - clk_settle
>     - clk_term
>     - hs_settle
>     - hs_term
>     - lanes
>=20
>   - rcar-vin (drivers/media/platform/rcar-vin/rcar-csi2.c)
>     - hs_clk_rate
>     - lanes
>=20
>   - ti-vpe (drivers/media/platform/ti-vpe/cal.c)
>     - clk_term_en
>     - d_term_en
>     - hs_settle
>     - hs_term
>=20
> So the timings expressed in the structure are the set of all the ones
> currently used in the tree by DSI and CSI drivers. I would consider
> that a good proof that it would be useful.
>=20
> Note that at least cdns-dsi, exynos4-is
> (drivers/media/platform/exynos4-is/mipi-csis.c), kirin, sun4i, msm,
> mtk, omap4iss, plus the v4l2 drivers cdns-csi2tx and cdns-csi2rx I
> want to convert, have already either a driver for their DPHY using the
> phy framework plus a configuration function, or a design very similar
> that could be migrated to such an API.

There's also a patch set currently being submitted that uses a phy
driver + custom functions:
https://lore.kernel.org/patchwork/cover/988959/

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zldsfftxvy2fxfnd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluk/ZwACgkQ0rTAlCFN
r3QPsA//TW4vFjvM51035KuuVaJi4y5Tu7v4ock6POiSrP6k1buND4KfJXXU+iSj
Z+OWrLSK0iDFtFLeZ2oN6dFucpHZdaHvZH+KWrrXkKj0zZVPS8eBuKnmQZOqEn8J
DPvsEK2ckfcmtSYidr10APVWc2WbfUAgLBj0ZcGtGt/zELiQeW5cc9DRq5g5F12n
HuVLrIi1/1GvzZYCI+oqQLga7D/7KTZ5ssD+zzQ2V4fA1p26ijQaNoIzRW05VB5v
MHnJyoEwBr/HNO/zsVd9iihRv6S+/muQpXB2hBC/rDb1mPMbwN/U8M+Gc+9/fhN1
tsQlN6rBlhlpmJA5maaLvcoyvNjU4qTSp/dPtXhn6Xr4ajJQGQRasEuZo22eeC5I
tZQoJaWABsBTz37NZOxpww0NkaDa7RmRg0iyhgGqmwSfj2AeTS/u7/vg2m0kbWpX
9c5bxE5WbuzqQlgvEAWJ/r++Ajl3d7OWT2TJCc7659OO6ozQQk5i+z4Q9MLSdhKj
W0MacoUy3GbgmRv3Xg/kMa1aDUPiEhTr2odTZF2xsCrlHNRiCHJHXaFdsm4UOqik
5Qn9OXSORVS92xepO+XalE5KAy0N2ERgd0F7DXaou6BR04D0HWrcFEOxvuixFPwi
FaSqIJ8ZifBWamfb5fhnMbIDxacQcTUAcQsYxiC6XkXG0A2cIqQ=
=76Ph
-----END PGP SIGNATURE-----

--zldsfftxvy2fxfnd--
