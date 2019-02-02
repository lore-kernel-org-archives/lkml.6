Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24923C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67DD20870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="U11STUNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfBBEIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 23:08:07 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:25495 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbfBBEHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 23:07:39 -0500
X-IronPort-AV: E=Sophos;i="5.56,550,1539673200"; 
   d="scan'208";a="25777622"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Feb 2019 21:07:37 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 1 Feb 2019 21:07:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfsyMf/kEpDa4FIEF9Vr7A/njHirUhN3QsSOsOYW8sc=;
 b=U11STUNTBoBhgL/GsYTR3SxasiYZhTfSOEG3rp6EsGqm2ulwVd/Q0OA5K6pWhfyIQfURh2mDZsVTx9iE895xyhUSqnaRbBAw2eNdrBNjQrjCnd7JWH/c60B4eeANkISnhUxfPHkr1ip6hP1I4UG0ZiW4I+uANimsPYr2Mw/teGk=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1300.namprd11.prod.outlook.com (10.173.26.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 04:07:36 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 04:07:36 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 09/13] dt-bindings: spi: atmel-quadspi: update example to
 new clock binding
Thread-Topic: [PATCH v3 09/13] dt-bindings: spi: atmel-quadspi: update example
 to new clock binding
Thread-Index: AQHUuqzUD5rUyBAMmUemMqz3/PSN4w==
Date:   Sat, 2 Feb 2019 04:07:36 +0000
Message-ID: <20190202040653.1217-10-tudor.ambarus@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1300;6:Ox/X6os129ogSKr7NwpunFYPn13P0VmeOv42K7ozb8JlA0UAnlGd8mqrhtJcwGdX1kkOBRaENWZeW48fvJzUbHnvHmKXs75wwsVHeavxwpKaVA1DJ/b2vPzOa3IBOfEDMCut1pHG8sU99TxRh7Ls+J6KF/Zs1D5rXmN0gk1WDUF+byG3vIP+bpYPL2Nz6fzhH3/fIDs1bfv5boSw7KPC9DJfy8nY6FVTaLmwlwc0HwZ9RcYJ8GQplDcAM7f3Gc4UaceCmxqZP56VI3fdgoIzBhQ/RtKB+wlR+DnIg2NCLLcAfiie6nJFTGj2xY24z+JwNGV7PK7WZZvXPnQMRsMILSDSONdWBA7f/nVZQB7FIfau/bqhE95dhAvOO0/qe2X6usDw3PEo/9JTqJYR+p1S6LtFeU9AopdEiIUWXJEFn9Abfsw+0+i8wlEcBGP5xlpX256TIbMhfYdKLpBArRqI6w==;5:3k2E5yiOdzysBq5NTrgOADhX96W55QV3EA6X+4lhu8jgMAt2Bo8h1FnPwzcYjAmPc7a1g6rQw9JBNZBdr2K45ROTJS8/H37QcLXyvy7PEbOjDLxyzFneKeg6yHM0WoRNGdNWUQBGzK/BXoyJaeA/BOxg4x3jsEhPn4AohJMKV0b3kc+HskLjBVZqJuRDSfS7DxMxUIxWtzuf0VftEl5L4w==;7:RnwuAJrNyqVx6Hkd+4bjz+a2EqeldDDfqJhbcMrRoLM6UqYgziUs3LDGivZKkLYcw09SXmkltt3mrLQC7qLjsVzon6863rKCDwuEG6TZWmjwaasEtzWKFLLlhWbH+WJ6ng7Z2z+lFz4JUXRLfQwPnA==
x-ms-office365-filtering-correlation-id: 248f9fcf-b192-485e-66ed-08d688c3f69d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1300;
x-ms-traffictypediagnostic: BN6PR11MB1300:
x-microsoft-antispam-prvs: <BN6PR11MB1300432EFC6F71083DD35097F0930@BN6PR11MB1300.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(14454004)(52116002)(50226002)(105586002)(6436002)(102836004)(72206003)(81156014)(81166006)(2906002)(26005)(7736002)(478600001)(3846002)(6116002)(53936002)(256004)(14444005)(106356001)(8936002)(68736007)(36756003)(97736004)(76176011)(107886003)(4326008)(39060400002)(2616005)(99286004)(476003)(446003)(86362001)(66066001)(71200400001)(11346002)(7416002)(71190400001)(6486002)(4744005)(6512007)(316002)(110136005)(1076003)(305945005)(186003)(8676002)(2501003)(25786009)(486006)(54906003)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1300;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u1e8epatYhcGdYHTU784IDmP5eovD0mSjM58+YEqw6DMquC5Liy0PyJxTDHZUV/mgr8xNsNiUPB1oVqCS6s9ziyWl3TkNuQIdhK9p65Ueu5mAH1js7F56ztHv1BGZ9T3EDOwHsMmy7iNU/oz1raqh4qt5Bsun/iGs+cRzMcMHn5S9MPmV87UzCYIcq2zanEsoxOji0z92fVq45bc0ISw1YVsFBax8bmmpMDt1KtnCskkaYzuEIiUhVhiA9TI8lfKptiF2FAGKIlY/aoSasvTw9VsA7mggC4D3KjR/ygF+5+DSmxrMx9WaN+q9H/d/r9ut1ekze10C2ispCT7NwXs8+SFKKPQ33MtvHF4PSEOrc8w57uOTL6zJGbVDGfzOli6MbkkfaykMnjmPhYfAxzrP4yl/bt4UB6aJ8qHAaz5Dy0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 248f9fcf-b192-485e-66ed-08d688c3f69d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 04:07:33.6657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1300
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
v3: no change
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

