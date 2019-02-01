Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BA2C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E849218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfBANMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:12:21 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:54363 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfBANMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:12:21 -0500
X-Originating-IP: 90.88.147.226
Received: from localhost (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 87834E0007;
        Fri,  1 Feb 2019 13:12:18 +0000 (UTC)
Date:   Fri, 1 Feb 2019 14:12:18 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] drm/sun4i: tcon: Prepare and enable TCON channel 0 clock
 at init
Message-ID: <20190201131218.633gv3npsekliezj@flea>
References: <20190131132550.26355-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mw7tj6i6edxi3mtm"
Content-Disposition: inline
In-Reply-To: <20190131132550.26355-1-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mw7tj6i6edxi3mtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 02:25:50PM +0100, Paul Kocialkowski wrote:
> When initializing clocks, a reference to the TCON channel 0 clock is
> obtained. However, the clock is never prepared and enabled later.
> Switching from simplefb to DRM actually disables the clock (that was
> usually configured by U-Boot) because of that.
>=20
> On the V3s, this results in a hang when writing to some mixer registers
> when switching over to DRM from simplefb.
>=20
> Fix this by preparing and enabling the clock when initializing other
> clocks. Waiting for sun4i_tcon_channel_enable to enable the clock is
> apparently too late and results in the same mixer register access hang.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mw7tj6i6edxi3mtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFRFsgAKCRDj7w1vZxhR
xWwCAP9nOM5TEB8sq5A3dUGCZ7iQqjy0qQCGIFOMG2kI5sFgNgD8D0dRKAXCf1j5
TIxNDj5ErrqgTSJqEagzyWos9NDO5QA=
=PWKT
-----END PGP SIGNATURE-----

--mw7tj6i6edxi3mtm--
