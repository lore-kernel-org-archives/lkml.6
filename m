Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA4BC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D50F20821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="eB+RhzJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfBERdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:33:35 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:49474 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730657AbfBERdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:33:32 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="25881411"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Feb 2019 10:33:31 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Feb 2019 10:33:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfH2Jg5tnbHT+3iBrkm9uPVkz+bTwBk4NDVX8KiHmA0=;
 b=eB+RhzJo50LZHKEBiEJIlJ0YCaCtSddG9k3VzQa7i5fBFsSR1UZs1rKgbXndO0+I3/JkjGTxJQXXbRE4RQT0K8cmXlGNoWv7vGNsj4W6OjZbYZLU9MyocHKEu14C1FRLuD5C8W4vOVfWO67Dj5IhhhXc2xW/qNB4bWNpgspQmWk=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1539.namprd11.prod.outlook.com (10.172.23.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Tue, 5 Feb 2019 17:33:28 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 17:33:28 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v6 09/13] dt-bindings: spi: atmel-quadspi: update example to
 new clock binding
Thread-Topic: [PATCH v6 09/13] dt-bindings: spi: atmel-quadspi: update example
 to new clock binding
Thread-Index: AQHUvXjn06mxv8WDSEe35xEVc4rrbw==
Date:   Tue, 5 Feb 2019 17:33:27 +0000
Message-ID: <20190205173254.16388-10-tudor.ambarus@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1539;6:ZFfYHVgMcPRUsWd94s0cGfn5MvXTqV5iQSE+pjBMNcFOoxOE1mxS4vdEuOq74Xj6wMnG0LTqRWwz58dqVnsU8yVBurMhECSaJC6WVylFvYJs4Jx6ZJ0jZRea9IIQjlPpq/kTniZfnZ1SMUz1YhdXp8fnbWsUSBUxop3UFHJuV2pWmbL8/s9gr+IapP4V5+YYaOC5YhgF4wxY9wzmALXLclq303kDvG/0wcvueZ+1aRQLXgaA44lOF0eLWnqfcUVLx83FOKndggAGcDePIVKyDLJ0ik8/hLjEca7quRke/4OxsvQKf+ZcuOJpOpnGpyIsNWuypjJQSGf5g+QTUhnQ5/c/9eiN/GK0iU1zDcUY8tQJMDVC7HvRXJ7sVVveaUTYCsCCq0feVpi+lNtEwgPt5Lh7+UlHso2J3dbPhAiPZPNd/EmUO8NaxoARE21ggpu/dgBkdkmaOHdUz54yJnB9OQ==;5:oFsuIbEHl7sgrdy3ZV5NScp2Fevc8QamPtU33k/m2wBFN5qC+L5ijVAR7dJNB+tlQcyN/ayxSIslKOy9rE1mlypGmJV7Hzl5pqBVGT5FoR5ZBqW6aLJvaRXuoL/mgFRFxhkLZ4VaFuxmaMhL8WuvO5Nq8T0Sgw2ANr/Y7JC3R4BiLoy+E1mQfT65UtitTxNzK9BKkInxgVC7tqvzehwJ/Q==;7:DhqsSbYPGLsk5IpDF6yoyc20+A5CDzbd5SB4/vkOaOBBD2WtFX6G35WI6wButR6BlZK+9v/tke3S6HbkHslypt0OO1aG7GTgVS2cL2pMVPOfKwFH9MjDRxHPEWorI3vCJcoVdhbV+gKB3Dr1CPRAWw==
x-ms-office365-filtering-correlation-id: e06666d9-864f-43f4-5de7-08d68b9009dd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1539;
x-ms-traffictypediagnostic: BN6PR11MB1539:
x-microsoft-antispam-prvs: <BN6PR11MB15396EF68A527CB8C7B49ABAF06E0@BN6PR11MB1539.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(386003)(6506007)(7736002)(4326008)(71200400001)(71190400001)(99286004)(72206003)(2906002)(110136005)(14454004)(316002)(305945005)(76176011)(8936002)(8676002)(52116002)(7416002)(3846002)(478600001)(6116002)(54906003)(2501003)(50226002)(1076003)(36756003)(106356001)(53936002)(105586002)(4744005)(25786009)(81156014)(6486002)(68736007)(81166006)(256004)(86362001)(102836004)(26005)(486006)(6512007)(11346002)(14444005)(66066001)(476003)(97736004)(107886003)(6436002)(186003)(2616005)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1539;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Sd/E3p09ilGajcATbZSU4jzTpI4nq3sS9j6l2ZB3xbDjylgi1uZjZh0c+lxSBpxPOvdJzUhMUGRFkaZNDiGRa1QcQVhpVDc6v7s0YF/NMcoY99WvUMYbMO+Cv/WL63pfv9zBJq/hV7VwRg9mjhoImJKqDNDXgLbxby7LxfJNHPWLuv2MX/ysA4TXEW7hLeJ4cCT8TCxgCd9+ndrehksKNPOBJWwBs/PAjXmADpsWGjKhGGn0h/W2DaIDttNNrBeZpy3apMc59lgJV2nAcsfd7Ry3VS3eXtwTjUXnVmWcZ6beoicTVzUJGiUVPnYyXJHczYwPYLRBxvkqrg0m0cjKRolA/dh1vwr+Lz70Yg1WicKLJKCrwIsJWh29ZQ9UDdNYBxFXQg6RzvMIwWZI7P1/RfzQxJlnh6F6W2yYX5uQZLo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e06666d9-864f-43f4-5de7-08d68b9009dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 17:33:25.4748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1539
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
v6: no change
v5: no change
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

