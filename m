Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2B9C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16248218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PxeXCGQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfB0Iqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:46:47 -0500
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:52026
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726722AbfB0Iqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFpg/8sHavncXPdEKtOnpsa9aNa/nU6OIDuOtkoLQaU=;
 b=PxeXCGQEAvPePytoXy65IFLCRcqN+vvba+BuG3H++kdKY0ybgO/7y9+jZ0B/+1o0/HHN/MkqAvhYj3igDCM4ah3/hAEUw+xhuhPf9nNMF9+x4bI5YeFcSWIfS2m9kaV8EB+pRjc6jdzmuZ2F+oL/Cw/qSGGHFT4FvZP9zZ2AfBk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3643.eurprd04.prod.outlook.com (52.134.66.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Wed, 27 Feb 2019 08:46:31 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 08:46:31 +0000
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
Subject: [PATCH V10 2/4] thermal: imx_sc: add i.MX system controller thermal
 support
Thread-Topic: [PATCH V10 2/4] thermal: imx_sc: add i.MX system controller
 thermal support
Thread-Index: AQHUznjvZmULGL+j60+dibYMxXvlrg==
Date:   Wed, 27 Feb 2019 08:46:31 +0000
Message-ID: <1551256894-21954-2-git-send-email-Anson.Huang@nxp.com>
References: <1551256894-21954-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551256894-21954-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0021.apcprd04.prod.outlook.com
 (2603:1096:202:2::31) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1c4083b-7098-42e4-65b1-08d69c901207
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3643;
x-ms-traffictypediagnostic: DB3PR0402MB3643:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3643;23:dKUFpNR2HXIONLH5NkevJu+eOv1H4ZHYlyc+Z?=
 =?iso-8859-1?Q?06hKCaziuCMj7Tbjb0vbyh0FfoAr0j0aFxCzrscrfEgmIrrvssz5JbLq8e?=
 =?iso-8859-1?Q?5ztj82OuhvpCW0SjjCXah7DJRhZIEjjfv0gOmuHLmq890DxKLE0dQqGaKL?=
 =?iso-8859-1?Q?OZfYynRzfmPktFuzMM2OAGNlyBseuKyj9WbWtEsGhTKQ/scbdq4JFAy3TI?=
 =?iso-8859-1?Q?cgn2ZOKEg7RRIsmky4ozRO+p6WST7pMPD3vBV3dpjNAKDRVzlBIVkI4Xr3?=
 =?iso-8859-1?Q?oT220DFI5kA5312r74r07JaH+qqKGljeHaXng32xNRt6at7vxUsGwv/Byp?=
 =?iso-8859-1?Q?4WqdCGFOfELVlPu45QfcatWRlbzfMZBsbac3M2H7tVkxvMcmExDtVe/gaW?=
 =?iso-8859-1?Q?oXr9igeVTuOT/CQwIawOR5we0NympGLElSqNz6EmIf/WOU3UJ8fJxpzyAC?=
 =?iso-8859-1?Q?vCvhhlarmjqULDJ0PSHN6kWr/e1n5cmZlj8WzXjx15WLLL6lhrTz7sjqX4?=
 =?iso-8859-1?Q?TZ2k6FJ+kFzvZDth/xEUCdj8WS71wRsh18wp+OLyl/nUh3STNI6cawSMW+?=
 =?iso-8859-1?Q?XDyUngf8x0n9UF18GtBPKhqp3kPYQX3k5hn+RHYFxTxdid7zXGxP4Etx39?=
 =?iso-8859-1?Q?5M95Po8cFFJXrI06RFssmfCiuYaE27nuy9brAHxOSa+Ppvu6GjYjBeKQkE?=
 =?iso-8859-1?Q?610kcigM2E9m8ObhcUcwZbjHgm/BdRJ8nfM4NZvJXclU+gSn9QeyhIXBa/?=
 =?iso-8859-1?Q?AC2jXZxsr22ivZj8p22/+FHbsZZI8JfjU+7q45vXilOYLTidKIQkmDVlt8?=
 =?iso-8859-1?Q?6T7Kwphnku6gBdfRmf+NfTEu04vatcVFQ3Pnmt+OcIGMubOISXRTeUL7xq?=
 =?iso-8859-1?Q?SIc68836sQtcQ54N1XDasxBwArFdN5VB/5AqLMl3Y2v2vF96xzilBWTtWW?=
 =?iso-8859-1?Q?Z5a8Lf5lNKtGpuSrK62gpPwOzSx+Pbau2Bxc0weqp1DoVJ+UVZuzsC3Voo?=
 =?iso-8859-1?Q?UoALkwviJ2aqpscbAMgfqBTpE3XxVT2au9aRgsJSW3QsICCNppn2pZ2uC9?=
 =?iso-8859-1?Q?Boy3BjK4mTev+XFZ93NgDGNSMOhxwKoeji5NA1s2VeCEAsxbYXAxoONy3+?=
 =?iso-8859-1?Q?oWg1/OCLlYm/6Z8qs4vwtACWJK8kuYGeN0/R2slOJy34XEHjmGOfWbq3Hz?=
 =?iso-8859-1?Q?oob7UJ+EvBG2ewYjMIDBagqh34KGkMZjn09VCxV1d+9lp4f9nU7UPChUKT?=
 =?iso-8859-1?Q?bfHfTchniXI67QKpZ6Wc+lMRAcDytXHAn4Vctf/n8iVg3B7mpvA+nxvBpz?=
 =?iso-8859-1?Q?2ZPb21UnhQnlkeQ8qQK8vkOY7GzI6MUihUO05m2m/HGV7s7c6QqrChGeb+?=
 =?iso-8859-1?Q?4JB1i6UPfW1YEUpsyuAYNOJjwJO8N3vLPHyL15u+PYkmbz+DFEGjA=3D?=
 =?iso-8859-1?Q?=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3643B561420EBDC9029C4A23F5740@DB3PR0402MB3643.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(136003)(396003)(39860400002)(346002)(376002)(189003)(199004)(6512007)(99286004)(71200400001)(36756003)(71190400001)(305945005)(7736002)(6116002)(3846002)(105586002)(6486002)(50226002)(106356001)(53936002)(97736004)(68736007)(2201001)(86362001)(14454004)(81156014)(76176011)(8676002)(5660300002)(25786009)(81166006)(8936002)(4326008)(52116002)(2501003)(478600001)(2906002)(26005)(186003)(102836004)(486006)(7416002)(476003)(66066001)(6436002)(386003)(6506007)(316002)(256004)(2616005)(11346002)(446003)(110136005)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3643;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XjPkb2XFa+8Ju0w077WIOW8LOjh1ihn4dfniJvnRQlMs0zhq1W2HHos1JpancKdvh8R0s7umaKj6HI4NCDks9YDbPNmc/3M65DWkS+r9eDqwrLOlDg+f+Orr8/qnD1Ia2HZ4NTVzHjrFQJoT//foMqPEtbgON+sxsZcc9OFGh8XLhddelNIyDx3TMkczmp/hGb/W3nHfrHoi67IC32ZJnO2s2f9O/EwLTdJQzbqewx0YJSBCr1124FoPYwxGxdSG2hE6l+DDF7xKtWAm79JZfo6KV3N571IFRbABrlFwXzqH2vBsaNoUVp+6s+VAm1ts+QhRrn1fYCWrB2V83MwkzdQ1O2txOzHyRr/pzVPKhoRCiYTnmZRfQQyKyNd7ciDJ/Zfk3opTAvy/lYE396OTZ+gqM/gILJzl0tkZI57FeFI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c4083b-7098-42e4-65b1-08d69c901207
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 08:46:22.1398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3643
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
No changes since V9.
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

