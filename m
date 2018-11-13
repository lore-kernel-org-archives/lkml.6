Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D627C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F7522419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="SOvDfhh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F7522419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbeKMV1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:27:10 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:47173 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732037AbeKMV1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:27:09 -0500
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="24030073"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Nov 2018 04:29:26 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 13 Nov 2018 04:29:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REtIl4GSJZWK8lk2iUi5sd8t6CwW5uV9z41oofWXLKw=;
 b=SOvDfhh186GYYA6AqMsoweCieALxK1Vd5e8E43eWQ/b8/zMw8BaYUYz9qNoGn3xz5igg3FNp2RggR8yE6kPV9falY3I+4VlJxuG6fXcLqJMHk7lcNw0OFa0vdPwYTBkchw7qpr2sQBPNWdAct6Jv+7mXVbIyi/V9BkI9ufHClZs=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2353.namprd11.prod.outlook.com (10.173.200.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Tue, 13 Nov 2018 11:29:24 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6%6]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 11:29:24 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>
CC:     <Cristian.Birsan@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Andrei.Stefanescu@microchip.com>
Subject: [PATCH 1/3] regulator: dt-bindings: add MCP16502 regulator bindings
Thread-Topic: [PATCH 1/3] regulator: dt-bindings: add MCP16502 regulator
 bindings
Thread-Index: AQHUe0Qg38ZobbJRekqKgZo6abU5dw==
Date:   Tue, 13 Nov 2018 11:29:24 +0000
Message-ID: <1542108563-10108-2-git-send-email-andrei.stefanescu@microchip.com>
References: <1542108563-10108-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1542108563-10108-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0067.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::29) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2353;6:oG5oXRE2b+m9TZlGxXKaTHAUVMaejS02v+7f2mdcYC5pjI1g55S8cVaBQYphAM39y9epIR9Vavp4JWXaBSbD2v621qHk+jCFlblc7KVUMmggpVj9RTmOStUBN3Nib81Z5XOVp2yfJqZXuq3hwAPPqZNz4YJ1N/CSGUrdtuKs+dtTsMDGKR5CweyDDPvKjoM3qBbhN+psEqi1DZ3INSXoExBSj7Z5UiqhfHBdoGkmwGL0iZrfVt2htcCoQQyBtyQ0I4xPO8M12ycdUDRlQBDET7usF+3QzLo2l4OMiN0lUBt6JrAML6NMVH1t17GltfhsZJQBFWucdS1Jnj0SC+rV3qL+rCzL+e0ByDe7dA+LcxOpVZQdFhjP3BcaNS0QFvJrScs58qrbA7PcQ6eoHoC0oI3sTji2VzOuhvCxkXg23uNIKnpILZG4ybyTa9N+Fwy9hYBcyQgyFJdhRy9cLe6M5A==;5:WxfhFxLwC8LMwQWDZxQWl9GJGZMsFpa9ISQs5MnJXsk0Uin8056I/tHHBGrHpF+7TSGCc2EwanOK8iOHKb9cAU2EWPaMMIanwvXqmfkvdbUgARThf1fHQP0KBRz5zgemnaxFPF4DovbkP1/dFyPtkrY7VpMiDnj5ia1OL/4vTKA=;7:cqOZZXXVz2w5eOowni+NdlUp/hpazVozTRDSC0AQ86vcqpCb2WsmL39fVZXIe7CrAlujzchbqjthSW/POnOS+obicWdHg1V2Fl+35WLM49mbU0Kdxvs8Tzs36j0AkfSyh7m6xfFwtANYAu/ZoO4meQ==
x-ms-office365-filtering-correlation-id: 25a1425b-adf4-4c99-5120-08d6495b4323
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2353;
x-ms-traffictypediagnostic: BN6PR1101MB2353:
x-microsoft-antispam-prvs: <BN6PR1101MB2353BC68F28848F6D150FF6BEDC20@BN6PR1101MB2353.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2353;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2353;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(136003)(396003)(199004)(189003)(36756003)(72206003)(305945005)(110136005)(54906003)(107886003)(14454004)(53936002)(8676002)(478600001)(7736002)(102836004)(106356001)(26005)(316002)(105586002)(6506007)(39060400002)(4326008)(86362001)(386003)(25786009)(11346002)(97736004)(6436002)(446003)(2616005)(476003)(486006)(6486002)(2900100001)(68736007)(71190400001)(71200400001)(256004)(2906002)(14444005)(66066001)(6116002)(8936002)(3846002)(6636002)(76176011)(5660300001)(81156014)(81166006)(52116002)(99286004)(2501003)(6512007)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2353;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9jeKJs/44/VFsoKq2YlnsvepPv2zXCidjMVoL+3UStC7iJnIakZBeITgIzy+KMegeRs1nkPPgUgy/wSl11BHCoYYoIeXVnObodYBKGIV6opDh0KnF5NI8wDGoMIflh3slupzBswYQGvDYDIe/wE3gf9v3AuAGEVELGVRys7cCSEhvWkLpYCoOAN57oWmiY7etBahRXArVLNI57+5bjucd1dk81o5teTqHbRh5uOdHWVKhzVv/sP3VT6dt6aY+B2bR+o3U+pKce+fqRdnNZi+ErZquGTyKAcc5qR/uUnRmMREr/KmSUA2mCIdBjK3nIvTKMsPk+561/Nm309voAtCvg4TTyfQanQfUJIAb2+g9hc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a1425b-adf4-4c99-5120-08d6495b4323
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 11:29:24.2177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2353
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch describes the compatible and the device tree
bindings necessary for the MCP16502 PMIC.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 .../bindings/regulator/mcp16502-regulator.txt      | 107 +++++++++++++++++=
++++
 1 file changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mcp16502-re=
gulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/mcp16502-regulator=
.txt b/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
new file mode 100644
index 0000000..bb3d787
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
@@ -0,0 +1,107 @@
+MCP16502 PMIC
+
+Required properties:
+- compatible: "microchip,mcp16502"
+- reg: I2C slave address
+- lpm-gpio: GPIO for LPM pin. Note that this GPIO *must* remain high durin=
g
+	     suspend-to-ram, keeping the PMIC into HIBERNATE mode.
+- regulators: A node that houses a sub-node for each regulator within
+              the device. Each sub-node is identified using the node's
+              name. The content of each sub-node is defined by the
+              standard binding for regulators; see regulator.txt.
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
+			regulator-state-mem {
+				regulator-off-in-suspend;
+			};
+		};
+
+	};
+};
--=20
2.7.4

