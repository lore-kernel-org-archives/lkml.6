Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755154AbeDPL5a (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 07:57:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58960 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754624AbeDPL5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 07:57:18 -0400
Date: Mon, 16 Apr 2018 12:57:11 +0100
From: Mark Brown <broonie@kernel.org>
To: sxauwsk <sxauwsk@163.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangshikai@inno-instrument.cn, guojian <guojian@innoinstrument.net>
Subject: Re: [PATCH] [PATCH v1] spi: cadence: Add usleep_range() for
 cdns_spi_fill_tx_fifo()
Message-ID: <20180416115711.GB20726@sirena.org.uk>
References: <1523861200-34130-1-git-send-email-sxauwsk@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
In-Reply-To: <1523861200-34130-1-git-send-email-sxauwsk@163.com>
X-Cookie: No lifeguard on duty.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2018 at 02:46:40PM +0800, sxauwsk wrote:
> In case of xspi work in busy condition, may send bytes failed.
> once something wrong, spi controller did't work any more
>=20
> My test found this situation appear in both of read/write process.
> so when TX FIFO is full, add one byte delay before send data;

This looks sensible but doesn't seem to apply against current code,
please check and resend. =20

>  		/* When xspi in busy condition, bytes may send failed,
> -		 * caused communication failure so add one byte delay
> +		 * then spi control did't work thoroughly, add one byte delay
>  		 */
> -		usleep_range(10, 20);
> +		if (cdns_spi_read(xspi, CDNS_SPI_ISR_OFFSET) &
> +		    CDNS_SPI_IXR_TXFULL_MASK)
> +			usleep_range(10, 20);

It looks like this may have been sent based on a previous version of
your patch, not against the driver as it is now.

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrUj5YACgkQJNaLcl1U
h9CmDQf+N6GcIexi7BGApL0D9gLTDtT9RN2GdqrVoVokQLKXnP58D1THElEO/nfV
vbUnVrKZqPqKGS6eWFyjNbmyOlsLvWCt8OR7vfEfmLONJdLqCgJPJewg6tf+48Dt
PC6amPDgbvRcFADPym0kNHf5d0sZm9XdKrTP4FtoCrr97QP3gfByzEkCIZ4n1K/H
aiAu81QYajQoD9PkxUadB8nLiFL5HpIWW6DzmIEVlsdx0CPX1fbryYZBtSc7rhNV
XkBwEU5Gw3cVEyFN1WPvjbQidp65sV+9phdVLEQfoARA4ouIUe6E7GVto72xgUMJ
NNHsecrT2KcN+OfGio+PMSvRQzKBGw==
=xFe2
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
