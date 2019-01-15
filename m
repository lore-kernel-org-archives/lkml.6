Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1582C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A416D20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bv1b5dRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfAOJux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:50:53 -0500
Received: from mail-eopbgr140079.outbound.protection.outlook.com ([40.107.14.79]:13070
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726594AbfAOJuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:50:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Io13e8ejQNP3RiZBaIGX5/D1h89WVl7okAyIb3+itRk=;
 b=bv1b5dRoWSqHWmN0Fs5EG3uHV6yeVK5ks6dE4+1n2nY7DDwCbZlUkoDsenUB+kCqkDKzdBQHuumW1YIlRZGvmBP1KTeUe3wyEa39ML/yivPJloRPbD9nxzhM3scg4yWeLrxlsRgYLanntBhuboaorU93EckjraVp6h5DkWLrmIo=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5086.eurprd04.prod.outlook.com (20.177.50.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Tue, 15 Jan 2019 09:50:40 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 09:50:40 +0000
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
Subject: [PATCH v7 3/5] arm64: dts: lx2160a: add FlexSPI node property
Thread-Topic: [PATCH v7 3/5] arm64: dts: lx2160a: add FlexSPI node property
Thread-Index: AQHUrLfGVpsvUOPDeUKA4b5cC0uPdQ==
Date:   Tue, 15 Jan 2019 09:50:40 +0000
Message-ID: <1547545697-4042-4-git-send-email-yogeshnarayan.gaur@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5086;6:NMASuBaOAv7cMHv8W6TM85TAGshHmFhyTugeOjgvqsInc3XjWnaJdJBAO4IO1ohLoxX0KtoLIIAYTnwmghlyiA+db7qY+SwhDrgPpK5+B4dwLBP006CQVXzoWwZ2Un09n5c1pEeNqJeJO2AaAS1weNJ1bMerOkEXT0INm94uUAZkxvnH75xT2RxYCXS4ps6ojWJPFwns7p7vs+4ZiTyjaLhhwp5i7isnPljLqzjgACiZ9kaPrrr3uIos0jnuunohUD1YeXMLTYbduSiSJnMPlKuQzqNKz77INnw5H7nWJvfj2KO32GKCooC1dfIvb0bEDLxl2Y+YQ6rygzSBJStgTQ1YfD2Hc95k5dFjuR6gceUF8FVIDmormHGZZSPWr3EowDTg6Ml5MZAk7mXs1nkX8oCpf/ZDEIdUTeadmnWfQfNDFDtNPGHXsZQKWxWJHRlArtD8Pf4NqOzWRngM+gZ38A==;5:KJ0FkRuTi2kfnS5dIgAgyosMvI2zNojIX7i9B1C1Zr8cxRKpRw9SevluWep7h+aAwyE64aBK9GHATBvkvcb5vjnhIxraE9F+pxOLnUTd1HF0Y2LpBeKX+eEYYHSfzyazY0xhmI9lgnDi5kBsYw9wJGUwh+un3x6XdcOWnfUF1xeUwgVWIJN/tu7Ccn22j2BPYZKK5Lb4qeEAJ9rsb8hpXg==;7:Pvi8X5nxny4/t0UbJjKTbPa2NOlRPgPuffrwvN1Ga7zrNkxwqZWsNMkZrAZI2k11zh1l9aExQZ7HssbvgdeYZ/N3GglUiUsAfOyAlqikmlA+oK9HwEjEDaBa4j5aTUIewHF6KrVhcBDXwNLEzhc3zw==
x-ms-office365-filtering-correlation-id: b7bf85fa-0da0-4c4d-cdc8-08d67acee849
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5086;
x-ms-traffictypediagnostic: VI1PR04MB5086:
x-microsoft-antispam-prvs: <VI1PR04MB5086D1626F6441FD8C0ED8ED99810@VI1PR04MB5086.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(39860400002)(346002)(189003)(199004)(39060400002)(7736002)(305945005)(2501003)(110136005)(99286004)(66066001)(316002)(36756003)(50226002)(8936002)(25786009)(2906002)(486006)(4326008)(478600001)(14444005)(256004)(54906003)(86362001)(186003)(97736004)(2201001)(55236004)(102836004)(14454004)(26005)(3846002)(7416002)(6116002)(6506007)(386003)(52116002)(106356001)(76176011)(5660300001)(71200400001)(2616005)(78486014)(105586002)(71190400001)(68736007)(11346002)(446003)(6436002)(6486002)(81166006)(53936002)(6512007)(81156014)(8676002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5086;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CpQMfTEHGqnScIDnUqAUaAuiR/hM4G80J2yexNicOBh6yKEZ0MsxbOXLXQy6VSi0x2wRHIK/z/PLffHdCucFmlo2x71qHn7jqT7hzSVpS9ER30u6LYLHTnWd/KoM9Y09LjV+Gfm3P3nnObCV5upwcl+SRrz0GBQ/GH7CRn79DiPWeDVxXrrde43rBmBd0rj/eGmgx4oqjypqVTyZgDAXXyTY5JYuJXyUznjksAIrE9qoPitjp2aeZ2v7yE4LscNo/TyHWjdHIl7gU9GpVA0PWge9MP4vBso+6NHJoTEjniBCnEqwPOoiyfoiH7QZ0Qt59eHLZlew1oKqd9Jhkzf33kSCyf9wc1mJmpY1Zg8rzq2WgG6F055jnKAf4nqCtr0APGZK9zeisDrDCbrfpeObph6AwxAIFiKYk0ZVKf4Gnyk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bf85fa-0da0-4c4d-cdc8-08d67acee849
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 09:50:34.0380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5086
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

