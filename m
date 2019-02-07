Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05155C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4498218B0
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TdjGdZhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfBGJwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:52:53 -0500
Received: from mail-eopbgr40051.outbound.protection.outlook.com ([40.107.4.51]:42153
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726727AbfBGJww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBCVcyuHI8F17nhIew6FC+NgAS8LkLo3yvFiZ3gRV+4=;
 b=TdjGdZhSnZxTFms1Z2SzT0rnlX3WGskP2JoFouj4kS+qqFqLNuEyxZhK1Q1TAxfJ5zlLxfEuWrSil0+z85oy5hQukaCleMc1g1w+0w5Ck8D/hz+bbEv7lPqlfq8ItSmUtJd27vqBUUVxDSGAIIhJe1PiBjJ5KCgnsbfSorCqrx4=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3702.eurprd04.prod.outlook.com (52.133.28.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Thu, 7 Feb 2019 09:52:47 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1%4]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 09:52:47 +0000
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
        Daniel Baluta <daniel.baluta@nxp.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V6 2/4] thermal: imx_sc: add i.MX system controller thermal
 support
Thread-Topic: [PATCH V6 2/4] thermal: imx_sc: add i.MX system controller
 thermal support
Thread-Index: AQHUvsrh/bRpd0a7WkiScdELFst3Yg==
Date:   Thu, 7 Feb 2019 09:52:46 +0000
Message-ID: <1549532838-27025-2-git-send-email-Anson.Huang@nxp.com>
References: <1549532838-27025-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1549532838-27025-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0190.apcprd02.prod.outlook.com
 (2603:1096:201:21::26) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3702;6:hxLIwiM47xFJe4FqXgvMhQpWuHjHzRaz5Ag3McCmHL3G/jGHUFOnsJJDnOw1jP4+zRUFW8wj67NfurBC5dOvPgFCpS91wkhod2Ra+zZU8vjec80PosGqtGcSfUiyo4sBFDkWIM3jPao/GVqhP6gIp/v0dtECKhl6mVhEgtz1kVZJ9n7Xgkm+dAzeMCLPr82yoVQuts+rbgDXf72wbZ8Q4ky7FOKbf8NTo+zN6uXGQyY7t5ZMrwdwqPC7yG6KMeRlVUA7Q4sBhePI5rDeqOCSeKh6uz44JMzi1kp2CwEwjbgscEZrOWnLVvGxiB7Qsarn+ydC6ABkxnjhTQ79Es61vtXPC+vZS7zgXdbn9RDV9x6prXI2ukHNKkQLfZLwVdrOohpjIiYUEFPRFWdhUhtA3G1xtINgVc96C4LYMYb7dp3SyTdNP9Uu1QHzUAk8HYsFe3TUlrTQ1Va6oOQP9YNdgA==;5:asd2s+QWkpzYogw9k/SQT3bKHkX9W81JdzXhRhkSO7veORs26HUoxA4aML4/20JPxVua7hvGvRg4RtrZ+kuoGDyHCf8NyLXAn6nocINsqFIyfXA5XgYhiJYwqxxpRuri+uRQNLxitmCXznnfsxas01klJ/c2GrGdhKVS8M0IALd77kMzAs43XzzCGyFpT44avCNPFeLUWdQ5td92coVlww==;7:R6HZThVfkDZsudf8TxRQTJ5W77NazxPAlOgXpPmZHkJ5uoMVyhMYbB9ACutmkcxR1846z1eIod09E+JGIKuC4yrEy3jyFm6u6knNnPtnmOoCEWyYVTersYneb/aK+pQmQazCcV5cabQlj1yB1/vYFg==
x-ms-office365-filtering-correlation-id: 37f8de90-f91b-441b-e3b3-08d68ce2035b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3702;
x-ms-traffictypediagnostic: AM6PR0402MB3702:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR0402MB3702EA1A9EFC511654D5E22CF5680@AM6PR0402MB3702.eurprd04.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(396003)(136003)(346002)(199004)(189003)(54534003)(386003)(66066001)(97736004)(316002)(6506007)(26005)(7416002)(102836004)(110136005)(86362001)(71190400001)(52116002)(68736007)(71200400001)(99286004)(36756003)(2201001)(76176011)(6436002)(6116002)(53936002)(25786009)(256004)(478600001)(3846002)(476003)(446003)(81156014)(8676002)(11346002)(81166006)(50226002)(2616005)(6512007)(486006)(305945005)(7736002)(2906002)(8936002)(186003)(106356001)(2501003)(105586002)(4326008)(14454004)(6486002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3702;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BJoHsyqYYwC+yjOk9j3k0RVqXFp2DLybfRvlv1TtR39h3G+bZoOLDKFSiIJsGf2OYwOCldsjG6JtVPx2BPj5An2nYTPaDzx7ng2TlDTxa+foKIcblDxYho4eeD7RV/ptAVSETFDpNg/dljHsbJuEGx4wso6thUXEjLWpz0PKBEmV+z55II5xtX78RPEjAK4kar6uhd+kE5Ph81ImeQaFD9Fd4RpeN9eDeNyoHrNZ8xuhFfGdOJFbFqs8YuNbZzLg61LV0A10bdA2tUnN+q7BJccg1swc8a4WT2OaE6IY6Ishr2hyBDW+RPpgS952p8sxO/Ufynm1PN5BQFgHAqhrktn1lyUUaPRy2R6pcAW0Ye085fanJCUZ8UaJACZb4tRnnD1eeXDGBJ3ewfoU3kgj6LF7KuX0VcjJPw8/ZdAWxyg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f8de90-f91b-441b-e3b3-08d68ce2035b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 09:52:38.3236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3702
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
ChangeLog since V5:
	- instead of abusing common thermal sensor ID, add a property in each ther=
mal zone to pass
	  resource id to thermal driver.
---
 drivers/thermal/Kconfig          |  11 +++
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/imx_sc_thermal.c | 161 +++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 173 insertions(+)
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
index 0000000..fc0bb7e
--- /dev/null
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -0,0 +1,161 @@
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
+struct imx_sc_thermal_data {
+	struct imx_sc_sensor *sensor;
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
+	struct device_node *np =3D pdev->dev.of_node;
+	struct device_node *sensor_np =3D NULL;
+	struct imx_sc_thermal_data *data;
+	struct imx_sc_sensor *sensors;
+	u32 sensor_num;
+	int ret, i;
+
+	ret =3D imx_scu_get_handle(&thermal_ipc_handle);
+	if (ret)
+		return ret;
+
+	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ret =3D of_property_read_u32(np, "tsens-num", &sensor_num);
+	if (ret || !sensor_num) {
+		dev_err(&pdev->dev, "failed to get valid temp sensor number!\n");
+		return -EINVAL;
+	}
+
+	sensors =3D devm_kzalloc(&pdev->dev, sizeof(*data->sensor) * sensor_num,
+			       GFP_KERNEL);
+	if (!sensors)
+		return -ENOMEM;
+
+	data->sensor =3D sensors;
+
+	np =3D of_find_node_by_name(NULL, "thermal-zones");
+	if (!np)
+		return -ENODEV;
+
+	for (i =3D 0; i < sensor_num; i++) {
+		struct imx_sc_sensor *sensor =3D &data->sensor[i];
+
+		sensor_np =3D of_get_next_child(np, sensor_np);
+		ret =3D of_property_read_u32(sensor_np, "imx,sensor-resource-id",
+			&sensor->resource_id);
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
+	of_node_put(np);
+	of_node_put(sensor_np);
+
+	return ret;
+}
+
+static const struct of_device_id imx_sc_thermal_table[] =3D {
+	{ .compatible =3D "fsl,imx8qxp-sc-thermal", },
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

