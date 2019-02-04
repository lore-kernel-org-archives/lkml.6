Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA80C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20622081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="oAgHbpy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfBDKKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:10:19 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:33464 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbfBDKKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:10:10 -0500
X-IronPort-AV: E=Sophos;i="5.56,559,1539673200"; 
   d="scan'208";a="26269146"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Feb 2019 03:10:10 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 4 Feb 2019 03:10:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DM9YvZFRmm2TujWMa9nU320PQq2xBK8WAP6mbRCU62Q=;
 b=oAgHbpy9TM02n/W6bIcNXCjQO3rfT7Zv0AoGEXibeFTCqfCt39AnYYB1kfAr+SohH1f5o3Gp6ToudHHxxvvG6wa3DO9v2yRh0b5iqE4Y5LHg0cx6biJ8RerxSHwOedQ8/S4eEIcy2Emcsy/LFXvPf5cHQfFT7ztRFIZmznWy/xU=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1508.namprd11.prod.outlook.com (10.172.21.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 10:10:08 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 10:10:08 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 12/13] dt-bindings: spi: atmel-quadspi: QuadSPI driver for
 Microchip SAM9X60
Thread-Topic: [PATCH v4 12/13] dt-bindings: spi: atmel-quadspi: QuadSPI driver
 for Microchip SAM9X60
Thread-Index: AQHUvHHORQ3gmJMls022AUAaShGcrw==
Date:   Mon, 4 Feb 2019 10:10:08 +0000
Message-ID: <20190204100910.26701-13-tudor.ambarus@microchip.com>
References: <20190204100910.26701-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190204100910.26701-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0270.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::43) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1508;6:F6H9QMlkGjUeufPohpPHIofAK/Q+1rILtJVyR6CABwmTA5dwHjPsOEqLG5kJf68ddhsD40+31ygumT8/c2TdWbuHhd70Tj3QNu6I/aimw2Rd3lUIH/YrfNVh4JwmwC9PNInar2uY9xVUz5EfczY2f6S/oSrvxMICE5YTu9RxbGwuLAF0yJvqxQN51PhOvTV3+YLGYBA4xv9QI//3WDmRvmHlWzFEsDbxZuNnABDC0ar8ljDHsKKG616aMru3kjQ95g0/d7VQHI/HNXBcgH6WoT1SFLQgcXZhRqu3ZPeriXbSzz76IRGEGcH1uZ0A2dvwh94Q7Lx6qHUc0ebQr81yiZvAonDzWLKejEeVmCokw/ae5hRh7QQZ58IcR1ZSmnnx3cKYucfUY45EplYpT37MZznSY7sxaQIUv2CM9vxzLE9QfgLDigvvm3UoxxHW9xg+Ehqsfp5YspcxxbueRnPdTA==;5:CONmofZgrPnM5MMq8vlShcM9MKpZBgCt50cSCc98cVIAjfGhFsKsjnDJo9UEIbFdSsEooC0pkneDopM4+mdOO7/xaIe1johz3jvvqgFWxI9PpkNaNToQNJYTp32Iq6ryGNvvxOGvTGm9GILRkwqLW7ed75E97fZyTU+0qopnfSJs0LdiIvTDjBgyQXO3JzlL/sqw76uULuef1buYlMwgIQ==;7:bkENbz5KA/kWVfvMTqrOuNcQPDJrKq0toK6NN0b5tSylCfLetlKoVqvhRpkl687eyYZWP5sSx1hRr3Gz8QNiM5ymC76Y/Kk+1haemIQ9xWWjIFrYqZ7Ye7niuMoYB1JzBCPfEgF5kuOFj0+elhV91g==
x-ms-office365-filtering-correlation-id: 6448876f-88b0-47a3-4b78-08d68a88f0a1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1508;
x-ms-traffictypediagnostic: BN6PR11MB1508:
x-microsoft-antispam-prvs: <BN6PR11MB150881B775BA2AFBE17911C4F06D0@BN6PR11MB1508.namprd11.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(6486002)(11346002)(446003)(2616005)(486006)(106356001)(99286004)(6436002)(4326008)(105586002)(478600001)(476003)(76176011)(186003)(53936002)(305945005)(3846002)(6116002)(7736002)(81156014)(102836004)(26005)(81166006)(6512007)(107886003)(8676002)(25786009)(68736007)(39060400002)(52116002)(50226002)(110136005)(8936002)(2906002)(386003)(54906003)(6506007)(86362001)(1076003)(36756003)(71190400001)(71200400001)(316002)(97736004)(7416002)(14454004)(256004)(2501003)(14444005)(72206003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1508;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VSKawq9VLWQHfpDKbDDL8UCxz0VH9bvmbsvzBbjo76BiXEgcnO4+S6Bgx8TquJO41zcXbhzaVnZvYS2/7wBZ1BIne8YKbESiVcQmBBcIpI7TetR8MNCD2nKpknQyNiGYrMJ77nq4Bl1pSJn7Jb3vr6OFgb/Iv9LZHi8JszCi6WvxH4eprytqK8RsxYtskN2cQF5HCEH0dmYLcptEE4vl+orB6AAHeLsAn0+UbAGJ9Ta6f20B1KNlA597oiPPEWVJuPSiB+3sHbj+nqwbEsSGOeT9/J9Y/tp/lip6oWmw4vvFiQDK4X+/A64jEOz4bMoDibonWL0IIA4PbKmqKB5w5MUPWveYx52MgMGbxpFfhoiruJqN3kVFICruSUk3XfscBID16sERCKjswzn0AFy2StQdx5MM29F+0YcRDwEmjBY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6448876f-88b0-47a3-4b78-08d68a88f0a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 10:10:05.0149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1508
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
access, the other for the qspi core and phy. Both are mandatory.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v4: collect R-b
v3: "pclk" was made mandatory in previous patch. Reword clock
descriptions.
v2:
- make "pclk" mandatory even for sama5d2. Unnamed clk will be
supported in the driver.
- drop unneeded example

 Documentation/devicetree/bindings/spi/atmel-quadspi.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Docu=
mentation/devicetree/bindings/spi/atmel-quadspi.txt
index 50bd257e6826..7c40ea694352 100644
--- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
+++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
@@ -1,15 +1,19 @@
 * Atmel Quad Serial Peripheral Interface (QSPI)
=20
 Required properties:
-- compatible:     Should be "atmel,sama5d2-qspi".
+- compatible:     Should be one of the following:
+		  - "atmel,sama5d2-qspi"
+		  - "microchip,sam9x60-qspi"
 - reg:            Should contain the locations and lengths of the base reg=
isters
                   and the mapped memory.
 - reg-names:      Should contain the resource reg names:
                   - qspi_base: configuration register address space
                   - qspi_mmap: memory mapped address space
 - interrupts:     Should contain the interrupt for the device.
-- clocks:         The phandle of the clock needed by the QSPI controller.
-- clock-names:    Should contain "pclk" for the peripheral clock.
+- clocks:         Should reference the peripheral clock and the QSPI syste=
m
+                  clock if available.
+- clock-names:    Should contain "pclk" for the peripheral clock and "qspi=
ck"
+                  for the system clock when available.
 - #address-cells: Should be <1>.
 - #size-cells:    Should be <0>.
=20
--=20
2.9.5

