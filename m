Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA48DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8F120989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8F120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbeK0T2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:28:42 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55445 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729129AbeK0T2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:28:41 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7162B20DBE; Tue, 27 Nov 2018 09:31:33 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 423B8207BC;
        Tue, 27 Nov 2018 09:31:23 +0100 (CET)
Date:   Tue, 27 Nov 2018 09:31:23 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 02/43] drm/sun4i: frontend: Replace ARGB with XRGB as
 supported format
Message-ID: <20181127083123.ok6eftf2nd4arqe5@flea>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-3-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b3xfdm4n7fbyncrm"
Content-Disposition: inline
In-Reply-To: <20181123092515.2511-3-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b3xfdm4n7fbyncrm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 10:24:34AM +0100, Paul Kocialkowski wrote:
> The frontend documentation (for the A33) mentions that ARGB is supported
> as output, but with the alpha component always set to 0xff. In practice,
> this means that the alpha component cannot be preserved when going
> through the frontend. Since the information is lost, ARGB is not
> properly supported.
>=20
> As a result, expose the matching format supported by the frontend (both
> for input and output) as XRGB instead of ARGB.
>=20
> Since ARGB was the selected format for connecting the frontend to the
> backend, change it to XRGB to reflect this as well.
>=20
> The A31 and A80 SoCs apparently have a bit to enable proper alpha,
> but this is not supported at this point (see the comment already in the
> code).
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--b3xfdm4n7fbyncrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/0A2wAKCRDj7w1vZxhR
xXMlAQDMMrbN5E5MhUvac4STw4t34AqYsOuAD8fKf/x0z+hC4QEAjMrEMnm/Vn1W
FylgWYaWFTdKyGc5ChlTyeV9cRzJqgA=
=LSdU
-----END PGP SIGNATURE-----

--b3xfdm4n7fbyncrm--
