Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BB4C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4B12081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="RJMASlnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfBDKKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:10:04 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:59645 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729403AbfBDKJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:09:59 -0500
X-IronPort-AV: E=Sophos;i="5.56,559,1539673200"; 
   d="scan'208";a="26111701"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Feb 2019 03:09:58 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 4 Feb 2019 03:09:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sl0ZxzuWZAR77THBGi7a4o9ip4vZenzv5gkGL1ZO2/Y=;
 b=RJMASlnhu/chu9QNTyAWg/rVsrsflLhDNv+hqXb3WKxE8m7SHmwGr+Yo0CTtgmRgTnYHBZyU6XvEkLvlWru7EAB+ZANYljQxTabiYfqnExFDqJmAm2SN5RDv8WRI3m7L9OV4SnTbMMXYwsEpBZTxk82vP9mVoAcoKMqFoBrnenA=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1508.namprd11.prod.outlook.com (10.172.21.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 10:09:57 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 10:09:57 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 09/13] dt-bindings: spi: atmel-quadspi: update example to
 new clock binding
Thread-Topic: [PATCH v4 09/13] dt-bindings: spi: atmel-quadspi: update example
 to new clock binding
Thread-Index: AQHUvHHHgJu9moC3XEqdb/LUZheacg==
Date:   Mon, 4 Feb 2019 10:09:56 +0000
Message-ID: <20190204100910.26701-10-tudor.ambarus@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1508;6:yoIXTVPaDh6GAiOXATzb1MyGXincU5eyeRa1yfFkoDNx0uZfID3zDjhshNpDBtZg5aJp8zjudIUKgKnFcCHrqhSzA8pTpxhw4p3aQxI+FAMGdFRR1PKwSJUtXFQBy/Zo/+IgpL2rNm3+Yp0fp1OBcRpUQqrG5lZn13UPZm6btHVnWwQ9lpz5naORT18quBIcQLADfi3KeSex4nWMUDSaUUz0LUSemnmbPRXNxePpfVCRPDRuOrvK7GmQmxjVGBusmxW4fNyCsv/Hft1gfDrWAJdv4hrEL+NAoRn7I26E250QVsrQMgM3+GUb5hg0L6TzUoAshsqs14T1o2dxTOLDmT4Qktl8Rij1i0fKCokUkm0wVQWFuMWkUwtGsF4X+cFoHhTUIYxtoNo95z+dBPve2zH75oJD11SpbFY36U2K4RxAdWG3FX4HZ+h30w+JCqDxlvnLgGabkIUk1KQchQb0Ag==;5:5S6o+v8t2Lyxcu3nlcGcchIEsWwR6ZlYTyyemmaFWpGi8Gw73GttO+GITo1m/Mx1a8kqWdAC++LPM6ZcIWHD4oADd093fKvMVZYvhJZh1xwOe370Pi/h/qC5ixKjJJGtGWvTuiJj1zatrpviY2ybXkYfUyYsU5KQXMNTHd18vcygGLgWSX5oyrdPvuculZs+QSC93AAG+MsTDV1DQwJm4w==;7:8iSExSVYDN3VhJdKupGoGgljn9zN613ipSHujtMtUJA407swI2DURGaVog2g0BBI+Yj2rUDrTEIL7nADO7XIxtwDqF/aZDtue+zoYDQdN7hgih9xo4UraCTNsTLRfuDll1ovB3uxlo7MCM0qp6bh0A==
x-ms-office365-filtering-correlation-id: 0fa432ae-4bbe-4571-5c75-08d68a88e9f1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1508;
x-ms-traffictypediagnostic: BN6PR11MB1508:
x-microsoft-antispam-prvs: <BN6PR11MB1508C442BEED8A99BB893BF5F06D0@BN6PR11MB1508.namprd11.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(6486002)(11346002)(446003)(2616005)(486006)(106356001)(99286004)(6436002)(4326008)(105586002)(478600001)(476003)(76176011)(186003)(53936002)(305945005)(3846002)(6116002)(7736002)(81156014)(102836004)(26005)(81166006)(6512007)(107886003)(8676002)(25786009)(68736007)(39060400002)(52116002)(50226002)(110136005)(8936002)(2906002)(386003)(54906003)(6506007)(86362001)(1076003)(36756003)(4744005)(71190400001)(71200400001)(316002)(97736004)(7416002)(14454004)(256004)(2501003)(14444005)(72206003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1508;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x2CgSAf52F0RezGIWtdvpVXiVBvuyDby12e5aaoT4w8q1gehn06XQBA/X27zJ7iTTtIHNddHHvFL+oz+oB63Mj/Qdt1SxnWiZWSnfxEh9C3ksXrilMBBOEpXAHdqNlsX5WjEUE+MRkRpwOoEJt4rvgkCrrfl8fegbS3I50iW84rocfXGBHN6shPPmPpVuEPh2tTuI/8xYisuhj3XEb74ShMIKZBVaHw+FxPcOkXZcHIcPTThB4EI8CTZbbcvV5yS4WdwAKfSwOvNkKEUpMOkuxNVuxycPGCUBXa9FwCZbfHUB766QuwI9weX0AflI38JY3jfqfv4F/uqb9HjSxXJjfcAg5me+CVqN75S8Qc4WIrFzTpvlxUMDdbi/1B+GwKKszAsHtm1bhlQR8h+/ITijOi8u7FeoTVsSHh9o3IZlTA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa432ae-4bbe-4571-5c75-08d68a88e9f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 10:09:53.9287
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

Introduced in:
commit b60557876849 ("ARM: dts: at91: sama5d2: switch to new clock binding"=
)

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v4: no change
v3: new patch

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

