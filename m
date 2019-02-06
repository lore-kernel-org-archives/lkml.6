Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EABC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2047220663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfBFJSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 04:18:50 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50023 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfBFJSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 04:18:49 -0500
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 459F26001C;
        Wed,  6 Feb 2019 09:18:44 +0000 (UTC)
Date:   Wed, 6 Feb 2019 10:18:44 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Chen-Yu Tsai <wens@csie.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Variable "val" in function
 sun8i_dwmac_set_syscon() could be uninitialized
Message-ID: <20190206091844.gqwomr4j2pe3vvvn@flea>
References: <20190205221559.17545-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5fngwngoxyun3lzg"
Content-Disposition: inline
In-Reply-To: <20190205221559.17545-1-yzhai003@ucr.edu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5fngwngoxyun3lzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 05, 2019 at 02:15:59PM -0800, Yizhuo wrote:
> In function sun8i_dwmac_set_syscon(), local variable "val" could
> be uninitialized if function regmap_read() returns -EINVAL.
> However, it will be used directly in the if statement, which
> is potentially unsafe.
>=20
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/=
net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 39c2122a4f26..11d481c9e7ab 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -639,9 +639,14 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv=
 *priv)
>  	struct sunxi_priv_data *gmac =3D priv->plat->bsp_priv;
>  	struct device_node *node =3D priv->device->of_node;
>  	int ret;
> -	u32 reg, val;
> +	u32 reg, val =3D 0;

I guess we don't need to initialize it anymore with the check you add?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--5fngwngoxyun3lzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFqmdAAKCRDj7w1vZxhR
xbdEAQDkVLWjPxsG2BD//iU7Y0A7XKf0pM9pJSkJi3keBVJE8QEAqcUZmZksPBsL
N2GJOL9haNEujvY7y0VzsuCthVc1hwY=
=QjTU
-----END PGP SIGNATURE-----

--5fngwngoxyun3lzg--
