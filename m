Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BFEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF55218A4
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732980AbfAKPyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:54:19 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59189 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730850AbfAKPyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:54:18 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C2CF6209BC; Fri, 11 Jan 2019 16:54:16 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id 95F6B2074D;
        Fri, 11 Jan 2019 16:54:16 +0100 (CET)
Date:   Fri, 11 Jan 2019 16:54:16 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Eric Anholt <eric@anholt.net>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] drm: Auto-set allow_fb_modifiers when given modifiers at
 plane init
Message-ID: <20190111155416.otv563wki5rzhp4u@flea>
References: <20190104085610.5829-1-paul.kocialkowski@bootlin.com>
 <20190107104916.GJ21184@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="35vpbccfsjw7nhln"
Content-Disposition: inline
In-Reply-To: <20190107104916.GJ21184@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--35vpbccfsjw7nhln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 11:49:16AM +0100, Daniel Vetter wrote:
> On Fri, Jan 04, 2019 at 09:56:10AM +0100, Paul Kocialkowski wrote:
> > When drivers pass non-empty lists of modifiers for initializing their
> > planes, we can infer that they allow framebuffer modifiers and set the
> > driver's allow_fb_modifiers mode config element.
> >=20
> > In case the allow_fb_modifiers element was not set (some drivers tend
> > to set them after registering planes), the modifiers will still be
> > registered but won't be available to userspace unless the flag is set
> > later. However in that case, the IN_FORMATS blob won't be created.
> >=20
> > In order to avoid this case and generally reduce the trouble associated
> > with the flag, always set allow_fb_modifiers when a non-empty list of
> > format modifiers is passed at plane init.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>=20
> The automatic primary plane drm_crtc_init() creates doesn't set this, so
> looks correct in all cases.
>=20
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>=20
> (boolin.com has a bunch of drm-misc committers, so I'll leave pushing to
> them).

Applied,

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--35vpbccfsjw7nhln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXDi8KAAKCRDj7w1vZxhR
xeM8AQDB9O4Fg8A3CxY2GJsmFp1+ISyTd1kgJbLcB7c58IQtxwEAr8Eqeq40Xgzf
yzjEdWojD0xRb1/8xYstm23q9tYszQ4=
=HckO
-----END PGP SIGNATURE-----

--35vpbccfsjw7nhln--
