Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C5CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450CB2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546874532;
	bh=/zPkt3w+YVbiRP+ggAH8tK2YZSkRdYc5dNateEprkyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GUjhuwyHOx5RS8bng04aYEkFAywCiCyozYZSS+g17KSo5HrLQL4KU+EfcfYjHItfh
	 r3O+nz2j2BTiDU0BCaStokF6T/xDaBIk3dXvrtLiJ8JBliv1wGvq5GsZWLt+je26PL
	 kv/epPT0nZx2W/WLAmK+jCEClXD8W9ly/gdSmO3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbfAGPWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:22:11 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44934 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfAGPWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=87suKXyWDaQtpwscAPWIdxtnolEhcgPagitxUoHqHsk=; b=UEKnMy4LXriOQwuvoxJLeUjnq
        ufgufAN/Rby88cVYnMR3eh2jopoN6iLXGMxmEwrtj6iMAXZVFzDiR9/Af2NYhCX476p4ZofXF3DV6
        Tk3r2xX3qoLZo6vvzotPOOxdjrcY0KDbHMZaj+McXIct7yZcSBQHK+Ry++F1LKXIm9AgQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ggWjA-0007Ot-DS; Mon, 07 Jan 2019 15:22:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A87801127491; Mon,  7 Jan 2019 15:22:07 +0000 (GMT)
Date:   Mon, 7 Jan 2019 15:22:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/8] spi: lpspi: add dma mode support
Message-ID: <20190107152207.GG9570@sirena.org.uk>
References: <20190107074639.6336-1-xiaoning.wang@nxp.com>
 <20190107074639.6336-9-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RDS4xtyBfx+7DiaI"
Content-Disposition: inline
In-Reply-To: <20190107074639.6336-9-xiaoning.wang@nxp.com>
X-Cookie: NOBODY EXPECTS THE SPANISH INQUISITION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RDS4xtyBfx+7DiaI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:47:49AM +0000, Clark Wang wrote:

A couple of small nits but otherwise this looks good:

> +	bytes_per_word =3D fsl_lpspi_bytes_per_word(transfer->bits_per_word);
> +	if (bytes_per_word !=3D 1 && bytes_per_word !=3D 2 && bytes_per_word !=
=3D 4)
> +		return false;

This would be clearer written as a switch statement.

> @@ -301,12 +352,59 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_d=
ata *fsl_lpspi)
>  	writel(scldiv | (scldiv << 8) | ((scldiv >> 1) << 16),
>  					fsl_lpspi->base + IMX7ULP_CCR);
> =20
> -	dev_dbg(fsl_lpspi->dev, "perclk=3D%d, speed=3D%d, prescale =3D%d, scldi=
v=3D%d\n",
> +	dev_dbg(fsl_lpspi->dev, "perclk=3D%d, speed=3D%d, prescale=3D%d, scldiv=
=3D%d\n",
>  		perclk_rate, config.speed_hz, prescale, scldiv);
> =20
>  	return 0;
>  }
> =20

This looks like an unrelated typo fix, should be a separate patch.

--RDS4xtyBfx+7DiaI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzbp4ACgkQJNaLcl1U
h9Ajsgf/Yha2C12GozXXbtV+VEOkPRDxY5PnRhuK4O6TJPJ5J1RCKg0OnAPHghyi
pgE8rq3k1wvFu571RkgEAEtqJILViIEXTDDW++UVh1k5ePRx9/61sJEDvmfqLa2V
l4m6tziQVLz94sebXS1De+z7Q2XbxAGj/9KoYeI6eOHEB4UCLbLh/xq5OVL+T0uL
vwL8vlXOFhQF14exiEM7Xs0YfljJaLW5sLHEU6lU4hltFA94/KtwbSULpOXzA81t
I9/frO8i+GYulmgv/29dUGXJMyA3NpSi6lsj+BJ/zPgb0/juf31LjGHIUZCtZRzy
UBz2r8JgovhZRMbL84YGO5mGvYl2tw==
=Dlhv
-----END PGP SIGNATURE-----

--RDS4xtyBfx+7DiaI--
