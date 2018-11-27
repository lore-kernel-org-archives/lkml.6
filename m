Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B96C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7272082F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kygHpNXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7272082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbeK0WzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:55:18 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:22949 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbeK0WzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 17:55:18 -0500
X-IronPort-AV: E=Sophos;i="5.56,286,1539673200"; 
   d="scan'208";a="21574175"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Nov 2018 04:57:36 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 27 Nov 2018 04:57:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hztodwJY33Vhcj/6CxFidSHHSax07SRB63F2qBSHeKI=;
 b=kygHpNXCD09QmLUNWlWna8n9nARFQDNG1wuaG/33JqRUywXE3SgmtHoW+w8p6HYaIQvBfRn7JTT9DqODBWV39SULhhkirVHabJoNexPfWaysvLVK7r7n/zDTk+dqpUHs04uS7BRLdJz/nVRSzGue2J1DI/99LFsUlV9kvIbV9OY=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0646.namprd11.prod.outlook.com (10.163.159.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.18; Tue, 27 Nov 2018 11:57:25 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 11:57:25 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 5/5] regulator: add documentation for regulator modes and
 suspend states
Thread-Topic: [PATCH v2 5/5] regulator: add documentation for regulator modes
 and suspend states
Thread-Index: AQHUhkhcc/FQ+O4mvUqVP1+3dl3KuA==
Date:   Tue, 27 Nov 2018 11:57:25 +0000
Message-ID: <1543319801-19100-6-git-send-email-claudiu.beznea@microchip.com>
References: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0173.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::17) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0646;6:w5cdP2lljeLd1bdeTCT5pZaMz0ARos3/nHGE3zxkTpm6aruekciC4EiDPmELvdgRFiR5EgbLUBV39L2vwIpLSM7o2Iu0HGLH+EUHgO9G0hSFYGVPXrfDMxrjOuGBbzlFk0oloSpI2BVlwGLN+XFKOMHktiMt5NiG5M//531tkPvcMbfiLXM9HHI1Aie/OrHfmra6Xf09yWq6rREg546SwvLkn3autD0A2bDPasyyCMOfpr1uN/8ee4BPMSTr9i33d6pOduZ0pxGjyhOdjxvjl25uSQjpfyGatvO5RIn6R7QO8tp9AdOJStXI63qFOg/WEgonVlLKewxr8hxxgSzxu5NixZ2RhGGrHhG8+a6IfvYXu1ygPcV3OlkU3vQZ6WQrQqlt4WXegjlrlGoyAweIzs6pgjcsmuQ9HLw7/mio7AagPhNnoQbHv9fdmhoPBsuFkzUxGU2hByTn0b08cQ34uMueloK4yG9MZLDKdvo9CNo=;5:T3QO7weM74zWYQhnxvfrNFlJmJDb2ODLMlwOJctMLDnkElJ9EHM7GBJIlfY0FAeXK1pj2ViPxkH58iQPbH7QTaNvAkObUjZp1aiyD1LkKpVVQGx1sxAqhqGkJ3FHlpBNpdp/I/e2RDFt9G/84fNKNhAw46Vw9573xAavGJdJknE=;7:Sk33rRp+MTQ4M/xSfx4PS+0yup8UTiMf15ayghJeaErRj66joDicvZEwYfn6EEuWhMx+nv/+79itPjxd1JvcEBjLnDUSObKr+JA+8gN5Yvf+BsX6HGW+uI4PkQVQagvXeDpt/U2ccngSiAGQch5dgw==
x-ms-office365-filtering-correlation-id: a19e6abc-d0c0-4864-472e-08d6545f7edd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0646;
x-ms-traffictypediagnostic: BY2PR11MB0646:
x-microsoft-antispam-prvs: <BY2PR11MB0646B6012BE9814275E1519887D00@BY2PR11MB0646.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231443)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0646;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0646;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(136003)(346002)(199004)(189003)(86362001)(6116002)(3846002)(72206003)(76176011)(305945005)(106356001)(6486002)(52116002)(6506007)(386003)(316002)(110136005)(54906003)(14454004)(478600001)(66066001)(6436002)(99286004)(2906002)(105586002)(15650500001)(68736007)(7736002)(6636002)(39060400002)(476003)(11346002)(107886003)(2616005)(256004)(4326008)(36756003)(5660300001)(14444005)(8936002)(53936002)(6512007)(486006)(102836004)(26005)(97736004)(81156014)(81166006)(25786009)(71200400001)(8676002)(71190400001)(186003)(446003)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0646;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: C+KFLAqd3x+AucLF6/woQl9SNUW3q6wdVzaPIdk54lYdG8hi9scsndKDleyGKy1D2psNdT+G/FtXE1pdZDkAiv0b7LBrhodTkv5SkRfwB0+TCLe2I4xQKTFH5O86Y9FhW+EVFdJfXjErqFjYtN14tQebaWbmIIx8MiyzvaSr/NXH2WD0G0cfssogX/wVK5zFgNVaIegbqfPozyoWjjXf+mrDftmbYYLuYc852QVHSQrChOnjPGXQWyw4A6i6DFcgwYZJPosEkF4CqLXrzZ0cR70sOBzUXcENYrj3LeBeT6eCP/CyAnZRCFY2u6GVNCxNmz/fIh920E6xnOOP8iP5qhv9pjZu1ByfJ/03Urxz3qE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a19e6abc-d0c0-4864-472e-08d6545f7edd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 11:57:25.3137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0646
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add documentation for regulator modes and suspend states.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../bindings/regulator/act8945a-regulator.txt      | 34 ++++++++++++++++++=
++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/act8945a-regulator=
.txt b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
index ac955dea00d1..4017527619ab 100644
--- a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
@@ -15,11 +15,17 @@ Optional input supply properties:
   - inl67-supply: The input supply for REG_LDO3 and REG_LDO4
=20
 Any standard regulator properties can be used to configure the single regu=
lator.
+regulator-initial-mode, regulator-allowed-modes and regulator-mode could b=
e
+specified using mode values from dt-bindings/regulator/active-semi,8945a-r=
egulator.h
+file.
=20
 The valid names for regulators are:
 	REG_DCDC1, REG_DCDC2, REG_DCDC3, REG_LDO1, REG_LDO2, REG_LDO3, REG_LDO4.
=20
 Example:
+
+#include <dt-bindings/regulator/active-semi,8945a-regulator.h>
+
 	pmic@5b {
 		compatible =3D "active-semi,act8945a";
 		reg =3D <0x5b>;
@@ -32,6 +38,18 @@ Example:
 				regulator-min-microvolt =3D <1350000>;
 				regulator-max-microvolt =3D <1350000>;
 				regulator-always-on;
+
+				regulator-allowed-modes =3D <ACT8945A_REGULATOR_MODE_FIXED>,
+							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+				regulator-initial-mode =3D <ACT8945A_REGULATOR_MODE_FIXED>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-min-microvolt=3D<1400000>;
+					regulator-suspend-max-microvolt=3D<1400000>;
+					regulator-changeable-in-suspend;
+					regulator-mode=3D<ACT8945A_REGULATOR_MODE_LOWPOWER>;
+				};
 			};
=20
 			vdd_1v2_reg: REG_DCDC2 {
@@ -39,6 +57,14 @@ Example:
 				regulator-min-microvolt =3D <1100000>;
 				regulator-max-microvolt =3D <1300000>;
 				regulator-always-on;
+
+				regulator-allowed-modes =3D <ACT8945A_REGULATOR_MODE_FIXED>,
+							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+				regulator-initial-mode =3D <ACT8945A_REGULATOR_MODE_FIXED>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
=20
 			vdd_3v3_reg: REG_DCDC3 {
@@ -53,6 +79,14 @@ Example:
 				regulator-min-microvolt =3D <2500000>;
 				regulator-max-microvolt =3D <2500000>;
 				regulator-always-on;
+
+				regulator-allowed-modes =3D <ACT8945A_REGULATOR_MODE_NORMAL>,
+							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+				regulator-initial-mode =3D <ACT8945A_REGULATOR_MODE_NORMAL>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
=20
 			vdd_3v3_lp_reg: REG_LDO2 {
--=20
2.7.4

