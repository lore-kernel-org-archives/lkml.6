Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EEBC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCCF20989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCCF20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbeKUUpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:45:23 -0500
Received: from mail.bootlin.com ([62.4.15.54]:41915 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbeKUUpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:45:23 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 21B0220D31; Wed, 21 Nov 2018 11:11:32 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id E702720D29;
        Wed, 21 Nov 2018 11:11:21 +0100 (CET)
Date:   Wed, 21 Nov 2018 11:11:21 +0100
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
Subject: Re: [PATCH v2 8/9] phy: Add Cadence D-PHY support
Message-ID: <20181121101121.7rhe2hz2mnmc72cu@flea>
References: <cover.c2c2ae47383b9dbbdee6b69cafdd7391c06dde4f.1541516029.git-series.maxime.ripard@bootlin.com>
 <4ec9e47fb5aa9794f69a8e75a04108055094c056.1541516029.git-series.maxime.ripard@bootlin.com>
 <5f5bcc06-51b2-d565-56a0-083c66c1f01a@ti.com>
 <8536050b-40ab-1ec4-d325-e59bb3a92e73@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ttjex4x5w3yurkmw"
Content-Disposition: inline
In-Reply-To: <8536050b-40ab-1ec4-d325-e59bb3a92e73@ti.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ttjex4x5w3yurkmw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kishon,

On Tue, Nov 20, 2018 at 11:02:34AM +0530, Kishon Vijay Abraham I wrote:
> > > +static int cdns_dphy_config_from_opts(struct phy *phy,
> > > +				      struct phy_configure_opts_mipi_dphy *opts,
> > > +				      struct cdns_dphy_cfg *cfg)
> > > +{
> > > +	struct cdns_dphy *dphy =3D phy_get_drvdata(phy);
> > > +	unsigned int dsi_hfp_ext =3D 0;
> > > +	int ret;
> > > +
> > > +	ret =3D phy_mipi_dphy_config_validate(opts);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D cdns_dsi_get_dphy_pll_cfg(dphy, cfg,
> > > +					opts, &dsi_hfp_ext);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	opts->wakeup =3D cdns_dphy_get_wakeup_time_ns(dphy);
>=20
> Is the wakeup populated here used by the consumer driver?

It's supposed to, if it can yes.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ttjex4x5w3yurkmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/UvSQAKCRDj7w1vZxhR
xa/lAPwJhIct3Jc0UzdxD5DP15c9Pa6jnLtkgzNGvvIaYDj6mgEAnoLj1FspAqzu
2NqTBnQTr0AC9In9vPjRm8r/oAyaTg4=
=BI+c
-----END PGP SIGNATURE-----

--ttjex4x5w3yurkmw--
