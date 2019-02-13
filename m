Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B19BC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D30222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="OQymV7ck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391104AbfBMJBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:01:51 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:62113 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732475AbfBMJBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:01:49 -0500
X-IronPort-AV: E=Sophos;i="5.58,365,1544511600"; 
   d="scan'208";a="23778136"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Feb 2019 01:59:51 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 13 Feb 2019 01:59:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hc4nV9jdLKYNjIUT+gRpNFusDLGZhRyZ8ciEoFGPcx0=;
 b=OQymV7ckweMKp+j8tid0b2UoC/XDJpijDFAt3zyxeJVFQiWdqsj361CQuuIKLf9vqx3E2RpUEl5qCwWcZlZbqAql44j/aT+s0TNf2gX6xK1FCyQUiflzAoYt7O69kYtA5JPbHh2BekE+pH5sXTpV26CagcClYwXagHoUJkLW03k=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB0019.namprd11.prod.outlook.com (10.161.155.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 08:59:48 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 08:59:48 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <bbrezillon@kernel.org>,
        <marek.vasut@gmail.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 02/11] memory: atmel-ebi: add generic name for ebi regmap
Thread-Topic: [PATCH 02/11] memory: atmel-ebi: add generic name for ebi regmap
Thread-Index: AQHUw3p49S/sYBbl10WTjl6hIGDc8A==
Date:   Wed, 13 Feb 2019 08:59:48 +0000
Message-ID: <20190213085930.31578-3-tudor.ambarus@microchip.com>
References: <20190213085930.31578-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190213085930.31578-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0085.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::11) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae6e05dd-e7e6-40c8-ef9f-08d691919b13
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB0019;
x-ms-traffictypediagnostic: BN6PR11MB0019:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;BN6PR11MB0019;23:557XpDeJbzlhl/SeyL9HDqRRS80Xvci+V6bqinC?=
 =?iso-8859-1?Q?oCwpWXF6bKiFV3sOD9aO9kDjdBCngbtnkzm3L80tesAErSbPhByIpbYk+f?=
 =?iso-8859-1?Q?NppboWGXgVYhhgU7dxnc+C+rxiaFaziDHFKKshZCmJa6CXFHDKsuowLN5S?=
 =?iso-8859-1?Q?CEigv4kCWrzP3BaQNqNTIjGyCPQs5ZpR8kn+8ZPsdZz0OzvLfrVVcnPVcB?=
 =?iso-8859-1?Q?/NILJhfwuNKqDyE+e9aV7Ueri5vfq+6ansD4ROuHvYtcOnZ/DIwkx/vNsl?=
 =?iso-8859-1?Q?pZoI1YN1EKZJ6GWEqzoXfyrrmoHj/AHtbXfYU7kZdvY0C/0mTv3hnjXPK+?=
 =?iso-8859-1?Q?vwWQKs9EXXkWJIAKhUVta8oJFVjutJ+xyLcmll/cwzOgNYS9ZuRBaEVB+I?=
 =?iso-8859-1?Q?qvczZ9ngzB8KHbfQcIlChbP5qeFgXuHKmQbRrZxuncMQjsene0X2SNskrG?=
 =?iso-8859-1?Q?BC2rSbn6aeDh0Y6NDfkfBOIGPzgvyOx2jyXPWHTUL0q/fD2FCANR1yo2fD?=
 =?iso-8859-1?Q?9GucYungafDRVU4HxJfeWKGc4WAlCjLka9l3NW22c7+kn2EFfF/BXScmyN?=
 =?iso-8859-1?Q?5lxix4IZGZ2kgAhyo1G+ybMQhpnee3DwvKxRdmka+EiBJZu0NsNxYD2P56?=
 =?iso-8859-1?Q?bGcbPNZ/dxWDyqVgcH/+z/4DdgWmjyb1IZxtROyGJV3XQi59LZYJZ4IVpE?=
 =?iso-8859-1?Q?g6J7Hp+I/BeeDBc3gsbN9Bgu5pRZoRga3GxG3WwokVuEkwGb8gH5/2Biq5?=
 =?iso-8859-1?Q?eoir4n3LHgZ+WoX8QmpUWPEip5M3cBDks6xWPsrV5l/0tNcvJ/q469gOYN?=
 =?iso-8859-1?Q?1scseswZQ+fWoatBHkrAEw0rMDalgQSigRDCdq3YEHgv0Frkwg8oSQSHFO?=
 =?iso-8859-1?Q?z6zN7ponRm7AsQKwUn/nQ+Jr8YHi5WvZyFAVj7pZrIrMm+3KnmB6IU7Tff?=
 =?iso-8859-1?Q?Zzt8FyofuHaZgb0w0sM/jw2/U9NwqaUEeqzfgiUrkLyan161jlSLWnGZTZ?=
 =?iso-8859-1?Q?TSXG5Z/4ByCceptFK0VBiIN+i/r/z8QMQSYFkAt49AWIHtr087X9bCHRjE?=
 =?iso-8859-1?Q?YMKancDE5ns/rbKubqgH/Eih9qaRM57ovOaLQdi0R+RsyFwrfuoH736lm4?=
 =?iso-8859-1?Q?rE4gCWL/+xzn/mt33oYw6Sudcb8I2R9q55eR08ithKRM909PL1UFLHDKhQ?=
 =?iso-8859-1?Q?vpHQXxcOW8L1qtBMJOAevJmQ4pLrYSjnwkjgd9VhkTmUq0PSrgCNJrf1rG?=
 =?iso-8859-1?Q?C3hiOyFeuCm01GcljKoxOYVtrpMJJIVNBvoLj34aHJ1EDqlM9e3Ong6c64?=
 =?iso-8859-1?Q?iJMt3m9os/NyUHYQwPHls3KDYl+WMwVvWZSn/MyYwPMjN4tBjWewUcCQcp?=
 =?iso-8859-1?Q?czjehuH2lCvSlPdeGDT5IPvEWYs6zjMnq9JxXUEsgO7xSFLerRA=3D=3D?=
x-microsoft-antispam-prvs: <BN6PR11MB00198D1B6F2B17A7333019B2F0660@BN6PR11MB0019.namprd11.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(81166006)(50226002)(106356001)(7416002)(6436002)(54906003)(2201001)(1076003)(81156014)(26005)(110136005)(476003)(102836004)(107886003)(8936002)(6512007)(6486002)(4326008)(446003)(2616005)(316002)(8676002)(105586002)(99286004)(66066001)(486006)(6116002)(3846002)(186003)(11346002)(86362001)(2906002)(72206003)(71190400001)(14454004)(76176011)(53936002)(71200400001)(478600001)(68736007)(6506007)(386003)(2501003)(52116002)(97736004)(14444005)(7736002)(305945005)(256004)(25786009)(36756003)(41533002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB0019;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9IhWswPpxidizIm7BL911oEu48ryQUJdhvfB1rQp94+beokjqxVT+EsFRKqDRIOgKW4e3F78KorxMF6V07VgUnIWvuqnOTIyI8jvQ6Vf18tiSNq2eGOiFcxfGTjVWnaR2mnXn74y1drIOGmlHaVgBJzBuM3I2wIaZoq/FjxBeUuk507YZ5KnsFkunM/eLhYXD9LXbqoAvUXGSGPysiaCCzqMoMXavFIozB2AKKcYiR1Tu99x029Id9F81D3BWphqCpQisqgPINjdTFfQdwAR4z3duBgVh9Y9PpkeiuC7DSAzePUMsuhQ00LNUZJEFs4U/uWfk5c42KmCGTsf3G7olz1UQ7EQGNH6SnkWPjR71IIY7eyRmpdHTRQwTX6+fIW4npIxTJ4R/TgdSyu8/Mk5pXDADsYTHK9bd+B47fq2OAM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6e05dd-e7e6-40c8-ef9f-08d691919b13
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 08:59:45.2083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0019
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The sam9x60 board defines the CCFG_EBICSA register under SFR,
and not as a MATRIX register, as previous boards do. Add a
more generic name for the EBI regmap as a prerequisite for
sam9x60 ebi support.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/memory/atmel-ebi.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index c3748b414c27..b45914cfa212 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -36,6 +36,7 @@ struct atmel_ebi_dev {
 struct atmel_ebi_caps {
 	unsigned int available_cs;
 	unsigned int ebi_csa_offs;
+	const char *regmap_name;
 	void (*get_config)(struct atmel_ebi_dev *ebid,
 			   struct atmel_ebi_dev_config *conf);
 	int (*xlate_config)(struct atmel_ebi_dev *ebid,
@@ -47,7 +48,7 @@ struct atmel_ebi_caps {
=20
 struct atmel_ebi {
 	struct clk *clk;
-	struct regmap *matrix;
+	struct regmap *regmap;
 	struct  {
 		struct regmap *regmap;
 		struct clk *clk;
@@ -357,7 +358,7 @@ static int atmel_ebi_dev_setup(struct atmel_ebi *ebi, s=
truct device_node *np,
 		 * one "atmel,smc-" property is present.
 		 */
 		if (ebi->caps->ebi_csa_offs && apply)
-			regmap_update_bits(ebi->matrix,
+			regmap_update_bits(ebi->regmap,
 					   ebi->caps->ebi_csa_offs,
 					   BIT(cs), 0);
=20
@@ -372,6 +373,7 @@ static int atmel_ebi_dev_setup(struct atmel_ebi *ebi, s=
truct device_node *np,
 static const struct atmel_ebi_caps at91sam9260_ebi_caps =3D {
 	.available_cs =3D 0xff,
 	.ebi_csa_offs =3D AT91SAM9260_MATRIX_EBICSA,
+	.regmap_name =3D "atmel,matrix",
 	.get_config =3D at91sam9_ebi_get_config,
 	.xlate_config =3D atmel_ebi_xslate_smc_config,
 	.apply_config =3D at91sam9_ebi_apply_config,
@@ -380,6 +382,7 @@ static const struct atmel_ebi_caps at91sam9260_ebi_caps=
 =3D {
 static const struct atmel_ebi_caps at91sam9261_ebi_caps =3D {
 	.available_cs =3D 0xff,
 	.ebi_csa_offs =3D AT91SAM9261_MATRIX_EBICSA,
+	.regmap_name =3D "atmel,matrix",
 	.get_config =3D at91sam9_ebi_get_config,
 	.xlate_config =3D atmel_ebi_xslate_smc_config,
 	.apply_config =3D at91sam9_ebi_apply_config,
@@ -388,6 +391,7 @@ static const struct atmel_ebi_caps at91sam9261_ebi_caps=
 =3D {
 static const struct atmel_ebi_caps at91sam9263_ebi0_caps =3D {
 	.available_cs =3D 0x3f,
 	.ebi_csa_offs =3D AT91SAM9263_MATRIX_EBI0CSA,
+	.regmap_name =3D "atmel,matrix",
 	.get_config =3D at91sam9_ebi_get_config,
 	.xlate_config =3D atmel_ebi_xslate_smc_config,
 	.apply_config =3D at91sam9_ebi_apply_config,
@@ -396,6 +400,7 @@ static const struct atmel_ebi_caps at91sam9263_ebi0_cap=
s =3D {
 static const struct atmel_ebi_caps at91sam9263_ebi1_caps =3D {
 	.available_cs =3D 0x7,
 	.ebi_csa_offs =3D AT91SAM9263_MATRIX_EBI1CSA,
+	.regmap_name =3D "atmel,matrix",
 	.get_config =3D at91sam9_ebi_get_config,
 	.xlate_config =3D atmel_ebi_xslate_smc_config,
 	.apply_config =3D at91sam9_ebi_apply_config,
@@ -404,6 +409,7 @@ static const struct atmel_ebi_caps at91sam9263_ebi1_cap=
s =3D {
 static const struct atmel_ebi_caps at91sam9rl_ebi_caps =3D {
 	.available_cs =3D 0x3f,
 	.ebi_csa_offs =3D AT91SAM9RL_MATRIX_EBICSA,
+	.regmap_name =3D "atmel,matrix",
 	.get_config =3D at91sam9_ebi_get_config,
 	.xlate_config =3D atmel_ebi_xslate_smc_config,
 	.apply_config =3D at91sam9_ebi_apply_config,
@@ -412,6 +418,7 @@ static const struct atmel_ebi_caps at91sam9rl_ebi_caps =
=3D {
 static const struct atmel_ebi_caps at91sam9g45_ebi_caps =3D {
 	.available_cs =3D 0x3f,
 	.ebi_csa_offs =3D AT91SAM9G45_MATRIX_EBICSA,
+	.regmap_name =3D "atmel,matrix",
 	.get_config =3D at91sam9_ebi_get_config,
 	.xlate_config =3D atmel_ebi_xslate_smc_config,
 	.apply_config =3D at91sam9_ebi_apply_config,
@@ -420,6 +427,7 @@ static const struct atmel_ebi_caps at91sam9g45_ebi_caps=
 =3D {
 static const struct atmel_ebi_caps at91sam9x5_ebi_caps =3D {
 	.available_cs =3D 0x3f,
 	.ebi_csa_offs =3D AT91SAM9X5_MATRIX_EBICSA,
+	.regmap_name =3D "atmel,matrix",
 	.get_config =3D at91sam9_ebi_get_config,
 	.xlate_config =3D atmel_ebi_xslate_smc_config,
 	.apply_config =3D at91sam9_ebi_apply_config,
@@ -543,13 +551,14 @@ static int atmel_ebi_probe(struct platform_device *pd=
ev)
=20
 	/*
 	 * The sama5d3 does not provide an EBICSA register and thus does need
-	 * to access the matrix registers.
+	 * to access it.
 	 */
 	if (ebi->caps->ebi_csa_offs) {
-		ebi->matrix =3D
-			syscon_regmap_lookup_by_phandle(np, "atmel,matrix");
-		if (IS_ERR(ebi->matrix))
-			return PTR_ERR(ebi->matrix);
+		ebi->regmap =3D
+			syscon_regmap_lookup_by_phandle(np,
+							ebi->caps->regmap_name);
+		if (IS_ERR(ebi->regmap))
+			return PTR_ERR(ebi->regmap);
 	}
=20
 	ret =3D of_property_read_u32(np, "#address-cells", &val);
--=20
2.9.5

