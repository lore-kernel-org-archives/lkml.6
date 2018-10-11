Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE30C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB59C2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZrFLJMja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB59C2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeJKS16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:27:58 -0400
Received: from mail-db5eur01on0054.outbound.protection.outlook.com ([104.47.2.54]:50555
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728120AbeJKS15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXzbUqqJFXwwoBz1f4lXn1eR5ymgFpx4P9uWX4cx40E=;
 b=ZrFLJMjaeMIFMtW+xzZT2wG9E7+1oZyKwbdJGTCMB+RMJBkuiX9sXlAanup/XWZVu+Sj4S4iZ3vTSyfctlBOS8R/A52Qx1jHlN0iqW0ZZDimU2WYpRMlnr+QY2Z39kvEk8u252QsmMdH2k/WuQ1gZfYbXBa28ErEgk5VSJXc9I8=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1024.eurprd04.prod.outlook.com (10.161.109.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.27; Thu, 11 Oct 2018 11:00:38 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1207.024; Thu, 11 Oct 2018
 11:00:38 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v4 2/5] dt-bindings: spi: add binding file for NXP FlexSPI
 controller
Thread-Topic: [PATCH v4 2/5] dt-bindings: spi: add binding file for NXP
 FlexSPI controller
Thread-Index: AQHUYVGkf7E2fRauEUGzrcMJU3QQsg==
Date:   Thu, 11 Oct 2018 11:00:38 +0000
Message-ID: <1539255519-1408-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539255519-1408-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1539255519-1408-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0173.apcprd06.prod.outlook.com
 (2603:1096:1:1e::27) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1024;6:8NPTJKabqhkYfu6Xy5j4RS1+w6I3B/DJH9GT+vmOciZBqStpVowVKkCeKDtzk9vMXO/5mnYeTYFc/6k1syy8Oj4IqMFYTx56mU1UjJtGAjunU4zTKp61K6OZpVa9yffE2cdHXV8t7BZ7AELcciA6iH0H+JlRZ5Fo9131iGSDqK+Z/n2w9EAcxrOhXBPzCCn7ewRj0/MgpYBzRgukiBE8sRk7eHc0A4O/ZIoogRFBcx61h4Uh3q7FxvopXqBz3ZsIzpt83eiSqL6PP4dFr47/qZj6h3dzilyhsDsZClSbtsWQjDjh0vePd89oJrbtloWHIqRF7rITWwVasERYxWQRBS7+TBY0Fx2IfX0lEJdZTCjFglrouBbtFa4VCrMOuy+7Bns756wxRhaXjZh9ARxhRL/uW1vl8oNZTKG3y/iZIMAgODIwSMW42ubqkmYfljRZaiX1hdga0ayJKPXl1QlYLg==;5:LWHXxq8KW2K6stmIuD4xPDcuZWpyBWdqxlcjfUCtbNHOzzbyMJNb08MDhn63k3IN2dhf09/+BTLyfiQ387RxkJNOQxLebNm8AzXvcq4tXneMZGVWKUVQTHR7teYNjGf7Ims7S6/fsnzp6ZgRek0x2uSGF+64Js/+9qKkI27MQ9k=;7:5UVQpsaJ8RbYMWGuHn9P5qKovuDBycRhFlCSyXIJq5exZ6dc2PIajZNy6vNA9QeHaJvDLqWUtairaoxJQT1ILLk34rUCqeLNnuzjQ4i4k0AAb7E99n8Tt6WH09gHetTbojii2DwkvxNW8SqlfGnrb4054SjNQXd0lDYGDqMHVQ2B0oswMqF01EvItH7F3IoO35GBH3+daM1JxI7HpQT20t17EsFh8ol0lBEj/w9KdcmzovV2PJEAcaZ8s0rsPPF+
x-ms-office365-filtering-correlation-id: fbf969cf-3a8d-4cb0-76c1-08d62f68c6be
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1024;
x-ms-traffictypediagnostic: VI1PR04MB1024:
x-microsoft-antispam-prvs: <VI1PR04MB1024F2B52E6C5829A701596099E10@VI1PR04MB1024.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991055);SRVR:VI1PR04MB1024;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1024;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(366004)(189003)(199004)(478600001)(39060400002)(4326008)(54906003)(66066001)(25786009)(8676002)(2201001)(53936002)(68736007)(486006)(476003)(7416002)(6512007)(446003)(7736002)(3846002)(6116002)(86362001)(11346002)(305945005)(8936002)(2616005)(81166006)(81156014)(256004)(105586002)(106356001)(6436002)(186003)(71190400001)(71200400001)(110136005)(2906002)(55236004)(6506007)(386003)(5250100002)(99286004)(2501003)(97736004)(26005)(52116002)(6486002)(316002)(5660300001)(102836004)(36756003)(14454004)(2900100001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1024;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 10Y+cE/tDIQClapVTNuynYAvm0ynD9V4OO/YJbCMSdVP5KxXBpjYIVrvrECxPnkhSZcrhFzjEf1XAu4l1mmieWFyFLOUykRl0Vx+bNWMEBfwl/GeoWPX+s2GxY+C04gji/ttSEmhp1KiyjrQJmDhaDuUycLp7GkWirb+ga9HAcUlGtd0ULpPIKxbkbBe48V1NJn4GdJhUCxMfvMHsPUGlvTxaU+SHmKgqLhkDf+ULC8rB66VPj7LuR3VEuvzQ3U6cRLma8qP/96JbAY8hTcq7NCehOaSLBxu8bzPZd81au7MOM3dGaJUJ8K+PgK/BxBxMKIomFPbJema1p9DbABTOihMIKEzGy53pA2T4JC9cWk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf969cf-3a8d-4cb0-76c1-08d62f68c6be
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 11:00:38.5104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding file for NXP FlexSPI controller

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v4:
- Incorporated Rob review comments.
Changes for v3:
- Removed node property 'big-endian'.
Changes for v2:
- Incorporated Rob review comments.

 .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 39 ++++++++++++++++++=
++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Docum=
entation/devicetree/bindings/spi/spi-nxp-fspi.txt
new file mode 100644
index 0000000..2cd67eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
@@ -0,0 +1,39 @@
+* NXP Flex Serial Peripheral Interface (FSPI)
+
+Required properties:
+  - compatible : Should be "nxp,lx2160a-fspi"
+  - reg :        First contains the register location and length,
+                 Second contains the memory mapping address and length
+  - reg-names :  Should contain the resource reg names:
+	         - fspi_base: configuration register address space
+                 - fspi_mmap: memory mapped address space
+  - interrupts : Should contain the interrupt for the device
+
+Required SPI slave node properties:
+  - reg :        There are two buses (A and B) with two chip selects each.
+                 This encodes to which bus and CS the flash is connected:
+                 - <0>: Bus A, CS 0
+                 - <1>: Bus A, CS 1
+                 - <2>: Bus B, CS 0
+                 - <3>: Bus B, CS 1
+
+Example showing the usage of two SPI NOR slave devices on bus A:
+
+fspi0: spi@20c0000 {
+	compatible =3D "nxp,lx2160a-fspi";
+	reg =3D <0x0 0x20c0000 0x0 0x10000>, <0x0 0x20000000 0x0 0x10000000>;
+	reg-names =3D "fspi_base", "fspi_mmap";
+	interrupts =3D <0 25 0x4>; /* Level high type */
+	clocks =3D <&clockgen 4 3>, <&clockgen 4 3>;
+	clock-names =3D "fspi_en", "fspi";
+
+	mt35xu512aba0: flash@0 {
+		reg =3D <0>;
+		....
+	};
+
+	mt35xu512aba1: flash@1 {
+		reg =3D <1>;
+		....
+	};
+};
--=20
2.7.4

