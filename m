Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082CAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2B320870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2B320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeIJTKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:10:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41228 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbeIJTKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:10:34 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A911F207B0; Mon, 10 Sep 2018 16:16:14 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6A8BF2074F;
        Mon, 10 Sep 2018 16:16:04 +0200 (CEST)
Date:   Mon, 10 Sep 2018 16:16:03 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-media@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Witos <kwitos@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>
Subject: Re: [PATCH 04/10] phy: dphy: Add configuration helpers
Message-ID: <20180910141603.gnwpkmemevaxbi7b@flea>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
 <3617916.Vq2Smf1hnZ@avalon>
 <20180907133739.6lvlw7wsdk4ffeua@flea>
 <1923627.Ifno3EcWVN@avalon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fi6b2dacjrdoxmvg"
Content-Disposition: inline
In-Reply-To: <1923627.Ifno3EcWVN@avalon>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fi6b2dacjrdoxmvg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 07, 2018 at 05:26:29PM +0300, Laurent Pinchart wrote:
> > >> + */
> > >> +int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
> > >> +				     unsigned int bpp,
> > >> +				     unsigned int lanes,
> > >> +				     struct phy_configure_opts_mipi_dphy *cfg)
> > >> +{
> > >> +	unsigned long hs_clk_rate;
> > >> +	unsigned long ui;
> > >> +
> > >> +	if (!cfg)
> > >> +		return -EINVAL;
> > >=20
> > > Should we really expect cfg to be NULL ?
> >=20
> > It avoids a kernel panic and it's not in a hot patch, so I'd say yes?
>=20
> A few line below you divide by the lanes parameter without checking wheth=
er it=20
> is equal to 0 first, which would also cause issues.

You say that like it would be a bad thing to test for this.

> I believe that invalid values in input parameters should only be handled=
=20
> explicitly when considered acceptable for the caller to pass such values.=
 In=20
> this case a NULL cfg pointer is a bug in the caller, which would get noti=
ced=20
> during development if the kernel panics.

In the common case, yes. In the case where that pointer is actually
being lost by the caller somewhere down the line and you have to wait
for a while before it happens, then having the driver inoperant
instead of just having a panic seems like the right thing to do.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--fi6b2dacjrdoxmvg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluWfKIACgkQ0rTAlCFN
r3SuPQ/9E5zBCx4kDWAKagNrkI+Ew5i1nggHyuM4Mn2suJmx8gJfzPKUlmkVTBHj
MFCt0XIZB/7v71pMDy2fRKrgDjJ8bda9d0Tyaj3QChPP16RwI6iyY/GCPQ/UsVgm
KOhOUq1EZhQm9NtXphzrg1ImJFuhHiVhLD6b+uvfmvuBzTvOrX+yMFihhD5Mj9LX
0jDcSXifmeGt2qS3hncIKmtlEviCydIisTQp2O82a1FwHVmYkk/y1dU0CrX5A1CK
yPlKbugqt3hSWWk9MPIL/rEgszst5HsuX7i6+M61fLLokozS051r0aBy25KYRc1B
C+Q8Q+xkoMY9v9RdpIUHAcklJdsWN9j4XbAfaUu+nqzxxcOoZaDjX/yUL4b06LLy
G0rRD8kAK1BzxfyoWghZzUglbYKlF//KB4DWO6f5H0VHkKQNe1/1fJNIM9VZteM+
WvPQzX30QbCBSt00gTPQyv0Em72BJH7UVDiXe04EgC0Wwt3RF1NtiGiSIE/AE7tM
9a9g0F0LofcXC/0e41k4Mu8Y2a4QpgkB7KzgaYT/FA0kkFXvf65/XTaPHL8ARJ0o
DpfSPgfgHI7DW20N8KZHtPp94mCET/wYdiQB4XVVoRjPSrWVt8UQqxewGz3BiQ9e
G15pp1F3rlY8FWv9GZ8xLJbb3swRudfPofFR/rBS12dPZa7v7IE=
=KrMk
-----END PGP SIGNATURE-----

--fi6b2dacjrdoxmvg--
