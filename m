Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B30C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537C7205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="w1bXrbeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537C7205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbeLKP5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:57:07 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:58020 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730726AbeLKP5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:57:04 -0500
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; 
   d="scan'208";a="22139902"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Dec 2018 08:57:04 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 11 Dec 2018 08:57:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hztodwJY33Vhcj/6CxFidSHHSax07SRB63F2qBSHeKI=;
 b=w1bXrbePUj7xl0XXeBiRlpuqPhauEwDgAPlcaQCVjRcuCq5KFN/g5icYaP4skRLE1YI0PFJhLV4herfbvGESMqMIbqMzoSwWBcV/mySD2JjXMgR5vMm+cYjx6LI6eLhfBhSp7vBkjr2Eqjaj6lAry8yqE3ApmlxhYQZO6EFd3DE=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Tue, 11 Dec 2018 15:56:59 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 15:56:59 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 6/6] regulator: add documentation for regulator modes and
 suspend states
Thread-Topic: [PATCH v3 6/6] regulator: add documentation for regulator modes
 and suspend states
Thread-Index: AQHUkWomPhAYW6csj0eA5tA1EyaMsg==
Date:   Tue, 11 Dec 2018 15:56:59 +0000
Message-ID: <1544543768-2066-7-git-send-email-claudiu.beznea@microchip.com>
References: <1544543768-2066-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1544543768-2066-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0902CA0050.eurprd09.prod.outlook.com
 (2603:10a6:802:1::39) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0744;6:auADopIeqpao7Rs0eLsoSk7+8bJzRCvBHjLUS8ltMJyLEsoRHQCqiqCMVaC1Waq5Np/aHIy39NK2sUOyEoQOSxMe7+RYN4OrgEqHfF0PIDJbEbDnY71+l8q5JLrYcKZ4cPEyeYCmwQi2ETA09LR7x2pYTv9yzUHQewHbR+ob1TWDdSE2dQ/eVevG5ypWUZ8A/Uu+QAGIxyrN+qo8HCSBW6aPdFrBSfNmhqQ8JMJs/qrY4Q020ecPU+UkLdm/4CdvEdP+3ur7FhTDXtsrm95TsJh2Df2Kw71z1EjdRzS/mzk04qy7Tvdsb2jGQmrpuy67yAFMdzbSuTBKxbgm66UMKT4vn1Tx9TdT/EWcyZ57VTZ7h2HwC4n5hFdXsjFo0LX31F5AXM5HTZaJLalv6zqKMTmgt6mXP1BzVqus9q+cJHr0tvItT0b8V1Pzw/tC6KbFqHsgqsuOP12Lkx+AqeeL9A==;5:Vw+/kFJkH9nmQUPm5qMtgrmj4CZFxDMHXn6loCdiHzdhCcEuELvXceahKJ9PW0FbWCxd6WXEcDGG6HYufKSXIoRU3xJXCXpkd0WdWjA6KBSOaCC+HKplMYAlpqYg11gwmS1qMXWL8xKHk8uRnBl0/6r56JJ0LlN/osPz8aGOeOo=;7:qj62mk6q6ZjgkhHNrYE53vTCJjGOPVigeypNnYw9OaecKfcxe6AbK7FQn541BQ10Tkzrr1C3QYhrDBlS3MPkd0GeP7eXu1kMx0796zJXKxo8Hhm0OvQ1LJh7Qy+UlSkrTScEn/bYxbg0zX/9K6jbag==
x-ms-office365-filtering-correlation-id: 49399a85-a699-4995-ff7c-08d65f81485b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0744;
x-ms-traffictypediagnostic: BY2PR11MB0744:
x-microsoft-antispam-prvs: <BY2PR11MB074429B335B3A25A0E1D46E187A60@BY2PR11MB0744.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0744;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0744;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(97736004)(81156014)(7736002)(81166006)(2906002)(8936002)(72206003)(106356001)(5660300001)(305945005)(36756003)(6486002)(71190400001)(478600001)(6436002)(54906003)(316002)(8676002)(86362001)(15650500001)(25786009)(68736007)(102836004)(66066001)(14444005)(256004)(486006)(2501003)(11346002)(71200400001)(110136005)(6506007)(2616005)(446003)(386003)(186003)(76176011)(99286004)(14454004)(3846002)(39060400002)(6116002)(4326008)(105586002)(476003)(107886003)(52116002)(53936002)(6512007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0744;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rNqMfRo5Fr+Z/0IY7eQ60Lwc+agG5EgP3up4dv65e3N1Kgp9kilnXeGrVbjz3e59qkwzkeJZ9/GjSCurasuY3Www+6W5Z3u8Ts+/4aUflEECRHq62ZJ0Ic5RW2NGFVJT3qVX62anX4bUWHlzUJ7OrcNhCOWlrdWyBvAzadJdZFAjXAvocG+drwwUrp3OCbulyAdbPnsPSKIhUtbNtKC7HIMX/rhDoBRBLJoZRHy1pBXbIn+vZW+jOJh1TTEd1UTiXCA++HfJYUtwkdInKjDzMskeB/vDfG/JtL2wLDweeVSc6iPMLmo4dH8nEftIYSag
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 49399a85-a699-4995-ff7c-08d65f81485b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 15:56:59.1955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0744
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

