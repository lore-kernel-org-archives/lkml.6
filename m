Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5428AC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5BA2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="KehiMgAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5BA2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbeLGUZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:25:27 -0500
Received: from mail-eopbgr710079.outbound.protection.outlook.com ([40.107.71.79]:41441
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbeLGUZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSlwvoC7ypodGxKLQRGZakhxkbW3M7B7M75uyDnI1AU=;
 b=KehiMgAlEj43vudupjPVn6PYMyqkGrkx70q1nNst2erAtC75Dkkki3zO1FLLKbbRQerDjLQsyMbod2nTXJ2/oRwSKK2mZxVr3fDNw7/adex0QlhdgRM3yHwIrc4BzePyZ1enpN4KO1Crjt+P6qReFKSuee7SF5X8Atcq8qKv6Zs=
Received: from BN7PR03MB3572.namprd03.prod.outlook.com (20.176.20.139) by
 BN7PR03MB3700.namprd03.prod.outlook.com (20.176.23.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Fri, 7 Dec 2018 20:24:45 +0000
Received: from BN7PR03MB3572.namprd03.prod.outlook.com
 ([fe80::4d32:687b:8d17:23b6]) by BN7PR03MB3572.namprd03.prod.outlook.com
 ([fe80::4d32:687b:8d17:23b6%3]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 20:24:44 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 02/18] mfd: adp5520: Make it explicitly non-modular
Thread-Topic: [PATCH 02/18] mfd: adp5520: Make it explicitly non-modular
Thread-Index: AQHUjmlWTJGhmqBj20qEZ2E27ijP9qVzuKCA
Date:   Fri, 7 Dec 2018 20:24:44 +0000
Message-ID: <BN7PR03MB3572AA2446C348BF7B57F49D8EAA0@BN7PR03MB3572.namprd03.prod.outlook.com>
References: <1544213465-16259-1-git-send-email-paul.gortmaker@windriver.com>
 <1544213465-16259-3-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1544213465-16259-3-git-send-email-paul.gortmaker@windriver.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.Hennerich@analog.com; 
x-originating-ip: [2001:16b8:2dbd:ff00:10f9:445d:ab57:4f9a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR03MB3700;6:HZjTwTaBJYxx8mKt38eQqYuOYjxXXsCZ9KAG3UCQkv1J3XTrpBzUnT5jpZ2rMec74t/MXBCh2liWMOQzGBukVN1qDrotdftVbw7GMRqoEc8jBn+/fpkAGi4qHKaq8HE0NRK+vddBjxLoOI+hMSO80bOqcvUjY01nXnPYmGcE52aNJ+aHzd3YlfVVGLPGU5DHqnmo7XSu0jdGSpzvL/lCTpt8W492tOhlQqU6Y0nn4Ledk7sccoNpjGKLA+5ox7KlmuuyMlh6OA6KNkW/sYc/MI9KrJ6r223pyhZUTI0kXlvcKUS6jPSmolTl2GhRhFxPKA9K/UILyHdBVYd+kelWaUM9LCKO3RfmSVScoN9TUaLYd/C0AJjTT6joMo5q2P3QNilUqmSqEF86Ycvdi8boNOGGToDmQTyYoX9mrQw23eGki3ml/Spo1XlNQQKs0LuK46W/pIgrk+MA7SxXesSX3g==;5:Ytfo9ps3Raz6PD544BFi/lk7QMz8iU8SVfU8WEIOKEm5FSaDX6PSAT/PUIslccjQcdsibpOzK+dzaTg9KJx4K9dn0yTyNQ57whFp8H/OFBFyCvNcM7b+XGqwUwvLhJNAzTxy9+J53uGxn0YlOA8vYhVqF/hk04lduEtMSh5Y9NI=;7:UHfVJEmi51Fv79zHoHegC9ht7PY0Ngz0vXA5IyFe8d7bqMVpGvFIvRwJm2TR3YLep4QBRcjdmQtdM8yIcyZhKtpbADrvYzeZDoovOEoLChjo8ZaPx9OZo9eQoCMDt/GLnP+fSEJ3iLawCsv/7lPszQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7d3f4732-aef4-431c-a227-08d65c8206d6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR03MB3700;
x-ms-traffictypediagnostic: BN7PR03MB3700:
x-microsoft-antispam-prvs: <BN7PR03MB37004D5D710E3CE6D1F964348EAA0@BN7PR03MB3700.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN7PR03MB3700;BCL:0;PCL:0;RULEID:;SRVR:BN7PR03MB3700;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(366004)(396003)(376002)(189003)(199004)(52314003)(13464003)(74316002)(7736002)(53546011)(6506007)(97736004)(2906002)(102836004)(105586002)(6436002)(6246003)(46003)(305945005)(186003)(55016002)(7696005)(99286004)(14444005)(6116002)(86362001)(256004)(76176011)(53936002)(9686003)(71200400001)(71190400001)(25786009)(33656002)(4326008)(68736007)(72206003)(229853002)(446003)(486006)(476003)(8676002)(5660300001)(110136005)(11346002)(14454004)(81156014)(316002)(81166006)(478600001)(8936002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3700;H:BN7PR03MB3572.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9XaqY/ha89NNluIZZO+8lpnpKPpnUokMw5YO9SkkSV0vRBBwLnh07Q+8t3WNjthfFXw4FA7EpesAPZH9LTyur20f8GlTgK3Xae/f85jbVH9YGYVJpfyRxst6ril5uGYZZ51bc8tygv8iXuIv29lo7GEbW80BtlZIEKaiUjVAqx2vXulkh7QeTwrzJYt+2YZTEpFvT1Y/CEDpfrgab5f5uVF0zNMqbniomvatzi1FVHku/4Dm/xpg4K8HYSqZIKRRst4HLZVh6mBHDHs54hdtFQIhehTqwYDLTW/V/HGN5BpShr2tWFtxHP/oC3cOj7jUjirAnIEO19Ezkg8PPtlPtI9goGL9SajR94MhADInHHo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3f4732-aef4-431c-a227-08d65c8206d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 20:24:44.9487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Paul Gortmaker [mailto:paul.gortmaker@windriver.com]
> Sent: Freitag, 7. Dezember 2018 21:11
> To: Lee Jones <lee.jones@linaro.org>
> Cc: linux-kernel@vger.kernel.org; Paul Gortmaker <paul.gortmaker@windrive=
r.com>; Hennerich, Michael
> <Michael.Hennerich@analog.com>
> Subject: [PATCH 02/18] mfd: adp5520: Make it explicitly non-modular
>=20
> The Makefile/Kconfig currently controlling compilation of this code is:
>=20
> drivers/mfd/Makefile:obj-$(CONFIG_PMIC_ADP5520) +=3D adp5520.o
> drivers/mfd/Kconfig:config PMIC_ADP5520
> drivers/mfd/Kconfig:    bool "Analog Devices ADP5520/01 MFD PMIC Core Sup=
port"
>=20
> ...meaning that it currently is not being built as a module by anyone.
>=20
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
>=20
> We explicitly disallow a driver unbind, since that doesn't have a
> sensible use case anyway, and it allows us to drop the ".remove"
> code for non-modular drivers.
>=20
> Since module_i2c_driver() uses the same init level priority as
> builtin_i2c_driver() the init ordering remains unchanged with
> this commit.
>=20
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
>=20
> We also delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.
>=20
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/mfd/adp5520.c | 30 +++++++-----------------------
>  1 file changed, 7 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/mfd/adp5520.c b/drivers/mfd/adp5520.c
> index be0497b96720..2cdd39cb8a18 100644
> --- a/drivers/mfd/adp5520.c
> +++ b/drivers/mfd/adp5520.c
> @@ -7,6 +7,8 @@
>   *
>   * Copyright 2009 Analog Devices Inc.
>   *
> + * Author: Michael Hennerich <michael.hennerich@analog.com>
> + *
>   * Derived from da903x:
>   * Copyright (C) 2008 Compulab, Ltd.
>   *	Mike Rapoport <mike@compulab.co.il>
> @@ -18,7 +20,7 @@
>   */
>=20
>  #include <linux/kernel.h>
> -#include <linux/module.h>
> +#include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/interrupt.h>
> @@ -304,18 +306,6 @@ static int adp5520_probe(struct i2c_client *client,
>  	return ret;
>  }
>=20
> -static int adp5520_remove(struct i2c_client *client)
> -{
> -	struct adp5520_chip *chip =3D dev_get_drvdata(&client->dev);
> -
> -	if (chip->irq)
> -		free_irq(chip->irq, chip);
> -
> -	adp5520_remove_subdevs(chip);
> -	adp5520_write(chip->dev, ADP5520_MODE_STATUS, 0);
> -	return 0;
> -}
> -
>  #ifdef CONFIG_PM_SLEEP
>  static int adp5520_suspend(struct device *dev)
>  {
> @@ -346,20 +336,14 @@ static const struct i2c_device_id adp5520_id[] =3D =
{
>  	{ "pmic-adp5501", ID_ADP5501 },
>  	{ }
>  };
> -MODULE_DEVICE_TABLE(i2c, adp5520_id);
>=20
>  static struct i2c_driver adp5520_driver =3D {
>  	.driver =3D {
> -		.name	=3D "adp5520",
> -		.pm	=3D &adp5520_pm,
> +		.name			=3D "adp5520",
> +		.pm			=3D &adp5520_pm,
> +		.suppress_bind_attrs	=3D true,
>  	},
>  	.probe		=3D adp5520_probe,
> -	.remove		=3D adp5520_remove,
>  	.id_table	=3D adp5520_id,
>  };
> -
> -module_i2c_driver(adp5520_driver);
> -
> -MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> -MODULE_DESCRIPTION("ADP5520(01) PMIC-MFD Driver");
> -MODULE_LICENSE("GPL");
> +builtin_i2c_driver(adp5520_driver);
> --
> 2.7.4
>=20

