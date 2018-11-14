Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8E0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A078621582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A078621582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbeKOAxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 19:53:05 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38225 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732450AbeKOAxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 19:53:04 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2C5712074F; Wed, 14 Nov 2018 15:49:31 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0165C20379;
        Wed, 14 Nov 2018 15:49:30 +0100 (CET)
Date:   Wed, 14 Nov 2018 15:49:30 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] drm/sun4i: hdmi: Use PTR_ERR_OR_ZERO in
 sun4i_tmds_create()
Message-ID: <20181114144930.j26xlro2cke47xza@flea>
References: <1541558063-100341-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bxddqxz2i5jewhca"
Content-Disposition: inline
In-Reply-To: <1541558063-100341-1-git-send-email-yuehaibing@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bxddqxz2i5jewhca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed, Nov 07, 2018 at 02:34:23AM +0000, YueHaibing wrote:
> Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c b/drivers/gpu/dr=
m/sun4i/sun4i_hdmi_tmds_clk.c
> index fb985ba..3d5ee6f 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
> @@ -232,8 +232,5 @@ int sun4i_tmds_create(struct sun4i_hdmi *hdmi)
>  	tmds->div_offset =3D hdmi->variant->tmds_clk_div_offset;
> =20
>  	hdmi->tmds_clk =3D devm_clk_register(hdmi->dev, &tmds->hw);
> -	if (IS_ERR(hdmi->tmds_clk))
> -		return PTR_ERR(hdmi->tmds_clk);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(hdmi->tmds_clk);

While this is technically correct (and I appreciate that this is also
a matter of taste), I find the former syntax to be clearer and easier
to extend if needed.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--bxddqxz2i5jewhca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+w1+gAKCRDj7w1vZxhR
xRpRAP9rYgWArEpgq7P/wY8Lmo+yxM4RN2CRLzR5vqDQNU+suQD7BRiMKWmV87dD
b0/KX4wnPXW142jqRW1ztlvBcuRYHgo=
=D1nG
-----END PGP SIGNATURE-----

--bxddqxz2i5jewhca--
