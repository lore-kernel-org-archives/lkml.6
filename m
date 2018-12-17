Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352D1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F2D206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbeLQPbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:31:12 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47131 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbeLQPbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:31:12 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1gYurN-0006K9-Vm; Mon, 17 Dec 2018 16:31:09 +0100
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1gYurM-00039Z-D8; Mon, 17 Dec 2018 16:31:08 +0100
Date:   Mon, 17 Dec 2018 16:31:08 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH v2 08/19] mailbox: imx: Use device-managed registration
 API
Message-ID: <20181217153108.ycu7xg25edzccv7g@pengutronix.de>
References: <20181217150217.32435-1-thierry.reding@gmail.com>
 <20181217150217.32435-9-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qvpswsuqauvcroq3"
Content-Disposition: inline
In-Reply-To: <20181217150217.32435-9-thierry.reding@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 16:30:05 up 188 days, 39 min, 131 users,  load average: 0.21, 0.18,
 0.20
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qvpswsuqauvcroq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 04:02:06PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Get rid of some boilerplate driver removal code by using the newly added
> device-managed registration API.
>=20
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

> ---
>  drivers/mailbox/imx-mailbox.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index 363d35d5e49d..774362a05159 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -324,14 +324,13 @@ static int imx_mu_probe(struct platform_device *pde=
v)
> =20
>  	imx_mu_init_generic(priv);
> =20
> -	return mbox_controller_register(&priv->mbox);
> +	return devm_mbox_controller_register(dev, &priv->mbox);
>  }
> =20
>  static int imx_mu_remove(struct platform_device *pdev)
>  {
>  	struct imx_mu_priv *priv =3D platform_get_drvdata(pdev);
> =20
> -	mbox_controller_unregister(&priv->mbox);
>  	clk_disable_unprepare(priv->clk);
> =20
>  	return 0;
> --=20
> 2.19.1
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--qvpswsuqauvcroq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlwXwTgACgkQdQOiSHVI
77SEUAf/bUL04o+tlyA2nkwhJMS+5/9x96p3uzmx+lhpAZNOo23fVxehmcz3zr5P
Wt8rXDjjqqiD1yztvjUjXUo/R/pidrBqH7YnX9f0VZ30a/kIBohKqAChB0YGETPu
8xTInzWsRwqs9zxCNpUyPL18hY8gFwk0F8WNTOckISmmIFCDMblseEuBHLRFW/dx
ChdnSCOaHpo5EjZp4ZW2Kaq5vElu2Ggf3V1RriQ4bTMZ1s85FEC2fN6WZ8NJ3jmz
IYBgVu88aipODGbzbINL0ROSPdxtVpPkSmwrw4L0RmfGGrP3FQ9J+Dq89A7KZJhK
rM1CoMlAMg46dmWwuWLRlnujCYLmvg==
=RvwJ
-----END PGP SIGNATURE-----

--qvpswsuqauvcroq3--
