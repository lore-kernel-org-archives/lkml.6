Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2893EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60B921904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPMtHJgJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfBGMRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:17:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32833 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfBGMRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:17:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id a16so11348302wrv.0;
        Thu, 07 Feb 2019 04:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7II38q0kmmyohaOEalomjTBU+FXVkZ+3btNGehaQuuo=;
        b=KPMtHJgJm8ZmdRVgE0a98r9ylcPVjTcAPwkXQsvUsN0P/91oD8RpVEKmvCP0tn/tbC
         9axkhxafldv0GD2Bok2D5NMHk1PGJPOrx9tXICsU9JAvAE1fsaGL9PHTjWPUssnbqpEk
         hwlV4SxEurKmZqcZ8wabUNno/wkAvEpVDIe+XSrDbofycA+Qmlqea6O8IDBYP05ra451
         ZeHYu3+cVp0vSxvZ3eSvjAao4DLq7X5A1LjzMQBkUig5NMOCY3d2KyW3qLat8Gp3l6Zx
         g3ZUwtJS4HP29egyQ2QtPHSap9I2iNKDAXpySzLtgy/S5iLQiPcxyymBbIrW1sRLJu1j
         JWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7II38q0kmmyohaOEalomjTBU+FXVkZ+3btNGehaQuuo=;
        b=rHH4rUFAX6NCv4apmeMuT7F/mtGy0ScQ0zly299jUXuZUAnLbdafFlPyLAxJlOeghu
         P0os0bvU9yWhjN1X6La+D9PrCrQdQ3CBpy3c1I21emG5nG6Lac/AoMeuy7dyRL1btEQq
         zYDCQ0utAUkrZnnI/1ItasmFkQtLvjcvvBOD287fPvRGzfvDABMePN/l17N3SMr4hN3y
         ePkmYOITew1qgW0HgNigg2HrETKiTl8b8NuR/dVzEKJJY+8UCcT0OY2hgVWsmKdM0FUe
         c7W34BHxVXsbzixW50echCsYGE0y7mUzuskyhhx4TxZD4MRA+ax8mOiUaQaRru5T/0YZ
         Z+ng==
X-Gm-Message-State: AHQUAuY1+7ko8eZde9Gitjj7Kvq652lXch27ZdORYzmuKvHNzYOLIMtU
        9Jwqfz6XKKpNJlb9eQSmW8SxLEIcC8Y=
X-Google-Smtp-Source: AHgI3Ia+ewNXq4q2nz2KxVSfU2pu53Nk0pYGB8ahxxz5mRKazqIPXhsLkCffilLi962dcrMLjT6Enw==
X-Received: by 2002:adf:d146:: with SMTP id b6mr12259272wri.156.1549541856252;
        Thu, 07 Feb 2019 04:17:36 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id x3sm32848619wrd.19.2019.02.07.04.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 04:17:35 -0800 (PST)
Date:   Thu, 7 Feb 2019 13:17:34 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] phy: tegra: xusb: Add Tegra186 support
Message-ID: <20190207121734.GA8274@ulmo>
References: <20190125112525.10697-1-thierry.reding@gmail.com>
 <20190125112525.10697-5-thierry.reding@gmail.com>
 <f6f3415c-56a7-e361-e9b3-8d86fab3a211@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <f6f3415c-56a7-e361-e9b3-8d86fab3a211@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 05:17:59PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
>=20
> On 25/01/19 4:55 PM, Thierry Reding wrote:
> > From: JC Kuo <jckuo@nvidia.com>
> >=20
> > Add support for the XUSB pad controller found on Tegra186 SoCs. It is
> > mostly similar to the same IP found on earlier chips, but the number of
> > pads exposed differs, as do the programming sequences.
> >=20
> > Note that the DVDD_PEX, DVDD_PEX_PLL, HVDD_PEX and HVDD_PEX_PLL power
> > supplies of the XUSB pad controller require strict power sequencing and
> > are therefore controlled by the PMIC on Tegra186.
> >=20
> > Signed-off-by: JC Kuo <jckuo@nvidia.com>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  MAINTAINERS                       |   5 +
> >  drivers/phy/tegra/Makefile        |   1 +
> >  drivers/phy/tegra/xusb-tegra186.c | 908 ++++++++++++++++++++++++++++++
> >  drivers/phy/tegra/xusb.c          |   6 +
> >  drivers/phy/tegra/xusb.h          |  27 +
> >  5 files changed, 947 insertions(+)
> >  create mode 100644 drivers/phy/tegra/xusb-tegra186.c
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ddcdc29dfe1f..754f7e757361 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15099,6 +15099,11 @@ M:	Laxman Dewangan <ldewangan@nvidia.com>
> >  S:	Supported
> >  F:	drivers/spi/spi-tegra*
> > =20
> > +TEGRA XUSB PADCTL DRIVER
> > +M:	JC Kuo <jckuo@nvidia.com>
> > +S:	Supported
> > +F:	drivers/phy/tegra/xusb*
> > +
> >  TEHUTI ETHERNET DRIVER
> >  M:	Andy Gospodarek <andy@greyhouse.net>
> >  L:	netdev@vger.kernel.org
> > diff --git a/drivers/phy/tegra/Makefile b/drivers/phy/tegra/Makefile
> > index 898589238fd9..a93cd9a499b2 100644
> > --- a/drivers/phy/tegra/Makefile
> > +++ b/drivers/phy/tegra/Makefile
> > @@ -4,3 +4,4 @@ phy-tegra-xusb-y +=3D xusb.o
> >  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_124_SOC) +=3D xusb-tegra124.o
> >  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_132_SOC) +=3D xusb-tegra124.o
> >  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_210_SOC) +=3D xusb-tegra210.o
> > +phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_186_SOC) +=3D xusb-tegra186.o
> > diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb=
-tegra186.c
> > new file mode 100644
> > index 000000000000..0dbcaddade90
> > --- /dev/null
> > +++ b/drivers/phy/tegra/xusb-tegra186.c
> > @@ -0,0 +1,908 @@
> > +/*
> > + * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but WITH=
OUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
> > + * more details.
> > + */
>=20
> please use SPDX license format.

Done.

> > +
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/clk.h>
> > +#include <linux/slab.h>
> > +
> > +#include <soc/tegra/fuse.h>
> > +
> > +#include "xusb.h"
> > +
> > +/* FUSE USB_CALIB registers */
> > +#define HS_CURR_LEVEL_PADX_SHIFT(x)	((x) ? (11 + (x - 1) * 6) : 0)
> > +#define HS_CURR_LEVEL_PAD_MASK		0x3f
> > +#define HS_TERM_RANGE_ADJ_SHIFT		7
> > +#define HS_TERM_RANGE_ADJ_MASK		0xf
> > +#define HS_SQUELCH_SHIFT		29
> > +#define HS_SQUELCH_MASK			0x7
> > +
> > +#define RPD_CTRL_SHIFT			0
> > +#define RPD_CTRL_MASK			0x1f
> > +
> > +/* XUSB PADCTL registers */
> > +#define XUSB_PADCTL_USB2_PAD_MUX	0x4
> > +#define  USB2_PORT_SHIFT(x)		((x) * 2)
> > +#define  USB2_PORT_MASK			0x3
> > +#define   PORT_XUSB			1
> > +#define  HSIC_PORT_SHIFT(x)		((x) + 20)
> > +#define  HSIC_PORT_MASK			0x1
> > +#define   PORT_HSIC			0
> > +
> > +#define XUSB_PADCTL_USB2_PORT_CAP	0x8
> > +#define XUSB_PADCTL_SS_PORT_CAP		0xc
> > +#define  PORTX_CAP_SHIFT(x)		((x) * 4)
> > +#define  PORT_CAP_MASK			0x3
> > +#define   PORT_CAP_DISABLED		0x0
> > +#define   PORT_CAP_HOST			0x1
> > +#define   PORT_CAP_DEVICE		0x2
> > +#define   PORT_CAP_OTG			0x3
> > +
> > +#define XUSB_PADCTL_ELPG_PROGRAM		0x20
> > +#define  USB2_PORT_WAKE_INTERRUPT_ENABLE(x)		(1 << (x))
>=20
> Use BIT() macros here and below

Done.

> > +#define  USB2_PORT_WAKEUP_EVENT(x)		(	1 << ((x) + 7))
> > +#define  SS_PORT_WAKE_INTERRUPT_ENABLE(x)		(1 << ((x) + 14))
> > +#define  SS_PORT_WAKEUP_EVENT(x)			(1 << ((x) + 21))
> > +#define  USB2_HSIC_PORT_WAKE_INTERRUPT_ENABLE(x)	(1 << ((x) + 28))
> > +#define  USB2_HSIC_PORT_WAKEUP_EVENT(x)			(1 << ((x) + 30))
> > +#define  ALL_WAKE_EVENTS						\
> > +	(USB2_PORT_WAKEUP_EVENT(0) | USB2_PORT_WAKEUP_EVENT(1) |	\
> > +	USB2_PORT_WAKEUP_EVENT(2) | SS_PORT_WAKEUP_EVENT(0) |		\
> > +	SS_PORT_WAKEUP_EVENT(1) | SS_PORT_WAKEUP_EVENT(2) |		\
> > +	USB2_HSIC_PORT_WAKEUP_EVENT(0))
> > +
> > +#define XUSB_PADCTL_ELPG_PROGRAM_1		0x24
> > +#define  SSPX_ELPG_CLAMP_EN(x)			(1 << (0 + (x) * 3))
> > +#define  SSPX_ELPG_CLAMP_EN_EARLY(x)		(1 << (1 + (x) * 3))
> > +#define  SSPX_ELPG_VCORE_DOWN(x)		(1 << (2 + (x) * 3))
> > +
> > +#define XUSB_PADCTL_USB2_OTG_PADX_CTL0(x)	(0x88 + (x) * 0x40)
> > +#define  HS_CURR_LEVEL(x)			((x) & 0x3f)
> > +#define  TERM_SEL				(1 << 25)
> > +#define  USB2_OTG_PD				(1 << 26)
> > +#define  USB2_OTG_PD2				(1 << 27)
> > +#define  USB2_OTG_PD2_OVRD_EN			(1 << 28)
> > +#define  USB2_OTG_PD_ZI				(1 << 29)
> > +
> > +#define XUSB_PADCTL_USB2_OTG_PADX_CTL1(x)	(0x8c + (x) * 0x40)
> > +#define  USB2_OTG_PD_DR				(1 << 2)
> > +#define  TERM_RANGE_ADJ(x)			(((x) & 0xf) << 3)
> > +#define  RPD_CTRL(x)				(((x) & 0x1f) << 26)
> > +
> > +#define XUSB_PADCTL_USB2_BIAS_PAD_CTL0		0x284
> > +#define  BIAS_PAD_PD				(1 << 11)
> > +#define  HS_SQUELCH_LEVEL(x)			(((x) & 0x7) << 0)
> > +
> > +#define XUSB_PADCTL_USB2_BIAS_PAD_CTL1		0x288
> > +#define  USB2_TRK_START_TIMER(x)		(((x) & 0x7f) << 12)
> > +#define  USB2_TRK_DONE_RESET_TIMER(x)		(((x) & 0x7f) << 19)
> > +#define  USB2_PD_TRK				(1 << 26)
> > +
> > +#define XUSB_PADCTL_HSIC_PADX_CTL0(x)		(0x300 + (x) * 0x20)
> > +#define  HSIC_PD_TX_DATA0			(1 << 1)
> > +#define  HSIC_PD_TX_STROBE			(1 << 3)
> > +#define  HSIC_PD_RX_DATA0			(1 << 4)
> > +#define  HSIC_PD_RX_STROBE			(1 << 6)
> > +#define  HSIC_PD_ZI_DATA0			(1 << 7)
> > +#define  HSIC_PD_ZI_STROBE			(1 << 9)
> > +#define  HSIC_RPD_DATA0				(1 << 13)
> > +#define  HSIC_RPD_STROBE			(1 << 15)
> > +#define  HSIC_RPU_DATA0				(1 << 16)
> > +#define  HSIC_RPU_STROBE			(1 << 18)
> > +
> > +#define XUSB_PADCTL_HSIC_PAD_TRK_CTL0		(0x340)
>=20
> unnecessary ().

Done.

> > +#define  HSIC_TRK_START_TIMER(x)		(((x) & 0x7f) << 5)
> > +#define  HSIC_TRK_DONE_RESET_TIMER(x)		(((x) & 0x7f) << 12)
> > +#define  HSIC_PD_TRK				(1 << 19)
> > +
> > +#define USB2_VBUS_ID				(0x360)
>=20
> here too..

Done.

> > +#define  VBUS_OVERRIDE				(1 << 14)
> > +#define  ID_OVERRIDE(x)			(((x) & 0xf) << 18)
> > +#define  ID_OVERRIDE_FLOATING			ID_OVERRIDE(8)
> > +#define  ID_OVERRIDE_GROUNDED			ID_OVERRIDE(0)
> > +
> > +#define TEGRA186_LANE(_name, _offset, _shift, _mask, _type)		\
> > +	{								\
> > +		.name =3D _name,						\
> > +		.offset =3D _offset,					\
> > +		.shift =3D _shift,					\
> > +		.mask =3D _mask,						\
> > +		.num_funcs =3D ARRAY_SIZE(tegra186_##_type##_functions),	\
> > +		.funcs =3D tegra186_##_type##_functions,			\
> > +	}
> > +
> > +struct tegra_xusb_fuse_calibration {
> > +	u32 *hs_curr_level;
> > +	u32 hs_squelch;
> > +	u32 hs_term_range_adj;
> > +	u32 rpd_ctrl;
> > +};
> > +
> > +struct tegra186_xusb_padctl {
> > +	struct tegra_xusb_padctl base;
> > +
> > +	struct tegra_xusb_fuse_calibration calib;
> > +
> > +	/* UTMI bias and tracking */
> > +	struct clk *usb2_trk_clk;
> > +	unsigned int bias_pad_enable;
> > +};
> > +
> > +static inline struct tegra186_xusb_padctl *
> > +to_tegra186_xusb_padctl(struct tegra_xusb_padctl *padctl)
> > +{
> > +	return container_of(padctl, struct tegra186_xusb_padctl, base);
> > +}
> > +
> > +/* USB 2.0 UTMI PHY support */
> > +static struct tegra_xusb_lane *
> > +tegra186_usb2_lane_probe(struct tegra_xusb_pad *pad, struct device_nod=
e *np,
> > +			 unsigned int index)
> > +{
> > +	struct tegra_xusb_usb2_lane *usb2;
> > +	int err;
> > +
> > +	usb2 =3D kzalloc(sizeof(*usb2), GFP_KERNEL);
> > +	if (!usb2)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	INIT_LIST_HEAD(&usb2->base.list);
> > +	usb2->base.soc =3D &pad->soc->lanes[index];
> > +	usb2->base.index =3D index;
> > +	usb2->base.pad =3D pad;
> > +	usb2->base.np =3D np;
> > +
> > +	err =3D tegra_xusb_lane_parse_dt(&usb2->base, np);
> > +	if (err < 0) {
> > +		kfree(usb2);
> > +		return ERR_PTR(err);
> > +	}
> > +
> > +	return &usb2->base;
> > +}
> > +
> > +static void tegra186_usb2_lane_remove(struct tegra_xusb_lane *lane)
> > +{
> > +	struct tegra_xusb_usb2_lane *usb2 =3D to_usb2_lane(lane);
> > +
> > +	kfree(usb2);
> > +}
> > +
> > +static const struct tegra_xusb_lane_ops tegra186_usb2_lane_ops =3D {
> > +	.probe =3D tegra186_usb2_lane_probe,
> > +	.remove =3D tegra186_usb2_lane_remove,
> > +};
> > +
> > +static void tegra186_utmi_bias_pad_power_on(struct tegra_xusb_padctl *=
padctl)
> > +{
> > +	struct tegra186_xusb_padctl *priv =3D to_tegra186_xusb_padctl(padctl);
> > +	struct device *dev =3D padctl->dev;
> > +	u32 value;
> > +	int err;
> > +
> > +	mutex_lock(&padctl->lock);
> > +
> > +	if (priv->bias_pad_enable++ > 0) {
> > +		mutex_unlock(&padctl->lock);
> > +		return;
> > +	}
> > +
> > +	err =3D clk_prepare_enable(priv->usb2_trk_clk);
> > +	if (err < 0)
> > +		dev_warn(dev, "failed to enable USB2 trk clock: %d\n", err);
> > +
> > +	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
> > +	value &=3D ~USB2_TRK_START_TIMER(~0);
> > +	value |=3D USB2_TRK_START_TIMER(0x1e);
> > +	value &=3D ~USB2_TRK_DONE_RESET_TIMER(~0);
> > +	value |=3D USB2_TRK_DONE_RESET_TIMER(0xa);
> > +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
> > +
> > +	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL0);
> > +	value &=3D ~BIAS_PAD_PD;
> > +	value &=3D ~HS_SQUELCH_LEVEL(~0);
> > +	value |=3D HS_SQUELCH_LEVEL(priv->calib.hs_squelch);
> > +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL0);
> > +
> > +	udelay(1);
> > +
> > +	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
> > +	value &=3D ~USB2_PD_TRK;
> > +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
> > +
> > +	mutex_unlock(&padctl->lock);
> > +}
> > +
> > +static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl =
*padctl)
> > +{
> > +	struct tegra186_xusb_padctl *priv =3D to_tegra186_xusb_padctl(padctl);
> > +	u32 value;
> > +
> > +	mutex_lock(&padctl->lock);
> > +
> > +	if (WARN_ON(priv->bias_pad_enable =3D=3D 0)) {
> > +		mutex_unlock(&padctl->lock);
> > +		return;
> > +	}
> > +
> > +	if (--priv->bias_pad_enable > 0) {
> > +		mutex_unlock(&padctl->lock);
> > +		return;
> > +	}
> > +
> > +	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
> > +	value |=3D USB2_PD_TRK;
> > +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
> > +
> > +	clk_disable_unprepare(priv->usb2_trk_clk);
> > +
> > +	mutex_unlock(&padctl->lock);
> > +}
> > +
> > +void tegra_phy_xusb_utmi_pad_power_on(struct phy *phy)
> > +{
> > +	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
> > +	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
> > +	struct tegra_xusb_usb2_port *port;
> > +	struct device *dev =3D padctl->dev;
> > +	unsigned int index =3D lane->index;
> > +	u32 value;
> > +
> > +	if (!phy)
> > +		return;
> > +
> > +	port =3D tegra_xusb_find_usb2_port(padctl, index);
> > +	if (!port) {
> > +		dev_err(dev, "no port found for USB2 lane %u\n", index);
> > +		return;
> > +	}
> > +
> > +	tegra186_utmi_bias_pad_power_on(padctl);
> > +
> > +	udelay(2);
> > +
> > +	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
> > +	value &=3D ~USB2_OTG_PD;
> > +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
> > +
> > +	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
> > +	value &=3D ~USB2_OTG_PD_DR;
> > +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
> > +}
> > +
> > +void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy)
> > +{
> > +	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
> > +	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
> > +	unsigned int index =3D lane->index;
> > +	u32 value;
> > +
> > +	if (!phy)
> > +		return;
> > +
> > +	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
> > +	value |=3D USB2_OTG_PD;
> > +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
> > +
> > +	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
> > +	value |=3D USB2_OTG_PD_DR;
> > +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
> > +
> > +	udelay(2);
> > +
> > +	tegra186_utmi_bias_pad_power_off(padctl);
> > +}
> > +
> > +static int tegra186_utmi_phy_power_on(struct phy *phy)
> > +{
> > +	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
> > +	struct tegra_xusb_usb2_lane *usb2 =3D to_usb2_lane(lane);
> > +	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
> > +	struct tegra186_xusb_padctl *priv =3D to_tegra186_xusb_padctl(padctl);
> > +	struct tegra_xusb_usb2_port *port;
> > +	unsigned int index =3D lane->index;
> > +	struct device *dev =3D padctl->dev;
> > +	u32 value;
> > +
> > +	port =3D tegra_xusb_find_usb2_port(padctl, index);
> > +	if (!port) {
> > +		dev_err(dev, "no port found for USB2 lane %u\n", index);
> > +		return -ENODEV;
> > +	}
> > +
> > +	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_PAD_MUX);
> > +	value &=3D ~(USB2_PORT_MASK << USB2_PORT_SHIFT(index));
> > +	value |=3D (PORT_XUSB << USB2_PORT_SHIFT(index));
> > +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_PAD_MUX);
> > +
> > +	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_PORT_CAP);
> > +	value &=3D ~(PORT_CAP_MASK << PORTX_CAP_SHIFT(index));
> > +
> > +	if (port->mode =3D=3D USB_DR_MODE_UNKNOWN)
> > +		value |=3D (PORT_CAP_DISABLED << PORTX_CAP_SHIFT(index));
> > +	else if (port->mode =3D=3D USB_DR_MODE_PERIPHERAL)
> > +		value |=3D (PORT_CAP_DEVICE << PORTX_CAP_SHIFT(index));
> > +	else if (port->mode =3D=3D USB_DR_MODE_HOST)
> > +		value |=3D (PORT_CAP_HOST << PORTX_CAP_SHIFT(index));
> > +	else if (port->mode =3D=3D USB_DR_MODE_OTG)
> > +		value |=3D (PORT_CAP_OTG << PORTX_CAP_SHIFT(index));
> > +
> > +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_PORT_CAP);
> > +
> > +	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
> > +	value &=3D ~USB2_OTG_PD_ZI;
> > +	value |=3D TERM_SEL;
> > +	value &=3D ~HS_CURR_LEVEL(~0);
> > +
> > +	/* TODO hs_curr_level_offset support */
>=20
> What is TODO here?

Nothing. hs_curr_level_offset support is clearly implemented below, so
I've removed the stale comment.

> > +	if (usb2->hs_curr_level_offset) {
> > +		int hs_current_level;
> > +
> > +		hs_current_level =3D (int)priv->calib.hs_curr_level[index] +
> > +						usb2->hs_curr_level_offset;
> > +
> > +		if (hs_current_level < 0)
> > +			hs_current_level =3D 0;
> > +		if (hs_current_level > 0x3f)
> > +			hs_current_level =3D 0x3f;
> > +
> > +		value |=3D HS_CURR_LEVEL(hs_current_level);
> > +	} else {
> > +		value |=3D HS_CURR_LEVEL(priv->calib.hs_curr_level[index]);
> > +	}
> > +
> > +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
> > +
> > +	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
> > +	value &=3D ~TERM_RANGE_ADJ(~0);
> > +	value |=3D TERM_RANGE_ADJ(priv->calib.hs_term_range_adj);
> > +	value &=3D ~RPD_CTRL(~0);
> > +	value |=3D RPD_CTRL(priv->calib.rpd_ctrl);
> > +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
> > +
> > +	/* TODO: pad power saving */
> > +	tegra_phy_xusb_utmi_pad_power_on(phy);
> > +	return 0;
> > +}
> > +
> > +static int tegra186_utmi_phy_power_off(struct phy *phy)
> > +{
> > +	/* TODO: pad power saving */
> > +	tegra_phy_xusb_utmi_pad_power_down(phy);
> > +
> > +	return 0;
> > +}
> > +
> > +static int tegra186_utmi_phy_init(struct phy *phy)
> > +{
> > +	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
> > +	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
> > +	struct tegra_xusb_usb2_port *port;
> > +	unsigned int index =3D lane->index;
> > +	struct device *dev =3D padctl->dev;
> > +	int err;
> > +
> > +	port =3D tegra_xusb_find_usb2_port(padctl, index);
>=20
> I would prefer if this entire driver is rewritten without using xusb libr=
ary.

I don't think that would be possible without duplicating most of the
code in xusb.c into each of xusb-tegra124.c, xusb-tegra210.c and
xusb-tegra186.c.

> Ideally you shouldn't have to traverse a list to configure the PHY. phy_g=
et
> already does that for you. It should be straight forward to get "port" fr=
om "phy".

There's a subtle difference here between port and PHY. The "phy" that
we're initializing here is actually the "lane" in Tegra terms. Each pad
on Tegra (typically USB, PCIe, SATA, ...) can have multiple lanes, each
of which can be muxed to a specific function.

Ports are a separate abstraction that is used to represent the physical
connectors on a board. This is different from the lane.

> I think xusb is making it more complicated than it has to be.

I understand that it may seem that way, but a lot of thought went into
abstracting this in order to cover the various scenarios that we can run
into, and to be able to unify this across multiple chips.

A lot of this infrastructure is also there to make sure the device tree
is actually consistent. So the indirections and abstractions not only
serve to wrap PHYs and ports into objects that are easy to work with but
also to validate that the device tree adheres to the device tree
bindings.

Thierry

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxcIdsACgkQ3SOs138+
s6FXEA//TEP5bwzdBTJn+/WWYXlLthuHWq54F3Q1KFFJtyT4wiMAywRYsyJGcAoW
gKdG5u7GdBZLE8ckxtW+MP+ZMsD2tBd3+bdDhqsscNVRwR3KLXB384aHvX61xipi
LpEXLWWpPGnrSWiA1CB4/XJH0FHO8wjn61OCxCndP6UTQUm+UT0J06kFBH9BP7As
Dl88Qgo+DT+Olk5/cKB9f+snirfLZLFU2xM9i6MJ9I2m4unI4a4wUoQmmratvfp7
S1BDCgg12YPq+QAeUeGCBkQ8NnuCs2Fo3dSeQU+6OMauTsVQpe/+J7fEsrC/U+o5
7EVA0f1X8ZZCL24MDjgUkAfDlNj4mOhPDVxpI0D04VFSAHLfNSULJtP+QARyJXri
UBbJKO9Ccb3Ew9dD/zDK+yIyOLqubHnVjlLGWLIyaY/r11ciJ+WlGa0tnTccQ3CO
5EcQyfFDjKtwJYivsbzmHaZ7P+CpPTMEtbgcHMwwS/I9fNiBw5piVjWmNgZJRItQ
tDIpIhd7xYSURJwqXyDeW9wpBHEAnJIYN+1S3d7TXxqnviAeS8EYqHXAv4+UdDGt
IWn1I1ENj7Tynq8njTYgqGTOdP0PmCPAo2Meff7KC3wcRmp7xCI2Q2DS+NjzVPZr
4Bsprc+bdgJGdqxlILy7O/VTSCo2maupbrhZ+jfgzCQglON+EDk=
=WwSt
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
