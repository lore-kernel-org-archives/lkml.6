Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B94C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E75320821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Xl7aGykz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbfBEReH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:34:07 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:50041 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730703AbfBERde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:33:34 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="26171831"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 05 Feb 2019 10:33:33 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Feb 2019 10:33:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nXrQZXeOCUbWGDz7IVa2QEx0dQ+ABc72ETbWdOCENs=;
 b=Xl7aGykzbTM7/V1vJ01FHiMFygAJt5Q4uoSNM4u1ceolO7FdW7rHZ61W0tn1P7xCmQhSVUeCKjgal79LZowYGmKTvACNq3FA/TIAuBmvdQgNyZCf6YnFsf8X2bvnod8KBn5qYPhcViyYlEIg7E2VqEU7RJAV4hQIGXz443/EmFc=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1681.namprd11.prod.outlook.com (10.173.26.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Tue, 5 Feb 2019 17:33:30 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 17:33:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v6 10/13] dt-bindings: spi: atmel-quadspi: make "pclk"
 mandatory
Thread-Topic: [PATCH v6 10/13] dt-bindings: spi: atmel-quadspi: make "pclk"
 mandatory
Thread-Index: AQHUvXjprowezEMR+UGbdwWUreHtIA==
Date:   Tue, 5 Feb 2019 17:33:30 +0000
Message-ID: <20190205173254.16388-11-tudor.ambarus@microchip.com>
References: <20190205173254.16388-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190205173254.16388-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0128.eurprd07.prod.outlook.com
 (2603:10a6:802:16::15) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1681;6:bOkZG8rli9MARNKykM85IFlrAmGP2J0wtz1V+fGm2yHzMR9pQUxmgptYQJoUevyNvPC0DGh0HzicnQFBWDzuUATNOjuGBPh+pNgT0cnVsI0ZOU+Qbsx3qAuhOPzYHmYMk9Ij0MJ/R0YBU+1RY8cZpsFFz/4W/nVcu7oGutMi31QwXHgXel1X6+RlZmGSKnXTMybFvwgtqEYLFHWrOQ/kLOxyXXA3RbxV78wObZgb8R/cjmOma0d/skqT/4GCaNvlSLdpQEn7p9nLxKPQ3EeOVRxFysPt3GSj/0fKtZJdGl6330OGA94jL1iGKLndpv1d16efVJ7aWaeIrXdcdzJlsv/imUNWBEav6a/1t5g+o0Rc2P1IkDHZkb1mqpoaBRNY+NafzYCrT2RjJhVhGkcDPepaxusVj0sYJ0YM3WzpcRhk5T+Uu1293N1BdpWBALIUlVXned8uKIHA7ZInh9ZdZA==;5:zUJUQ8d/DNRdnRrWawG48q1iC/IfHizaVO9vQKGdWmzFrAzugyh5R7/a3B6wuJ9Mee+qAXRPkuu6nbZkWdOu9OKlgCCXEr8X0dVOu0MdMMJJTYX7Qyy8FGDr6vudWCTXzLB73/3bEiV5jvMIfPX9TqGcFJyNDiHpuQ6DLOuNZDB5u+9KztPY2hiWLP70HYcsS+7LIfO4NbMECaxU9FDcCQ==;7:hh73UnnyW/j9p+5Hm5Apz7i71GavoNjJ+p6ZVqZH3oqtfKTTq1zzj/3X46ESCyr7W2WFYC/kmc72urI94RfQEp7dAKLJkqTzJXJhDy719yY0e/JYsLX9aO4a7TS3uYeCqv8CklUYU/iY+agWaKPj2A==
x-ms-office365-filtering-correlation-id: 81067654-ace4-4d50-2442-08d68b900b7e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1681;
x-ms-traffictypediagnostic: BN6PR11MB1681:
x-microsoft-antispam-prvs: <BN6PR11MB1681D65693812FFB41D11C9CF06E0@BN6PR11MB1681.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(376002)(366004)(189003)(199004)(4326008)(186003)(1076003)(36756003)(26005)(110136005)(25786009)(6512007)(316002)(476003)(11346002)(7416002)(54906003)(486006)(2616005)(446003)(86362001)(6486002)(6436002)(66066001)(478600001)(71200400001)(7736002)(97736004)(14454004)(71190400001)(76176011)(256004)(52116002)(3846002)(2501003)(305945005)(99286004)(6116002)(53936002)(72206003)(386003)(107886003)(8936002)(106356001)(81156014)(81166006)(105586002)(102836004)(50226002)(68736007)(6506007)(2906002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1681;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j//nneVn0RKy77+jsy8zYGXY/Zt0sGuM4Wr3GKdHJpB+DkEf2yb0HliOUYzq2SoevLaOyJn3DJeDWHA/Zs9ZvyKy/QohOmo0lQNb9vsYiZWnYxsbe4iryeAbnhJFVQvICMoPUkypzuMRsu7SLTUKvfCfWIUcs6leRe7VVrvBQDcg/FWQH+dvVAbFBAQbjerc5hpU+BF8+FnTPd3fZs4iI4ffFuMl19V4JqNGohM9vhgniH3afkejCZ6bn5D89o00Kz6edPFks4XfFB6D9L/uRhPTJwPHYadDl2H6k1vBNiXKjidAyJa+Z5ljmUsGZ5tUwAefuyHIOzZrfWgWonJxFdFd6x5X6uyXE/J4L/VlJ8IcXdU6DsbVGsFE3ckW8XiXo8AlaUjiek9XktdUFh/UGC1WleZoWBVWoygYoJDBVjY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 81067654-ace4-4d50-2442-08d68b900b7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 17:33:28.1522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1681
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Naming clocks is a good practice. Make "pclk" madatory even if
we support unnamed clock in the driver, to be backward compatible
with old DTs.

Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v6: no change
v5: no change
v4: add missing semicolon, collect R-b
v3: new patch

 Documentation/devicetree/bindings/spi/atmel-quadspi.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Docu=
mentation/devicetree/bindings/spi/atmel-quadspi.txt
index e9dae6264d89..50bd257e6826 100644
--- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
+++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
@@ -9,6 +9,7 @@ Required properties:
                   - qspi_mmap: memory mapped address space
 - interrupts:     Should contain the interrupt for the device.
 - clocks:         The phandle of the clock needed by the QSPI controller.
+- clock-names:    Should contain "pclk" for the peripheral clock.
 - #address-cells: Should be <1>.
 - #size-cells:    Should be <0>.
=20
@@ -20,6 +21,7 @@ spi@f0020000 {
 	reg-names =3D "qspi_base", "qspi_mmap";
 	interrupts =3D <52 IRQ_TYPE_LEVEL_HIGH 7>;
 	clocks =3D <&pmc PMC_TYPE_PERIPHERAL 52>;
+	clock-names =3D "pclk";
 	#address-cells =3D <1>;
 	#size-cells =3D <0>;
 	pinctrl-names =3D "default";
--=20
2.9.5

