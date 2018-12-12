Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE215C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BAA920849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="RcpW5P+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BAA920849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbeLLHmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:42:09 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:28490 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLHmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 02:42:09 -0500
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="21407622"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Dec 2018 00:42:07 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 12 Dec 2018 00:42:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bV3niSy8aMTGWJqCjlB8G3ytUtT6IMc2bC/oRnW5PY=;
 b=RcpW5P+Ide6ALWBVevZsYxljc8XtmU61WF3QGmSZZ+JHwy9L/q7O/iSietsbdjEsJpwGDCw6aNQQgF7fREwO9FbKsMs+IEzE3avqLtlTDhg6pv34C8QdZUEJF5n+yvM9YHT6eAbVV+kUmdABrJjfkFHs9Zcee4SZL7iGMjIOvac=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2321.namprd11.prod.outlook.com (10.173.198.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 12 Dec 2018 07:42:05 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838%3]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 07:42:05 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>
CC:     <Cristian.Birsan@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Andrei.Stefanescu@microchip.com>
Subject: [PATCH v4 1/3] regulator: dt-bindings: add MCP16502 regulator
 bindings
Thread-Topic: [PATCH v4 1/3] regulator: dt-bindings: add MCP16502 regulator
 bindings
Thread-Index: AQHUke4tUb4pafIYqU6o8+2BGQNvWw==
Date:   Wed, 12 Dec 2018 07:42:05 +0000
Message-ID: <1544600485-17586-2-git-send-email-andrei.stefanescu@microchip.com>
References: <1544600485-17586-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1544600485-17586-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0267.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::40) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2321;6:ebAfD8gSkUTjhbfVUP+Ddw/HEQRsr28BifO1GxWJqBKkqbjcIMGDwMzOM3egUg9i641LlTrS2NYCBbwpB1qR5pBwJ4zJP5zLn60xy+nHUDQGuA6AP5vrnJfqYaxzD36siZhsYW+4Pcl9r4JUpnZpQYccoDuOp/+PSJNdIUG8P9g7OVq/Pgs1VjJkJREg+gD/6Iw3t0SOyVTQGL1lfjAhtEtwOXRrsYcAlHSi/a89DNUgO1igGTwIiwlHMwZ8QLoCx1TIdPWvK5scel22tOTFiHRy9iYvuyogHzn94y9zwVJ/7iI//xK8tUXFA4XGP9USMyV7rB/0ps4uG+FOD1/xUr1WjpfPaS4bHseSFUaocu/obPXeZoO/l0pWe5bUZpR7luv/rDY4SHZg+iiiKiIgD7VMNJN+mu0mXfVLKrL2erG5CFNVToBdLLxzu01//XWve3x9jpWkukYwCJZrTroxWA==;5:iFLPo4LcD9ID2cA7YGp8D/W9Qhu5JaPYnCYtOA+Zg/yoJ6eP/VUzq8NVbgtmXM7JRvtLJaewt0XMZXq3qcxsWPcMBcVjl1aKe8b4Y2nD1Tjtg7bipiX8noUDbuwpeoCT26DPwt2D3EFKcfY5meLZnncDP5B1yvXQ8X/8maclqoI=;7:Gipg9kqqHEt/xjVKxirYaduyogdDSa5zhRFdqpfdBlBbwpMG1Pi2ThsryjCXCFoZTx0w5wUKlzF3rSR3TsfE3DGAkGlCUeDfBotk1GwQ9wrEWu8BpiZgHu0mDsD+CxVhi68HM9iBl0BRHx/eSTsZ9w==
x-ms-office365-filtering-correlation-id: d78ebc8e-cfcf-4e84-8822-08d660054fff
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2321;
x-ms-traffictypediagnostic: BN6PR1101MB2321:
x-microsoft-antispam-prvs: <BN6PR1101MB2321C88AE63BFFF29AAE7E68EDA70@BN6PR1101MB2321.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231455)(999002)(944501520)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2321;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2321;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(346002)(136003)(189003)(199004)(2501003)(107886003)(53936002)(110136005)(54906003)(316002)(2906002)(486006)(97736004)(5660300001)(68736007)(7736002)(305945005)(72206003)(25786009)(4326008)(478600001)(66066001)(6512007)(39060400002)(36756003)(3846002)(6116002)(2201001)(81156014)(106356001)(105586002)(6436002)(14454004)(71200400001)(52116002)(2616005)(6506007)(446003)(71190400001)(476003)(26005)(81166006)(76176011)(256004)(386003)(186003)(6486002)(14444005)(86362001)(8936002)(102836004)(8676002)(11346002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2321;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KhcDyPTas003I8uYg5+yq6pJHBBIpoS30YG4TOMAtpHBzmXwIPw32+9mjmo6D+VMVqemMmsfoNa6zR1FsSlNIUx1zod5H5QEFf7tlHjKGlk3bgB6UDyqerCEWQmtetAQlaUkJ4GN/jTzLXNh7pXWHR5g0souVl5R/0rLQvFjTYtK8/ka7idMscsV0o2VRsopu0A+QcXR9R127qUIeU71U/WIxNqRd3iT+Bxh3s3E9ArWcF4pbo//8tgN1A+hYJn00D1Q6uzA9SXLGpOdC0jzPzUkwNBWY4T3RXX7LiS01gFOdED0KyL56UU8LwawiiTe
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d78ebc8e-cfcf-4e84-8822-08d660054fff
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 07:42:05.5405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2321
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch describes the compatible and the device tree
bindings necessary for the MCP16502 PMIC.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/regulator/mcp16502-regulator.txt      | 143 +++++++++++++++++=
++++
 1 file changed, 143 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mcp16502-re=
gulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/mcp16502-regulator=
.txt b/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
new file mode 100644
index 0000000..b8f843f
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
@@ -0,0 +1,143 @@
+MCP16502 PMIC
+
+Required properties:
+- compatible: "microchip,mcp16502"
+- reg: I2C slave address
+- lpm-gpios: GPIO for LPM pin. Note that this GPIO *must* remain high duri=
ng
+	     suspend-to-ram, keeping the PMIC into HIBERNATE mode.
+- regulators: A node that houses a sub-node for each regulator within
+              the device. Each sub-node is identified using the node's
+              name. The content of each sub-node is defined by the
+              standard binding for regulators; see regulator.txt.
+
+Regualtors of MCP16502 PMIC:
+1) VDD_IO	- Buck (1.2 - 3.7 V)
+2) VDD_DDR	- Buck (0.6 - 1.85 V)
+3) VDD_CORE	- Buck (0.6 - 1.85 V)
+4) VDD_OTHER	- BUCK (0.6 - 1.85 V)
+5) LDO1		- LDO  (1.2 - 3.7 V)
+6) LDO2		- LDO  (1.2 - 3.7 V)
+
+Regulator modes:
+2 - FPWM: higher precision, higher consumption
+4 - AutoPFM: lower precision, lower consumption
+
+Each regulator is defined using the standard binding for regulators.
+
+Example:
+
+mcp16502@5b {
+	compatible =3D "microchip,mcp16502";
+	reg =3D <0x5b>;
+	status =3D "okay";
+	lpm-gpios =3D <&pioBU 7 GPIO_ACTIVE_HIGH>;
+
+	regulators {
+		VDD_IO {
+			regulator-name =3D "VDD_IO";
+			regulator-min-microvolt =3D <1200000>;
+			regulator-max-microvolt =3D <3700000>;
+			regulator-initial-mode =3D <2>;
+			regulator-allowed-modes =3D <2>, <4>;
+			regulator-always-on;
+
+			regulator-state-standby {
+				regulator-on-in-suspend;
+				regulator-mode =3D <4>;
+			};
+
+			regulator-state-mem {
+				regulator-off-in-suspend;
+				regulator-mode =3D <4>;
+			};
+		};
+
+		VDD_DDR {
+			regulator-name =3D "VDD_DDR";
+			regulator-min-microvolt =3D <600000>;
+			regulator-max-microvolt =3D <1850000>;
+			regulator-initial-mode =3D <2>;
+			regulator-allowed-modes =3D <2>, <4>;
+			regulator-always-on;
+
+			regulator-state-standby {
+				regulator-on-in-suspend;
+				regulator-mode =3D <4>;
+			};
+
+			regulator-state-mem {
+				regulator-on-in-suspend;
+				regulator-mode =3D <4>;
+			};
+		};
+
+		VDD_CORE {
+			regulator-name =3D "VDD_CORE";
+			regulator-min-microvolt =3D <600000>;
+			regulator-max-microvolt =3D <1850000>;
+			regulator-initial-mode =3D <2>;
+			regulator-allowed-modes =3D <2>, <4>;
+			regulator-always-on;
+
+			regulator-state-standby {
+				regulator-on-in-suspend;
+				regulator-mode =3D <4>;
+			};
+
+			regulator-state-mem {
+				regulator-off-in-suspend;
+				regulator-mode =3D <4>;
+			};
+		};
+
+		VDD_OTHER {
+			regulator-name =3D "VDD_OTHER";
+			regulator-min-microvolt =3D <600000>;
+			regulator-max-microvolt =3D <1850000>;
+			regulator-initial-mode =3D <2>;
+			regulator-allowed-modes =3D <2>, <4>;
+			regulator-always-on;
+
+			regulator-state-standby {
+				regulator-on-in-suspend;
+				regulator-mode =3D <4>;
+			};
+
+			regulator-state-mem {
+				regulator-off-in-suspend;
+				regulator-mode =3D <4>;
+			};
+		};
+
+		LDO1 {
+			regulator-name =3D "LDO1";
+			regulator-min-microvolt =3D <1200000>;
+			regulator-max-microvolt =3D <3700000>;
+			regulator-always-on;
+
+			regulator-state-standby {
+				regulator-on-in-suspend;
+			};
+
+			regulator-state-mem {
+				regulator-off-in-suspend;
+			};
+		};
+
+		LDO2 {
+			regulator-name =3D "LDO2";
+			regulator-min-microvolt =3D <1200000>;
+			regulator-max-microvolt =3D <3700000>;
+			regulator-always-on;
+
+			regulator-state-standby {
+				regulator-on-in-suspend;
+			};
+
+			regulator-state-mem {
+				regulator-off-in-suspend;
+			};
+		};
+
+	};
+};
--=20
2.7.4

