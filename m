Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C17C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529AF2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uWvBOH6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfBUGi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 01:38:57 -0500
Received: from mail-eopbgr50052.outbound.protection.outlook.com ([40.107.5.52]:48404
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726680AbfBUGi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 01:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ze5IIe1T6c4EkSzmcmLV1l3QESc8WF7FBLxcdcb36UU=;
 b=uWvBOH6yfPAirPHmVlO7qLIEonFrcitHX4KeGwM2SS0jckvgKooTr7m5pjTlbQpRDezVivFwx96783joUJUNbSRBt+BthE3QRMuYhfURlF4os4E9qNVcX1M0ITODLRDzCcZiNYGwS1OjVAQUP//QGZhpu02DwiGOSY71DweF/CA=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3863.eurprd04.prod.outlook.com (52.133.29.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Thu, 21 Feb 2019 06:38:39 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1%4]) with mapi id 15.20.1622.018; Thu, 21 Feb 2019
 06:38:39 +0000
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
Subject: [PATCH V8 2/4] thermal: imx_sc: add i.MX system controller thermal
 support
Thread-Topic: [PATCH V8 2/4] thermal: imx_sc: add i.MX system controller
 thermal support
Thread-Index: AQHUybAULnz4bMD1zUS0pt2wSf6zwA==
Date:   Thu, 21 Feb 2019 06:38:39 +0000
Message-ID: <1550730831-14995-2-git-send-email-Anson.Huang@nxp.com>
References: <1550730831-14995-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550730831-14995-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0069.apcprd03.prod.outlook.com
 (2603:1096:203:52::33) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d3a3118-761b-4e87-41e2-08d697c7369d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3863;
x-ms-traffictypediagnostic: AM6PR0402MB3863:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR0402MB3863;23:i8NpIJ3e9MhIan5EXXmQ+o8CbTjyYYxWSci1K?=
 =?iso-8859-1?Q?Cdo9ynuWfvL8w7eNOuEzrYRVGaxCQHC7aboMD+Kecu2XB1w3s1ULzryMnv?=
 =?iso-8859-1?Q?uwcYWznqdx95BFhjfoEbzbRtP2876uNXo3QDNiprl/CR0JsgDO/FJ8bS2U?=
 =?iso-8859-1?Q?KPmu3BizNIUKRdJpVGgxPNsedWnhn5EdYDwS9tYy9iWHir04iaidBF7HWV?=
 =?iso-8859-1?Q?Fiync+aUKcD6ro9nDRe0UYI3+y+COc0eqmI/e1SANb6KANLfQUaFSrpHJu?=
 =?iso-8859-1?Q?8ujz+EzklrQgzyYDnvUfzyZqIMIfhTbREjtIqf5qwBKCdbGHQD/dQ0vjfW?=
 =?iso-8859-1?Q?711EYVi+uGJp9ZSOjyQ/bmCcTpVStLsTJMFSeiKhapWpU9NRoeRrEIHina?=
 =?iso-8859-1?Q?43JEPUjEaFJUfyO3R0mjgUywZ5VVJvA6FiLfy8ty90Kbhn+Ns9dhjG6AZy?=
 =?iso-8859-1?Q?m3qQ9sjOUhE2vERIKzmO+FFzd0HWSSRWyNLqs44jImZ4EeX3NrBSMAMyWT?=
 =?iso-8859-1?Q?sVNdXpGezY3iylPLenUQFKOlnKFef1sjd2YNuY+Mi9ich1B7zKE2iOTUl9?=
 =?iso-8859-1?Q?u98QE7Jc3kMXOY+Yx80ZCoumwfTKeTyrhu7T/VPRLI0jZ2p45ZyPi9+i/S?=
 =?iso-8859-1?Q?PHqA5LBcj/8x9VrFRTBVp6uQUqtIEEGJfh+WHYdOYxRi3z0GpM8zbEcNwi?=
 =?iso-8859-1?Q?pjGbTwXDNuYgT0NlPq+xmvYmDcB7UqszGipnycCu1LEeWYRNdJPOjxvekP?=
 =?iso-8859-1?Q?hQpPUZl+GgD75mP/2RhNmFLVpWUQ2XFxs4jeK4HqTcwUgObL2vZrehX5YL?=
 =?iso-8859-1?Q?9cHB9eOekMsp7fwcntDyKmQy8pE4gn1h9DF7TmLeiUKulOLmLjsWMhYTSo?=
 =?iso-8859-1?Q?D6OvOnluTvRba050ve3oD6PC3UDhmkIEllQ5h/ijUQzUzmb6OfIZSB3rgZ?=
 =?iso-8859-1?Q?AcfWujIE8g8OAG1qx9u6uK6Dsyns0n+qPw84zzg26RvjLtQl8Fxs9QZffZ?=
 =?iso-8859-1?Q?69YU50pRm3TG8Ipwq9oUnZWiMs6JeaIc+Ahh+WsTQUz3v9zVHhDLvSutfY?=
 =?iso-8859-1?Q?Tec5cJa9mzZv6ZCFjG9l4kbPnQb9tgAY1CwKWcNQ5/+7CidG9jwZVNLDFq?=
 =?iso-8859-1?Q?k+AYqhJQwez031AeKbaJWhkPbWBFXmofMHxSJ1iKoszjvCS7R93nrqDAEj?=
 =?iso-8859-1?Q?UvZU98WnCKQp2RPF/6gxZkGvj5KFzBO9e0HpqZajw+t/MetnzybQ4lbPwQ?=
 =?iso-8859-1?Q?Iyk2wGN3lQeJJ9z7BmIhRre07VwBYAiGWQ1QBD0QZIca8odsdULCIBK1zG?=
 =?iso-8859-1?Q?zZuw=3D?=
x-microsoft-antispam-prvs: <AM6PR0402MB386316E86BC2C0A5EBECD30AF57E0@AM6PR0402MB3863.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(478600001)(71200400001)(5660300002)(6486002)(97736004)(6512007)(2906002)(86362001)(36756003)(66066001)(2201001)(71190400001)(53936002)(4326008)(486006)(25786009)(68736007)(305945005)(14454004)(6436002)(316002)(386003)(8676002)(6116002)(3846002)(446003)(110136005)(186003)(7736002)(2616005)(76176011)(26005)(256004)(81166006)(102836004)(50226002)(7416002)(476003)(2501003)(81156014)(8936002)(6506007)(52116002)(106356001)(99286004)(105586002)(11346002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3863;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Tve+XdrNd0ulrSKhAH2FuFQ7IhyLD2+Z1JjPuyltnvJidmH0OSN0gyQKXTPpqZrNjD1syy32v0itoHz2q4Ye/O+hqqL4NWtyGRjzoHMw5vM9XjMJh15kJu853vr3ks3VqeOf66+JhrJczlM7O0WWti5MC1J6D+fFIGmKM0NPoxw8b3LPP4hAM0SRcT09wh5oRP9irhX85yUf05TnGEI5yTOLEysZvP/3BjaCqIqokVZQUhtpU1eoTXVPyiFM+dm6/ZofF11M54MOIJxW1oxQ/srkpTQFLJoNVLopUvwccXn6nBwyY2xakQ5YKUQG/8Z9+B3wh1HFpuBEEHkYTouZ9aXSG6ya3F/PJRxRK0vvPQQ3pFPupopYsfODF8fQ9vvwC87dtRDPClO//V8ug8U2+6fE69bYsA2pfx8PGgKMGeM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3a3118-761b-4e87-41e2-08d697c7369d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 06:38:30.7416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3863
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
Changes since V7:
	- remove unused structure imx_sc_thermal_data to simply the driver;
	- move the "imx,sensor-resource-id" property from thermal zone node to scu=
 tsens node, and
	  get this property using phandle;
	- remove unused sensor number got from dts, now it is not needed.
---
 drivers/thermal/Kconfig          |  11 +++
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/imx_sc_thermal.c | 144 +++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 156 insertions(+)
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
index 0000000..145e73b
--- /dev/null
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -0,0 +1,144 @@
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
+	struct device_node *np, *sensor_np;
+	int ret, i =3D 0;
+
+	ret =3D imx_scu_get_handle(&thermal_ipc_handle);
+	if (ret)
+		return ret;
+
+	np =3D of_find_node_by_name(NULL, "thermal-zones");
+	if (!np)
+		return -ENODEV;
+
+	for_each_available_child_of_node(np, sensor_np) {
+		struct of_phandle_args tsens_args;
+		struct imx_sc_sensor *sensor =3D
+			devm_kzalloc(&pdev->dev, sizeof(*sensor), GFP_KERNEL);
+		if (!sensor)
+			return -ENOMEM;
+
+		ret =3D of_parse_phandle_with_args(sensor_np, "thermal-sensors",
+				"#thermal-sensor-cells", i, &tsens_args);
+		if (ret < 0)
+			return ret;
+
+		ret =3D of_property_read_u32_index(tsens_args.np,
+			"imx,sensor-resource-id", i, &sensor->resource_id);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"failed to get valid sensor resource id: %d\n",
+				ret);
+			break;
+		}
+
+		sensor->tzd =3D devm_thermal_zone_of_sensor_register(&pdev->dev,
+								   i++,
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

