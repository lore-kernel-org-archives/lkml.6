Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B263C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBA220989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YaItCvj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CBA220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbeK2CtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:49:02 -0500
Received: from mail-eopbgr00081.outbound.protection.outlook.com ([40.107.0.81]:9244
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727979AbeK2CtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWVy8G6o/MYY5vTPchhHWfl6x1tcAx2PvDyr6z7hf0I=;
 b=YaItCvj2DDAtU0lCBMOw8kyveMYE6z/AVof/1pHNll0tgFoqOj6bvi2xkzHXVG/XHuaYJiAHMKghFkGGc+UTsFmVqpiFmvnEsNGt6bmfsENvBLIYiS0gLeyISZQSDg8LuxcjJheikaOV6SHA2d0zHdoFkyAR5IZxnU1jtFWTff4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5089.eurprd04.prod.outlook.com (20.177.40.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Wed, 28 Nov 2018 15:44:58 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 15:44:58 +0000
From:   Aisheng DONG <aisheng.dong@nxp.com>
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
Subject: RE: [PATCH V3 2/4] rtc: add i.MX system controller RTC support
Thread-Topic: [PATCH V3 2/4] rtc: add i.MX system controller RTC support
Thread-Index: AQHUhwDI8If5InxlmEGlSMOzFmMDVKVlUt1A
Date:   Wed, 28 Nov 2018 15:44:58 +0000
Message-ID: <AM0PR04MB4211140489B0BE1DEC4165B880D10@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1543398696-3140-1-git-send-email-Anson.Huang@nxp.com>
 <1543398696-3140-3-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543398696-3140-3-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5089;6:Ua5sZnyY70dKKvfttAHFzjm7IjUa/AKTdZSPVhj6dS9HsvQ5XXq37XC1tj5Yb81KS/DceanLPOCNatrja4CTb+UQX39QI4y13Z93/M0350tpfJ2mtYXfvNx4lbFMGEhemFJs8EjSGM9muqpPtAGVAwn+X35ohT+mII/VUixrYTzoZcMuDeIyP5G/YiUV+rjXvEA4SGig0cssUgNmfQDchuztLDH7EGLeJ75vGbo9y3LnpZkMGMLvRS4y+j3TqHUhCT7xD/Yp4Ye3L86ARl8bEv1NoNn/yM+qD1cHwuEXFSDNFlyaZV9vdZUfxSNsvyEjjx+Y7gS84CRd/vB62k7OonLllTxHu8tr2sZ8ZAwyV8xqVI+Dqz8hmVThosFoOfXW5cD/zq+aXJuxStFA23YyPeYUULBuMJLPrZO6JYLkoBOuiV8OXuE/36E538gB6KpsfZPqjRJV/todazLi82TwPg==;5:XIQkMAHzsr0e/O2wVCx4PeIjfbhPyj130Y+c0Cppel6x3dpXeleMfimaudHmBIx4kvkIklNKyfd0Zg/a59mhWThuOaI1SupuxL6Grsq5zXf30Q5nTKgm/nEs7EjooIlJ1IUFAnHttwsX6q1PrSdvRYYIs5c1j9uRITiTX6akyK0=;7:NHapGr+YMlo/kCxk917jUw8XN85wIFOTXM2t4HBzFU2w1sixpwzmy+ZSgTDYU1wc6v2+YTZNfxVMPSPzY48SXiUocuB+yYAyvXlDF7BfYA56K5k+iG84MpgQ8rmoLthrh96cOKfwOHOUWnWrwr5Cdg==
x-ms-office365-filtering-correlation-id: 119abb43-eeea-42fa-fe22-08d6554873a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5089;
x-ms-traffictypediagnostic: AM0PR04MB5089:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB5089FFC36725FE4889AFF38680D10@AM0PR04MB5089.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231443)(999002)(944501410)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5089;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5089;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(366004)(136003)(39860400002)(54534003)(13464003)(199004)(189003)(476003)(8676002)(2201001)(256004)(81166006)(106356001)(81156014)(11346002)(486006)(446003)(66066001)(8936002)(105586002)(2906002)(6436002)(7416002)(2501003)(4326008)(7736002)(305945005)(102836004)(74316002)(71190400001)(86362001)(5660300001)(99286004)(6116002)(6246003)(25786009)(3846002)(68736007)(71200400001)(6506007)(7696005)(229853002)(76176011)(53936002)(26005)(53546011)(110136005)(55016002)(97736004)(9686003)(33656002)(186003)(478600001)(316002)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5089;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mg52Dbkdh5o3z2Awf/T+iV33VVy9IIkmKf4G0EA4mqQ6O/JtaMSIY5y0BU7uHSbCb8Ff/Ts65G07KRMkEfuHUojFwQ5y58jMZwHbzOJB2RIyC9CaVe7V7THYE8YB13OebUEn7waXoqDLC9FIvCKC3O+XCjCUoEzw7VJ08yx5UZ38vWByW907MjkGlkFMVES8ZnBSezx4BydHsgZg1eeq2x3AXl178aiCEllNYnaaAvJXqoZHPXveea2peyT4CyW90HxkodVQx11p8vJadEd75zqrClygjOBPSvl+1rldJV4ZintM8F0KCm2V6gYYZ+wqmPnXuJtuw0bdUReQhlcVaFC4itk4AdbmTa0l8V9bsFY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 119abb43-eeea-42fa-fe22-08d6554873a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 15:44:58.3434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Anson Huang
> Sent: Wednesday, November 28, 2018 5:57 PM
[...]
> Subject: [PATCH V3 2/4] rtc: add i.MX system controller RTC support
>=20
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
> changes since V2:
> 	- make rtc_ipc_handle/imx_sc_rtc static;
> 	- remove comma in last entry of imx_sc_dt_ids;
> 	- rename rtc_device.
>  drivers/rtc/Kconfig      |   6 +++
>  drivers/rtc/Makefile     |   1 +
>  drivers/rtc/rtc-imx-sc.c | 107

This change log format seems strange.

> +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 114 insertions(+)
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
> 100644 index 0000000..b8e331e
> --- /dev/null
> +++ b/drivers/rtc/rtc-imx-sc.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2018 NXP.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>

Do we need them all?

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
> +struct imx_sc_msg_req_timer_get_rtc_time {
> +	struct imx_sc_rpc_msg hdr;
> +} __packed;
> +
> +struct imx_sc_msg_resp_timer_get_rtc_time {
> +	struct imx_sc_rpc_msg hdr;
> +	u32 time;
> +} __packed;
> +
> +static int imx_sc_rtc_read_time(struct device *dev, struct rtc_time
> +*tm) {
> +	struct imx_sc_msg_resp_timer_get_rtc_time *resp;
> +	struct imx_sc_msg_req_timer_get_rtc_time msg;
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
> +		return ret;
> +	}
> +
> +	resp =3D (struct imx_sc_msg_resp_timer_get_rtc_time *)&msg;

This is wrong and may result in memory corruption.
Please refer to how the scu-clk driver does.

Regards
Dong Aisheng

> +	rtc_time_to_tm(resp->time, tm);
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
> +
> +	imx_sc_rtc =3D devm_rtc_allocate_device(&pdev->dev);
> +	if (IS_ERR(imx_sc_rtc)) {
> +		ret =3D PTR_ERR(imx_sc_rtc);
> +		return ret;
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
> +	{ .compatible =3D "nxp,imx8qxp-sc-rtc", },
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

