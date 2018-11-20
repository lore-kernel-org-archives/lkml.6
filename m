Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB166C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69188208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="FLgjEhP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69188208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeKTSg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:36:29 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:8423 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeKTSg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:36:28 -0500
X-IronPort-AV: E=Sophos;i="5.56,256,1539673200"; 
   d="scan'208";a="23487244"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Nov 2018 01:08:38 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 20 Nov 2018 01:08:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zscEz6pUYPOeJtn1Br/mU4vnN5g6LHeskR1yoDheqRs=;
 b=FLgjEhP1f52+LtV6HiFSeZWNeM0/GISQOl4020mHFS9uVbakJTKaB26C//ItcN72NxBQD+aflVFQs37T2tO8e1QblMPrFoPg146QCI7zhI6J511XPImb3SQ+Vov2HQMr6Lmu+9PN2lWhu3phEvbMcL4u+XcNXRHxaxoU/QN3G+g=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2260.namprd11.prod.outlook.com (10.174.113.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Tue, 20 Nov 2018 08:08:36 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1%4]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 08:08:36 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <linus.walleij@linaro.org>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <Ludovic.Desroches@microchip.com>, <Cristian.Birsan@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <Andrei.Stefanescu@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: gpio: add SAMA5D2 PIOBU support
Thread-Topic: [PATCH v2 1/2] dt-bindings: gpio: add SAMA5D2 PIOBU support
Thread-Index: AQHUgKg8JYSs1TI8IUy9lTCXxs8Now==
Date:   Tue, 20 Nov 2018 08:08:36 +0000
Message-ID: <1542701330-23466-2-git-send-email-andrei.stefanescu@microchip.com>
References: <1542701330-23466-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1542701330-23466-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0183.eurprd07.prod.outlook.com
 (2603:10a6:802:3e::31) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2260;6:XJ4I9JycyCPiiojC79/zwMx0FZz2IxBzThMuS6up5gS91YnUfDIVEQeFbkOixWPc6G6Hj26Exf3LUsUsACo4UNEZmZmRLrPwPGTeh01tHkRhblY5YGox2wmQ9mYzQfUCwMXlZ89BBJaID8F1psCbJguAAEraegVKyZ8B6O53r6n8Nb9S7uKsDF+7Df5RrHodcGa5GUB4hqJUU67ygO4DsCYI2Kw2aN4naiLQnPYNMle9gC/wfI3oPvuhEKUf9R3Q6G5P3Th1UEoFEALrD0rhAS1rdhY0i+k5dY40tJGWpVTJP9vMdWYEESSa/QRV1/wF4tW/sDMoIJXEBNDoFNTgb4/ZdN6SREVBMVt19B7rv5fPYUOavKnLF9HHlkl3DMy0pJ/PorcQL7KPpBYQrel157EkXQ0rpXzYqmd69U1y/D0t5aqFhhbXpf+kOr+5dtkempuqOG4JKTlz8sbTgjRWig==;5:syslqZYLFVFEE55oWa+g6gLkLMonThJYX19TXMcNzl/5m0IJfGZn/poUfOf+eaVXBWcnTrPAp0ojV/IPXJJV7SvJnseEHoLHRP7CKrFVZUjljA2Eo5XAPjFZAfCNBDvSwxrY8IGWhVEa7ODsdagAnozL6rFAancd9wlp87Up5J8=;7:oiVm6duIMBBInhcfI6c/aUHrQDs9xwtCfZ0Rqpj5mSJGLSi88/0GL6bKdOSaW7eG0kgq9D66hzVoInKFJgwWHAxUSURxcCrjqSxBLPfBDouFQ1ipDbpV66hn2vlAIqTAaGQBZ+Zc+dAsZZw2RirHZQ==
x-ms-office365-filtering-correlation-id: 50511eff-ca72-4852-60f2-08d64ebf5efc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2260;
x-ms-traffictypediagnostic: BN6PR1101MB2260:
x-microsoft-antispam-prvs: <BN6PR1101MB22602ADCA39D6F46FA9C0F40EDD90@BN6PR1101MB2260.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231442)(944501410)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2260;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2260;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(366004)(39860400002)(346002)(37524003)(199004)(189003)(6486002)(14454004)(11346002)(53936002)(2616005)(446003)(476003)(2900100001)(2501003)(6512007)(86362001)(106356001)(2906002)(36756003)(316002)(486006)(8676002)(72206003)(81166006)(81156014)(478600001)(105586002)(6116002)(3846002)(71190400001)(71200400001)(256004)(68736007)(6436002)(97736004)(102836004)(4326008)(386003)(6506007)(186003)(7736002)(305945005)(76176011)(5660300001)(25786009)(99286004)(26005)(8936002)(66066001)(110136005)(52116002)(107886003)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2260;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Q22N84UZXWMSTXHMgYa24MVGjM/QuEaIkM7KidWHDfyDj7U4oRzNyWoFop3mwuIHvRalPUsWTnYxZx+dN4Ge+4/ymhzXTqTbUKiwgecoNVunHR/gTCrG8Sf0tC8GEKHxwNNqJxm0wc1/RZyKRQCob2cBO/9Lr1rGzkB8Gc5MXFDTFLyLwIYKUS0oHLzyVFRQCMi5W1bjqrmKzkr6Ot0lxJ0yKUJYDv72ZQPIWlIX/leV78wIR84uUou9OOcjMeKdevYZaKbsl407seLSJ+yiqCOw2CSf0h6cFQF/hO+qhfGXc7WfBIrzOETQxK8m+QYT9w45EXDKEpCyv1VBTdJ59/ju4XnYnYRkRwh2nL0+03k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 50511eff-ca72-4852-60f2-08d64ebf5efc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 08:08:36.2884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2260
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch describes the compatible and the device tree
bindings necessary for the SAMA5D2 PIOBU GPIO.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 .../bindings/gpio/gpio-sama5d2-piobu.txt           | 31 ++++++++++++++++++=
++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-sama5d2-pio=
bu.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt =
b/Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt
new file mode 100644
index 0000000..2e260e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt
@@ -0,0 +1,31 @@
+GPIO controller for SAMA5D2 PIOBU pins.
+
+These pins have the property of not losing their voltage
+during Backup/Self-refresh mode.
+
+These bindings should be set to a node in the dtsi file.
+
+Required properties:
+- compatible:		"syscon", "microchip,sama5d2-piobu"
+- #gpio-cells:		There are 2. The pin number is the
+			first, the second represents additional
+			parameters such as GPIO_ACTIVE_HIGH/LOW.
+- gpio-controller:	Marks the port as GPIO controller.
+
+Note that the driver uses syscon and should be the child of
+the syscon node.
+
+Example:
+
+	secumod@fc040000 {
+		compatible =3D "atmel,sama5d2-secumod", "syscon", "simple-mfd";
+		status =3D "okay";
+		reg =3D <0xfc040000 0x100>;
+
+		pioBU: piobu {
+			status =3D "okay";
+			compatible =3D "microchip,sama5d2-piobu";
+			gpio-controller;
+			#gpio-cells =3D <2>;
+		};
+	};
--=20
2.7.4

