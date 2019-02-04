Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FCCC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2F72081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Ibut65JB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbfBDKJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:09:47 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:23806 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfBDKJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:09:45 -0500
X-IronPort-AV: E=Sophos;i="5.56,559,1539673200"; 
   d="scan'208";a="25825516"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Feb 2019 03:09:34 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 4 Feb 2019 03:09:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaYxaNBKwRaW5vxHWs66S0Bvl3mPfPUab0t93rbEJXo=;
 b=Ibut65JBgjdluM05ukLjMmEkKnt7q32lea/f5WJSTNLnJjDOzvwqFOmIYrT3oNkLtmySJGSRQzWURjWPJXiidli2FYaPkNaobAuXFUcrmO1jB89MI8fF/A/xn31dF7C4vwygf+AfY+d7sL0H4i4/bVwZ157fNx/g1xG/1wKeYBs=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1473.namprd11.prod.outlook.com (10.172.21.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 10:09:32 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 10:09:32 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 04/13] spi: atmel-quadspi: fix naming scheme
Thread-Topic: [PATCH v4 04/13] spi: atmel-quadspi: fix naming scheme
Thread-Index: AQHUvHG5Jq0015cwR0myuxhyL3a68w==
Date:   Mon, 4 Feb 2019 10:09:32 +0000
Message-ID: <20190204100910.26701-5-tudor.ambarus@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1473;6:skemZT0iRVd57wTKDn0Y+3Wvlsj9/h/A6lJn3EPQ0iTRkDwDsA+JSTn8yKIxllsvupiYL2TsAQKpYMwPwNTj4xCpXRNcH1ArZ1C3M+7UIpr3mT60jeD0w1x1zTQvkTpINma40vSzKRK7Z4GUQ+gFFwlVzEw6a+GVYM3X02ERswco9MVSDRur3npJ1ImMJWjELh5DY5K5Em1RNDEO1E4BSgA4y7s9lkEypmvfIEn9OQMbL/IkP4rE4VlzYBedkDds6KI876JKUbLA3AVVVBbIKtBM5L+4z1goHY1vKqf9crr62p2ZLGwE/bU6vBp+oGF2q9+OHTZFpfi/mIjeeyrzdJeCD31cpz2m0ZcN+DUqROLpa01493pbvqelM8w2QBUPQVVg71fXUlFNOuaeb4RoU5v5woObqM0hksY1IiVaa8aBPiSAE85ZMvUppql1Oi2A2QDWMhK91Sjvq6Cx7RqyHQ==;5:+bAzbqHUQ/MIKc7rB0QBnd80duXuh7arx5tn44gwz7jdyr7q6ms6cSerErt4vn5Q9JUz4oqX7tsTQDYCUiCCGJ9XxZigJ+tyjAwsaDfrvpB+Uegc4cOzfici9USvw5fJsi6sBzLdOfKpl9EQiDYOseaZulE2s6ObgmfRvyBTmdTjvKLlsbpQaeKPFrwOC74LVRSoTPgsUaaNuSe2C7mr2g==;7:Z4AVvrEN4A9KHrPblstLj9AblAb3AZ3sY5UIckNUdZxwWAHgx13NfsNHO8w4xr7xEfK8hutVJzyH+6G2xOTPNA47vb2z4kuy5BMtfi8Pzqb23O7JjKIzOYecX5lbgd8KJCEYnUYuDJFVrJuoilkqHA==
x-ms-office365-filtering-correlation-id: 7d59033e-1602-4d6e-3dec-08d68a88db67
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1473;
x-ms-traffictypediagnostic: BN6PR11MB1473:
x-microsoft-antispam-prvs: <BN6PR11MB1473043B94E62883CCDF42B0F06D0@BN6PR11MB1473.namprd11.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(346002)(396003)(39860400002)(199004)(189003)(52116002)(8676002)(478600001)(2906002)(26005)(2501003)(186003)(50226002)(53936002)(4326008)(81156014)(316002)(66066001)(8936002)(3846002)(81166006)(6116002)(1076003)(386003)(6506007)(106356001)(68736007)(6436002)(6512007)(39060400002)(76176011)(102836004)(107886003)(71200400001)(54906003)(71190400001)(105586002)(476003)(99286004)(36756003)(7736002)(14444005)(6486002)(97736004)(446003)(11346002)(14454004)(2616005)(86362001)(305945005)(7416002)(256004)(72206003)(486006)(110136005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1473;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XUpVO30+kh48jfYrjoEIliPwdHdkY80mG9vFbmoUqA5pnqyu/MizIgig+3WWhiKmW+4PAwkhErTUQAn92pAhiFISg5SqoQnhR1BTXoKKjo22yv3/p59bUFyiFkcAx8tQAXwuO7nGeUb+Q14gBBxiBOd7xZNluo6rDO5J/syqFAOPsdF1V0c9evYhzbi2vAgpO2HO3q4eBcqqPfmsJc+IB/tle6KOTUeCXmIwSnm/UdRuE5SfVLq/pi6IXKa0rMuDK+3taanVP2Nyr6BIV7XZAk7gXr9ThMmoaAQjhfhE2HDRbd9DlT+jO+/VH5O6DgnvqqlqMCBzY//jzXZJguE6ATLsMl4klEYjAySvE3/RWgHvYrGQTLSPBPoEyjZwWIH1SqL6P8BrgyZWD1v0tW2E/z2aW5yTd/m9QQc4HFBvX/M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d59033e-1602-4d6e-3dec-08d68a88db67
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 10:09:29.4734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1473
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Let general names to core drivers.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v4: collect R-b
v3: no change
v2: update after the removing of iomem access wrappers
 drivers/spi/atmel-quadspi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index c745e75b755e..be1d1ba7898c 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -158,14 +158,14 @@ struct atmel_qspi {
 	struct completion	cmd_completion;
 };
=20
-struct qspi_mode {
+struct atmel_qspi_mode {
 	u8 cmd_buswidth;
 	u8 addr_buswidth;
 	u8 data_buswidth;
 	u32 config;
 };
=20
-static const struct qspi_mode sama5d2_qspi_modes[] =3D {
+static const struct atmel_qspi_mode sama5d2_qspi_modes[] =3D {
 	{ 1, 1, 1, QSPI_IFR_WIDTH_SINGLE_BIT_SPI },
 	{ 1, 1, 2, QSPI_IFR_WIDTH_DUAL_OUTPUT },
 	{ 1, 1, 4, QSPI_IFR_WIDTH_QUAD_OUTPUT },
@@ -175,8 +175,8 @@ static const struct qspi_mode sama5d2_qspi_modes[] =3D =
{
 	{ 4, 4, 4, QSPI_IFR_WIDTH_QUAD_CMD },
 };
=20
-static inline bool is_compatible(const struct spi_mem_op *op,
-				 const struct qspi_mode *mode)
+static inline bool atmel_qspi_is_compatible(const struct spi_mem_op *op,
+					    const struct atmel_qspi_mode *mode)
 {
 	if (op->cmd.buswidth !=3D mode->cmd_buswidth)
 		return false;
@@ -190,12 +190,12 @@ static inline bool is_compatible(const struct spi_mem=
_op *op,
 	return true;
 }
=20
-static int find_mode(const struct spi_mem_op *op)
+static int atmel_qspi_find_mode(const struct spi_mem_op *op)
 {
 	u32 i;
=20
 	for (i =3D 0; i < ARRAY_SIZE(sama5d2_qspi_modes); i++)
-		if (is_compatible(op, &sama5d2_qspi_modes[i]))
+		if (atmel_qspi_is_compatible(op, &sama5d2_qspi_modes[i]))
 			return i;
=20
 	return -1;
@@ -204,7 +204,7 @@ static int find_mode(const struct spi_mem_op *op)
 static bool atmel_qspi_supports_op(struct spi_mem *mem,
 				   const struct spi_mem_op *op)
 {
-	if (find_mode(op) < 0)
+	if (atmel_qspi_find_mode(op) < 0)
 		return false;
=20
 	/* special case not supported by hardware */
@@ -236,7 +236,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, cons=
t struct spi_mem_op *op)
 		aq->mr =3D QSPI_MR_SMM;
 	}
=20
-	mode =3D find_mode(op);
+	mode =3D atmel_qspi_find_mode(op);
 	if (mode < 0)
 		return -ENOTSUPP;
=20
--=20
2.9.5

