Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59967C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140222082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="rmksHg1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140222082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbeLJRPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:15:39 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:32847 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeLJRPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:15:36 -0500
X-IronPort-AV: E=Sophos;i="5.56,339,1539673200"; 
   d="scan'208";a="25064723"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Dec 2018 10:15:34 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 10 Dec 2018 10:15:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XNrmeOL+ZjYS/P/wlQ3EdM9OocCB16TWniZLAaI+9M=;
 b=rmksHg1NSLObVTGb056pbUmOwgwBWI5P+VG77VSEGgT4GZZkHF6eC495/rBDdKlGDaDJ+tRUuyU42Ye6WqbkGbBdgFRfrK5k1gFybHISxoDAO3DBqVNMRywYZU10Rx/Zrw1f3D9MTeqwQhcGUjayoPBoOhQIq69yhniz7olO03E=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1282.namprd11.prod.outlook.com (10.173.32.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Mon, 10 Dec 2018 17:15:29 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 17:15:29 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Cyrille.Pitchen@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <boris.brezillon@bootlin.com>, <linux-mtd@lists.infradead.org>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR memory
 nodes
Thread-Topic: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR
 memory nodes
Thread-Index: AQHUkKvzXXGQaMBmgEiVjL0m4mUE4w==
Date:   Mon, 10 Dec 2018 17:15:29 +0000
Message-ID: <20181210171511.21002-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::17) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1282;6:UGrae/y90LV0en2YRmBfZBSm+e6Hgj96pB9wIerFuvPWk5MNFWcK/nZTLhIjlYbvOBEGu1/vPe4BSPwsXU1SvX6eMtJ5tVOyvcebUucH5jmc9dPmbKVYbQjNbGc8u7Xv5pchuL/Rx9/ufw1K+g3RSuE4dTTWhmUJQ9P67jOQsMQbXVHp+synzLzXS0Yat9TsnuOsTJhMwsZC+haZdyvSdtCbJvUYlQVxIwYaLfsSL9aafKnEvHslvIuoMZG/6FUc8Q+K5PtU7Sort8tn2M+DxKC+didAiYrbEbNj+iDbxW1XHGc6V6AdHyB61iV6emejwg9uvt4UWl0ntPMSteVpkUYySaR13hz49P+c74kx0ONjfJuActkQMFgAXtEQaHB3WPa5dLo/0WhciSUxtulCZMqROOuY6nnAzQUaU2wvvymfspJ4wLu5r+NAbmyqgDZ4jdEbp4uoIo/47EFwL1TKXA==;5:W9KyeZGXMYEz+Abo3iwvj7Nksh/Bb/RED/ynuald6LKDTjlErs75DoSapRk73xil32EKeCZiv5Mfuq6eIOOQYmf9eCXBQAxCPEyT2c5G0H6fuQ+ZOOD/RgLBrDvaS5w7WA8QyZQkH4i7F2EErvEessJAEhDbTYXGDCpowLKn+4g=;7:W5HT1ARSXFspC8IwT5z8dkTeIzR/0FNikReDSYn/CpQZ0u5I0NrctEHIjGW7hatojpNWGq9IY7FLmKjC31uYMWSfphTG/k7KZodRIBA2VtYxxhZFUgvOkCAM+oJDcZ/iYia4ZnOys2tRn0Bz5qGTsQ==
x-ms-office365-filtering-correlation-id: ec007223-fa55-47f3-3b87-08d65ec31555
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1282;
x-ms-traffictypediagnostic: BN6PR11MB1282:
x-microsoft-antispam-prvs: <BN6PR11MB12824574E1795CE19F82D3EBF0A50@BN6PR11MB1282.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231472)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1282;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1282;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(136003)(346002)(39860400002)(199004)(189003)(106356001)(25786009)(53936002)(66066001)(71200400001)(81166006)(6436002)(110136005)(6486002)(99286004)(52116002)(1076002)(256004)(14444005)(54906003)(8676002)(8936002)(81156014)(6636002)(316002)(26005)(68736007)(7416002)(305945005)(6506007)(386003)(7736002)(2906002)(6116002)(86362001)(4326008)(5660300001)(3846002)(71190400001)(6512007)(186003)(102836004)(107886003)(2616005)(2501003)(97736004)(14454004)(217873002)(36756003)(72206003)(478600001)(105586002)(486006)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1282;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lyuWmiDuJ/aDtrOacE5OudXmy1a9cKez97GOo6aXJINRvA8+9U4+BtwyyxPXsWIy+LQELZhllI58HIgPfabsx+4+Uf/pDx5tgzS//P3Xmor9XmAKaQHRb2fanIBpCqiHfIOU2+WH4rSXcfhqGMZ6xZVgQxF3kAYFQ+39GyvgrIPIb1gQyOsTHyYaJLRNbHkTGHsMgGOJR6B72HMDT8S9q0l0aIUshjfell3lJmu/cKLvOWqLp6ts97MBVrb8mRrrsCFAJ7B96oyVUil0jPe3BuTGgWMULqeay3xmSDc+sJ6US/tehKpX+kLM0tVooENu
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ec007223-fa55-47f3-3b87-08d65ec31555
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 17:15:29.5039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1282
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cyrille Pitchen <cyrille.pitchen@microchip.com>

This patch configures the QSPI0 controller pin muxing and declares
a jedec,spi-nor memory.

sama5d2 Xplained RevB and RevC use the Macronix MX25L25673G flash
memory which advertises a maximum frequency of 80MHz for Quad IO
Fast Read. Set the spi-max-frequency to 80MHz knowing that actually
the QSPI drver will set the SPI bus clock to 166MHz / 3 =3D 55.3MHz.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
[tudor.ambarus@microchip.com:
- drop partitions,
- add spi-rx/tx-bus-width
- change spi-max-frequency to match the 80MHz limit advertised by
  MX25L25673G for Quad IO Fast Read,
- reword commit message and subject.]
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 31 +++++++++++++++++++++++++=
++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dt=
s/at91-sama5d2_xplained.dts
index 518e2b095ccf..171bc82cfbbf 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -108,6 +108,21 @@
 		};
=20
 		apb {
+			qspi0: spi@f0020000 {
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&pinctrl_qspi0_default>;
+				/* status =3D "okay"; */ /* conflict with sdmmc1 */
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
 			spi0: spi@f8000000 {
 				pinctrl-names =3D "default";
 				pinctrl-0 =3D <&pinctrl_spi0_default>;
@@ -485,6 +500,22 @@
 					bias-disable;
 				};
=20
+				pinctrl_qspi0_default: qspi0_default {
+					sck_cs {
+						pinmux =3D <PIN_PA22__QSPI0_SCK>,
+							 <PIN_PA23__QSPI0_CS>;
+						bias-disable;
+					};
+
+					data {
+						pinmux =3D <PIN_PA24__QSPI0_IO0>,
+							 <PIN_PA25__QSPI0_IO1>,
+							 <PIN_PA26__QSPI0_IO2>,
+							 <PIN_PA27__QSPI0_IO3>;
+						bias-pull-up;
+					};
+				};
+
 				pinctrl_sdmmc0_default: sdmmc0_default {
 					cmd_data {
 						pinmux =3D <PIN_PA1__SDMMC0_CMD>,
--=20
2.9.4

