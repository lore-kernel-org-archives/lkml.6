Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E098C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F171F20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n2EYmKMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F171F20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeJWRTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:19:35 -0400
Received: from mail-eopbgr40076.outbound.protection.outlook.com ([40.107.4.76]:59456
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727658AbeJWRTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kw+v/Y7Y9Mt711JjeLGRjrDd301DFP37N+cxtKVJYL4=;
 b=n2EYmKMJu6rTTPvGjXdpDkDSYHueQyh8l93+7L7+UJjaVPRFGFXZF5FK1rp0HwZ9g7byrrxgaGaL0HCTO3NYFdzLZYs4oHoe/3iNxZUY2gEVqq9kX2Qw1pedlSO3q3pUVVfHfQvK+04BtZYgX+XDv6kcypUttanFnoZbkIYNkGA=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4367.eurprd04.prod.outlook.com (52.134.123.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 08:57:00 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Tue, 23 Oct 2018
 08:57:00 +0000
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
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH RESEND v4 3/5] arm64: dts: lx2160a: add FlexSPI node property
Thread-Topic: [PATCH RESEND v4 3/5] arm64: dts: lx2160a: add FlexSPI node
 property
Thread-Index: AQHUaq5cmuo4jqAi5UKkyT+b2mhQ7g==
Date:   Tue, 23 Oct 2018 08:57:00 +0000
Message-ID: <1540284888-32307-4-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1540284888-32307-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1540284888-32307-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR0601CA0008.apcprd06.prod.outlook.com (2603:1096:3::18)
 To VI1PR04MB1038.eurprd04.prod.outlook.com (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4367;6:N8xeHxk9GpXoA4jH1yt7+KuHbD8BY5YVnsOP7bW6hA8I079HpfAepwAqdF5q2FZS3stLkwt7+ZxAANsa3wzWGOjv5VSBN5u8yqOaZFIB2jCSa9NOjNNupwDrHNm2m2fNnDJLSu2wXIld/6OM1757qqcC54X8UgD+G9AnSJui241o44O6QfZqeebMKY6uMs68XO5Zs2M1ky+X4F7uWkTFnKPnydzYdsT/0+fkjkgKShtDeJy1xEBVP/s+j6bvAL5cZtuxpC0N/X6Sut/jfZY12juvFxp9Y2t3hjI8wNjr2LruQ3skIMZ6K46lQuFwwbrzFyL6d1ZsKNZbae9bdrFd2kt17W0F7Ab7mek9lAo+Q5Oozj9vlFi6FkxQfj8zQNJU7qs6F+l82u8owKmHBdMKiy7eKqjf/VkEv0aanPESOd2V/xSo87AlCql2ZROyKV3Lq3tnKmQAcJ9IRyTqwwcW2w==;5:upXknA0pPu6x7GlDoUSLrKGhnfs5MAhkXRUQul8GuOA7I2ZQ2r916Z57A8K0c3mBbmLOdDMs+gmMQRM1T/K6FKKMiVly77uIWms+1feDZBaK3ijv8zByLvRh/1JgKa3zW9SICKj7cCT87FWyENhZmq+Enc/OKiL7gYz7QFcRjmQ=;7:VJFcfEQ5yXJGJr5boCOiE2engOmHy+tXKHNrsihQl5yMQg2gXGizYPeZCRxGcHalvVF7E/OYn8jDk6fO+GZMvxodjuOdkcAr4GWF3iB/IPfD/exAxj7OjP6dclS5G97PmPZUXuXpfAg/9W1OWoCfvPAv23dLMpwl5/Djs3sY+MbroOCelXeSh+bHH0poPbtuy7yzsgorbDEolWtmA/A1HsczF7TIj++Sgsux8WDZ89vHT5imm79XQBG5Znvw8KlW
x-ms-office365-filtering-correlation-id: 1f265ec9-4b18-4afc-cae9-08d638c57e31
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4367;
x-ms-traffictypediagnostic: VI1PR04MB4367:
x-microsoft-antispam-prvs: <VI1PR04MB4367797C25D3BC43A736A15699F50@VI1PR04MB4367.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4367;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4367;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(39860400002)(136003)(199004)(189003)(2906002)(7736002)(52116002)(66066001)(71200400001)(71190400001)(76176011)(186003)(305945005)(3846002)(54906003)(6116002)(110136005)(2501003)(217873002)(14454004)(8936002)(68736007)(316002)(2616005)(7416002)(105586002)(476003)(11346002)(25786009)(53936002)(446003)(14444005)(6512007)(5250100002)(2900100001)(97736004)(486006)(39060400002)(102836004)(36756003)(81156014)(478600001)(55236004)(81166006)(6486002)(8676002)(106356001)(6506007)(386003)(5660300001)(2201001)(4326008)(26005)(99286004)(86362001)(6436002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4367;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jcGbctGwh9sjJzvyYOKZdIeVEFRto8SNGSw5hAtrUIJigJ19MBWpH4Hc2cBLrbV4SbESr25gbWzA4Or2whhdlNVIhz3fBrM/g1zqeUnsxkZ/ZTQy9cBtHVijwPdvBeh5NXCb8rI7sdYCrJ/WzDvG97WX6a6dYres8IfHT1NCgYCWGC8I09Xk3C1X2J7hy/TKPgOek+9CS02nVAasQB6Ed0LW2dts/6MtJccOyhTP9TrLj+hRqfHoKbBe7k+o9OK0WoIl1sf8bvNwmExOG4RZbvvQaB8TocMNKcEbSjPwRbsTvS+Zj2FMAMea30KIXZg4ZwnokbQMNxc+YzmlGiwKNwHloBIEmBFXrg5ldRKpJJ0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f265ec9-4b18-4afc-cae9-08d638c57e31
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 08:57:00.3294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4367
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

