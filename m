Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA3FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FBE218A1
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H82Y5CCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfAHJZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:25:04 -0500
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:56381
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727367AbfAHJZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:25:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eNQ4wdp+nt3DjPm54lpGYIcDvFUrAxITWeEZ5hRjrE=;
 b=H82Y5CCx1QQUsXd+uxgH8rCRQ8RnBmPB0/E9zpZIKYsgPKoryuiR9YDQ4sOAokroGCLd37yFe8PMGTdkz8xYx/LnuifWdZPgCLYnEl/Qd8hgOlSqrhoagPn/0I/K+F+zk9Er3H1alK8adVFGKVtg0+dQAo/4lulWihHMnyc5YG0=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5886.eurprd04.prod.outlook.com (20.178.205.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.8; Tue, 8 Jan 2019 09:24:55 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175%3]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 09:24:54 +0000
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
Subject: [PATCH v6 3/5] arm64: dts: lx2160a: add FlexSPI node property
Thread-Topic: [PATCH v6 3/5] arm64: dts: lx2160a: add FlexSPI node property
Thread-Index: AQHUpzQEH0yUPlXZL0GxfADI6wSS0w==
Date:   Tue, 8 Jan 2019 09:24:54 +0000
Message-ID: <1546939346-20181-4-git-send-email-yogeshnarayan.gaur@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5886;6:+Z5crLIWrAsZ0FyM+3ZipU71Tknkeq86tdJQBrtPtBZdteZzOxJcjDfQoAR6DFVuVuY+bIgPc6VrMUFGtE+OjvYVMrFiSMzZl8kQpYTgxgBRvQQ9k56q/6HMUPXAHSt3syvKHF8n43djQWWKUzP7fEo3MeTk0rDogC6Hs0668SRXHWiVsOaLaV+NmPmrA+kXA3zVpuhRd3nNFYwpahlUq7yDOjUCBdpy00jpYZW88Ti4pb0V9CgeMXjyJ/5174hogLdJzDxkPo1jl5KX15dL1rNH4oK270TasQSUnuCbcjfRmA9yUmURdT1zs1Nco6g/QVLQsSpNoMCxQ7crDIDKj07JljHKMuf0UUMCykAKNZHn8XcwYq9woWkYvGNzxvACVx0RhdmLsCMs1rot1bZ9Kz678r/Kqv2q7kSxuzPB5yQNMxc3xgEXxwZSD77zzRKhtuLKL4DL74Ov1BxRejPMLQ==;5:tV8unxsSpyRHWl0elDw8LX4lej7+5j4jVMuULrXZp3sYXTs51w8myaFXgLV0UA9+zS1hOLiTcrBuTmT/LTCuIu5U3KwVLwF4L/j5fIzxaJdVFe4C4EB+JA0I+g2Adztj22SKhLpOO1PqSNY6vIbzAcvjeqXaE3HJnIkVFRP3OZ71AWiVgYZa4K4VhdGHeI7+RB4kUA1iFrJk1BU7gG1S/A==;7:YkV8ezsZ1Zc9Uh5IrUk9bKuqD8GyEhWv9k7hTXcpdaoPixVagDvNJJP37EHhdubfHAllA4u6kXkuR4Kn7nYfh9+s8b+yYqATYWi7vx92A41AHowIjH/fOOHuoLoIRfDXKOW3eebiaswRjtHasBTOYg==
x-ms-office365-filtering-correlation-id: 93e54b39-3fd2-449b-c2ff-08d6754b2639
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5886;
x-ms-traffictypediagnostic: VI1PR04MB5886:
x-microsoft-antispam-prvs: <VI1PR04MB5886D67AB096E350B34AB958998A0@VI1PR04MB5886.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5886;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5886;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(8936002)(50226002)(2616005)(2501003)(2906002)(256004)(14444005)(81156014)(106356001)(8676002)(81166006)(4326008)(6116002)(478600001)(39060400002)(25786009)(105586002)(316002)(53936002)(99286004)(3846002)(6512007)(6436002)(186003)(26005)(110136005)(78486014)(36756003)(54906003)(97736004)(6486002)(71190400001)(52116002)(14454004)(6506007)(386003)(76176011)(102836004)(68736007)(55236004)(486006)(2201001)(86362001)(66066001)(7736002)(5660300001)(7416002)(71200400001)(11346002)(305945005)(446003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5886;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DrPPocMcYB+bTpL8tbusOPJyzc8UvlVoGo035uOBhbVpCkNggx7V97awCtfVnaOCKvfAPZMdtEs+7LalAjGZquOVrsxepr8qT4pcLZlIx99LjcM0Emexw3Wj+JolT/J1Jaz3luKgL8K9Gl9deDrZKrlrBP8YywNCJ1OP/i2AdjI9IqdEo3Nvq9Z2LSPp5CuAzjEDJeqEZXuCoaPYi96+bSLvbbBxmQ9XcTWWycfcbNjbI5ea74qQ1avyZ2n6FyVkBj1XEB3CnCmgp3+xJ5E2dtkpZw2d/OzycXpwiqslXArk76d6whB5db+m70lHjEP9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e54b39-3fd2-449b-c2ff-08d6754b2639
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 09:24:48.7890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5886
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fspi node property for LX2160A SoC for FlexSPI driver.
Property added for the FlexSPI controller and for the connected
slave device for the LX2160ARDB target.
This is having two SPI-NOR flash device, mt35xu512aba, connected
at CS0 and CS1.

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v6:
- None
Changes for v5:
- None
Changes for v4:
- Incorporated Rob review comments.
Changes for v3:
- None.
Changes for v2:
- Incorporated Shawn review comments.
---
 .../boot/dts/freescale/fsl-lx2160a-rdb.dts    | 22 +++++++++++++++++++
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 13 +++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64=
/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 6481e5f20e69..70658946fbbe 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -50,6 +50,28 @@
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
+		spi-max-frequency =3D <50000000>;
+		reg =3D <0>;
+	};
+
+	mt35xu512aba1: flash@1 {
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		compatible =3D "spansion,m25p80";
+		m25p,fast-read;
+		spi-max-frequency =3D <50000000>;
+		reg =3D <1>;
+	};
+};
+
 &i2c0 {
 	status =3D "okay";
=20
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-lx2160a.dtsi
index a79f5c1ea56d..e3ff86201f73 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -762,5 +762,18 @@
 				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
 			dma-coherent;
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
2.17.1

