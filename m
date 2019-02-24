Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64DCC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 02:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDE0206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 02:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P3PkkZvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfBXCuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 21:50:22 -0500
Received: from mail-eopbgr130043.outbound.protection.outlook.com ([40.107.13.43]:14820
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726405AbfBXCuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 21:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aN2hxg9MH/QYU51I2U88BGfR0AGtuK/gNUqp4JiBmSs=;
 b=P3PkkZvJgk84oCQI0Aca+J8xIq0N6I1aKeFgyD7C7Z7lUB/rU2viqXzoyGPTswQDrWHBNgR0X0ZcQFAf4wD8IrtfeLfrMaRRuPZHQTZgtSqcQAW72l9UOZpTdUN1GnSiPTKxXvWAEkokdlCxLuGCmWq+7B5LmgjR6XoJ7QCRL0g=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3865.eurprd04.prod.outlook.com (52.134.73.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Sun, 24 Feb 2019 02:50:13 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Sun, 24 Feb 2019
 02:50:13 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V9 2/4] thermal: imx_sc: add i.MX system controller thermal
 support
Thread-Topic: [PATCH V9 2/4] thermal: imx_sc: add i.MX system controller
 thermal support
Thread-Index: AQHUy+uqPMkufWKZK061slXkp9mayQ==
Date:   Sun, 24 Feb 2019 02:50:13 +0000
Message-ID: <1550976319-20216-2-git-send-email-Anson.Huang@nxp.com>
References: <1550976319-20216-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550976319-20216-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0145.apcprd02.prod.outlook.com
 (2603:1096:202:16::29) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1ccef00-c944-44ee-b7e8-08d69a02cc70
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3865;
x-ms-traffictypediagnostic: DB3PR0402MB3865:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3865;23:SVaJPWDeIGZTWocGtushW1wkKkccuyTLiWrBQ?=
 =?iso-8859-1?Q?WkEh5ZOFgCVIbtFR6EJhXXOn+9HkBUKXf0gOdkU24SiFdzSoXWZOePnYSj?=
 =?iso-8859-1?Q?fgBuclVaOVXHlpZPHvY76yA3kW2ZaRohLsF2Azb1wW/YJtT/vHNF+M01Jf?=
 =?iso-8859-1?Q?k/NidRdJNQOruXbTg2yodF4gGTz+PoQV1+KcvuiJLp0XP/fysbvciLbM6w?=
 =?iso-8859-1?Q?7Lq4FcNWDO7IBswvqlnXRpiNJBI0zjRg1Flyz/3d6p61i1NbInHewiP66g?=
 =?iso-8859-1?Q?h2lgoQC9iWT11hHHLvK4GshJmVde4vIpFC6II99DwTQsE7CE/Kng7Tp/jU?=
 =?iso-8859-1?Q?z9Z3kbAHYkCZeHFv4el0r8q6E3+5ml41nWCFcX7XRqk3/9IfkLxHvkYdf/?=
 =?iso-8859-1?Q?8D3/IatO8eQwIDcPljZEbI1M/frKQ5GhY3fTVxTDSB+Ag8B2VcSWkuaYDi?=
 =?iso-8859-1?Q?CKaB7E621QzIb8yftblJTqDykFblnGe48/RG1/KUDJn02JCbS/982pZjED?=
 =?iso-8859-1?Q?O0jxriCR+4uNmpSk9/6ZFDEQnZLf8WaREzSii7BiAA6u5HKWyQtToMgWrJ?=
 =?iso-8859-1?Q?n/QzV/knTjOg0L1C+6JuEjJQHPuj/lshLuI8EOFXhqo66kkNDopscbtRPw?=
 =?iso-8859-1?Q?kAfOgUlnmi2aYE9XyboPEsGNAUrFhQ83xfbTZvCTaCCuAqJE7adJa34y/V?=
 =?iso-8859-1?Q?urDSi2axPEreVjV5X8/i2BrZ1eQAsQYY4sM1iE4K1mByjsU0nHid14uDSc?=
 =?iso-8859-1?Q?rCsaxnoEJrv8GD9u22220Gil2G4Om9/BpqB15GSKKiOtoZ85zGdE6XN2ui?=
 =?iso-8859-1?Q?NT9YkoRCo36LpOmQFNvDvnCbEdNh4RKYa8NwMTFYHZm2ZHjEQV355Mmkf4?=
 =?iso-8859-1?Q?yihMDnRUkItWui1+IqS2YtxeI267J3hno6bE8VpcIs+o1YkdeNno998+UV?=
 =?iso-8859-1?Q?YSa7zGG0hQURweij3KaIjfyrTg/77Xs3MdhjCfLy2Hr7xgp0KlqkU2QtCn?=
 =?iso-8859-1?Q?ycYHNlGT9DEh8C4buTGeOtWiAfPP78Os2Yjq7XTJQ8TA8+QlIyG9eD6T55?=
 =?iso-8859-1?Q?mWyMZpFAqQkYllGQFbdHjxy/y2WvWmWrw/Z3nHXJqeFBg5MfCEtdSh7xOE?=
 =?iso-8859-1?Q?qkfTMd/CAEURw4lo8v0HwcS0A29QHM8kvmvOEGPfSn1RWRnBXzelXF/Kvd?=
 =?iso-8859-1?Q?DxjF7hE+Upj7f4hMTV+2gS2xxV1pe3cSHEULagayR3gw4OWZL83XOjqLEp?=
 =?iso-8859-1?Q?dq7p3Vd8y4PHxrGgDZMrP2K5KaPD4m8krA/+0Oc+n9W6obF4pX0dtnQCCM?=
 =?iso-8859-1?Q?RUHk=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB386571EED0BC7E7B73BF1FC5F5790@DB3PR0402MB3865.eurprd04.prod.outlook.com>
x-forefront-prvs: 09583628E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39850400004)(396003)(136003)(346002)(376002)(189003)(199004)(110136005)(478600001)(4326008)(316002)(66066001)(256004)(3846002)(6116002)(36756003)(2501003)(52116002)(7416002)(99286004)(14454004)(6486002)(76176011)(71200400001)(71190400001)(8676002)(6436002)(53936002)(106356001)(2201001)(6506007)(386003)(86362001)(6512007)(7736002)(305945005)(68736007)(50226002)(97736004)(11346002)(8936002)(486006)(26005)(81166006)(2906002)(186003)(2616005)(5660300002)(476003)(81156014)(25786009)(446003)(102836004)(105586002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3865;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PH1TzirzcyslzoPy/zSQ4QbEc+5bqnz5/LcmO9OO7zMhBYplWF5ndNM+9mxYjEzHH3WWE0ZkjXLGCUsZRAGApUlyue7YmIyoMQ4oV4frQ5qYwkkBQ9QfQCorptSKs1ZHK05Jkl34t6uciJGOJWseBavGiOyAVd5JYF+9d1C/JheBRJ7fZ8WlEyOFznQFKw3+nQb6LJ7QWkE/VYNQ0Bi2v9flVefkp0aSdZmUArzuWGN7b2YeygGo5OdBeFHbsA2IzDIdykqdubo3DNbWG+1yz9OQugGoLOjkfDfEHMpH5fGS5lljjsIobz2rui4daJMQ2EdiPNLXSkUC2wrBGQFHboTp3hrM+nXciAL/LiygeWOvbmbylQ26kigrQj9DdB0PMNBR4/yE7v3SdVEN5+JdrEIuJwihAHLKXszWb2HQd1U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ccef00-c944-44ee-b7e8-08d69a02cc70
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 02:50:04.1992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3865
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
inside, the system controller is in charge of controlling power,
clock and thermal sensors etc..

This patch adds i.MX system controller thermal driver support,
Linux kernel has to communicate with system controller via MU
(message unit) IPC to get each thermal sensor's temperature,
it supports multiple sensors which are passed from device tree,
please see the binding doc for details.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V8:
	- get thermal zones number from "imx,sensor-resource-id" element count, so=
 that we get get rid
	  of searching thermal-zones node;
	- use "pdev->dev.of_node" directly instead of getting phandle from thermal=
-zones node.
---
 drivers/thermal/Kconfig          |  11 ++++
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/imx_sc_thermal.c | 139 +++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 151 insertions(+)
 create mode 100644 drivers/thermal/imx_sc_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 58bb7d7..fec0ef5 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -223,6 +223,17 @@ config IMX_THERMAL
 	  cpufreq is used as the cooling device to throttle CPUs when the
 	  passive trip is crossed.
=20
+config IMX_SC_THERMAL
+	tristate "Temperature sensor driver for NXP i.MX SoCs with System Control=
ler"
+	depends on (ARCH_MXC && IMX_SCU) || COMPILE_TEST
+	depends on OF
+	help
+	  Support for Temperature Monitor (TEMPMON) found on NXP i.MX SoCs with
+	  system controller inside, Linux kernel has to communicate with system
+	  controller via MU (message unit) IPC to get temperature from thermal
+	  sensor. It supports one critical trip point and one
+	  passive trip point for each thermal sensor.
+
 config MAX77620_THERMAL
 	tristate "Temperature sensor driver for Maxim MAX77620 PMIC"
 	depends on MFD_MAX77620
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 486d682..4062627 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_DB8500_THERMAL)	+=3D db8500_thermal.o
 obj-$(CONFIG_ARMADA_THERMAL)	+=3D armada_thermal.o
 obj-$(CONFIG_TANGO_THERMAL)	+=3D tango_thermal.o
 obj-$(CONFIG_IMX_THERMAL)	+=3D imx_thermal.o
+obj-$(CONFIG_IMX_SC_THERMAL)	+=3D imx_sc_thermal.o
 obj-$(CONFIG_MAX77620_THERMAL)	+=3D max77620_thermal.o
 obj-$(CONFIG_QORIQ_THERMAL)	+=3D qoriq_thermal.o
 obj-$(CONFIG_DA9062_THERMAL)	+=3D da9062-thermal.o
diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_ther=
mal.c
new file mode 100644
index 0000000..e9a8207
--- /dev/null
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018-2019 NXP.
+ */
+
+#include <linux/err.h>
+#include <linux/firmware/imx/sci.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+
+#include "thermal_core.h"
+
+#define IMX_SC_MISC_FUNC_GET_TEMP	13
+#define IMX_SC_C_TEMP			0
+
+static struct imx_sc_ipc *thermal_ipc_handle;
+
+struct imx_sc_sensor {
+	struct thermal_zone_device *tzd;
+	u32 resource_id;
+};
+
+struct req_get_temp {
+	u16 resource_id;
+	u8 type;
+} __packed;
+
+struct resp_get_temp {
+	u16 celsius;
+	u8 tenths;
+} __packed;
+
+struct imx_sc_msg_misc_get_temp {
+	struct imx_sc_rpc_msg hdr;
+	union {
+		struct req_get_temp req;
+		struct resp_get_temp resp;
+	} data;
+} __packed;
+
+static int imx_sc_thermal_get_temp(void *data, int *temp)
+{
+	struct imx_sc_msg_misc_get_temp msg;
+	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
+	struct imx_sc_sensor *sensor =3D data;
+	int ret;
+
+	msg.data.req.resource_id =3D sensor->resource_id;
+	msg.data.req.type =3D IMX_SC_C_TEMP;
+
+	hdr->ver =3D IMX_SC_RPC_VERSION;
+	hdr->svc =3D IMX_SC_RPC_SVC_MISC;
+	hdr->func =3D IMX_SC_MISC_FUNC_GET_TEMP;
+	hdr->size =3D 2;
+
+	ret =3D imx_scu_call_rpc(thermal_ipc_handle, &msg, true);
+	if (ret) {
+		pr_err("read temp sensor %d failed, ret %d\n",
+			sensor->resource_id, ret);
+		return ret;
+	}
+
+	*temp =3D msg.data.resp.celsius * 1000 + msg.data.resp.tenths * 100;
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops imx_sc_thermal_ops =3D {
+	.get_temp =3D imx_sc_thermal_get_temp,
+};
+
+static int imx_sc_thermal_probe(struct platform_device *pdev)
+{
+	int ret, tsen_num, i;
+
+	ret =3D imx_scu_get_handle(&thermal_ipc_handle);
+	if (ret)
+		return ret;
+
+	tsen_num =3D of_property_count_elems_of_size(pdev->dev.of_node,
+						   "imx,sensor-resource-id",
+						   sizeof(u32));
+	if (tsen_num <=3D 0) {
+		dev_err(&pdev->dev,
+			"failed to get valid sensor number: %d\n", tsen_num);
+		return -EINVAL;
+	}
+
+	for (i =3D 0; i < tsen_num; i++) {
+		struct imx_sc_sensor *sensor =3D
+			devm_kzalloc(&pdev->dev, sizeof(*sensor), GFP_KERNEL);
+		if (!sensor)
+			return -ENOMEM;
+
+		ret =3D of_property_read_u32_index(pdev->dev.of_node,
+			"imx,sensor-resource-id", i, &sensor->resource_id);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"failed to get valid sensor resource id: %d\n",
+				ret);
+			break;
+		}
+
+		sensor->tzd =3D devm_thermal_zone_of_sensor_register(&pdev->dev,
+								   i,
+								   sensor,
+								   &imx_sc_thermal_ops);
+		if (IS_ERR(sensor->tzd)) {
+			dev_err(&pdev->dev, "failed to register thermal zone\n");
+			ret =3D PTR_ERR(sensor->tzd);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static const struct of_device_id imx_sc_thermal_table[] =3D {
+	{ .compatible =3D "fsl,imx-sc-thermal", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, imx_sc_thermal_table);
+
+static struct platform_driver imx_sc_thermal_driver =3D {
+		.probe =3D imx_sc_thermal_probe,
+		.driver =3D {
+			.name =3D "imx-sc-thermal",
+			.of_match_table =3D imx_sc_thermal_table,
+		},
+};
+module_platform_driver(imx_sc_thermal_driver);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("Thermal driver for NXP i.MX SoCs with system controlle=
r");
+MODULE_LICENSE("GPL v2");
--=20
2.7.4

