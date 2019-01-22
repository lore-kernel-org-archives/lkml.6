Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D16C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7173120870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfAVWv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:51:57 -0500
Received: from sauhun.de ([88.99.104.3]:56624 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbfAVWv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:51:57 -0500
Received: from localhost (p54B333AA.dip0.t-ipconnect.de [84.179.51.170])
        by pokefinder.org (Postfix) with ESMTPSA id D6CBE2C78FF;
        Tue, 22 Jan 2019 23:51:55 +0100 (CET)
Date:   Tue, 22 Jan 2019 23:51:55 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     linux-i2c@vger.kernel.org, linux-imx@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabio.estevam@nxp.com, leoyang.li@nxp.com
Subject: Re: [PATCH v2 1/2] i2c: imx: fix dma_request_chan error handling
Message-ID: <20190122225155.vfy37bfuikzzymao@ninjato>
References: <20190116112855.13824-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tzp54if5hd3it573"
Content-Disposition: inline
In-Reply-To: <20190116112855.13824-1-laurentiu.tudor@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tzp54if5hd3it573
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 16, 2019 at 01:28:54PM +0200, Laurentiu Tudor wrote:
> Use the correct error pointer when extracting the error code.
>=20
> Fixes: ea1e5f176e97 ("i2c: imx: notify about real errors on dma i2c_imx_d=
ma_request")

This is not the sha1 in my tree. Maybe you rebased? I applied another
patch meanwhile fixing the same issue. Still thanks!

> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 09b124547669..42fed40198a0 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -287,7 +287,7 @@ static int i2c_imx_dma_request(struct imx_i2c_struct =
*i2c_imx,
> =20
>  	dma->chan_tx =3D dma_request_chan(dev, "tx");
>  	if (IS_ERR(dma->chan_tx)) {
> -		ret =3D PTR_ERR(dma->chan_rx);
> +		ret =3D PTR_ERR(dma->chan_tx);
>  		if (ret !=3D -ENODEV && ret !=3D -EPROBE_DEFER)
>  			dev_err(dev, "can't request DMA tx channel (%d)\n", ret);
>  		goto fail_al;
> --=20
> 2.17.1
>=20

--tzp54if5hd3it573
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxHnosACgkQFA3kzBSg
KbZMgA//cFlQRC8UbygfeKRp1djCuNi+hrVDWQ3uHwvIO54srWtH/93QcngYpDo3
zPaJY+syS3Hl22XvtZDgSMljAiN2JXGv0UsxjcTRxU60A4TQaY/UUYuDIF6PcPbN
kiLGbHmZ+LaT/bSTH6k+c7l7nx/ffqxHrlcy5VOgp9pcOdTsvidJlVV/tsQ5QApJ
I4c+7xWzr5CztMci10Dq5p3wRClQNpbA28AVWpufJ78yDxf1yMS2q1F84Qbvg1Wd
XjJESQdlkAXs0e9Ujjwg1mHzAO7lwkF8oj2QN38E94ebyx2t3uoyrv8cbRi/ivCR
UUwE5Aa72Yhk+h5sTPo3MnAXv9V2gYXkjuinzHwibOxC+B4PQu/oItW4xmGvihh3
LO88WNnsBgK0M3ZGzWcKYubyYp+zF6a3Z3U47lN1zc2BzS1Ba8svDmQeoeuxItWc
QRjYtymm/2daqJh7s+2PLjbXHckuw7BsiA9j42YsWiGNMxll88mEPGpg3+F1Fzhh
0tTJ0zUuSm+99wJO1NanBnGE8vzGb9yjPKqf8xID+1W7q+EjwlNGsHQXb5YchWAe
R+VmyaoTXoDFytH8LotU628o4WAEFFpJjJjV1hyeC/gev+N/gcWoE1p1W1Gzwvxd
BxYwAedHrPXztHDfMi9p2EUtXOMyJsm4bIM2ToQ4Clh70xQBl8k=
=gB2m
-----END PGP SIGNATURE-----

--tzp54if5hd3it573--
