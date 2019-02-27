Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9B6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6324B20661
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfB0ODe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:03:34 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37289 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730472AbfB0ODe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:03:34 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mkl@pengutronix.de>)
        id 1gyzo2-0001c1-2f; Wed, 27 Feb 2019 15:03:30 +0100
Received: from [IPv6:2a03:f580:87bc:d400:f8eb:aafc:4bc:24e5] (unknown [IPv6:2a03:f580:87bc:d400:f8eb:aafc:4bc:24e5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CF56F3DC722;
        Wed, 27 Feb 2019 14:03:28 +0000 (UTC)
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc:     "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <20181212064419.18613-1-qiangqing.zhang@nxp.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] can: flexcan: add TX support for variable payload size
Message-ID: <cb0bf438-e3c3-5591-dcf7-8802346feefc@pengutronix.de>
Date:   Wed, 27 Feb 2019 15:03:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20181212064419.18613-1-qiangqing.zhang@nxp.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="rHzSW3w6iy4aDzcweX6WrcfMFAxHWKe9Q"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rHzSW3w6iy4aDzcweX6WrcfMFAxHWKe9Q
Content-Type: multipart/mixed; boundary="zgwkDLGLmV2tiDDHkTxnm9pBa7hK27aPF";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>
Message-ID: <cb0bf438-e3c3-5591-dcf7-8802346feefc@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: add TX support for variable payload size
References: <20181212064419.18613-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181212064419.18613-1-qiangqing.zhang@nxp.com>

--zgwkDLGLmV2tiDDHkTxnm9pBa7hK27aPF
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 12/12/18 7:46 AM, Joakim Zhang wrote:
> Now the FlexCAN driver always use last mailbox for TX, it will work wel=
l
> when MB payload size is 8/16 bytes.
> TX mailbox would change to 13 when MB payload size is 64 bytes to
> support CANFD. So we may need to set iflag register to add support for
> variable payload size.
>=20
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  drivers/net/can/flexcan.c | 42 +++++++++++++++++++++++++++++----------=

>  1 file changed, 32 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 0f36eafe3ac1..13fd085fcf84 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -141,7 +141,9 @@
>  #define FLEXCAN_TX_MB_RESERVED_OFF_FIFO		8
>  #define FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP	0
>  #define FLEXCAN_RX_MB_OFF_TIMESTAMP_FIRST	(FLEXCAN_TX_MB_RESERVED_OFF_=
TIMESTAMP + 1)
> -#define FLEXCAN_IFLAG_MB(x)		BIT((x) & 0x1f)
> +#define FLEXCAN_IFLAG1_MB_NUM		32
> +#define FLEXCAN_IFLAG1_MB(x)		BIT(x)
> +#define FLEXCAN_IFLAG2_MB(x)		BIT((x) & 0x1f)
>  #define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW	BIT(7)
>  #define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
>  #define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
> @@ -822,9 +824,15 @@ static inline u64 flexcan_read_reg_iflag_rx(struct=
 flexcan_priv *priv)
>  	struct flexcan_regs __iomem *regs =3D priv->regs;
>  	u32 iflag1, iflag2;
> =20
> -	iflag2 =3D priv->read(&regs->iflag2) & priv->reg_imask2_default &
> -		~FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
> -	iflag1 =3D priv->read(&regs->iflag1) & priv->reg_imask1_default;
> +	if (priv->tx_mb_idx >=3D FLEXCAN_IFLAG1_MB_NUM) {
> +		iflag2 =3D priv->read(&regs->iflag2) & priv->reg_imask2_default &
> +			~FLEXCAN_IFLAG2_MB(priv->tx_mb_idx);
> +		iflag1 =3D priv->read(&regs->iflag1) & priv->reg_imask1_default;
> +	} else {
> +		iflag2 =3D priv->read(&regs->iflag2) & priv->reg_imask2_default;
> +		iflag1 =3D priv->read(&regs->iflag1) & priv->reg_imask1_default &
> +			~FLEXCAN_IFLAG1_MB(priv->tx_mb_idx);
> +	}

I just noticed, that FLEXCAN_IFLAGx_MB(priv->tx_mb_idx) should already
be part of the corresponding imaskx_default. See flexcan_open(). So we
can remove it completely here, right?

> =20
>  	return (u64)iflag2 << 32 | iflag1;
>  }
> @@ -836,7 +844,8 @@ static irqreturn_t flexcan_irq(int irq, void *dev_i=
d)
>  	struct flexcan_priv *priv =3D netdev_priv(dev);
>  	struct flexcan_regs __iomem *regs =3D priv->regs;
>  	irqreturn_t handled =3D IRQ_NONE;
> -	u32 reg_iflag2, reg_esr;
> +	u32 reg_tx_iflag, tx_iflag_idx, reg_esr;

"tx_iflag_idx" is not an index (going from 0...63) but a bit-mask.

> +	void __iomem *reg_iflag;

"reg_iflag" is not a register but a pointer to a register, better rename
it. There is a "u64 reg_iflag" in the same function already, but in a
different scope. Why not make it a u32 instead of a void?

>  	enum can_state last_state =3D priv->can.state;
> =20
>  	/* reception interrupt */
> @@ -870,10 +879,18 @@ static irqreturn_t flexcan_irq(int irq, void *dev=
_id)
>  		}
>  	}
> =20
> -	reg_iflag2 =3D priv->read(&regs->iflag2);
> +	if (priv->tx_mb_idx >=3D FLEXCAN_IFLAG1_MB_NUM) {
> +		reg_tx_iflag =3D priv->read(&regs->iflag2);
> +		tx_iflag_idx =3D FLEXCAN_IFLAG2_MB(priv->tx_mb_idx);
> +		reg_iflag =3D &regs->iflag2;
> +	} else {
> +		reg_tx_iflag =3D priv->read(&regs->iflag1);
> +		tx_iflag_idx =3D FLEXCAN_IFLAG1_MB(priv->tx_mb_idx);
> +		reg_iflag =3D &regs->iflag1;
> +	}
> =20
>  	/* transmission complete interrupt */
> -	if (reg_iflag2 & FLEXCAN_IFLAG_MB(priv->tx_mb_idx)) {
> +	if (reg_tx_iflag & tx_iflag_idx) {
>  		u32 reg_ctrl =3D priv->read(&priv->tx_mb->can_ctrl);
> =20
>  		handled =3D IRQ_HANDLED;
> @@ -885,7 +902,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_i=
d)
>  		/* after sending a RTR frame MB is in RX mode */
>  		priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
>  			    &priv->tx_mb->can_ctrl);
> -		priv->write(FLEXCAN_IFLAG_MB(priv->tx_mb_idx), &regs->iflag2);
> +		priv->write(tx_iflag_idx, reg_iflag);
>  		netif_wake_queue(dev);
>  	}
> =20
> @@ -1244,8 +1261,13 @@ static int flexcan_open(struct net_device *dev)
>  	priv->tx_mb_idx =3D priv->mb_count - 1;
>  	priv->tx_mb =3D flexcan_get_mb(priv, priv->tx_mb_idx);
> =20
> -	priv->reg_imask1_default =3D 0;
> -	priv->reg_imask2_default =3D FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
> +	if (priv->tx_mb_idx >=3D FLEXCAN_IFLAG1_MB_NUM) {
> +		priv->reg_imask1_default =3D 0;
> +		priv->reg_imask2_default =3D FLEXCAN_IFLAG2_MB(priv->tx_mb_idx);
> +	} else {
> +		priv->reg_imask1_default =3D FLEXCAN_IFLAG1_MB(priv->tx_mb_idx);
> +		priv->reg_imask2_default =3D 0;
> +	}
> =20
>  	priv->offload.mailbox_read =3D flexcan_mailbox_read;
> =20
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--zgwkDLGLmV2tiDDHkTxnm9pBa7hK27aPF--

--rHzSW3w6iy4aDzcweX6WrcfMFAxHWKe9Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlx2mK0ACgkQWsYho5Hk
nSDItAf/Tatpm6THsskAxHwTjMqsWpGTrRfXyNO7aYTMa4m7Td0IEjmxQ3TLguN7
Zfuo4zdLHI0iEJQrA5tyxHHmtJLhztV58l/ZTZG8yzL05R1pklxfDFxL8/+5gxjm
T2bTcKJN/kKDYTYQloklUaTEQqZLt5RPIYNW3ByyAcEyDS21vhDq8aQ2JoAY9+VF
bvOQmmTBzFG+GMj8vm4u3B6Y7FYYu2F4/IRa3BtMdIV+ZpB6LlOLWEMCa+sCQp56
50YeFAXbHq+22CX8VnzPwL6xz3w41xfGbBVDD2PeC6pFR1PUiPwnpOpHJ8n7lRbk
tjTySTzgzp9jDVCS9XPjWH/kGeLi0g==
=KmaZ
-----END PGP SIGNATURE-----

--rHzSW3w6iy4aDzcweX6WrcfMFAxHWKe9Q--
