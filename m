Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DDEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37651217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="raubEcb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeLRHn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:43:57 -0500
Received: from mail-eopbgr680063.outbound.protection.outlook.com ([40.107.68.63]:54036
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726324AbeLRHn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuAAlDylbLnGcWMonBpQo4DzNbXPxhv6nrkR6unBpYE=;
 b=raubEcb3PowvEFRTfN4uzeaM3QZXB+M2BuND+9IUvcfc4mioqexieztyfv+urHMKVG1eG+gtzbQZD8xYv1/ZOatP4Lr5+LpkVu5C+SjC8tffdIKyAiCG9wrFlgTV6ZNtDufG74BRyCd5V596B5YOea5pQTcmv1UWClcp+Nt6Acw=
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (52.135.213.26) by
 BYAPR03MB3752.namprd03.prod.outlook.com (20.176.254.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Tue, 18 Dec 2018 07:43:14 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d947:97fb:64a3:25be]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d947:97fb:64a3:25be%3]) with mapi id 15.20.1425.023; Tue, 18 Dec 2018
 07:43:14 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 02/18] mfd: adp5520: Make it explicitly non-modular
Thread-Topic: [PATCH 02/18] mfd: adp5520: Make it explicitly non-modular
Thread-Index: AQHUlkfQ5yy/j2MZdUW8lYUwz7mz46WEHeAw
Date:   Tue, 18 Dec 2018 07:43:14 +0000
Message-ID: <BYAPR03MB3573A8675B9FB8E436024AA18EBD0@BYAPR03MB3573.namprd03.prod.outlook.com>
References: <1545078688-21217-1-git-send-email-paul.gortmaker@windriver.com>
 <1545078688-21217-3-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1545078688-21217-3-git-send-email-paul.gortmaker@windriver.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.Hennerich@analog.com; 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR03MB3752;6:zT2bkc1Q1xFu4KVoICvafpPhsGi+ZHjoeLuo7CSfiLOEikFE9wYq6+jdyc0v9VsqCcOa6+WXHkVFtfmAOyQACQxcc9fYCkRobFlqEp33N35cs7+T01IR0FZZfYJ4Ez3ixX+a3/3sLcsdh5hHeVunwrLQRNVjFR7Qvj6UQQgSKJC/xzyyejxnxXUCC/w9YN8b5ZV3q2+tTlbcfYP6CMh5fSua/IDsqroDv+2KYHUhlhS2xxLcrzBysmMMWgLb7tYe31devyzyc6tP3t2E5bWUnmUf9U0HQQiCLnNw6Yrld00Jh+SUcDxmahYm9y2hljhDhXHlYMNHi62FmHBj1P0ijwHT+K/4pCB+0uhH0P3pGrmZccu6+Ml7AUcicnD50YpMFKnrOT094mSj0NanfgTkGqmhRXfjJWdVW6UIce3jbQ9htrZvFvtboL9SWQUimbSYSb4nBqKUkQkG7Kd3NHxXXQ==;5:5ZZ1cJfbyC/GgdO4sjb0CoZWPWIMJmqT/fTq+utv1xQ9BYokMILbxyYvhw7gxEUovQN5ysPhlAhvNG9Z99UQLiwpH++aoryAWaQttKER46zyx1QHDFfaIFl9tvU3aJv1riSJ5auwKqe4AMYZu379lytXiBpxxiBsr4dO2ANt8bs=;7:UrYuQLmVPg9Uw7C9TfrGAoPzjIxRNuEDZusX3dsFmeaukbXe8uTuvd1gYFzS4MjuK7pb9RPDIDZZi4Z+traWAtJqiyfS80i10BEuI5SKzcwCfir3Bs5YHb1Fr9TJKjyAqdm9vc4TRzqC48kIO40kGg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4aa3dbf2-2863-465a-0503-08d664bc77a0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB3752;
x-ms-traffictypediagnostic: BYAPR03MB3752:
x-microsoft-antispam-prvs: <BYAPR03MB3752D77D90B14D4C064FB0C48EBD0@BYAPR03MB3752.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR03MB3752;BCL:0;PCL:0;RULEID:;SRVR:BYAPR03MB3752;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(366004)(13464003)(199004)(189003)(52314003)(66066001)(76176011)(7696005)(53546011)(6506007)(102836004)(2906002)(71190400001)(71200400001)(316002)(33656002)(256004)(14444005)(105586002)(106356001)(478600001)(3846002)(6116002)(186003)(4326008)(68736007)(26005)(99286004)(53936002)(14454004)(11346002)(446003)(9686003)(25786009)(8936002)(55016002)(486006)(476003)(86362001)(6246003)(72206003)(7736002)(81156014)(81166006)(110136005)(305945005)(6436002)(8676002)(74316002)(229853002)(5660300001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3752;H:BYAPR03MB3573.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: F8rBOrNi37SShLRT/ut26K4twWdEpo0DpFHfDL5pcbNFOJUtaH91YJRO9LElIJ2aJO4HJKDa1F+9RdAI1mQR8ke8E+iNRQCBJJ6jSMw4NtkqTFnrV+oV8J1FKsM7oZRO4MCCrMEwmw5K1Nmembt+5bbxKTzRy4FuR1uWQlQ6kiKQmOpGB19hwrfh6Xxeox6H+FwMDdarhuJLmIwN/U+LcAq3wy7nHgmQh6/ycYsI+UlJu7zSB2EOxKEcZtxiwnGIlEBBHGbbfi2NTr8GMlAKKZrTorutodClDYmj0as+lXi+n3BYCIKigg1OwadHZh2h
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa3dbf2-2863-465a-0503-08d664bc77a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 07:43:14.1702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3752
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Paul Gortmaker [mailto:paul.gortmaker@windriver.com]
> Sent: Montag, 17. Dezember 2018 21:31
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
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

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

