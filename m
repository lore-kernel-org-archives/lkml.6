Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1DEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34D521104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="bM/rC6ya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34D521104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbeK1DYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:24:18 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:40222 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbeK1DYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:24:18 -0500
X-IronPort-AV: E=Sophos;i="5.56,287,1539673200"; 
   d="scan'208";a="20832789"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 27 Nov 2018 09:25:52 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 27 Nov 2018 09:25:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQARGGPERA+BFGJTGmIpnnkpI4LwGtOI82OBUnPbT9o=;
 b=bM/rC6yaiYKrJ/euLVnFChuConPYDMd/xcx3n6YGmn74TnNESthq9sBHjNwL3fv8yRwRMsxYvfOnwWV7WKxu1BfpwdVhoOyPeit2pnUgoqZXuiRkEDVY0u0pYVWypp+3+r8pYrP45NAQ/eje0QLKMO0pccRm+kZeHVgCNdhgskk=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2163.namprd11.prod.outlook.com (10.174.112.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 16:25:45 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1%5]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 16:25:45 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Claudiu.Beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Andrei.Stefanescu@microchip.com>
Subject: [PATCH v2 1/3] regulator: dt-bindings: add MCP16502 regulator
 bindings
Thread-Topic: [PATCH v2 1/3] regulator: dt-bindings: add MCP16502 regulator
 bindings
Thread-Index: AQHUhm3ZbrMHpTZRJkKB7kh+dqOiYA==
Date:   Tue, 27 Nov 2018 16:25:45 +0000
Message-ID: <1543335937-12689-2-git-send-email-andrei.stefanescu@microchip.com>
References: <1543335937-12689-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1543335937-12689-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0080.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::48) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2163;6:PIWSULwHsM6zEtSfwv3ZhJuqv4pOTvFkq2A6UGXwADvPl6aEr44TR9aYP8g+EWExWdiSfyxyCQSGlRLm7pq6NosPhL9ZU1g7xgNzq4f7/BXeOLFqyaHk+48XNsTrr1l+LNwk2IlAiQqmdSW3tzFTiS2d4bHccNd7O6FmC5QbRU7uvAs0mK298KUZ4F3mWpQuK3KwPqEtowgb6J9YdhjSp1Nw2dENrx/ZPDmnLvDc78h5Tk6PuW42qmKjBTTo9AFna/8NRX+Ao6kPRYnMmQpuPx+2YUWWP3dz5ExRPLCz6yO5pKLZmBUTbSUEEztj4XqPphQgSlDKuK5H8Grp73oH8TfdmhJfIV3acO+zRSuyZztxhQgybSrPXrlET4hgJXs0ip0nhxc0oY52P0PeEzKMcThg5vINCVUhnq4WXgtYyXMWRnpH79Oxd7mnLtZusD7f0cHLskdgjEPXDr878GBe8g==;5:1JP3yCEJgtzDucDXUy7i0KH8mcx/+RqIO7G/BddqlGQoduv4K94YhQP0OJOvrrWxPdf7nLAtffjO5pp4RFHBIgHu9vpdxN2NFCjw3ZdY9/AYRw+jLk/HsspmC0yybsf24+kp76ZSLfgeSZe/im8S2IQI9+0stgUgZOfjUnqNfN0=;7:7N4nHLYwVs4R7kI25mIc3Hq3KHe1j4Wkxm5EJql4NUrYkdtkGjWel3WdyoXsSz3vHXqMiFaMKJPUW7ntuwZW5aQ6QaTZvAzK4yVw8dmqJN7irzNp6ZfS2Q/IdYEbbFZWKo/iwRjv9WDoP//zkP/Pzw==
x-ms-office365-filtering-correlation-id: 85163ed2-2731-4f87-22b7-08d65484fb78
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2163;
x-ms-traffictypediagnostic: BN6PR1101MB2163:
x-microsoft-antispam-prvs: <BN6PR1101MB2163A6ABBC491F7B2C33CBE0EDD00@BN6PR1101MB2163.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231443)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2163;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2163;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(189003)(199004)(106356001)(105586002)(72206003)(3846002)(6436002)(6116002)(81166006)(478600001)(8676002)(76176011)(6512007)(6506007)(8936002)(186003)(53936002)(102836004)(81156014)(107886003)(26005)(7736002)(316002)(6486002)(86362001)(25786009)(4326008)(36756003)(39060400002)(5660300001)(2616005)(11346002)(446003)(476003)(2906002)(97736004)(6636002)(14444005)(71200400001)(256004)(71190400001)(14454004)(99286004)(52116002)(305945005)(110136005)(54906003)(66066001)(386003)(2501003)(68736007)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2163;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6RdGpbQbyvdOiWXMilsyOOs0IhSoPYiDA6anMzscygHo0YbKQKTY7WO79zDec6/st6NhrO732EAx6g/R/l1DU3UNfVMxjH7wU9TSUmxBZjCSi5tjZMShU0GRNOX+npnA95OhX4Yeex1NbQQ/AvK8nRihddC4VhXWjV5m8ULfLEg+7jNLaEnEdBng+pA58vDnbGEW0TbSznSlU06FwliZnxx/ZQdVz9FoxJWqnGIFYC3RDaEiLlepUjPRW4TTT1SdaAMY73Jt28hQqjQHopdOU8LysD9d54ANe4MylSxPb6EaVp+qe/tgvYZU1DGNYpU9LUHbvrv3ebfcqDtys6lhKwL6yEM8QEtfe2Dadhpu5Fc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 85163ed2-2731-4f87-22b7-08d65484fb78
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 16:25:45.4867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2163
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

