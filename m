Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7A2C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8DA2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="IqyWWHIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8DA2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbeLLSbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:31:21 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:7943 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbeLLSbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:31:19 -0500
X-IronPort-AV: E=Sophos;i="5.56,345,1539673200"; 
   d="scan'208";a="24287629"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Dec 2018 11:31:18 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 12 Dec 2018 11:31:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bV3niSy8aMTGWJqCjlB8G3ytUtT6IMc2bC/oRnW5PY=;
 b=IqyWWHIlkXp2rqN0/FTkS/NbS2v3rEqzhv24ju+3Y26YkYKjC5dxr2McIzudOcjEZe673ezLtshBCUjwGPZRT7oJBai3eYtpoJFSfr2hDP9jazEcGg2FkUzh4n/E+8pq6CabRuFymowLQHgqlgSWLdbJFQbjXi7sV0dOylZTmCE=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2241.namprd11.prod.outlook.com (10.174.113.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Wed, 12 Dec 2018 18:31:08 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838%3]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 18:31:08 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>
CC:     <Cristian.Birsan@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <andr3i.stefanescu@gmail.com>, <Andrei.Stefanescu@microchip.com>
Subject: [PATCH v5 1/3] regulator: dt-bindings: add MCP16502 regulator
 bindings
Thread-Topic: [PATCH v5 1/3] regulator: dt-bindings: add MCP16502 regulator
 bindings
Thread-Index: AQHUkkjZYU3MU2NP4kuisrA6KUBtoA==
Date:   Wed, 12 Dec 2018 18:31:08 +0000
Message-ID: <1544639447-17392-2-git-send-email-andrei.stefanescu@microchip.com>
References: <1544639447-17392-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1544639447-17392-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0012.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::24)
 To BN6PR1101MB2243.namprd11.prod.outlook.com (2603:10b6:405:52::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [213.233.110.155]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2241;6:2I5T8q8huE6mLienNlUMlTVL7Be/VykSSyKqrxda6vmA8gqG8dsU636aGfCvxsWtMm4ys3r34gCOYBVAFSTFAFuoBj3JvEYAmWcGIqT+z+ve4OkuLb+FDsOJ8ASj/fLPcBllk9xlHPJorVLFjT7oknORGs9RHw+Nict64iqkVU7zEGXjByAHQ1akviHupHnArCmy/7hhcxeWJR2VNXau2DbgvONNBiHvbewhZ5AQaaz7guh37btxBdi0rU1nneCZMZN5nkdmdG6Mv/Vr11OSb/ZuHZP+jExctF2di7inbgjJoB3Yk1WFEPEHcDc1rb0NgN8rlKWnFNXyRIp33qYHPrSVZn4WlmKuDv5EcMuZhOKpPUaw0XGOl2nBXWb2MbjnANHOQfW15TLdDgmUSgxIxzKFuVRZUxStAiBNQu8d9BT0hxoV6yuD/8w+/XbNNBj7lTfE+hIliP2+OcRWvJH9yw==;5:amOihjD2+NVns3uM/Jbj9mPBpeYtmi1lMEeihCUHVo+uuh0IvGnCBcYtYe29eF+jB+jQMcB7/rJvxi9GRkcVgJGnJx9U6HwavjNVdigi5mON2tRgbki3BIexgrkKgnH8oWnmU+UHim8+7BSi8+GJqauQBDnDvHkTia+t/pXiHO0=;7:v1DHAmw3HxZQSGPTDox5MAPdpGB/8BG7t5dJVaSBGyOeX+ISkH8E92yQl40QD+RRh5zyh67LSOvstkw7O5XCd5ObMdDomJnLLlcjYqsbTORoPhcVs3tMDEjK1chu8GNPmvSLp9zJcaWR1uRlCuYFUw==
x-ms-office365-filtering-correlation-id: 8093fc9f-e900-4a84-f3ae-08d6605ffafc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2241;
x-ms-traffictypediagnostic: BN6PR1101MB2241:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-microsoft-antispam-prvs: <BN6PR1101MB2241F1270649BC3BFD2121BAEDA70@BN6PR1101MB2241.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3231472)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2241;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2241;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(396003)(136003)(199004)(189003)(66066001)(486006)(105586002)(25786009)(71200400001)(4326008)(446003)(106356001)(2906002)(476003)(71190400001)(305945005)(6512007)(2616005)(478600001)(53936002)(11346002)(14444005)(26005)(76176011)(86362001)(386003)(6506007)(107886003)(72206003)(2201001)(186003)(52116002)(99286004)(110136005)(8936002)(316002)(6486002)(81166006)(256004)(39060400002)(54906003)(2501003)(102836004)(5660300001)(6436002)(6116002)(14454004)(68736007)(7736002)(81156014)(8676002)(3846002)(97736004)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2241;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MKIzYRCzv5XxjPJCTqfJI+aqHd/CJd43ED9MwZU+uJdyOd3nzeYjc5U0pbPbUQWeh6UgWnI1Uk/NyQaZsM1485TTLzXSkDM1LdWjXAO76weg8YyN3pG/LocKPGqmuU/sz58GP3sJkM27UIUy8xZQoELzSBnYIhcMQjqD7scm9sh4TUnsiF+jh7yBtw7hISPAQVfSCgtDfpAj0CYDg7nKB7WQ1PmHyhSHw6Xzj0UBwUhg1OaUK87fYIrEXExYad0C7C2/u25SIiORRoGiBoH9axoeTW6ct5/WP95yfdJzXXqTR6n8+o6WGtfNLI4wx2Xx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8093fc9f-e900-4a84-f3ae-08d6605ffafc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 18:31:08.0888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2241
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

