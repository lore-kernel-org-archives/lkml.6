Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C668FC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AD32082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="NAE01EHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79AD32082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbeLDJwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:52:33 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:30463 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbeLDJwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:52:32 -0500
X-IronPort-AV: E=Sophos;i="5.56,313,1539673200"; 
   d="scan'208";a="23510446"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Dec 2018 02:52:31 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 4 Dec 2018 02:52:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQARGGPERA+BFGJTGmIpnnkpI4LwGtOI82OBUnPbT9o=;
 b=NAE01EHIbX5Bty2xVvltYBIzhxaQlqp8x/hOU9l9+bXMMyBLlHg7rP9GaGFQx+ohxn3MDc52yCBzp/eKB8nTTcMZLFtEl1t1cw7+LMlcCsW/Iz9UdvgqXCF9P+rfy4puDohCcBuj/2aB3RnGkE2EvEiaOyVg1H5iYDjYY77K/0Q=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2083.namprd11.prod.outlook.com (10.174.112.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 09:52:28 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1%5]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 09:52:28 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Claudiu.Beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Andrei.Stefanescu@microchip.com>
Subject: [PATCH v3 1/3] regulator: dt-bindings: add MCP16502 regulator
 bindings
Thread-Topic: [PATCH v3 1/3] regulator: dt-bindings: add MCP16502 regulator
 bindings
Thread-Index: AQHUi7cREVr9mxrkH0+y0ZAga/unFg==
Date:   Tue, 4 Dec 2018 09:52:28 +0000
Message-ID: <1543917126-32572-2-git-send-email-andrei.stefanescu@microchip.com>
References: <1543917126-32572-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1543917126-32572-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0214.eurprd07.prod.outlook.com
 (2603:10a6:802:58::17) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2083;6:1QkLC4aDfYCJgZEkqF86TxTeX/Qaz89Em7ZRv7k7KYgIMtEyLQEXRLMSq9zitDgUIAeVQ9P+ghGfwh6zbvq5zgR3PVVciRShcC4QvvjgNnYz2xIOaNlokt79u6hy/W/qcSuymTGUmcJiHDh3UFaOOlOuaNsC0zhMesRcGFqMEElMJGRrYHlqx0SVBIc760LPfDAf+RPaUZTNk8bzDYGW/IKte6KOzWkfHUbE38gDVYE8QNu7VuSJ1xoQTfgHrXGT5vfulyD15UsY8KFtGnyT0JO8NU1gAzY8TFsuO7PALGKC6WF/J6BciPFPg+c8ZP6uqk3ywLbT8Jz4Dj2q7LFSEcpFT8nJJI/Ytz4MMFCxPsAL/Xmjk88MZpKQdOUq/nJuX6ppe4PPcIpbdMoOuw3RbKMN+iCySodOMzL6lxDIjNfFeuKUMMWICovxCMB2D4QqvCcERVQ78OTU3rrJLbaBFg==;5:/PixOTwE5l0DQWTdEDRuW3Na09DR7P5wFqaboef/aoMELHJdRwm7/dmmGURQkUtn6fYfkNIn0+demZGzNjH5/Dizu6wTw8cBlADG0yYtU0LRKI/fNAt+23wizW3/QgbwNDUnPRnKDSryLvNh8LhmjIMlXkbx7dFeRBpS9c41CXo=;7:PHxfdgh8j+lMAKOObuqfiVE9nsUG4hYTevlBjePS9T1rMMFyf7oiVtjvNnDSc1swXIa4ULME7ZbCzqZR/JIadBObho+UnyO0EU4cFutEx7BvixjnlXyWIhjeUZMntWb9PPa0Vgcm3+kCs2QQ/81Z2Q==
x-ms-office365-filtering-correlation-id: b3b4e8f6-2119-454b-b1a8-08d659ce336f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2083;
x-ms-traffictypediagnostic: BN6PR1101MB2083:
x-microsoft-antispam-prvs: <BN6PR1101MB208374421592ED682233450AEDAF0@BN6PR1101MB2083.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2083;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2083;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(39860400002)(366004)(199004)(189003)(386003)(54906003)(478600001)(186003)(2501003)(72206003)(14454004)(446003)(110136005)(2616005)(107886003)(11346002)(316002)(26005)(102836004)(105586002)(106356001)(6506007)(4326008)(97736004)(39060400002)(36756003)(53936002)(68736007)(81166006)(7736002)(81156014)(6436002)(256004)(8936002)(8676002)(305945005)(6512007)(6636002)(66066001)(14444005)(86362001)(25786009)(2906002)(476003)(76176011)(486006)(6116002)(99286004)(6486002)(71200400001)(52116002)(5660300001)(71190400001)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2083;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kzbnIznuvQ13IrizGlnPDr9asnstx17yml85sx+B9oA1ec7k6GgLXWVyygxmadZh0heACgbKAA9ggIoF0IHsZedl1Se4kWujGBuYtUGktyaY6JD3eUC8jvcrLX7MRYTekzFTHfyUmC4ZYA2qjPa1z+Evf2I+bTUAD0zoVsUv9bnf6FzR3OLaUizPzt2Ded+vn3/QA/14/S0F6fWmmU/9HIjIm8enjAoAncS9wDS1tNr+wF+EV3xQvzUffbgw9RSwylfjEilmE6598GLO6KU1yVyKLcS+qCFwOH6oyj9pn+gA9tzz8Zju9dJBO0328Veh3xdYWdQlSSuUXBdJko+pmecmKJX5LTlZ76bQ2G7b080=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b4e8f6-2119-454b-b1a8-08d659ce336f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 09:52:28.3359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2083
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch describes the compatible and the device tree
bindings necessary for the MCP16502 PMIC.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
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

