Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F459C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B64A21850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f/FGmnvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbeLSKMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:12:23 -0500
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:5931
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728714AbeLSKMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:12:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGsXDO7P957BKFs9UEtE52jcWeiDU7HqehmhD4NBdyU=;
 b=f/FGmnvQoQmJalPww3oNfW7uQBZw5vgoDVIcJBMii0rUg8ZntCjPmBx8j7PnRYUA5MRuJigXhQY227O979Kuy0zei4VLT5Vi2T65WjEsQG3F7mqft4xKmfK8dyObHY7/z7KOso+C4ZX2tvOGWaZxTrU3X/7m9WUuN58yqIt37u0=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5490.eurprd04.prod.outlook.com (20.178.115.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Wed, 19 Dec 2018 10:12:12 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.024; Wed, 19 Dec 2018
 10:12:12 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 2/4] rtc: add i.MX system controller RTC support
Thread-Topic: [PATCH V4 2/4] rtc: add i.MX system controller RTC support
Thread-Index: AQHUh4Xdr+AyS6mQK0O0uEwcLIV+4aWF8YZA
Date:   Wed, 19 Dec 2018 10:12:12 +0000
Message-ID: <AM0PR04MB4211498611A15A70D41A492E80BE0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1543455856-18021-1-git-send-email-Anson.Huang@nxp.com>
 <1543455856-18021-3-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543455856-18021-3-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5490;6:7sLBZCEsryRLZ7S8W+j6MRMIayFbWNm3Inn2vvK9JZlDf6lYqTlgU6/c0wuPFnFvbL3+k8KqqUDtvLY3tuea5+X8DwjozhdvCsBAZ4JNZgcIIHMKkNemr4++zwzwaHIrW0YO0wv+1fKs0wXcOEc/uoQs54BivQZ8QaHs1MDnzHtodiL0xBuhZ631E88ZKyrdDBVWH3H8A74IlTPEAV2l9QzTVxgfW8m7Rodarm1U4wSRenwKkJVuitLmG2QQDWo/SIjItAzuV19bPOFB8xR170VS00D4OJCnoZqY6dt58n5NSXC6IsFpdT8MA+XwAwf0f60da6ozjYTfA+hIq8To1XaRDV3r+vnwECk8QXqAY89rW1E71PKKxTyIy+pj9GCUuvjRE3SVofWFHC49eDQntf3wMuwMFfMHMTerPI0tCYuEFtncmH94es8OjAbDNGXJAaIQ2SLTnI37XmBLqvCSmA==;5:EeFA0suEBFEHAES3D4+LqReISLW7XY0kUBfV4KoOKzGMQWAc5TYFht+I7/QTat2L0i7AqtEBWbOlY4PXfQ6g706Xjjak9SyfdcqpZV3FLcCGpIKuffPGGejjxQhwi+jxKwYYoPRJYasOct/BjjsHJz5MAoWW19B6c8h2Jizkdug=;7:FrD7JH/9AkBXzunqazVbQSlddQrFQELCdB4d1ViF7cB6xtIYb7ueICTp6CN+l5NYLQZOz83/Q7AcdR06RLb3Yg1mgIV2Bo1PetOcUHFr6m/w9D2Hf52IYos+fDRJS9volpu2Auzg2mRGAkh64fySFg==
x-ms-office365-filtering-correlation-id: 5ee2158c-8fae-4e30-048a-08d6659a71cc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5490;
x-ms-traffictypediagnostic: AM0PR04MB5490:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB5490DF20249E3C9AFFB651CE80BE0@AM0PR04MB5490.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5490;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5490;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(39860400002)(396003)(54534003)(13464003)(199004)(189003)(8936002)(76176011)(186003)(486006)(2201001)(86362001)(14454004)(44832011)(476003)(6506007)(55016002)(7416002)(6246003)(316002)(26005)(68736007)(25786009)(229853002)(7696005)(14444005)(102836004)(99286004)(446003)(11346002)(8676002)(81166006)(81156014)(478600001)(256004)(71190400001)(71200400001)(6436002)(97736004)(7736002)(33656002)(74316002)(305945005)(2906002)(9686003)(110136005)(3846002)(6116002)(2501003)(66066001)(106356001)(53936002)(5660300001)(105586002)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5490;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qv+XDHHYxUGVLBpn1zBeHoecJctfbDJYWwd0ygHNMmDN4rxr4ioZR20bCaVqCwZ5c41rXr6/7SrRdKacWN4dxFwC7zJAVbiStDRrEgF6Silk9Iy3e+YkIzKAxE4KITwCGhyWmlb46bPZ/AJiIDgmMH/JGFvwVH8Q9I4PSaph0XcoTRoNXRDv1tCzf8uuOP5ws9PLBQW+HvoLJuKYzRdtZipqPwjPNwJGgk5qHW3DfmcZk92IV9rQB3A+6hV1kXmov/M5dHWTnb2UquY1aWQZVnVtpIE4bUc19/ruaE5A7ttVyZd+jlglzEdC5FQ5eVgt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee2158c-8fae-4e30-048a-08d6659a71cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 10:12:12.6818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5490
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Anson Huang
> Sent: Thursday, November 29, 2018 9:50 AM
[...]
> i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller inside,
> the system controller is in charge of controlling power, clock and secure=
 rtc
> etc..
>=20
> This patch adds i.MX system controller RTC driver support, Linux kernel h=
as to
> communicate with system controller via MU (message unit) IPC to set/get R=
TC
> time and other alarm functions, since the RTC set time needs to be done i=
n
> secure EL3 mode (required by system controller firmware) and alarm functi=
ons
> needs to be done with general MU IRQ handle, these depend on other
> components which are NOT ready, so this patch ONLY enables the RTC time
> read.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> ChangeLog:
> V3->V4:
>   *remove unnecessary headfile included;
>   *fix potential memory currpution for the message responce;
>   *update the compatible string name to start with "fsl" instead of "nxp"=
.
>  drivers/rtc/Kconfig      |  6 +++
>  drivers/rtc/Makefile     |  1 +
>  drivers/rtc/rtc-imx-sc.c | 98
> ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+)
>  create mode 100644 drivers/rtc/rtc-imx-sc.c
>=20
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig index a819ef0..3b9=
642e
> 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1677,6 +1677,12 @@ config RTC_DRV_SNVS
>  	   This driver can also be built as a module, if so, the module
>  	   will be called "rtc-snvs".
>=20
> +config RTC_DRV_IMX_SC
> +	tristate "NXP i.MX System Controller RTC support"

This should depend on IMX_SCU

> +	help
> +	   If you say yes here you get support for the NXP i.MX System
> +	   Controller RTC module.
> +
>  config RTC_DRV_SIRFSOC
>  	tristate "SiRFSOC RTC"
>  	depends on ARCH_SIRF
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile index 290c173..f=
97c05e
> 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -75,6 +75,7 @@ obj-$(CONFIG_RTC_DRV_GOLDFISH)	+=3D rtc-goldfish.o
>  obj-$(CONFIG_RTC_DRV_HID_SENSOR_TIME) +=3D rtc-hid-sensor-time.o
>  obj-$(CONFIG_RTC_DRV_HYM8563)	+=3D rtc-hym8563.o
>  obj-$(CONFIG_RTC_DRV_IMXDI)	+=3D rtc-imxdi.o
> +obj-$(CONFIG_RTC_DRV_IMX_SC)	+=3D rtc-imx-sc.o
>  obj-$(CONFIG_RTC_DRV_ISL12022)	+=3D rtc-isl12022.o
>  obj-$(CONFIG_RTC_DRV_ISL12026)	+=3D rtc-isl12026.o
>  obj-$(CONFIG_RTC_DRV_ISL1208)	+=3D rtc-isl1208.o
> diff --git a/drivers/rtc/rtc-imx-sc.c b/drivers/rtc/rtc-imx-sc.c new file=
 mode
> 100644 index 0000000..5976a2e
> --- /dev/null
> +++ b/drivers/rtc/rtc-imx-sc.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2018 NXP.
> + */
> +
> +#include <linux/firmware/imx/sci.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/rtc.h>
> +
> +#define IMX_SC_TIMER_FUNC_GET_RTC_SEC1970	9
> +#define IMX_SC_TIMER_FUNC_SET_RTC_TIME		6
> +
> +static struct imx_sc_ipc *rtc_ipc_handle; static struct rtc_device
> +*imx_sc_rtc;
> +
> +struct imx_sc_msg_timer_get_rtc_time {
> +	struct imx_sc_rpc_msg hdr;
> +	u32 time;
> +} __packed;
> +
> +static int imx_sc_rtc_read_time(struct device *dev, struct rtc_time
> +*tm) {
> +	struct imx_sc_msg_timer_get_rtc_time msg;
> +	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
> +	int ret;
> +
> +	hdr->ver =3D IMX_SC_RPC_VERSION;
> +	hdr->svc =3D IMX_SC_RPC_SVC_TIMER;
> +	hdr->func =3D IMX_SC_TIMER_FUNC_GET_RTC_SEC1970;
> +	hdr->size =3D 1;
> +
> +	ret =3D imx_scu_call_rpc(rtc_ipc_handle, &msg, true);
> +	if (ret) {
> +		pr_err("read rtc time failed, ret %d\n", ret);

Nitpick:=20
better to use dev_err?

> +		return ret;
> +	}
> +
> +	rtc_time_to_tm(msg.time, tm);
> +
> +	return 0;
> +}
> +
> +static const struct rtc_class_ops imx_sc_rtc_ops =3D {
> +	.read_time =3D imx_sc_rtc_read_time,
> +};
> +
> +static int imx_sc_rtc_probe(struct platform_device *pdev) {
> +	int ret;
> +
> +	ret =3D imx_scu_get_handle(&rtc_ipc_handle);
> +	if (ret) {
> +		if (ret =3D=3D -EPROBE_DEFER)
> +			return ret;
> +
> +		dev_err(&pdev->dev, "failed to get ipc handle: %d!\n", ret);
> +		return ret;
> +	}

You don't have to handle different error cases as API has already enclosed =
it.

> +
> +	imx_sc_rtc =3D devm_rtc_allocate_device(&pdev->dev);
> +	if (IS_ERR(imx_sc_rtc)) {
> +		ret =3D PTR_ERR(imx_sc_rtc);
> +		return ret;

Return PTR_ERR(imx_sc_rtc)

Regards
Dong Aisheng

> +	}
> +
> +	imx_sc_rtc->ops =3D &imx_sc_rtc_ops;
> +	imx_sc_rtc->range_min =3D 0;
> +	imx_sc_rtc->range_max =3D U32_MAX;
> +
> +	ret =3D rtc_register_device(imx_sc_rtc);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register rtc: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id imx_sc_dt_ids[] =3D {
> +	{ .compatible =3D "fsl,imx8qxp-sc-rtc", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, imx_sc_dt_ids);
> +
> +static struct platform_driver imx_sc_rtc_driver =3D {
> +	.driver =3D {
> +		.name	=3D "imx-sc-rtc",
> +		.of_match_table =3D imx_sc_dt_ids,
> +	},
> +	.probe		=3D imx_sc_rtc_probe,
> +};
> +module_platform_driver(imx_sc_rtc_driver);
> +
> +MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
> +MODULE_DESCRIPTION("NXP i.MX System Controller RTC Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.7.4

