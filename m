Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DFFC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB2C218A1
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ibItGUPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfAHJZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:25:02 -0500
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:56381
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728374AbfAHJY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:24:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rINqdV1jsxCCIJv9h4kS4qvSaec9wAj24jn5agBNL0=;
 b=ibItGUPaifGle85ECzfxm8nKr5HGt5dXI53AyUBTLFKWZbRujaPRbLs129Btfwo8jJliadGj5WzApqKR6SrsdV4a+Vvh8WqTzm7ml49PmX/WhnJZXHj+6yJDaH2OF9yac1dd/DoIH6g+uhjI9Zmh7GbpbZ65aNK3GP+rzSmQtgI=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5886.eurprd04.prod.outlook.com (20.178.205.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.8; Tue, 8 Jan 2019 09:24:48 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175%3]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 09:24:48 +0000
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
Subject: [PATCH v6 2/5] dt-bindings: spi: add binding file for NXP FlexSPI
 controller
Thread-Topic: [PATCH v6 2/5] dt-bindings: spi: add binding file for NXP
 FlexSPI controller
Thread-Index: AQHUpzQAll+tUvFnp0qfoAb8WsqAVw==
Date:   Tue, 8 Jan 2019 09:24:48 +0000
Message-ID: <1546939346-20181-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5886;6:UvSnEQaXi1V2yIKpPRnz8ZMxDhEzh78iQl6zu5J9aOGFfKbHHls9plUTeDmssHuL3jAGxSx0R9mlJzIFNsNmQCCMJlKBdvvwkClHcHkM5EZMbU2gwVPKhCAgRq3l0SmLpGqBi//YbF2Jlpnux4I8suIo1BIVxdvPMPiJHYsUhg2wov73BJ5RMtibvo+uMIgAK7YOKdohmxcleKzfSfqvghE6/sqp9mK0nBP+YMfWiKx2EyBiIJRjmCfTPv3Bjw2Q7lgFuU1acNGx4MWSwvtW5gVtjuDiG7IWn6rEkMuyqJXEmlB36xtlsP9m5HBjz7mlU7lg0951kZYB3cmS5pQEJGW8KDo9z2M7w3MTkEYypTrBVSOOp3vLfBIxaEtxaq3irKuevE9Eg3Ds2vKur8gogl+B9uNvC4IIk69bhmdQhdxJUE4zJDcwjNd0vvacTqw6n5eYbYxkuwpnN7EqiuTFxg==;5:K0AJgDFpYxg5OoE6STbBvG5a4/PqHw47gl05/oo542Cb0b7HJcgqnfsjIcDUyrA0uT/vA0Hdve8r9Br8MNKmXOYu7VnWf+rh5rDuSnbd/ykBSOiV3VHYSSihvQamv/fSmsV40hRZEBGDtUues7ozYP7p8dbV8lrP05ps846t2/cvHUKQJ5PnR2Ta5tHOkX1mBRwfEGkh//IRUUypaKbkpw==;7:1W6Mj2+/7FHIBMqc1NuW97NQaFdmoVTiSPx7w0sez6PlCDGpjYOM1mIoVMc2FPhDy22jgwDYkE7CrV7ClSqH3XcThMz83YkzFrNZNBBZnPevOUuTJvysQ9bcb3MiqYLkF155xED7Y6h/mfN89QEzkw==
x-ms-office365-filtering-correlation-id: 588054ed-a006-4662-d6b9-08d6754b2264
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5886;
x-ms-traffictypediagnostic: VI1PR04MB5886:
x-microsoft-antispam-prvs: <VI1PR04MB5886537A0922DFEC5BEE78BD998A0@VI1PR04MB5886.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5886;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5886;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(8936002)(50226002)(2616005)(2501003)(2906002)(256004)(81156014)(106356001)(8676002)(81166006)(4326008)(6116002)(478600001)(39060400002)(25786009)(105586002)(316002)(53936002)(99286004)(3846002)(6512007)(6436002)(186003)(26005)(110136005)(78486014)(36756003)(54906003)(97736004)(6486002)(71190400001)(52116002)(14454004)(6506007)(386003)(76176011)(102836004)(68736007)(55236004)(486006)(2201001)(86362001)(66066001)(7736002)(5660300001)(7416002)(71200400001)(11346002)(305945005)(446003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5886;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kTVUmxUI5098mo0ZpeRFvZnf91YV93pSi23SqwChexY54T0SGS/TU5h61BNzbYXZBkx2Xn1QdXywLTh0UKsIOTr/rZWxgMkfci86ko4uf55p902Vb4fLYvAXyoFRtq2+s5HjBlM1DR12v7Vzo2viPWZfmUJ2PT0uJ2M7nv6R/WnseZJzObW788OVZ4cKkDaHVYgfG34HCxxDCbiNG4U/ubdB5dc6IUVDCcDGS6C4EsYDCZMuMhwQF2ROREBiL6DbIl1Kp9FYxq9F2NWwI23uaxgR2d4V6aksnl4VkGo5Fos6jMsHtHKM8Jdr9ArICCPo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588054ed-a006-4662-d6b9-08d6754b2264
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 09:24:42.3675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5886
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding file for NXP FlexSPI controller

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
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

