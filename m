Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6244C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D022087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lB50OHLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D022087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeJKS2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:28:00 -0400
Received: from mail-db5eur01on0054.outbound.protection.outlook.com ([104.47.2.54]:50555
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727526AbeJKS17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kw+v/Y7Y9Mt711JjeLGRjrDd301DFP37N+cxtKVJYL4=;
 b=lB50OHLpB0Ac0N0gDGyLqOsDUPSjDCDaIhP26h/WKQo99f9GXE0tdrEFiurx8gONib0IVWOzxnlfmTvZMpt8y8l2wmm3qFYTEbYVOwL2WKjpFVq6GXZTYRlK9Lxa0x19EndIknDaKRvax2zFycu30GMVnG8TITa+rETKQ1oAwVQ=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1024.eurprd04.prod.outlook.com (10.161.109.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.27; Thu, 11 Oct 2018 11:00:44 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1207.024; Thu, 11 Oct 2018
 11:00:44 +0000
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
Subject: [PATCH v4 3/5] arm64: dts: lx2160a: add FlexSPI node property
Thread-Topic: [PATCH v4 3/5] arm64: dts: lx2160a: add FlexSPI node property
Thread-Index: AQHUYVGn2ipI8GyGGkKr5zFwXCG6bg==
Date:   Thu, 11 Oct 2018 11:00:44 +0000
Message-ID: <1539255519-1408-4-git-send-email-yogeshnarayan.gaur@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1024;6:gR2Jpeb2nsMeddnXqwNAZh0ldvmnAskLSdgKUApq+Ay55MVbdbOJcPJ7NV5FVdrE0e/BQ1jvplhWyIYJ5KPfKV2GQjqxMgZw6A2cHOUbmn3EfSnLJuXIzjIhjkmCTIULL3D6z0Ou2IjXrurgMoki85D7pVRZPJ9oXJmwLRQxAPu1cYmcP4L1y3P1mMmKak6bvewbU1zHP1d807ipXV8ZJGQhHU4Svk2XNi7+T7Q5RyB4VCZMl2aLdFUaVycstTIH3ldeMacIgNbMg0GbLocmclMNfagGF1fDuq0BSW6EuHna697TZJeZbzG6nG44yHQxD+2IiVcyP+AMKaRGY3g6JfPbNtHAjRx+qfcu4lzqSCVZDr8a68LBoUJJrzyDPV8B3LmGZvzuoyk0+FM44KRfQmTAuRb6pUn/KCWKXKvPSu//mbt9ZTjtasdg2kaoZrg/Msovq/LdGYI1nOSllr9QN8GUT0KTcSsrywM5YLzXo7A=;5:54mU22AyHk/qRb5wwc9wFRNEWFL34HrFQ1r+McJIFFftXKgW1YsWatnxKI/SLS9Zx6wQogp3S0Egw4gkewdDpQcGD0jjm/slEvCQl7+AMPxv53Z5OB2siMzOduX+wnNHZ77TTToghzzi+QN3kYqzdY9ZB+RSLHHMt2EmZmPArq4=;7:8MS6lJ1V8YSLIw4qVKEgP4hZNZ8exfMC/xgrpE2WQNiaRfAvWFPMcuuwPStPiV0wxAV+Nbl/XkQ8v/B6Tgrj0wbOzB8tFs5iuuimcDmbqNSwhjZ+xwFe6JHDQTjNAJ6Qr1+FML0MmmpjOgbyFZxC9dpL1YJT7gfCAM05ObmOH9OF7INdJhaTq1B9UJE0JYCjwEqCm1cMmLdZSmq42dZuXb6a9hiJog0fewLMzXm55aAUdBW1rvrvSRXTvQ2CrukX
x-ms-office365-filtering-correlation-id: e03a3e4f-4c17-4e48-9ff2-08d62f68ca30
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1024;
x-ms-traffictypediagnostic: VI1PR04MB1024:
x-microsoft-antispam-prvs: <VI1PR04MB102480867FCADCD47C68CAD599E10@VI1PR04MB1024.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991055);SRVR:VI1PR04MB1024;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1024;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(366004)(189003)(199004)(478600001)(39060400002)(4326008)(54906003)(66066001)(25786009)(8676002)(2201001)(53936002)(68736007)(486006)(476003)(7416002)(6512007)(446003)(7736002)(3846002)(6116002)(86362001)(11346002)(305945005)(8936002)(2616005)(81166006)(81156014)(256004)(14444005)(105586002)(106356001)(6436002)(186003)(71190400001)(71200400001)(110136005)(2906002)(55236004)(6506007)(386003)(5250100002)(99286004)(2501003)(97736004)(26005)(52116002)(6486002)(316002)(5660300001)(102836004)(36756003)(14454004)(2900100001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1024;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nRjOK/DBntRXTmbVXAvUjSB6Jd3jfi75vYpWTR2OSjMyuU8gHMijzw9+uiSuuYm6MuI98SKNqqfytYRruwuQw9YsOe2ZJK6PtLmXb8Wcjv6fdOhceroMkogsizt6ixW8mXnOZmMBmAVAS2MaR3yz/GNxoZK8YTyVib/XN836JdBO1ExRzDE2b8IrH9oTKprjAQmJwkOIbDlH15Z/uzbq7Qs+4N6ib7++qweiU/8MZ7+DGr7tkBgoC7KzCyVg/4gWgP4JjEoH/w1MY7mUlTKBlnZ2IZfMS7YyWtjBA+mV+UtoJ08s8Z4oVoqy8z3bNCf11ehklo5Zn+T2Mx0Tlz5NFgKfWRMpdd0OwZ7UY2aISn0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e03a3e4f-4c17-4e48-9ff2-08d62f68ca30
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 11:00:44.1042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1024
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
Changes for v4:
- Incorporated Rob review comments.
Changes for v3:
- None.
Changes for v2:
- - Incorporated Shawn review comments.

 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 22 +++++++++++++++++++=
+++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 12 ++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64=
/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 70fad20..901ca346 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -32,6 +32,28 @@
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
 	pca9547@77 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-lx2160a.dtsi
index e35e494..ba2a247 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -568,5 +568,17 @@
 			timeout-sec =3D <30>;
 		};
=20
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

