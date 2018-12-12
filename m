Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D87EC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0715220849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="y1uOmyw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0715220849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbeLLQbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:31:22 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:51682 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeLLQbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:31:22 -0500
X-IronPort-AV: E=Sophos;i="5.56,344,1539673200"; 
   d="scan'208";a="24131289"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Dec 2018 09:31:15 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 12 Dec 2018 09:31:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jO3d8N8M3PxcEP3EY/6uc+gOhNYqDJcrsGoop/mv4yg=;
 b=y1uOmyw/juVDPZNcUgB7VEh7aJLhR5yVJv0+z+pOElJ4+Dt0C2pXn56c7hNa5X3iQswrcHS3civ8xfaTrSjSx/IFFvgqIEDajD9wwCpB0bf+WPUovXSeolgNiM/u/Xn6U0la34PfckRm9gDBdtmjY2ey1vKIHkYjHCP+dpWgo+U=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1683.namprd11.prod.outlook.com (10.173.27.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 12 Dec 2018 16:31:12 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::8155:7276:d66a:e239]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::8155:7276:d66a:e239%8]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 16:31:12 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Claudiu.Beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <boris.brezillon@bootlin.com>, <linux-mtd@lists.infradead.org>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH 2/2] ARM: dts: at91: at91-sama5d27_som1_ek: enable qspi1
 memory
Thread-Topic: [PATCH 2/2] ARM: dts: at91: at91-sama5d27_som1_ek: enable qspi1
 memory
Thread-Index: AQHUkjgXT1ZW5pNpVUeT+c+CLZAqWA==
Date:   Wed, 12 Dec 2018 16:31:11 +0000
Message-ID: <20181212163057.22183-2-tudor.ambarus@microchip.com>
References: <20181212163057.22183-1-tudor.ambarus@microchip.com>
In-Reply-To: <20181212163057.22183-1-tudor.ambarus@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1683;6:BBE00oNHuXROFNi88yFv9WBp5p13RZW53GNVYOD3SyYOe8weg7WgTV1YfKd1ucbja4QFFbSOFO1/XKgKls6bBFRtCHGoG0YZaLuLLvig8sQZICN7UYaEOG6AIfsoZyKgyLCRyZJFtNmNP2CmxB8Ro0bhGYWBiSdxTmc5HICW/m7JTKyRLMPffNNmdQuTWhRhPVERT2NCxw8x7bA2WoRVpGccV4lGItZjngH/41YDZVtbyM81nI0Q1mjtkviVwBuWJQI8ju4kDjYdyBcbCONhZk7QebjY8xva22zZLuAAdKgyzV6xn/W0iqd7OH0WTwVy5+4465JZsVYs7jl7G5cYa0WqqEJtuKZg2rIZwV3SVngk5Kw8OP/7vmb7wIUdBcmLZtOkV70C4v3ADGxp7BpAGHWnKZdKkI2bBHiOHsfCnEgVN6+rzhTCtLPYq4ly/FHXw6G6qRVWpvDnlqC8WJ4oSw==;5:w+NizVMYsUx/ZKiCv9O/aY6HpsHlP7W3yda1WMfe+bheE3tpMPEYBMBfwPqk/Z09tSYXgQTaLjfSMzd+TB+mjfxotJX9zZqxMVP+aGKbODMH9QSjGF3A7cJYCxTdTjsGxcgJ6Z+I51iLGftlfJ7GO5fU8Ru8eLxCzGxOSfWZqIc=;7:n3Yprs8w4FK//1fqsxH6Rm/B/WfBBIT5pAdF90YHGsTOz8KE/gLzqw5vS6XAP7om8S+kOxASe08StPf0PA0dWD21OrD6lVeMJZqZT8fjwprwdZRCm5abuT+XA8HULzzqM8TRb+5tFIbQl3iucbFzJQ==
x-ms-office365-filtering-correlation-id: b0fdf0db-d252-4fcb-87b4-08d6604f3a2e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1683;
x-ms-traffictypediagnostic: BN6PR11MB1683:
x-microsoft-antispam-prvs: <BN6PR11MB168393C137414FE998CF06D9F0A70@BN6PR11MB1683.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231472)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1683;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1683;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39860400002)(136003)(189003)(199004)(8936002)(81156014)(81166006)(8676002)(7416002)(105586002)(68736007)(106356001)(110136005)(99286004)(54906003)(5660300001)(316002)(476003)(2616005)(486006)(26005)(97736004)(446003)(11346002)(102836004)(186003)(2501003)(52116002)(6486002)(76176011)(6436002)(6506007)(386003)(1076002)(6636002)(256004)(6116002)(36756003)(305945005)(2906002)(3846002)(72206003)(25786009)(478600001)(14454004)(6512007)(66066001)(71200400001)(86362001)(4326008)(71190400001)(53936002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1683;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: n7oYKKXA5fnamxHKRWzW4gqq0a4p+7BKPxpCsDtdFfYgXnC37UDHQj8/egpR2Ctc7ZFa34PLrRgLf/2ky+tpmPv7982lJVCdOIbY4k6WRYr7w5DfPfVGe1nYRcXW5BVkiWzBmKrK42BnGJmDw0EcVIsFaUtCx7UvXDgkQBSF15b4eh6+HKiirGeiNM0Btoi79xieI9+YfHGWYP507egcknK6RyDEkQLLlGk45vV1UmZ9cPh+tLbcpyt7I8CZFWS1RFXQBtXGUa6V3ppHq8GbMYiGtiP7nxZmYosGcfKFEG/ZYudpr645L4g1sB7O1UOp
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fdf0db-d252-4fcb-87b4-08d6604f3a2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 16:31:12.2283
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

Enable qspi1.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dt=
s/at91-sama5d27_som1_ek.dts
index 363a43d77424..73d16d98bf9c 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -109,6 +109,10 @@
 				status =3D "okay";
 			};
=20
+			qspi1: spi@f0024000 {
+				status =3D "okay";
+			};
+
 			spi0: spi@f8000000 {
 				pinctrl-names =3D "default";
 				pinctrl-0 =3D <&pinctrl_spi0_default>;
--=20
2.9.4

