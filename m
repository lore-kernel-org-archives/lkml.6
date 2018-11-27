Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0E2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7C6208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7C6208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbeK0Tz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:55:57 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58079 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729732AbeK0Tz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:55:57 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 04B2420D31; Tue, 27 Nov 2018 09:58:44 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id C6F07207AD;
        Tue, 27 Nov 2018 09:58:33 +0100 (CET)
Date:   Tue, 27 Nov 2018 09:58:33 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 25/43] drm/sun4i: frontend: Apply format sub-sampling
 to CH1 dimensions
Message-ID: <20181127085833.b6jhe5npgsvl2g5f@flea>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-26-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ivmx4o7crxm34pav"
Content-Disposition: inline
In-Reply-To: <20181123092515.2511-26-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ivmx4o7crxm34pav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 10:24:57AM +0100, Paul Kocialkowski wrote:
> The frontend comes with two "channels", that can be configured
> independently. When used in YUV mode, the first channel (CH0) represents
> the luminance component while the second channel (CH1) represents the
> chrominance. In RGB mode, both have to be configured the same way.
>=20
> Use variables (with the YUV terminology) for each channel's
> dimensions, calculating the chroma dimensions from the luma dimensions
> and the sub-sampling factors from the format description.
>=20
> Since the configured size only has pixel precision, the fractional
> fixed-point part of the source size is dropped for both components to
> ensure that the scaling factors are accurate.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ivmx4o7crxm34pav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/0HOQAKCRDj7w1vZxhR
xXwzAP9MshjHGeL2mhhR8gWpe0Vu1v4edxievCysQnF5opH4lwD9HmJ1c5BOVmIH
nWqkIYj6QHXTU1fYUdj+czi2SA3NwQo=
=Kk8n
-----END PGP SIGNATURE-----

--ivmx4o7crxm34pav--
