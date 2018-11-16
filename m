Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36D3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFCE2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HvqsbTbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEFCE2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389652AbeKPV0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:26:05 -0500
Received: from mail-eopbgr50048.outbound.protection.outlook.com ([40.107.5.48]:12395
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727734AbeKPV0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6xvKwhAEeZkx7vUATKgJO+G7zQ8xdkwRT3CZnp54DM=;
 b=HvqsbTbz1CBmrObUcyYA3+XZFEr9DP6GgzcVwso0m7hCawXQQlwP7Rbc2NYSezQNvZwZu0CjjN8KDPnwPZ074r4fHzig/8pOLhTCZYR8qkkhwwCBI7l2VCBnrgONlucbV6/Iwtnn+qUWoqD99oscuIe9nGWP25yT0h0RJDeQumM=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB3294.eurprd04.prod.outlook.com (10.170.231.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Fri, 16 Nov 2018 11:14:03 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::297b:bb50:9b83:48e1]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::297b:bb50:9b83:48e1%4]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 11:14:03 +0000
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
Subject: [PATCH v5 3/5] arm64: dts: lx2160a: add FlexSPI node property
Thread-Topic: [PATCH v5 3/5] arm64: dts: lx2160a: add FlexSPI node property
Thread-Index: AQHUfZ17GochuuzGXUWIsh2tPxHaWA==
Date:   Fri, 16 Nov 2018 11:14:03 +0000
Message-ID: <1542366701-16065-4-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0149.apcprd04.prod.outlook.com
 (2603:1096:3:16::33) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3294;6:LeOq41QWnJ1aICju1Nh5ONqdAX9eX4qc4ny6rMcCbaKWimZvKsaRiNIsEUKsGcLikM6mrnSU3L7vUlGqL5bM7HT7eY9vzQ++eq+gFBQjV2S7APRQUCvqlQ5HoNXwAsUu//vGqbwPRTNLM5dMo+H/MMa50yH7HJ9S020LQ/5LBBBLGN3qGvc5jYc4/enk4P8KcGJmr8grBj4SypQQk0Oqnb6Abnz06dxOHck0LZ571o8/+RKP0Daskvm6CiyJlo6fq5BO+ft5YkrrfBfiMgcBMtEStxyY/U6ioRUITp01rzGSdgl2Y8JSNXrZV9ySPCoP/T5huhckfNKdmD+ccIihY1kGW3sp22mhsIxVAGyeJgD+45N17OnVnCX2le+k8fm61X32vohB7ckHJnK2kA1+8TQyqQzammm/lrMz+Yt8eyiO/MK11JmpvpgiuDkNQSVj75hCz+PfWCfts+t2abBn+A==;5:Vs1I1SDU3jFbL3L9B7qwEyCsq6h/t7jjAJEO6HQypzgXIZNEIcy4/ONCAJKGW/QIwT31pW/4wxdlQdIioFrEmD+Z8Yf+HorV1485vgdPiPJEtYO6uRt0hz3gLwhOAMfTcdWni1N857J+tuBi7xWTE5gBSJPo4NIkLN+iuL7B7WU=;7:+urrcBQ8knoa6B84n3iivWrX+/rymBQyXKgLFewUEzhFLTYaprKfBB3JC/8GGKs8gEZlHsT+gMJUvoryD55s+1OFP4zwfPrJXUPQHlyzXrTn54ZCkmF9M5PQWug1wJpEGNRSm4TO3UJ1o/S88O37yw==
x-ms-office365-filtering-correlation-id: 24446cf6-698c-4275-b9fa-08d64bb49db6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3294;
x-ms-traffictypediagnostic: VI1PR04MB3294:
x-microsoft-antispam-prvs: <VI1PR04MB32941B07EE51806A2642734699DD0@VI1PR04MB3294.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231415)(944501410)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3294;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3294;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(396003)(39860400002)(376002)(199004)(189003)(2906002)(81166006)(8676002)(6436002)(106356001)(81156014)(6486002)(102836004)(25786009)(53936002)(4326008)(316002)(478600001)(8936002)(7416002)(6506007)(55236004)(6512007)(386003)(26005)(105586002)(186003)(54906003)(110136005)(68736007)(14454004)(99286004)(52116002)(2501003)(2900100001)(2201001)(76176011)(3846002)(6116002)(97736004)(476003)(2616005)(36756003)(78486014)(305945005)(486006)(7736002)(446003)(66066001)(256004)(14444005)(71190400001)(86362001)(71200400001)(39060400002)(11346002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3294;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: B+8QyWlxjrPKrptOAwoNUCuKfhAHFM963L4qakyJIZf+sWoHJa3tQX/9MzU2GSy+gOlLLq0R3fPKZxkFW4qQ7gP5pkQeGaCzpNcsy0k1BfznAI7dO+GiZzwsXzg2oJMKSrOyjhiLiIrFCfILtCFlvjTgQ4xQOXJ33aCsMMQ8yubFdLaZNgXix1LYzCps38O7eW+Uh5jeFg4etN2ZbVqtuQbIyF+sErsIwFSezr1xtBnyPpXIdIhF9CW8li8KreKZ/ynZ0udyuRXOYJagokQH5VQPitXYCB4cpSSTpfcIwwLzr/IpVhjqXfDAHW1wOfnDW7JlVg15IMj8V+eNmgcv4rSVp1Bfnjo/p78tpsInnxY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24446cf6-698c-4275-b9fa-08d64bb49db6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 11:14:03.5491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fspi node property for LX2160A SoC for FlexSPI driver.
Property added for the FlexSPI controller and for the connected
slave device for the LX2160ARDB target.
This is having two SPI-NOR flash device, mt35xu512aba, connected
at CS0 and CS1.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v5:
- None
Changes for v4:
- Incorporated Rob review comments.
Changes for v3:
- None.
Changes for v2:
- - Incorporated Shawn review comments.
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 22 +++++++++++++++++++=
+++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 13 +++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64=
/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 1483071..3b20c97 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -35,6 +35,28 @@
 	status =3D "okay";
 };
=20
+&fspi {
+	status =3D "okay";
+
+	mt35xu512aba0: flash@0 {
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		compatible =3D "spansion,m25p80";
+		m25p,fast-read;
+		spi-max-frequency =3D <20000000>;
+		reg =3D <0>;
+	};
+
+	mt35xu512aba1: flash@1 {
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		compatible =3D "spansion,m25p80";
+		m25p,fast-read;
+		spi-max-frequency =3D <20000000>;
+		reg =3D <1>;
+	};
+};
+
 &i2c0 {
 	status =3D "okay";
 	i2c-mux@77 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-lx2160a.dtsi
index c758268..5d0025a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -698,5 +698,18 @@
 			interrupts =3D <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			timeout-sec =3D <30>;
 		};
+
+		fspi: spi@20c0000 {
+			compatible =3D "nxp,lx2160a-fspi";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x0 0x20c0000 0x0 0x10000>,
+				<0x0 0x20000000 0x0 0x10000000>;
+			reg-names =3D "fspi_base", "fspi_mmap";
+			interrupts =3D <0 25 0x4>; /* Level high type */
+			clocks =3D <&clockgen 4 3>, <&clockgen 4 3>;
+			clock-names =3D "fspi_en", "fspi";
+			status =3D "disabled";
+		};
 	};
 };
--=20
2.7.4

