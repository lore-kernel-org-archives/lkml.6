Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A9EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C59420657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gVaNBa8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfAOMAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:00:47 -0500
Received: from mail-eopbgr130042.outbound.protection.outlook.com ([40.107.13.42]:23552
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729320AbfAOMAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr2xerPmKuB5CdcNPe6gcR9buYc6NwG3/39xDaeSUpE=;
 b=gVaNBa8Gcm+avBNYGLuhJfFqHiXQaUSMP5dATfXvcziQTrESPvuLr0vZFR5eWIlXstBx5uYDhYa8EqIvFGLsxxXujlgD4L+M6z9BlBVBf1LfYqHtC74IW5IxUOssnaxfVaH1aF7Kbe1qBsDLtWfK2FJGXXlVC3UJ08ObZoOMOM4=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4301.eurprd04.prod.outlook.com (52.134.31.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Tue, 15 Jan 2019 12:00:26 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 12:00:26 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
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
Subject: [PATCH v8 3/5] arm64: dts: lx2160a: add FlexSPI node property
Thread-Topic: [PATCH v8 3/5] arm64: dts: lx2160a: add FlexSPI node property
Thread-Index: AQHUrMnmG0R4tGWK7UOvqbFnAen7xQ==
Date:   Tue, 15 Jan 2019 12:00:26 +0000
Message-ID: <1547553487-9936-4-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0096.apcprd06.prod.outlook.com
 (2603:1096:3:14::22) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4301;6:TI3pTvm0Rpr7h2q7Y5KFGArHT4lQmDpPvAMPEmYl+BUbQvRAYXzYM5GVDYRPA7ZLAfSL6+K1aQ9GidxxvVTGreiwXju4/1k/jQUEtgT9aOgplRZh7oGX6UqLc3BD170/YDTWwiYRQtVMLJi1JeILm2UaqjVsSK93RRguGiHLdK3P4oudIb+WNJWBei6cmknvb2kf+kMXrdtLvzZNd03igvCEB12VAJJ+/r5nHBHM45HtHMVHDMi9jh8rHbNuFn9crp9AM4rscqeJLrGvVcY3ABcUeZxC2yaz8YMJk9YwE9yl9KbwNRVAFMuSm1eKzTMVMowbJCDost8KPVpOZQkcUlrTm9EYIqssTXF3tLsUzT/rbSh4nNB/RdUcN9wGnFGH/it1szV8ZWWoQ8+e9jiBYewTBOj3pGfPEVeuo0Ei8XHlzyRBGEgkHKTDUv11TFt8zCh7RaCVSsICPMUs0VhfKw==;5:xwSXufoudQccDgPdHJFSHl9CTMk7GJJwdSsxuJWfwSla+VhRgQRP/Y4Nh4Xqzq5e1DSBWK5Z7r+FSsGo4mVvjCszQpUGeoMRes+6wcBA/4sV3Nml52B+Qh04CFfwPEdMWNCE1Ey7xjQ9JuspB8aXUtm2bU1S0e1GpV5FR0rTlNXFak2NbvzZ9xXTZP4qmDOtYoZc/e6UHdHMR3lslf1GAg==;7:pHN6qNB2R+nrvdwhpBskU+TbU7ESzGntz5Jqy0XR5AFNCbxaX34FsHPQkWGoLdHHiIekrLI9an6ETEwBjcQr58zMpTKAkrWITC4SJJBrM52+6mp+/QMdSJtl+rM22hXx87lyQcVN9WEI/yQ4K7vgAA==
x-ms-office365-filtering-correlation-id: 27372150-6acb-476b-70f1-08d67ae1091e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4301;
x-ms-traffictypediagnostic: VI1PR04MB4301:
x-microsoft-antispam-prvs: <VI1PR04MB4301C797E2BAF556F4915A7399810@VI1PR04MB4301.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39860400002)(189003)(199004)(26005)(102836004)(6512007)(25786009)(4326008)(105586002)(2201001)(86362001)(478600001)(186003)(52116002)(6436002)(53936002)(476003)(14454004)(106356001)(50226002)(8676002)(81156014)(81166006)(8936002)(7736002)(305945005)(486006)(316002)(68736007)(36756003)(7416002)(110136005)(54906003)(3846002)(6116002)(97736004)(78486014)(2906002)(6486002)(256004)(14444005)(446003)(6506007)(386003)(11346002)(39060400002)(2616005)(2501003)(5660300001)(55236004)(76176011)(66066001)(71200400001)(71190400001)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4301;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DG3mSoCBooPsRvimTezGXisjYmT6/7cXRMPIqxrX5/RJOyg4X2v8t5P4DbSYLVaFAatASpg0P01Fl1d5ozW3jc21UorbYpdQeBo8FFHl2lGTZhkye4FHaKD/yYFo3YcnmemdCG3IWw0K0IYaT7o60IkjzB9uJtA0bSXSOOuUF93sTdHc0O0hg0+ABCu2t33aOc0ABwaBPIb8B8HtmhhuHpg8X4wUBSHiKJ31L9LrPLiLFdWFhcS6qRRIJVyy4Mad6/UxLoapg7GlelbuAqSIKdyZFDDps0bLK7vL1hjyOtCiMH4ue9dJ1TNy5vH6f+QDy8FlRtYkoJPeudTCKO7WLA9WArBymfCE7hW36J3KH1C6zi8KpY+EFZkF6dt8rlpwt0VxZO5Ad/JyGrR0QxffFR/E2tRp98vyF2lsed8ObHs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27372150-6acb-476b-70f1-08d67ae1091e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 12:00:21.0598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4301
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
Changes for v8:
- None
Changes for v7:
- None
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

