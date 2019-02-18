Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E1CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BFD2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wyjblIFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfBRIFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:05:45 -0500
Received: from mail-eopbgr20053.outbound.protection.outlook.com ([40.107.2.53]:31920
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728585AbfBRIFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAuiS+LFr8Bzt+m6qZ4eryxvGg+ugpvWLTY9TH2QtEE=;
 b=wyjblIFEfYArr928JigQco8CsWSk6Y9UObRfPfcsAVp3sH/SfLrAMNQi3fz9shOeKsA5MvVeFFPfIMVgSYUsULamXk9DyMv/g9aNDco+w8/WhRYfOKRGwmOAVLLy8xvpPTla//8pMh7GVRqS4tgncpzqsJ6ZQDSR7xmLF/FG5QM=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB1855.eurprd04.prod.outlook.com (10.165.235.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Mon, 18 Feb 2019 08:05:32 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1622.016; Mon, 18 Feb 2019
 08:05:32 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, Peter Rosin <peda@axentia.se>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: FW: [PATCH] drivers: mux: Generic register bitfield-based multiplexer
 driver
Thread-Topic: [PATCH] drivers: mux: Generic register bitfield-based
 multiplexer driver
Thread-Index: AQHUx0xz2hlFfSdjRkyo3ywwDF+eo6XlMoIw
Date:   Mon, 18 Feb 2019 08:05:32 +0000
Message-ID: <VI1PR0401MB249671EFE960B829F05068A1F1630@VI1PR0401MB2496.eurprd04.prod.outlook.com>
References: <20190218110509.28225-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190218110509.28225-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6caf6537-9147-4c7a-5331-08d69577db1e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB1855;
x-ms-traffictypediagnostic: VI1PR0401MB1855:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR0401MB1855;23:9AGMr9IBAL3b/owLuMBnAZhNJeUEWVcF5Q1zr5f?=
 =?us-ascii?Q?21iihlE3PL2Ox6w9TktoBLHu5ToAc8xUsr7sPco2CeFb4h4xGK9ThSCnAgQj?=
 =?us-ascii?Q?CusHK3uOZtKK52q2mTg40t2+xl8Ebv8pVsj02F9+B+MAIgxZQUTX8b4S3KA1?=
 =?us-ascii?Q?V+I7rTV567K/kKIMvKl7mkpafXendhed6ua5jmM3iKcr7WwnPyBc6mtRJO9p?=
 =?us-ascii?Q?6YLjj5P2gn2CNe6LeWoUZYSQq6jbuhyCqcCC/TlDwSTwCno6VklLo3eFLiE2?=
 =?us-ascii?Q?tN++iTB+MNtV3O2AGUjKWFvYgZ95xc8yfY11MRrldCU4f6nHJbLG1f+On4qk?=
 =?us-ascii?Q?iXaKATw/+1rFLoYvQs1ASmiwWBTKmQ7iojPje8Cj36Ul3P1Sb2ppu5ri96tc?=
 =?us-ascii?Q?QmEOqlUURTfFDSA+sFXaw2Gju3cU7+FJwzJAO4b98pM6+2xFt/lCueujtzuG?=
 =?us-ascii?Q?o7swoFdRM2b4KfdH9H6qd5ixHv9Mpc1ULriz2+BvJo9SGn7BhBJvCmW2XvBv?=
 =?us-ascii?Q?hFJJz+3pRUAVHCub30lCdtsQEKhQ7idAhG0QCGBIoT9768RwnA+G7d0Eeq04?=
 =?us-ascii?Q?FAy9x8Ows2SjvZuUqrZv2KJiINYuq8WA74iEROStGZ+P9zD+S0p2OzjS3mhK?=
 =?us-ascii?Q?82RDkNsrSc06aoQwuRY30S5AQXZJuFIyfQWXz/dMawHC/fJ1SBHF5JCPzLs+?=
 =?us-ascii?Q?4e8APmqCKCmiS12TkyBmSAuFbzU1C1KfUrZ1VUNOIxzFqPMCkkHHlVac9TBW?=
 =?us-ascii?Q?2vonrRxg3U1gH4I9mZsOprlWghe0FnOr0xNojpcivQNY/S6yGykhH+hLL0x6?=
 =?us-ascii?Q?woNOA92HuCqGAv4WyKRKjGsGHHfjcXuCkSpd8mgE0BeyaOEgH0q0DlzTN92j?=
 =?us-ascii?Q?nD4P7d5ZJG6F2Z68bAVcUy8AOfnX8KymE2p4/8bfeKU+znhgEZulBXNg1Orz?=
 =?us-ascii?Q?coQPPan4YNdqZippe1+cdAq3tuJ2X8MW0JoDcOAaej3ssXeEZeOVhxCbhgiM?=
 =?us-ascii?Q?BlsARqucnZVNI3F4NJ0JkKdrs46WkNPx9zR1bLak+J+3ZrI8Lph8oXhbozRB?=
 =?us-ascii?Q?IxiQ62Sv4oYDuhCQgkFBroxN95jca40xjOBFfd9Qt6AFo7G8wgLq9HNtKb2O?=
 =?us-ascii?Q?/F1Bsc6vy1+SGJTqzpVFw65cGTtRCLYVoT2g+lEXCDOUegwuXbIQneLwbGj+?=
 =?us-ascii?Q?04J/MQkWZwTlvKOwV4auIzsYtckWaBY2bB+RlPtsmIXXAXYeC4xjAFaFywB1?=
 =?us-ascii?Q?TGfVPfzp564/JS93mjmnmVtFJaHiAr7uCO2tc3NBLMBHWcZ37LlOJ6uYCVc1?=
 =?us-ascii?Q?vgQ=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR0401MB1855B602454D314ED62ECDF1F1630@VI1PR0401MB1855.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(366004)(376002)(346002)(199004)(189003)(13464003)(55016002)(71190400001)(81156014)(2906002)(99286004)(8936002)(7696005)(68736007)(5660300002)(6436002)(6306002)(71200400001)(44832011)(256004)(86362001)(229853002)(81166006)(66066001)(7736002)(74316002)(53546011)(305945005)(2473003)(9686003)(25786009)(8676002)(478600001)(14454004)(53936002)(6506007)(76176011)(966005)(316002)(11346002)(110136005)(446003)(186003)(3846002)(6116002)(4326008)(97736004)(33656002)(486006)(476003)(106356001)(26005)(105586002)(102836004)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB1855;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XoSTV1lh+eiOYeeoh8GOVYi91wYz/7edba7PGTRMsFU0qgnRPCf68ESaVDJVpA/SkXYh9SMnLq23wnhVP0U5OgC0JL2ajWIR4pMKl0ze6vcYcIFHsCLGyz17DncFyN4rDhpje9i4n4e+X8qcgXTfgsh1xEDHn+ipdMJ7t2z1IEG8HL2zBM0OAX2s6d+qQ9yFUmUewLnAn+TGzqPykZRjtkcnYFk+qgZvciI8iYfPQCo+7e3Djehpb8cenI6tvgrm7iWb9fGpvRcmCF6bwnCXcyQHiUcgtjhzV7Qyk7vNwZN8driK0hEDnuOe6Um2Nvv7IPuqj5TY+yVce5Gpisx1ih52YG/TPj0cx4YRdUvL3kZJjI0YZ0J6EexWQHVrdS87WVe9VX1SMbw+0K+VhSYxvNIux17aBDIzKZk9UPBodRU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6caf6537-9147-4c7a-5331-08d69577db1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 08:05:32.8888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB1855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Pankaj Bansal [mailto:pankaj.bansal@nxp.com]
> Sent: Monday, 18 February, 2019 11:10 AM
> To: Leo Li <leoyang.li@nxp.com>; Peter Rosin <peda@axentia.se>
> Cc: Pankaj Bansal <pankaj.bansal@nxp.com>
> Subject: [PATCH] drivers: mux: Generic register bitfield-based multiplexe=
r driver
>=20
> Generic register bitfield-based multiplexer driver that controls the mult=
iplexer
> producer defined under a parent node.
> The driver corresponding to parent node provides register read/write
> capabilities.
>=20
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> ---
>=20
> Notes:
>     Dependencies:
>     - https://patchwork.ozlabs.org/patch/1043790/
>=20
>  drivers/mux/Kconfig  |  13 ++++
>  drivers/mux/Makefile |   2 +
>  drivers/mux/regmap.c | 139 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 154 insertions(+)
>=20
> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig index
> 7659d6c5f718..a412d0955258 100644
> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -58,4 +58,17 @@ config MUX_MMIO
>  	  To compile the driver as a module, choose M here: the module will
>  	  be called mux-mmio.
>=20
> +config MUX_REGMAP
> +	tristate "Regmap register bitfield-controlled Multiplexer"
> +	depends on (OF && REGMAP) || COMPILE_TEST
> +	help
> +	  Regmap register bitfield-controlled Multiplexer controller.
> +
> +	  The driver builds multiplexer controllers for bitfields in a regmap
> +	  device register. For N bit wide bitfields, there will be 2^N possible
> +	  multiplexer states.
> +
> +	  To compile the driver as a module, choose M here: the module will
> +	  be called regmap-mmio.
> +
>  endmenu
> diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile index
> 6e9fa47daf56..ae1bafac0cbd 100644
> --- a/drivers/mux/Makefile
> +++ b/drivers/mux/Makefile
> @@ -8,9 +8,11 @@ mux-adg792a-objs		:=3D adg792a.o
>  mux-adgs1408-objs		:=3D adgs1408.o
>  mux-gpio-objs			:=3D gpio.o
>  mux-mmio-objs			:=3D mmio.o
> +mux-regmap-objs			:=3D regmap.o
>=20
>  obj-$(CONFIG_MULTIPLEXER)	+=3D mux-core.o
>  obj-$(CONFIG_MUX_ADG792A)	+=3D mux-adg792a.o
>  obj-$(CONFIG_MUX_ADGS1408)	+=3D mux-adgs1408.o
>  obj-$(CONFIG_MUX_GPIO)		+=3D mux-gpio.o
>  obj-$(CONFIG_MUX_MMIO)		+=3D mux-mmio.o
> +obj-$(CONFIG_MUX_REGMAP)	+=3D mux-regmap.o
> diff --git a/drivers/mux/regmap.c b/drivers/mux/regmap.c new file mode
> 100644 index 000000000000..c2156302929a
> --- /dev/null
> +++ b/drivers/mux/regmap.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Regmap register bitfield-controlled multiplexer driver
> + *
> + * Based on drivers/mux/mmio.c
> + *
> + * Copyright 2019 NXP
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/mux/driver.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +static int mux_regmap_set(struct mux_control *mux, int state) {
> +	struct regmap_field **fields =3D mux_chip_priv(mux->chip);
> +
> +	return regmap_field_write(fields[mux_control_get_index(mux)], state);
> +}
> +
> +static const struct mux_control_ops mux_regmap_ops =3D {
> +	.set =3D mux_regmap_set,
> +};
> +
> +static const struct of_device_id mux_regmap_dt_ids[] =3D {
> +	{ .compatible =3D "reg-mux", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mux_regmap_dt_ids);
> +
> +static int mux_regmap_probe(struct platform_device *pdev) {
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +	struct regmap_field **fields;
> +	struct mux_chip *mux_chip;
> +	struct regmap *regmap;
> +	int num_fields;
> +	int ret;
> +	int i;
> +
> +	regmap =3D dev_get_regmap(dev->parent, NULL);
> +	if (IS_ERR(regmap)) {
> +		ret =3D PTR_ERR(regmap);
> +		dev_err(dev, "failed to get regmap: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D of_property_count_u32_elems(np, "mux-reg-masks");
> +	if (ret =3D=3D 0 || ret % 2)
> +		ret =3D -EINVAL;
> +	if (ret < 0) {
> +		dev_err(dev, "mux-reg-masks property missing or invalid: %d\n",
> +			ret);
> +		return ret;
> +	}
> +	num_fields =3D ret / 2;
> +
> +	mux_chip =3D devm_mux_chip_alloc(dev, num_fields, num_fields *
> +				       sizeof(*fields));
> +	if (IS_ERR(mux_chip))
> +		return PTR_ERR(mux_chip);
> +
> +	fields =3D mux_chip_priv(mux_chip);
> +
> +	for (i =3D 0; i < num_fields; i++) {
> +		struct mux_control *mux =3D &mux_chip->mux[i];
> +		struct reg_field field;
> +		s32 idle_state =3D MUX_IDLE_AS_IS;
> +		u32 reg, mask;
> +		int bits;
> +
> +		ret =3D of_property_read_u32_index(np, "mux-reg-masks",
> +						 2 * i, &reg);
> +		if (!ret)
> +			ret =3D of_property_read_u32_index(np, "mux-reg-
> masks",
> +							 2 * i + 1, &mask);
> +		if (ret < 0) {
> +			dev_err(dev, "bitfield %d: failed to read mux-reg-masks
> property: %d\n",
> +				i, ret);
> +			return ret;
> +		}
> +
> +		field.reg =3D reg;
> +		field.msb =3D fls(mask) - 1;
> +		field.lsb =3D ffs(mask) - 1;
> +
> +		if (mask !=3D GENMASK(field.msb, field.lsb)) {
> +			dev_err(dev, "bitfield %d: invalid mask 0x%x\n",
> +				i, mask);
> +			return -EINVAL;
> +		}
> +
> +		fields[i] =3D devm_regmap_field_alloc(dev, regmap, field);
> +		if (IS_ERR(fields[i])) {
> +			ret =3D PTR_ERR(fields[i]);
> +			dev_err(dev, "bitfield %d: failed allocate: %d\n",
> +				i, ret);
> +			return ret;
> +		}
> +
> +		bits =3D 1 + field.msb - field.lsb;
> +		mux->states =3D 1 << bits;
> +
> +		of_property_read_u32_index(np, "idle-states", i,
> +					   (u32 *)&idle_state);
> +		if (idle_state !=3D MUX_IDLE_AS_IS) {
> +			if (idle_state < 0 || idle_state >=3D mux->states) {
> +				dev_err(dev, "bitfield: %d: out of range idle
> state %d\n",
> +					i, idle_state);
> +				return -EINVAL;
> +			}
> +
> +			mux->idle_state =3D idle_state;
> +		}
> +	}
> +
> +	mux_chip->ops =3D &mux_regmap_ops;
> +
> +	return devm_mux_chip_register(dev, mux_chip); }
> +
> +static struct platform_driver mux_regmap_driver =3D {
> +	.driver =3D {
> +		.name =3D "regmap-mux",
> +		.of_match_table	=3D of_match_ptr(mux_regmap_dt_ids),
> +	},
> +	.probe =3D mux_regmap_probe,
> +};
> +module_platform_driver(mux_regmap_driver);
> +
> +MODULE_DESCRIPTION("Regmap register bitfield-controlled multiplexer
> +driver"); MODULE_AUTHOR("Pankaj Bansal <pankaj.bansal@nxp.com>");
> +MODULE_LICENSE("GPL");
> --
> 2.17.1

