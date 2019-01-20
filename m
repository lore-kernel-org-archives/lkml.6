Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24F8C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772EA2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548058087;
	bh=5bq2cAZr0xE+c77reIx8cwZ3owwtr16n9PT0HGql00M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TKKv2cate8rWUQzajGri+r9cI+lGeem14Ow82h2BCRhY7NHji8YQnFJou27BksvCR
	 gmT2M222vVrn47zD/aLXKhBJacCowy8bJHtjE/aI6Tnj/oOPUQKz1VjWqbHfLaGZ/y
	 ADxCfpnCmAkF6a0tTXzAyouBfAGEYkjTrZX01JtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfAUIIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:08:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:49992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbfAUIH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:07:58 -0500
Received: from earth.universe (unknown [194.136.232.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84E362177E;
        Mon, 21 Jan 2019 01:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548032491;
        bh=5bq2cAZr0xE+c77reIx8cwZ3owwtr16n9PT0HGql00M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZKvBbP9khC8wJCDygVWRznx8t9ksIo/JT7K0BWW6ZO1S0DPvVBKrh9sSxOcVq+Yu
         KDD1q74Q9Q34z82grYeVp8KsqowX0LF8BYpK8yUAY/5nyxZpTPcEzgV+R0bxvuNFuQ
         zNn6oTb31pzaHsxRy/LFIDxad0vt1t/b5WpEe6pk=
Received: by earth.universe (Postfix, from userid 1000)
        id DC6A83C08E4; Sun, 20 Jan 2019 22:25:23 +0100 (CET)
Date:   Sun, 20 Jan 2019 22:25:23 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: isp1704: switch to gpiod API
Message-ID: <20190120212523.5f4zovssz6vihxsf@earth.universe>
References: <20181213013858.23996-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="esxcvnyauucu4vms"
Content-Disposition: inline
In-Reply-To: <20181213013858.23996-1-sebastian.reichel@collabora.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--esxcvnyauucu4vms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 13, 2018 at 02:38:58AM +0100, Sebastian Reichel wrote:
> This migrates isp1704 driver from old GPIO API to new descriptor
> based GPIO API and drops useless platform data as a side-effect.
>=20
> Migration is simple, since all mainline users are DT based and
> DT API does not change. Out of tree users of the platform data
> need to migrate to gpiod_lookup_table as described here:
>=20
> Documentation/driver-api/gpio/board.rst
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> Patch has been tested on Nokia N900.
> ---

Queued to power-supply-next.

-- Sebastian

>  drivers/power/supply/isp1704_charger.c | 60 ++++++--------------------
>  include/linux/power/isp1704_charger.h  | 30 -------------
>  2 files changed, 12 insertions(+), 78 deletions(-)
>  delete mode 100644 include/linux/power/isp1704_charger.h
>=20
> diff --git a/drivers/power/supply/isp1704_charger.c b/drivers/power/suppl=
y/isp1704_charger.c
> index 95af5f305838..a63cb5dcfa08 100644
> --- a/drivers/power/supply/isp1704_charger.c
> +++ b/drivers/power/supply/isp1704_charger.c
> @@ -30,13 +30,12 @@
>  #include <linux/power_supply.h>
>  #include <linux/delay.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
> =20
> +#include <linux/gpio/consumer.h>
>  #include <linux/usb/otg.h>
>  #include <linux/usb/ulpi.h>
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
> -#include <linux/power/isp1704_charger.h>
> =20
>  /* Vendor specific Power Control register */
>  #define ISP1704_PWR_CTRL		0x3d
> @@ -60,6 +59,7 @@ struct isp1704_charger {
>  	struct device			*dev;
>  	struct power_supply		*psy;
>  	struct power_supply_desc	psy_desc;
> +	struct gpio_desc		*enable_gpio;
>  	struct usb_phy			*phy;
>  	struct notifier_block		nb;
>  	struct work_struct		work;
> @@ -81,18 +81,9 @@ static inline int isp1704_write(struct isp1704_charger=
 *isp, u32 reg, u32 val)
>  	return usb_phy_io_write(isp->phy, val, reg);
>  }
> =20
> -/*
> - * Disable/enable the power from the isp1704 if a function for it
> - * has been provided with platform data.
> - */
>  static void isp1704_charger_set_power(struct isp1704_charger *isp, bool =
on)
>  {
> -	struct isp1704_charger_data	*board =3D isp->dev->platform_data;
> -
> -	if (board && board->set_power)
> -		board->set_power(on);
> -	else if (board)
> -		gpio_set_value(board->enable_gpio, on);
> +	gpiod_set_value(isp->enable_gpio, on);
>  }
> =20
>  /*
> @@ -405,46 +396,19 @@ static int isp1704_charger_probe(struct platform_de=
vice *pdev)
>  	int			ret =3D -ENODEV;
>  	struct power_supply_config psy_cfg =3D {};
> =20
> -	struct isp1704_charger_data *pdata =3D dev_get_platdata(&pdev->dev);
> -	struct device_node *np =3D pdev->dev.of_node;
> -
> -	if (np) {
> -		int gpio =3D of_get_named_gpio(np, "nxp,enable-gpio", 0);
> -
> -		if (gpio < 0) {
> -			dev_err(&pdev->dev, "missing DT GPIO nxp,enable-gpio\n");
> -			return gpio;
> -		}
> -
> -		pdata =3D devm_kzalloc(&pdev->dev,
> -			sizeof(struct isp1704_charger_data), GFP_KERNEL);
> -		if (!pdata) {
> -			ret =3D -ENOMEM;
> -			goto fail0;
> -		}
> -		pdata->enable_gpio =3D gpio;
> -
> -		dev_info(&pdev->dev, "init gpio %d\n", pdata->enable_gpio);
> -
> -		ret =3D devm_gpio_request_one(&pdev->dev, pdata->enable_gpio,
> -					GPIOF_OUT_INIT_HIGH, "isp1704_reset");
> -		if (ret) {
> -			dev_err(&pdev->dev, "gpio request failed\n");
> -			goto fail0;
> -		}
> -	}
> -
> -	if (!pdata) {
> -		dev_err(&pdev->dev, "missing platform data!\n");
> -		return -ENODEV;
> -	}
> -
> -
>  	isp =3D devm_kzalloc(&pdev->dev, sizeof(*isp), GFP_KERNEL);
>  	if (!isp)
>  		return -ENOMEM;
> =20
> -	if (np)
> +	isp->enable_gpio =3D devm_gpiod_get(&pdev->dev, "nxp,enable",
> +					  GPIOD_OUT_HIGH);
> +	if (IS_ERR(isp->enable_gpio)) {
> +		ret =3D PTR_ERR(isp->enable_gpio);
> +		dev_err(&pdev->dev, "Could not get reset gpio: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (pdev->dev.of_node)
>  		isp->phy =3D devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy", 0);
>  	else
>  		isp->phy =3D devm_usb_get_phy(&pdev->dev, USB_PHY_TYPE_USB2);
> diff --git a/include/linux/power/isp1704_charger.h b/include/linux/power/=
isp1704_charger.h
> deleted file mode 100644
> index 0105d9e7af85..000000000000
> --- a/include/linux/power/isp1704_charger.h
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -/*
> - * ISP1704 USB Charger Detection driver
> - *
> - * Copyright (C) 2011 Nokia Corporation
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 U=
SA
> - */
> -
> -
> -#ifndef __ISP1704_CHARGER_H
> -#define __ISP1704_CHARGER_H
> -
> -struct isp1704_charger_data {
> -	void		(*set_power)(bool on);
> -	int		enable_gpio;
> -};
> -
> -#endif
> --=20
> 2.19.2
>=20

--esxcvnyauucu4vms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxE50MACgkQ2O7X88g7
+po4pQ//e7qYawTJsbwZB3WKbzbyGC//u56PvmGvU5awFJU4142TTZDh0ABBCBEJ
2yxrQ1WvND1s0IoLfxgni1M6hI+FZKPjunoFDvCR1WrubATnRLwp+BN7l9CPJ/um
LPDeNd60JsQg/p+Lp7t80by+aD8D3XJZ6ZSHuf2gY084FwKuJKiG203FHyvRrfBa
m+ofyg4EdIkbuVQfEXM80F2X9W1emHLNN5faY3lBv4G5YoKh3egt53b5B5yUOh83
1/zzseS67GVMrFMpflRkiJDitT1J59ILuZWM03RyMV6OdYRdejFIzbr7dqNrhRY6
EevsB4IdwNvu0eGOo7lN2F9vm0nUSUJOeRrkr9i6vMF2mHVC1rdOc86RuOXU2Rbv
EPk/duhN7xdj9LWIznPf+aGVr1/n3jEyZUZnoB5U6dl9LSrTxZuVme1NMwsRR4+T
DIwx2a0/KDPiD72SynVLIhqnSr5ucoTcHRLSnbEdL5N7GGVu7PNQAstS//XEFBox
FR4kh5AlhszgmhVj0O0lvmq2xoBByDeyjzL5aEcR3/4EjMiGvS2pSreZ0Teulzly
xbi+N+E7JGmI4tjkQRSe0xeFtr5MIFbdrGwwDIc9QCdCPakcGuwnyjwm0rWzTkfp
uhrRmSSOjdSjr5zD+pbK8YXvcwlI5KXOLDI8v2g51IubBz2FAwY=
=X9W9
-----END PGP SIGNATURE-----

--esxcvnyauucu4vms--
