Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3BBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A159206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A159206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbeKSTvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:51:50 -0500
Received: from mail.bootlin.com ([62.4.15.54]:39295 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbeKSTvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:51:50 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C0AAB207B0; Mon, 19 Nov 2018 10:28:45 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8EE2F20510;
        Mon, 19 Nov 2018 10:28:35 +0100 (CET)
Date:   Mon, 19 Nov 2018 10:28:35 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eric Anholt <eric@anholt.net>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH] drm/fb-helper: Blacklist writeback when adding
 connectors to fbdev
Message-ID: <20181119092835.3y2xqfclwlmk4cww@flea>
References: <20181115163248.21168-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="adio4floig6atmjq"
Content-Disposition: inline
In-Reply-To: <20181115163248.21168-1-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--adio4floig6atmjq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 05:32:48PM +0100, Paul Kocialkowski wrote:
> Writeback connectors do not produce any on-screen output and require
> special care for use. Such connectors are hidden from enumeration in
> DRM resources by default, but they are still picked-up by fbdev.
> This makes rather little sense since fbdev is not really adapted for
> dealing with writeback.
>=20
> Moreover, this is also a source of issues when userspace disables the
> CRTC (and associated plane) without detaching the CRTC from the
> connector (which is hidden by default). In this case, the connector is
> still using the CRTC, leading to am "enabled/connectors mismatch" and
> eventually the failure of the associated atomic commit. This situation
> happens with VC4 testing under IGT GPU Tools.
>=20
> Filter out writeback connectors in the fbdev helper to solve this.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
Tested-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--adio4floig6atmjq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/KCQwAKCRDj7w1vZxhR
xY7gAQDZHFvWSxHsx94SaSOhXF1A+fyr4pYzvjdF+nkTKvYM6gD+NdiGWDKqdbIr
ACu17Ht3/N6gBG0skZA7KX5lcHQKyQk=
=Blv8
-----END PGP SIGNATURE-----

--adio4floig6atmjq--
