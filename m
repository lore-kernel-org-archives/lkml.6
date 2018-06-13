Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 49AE4C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006DC208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006DC208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754524AbeFMHqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:46:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42439 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754452AbeFMHqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:46:23 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8B6A120720; Wed, 13 Jun 2018 09:46:21 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5D79320012;
        Wed, 13 Jun 2018 09:46:21 +0200 (CEST)
Date:   Wed, 13 Jun 2018 09:46:21 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, airlied@linux.ie,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 14/27] drm/sun4i: Don't check for panel or bridge on
 TV TCONs
Message-ID: <20180613074621.5phumovcyymbkfbn@flea>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <20180612200036.21483-15-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="on6p3lb7ylr4gu64"
Content-Disposition: inline
In-Reply-To: <20180612200036.21483-15-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--on6p3lb7ylr4gu64
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2018 at 10:00:23PM +0200, Jernej Skrabec wrote:
> TV TCONs are always connected to TV or HDMI encoder, so it doesn't make
> sense to check if panel or bridge is connected to them.
>=20
> Check if TCON has channel 0 and only then check for connected panel or
> bridges.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/s=
un4i_tcon.c
> index b1205a7bc20f..c9ffa5381185 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -1189,13 +1189,19 @@ static const struct component_ops sun4i_tcon_ops =
=3D {
>  static int sun4i_tcon_probe(struct platform_device *pdev)
>  {
>  	struct device_node *node =3D pdev->dev.of_node;
> +	const struct sun4i_tcon_quirks *quirks;
>  	struct drm_bridge *bridge;
>  	struct drm_panel *panel;
>  	int ret;
> =20
> -	ret =3D drm_of_find_panel_or_bridge(node, 1, 0, &panel, &bridge);
> -	if (ret =3D=3D -EPROBE_DEFER)
> -		return ret;
> +	quirks =3D of_device_get_match_data(&pdev->dev);

We should probably check ofr the pointer value before dereferencing it.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--on6p3lb7ylr4gu64
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsgy8wACgkQ0rTAlCFN
r3TKsxAAiMdTHSYwfXld6lYjllJDZDxQke3ipIpcBxmX3te3cqIKX5GX25YtR6EK
M3XrUPsCgfGoVGnifxdC+Ew5CxKaPdGOrgYAHFtbBlPcI1/sX14eVqm628kRWa+Q
z6GPHG3c8w+ze97sOmJ/pgh30OV9Ugk4rO5/DLJvK65Yqz6JAvbr3wUVteFGM7tf
Qo5SLUPvtA0dbUa4IsmweBjkAcSRqJXtv+HS3UZB/1u4/skoIS+TRW2YuDwLfRgq
M14nEOMT/UpsLoG+N+OBksRAgNunN3YFbKWamml/2rJGBXYzhCqNuk3z1AElJb2b
1fSnahf2iR5Zg2vo4Mzvu+kNHgy7IOh3u5rUnhuQ0666gGFHTqUC7ZS/eHuFFF+C
SR2HcY9ct/wXan45S/h+OJmtciqXP95kVUZfTyzckdCpuQ9uZTCrx45cbpRRfggx
7NSqyUmw9E5U76ycqxQTFlCCJaY5dcaCHoP0+DPjrrs9lYicKlCVB8Um85bXaJbP
/RDrCmBR2+J4c/O5m3namnPbdTJS1nlM2/VakwVK8KF9/WZJT9c7yuk7UwXj8ZAS
w7slUbXq6JsGH1z03hrDe2NoPPsdfupRaM5jv04+QKpW8aVSPvDihXcqwR80/5hB
5VURE7lyKbgtf9So5TLG35HgiF3UYsKaQz9tWdyYg1zlOzTtYL4=
=7udD
-----END PGP SIGNATURE-----

--on6p3lb7ylr4gu64--
