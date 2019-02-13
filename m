Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1429CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7984222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391149AbfBMJDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:03:14 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:38077 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfBMJDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:03:14 -0500
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id B78DAC0043;
        Wed, 13 Feb 2019 09:03:08 +0000 (UTC)
Date:   Wed, 13 Feb 2019 10:03:08 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v7 00/23] drm/sun4i: Allwinner A64 MIPI-DSI support
Message-ID: <20190213090308.dlcwgcrhg264k2cu@flea>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
 <CAMty3ZBspvP=qZEK9vaowVq4f5W3Qx2qHkwcuAnCOOjV29=Y_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v3n2rtb3eqrrumch"
Content-Disposition: inline
In-Reply-To: <CAMty3ZBspvP=qZEK9vaowVq4f5W3Qx2qHkwcuAnCOOjV29=Y_Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v3n2rtb3eqrrumch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 03:16:02PM +0530, Jagan Teki wrote:
> On Fri, Feb 1, 2019 at 9:12 PM Jagan Teki <jagan@amarulasolutions.com> wr=
ote:
> >
> > Here is next version changes for Allwinner A64 MIPI-DSI support
> >
> > This series grouped the changes like previous version[1] with different
> > sets to support three different panels types that can fit into the DSI
> > controller.
> >
> > set:1, for 4-lane, burst mode support
> > - patch 0001: 0009, DSI controller changes that support burst mode.
> >
> > set:2, for A64 DSI support
> > - patch 0010: tcon dclk divider computation based on A64 BSP.
> > - patch 0011: 0017, Allwinner A64 DSI controller changes.
> >
> > set:3, enable 4-lane burst mode panel:
> > - patch 0018: Overlay patch that enable Feiyang FY07024DI26A30-D
> >   burst mode panel on Pine64-LTS
> >
> > set:4, enable 4-lane video mode panel:
> > - patch 0019: msg type MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM support
> > - patch 0020: Overlay patch that enable Bananapi S070WV20-CT16 ICN6211
> >   panel on Bananapi M64
> >
> > set:5, enable 2-lane video mode panel:
> > - patch 0021, 0022: DSI hfp and hbp timings fixes
> > - patch 0023: Enable Techstar TS8550B panel on Amarula A64-Relic
> >
> > Changes for v7:
> > - moved vcc-dsi binding to required filed.
> > - drop quotes on fallback dphy bindings.
> > - drop min_rate clock pll-mipi patches.
> > - introduce dclk divider computation as like A64 BSP.
> > - add A64 DSI quark patches.
> > - fixed A64 DSI pipeline.
> > - add proper commit messages.
> > - collect Merlijn Wajer Tested-by credits.
> > Changes for v6:
> > - dropped unneeded changes, patches
> > - fixed all burst mode patches as per previous version comments
> > - rebase on master
> > - update proper commit message
> > - dropped unneeded comments
> > - order the patches that make review easy
> > Changes for v5:
> > - collect Rob, Acked-by
> > - droped "Fix VBP size calculation" patch
> > - updated vblk timing calculation.
> > - droped techstar, bananapi dsi panel drivers which may require
> >   bridge or other setup. it's under discussion.
> > Changes for v4:
> > - droppoed untested CCU_FEATURE_FIXED_POSTDIV check code in
> >   nkm min, max rate patches
> > - create two patches for "Add Allwinner A64 MIPI DSI support"
> >   one for has_mod_clk quirk and other one for A64 support
> > - use existing driver code construct for hblk computation
> > - dropped "Increase hfp packet overhead" patch [2], though BSP added
> >   this but we have no issues as of now.
> >   (no issues on panel side w/o this change)
> > - create separate function for vblk computation
> > - enable vcc-dsi regulator in dsi_runtime_resume
> > - collect Rob, Acked-by
> > - update MAINTAINERS file for panel drivers
> > - cleanup commit messages
> > - fixed checkpatch warnings/errors
> >
> > [1] https://patchwork.kernel.org/cover/10779893/
> >
> > Any inputs?
> > Jagan.
> >
> > Jagan Teki (23):
> >   drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop N1 instruction
> >     delay
> >   drm/sun4i: sun6i_mipi_dsi: Support instruction loop selection
> >   drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
> >   drm/sun4i: sun6i_mipi_dsi: Simplify drq to support all modes
> >   drm/sun4i: tcon: Export get tcon0 routine
> >   drm/sun4i: sun6i_mipi_dsi: Probe tcon0 during dsi_bind
> >   drm/sun4i: sun6i_mipi_dsi: Setup burst mode
> >   drm/sun4i: sun6i_mipi_dsi: Enable trail_inv and trail_fill controls
> >   drm/sun4i: sun6i_mipi_dsi: Enable HBP, HSA_HSE for burst mode
>=20
> Can you pick these burst changes which are generic to all SoCs. and
> reset will send once we decide the tcon clock.

These patches don't implement what we discussed last week, and as I
told you already, most of them really need some work on the commit log
and their explanations.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--v3n2rtb3eqrrumch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGPdTAAKCRDj7w1vZxhR
xc/AAP9miZRDj1pZWJVBU4zeqpb9KrssK+t+zsH+tsTM+wdnugEA6P4ORSF94yTT
UipuIVIseMDH88WEB4c15hnBPzIDYAs=
=Va9V
-----END PGP SIGNATURE-----

--v3n2rtb3eqrrumch--
