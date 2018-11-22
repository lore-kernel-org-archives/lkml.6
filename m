Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F04AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5A720820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5A720820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393606AbeKVU1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:27:36 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44189 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731614AbeKVU1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:27:36 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mkl@pengutronix.de>)
        id 1gPlbM-0002iT-Vy; Thu, 22 Nov 2018 10:48:49 +0100
Received: from [IPv6:2a03:f580:87bc:d400:e586:a438:6bdb:ffff] (unknown [IPv6:2a03:f580:87bc:d400:e586:a438:6bdb:ffff])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D759F3930B7;
        Thu, 22 Nov 2018 09:48:46 +0000 (UTC)
Subject: Re: [PATCH V3 1/1] can: flexcan: Add self wakeup support
To:     Aisheng DONG <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc:     "wg@grandegger.com" <wg@grandegger.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <20181112015047.4252-1-qiangqing.zhang@nxp.com>
 <20181112015047.4252-2-qiangqing.zhang@nxp.com>
 <AM0PR04MB4211BE08EADBACBEC809067E80DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <af4e2030-c54d-d613-972a-25769bdff199@pengutronix.de>
Date:   Thu, 22 Nov 2018 10:48:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4211BE08EADBACBEC809067E80DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="G0kngbWH7G2O2MlycfNMuLUIXASNLH0P7"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G0kngbWH7G2O2MlycfNMuLUIXASNLH0P7
Content-Type: multipart/mixed; boundary="JVY2nIkGkeQm1dy3xSsTS4CdweqetRit1";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Aisheng DONG <aisheng.dong@nxp.com>,
 Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>
Message-ID: <af4e2030-c54d-d613-972a-25769bdff199@pengutronix.de>
Subject: Re: [PATCH V3 1/1] can: flexcan: Add self wakeup support
References: <20181112015047.4252-1-qiangqing.zhang@nxp.com>
 <20181112015047.4252-2-qiangqing.zhang@nxp.com>
 <AM0PR04MB4211BE08EADBACBEC809067E80DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211BE08EADBACBEC809067E80DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>

--JVY2nIkGkeQm1dy3xSsTS4CdweqetRit1
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/21/18 4:34 AM, Aisheng DONG wrote:
>> -----Original Message-----
>> From: Joakim Zhang
> [...]
>>
>> If wakeup is enabled, enter stop mode, else enter disabled mode.Self w=
ake can
>> only work on stop mode.
>>
>> Starting from IMX6, the flexcan stop mode control bits is SoC specific=
, move it
>> out of IP driver and parse it from devicetree.
>>
>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
>> ---
>>  drivers/net/can/flexcan.c | 175
>> +++++++++++++++++++++++++++++++++++---
>>  1 file changed, 163 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c ind=
ex
>> 3813f6708201..d21d0db8c83e 100644
>> --- a/drivers/net/can/flexcan.c
>> +++ b/drivers/net/can/flexcan.c
>> @@ -19,12 +19,17 @@
>>  #include <linux/delay.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/list.h>
>=20
> This two lines seems not neccesary
>=20
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/regulator/consumer.h>
>> +#include <linux/regmap.h>
>>
>>  #define DRV_NAME			"flexcan"
>>
>> @@ -132,7 +137,8 @@
>>  	(FLEXCAN_ESR_ERR_BUS | FLEXCAN_ESR_ERR_STATE)  #define
>> FLEXCAN_ESR_ALL_INT \
>>  	(FLEXCAN_ESR_TWRN_INT | FLEXCAN_ESR_RWRN_INT | \
>> -	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
>> +	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
>> +	 FLEXCAN_ESR_WAK_INT)
>>
>>  /* FLEXCAN interrupt flag register (IFLAG) bits */
>>  /* Errata ERR005829 step7: Reserve first valid MB */ @@ -191,6 +197,7=
 @@
>>  #define FLEXCAN_QUIRK_USE_OFF_TIMESTAMP	BIT(5) /* Use timestamp
>> based offloading */
>>  #define FLEXCAN_QUIRK_BROKEN_PERR_STATE	BIT(6) /* No interrupt for
>> error passive */
>>  #define FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN	BIT(7) /* default to BE
>> register access */
>> +#define FLEXCAN_QUIRK_SETUP_STOP_MODE	BIT(8) /* Setup stop mode to
>> support wakeup */
>>
>>  /* Structure of the message buffer */
>>  struct flexcan_mb {
>> @@ -255,6 +262,14 @@ struct flexcan_devtype_data {
>>  	u32 quirks;		/* quirks needed for different IP cores */
>>  };
>>
>> +struct flexcan_stop_mode {
>> +	struct regmap *gpr;
>> +	u8 req_gpr;
>> +	u8 req_bit;
>> +	u8 ack_gpr;
>> +	u8 ack_bit;
>> +};
>> +
>>  struct flexcan_priv {
>>  	struct can_priv can;
>>  	struct can_rx_offload offload;
>> @@ -272,6 +287,7 @@ struct flexcan_priv {
>>  	struct clk *clk_per;
>>  	const struct flexcan_devtype_data *devtype_data;
>>  	struct regulator *reg_xceiver;
>> +	struct flexcan_stop_mode stm;
>>
>>  	/* Read and Write APIs */
>>  	u32 (*read)(void __iomem *addr);
>> @@ -295,7 +311,8 @@ static const struct flexcan_devtype_data
>> fsl_imx28_devtype_data =3D {
>>
>>  static const struct flexcan_devtype_data fsl_imx6q_devtype_data =3D {=

>>  	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG |
>> FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
>> -		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
>> FLEXCAN_QUIRK_BROKEN_PERR_STATE,
>> +		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
>> FLEXCAN_QUIRK_BROKEN_PERR_STATE |
>> +		FLEXCAN_QUIRK_SETUP_STOP_MODE,
>>  };
>>
>>  static const struct flexcan_devtype_data fsl_vf610_devtype_data =3D {=
 @@
>> -392,6 +409,40 @@ static void flexcan_clks_disable(const struct flexca=
n_priv
>> *priv)
>>  	clk_disable_unprepare(priv->clk_per);
>>  }
>>
>> +static void flexcan_wake_mask_enable(struct flexcan_priv *priv) {
>> +	struct flexcan_regs __iomem *regs =3D priv->regs;
>> +	u32 reg_mcr;
>> +
>> +	reg_mcr =3D priv->read(&regs->mcr);
>> +	reg_mcr |=3D FLEXCAN_MCR_WAK_MSK;
>> +	priv->write(reg_mcr, &regs->mcr);
>> +}
>> +
>> +static void flexcan_wake_mask_disable(struct flexcan_priv *priv) {
>> +	struct flexcan_regs __iomem *regs =3D priv->regs;
>> +	u32 reg_mcr;
>> +
>> +	reg_mcr =3D priv->read(&regs->mcr);
>> +	reg_mcr &=3D ~FLEXCAN_MCR_WAK_MSK;
>> +	priv->write(reg_mcr, &regs->mcr);
>> +}
>> +
>=20
> Please combine those two functions into one, also improve the name a bi=
t.
> e.g.
> flexcan_enable_wakeup_irq(struct flexcan_priv *priv, bool enable)
>=20
>> +static inline void flexcan_enter_stop_mode(struct flexcan_priv *priv)=
 {
>> +	/* enable stop request */
>> +	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
>> +						1 << priv->stm.req_bit, 1 << priv->stm.req_bit); }
>> +
>> +static inline void flexcan_exit_stop_mode(struct flexcan_priv *priv) =
{
>> +	/* remove stop request */
>> +	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
>> +						1 << priv->stm.req_bit, 0);
>> +}
>> +
>>  static inline int flexcan_transceiver_enable(const struct flexcan_pri=
v *priv)  {
>>  	if (!priv->reg_xceiver)
>> @@ -955,6 +1006,10 @@ static int flexcan_chip_start(struct net_device =
*dev)
>>  		reg_mcr |=3D FLEXCAN_MCR_FEN |
>>  			FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
>>  	}
>> +
>> +	/* enable self wakeup */
>> +	reg_mcr |=3D FLEXCAN_MCR_SLF_WAK;
>> +
>=20
> Should we check before setting as we already have a SETUP_STOP_MODE qui=
rk?
>=20
>>  	netdev_dbg(dev, "%s: writing mcr=3D0x%08x", __func__, reg_mcr);
>>  	priv->write(reg_mcr, &regs->mcr);
>>
>> @@ -1240,6 +1295,60 @@ static void unregister_flexcandev(struct net_de=
vice
>> *dev)
>>  	unregister_candev(dev);
>>  }
>>
>> +static int flexcan_setup_stop_mode(struct platform_device *pdev) {
>> +	struct net_device *dev =3D platform_get_drvdata(pdev);
>> +	struct device_node *np =3D pdev->dev.of_node;
>> +	struct device_node *node;
>=20
> Probably gpr_np is better.
>=20
>> +	struct flexcan_priv *priv;
>> +	bool wakeup =3D true;
>> +	phandle phandle;
>> +	u32 out_val[5];
>> +	int ret;
>> +
>> +	if (!np)
>> +		return -EINVAL;
>> +
>> +	/* stop mode property format is:
>> +	 * <&gpr req_gpr req_bit ack_gpr ack_bit>.
>> +	 */
>> +	ret =3D of_property_read_u32_array(np, "fsl,stop-mode", out_val, 5);=

>> +	if (ret) {
>> +		dev_dbg(&pdev->dev, "no stop-mode property\n");
>> +		return ret;
>> +	}
>> +	phandle =3D *out_val;
>> +
>> +	node =3D of_find_node_by_phandle(phandle);
>> +	if (!node) {
>> +		dev_dbg(&pdev->dev, "could not find gpr node by phandle\n");
>> +		return PTR_ERR(node);
>> +	}
>> +
>> +	priv =3D netdev_priv(dev);
>> +	priv->stm.gpr =3D syscon_node_to_regmap(node);
>> +	if (IS_ERR(priv->stm.gpr)) {
>> +		dev_dbg(&pdev->dev, "could not find gpr regmap\n");
>> +		return PTR_ERR(priv->stm.gpr);
>> +	}
>> +
>> +	of_node_put(node);
>> +
>> +	priv->stm.req_gpr =3D out_val[1];
>> +	priv->stm.req_bit =3D out_val[2];
>> +	priv->stm.ack_gpr =3D out_val[3];
>> +	priv->stm.ack_bit =3D out_val[4];
>> +
>> +	dev_dbg(&pdev->dev, "gpr %s req_gpr 0x%x req_bit %u ack_gpr 0x%x
>> ack_bit %u\n",
>> +			node->full_name, priv->stm.req_gpr,
>> +			priv->stm.req_bit, priv->stm.ack_gpr,
>> +			priv->stm.ack_bit);
>> +
>> +	device_set_wakeup_capable(&pdev->dev, wakeup);
>=20
> If 'wakeup' variable is not changeable, then not need use it.
>=20
>> +
>> +	return 0;
>> +}
>> +
>>  static const struct of_device_id flexcan_of_match[] =3D {
>>  	{ .compatible =3D "fsl,imx6q-flexcan", .data =3D &fsl_imx6q_devtype_=
data, },
>>  	{ .compatible =3D "fsl,imx28-flexcan", .data =3D &fsl_imx28_devtype_=
data, },
>> @@ -1400,6 +1509,12 @@ static int flexcan_probe(struct platform_device=

>> *pdev)
>>
>>  	devm_can_led_init(dev);
>>
>> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE) {
>> +		err =3D flexcan_setup_stop_mode(pdev);
>> +		if (err)
>> +			dev_dbg(&pdev->dev, "failed to setup stop-mode\n");
>> +	}
>> +
>>  	pm_runtime_put(&pdev->dev);
>>
>>  	dev_info(&pdev->dev, "device registered (reg_base=3D%p, irq=3D%d)\n"=
, @@
>> -1437,10 +1552,18 @@ static int __maybe_unused flexcan_suspend(struct
>> device *device)
>>  	int err =3D 0;
>>
>>  	if (netif_running(dev)) {
>> -		err =3D flexcan_chip_disable(priv);
>> -		if (err)
>> -			return err;
>> -		err =3D pm_runtime_force_suspend(device);
>> +		/* if wakeup is enabled, enter stop mode
>> +		 * else enter disabled mode.
>> +		 */
>> +		if (device_may_wakeup(device)) {
>> +			enable_irq_wake(dev->irq);
>> +			flexcan_enter_stop_mode(priv);
>> +		} else {
>> +			err =3D flexcan_chip_disable(priv);
>> +			if (err)
>> +				return err;
>> +			err =3D pm_runtime_force_suspend(device);
>=20
> This is mixed with runtime pm.
> I would suggestion you first upstream wakeup support.
> Then runtime pm later separately.

In fact this patch is based on the patch "can: flexcan: Implement CAN
Runtime PM", which is still under review, too.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--JVY2nIkGkeQm1dy3xSsTS4CdweqetRit1--

--G0kngbWH7G2O2MlycfNMuLUIXASNLH0P7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlv2e3sACgkQk9IU1zQo
ZfEDqQf9F/M5v2BLffCu4Lydka09jXYOPmTcwrHeHxSZcmrKQazOQ3pmdiBDVBaS
rrNmjnlod4OlPo5BNDXJ5zpFk6So+MJKDG1Je3gWs7uAGlK6IoKLeC1gaw+gaBOS
0JexweSB0KkNKLLYlGuGLO6OmnXEPA2ALgG7S3ulVvfETZKueMg24OUTSIcRTp/X
Z08FKydIPCbs3s/zdayAJidJBaKc5ZGVGDW/yaDKDtESuKZj37YgC14MjePKHL79
Vp0GPwxhkBx4I9qHB3ff8DuLQiXDFnsvX2Kar3iysGY73hGjUhaQT6qOeI+dX7V+
BRoRH/J2y9AGqExcQPtrNzxXzht/9Q==
=sAZZ
-----END PGP SIGNATURE-----

--G0kngbWH7G2O2MlycfNMuLUIXASNLH0P7--
