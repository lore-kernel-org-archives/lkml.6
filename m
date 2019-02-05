Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F7EC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC59217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="DV2ubNUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbfBEPn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:43:26 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:27289 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbfBEPnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:43:24 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="24251458"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Feb 2019 08:43:24 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Feb 2019 08:43:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ht43FQ77Lmyxhf1sVDttNDicbrRKvELTpHO8as+4GqE=;
 b=DV2ubNUXawxXOEzzIKrSR4jaM7DNI7L2G3cdRhW66pxkbUOmt9leZOPlwX9hrJIxb0/2Pjyuh2/EcW02J5mqYUwnOO85HYyIilgjvgq2OC8CRl6nC2WkakgMV9bW0lvi9uF3CUmeKulyyt0w43LUoOBKm9pE61Pa2O2Hunp/oNU=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB2020.namprd11.prod.outlook.com (10.173.26.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 5 Feb 2019 15:43:21 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 15:43:21 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v5 04/13] spi: atmel-quadspi: fix naming scheme
Thread-Topic: [PATCH v5 04/13] spi: atmel-quadspi: fix naming scheme
Thread-Index: AQHUvWmFOi5CtcF1/UOwV1ikG9gvYA==
Date:   Tue, 5 Feb 2019 15:43:21 +0000
Message-ID: <20190205154257.29529-5-tudor.ambarus@microchip.com>
References: <20190205154257.29529-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190205154257.29529-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB2020;6:G0qtiNKAzF2OecD/N4rXTVEdRmqhaxdY0uGwD1tUpyvs8ZULp6AGkCCTFL0EUtAx7rEnJ5UiYEZO8Nsh0z0pydfJ+5nsaHBMAumYsrNRTSRJy6mKlyKkXZx2W4PE9isM4v49LmM/yw0XAL2765IEVnJlqUhO/JLHyDJDK1YODBgoO8mzmlMgAXZfXoHHMsTvDY8+uZqULfpPjoVwSBt7Lnxan3tApwFAQJHAzFupwsfzLKRua9UGTXdNx3HUmczVklYhNUchjV58GtH1hqPD8u3itTmgYPaexllbDZKXh6jkrvry/Iwult4YQ498LuAvsqBh6nQAX//6rD0fFI46oY3Kgb/PWMPKZVTa16tljEi6S5QM+RpchGGtTk+4I7sSU5Ir9yJ86+pGkgnOLIc3o1UjnpsAvWSl+lw2xnb6bqajzKAvCaEsx42+z2OWMh8SOMhoG/BB3rj+l1RwcRNwgw==;5:JjR50F9DLTwh2XWRAmaRL4EhLICPlUOUCJdpQq78m/0zONTK7ZJ4SJG3htWuEGBOUpF9TfIq7RdJL7hyLI1ZXVLlHE3gZ6Yjy6sEGjCIk2aw10lMeU5szoXKvll2cK9YhZ2FOtjXkPrPYGsSXGZ1wDxgjvExJOi/y+zK+/rylTsRAL7s9eaVHjjfqpkctP9qowG4MdtvjwrBKdNovi0Bug==;7:LMsujZX79kdEUEt+uQcIgnAOOGWn7r8asOlBoz8RH1EMSSugdUASl55wFMgSSnD3xtD/iCe5misyhSEuyoDSksC4CmdYWEuKdDrSphhjHHWkQ4ByBZgDgs+6EPSHZeeEMGnnqyzyIL1x/JiNaGZOUg==
x-ms-office365-filtering-correlation-id: b353fb04-41c8-41d1-9b17-08d68b80a781
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB2020;
x-ms-traffictypediagnostic: BN6PR11MB2020:
x-microsoft-antispam-prvs: <BN6PR11MB202021A8270741E3A32CB57BF06E0@BN6PR11MB2020.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(366004)(396003)(199004)(189003)(107886003)(6116002)(3846002)(4326008)(8676002)(305945005)(7736002)(2906002)(81156014)(14454004)(2501003)(1076003)(7416002)(81166006)(8936002)(50226002)(52116002)(86362001)(99286004)(6512007)(106356001)(36756003)(71200400001)(71190400001)(25786009)(68736007)(53936002)(11346002)(2616005)(486006)(446003)(186003)(105586002)(102836004)(6436002)(316002)(6506007)(386003)(478600001)(66066001)(54906003)(110136005)(76176011)(72206003)(14444005)(256004)(97736004)(476003)(26005)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB2020;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jqRp1+94qUk6EBXzDdAje42LSYMIemACV0x89vXM479FSbt+aDF6H25WnErv+oFF7XTRenTpH89b/zlH8bOcobT2Dq0lYpLLWGzqeCe0INXbdTB2xc31yKQjow/f9tupXsqralM6LruFxndiA41Srd06K8lzPCVtnZ74KjGBAEdCtt+T8AJlnqkB/MBsPseYxsebO7Gdogi72UOYyCv+Y1dRtx5Eo8z3VcCYD5yH5YmeP2eUFOdJyIqWwBYudvxPXrUcdeCbuWq2YAbtB51Pnt7KL3SZJvLBr6nY7LCTyAYnBATebCGhekvfGan9dBgesAlSsul64VT2KMDLm7GalxlY+EeBzLdqcT4lH+ZfvuS2q6tA5y93CHbZRxyGhPTkqDSbCLb+hAj+8Elhgys5mIhumeUCIJnm31nvnChT+8Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b353fb04-41c8-41d1-9b17-08d68b80a781
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 15:43:17.8758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2020
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
v5: no changes
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

