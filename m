Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330DEC282DC
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEED821479
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="aGKsTngw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfBBEHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 23:07:52 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:25475 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbfBBEHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 23:07:49 -0500
X-IronPort-AV: E=Sophos;i="5.56,550,1539673200"; 
   d="scan'208";a="26062104"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Feb 2019 21:07:48 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 1 Feb 2019 21:07:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9k/sBMT6uGD+/G5HsSqckaBWKQqACtT+I1jNsAx2R0k=;
 b=aGKsTngwUWE2uSlD2y79oa1gekV1kuThzpFpsUud/fEJnflgCJVhw2sa0OuQF+YF2CySvetCa46pE1KoZ+vEarfpnUxT7cBYBgn1NeBp9uylYREF85Z6ddPLfBdd2Y90uG4RwU5XE65NU5ULOb1dchno/Hgw/LCEe9NY90eTmng=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1812.namprd11.prod.outlook.com (10.175.98.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 04:07:44 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 04:07:44 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 12/13] dt-bindings: spi: atmel-quadspi: QuadSPI driver for
 Microchip SAM9X60
Thread-Topic: [PATCH v3 12/13] dt-bindings: spi: atmel-quadspi: QuadSPI driver
 for Microchip SAM9X60
Thread-Index: AQHUuqzZe8aclldzlkqIHoRq0DqenQ==
Date:   Sat, 2 Feb 2019 04:07:44 +0000
Message-ID: <20190202040653.1217-13-tudor.ambarus@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190202040653.1217-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0062.eurprd09.prod.outlook.com
 (2603:10a6:802:28::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [188.25.201.137]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1812;6:xUVxJKnNKnBonlGZYbJn9Bq6bJxVe+F3YKtzK7fDrbjgpnoWGTP61cHHex4hHMUBgCDesvQ3fc4b/x/40DxKZ7WZ318xI79o4l0TY2xku+5WbPv4RFiq8bOp/8oPfgF/y5bggjrNNP/OX+VNLBd5YedExesXM0BSzziPkX7YiYfF6sbVWgoZ44YqIVyRiuovvAFVNyeb2po/DnNMdPlfB/Bf3xjf+OJs+HWf2tnKm6yfvqfq9cGKLQynt+73+eXOjmhUOluFZqa8cgkPpS1Au1Ra3fLpP5gU04z6cJQD6ul8DBdOjclW/NaZJFY02PyztZWhHXJ/V+zvFzLqnoLtfeAvD0GcrFRLWap03D9S7p4W6hNpB7KsLYzvI/3HWIUl8zYjtF85gcdvTyu34qk4cSF8tpod1laZ4tHs9quhoLCveRqFgAAYWMBbv3mb2M6utttj4NbFfq38wmBZeqR72w==;5:+PTQtiULZU2pGC8HlAOdVrw93ybYfIFHqkLuKTDdUEXoz5fE1Ey/B0br5bqGYp3iX6Sab3I19Qw7491R9w695ZmDERDIfvJ0fw+HzN11SN4J/avX1y6KfcWZ0fwMBjjzpUN+SEfantnuVPg6Fv1W8ch9SO55CaOw4zMPReRYQTpzWo5Q/kCjHkmK1iI9mFOOD+HUCctM6orRuR7cnjURtQ==;7:WlHJ92m89I2dhQvIHyE0sM0pshPoahQEnfpqt5D33JfbwNv7SYqXS5yk/a/fUs9aOlpGsSZzIFSTky0y9TqLjisecVkuoOwmWV5XZsAS+0jr7mSOzh2a3jS6Fa2gxZDU8BYzKhd/PmEPv+tMA7gM5Q==
x-ms-office365-filtering-correlation-id: a2487c71-2d54-4f5c-672f-08d688c3fb91
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1812;
x-ms-traffictypediagnostic: BN6PR11MB1812:
x-microsoft-antispam-prvs: <BN6PR11MB181257BA611DFC5F6231AD5FF0930@BN6PR11MB1812.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(346002)(366004)(189003)(199004)(86362001)(72206003)(81156014)(8936002)(39060400002)(50226002)(105586002)(14454004)(107886003)(1076003)(36756003)(71200400001)(81166006)(71190400001)(66066001)(4326008)(478600001)(8676002)(25786009)(76176011)(2501003)(52116002)(99286004)(14444005)(256004)(110136005)(54906003)(68736007)(186003)(26005)(3846002)(6116002)(7416002)(386003)(6506007)(2616005)(11346002)(446003)(102836004)(6436002)(6486002)(476003)(7736002)(486006)(6512007)(97736004)(316002)(2906002)(305945005)(106356001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1812;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e8OdQafwfE2nhl8DlNyXLV2Mm+JnESp+TemffGhhL+xbJkH4GglVEE9jurSlQq+yyPwY7e94ZtRjAteTtlB+pVuR0fCxNBarcc5qoeEEt+CNQQEyeMVGx07PW5wPow7b2RmdRs61Z/B6YkuZzSYBXCY3eHML3yfq2jSfL+D7pVd82/HstZbip2hofL7na2pRTyOR9wsgo36Ynfw2QWbKlaogLQSNbOmoaLYtrYETZXFFnQDOQx8+BPte/G3cmjPiQ5reuWlVaOKJSAzJmDaiMDSHB3i7h7b+6SM/xN7zUAVCkkoJgVqGguWCeB3CjwXIzMEnSxFvQcmUc/Z8E6Ai2MjCMcBNpVjxEZZMqxcJ7r1+dLolBHfJU4USfXnsZIEpLdH/Gsn7Oe7ExHZDlSemeBcEdZgfCr7/V1FiENXAuMk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a2487c71-2d54-4f5c-672f-08d688c3fb91
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 04:07:41.9667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1812
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
access, the other for the qspi core and phy. Both are mandatory.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
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
index 1de54e87f5d6..fc7e83adab36 100644
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

