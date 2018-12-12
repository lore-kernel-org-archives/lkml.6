Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34844C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E1520849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="yfuvupym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E1520849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbeLLQbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:31:15 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:23997 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeLLQbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:31:14 -0500
X-IronPort-AV: E=Sophos;i="5.56,344,1539673200"; 
   d="scan'208";a="22187189"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Dec 2018 09:31:13 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 12 Dec 2018 09:31:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGWWOuTRarlTqDUeZFadjUS0edqT9Ih2KhDYb4sqUnk=;
 b=yfuvupymkFuj3EvN74SBNvNGsRqO/fmNE95yu85qT2z2fiH3D9Y1COC8oTV3hKrH4EnfK29INpbka8be10IvIrvyRfMgn1GJ8ZRG58Rx7wgTYvkdV4VA2Px3fTSmLyY4kNTzBPY1KJhIJwI9GsRBW2T4Al2TLj/ffGxmNFhf3Rg=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1683.namprd11.prod.outlook.com (10.173.27.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 12 Dec 2018 16:31:09 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::8155:7276:d66a:e239]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::8155:7276:d66a:e239%8]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 16:31:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Claudiu.Beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <boris.brezillon@bootlin.com>, <linux-mtd@lists.infradead.org>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 1/2] ARM: dts: at91: at91-sama5d27_som1: add QSPI1 + SPI NOR
 memory nodes
Thread-Topic: [PATCH 1/2] ARM: dts: at91: at91-sama5d27_som1: add QSPI1 + SPI
 NOR memory nodes
Thread-Index: AQHUkjgW0EZIpR8U80WmEyyY7b75UQ==
Date:   Wed, 12 Dec 2018 16:31:08 +0000
Message-ID: <20181212163057.22183-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR10CA0088.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::17) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1683;6:S7EOnoKCp5L8+vvPLi+/9ndDu+s2PPpW764BtNcdxXH0k/6M3v2AT/kUMjgqrbEnHIJ4yjm99JLrtRdV0oXc83DC0onx2i2RFmgCKg8+Q6H3NS/JS6KqtJ3edoFLfm9EpNgtQHqIcQ3P3e6wEga19FmGLccsXl12DqG6Sd/LK83Uclp5JixAkp32jyIFO3A61bGDCQZCRljqOTn1o9for4YEF6dGIstpYPGaUuTmPdL7rm0e0unMPYH+I6cktW/KnVZftdmscrW9FXt1qK3PmoOl8Ym4kbmD8DUfvBSgRQRV3YefN7d7C7nSrHrGoczMRc8AjCpqoD2tJMr9dUkXA7mbMQ0dn/TP16ssQ3FL3j2wzkusgsNn/5vBUz2PL5x6QgHuu2yDhjhp4CkfAUJtD0OdJNFQ8b6Dlj1be0zPuGUNJGX+oeTLb2QRfTpvm2MBtYLKH19Wwcpz0EzzeSGzEw==;5:woYEUbPWJYF6A7mkMnpdJhGV6kcLSlmUD7dCA5HDEQIOQAhNg4X3BW56KefPoC+mrmZnq1ZGQwRFAFPBd4xRUhzXMhclSpZqi+rNNqbgqZMK0SLZ4y8JQElcDgsEOZhC7xX2Dx8egB4Rd5G39Ny3xJrIjRYbnbPqBOOm52GZ8JE=;7:WC0KwXyxlCsbkYhnBWuhauY/IpggrdCqDzUtZMZwN/cBcsJd0y1SrvmKb65HvgETBBNQzo9+Aev+2ANgSfHpayBwGVyzY5pqfhbeE+TK1wMnl7BC3WMmFspM+tkiPzE17TQsCyRHQXjCDh7i5LdHAQ==
x-ms-office365-filtering-correlation-id: 634861d5-857b-4952-4e9c-08d6604f384f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1683;
x-ms-traffictypediagnostic: BN6PR11MB1683:
x-microsoft-antispam-prvs: <BN6PR11MB16830EA16E3287CC28DEC21EF0A70@BN6PR11MB1683.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231472)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1683;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1683;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39860400002)(136003)(189003)(199004)(8936002)(81156014)(81166006)(8676002)(7416002)(105586002)(68736007)(106356001)(110136005)(99286004)(54906003)(5660300001)(316002)(476003)(2616005)(486006)(26005)(97736004)(102836004)(186003)(2501003)(52116002)(6486002)(6436002)(6506007)(386003)(1076002)(6636002)(256004)(6116002)(36756003)(217873002)(305945005)(2906002)(3846002)(72206003)(25786009)(478600001)(14454004)(6512007)(66066001)(107886003)(71200400001)(86362001)(4326008)(71190400001)(53936002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1683;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Nm8F2YTfRmVshNNZY2aqfBysWPIKnDYPVWot2PRukQ5PoTNhkHaXUJgleNuEWppB1VqO6pwdd1S9ggv5fr61y9r1BfjRKpWO98RO9UiHuHNfjgEUynYgUmCf5bhdXvw0uDZUM/YF9T0za7D844ssnjZmdhWVoIyYQz4SQniE/CU14CUZGOemFgfA08QSPtxds42b/X9DXR8MpmpvGZ8/RVk50Qv5wO2Yw58rJkQl7jph0Pe2EFiqVI3a7pw7CrzYnuOfhLMpSf6titQ4fcu7NIAqOKJ/hXrsA4Nmqhh9ZJttwBJzwPTnMRWF2CAZIHTU
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 634861d5-857b-4952-4e9c-08d6604f384f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 16:31:09.0408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1683
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Configure the QSPI1 controller pin muxing and declare the
jedec,spi-nor memory (SST26VF064).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
[tudor.ambarus@microchip.com: add spi-rx/tx-bus-width, drop partitions,
reword commit.]
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi | 30 +++++++++++++++++++++++++++=
+++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi b/arch/arm/boot/dts/=
at91-sama5d27_som1.dtsi
index cf0087b4c9e1..33a159c0163f 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
@@ -62,6 +62,20 @@
=20
 	ahb {
 		apb {
+			qspi1: spi@f0024000 {
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&pinctrl_qspi1_default>;
+
+				flash@0 {
+					compatible =3D "jedec,spi-nor";
+					reg =3D <0>;
+					spi-max-frequency =3D <80000000>;
+					spi-tx-bus-width =3D <4>;
+					spi-rx-bus-width =3D <4>;
+					m25p,fast-read;
+				};
+			};
+
 			macb0: ethernet@f8008000 {
 				pinctrl-names =3D "default";
 				pinctrl-0 =3D <&pinctrl_macb0_default>;
@@ -78,6 +92,22 @@
=20
 			pinctrl@fc038000 {
=20
+				pinctrl_qspi1_default: qspi1_default {
+					sck_cs {
+						pinmux =3D <PIN_PB5__QSPI1_SCK>,
+							 <PIN_PB6__QSPI1_CS>;
+						bias-disable;
+					};
+
+					data {
+						pinmux =3D <PIN_PB7__QSPI1_IO0>,
+							 <PIN_PB8__QSPI1_IO1>,
+							 <PIN_PB9__QSPI1_IO2>,
+							 <PIN_PB10__QSPI1_IO3>;
+						bias-pull-up;
+					};
+				};
+
 				pinctrl_macb0_default: macb0_default {
 					pinmux =3D <PIN_PD9__GTXCK>,
 						 <PIN_PD10__GTXEN>,
--=20
2.9.4

