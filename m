Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D316C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61BF21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IbmuXkta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61BF21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeK2NlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:41:23 -0500
Received: from mail-eopbgr40064.outbound.protection.outlook.com ([40.107.4.64]:60817
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727026AbeK2NlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Xq28o9USIrqfOVSXbIPBcnSA0mFm+2ZGie5S3Xw2jc=;
 b=IbmuXktaXAYD9AImym4YySgPBLt0W824a/sFkFRnPzJ4zzfQkmLzenp2bzWf+pHcAOSa3ezf1BRbJtIvl9eRuzG9y/N6ngbDoZBYkXYxi8s/yIzFc1jfUvDQ49IvVYYOJ6OJjcNFxemWpPsJVncfd7fS+jFYl1k6uEue/8MrOkY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3946.eurprd04.prod.outlook.com (52.134.72.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Thu, 29 Nov 2018 02:37:32 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 02:37:32 +0000
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
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V4 2/4] thermal: imx_sc: add i.MX system controller thermal
 support
Thread-Topic: [PATCH V4 2/4] thermal: imx_sc: add i.MX system controller
 thermal support
Thread-Index: AQHUh4x6dY7vZjVYpE+4w9SclFRzpA==
Date:   Thu, 29 Nov 2018 02:37:32 +0000
Message-ID: <1543458696-4741-3-git-send-email-Anson.Huang@nxp.com>
References: <1543458696-4741-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543458696-4741-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:36::23) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3946;6:XKJxq8cG8v+lMttG/t77ZzobmQtW8aVqeVnrpzv3NTeeoSYfoPUQORoSLEH75fMwA0ZWpS17vt2B1n26DMAnyQ+PIHVFuCjib7PzI3I4MZKs4IzcJ0di9Nrev/21C1xLm/b8otKPvCXwYR6IKAy2Sgbuufbw4+QMXvb+QSgcb8QxSdbbbg5aaEZCrRmvt50ILA8VPlmokRlUhVml2mwNTWZRxtFsbdK+OYr9dxU72+fQDhtuChMOqzAYDKRZk/MiaSgoPmxHkVhg+PquJhFVOUWbFpPMopjsdkW3ztyRHysmRGbKCyXUJHR0gx+owQYty0BYysclEjxEMwibt2gceOddphPaR+Z2RChmvmgg6TvM65ZSPr35unR7BI2wQ3Vh/smODDrEMDmLthuJdRZolktykljTtaLQZ+t/6SAiLp3g39qFbcUr/HKOU4D6rOK1JrAE8eIC6m048oddo33ilQ==;5:bE31FLh5oYDV9QqUejO17wh9yEdtKt4cmk0B2gykljiHr9RprWnSqpnlk5e6Z/VhyUslA4QOF/Pvk23tSk4WJL3Ctuk7x2HHT2x4fCb/ae+9u2pPGns98+mgCWK6oCaj+kmLsIpAnlRx7eGuyS5RrGN9j+mhBLXdYIK7jSxhTpg=;7:eLVk76SmtW7GPT0FcthsQbyxAtHO7op9mdS/yIEoBsagiF2x9mpzO9YaeSF+42e4vy6IfO8brxK44ZCsjzU+YS9ASJybTMQnrTiEr1Drr2S4VQjcIEpFk8zuArO6ed3OEAHmFJuMfSQQccq6zXm95w==
x-ms-office365-filtering-correlation-id: 8a5f7f8e-059a-411c-5c33-08d655a39ce1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3946;
x-ms-traffictypediagnostic: DB3PR0402MB3946:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB39469DAEF668D5C9CAD97514F5D20@DB3PR0402MB3946.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231453)(999002)(944501410)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3946;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3946;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(136003)(366004)(54534003)(199004)(189003)(25786009)(50226002)(99286004)(3846002)(6116002)(478600001)(8936002)(76176011)(14454004)(2201001)(52116002)(316002)(102836004)(106356001)(86362001)(110136005)(186003)(2906002)(26005)(81166006)(81156014)(8676002)(386003)(6506007)(68736007)(6512007)(7736002)(6486002)(6436002)(4326008)(66066001)(71190400001)(53936002)(39060400002)(36756003)(2501003)(71200400001)(305945005)(256004)(14444005)(97736004)(105586002)(486006)(11346002)(446003)(2616005)(476003)(7416002)(5660300001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3946;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BfIi0g28iIOf+wYmsNbBacqzG60ipbSgmb7qQWXWP2HKjnMSVWHDcygrK7soDlOyYV3qe1gFu4QAyGhWqTRvnLql182ltZHo+LQxp9vRQyCPFi9gGFETTEj9ASptKeN27HzGpzU/H/5C+lnBeCAM+9OUnrhGU3Vkek+Uny10Ul3XFKf/yHmfQ/7OQYCPK6zo6uk/uJ5QfgMxoKogMqduc643QfaAlaciVDN86o4/h11ewugucsykyipkhIk6qfrDEVPWpwAfg4fOv9Cn3zN7V+J0t1VkRqiU6iOXXZJVVvR8GFDFS1FizA8Hd/Zy8SpP6JxxKHoLwFE8KX+ZqJQ5cn6A/bX0WAMqqCTM2n25XzQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5f7f8e-059a-411c-5c33-08d655a39ce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 02:37:32.2830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3946
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
ChangeLog:
V3->V4:
  *merge request/response message structure into one struction;
  *change the compatible string to start with "fsl" instead of "nxp" to ali=
gn with other nodes in dtb.
---
 drivers/thermal/Kconfig          |  11 +++
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/imx_sc_thermal.c | 205 +++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 217 insertions(+)
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
index 0000000..ce8e2de
--- /dev/null
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -0,0 +1,205 @@
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
+		return PTR_ERR(tzd);
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

