Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D46C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51FD222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="CD1I1veY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391137AbfBMJCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:02:13 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:62113 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfBMJBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:01:50 -0500
X-IronPort-AV: E=Sophos;i="5.58,365,1544511600"; 
   d="scan'208";a="23778144"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 13 Feb 2019 02:00:02 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 13 Feb 2019 02:00:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqitVlNfd9v40uYN1JBOEDg6FYjYqHs1pMwOVDIlhLU=;
 b=CD1I1veYXicSIcbdy4ALBTgPL6G1gioZE46BfY6BA4r/aHatMIW9roayt/aTVyp4uMabUxDqATMwYSumwZrygepqjh0aJ80ffzyabn88AzrZkJVTD48ejlOZsGVt70/IxP0nAfQ8vaKRQ50MoFAGaK2THNdikjCIZ+I+RDPtmHE=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB0019.namprd11.prod.outlook.com (10.161.155.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 08:59:59 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 08:59:58 +0000
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
Subject: [PATCH 05/11] mtd: rawnand: atmel: add generic name for EBICSA regmap
Thread-Topic: [PATCH 05/11] mtd: rawnand: atmel: add generic name for EBICSA
 regmap
Thread-Index: AQHUw3p/WcoWk5iPWUK5WAuDRxDQqA==
Date:   Wed, 13 Feb 2019 08:59:58 +0000
Message-ID: <20190213085930.31578-6-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: a7baa671-f851-4381-9817-08d69191a174
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB0019;
x-ms-traffictypediagnostic: BN6PR11MB0019:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;BN6PR11MB0019;23:Yz5UqXVkYUu4Kg/L3zuSA83NggrmH7IDW+oaJfj?=
 =?iso-8859-1?Q?py4kpPVAsc8prG95Vb2sB+4VG+DgnnuHpQeDj+eTLd1JZIJfeRSPzNLT80?=
 =?iso-8859-1?Q?swj2applyO2JaRGXKDfnaXk4XofcHijoxEJb+NFqU6fkUf1OHMgj3lnfOm?=
 =?iso-8859-1?Q?2L6ArMp7I4sqKaQwSD0Xq4xPsuGr+x3ZT3wXc2bOB/EqPo0HvduulXeytV?=
 =?iso-8859-1?Q?BttZHQ6FZ+5+6zx7ee4VzNBPkAh4S5p9sgjUnrDtCjdHFFi0YevAaaB1ny?=
 =?iso-8859-1?Q?AkjcssuELeJYzPbYSdWA1ZW8aHnBvt99nXGDvrH5k5IKfNYJW2D8aitrrs?=
 =?iso-8859-1?Q?+N/vhemzDkSOLuwan7aE2ZI9uP0Ye+CnQo3mxf8b1AkIQafg/MqIk66rnT?=
 =?iso-8859-1?Q?KgMuOJgVGNTHo7aFZmrj++CGNpORjDxerdf4Jcs4dgpvi1ChQYR80FD08w?=
 =?iso-8859-1?Q?XEjVz9aNfWccJ/3NYnKFT30lV6ctBWCbrEz6vpQ4WE+VIBZPwPKiFyQJ+4?=
 =?iso-8859-1?Q?4ubhF3T0H8VJycrl8oQlU0EVZhwmwR/4veUqvHaMlkC8jajz9UWECLgUS6?=
 =?iso-8859-1?Q?U70aiSlCR2AsaGGZdyTVYO5L5tKjW0UlMY5hW//PJ4yqXrR70pa0Slwu5u?=
 =?iso-8859-1?Q?12RbBu0Ai4lnhVD8EdINvHoajGUROGT5hS1zAi2kLL18eujCotnpAYbUeZ?=
 =?iso-8859-1?Q?KnEY6yzVvbthtjEw9oGIjvo0fhq/HFNhWvB8BuE/+agE7DmWl0NsZXbJx6?=
 =?iso-8859-1?Q?XiW9EcIqD8JbU1wIOZu50ldYTT+vSzenCUCglMLItqod2ST22irKYpAHsB?=
 =?iso-8859-1?Q?1U6g6uVOhbvQp+95eE2YHoSyA+/0rYZFP0oHa5ALczQcpKQ7xDC3ABXVvA?=
 =?iso-8859-1?Q?8Jp4euPJBMn9BJLIrHkTUubbSvpLpES0ZxnJx4+Y2cCxHoqk1G9DbqXXpV?=
 =?iso-8859-1?Q?4ldx/H+/8FFDomArId+6mgEsHKg6Cq+UkBfKgWY9GEry4k3WbCfgLVISX7?=
 =?iso-8859-1?Q?uRZqVVBT8hQ+sGVnLFss2QzAO/HXoE/RmshS83maTJPGW6LElbli7Glr9W?=
 =?iso-8859-1?Q?D4uWiOUDg6E2v1/WHn4hQdug3gbR5QQJfIzjKQd79Qw9ukpQK2rUYtUhPY?=
 =?iso-8859-1?Q?Vgd/etT2XklBx5QK6SP5Xvjy+dlMQfhlPEtGS2PWMfg24534hLhKRaq+jN?=
 =?iso-8859-1?Q?BQA1RRU+ytWPaEq171ODkdputHe3/7XwNKLFBoosN7nqfqrBlvc5Ry/p20?=
 =?iso-8859-1?Q?WXwpcDqe6mfZWFhfDZ1j5MtIXiV/PYSAfjP94GZTvfBQdH7ro8/uwcduE9?=
 =?iso-8859-1?Q?Lkdj0krTlXaaoeHfFf8PHQTNf7CLfvOj+l4OSkY7bBM79kSVsMWTTzd03G?=
 =?iso-8859-1?Q?NTj27ONfhXP5cyt/HiLWyKVPVMeJ3tSF2tjam9LTJO81RE7lpUexbnL/Ox?=
 =?iso-8859-1?Q?Lo3u1FkEOZ1GuU=3D?=
x-microsoft-antispam-prvs: <BN6PR11MB0019F4EA5FC7FA784F540766F0660@BN6PR11MB0019.namprd11.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(81166006)(50226002)(106356001)(7416002)(6436002)(54906003)(2201001)(1076003)(81156014)(26005)(110136005)(476003)(102836004)(107886003)(8936002)(6512007)(6486002)(4326008)(446003)(2616005)(316002)(8676002)(105586002)(99286004)(66066001)(486006)(6116002)(3846002)(186003)(11346002)(86362001)(2906002)(72206003)(71190400001)(14454004)(76176011)(53936002)(71200400001)(478600001)(68736007)(6506007)(386003)(2501003)(52116002)(97736004)(14444005)(5024004)(7736002)(305945005)(256004)(25786009)(36756003)(41533002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB0019;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u1hesAtNFzSAPFnjrA+oJnkSG2sdMc+l0aWEJ9Apyubgqj2/0Zg+LFLHKu3J+VznowhNxzKuwgQyMnpENzSMDTAx2zXrDkP8qzkTUsyYXtpoqiMDFjLrpyOE3ilAHrXyERyaRTBzlIWowJmTwGEbbvsZu5V6Xy9xUbg7tnkxOH33+aZrdFkq87Su948h843rhr2LOjzJt5lUoG/EfmO+0qnRmb8O/XOwU6Xvd7xzTs2wt8Hs9VGrjTh73tOJL1R7dMCErGbzVA3MWKQ5VaHulhslRyWVRSS8ZTMO6td1bqivwvx9szdr0nM5tvELCuf7tQ6hmLml6D+/ujLvxSJiYlc3ihOuKhlhCRAo+Nm3Gecd0Pz/m/emW9aG8ECbWbt8bTAQMb/EMfZRGUPlligoiRKpRsVzkgWGpLTHQYl4CCg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a7baa671-f851-4381-9817-08d69191a174
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 08:59:55.8050
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
more generic name for the EBICSA regmap, as a prerequisite for
sam9x60 nand controller support.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 28 +++++++++++++++++-------=
----
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nan=
d/raw/atmel/nand-controller.c
index 5781fcf6b76c..6aef98b7338a 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -211,6 +211,7 @@ struct atmel_nand_controller_caps {
 	bool legacy_of_bindings;
 	u32 ale_offs;
 	u32 cle_offs;
+	const char *ebi_csa_regmap_name;
 	const struct atmel_nand_controller_ops *ops;
 };
=20
@@ -233,7 +234,7 @@ to_nand_controller(struct nand_controller *ctl)
=20
 struct atmel_smc_nand_controller {
 	struct atmel_nand_controller base;
-	struct regmap *matrix;
+	struct regmap *ebi_csa_regmap;
 	unsigned int ebi_csa_offs;
 };
=20
@@ -1507,12 +1508,12 @@ static void atmel_smc_nand_init(struct atmel_nand_c=
ontroller *nc,
 	atmel_nand_init(nc, nand);
=20
 	smc_nc =3D to_smc_nand_controller(chip->controller);
-	if (!smc_nc->matrix)
+	if (!smc_nc->ebi_csa_regmap)
 		return;
=20
 	/* Attach the CS to the NAND Flash logic. */
 	for (i =3D 0; i < nand->numcs; i++)
-		regmap_update_bits(smc_nc->matrix, smc_nc->ebi_csa_offs,
+		regmap_update_bits(smc_nc->ebi_csa_regmap, smc_nc->ebi_csa_offs,
 				   BIT(nand->cs[i].id), BIT(nand->cs[i].id));
 }
=20
@@ -1833,7 +1834,7 @@ static void atmel_nand_controller_cleanup(struct atme=
l_nand_controller *nc)
 	clk_put(nc->mck);
 }
=20
-static const struct of_device_id atmel_matrix_of_ids[] =3D {
+static const struct of_device_id atmel_ebi_csa_regmap_of_ids[] =3D {
 	{
 		.compatible =3D "atmel,at91sam9260-matrix",
 		.data =3D (void *)AT91SAM9260_MATRIX_EBICSA,
@@ -1982,25 +1983,26 @@ atmel_smc_nand_controller_init(struct atmel_smc_nan=
d_controller *nc)
 	struct device_node *np;
 	int ret;
=20
-	/* We do not retrieve the matrix syscon when parsing old DTs. */
+	/* We do not retrieve the EBICSA regmap when parsing old DTs. */
 	if (nc->base.caps->legacy_of_bindings)
 		return 0;
=20
-	np =3D of_parse_phandle(dev->parent->of_node, "atmel,matrix", 0);
+	np =3D of_parse_phandle(dev->parent->of_node,
+			      nc->base.caps->ebi_csa_regmap_name, 0);
 	if (!np)
 		return 0;
=20
-	match =3D of_match_node(atmel_matrix_of_ids, np);
+	match =3D of_match_node(atmel_ebi_csa_regmap_of_ids, np);
 	if (!match) {
 		of_node_put(np);
 		return 0;
 	}
=20
-	nc->matrix =3D syscon_node_to_regmap(np);
+	nc->ebi_csa_regmap =3D syscon_node_to_regmap(np);
 	of_node_put(np);
-	if (IS_ERR(nc->matrix)) {
-		ret =3D PTR_ERR(nc->matrix);
-		dev_err(dev, "Could not get Matrix regmap (err =3D %d)\n", ret);
+	if (IS_ERR(nc->ebi_csa_regmap)) {
+		ret =3D PTR_ERR(nc->ebi_csa_regmap);
+		dev_err(dev, "Could not get EBICSA regmap (err =3D %d)\n", ret);
 		return ret;
 	}
=20
@@ -2341,6 +2343,7 @@ static const struct atmel_nand_controller_ops at91rm9=
200_nc_ops =3D {
 static const struct atmel_nand_controller_caps atmel_rm9200_nc_caps =3D {
 	.ale_offs =3D BIT(21),
 	.cle_offs =3D BIT(22),
+	.ebi_csa_regmap_name =3D "atmel,matrix",
 	.ops =3D &at91rm9200_nc_ops,
 };
=20
@@ -2355,12 +2358,14 @@ static const struct atmel_nand_controller_ops atmel=
_smc_nc_ops =3D {
 static const struct atmel_nand_controller_caps atmel_sam9260_nc_caps =3D {
 	.ale_offs =3D BIT(21),
 	.cle_offs =3D BIT(22),
+	.ebi_csa_regmap_name =3D "atmel,matrix",
 	.ops =3D &atmel_smc_nc_ops,
 };
=20
 static const struct atmel_nand_controller_caps atmel_sam9261_nc_caps =3D {
 	.ale_offs =3D BIT(22),
 	.cle_offs =3D BIT(21),
+	.ebi_csa_regmap_name =3D "atmel,matrix",
 	.ops =3D &atmel_smc_nc_ops,
 };
=20
@@ -2368,6 +2373,7 @@ static const struct atmel_nand_controller_caps atmel_=
sam9g45_nc_caps =3D {
 	.has_dma =3D true,
 	.ale_offs =3D BIT(21),
 	.cle_offs =3D BIT(22),
+	.ebi_csa_regmap_name =3D "atmel,matrix",
 	.ops =3D &atmel_smc_nc_ops,
 };
=20
--=20
2.9.5

