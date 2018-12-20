Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A7FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE9B2176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GDpgcCzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbeLTJI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:08:29 -0500
Received: from mail-eopbgr00080.outbound.protection.outlook.com ([40.107.0.80]:17184
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbeLTJI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGuHUoUnaH1q6eTv/YPgEEZgyfaGT3QF3UcKsuHgOM0=;
 b=GDpgcCzBP7dHPBD15ZkCToSWkSz/06hN7FUUS+zinGkP9oacgRpjSi1hyfI+8g5Fd+wKcHHxZCHWpr95DF3IMX+M6hr5xsBWBZvjMRzEVArDM361LztHut04kWkskHn8u3wA3arlN08Xi45/rUaMJ5xxU+d+yqFnZBu+teNg1nA=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3797.eurprd04.prod.outlook.com (52.133.29.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Thu, 20 Dec 2018 09:08:23 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::987c:cb59:96c9:6b71]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::987c:cb59:96c9:6b71%2]) with mapi id 15.20.1425.025; Thu, 20 Dec 2018
 09:08:23 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V5 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHUmEOPzVgmR6I/g0KdtfEFFiArMg==
Date:   Thu, 20 Dec 2018 09:08:23 +0000
Message-ID: <1545296609-20477-2-git-send-email-Anson.Huang@nxp.com>
References: <1545296609-20477-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1545296609-20477-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0091.apcprd03.prod.outlook.com
 (2603:1096:203:72::31) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3797;6:+XksBlP+FRgeqruHPUQVemPq2hULuIapFk2FPnCnQ8Ic/FhzbGyRMgX3hZ64R2SHg27MNaqNTWv8pB0StuUw4S8tebpFn/DawuRr3ck4xgBWQblG4p3pLK6Os7R+iinlsi2/s9RJhmdDGKShC9CV0qfv2IfkhzJe/br8waW9jQ8CQLTKbcQYfj80MeOHrWdJN1HwRtucohvs0GHmV5SExfchfYsoDHi/zNC2YKVYReeK7YRWeO4KzH8mu0O1vm96q1/4VSQMJmZJRR0SWDvx3BP9fO30Nj/TxTAWe0vK0/Vj+oAiSd1Q4sdPUNURXJfFkl7AAcgaXOeKU77dKyHRr752LtsmJVT2Qw8wh1DelkT51aW9ZIHNr36ZGdhuls4LEiu2vmOFNGITF2R68oVaCS+AH/kwgUw2BaPjCL4QxW5ZhQWsdwsXhM9+G6SSO3rkTrmF1dcydJZND3VcVPer1w==;5:VLgA9MIFy7VB8CjS+CCCA64f6R58Q9q+qAqkDumlfEdOAo79ZWzn5A1NiwohKJ7A2/7BV9hBL0OZKUL3t20S4j3jctJRwjtWAJTDVLcKA955oRzTfXGXEvgi3xkXlm8mD4zTiJGWB3VM64PtZbj5CUYe9KrqSzhsvPtWui+lRL8=;7:johmWB4b07ndPrpWCy1wm1IHEonL1WzB8dI7aciBPbxC2wGjAVuC4qJ21JBIhGq4xcdjsY0IWKrltp2nDY/HUHkf3Tj8YEffkBTN8QyrgLCbWFhpimRMf8f1B/NkFIn0QIKrQT8SW/eGBmlXgPFMVg==
x-ms-office365-filtering-correlation-id: 0fbe9c6c-2553-47b3-0b90-08d6665ab1b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3797;
x-ms-traffictypediagnostic: AM6PR0402MB3797:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR0402MB379701AA4196DD8364F3456AF5BF0@AM6PR0402MB3797.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3797;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3797;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(136003)(396003)(189003)(199004)(6116002)(39060400002)(3846002)(476003)(2616005)(7416002)(5660300001)(66066001)(99286004)(386003)(4326008)(6506007)(446003)(478600001)(50226002)(53936002)(2501003)(2906002)(11346002)(97736004)(256004)(6512007)(305945005)(25786009)(7736002)(8936002)(14454004)(71200400001)(71190400001)(8676002)(81156014)(81166006)(6486002)(486006)(6436002)(106356001)(86362001)(105586002)(110136005)(186003)(102836004)(36756003)(2201001)(52116002)(68736007)(316002)(76176011)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3797;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 150ZmRTVVv5sUsJrVem5bYblurQnDM8F5eFIyVGtWmmrU74/3S3Zs1topCTP17afqO4ANihRIVaFwFXMk/ITbBaWMvfGxEgwLWLUbM0G3cXm2jkCw1hmMjzmcAYx4l5cD3KlVR70xzx5y7PoM/5ZCgdII5zbSdq3e2bMeK5pC6Vaj0sonrsf0EEG41rSYO5inmCsV0H7I3jy9+BOTmD67XDgc1/vxvBvgJvoufQc2CG3ToNTOfdjpDfVuWntb9sL+bjLqomlhkKcSQxkemU5FV3zwLrkoHS0/XkpGWIpHQQ3B+mV3x5NAZ4xl/9rlpvs
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbe9c6c-2553-47b3-0b90-08d6665ab1b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 09:08:23.6509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3797
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
system controller, the system controller is in charge of system
power, clock and thermal sensors etc. management, Linux kernel
has to communicate with system controller via MU (message unit)
IPC to get temperature from thermal sensors, this patch adds
binding doc for i.MX system controller thermal driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
No change since V4.
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt        | 16 ++++++++++++=
++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/=
Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 3f3d697..b77ec29 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -112,6 +112,16 @@ RTC bindings based on SCU Message Protocol
 Required properties:
 - compatible: should be "fsl,imx8qxp-sc-rtc";
=20
+Thermal bindings based on SCU Message Protocol
+------------------------------------------------------------
+
+Required properties:
+- compatible : Must be "fsl,imx8qxp-sc-thermal";
+- tsens-num : Total number of thermal sensors supported;
+- #thermal-sensor-cells : Should be 1. See
+			  Documentation/devicetree/bindings/thermal/thermal.txt
+			  for a description.
+
 Example (imx8qxp):
 -------------
 lsio_mu1: mailbox@5d1c0000 {
@@ -158,6 +168,12 @@ firmware {
 		rtc: rtc {
 			compatible =3D "fsl,imx8qxp-sc-rtc";
 		};
+
+		tsens: thermal-sensor {
+			compatible =3D "fsl,imx8qxp-sc-thermal";
+			tsens-num =3D <1>;
+			#thermal-sensor-cells =3D <1>;
+		};
 	};
 };
=20
--=20
2.7.4

