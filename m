Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A49DC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 08:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B172081C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 08:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B172081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbeLBIrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 03:47:37 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:58635 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLBIrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 03:47:36 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4371wK5lY3z1qwdt;
        Sun,  2 Dec 2018 09:47:29 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4371wK4Wyvz1qtfC;
        Sun,  2 Dec 2018 09:47:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ALciLQp4YCUn; Sun,  2 Dec 2018 09:47:27 +0100 (CET)
X-Auth-Info: JfZ1ozKI+ABIEXyGvXnGJ/9ia3GCwFIenP0RcOsOWa4=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun,  2 Dec 2018 09:47:27 +0100 (CET)
Date:   Sun, 2 Dec 2018 09:47:17 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        Martin =?UTF-8?B?SHVuZGViw7hsbA==?= <martin@geanix.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCHv3] ARM: dspi: Provide support for DSPI slave mode
 operation (Vybryd vf610)
Message-ID: <20181202094717.7ddc88e8@jawa>
In-Reply-To: <20181113120631.13514-1-lukma@denx.de>
References: <20180927150709.17010-1-lukma@denx.de>
        <20181113120631.13514-1-lukma@denx.de>
Organization: denx.de
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/k325Tbu2Xw.1f8=ALzyDmPe"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k325Tbu2Xw.1f8=ALzyDmPe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear All,

> The NXP's Vybryd vf610 can work as a SPI slave device (the CS and
> clock signals are provided by master).
>=20
> It is possible to specify a single device to work in that mode. As we
> do use DMA for transferring data, the RX channel must be prepared for
> incoming data.
> Moreover, in slave mode we just set a subset of control fields in
> configuration registers (CTAR0, PUSHR).
>=20
> For testing the spidev_test program has been used.
> Test script for this patch can be found here:
> https://github.com/lmajewski/tests-spi/blob/master/tests/spi/spi_tests.sh

Gentle ping on this patch. Comments are more than welcome.

>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> Changes for v3:
>=20
> - Rebase to v4.20-rc2 (no code changes needed)
>=20
> Changes for v2:
>=20
> - Remove patch which adds extra NXP specific DTS property to support
> slave mode and reuse the generic one (spi-slave)
> - Remove patch which brings back the mcr_register local copy. It is
> not needed as generic SPI slave infrastructure is used.
> - Rewrite the code to use spi_controller_is_slave() helper functions
> ---
>  drivers/spi/spi-fsl-dspi.c | 40
> ++++++++++++++++++++++++++++++---------- 1 file changed, 30
> insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 3082e72e4f6c..94b6a9690062 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -233,6 +233,9 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi
> *dspi) {
>  	u16 cmd =3D dspi->tx_cmd, data =3D dspi_pop_tx(dspi);
> =20
> +	if (spi_controller_is_slave(dspi->master))
> +		return data;
> +
>  	if (dspi->len > 0)
>  		cmd |=3D SPI_PUSHR_CMD_CONT;
>  	return cmd << 16 | data;
> @@ -329,6 +332,11 @@ static int dspi_next_xfer_dma_submit(struct
> fsl_dspi *dspi) dma_async_issue_pending(dma->chan_rx);
>  	dma_async_issue_pending(dma->chan_tx);
> =20
> +	if (spi_controller_is_slave(dspi->master)) {
> +
> wait_for_completion_interruptible(&dspi->dma->cmd_rx_complete);
> +		return 0;
> +	}
> +
>  	time_left =3D
> wait_for_completion_timeout(&dspi->dma->cmd_tx_complete,
> DMA_COMPLETION_TIMEOUT); if (time_left =3D=3D 0) {
> @@ -798,14 +806,18 @@ static int dspi_setup(struct spi_device *spi)
>  	ns_delay_scale(&pasc, &asc, sck_cs_delay, clkrate);
> =20
>  	chip->ctar_val =3D SPI_CTAR_CPOL(spi->mode & SPI_CPOL ? 1 : 0)
> -		| SPI_CTAR_CPHA(spi->mode & SPI_CPHA ? 1 : 0)
> -		| SPI_CTAR_LSBFE(spi->mode & SPI_LSB_FIRST ? 1 : 0)
> -		| SPI_CTAR_PCSSCK(pcssck)
> -		| SPI_CTAR_CSSCK(cssck)
> -		| SPI_CTAR_PASC(pasc)
> -		| SPI_CTAR_ASC(asc)
> -		| SPI_CTAR_PBR(pbr)
> -		| SPI_CTAR_BR(br);
> +		| SPI_CTAR_CPHA(spi->mode & SPI_CPHA ? 1 : 0);
> +
> +	if (!spi_controller_is_slave(dspi->master)) {
> +		chip->ctar_val |=3D SPI_CTAR_LSBFE(spi->mode &
> +						 SPI_LSB_FIRST ? 1 :
> 0)
> +			| SPI_CTAR_PCSSCK(pcssck)
> +			| SPI_CTAR_CSSCK(cssck)
> +			| SPI_CTAR_PASC(pasc)
> +			| SPI_CTAR_ASC(asc)
> +			| SPI_CTAR_PBR(pbr)
> +			| SPI_CTAR_BR(br);
> +	}
> =20
>  	spi_set_ctldata(spi, chip);
> =20
> @@ -970,8 +982,13 @@ static const struct regmap_config
> dspi_xspi_regmap_config[] =3D {=20
>  static void dspi_init(struct fsl_dspi *dspi)
>  {
> -	regmap_write(dspi->regmap, SPI_MCR, SPI_MCR_MASTER |
> SPI_MCR_PCSIS |
> -		     (dspi->devtype_data->xspi_mode ? SPI_MCR_XSPI :
> 0));
> +	unsigned int mcr =3D SPI_MCR_PCSIS |
> +		(dspi->devtype_data->xspi_mode ? SPI_MCR_XSPI : 0);
> +
> +	if (!spi_controller_is_slave(dspi->master))
> +		mcr |=3D SPI_MCR_MASTER;
> +
> +	regmap_write(dspi->regmap, SPI_MCR, mcr);
>  	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
>  	if (dspi->devtype_data->xspi_mode)
>  		regmap_write(dspi->regmap, SPI_CTARE(0),
> @@ -1027,6 +1044,9 @@ static int dspi_probe(struct platform_device
> *pdev) }
>  		master->bus_num =3D bus_num;
> =20
> +		if (of_property_read_bool(np, "spi-slave"))
> +			master->slave =3D true;
> +
>  		dspi->devtype_data =3D
> of_device_get_match_data(&pdev->dev); if (!dspi->devtype_data) {
>  			dev_err(&pdev->dev, "can't get
> devtype_data\n");




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/k325Tbu2Xw.1f8=ALzyDmPe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlwDnBYACgkQAR8vZIA0
zr3uhQgAsmDCC10y9hbm6A8a4xYAh3hjEWBRCK/sBM8H6TxBHvfEeBReHcuEgyLf
dXmvbXYhHTnkrkupFWC0b62Sgu4n0+Hvt+J4qy6Gkxq0JZIRsBFtaboWt5iHfdsG
4ztMwEIt3u9vOJE96FVeZ/cyxoUDuxyMsjB7S14y2jQDzbhoCY7k+z5w969+rrSw
CrUe0ROi2wdxt+fkk+CMN2MaPDQCp3L5CCsEA/bgUhlkZzCg42YfRQ6V+Wcxvvtz
b5a6V+5DiaOxdXW7GfapZb1yu4dK+WVwGDyUSKAGZjb/U5BvCWvGL+faNwMZpGDs
L4zLfsIrJ+BAcisSSmVDvtgynBN/6g==
=UVPt
-----END PGP SIGNATURE-----

--Sig_/k325Tbu2Xw.1f8=ALzyDmPe--
