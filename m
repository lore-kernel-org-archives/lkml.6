Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53214C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E002075D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfBDKaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:30:22 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:44292 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbfBDKaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:30:21 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43tP9N4mTpz1r3bW;
        Mon,  4 Feb 2019 11:30:16 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43tP9N3VBpz1rVwM;
        Mon,  4 Feb 2019 11:30:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id uUOQX8Z7QANU; Mon,  4 Feb 2019 11:30:14 +0100 (CET)
X-Auth-Info: kJZET4WO/lEBzBRDPPTn+ViBsmJjQJ7WcyDgJU/9K3M=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  4 Feb 2019 11:30:14 +0100 (CET)
Date:   Mon, 4 Feb 2019 11:30:01 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        Martin =?UTF-8?B?SHVuZGViw7hsbA==?= <martin@geanix.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v5] ARM: dspi: Provide support for DSPI slave mode
 operation (Vybryd vf610)
Message-ID: <20190204113001.77d59570@jawa>
In-Reply-To: <20190109082644.14941-1-lukma@denx.de>
References: <20180927150709.17010-1-lukma@denx.de>
        <20190109082644.14941-1-lukma@denx.de>
Organization: denx.de
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/W4Esgja4AsQbHE3sTBx7r6y"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W4Esgja4AsQbHE3sTBx7r6y
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
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> Changes for v5:
>=20
> - Rebase to v5.0-rc1 (no code changes needed)

Is there any interest in adding new code (or fixes) to VF610 ?=20

The first version of this patch was posted more than 4 months ago with
no feedback on the VF610 dspi controller part (after I've rewritten it
to use the generic SPI slave code after comments from Geert [1]).

I do have a feeling that upstreaming this code takes a bit too long ...

[1] - https://lkml.org/lkml/2018/9/26/836

>=20
> Changes for v4:
>=20
> - Rebase to v4.20-rc5 (no code changes needed)
>=20
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
> index 5e10dc5c93a5..348682be9dd5 100644
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

--Sig_/W4Esgja4AsQbHE3sTBx7r6y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlxYFCkACgkQAR8vZIA0
zr1T7gf8DLa3CcHiFqBGUSa7LlfF73nm1NjO1JAbIB9inEccDPGYG9FoT0oVTzl6
7xOlOClt+hjsZC80MTBcyqKImEqHyUEdCzyvoPymqIgl3ZIJe9hGvDyve/N1NHEB
JgbDE16xZlhiEJFHCMjXFg7AO2ZftOtbeZIQRcFnS/DOK+q1ezM74X0sVP32/RNl
ZnBdqB4cEFLjxcpRupWtJqjCpfo4RULn5SNeWLhL+F3qvduapNedEiMgQVkjhA8W
NGu0rXCbkobe73Rqg+KRZQdaP0IB+4Q56jSSJ06zXoMUEHzfKR5uT+ehBTKDqMYF
nA5ICtn4v0jdcHgqsp9yS0phICwWWQ==
=PII2
-----END PGP SIGNATURE-----

--Sig_/W4Esgja4AsQbHE3sTBx7r6y--
