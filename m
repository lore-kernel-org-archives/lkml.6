Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2584DC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81BC2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Ff6jWJyu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388352AbfAaQQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:16:02 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:10157 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388261AbfAaQQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:16:00 -0500
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="24072857"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 31 Jan 2019 09:15:49 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:15:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYISt+mUq8a2y/52ynnDii37D8+VlIQlpqZskupf4Es=;
 b=Ff6jWJyuRg4VjWUPX7arYnKPGY4P8H7H1PrWpIqR90BvFKqlssNSZ2tFdP205p/lUQgzR2k8X4OVaNCu82Cn/cE8uEX79thMF3F5YX2Gof5Md0iVTUKMgHGLytmkgaYy/qnON02zt1HKC1Zf9ibte60FivonNoZC9jL1okEIOqQ=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1315.namprd11.prod.outlook.com (10.173.32.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Thu, 31 Jan 2019 16:15:46 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 16:15:46 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 08/10] dt-bindings: spi: atmel-quadspi: update example to
 new clock binding
Thread-Topic: [PATCH v2 08/10] dt-bindings: spi: atmel-quadspi: update example
 to new clock binding
Thread-Index: AQHUuYA4pheU0uoMGEKsRDfKD/gBUQ==
Date:   Thu, 31 Jan 2019 16:15:46 +0000
Message-ID: <20190131161515.21605-9-tudor.ambarus@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190131161515.21605-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR02CA0046.eurprd02.prod.outlook.com
 (2603:10a6:802:14::17) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1315;6:qKtka8aPh4HvszfxUIimPbgusA2/CTM5tlN2ULoLXFDgeWKS2ZT9hhTJe2K/7wsRwe4Be8gqjcQe/YpLOyILxlj7x5+iOeFlAav5mndq2tbN/pU6Xc25ig5/cnxW76LbbMvIUvBn70zOtteo9piX7foCpPD+0K4xRFbMD2JOGmhfRUaTmRf8WeRe+a/Jk7B4LNkYvuh7uAh7ouM2TCHgQJ482ViR2KbFvmO+IogfJ0n0mEc6N0tVRCAfwDRwyiEVFbMuKFQvPaNGU43KpTtqNQYMXtuo951BvAyq5BDE7d4J8oDyPpXOvH2kc8akDWQmKsm+QbwVmOD3P0o7ZDSxOrnFfIdzYfjhRMxhtVAxICRPLfTUfFC1X3WMDhso4bEZGRGWOO7Hu4kXGw6oM5o8oHfyDcLaNu2gGQPdpte4dalf6pcwcIUMrbrdoRzGgWoKxMoB4hQoXPWo0hTNiMf5Jg==;5:bhv9DqCzBZvTEDiIn8weHNNybYhkNWnFNNOwGvcLqeKwNsFwdQB5LHMasYp5nCHt9Frz1xzfwkhc/PEjnmLuyDxU5xkqo6j2QESIPFkQeutZrsdLNLiIEgBpZgWzHsDjMzRC5Hz4myb6OD0BfLXzAVVqqabf/a+455sOcMl7Sh1PoLCbZeFd1mp+cdvKF9/ikwiaPf3/eJHXkMAoOdS/Hg==;7:+DOcmcSfssXr6YVJo7dSe5Z4g6H+kd73DqB/OtNqj0aLkCT/wRazsX6Ku22+R18oH4nw6yJ5q7l2UHPNXpCXq2KjB8FI4vyR68n/8cQmQ1QpNJzsqKyAR+rG8myRBJmAx3D3QDbmthLU8RH0LG5ZZQ==
x-ms-office365-filtering-correlation-id: 76625ff3-56cc-4c6d-25ac-08d687975b4b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1315;
x-ms-traffictypediagnostic: BN6PR11MB1315:
x-microsoft-antispam-prvs: <BN6PR11MB1315211F4E5C66896DA3CFBBF0910@BN6PR11MB1315.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(366004)(199004)(189003)(6116002)(186003)(3846002)(107886003)(68736007)(386003)(6436002)(7736002)(76176011)(305945005)(105586002)(86362001)(256004)(14444005)(6506007)(52116002)(4326008)(106356001)(102836004)(26005)(99286004)(50226002)(8936002)(6486002)(2501003)(72206003)(1076003)(2906002)(446003)(11346002)(2616005)(97736004)(476003)(316002)(486006)(14454004)(54906003)(53936002)(110136005)(25786009)(4744005)(8676002)(81166006)(81156014)(71190400001)(66066001)(71200400001)(7416002)(478600001)(6512007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1315;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BU15//hhVB9fmXj+PwB6XF0mQN1fep8iPxqHwQzV5ywpl/fhJf+9AIOK9WvpgQTTj7QT5xxYA+jvvY54l28UEmuCA6XCpq9lzes685Z6Sq9dfOQ+51h3jbcHCGXlcVkz/mmZ0el/oj8dxNN4rhDNaFxxt/iDY6+VddvERxJSE5KP6l8Wr/lpmveQWumunOIAl2iipQUiK/ZroEz5GJAFnqvhwbSsRx3FRjuz5BeS0SH4xHZyDbtl0i8pP7ODJmQc6nADv5DV2moFAuiCFPq69V/or351R1trOaOIsYfXCse82Crhg2w5bZvgjvKdOWDwBj1ulE7wvGNqKvPFb9UuY/9isWBNK0qS2u+jWV9pKVqFIFwbCze+7yCYPT0YIhWaD9ttNpAZws9AmVq+WKM2mHHLykli1GI/XeHkYvqR5PA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 76625ff3-56cc-4c6d-25ac-08d687975b4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:15:44.1530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1315
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Introduced in:
commit b60557876849 ("ARM: dts: at91: sama5d2: switch to new clock binding"=
)

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v2: collect R-b

 Documentation/devicetree/bindings/spi/atmel-quadspi.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Docu=
mentation/devicetree/bindings/spi/atmel-quadspi.txt
index b93c1e2f25dd..e9dae6264d89 100644
--- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
+++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
@@ -19,7 +19,7 @@ spi@f0020000 {
 	reg =3D <0xf0020000 0x100>, <0xd0000000 0x8000000>;
 	reg-names =3D "qspi_base", "qspi_mmap";
 	interrupts =3D <52 IRQ_TYPE_LEVEL_HIGH 7>;
-	clocks =3D <&spi0_clk>;
+	clocks =3D <&pmc PMC_TYPE_PERIPHERAL 52>;
 	#address-cells =3D <1>;
 	#size-cells =3D <0>;
 	pinctrl-names =3D "default";
--=20
2.9.5

