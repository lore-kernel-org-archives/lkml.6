Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC294C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB2320657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MtyO7YuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfAOJuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:50:44 -0500
Received: from mail-eopbgr140079.outbound.protection.outlook.com ([40.107.14.79]:13070
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727410AbfAOJuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bA4y1Ir6rYl3LbKfNhCiaBdNtImU5JocvqlT3bDDifI=;
 b=MtyO7YuOG/Go0fSJHdwIio+Wo0yWrcZa8wse6ZuaDbRVUXuNpy5aICcL8CRp8ehnYw57I9BiXNqIvZt7CenmwYrmgU4inJEvb7PhHjSYVEyLrI94pZEQnMHG737E8mMaVB9cqkFcr6Z5C+U+mOWTkFOVWjmnzVSrYj3rgZ2ge4c=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5086.eurprd04.prod.outlook.com (20.177.50.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Tue, 15 Jan 2019 09:50:35 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 09:50:35 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v7 2/5] dt-bindings: spi: add binding file for NXP FlexSPI
 controller
Thread-Topic: [PATCH v7 2/5] dt-bindings: spi: add binding file for NXP
 FlexSPI controller
Thread-Index: AQHUrLfCF980LyW4rk217qdQa1lQBg==
Date:   Tue, 15 Jan 2019 09:50:33 +0000
Message-ID: <1547545697-4042-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1547545697-4042-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547545697-4042-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:3:2::25) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5086;6:gHeMaS5ooCO3e+EQHeXPdWX/R0z5z6L7eO4CdQ1xVUpEox2JnVbTXi1TGUftPqoMuC76+PsOs2fT2h4jVVh94/krVUtyeHuDQaIbXHIWpKQ6TtV/k3YXj4uv2PMvaLwRapqNqABNtQjlbRmZLQYDAO5gExF27D+NSXmokHmbcFI4SU7n/r3OhyPUv1q7DMewPIhdX8NvYmF1Wip8UlT6W/C/EUWUs9it5daZGORPGFJ+u68EFYHGzZiwdRovtV/38yKZIpps8sUqQtUxcLg9et8LwNs7TJ21wdgV+7tmxaOQIijpXA91SNRUrR+QFOqPiGHo1ayK2i0dSJhAXSRzRZn9RfPckRkVeQVKNVZba4MV/1E963cePgAaN/OIQB2J4H5UBxZRZvDrdcYG5JEuFlf7LKk99kCkn79lwC/VCRK4kYmOxSs5eZppUPtAAdP0nl8jyvRF9jtCwIIx4ik7KQ==;5:oc6UOCjxKXi+hUSk+Wzau2tubHcuJsUXaGZIKeqHRctCu1OtKRi2djB73kupC2eT/MgUmsXd71uMo/qd98cbsDgcwNhZffstz2IqBEtf0eV+ClOvvUTD3lFeed/BFCMPcK4Em7Ev81MltJIJIN1d+f5b18woZqPNikigU2HSdxvQc2SKNHLvA0B2eBdIRsTGuMm1wdl82XDUMrYoi3SNQg==;7:/cQeZjgBqQnVjNkLFZbnX4Wn9ok4d5ohn8CPm/AwkBjWHNisNEYuhxWffbGi24J5yFQq3Ls7jKQ+crF6DG/xifMtKiAnRNSswmyf0wmNHC4Z5pXWZ5bm++TzrcBf5mC4/df7ImfMM5FHH5bIsTaKqQ==
x-ms-office365-filtering-correlation-id: b4c123a4-dd92-44d7-bbfb-08d67acee44f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5086;
x-ms-traffictypediagnostic: VI1PR04MB5086:
x-microsoft-antispam-prvs: <VI1PR04MB5086A59DE36ECF828F3E600C99810@VI1PR04MB5086.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(39060400002)(7736002)(305945005)(2501003)(110136005)(99286004)(66066001)(36756003)(50226002)(8936002)(25786009)(2906002)(486006)(4326008)(498600001)(256004)(54906003)(86362001)(186003)(97736004)(2201001)(55236004)(102836004)(14454004)(26005)(3846002)(7416002)(6116002)(6506007)(386003)(52116002)(106356001)(76176011)(5660300001)(71200400001)(2616005)(78486014)(105586002)(71190400001)(68736007)(11346002)(446003)(6436002)(6486002)(81166006)(53936002)(6512007)(81156014)(8676002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5086;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 88hShAKVMRgyVA7IOWpez7LbxN4M+mzE0dY/TOYM3duVZQCbBHzzOkzeDzCFQA3y3vrkGX4IzftaHoCow1MdKlgetPw8LkkqQUGxAKJ9mq1lKZ5kSR/7c5RkyJ/JN0e0UmRCU0HrEdBrkCwBkofu3Q2h4tS38T1oXYc3ujBAebNZYcjgQZPGTlf9f1ugTPItGgKEZuN3jbDP4bG+Y0yb9anmXKDW3ydZSR+j8H3WN/WcV/MSWZktTZ0ch2fjXbOk9XNiPZzi8uZPHXFEOhsMx0x0jc1QJQ8oyWZYtXjclvK1SxxTiM1bzTgPrYkXMcP6lZVZIXvNeGHrnwjursItWrvbN2Jq8fa6Y6OkPGM7PuZsw9csSNIIxUeUQyMqtxZIP/mWANbM16TCpfJXWv/L/MgDtJZWPt/e4Edwa58QfCs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c123a4-dd92-44d7-bbfb-08d67acee44f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 09:50:27.3659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding file for NXP FlexSPI controller

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v7:
- None
Changes for v6:
- None
Changes for v5:
- None
Changes for v4:
- Incorporated Rob review comments.
Changes for v3:
- Removed node property 'big-endian'.
Changes for v2:
- Incorporated Rob review comments.

 .../devicetree/bindings/spi/spi-nxp-fspi.txt  | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Docum=
entation/devicetree/bindings/spi/spi-nxp-fspi.txt
new file mode 100644
index 000000000000..2cd67eb727d4
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
2.17.1

