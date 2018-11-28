Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4012C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA7D2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AIe6w8T1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA7D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeK1Q6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:58:55 -0500
Received: from mail-eopbgr10046.outbound.protection.outlook.com ([40.107.1.46]:18518
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727150AbeK1Q6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 11:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXITK8zdpGCkd7+ESa1whia23Z7lsL/ZxE0F2GkzYGs=;
 b=AIe6w8T1s6R1J5SwlNEmNP3/pRYqpnXlOfUJDHTGriC5xrRdntyYy4G0tkmITFlMMglFveMKynFsGrE2O1wsDEic1E+QTv4rIC4H020YkLiepp7RL+ZftFmIjB26DE44053HGECUmblZrCxyUU/jKRK0wvRIOCnmiXmHJKhI7NI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3691.eurprd04.prod.outlook.com (52.134.66.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 05:58:22 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 05:58:22 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 2/4] thermal: imx_sc: add i.MX system controller thermal
 support
Thread-Topic: [PATCH V2 2/4] thermal: imx_sc: add i.MX system controller
 thermal support
Thread-Index: AQHUht9eRTVB30Mg4kO37c4HVmgbQQ==
Date:   Wed, 28 Nov 2018 05:58:22 +0000
Message-ID: <1543384349-2851-3-git-send-email-Anson.Huang@nxp.com>
References: <1543384349-2851-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543384349-2851-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0010.apcprd03.prod.outlook.com
 (2603:1096:203:2e::22) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3691;6:qcysw8PBSo8pMKFT7U67QOJBkbBq5kQLJLpcIAHvGlcRB17RdblKO3TZLQj7GMNHAjfyE4Mwt0OSqT4pX6KbdGcPg3f2a+noPthQ3RkyOJfezsw8hrjWbHW8xUes7TSQR1MJkTzYab2926KRHpHDeWs+PeIvB3Fm3934s4AV8ydRmjyWHMQrvVpDjd6tGlelM80LDqxlZCeNsLe+bI4/dxV894d9jNbcxbq56chg2xmLtdVGjpbsJH/je3U+7cXJBFLaWQQ038qFy2vMYJ3uP7/nofTxUBkgmDG9gYwOwPxZsLohUmEf2DOssvdPDo25c1WjIowhmEW6g8cefs+9N5wnZ2SMpBK2Wkkf80W+8fIU2ustbYOqTy0mIGITaF/pqZztopuOfYvGTri/HXnQfGoKFNDUTPl71hkuyF17aLXfkfDcuaXZ0JcwWdjb+or/NuMtYhp/WPyHBO3T10gggA==;5:OdYjaKsWy2DKkNBhBHdWfe0EARLSaG+Zc11mqNClYZY8vpK+/2PGIO/2sTsT3gMQCi2VLaPoIfDN0nDgiaiP+KqfBs1XgvAR4KJpCSjZchBLUiaSaQ5mgHXSr8dvjg4ZRnOjqC4Qz0JQodR3HywtFuErbmTbQLVs3RDFzTFONFQ=;7:spkXV5Uvuvpgb6zzzBke4NQjxxHLfWf4+J3lfi5uu6ny3LiAY830CdDEPEb2uPKypSlLaz6jDnFodttGFCCNpefTFEaltV7TNi1HnVEskiRowxrr4HqnW47E5JMaV+fxm/LljP1hFqGpkHnr6n6f1Q==
x-ms-office365-filtering-correlation-id: fc6f2ee4-839d-4c50-3ecd-08d654f68106
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3691;
x-ms-traffictypediagnostic: DB3PR0402MB3691:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3691ACA1052E6D51009BE12BF5D10@DB3PR0402MB3691.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231443)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3691;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3691;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(366004)(376002)(199004)(189003)(256004)(99286004)(14444005)(36756003)(81156014)(2201001)(2501003)(110136005)(86362001)(76176011)(97736004)(6436002)(14454004)(316002)(386003)(68736007)(50226002)(486006)(39060400002)(52116002)(8936002)(81166006)(6506007)(71200400001)(2906002)(11346002)(71190400001)(2616005)(476003)(6486002)(7736002)(305945005)(7416002)(102836004)(53936002)(186003)(478600001)(3846002)(6512007)(105586002)(5660300001)(106356001)(26005)(6116002)(446003)(25786009)(66066001)(8676002)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3691;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pCgQvC4HJHYka9TP20bhAYgyt57lvAhEgIziAXld8YJ47WWL/mcpJyDMYLugrzksvJHXDqsuLO8GF0gYhG7Z9okO8jpR2QzckIFJg4up114QcFZq1c3WzQJiPHo+RPa0zQoEp1LbL5dC7taE7wgq0bxoig3i3DR3BytX5nzGmI4IAhuuq0kLWTWUftYdSPH2TKWb+HyajAnCDC23GvEpTly+CYg4fj1zJ7B2U3jFg07a4jjnNlDuAajXfIcg8b8Nx6KjPp183C15PBDG2FGThsF4vJSVWKvBQYvPlWWleCZ6O+yCSvqhtUgJTW3N8o8t2Kbn/+jMm5+PHcak+No8ceQksKS/ra1Vyxp3BgrX5w8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6f2ee4-839d-4c50-3ecd-08d654f68106
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 05:58:22.5362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3691
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
changes since V1:
	remove boiler plate license text;
	remove unnecessary kfree during probe;
	remove build warning of comparing unsigned int with < 0;
 drivers/thermal/Kconfig          |  11 +++
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/imx_sc_thermal.c | 201 +++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 213 insertions(+)
 create mode 100644 drivers/thermal/imx_sc_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 0e69edc..84e850c 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -222,6 +222,17 @@ config IMX_THERMAL
 	  cpufreq is used as the cooling device to throttle CPUs when the
 	  passive trip is crossed.
=20
+config IMX_SC_THERMAL
+	tristate "Temperature sensor driver for NXP i.MX SoCs with System Control=
ler"
+	depends on ARCH_MXC || COMPILE_TEST
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
index 610344e..1b13f6a 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_DB8500_THERMAL)	+=3D db8500_thermal.o
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
index 0000000..890537f
--- /dev/null
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP.
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
+struct imx_sc_ipc *thermal_ipc_handle;
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
+struct imx_sc_msg_req_misc_get_temp {
+	struct imx_sc_rpc_msg hdr;
+	u16 resource_id;
+	u8 type;
+} __packed;
+
+struct imx_sc_msg_resp_misc_get_temp {
+	struct imx_sc_rpc_msg hdr;
+	u16 celsius;
+	u8 tenths;
+} __packed;
+
+static int imx_sc_thermal_get_temp(void *data, int *temp)
+{
+	struct imx_sc_msg_resp_misc_get_temp *resp;
+	struct imx_sc_msg_req_misc_get_temp msg;
+	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
+	struct imx_sc_sensor *sensor =3D data;
+	int ret;
+
+	msg.resource_id =3D sensor->resource_id;
+	msg.type =3D IMX_SC_C_TEMP;
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
+	resp =3D (struct imx_sc_msg_resp_misc_get_temp *)&msg;
+	*temp =3D resp->celsius * 1000 + resp->tenths * 100;
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops imx_sc_thermal_ops =3D {
+	.get_temp =3D imx_sc_thermal_get_temp,
+};
+
+static int imx_sc_thermal_register_sensor(struct platform_device *pdev,
+					  struct imx_sc_sensor *sensor)
+{
+	struct thermal_zone_device *tzd;
+
+	tzd =3D devm_thermal_zone_of_sensor_register(&pdev->dev,
+						   sensor->resource_id,
+						   sensor,
+						   &imx_sc_thermal_ops);
+	if (IS_ERR(tzd)) {
+		dev_err(&pdev->dev, "failed to register sensor: %d\n",
+			sensor->resource_id);
+		return -EINVAL;
+	}
+
+	sensor->tzd =3D tzd;
+
+	return 0;
+}
+
+static int imx_sc_thermal_get_sensor_id(struct device_node *sensor_np, u32=
 *id)
+{
+	struct of_phandle_args sensor_specs;
+	int ret;
+
+	ret =3D of_parse_phandle_with_args(sensor_np, "thermal-sensors",
+			"#thermal-sensor-cells",
+			0, &sensor_specs);
+	if (ret)
+		return ret;
+
+	if (sensor_specs.args_count >=3D 1) {
+		*id =3D sensor_specs.args[0];
+		WARN(sensor_specs.args_count > 1,
+				"%pOFn: too many cells in sensor specifier %d\n",
+				sensor_specs.np, sensor_specs.args_count);
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
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
+	if (ret) {
+		if (ret =3D=3D -EPROBE_DEFER)
+			return ret;
+
+		dev_err(&pdev->dev, "failed to get ipc handle: %d!\n", ret);
+		return ret;
+	}
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
+		ret =3D imx_sc_thermal_get_sensor_id(sensor_np, &sensor->resource_id);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"failed to get valid sensor resource id: %d\n",
+				ret);
+			break;
+		}
+
+		ret =3D imx_sc_thermal_register_sensor(pdev, sensor);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to register thermal sensor: %d\n",
+				ret);
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
+	{ .compatible =3D "nxp,imx8qxp-sc-thermal", },
+	{},
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

