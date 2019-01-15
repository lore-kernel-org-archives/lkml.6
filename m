Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA501C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D01120651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dw52r3Yd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfAOKFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:05:33 -0500
Received: from mail-eopbgr10087.outbound.protection.outlook.com ([40.107.1.87]:38816
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727221AbfAOKFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzyxst+PTiRkkAIdab37IGTQhp9IR4kHAFdInXWUMeo=;
 b=Dw52r3YdG4xIHsOgVJG9ECPwGEHXrFFJ+Me/8GR/Fe8B3zmqTftH0MdFTsd7Bd+ip53Jz6j89QeAS4VqKdv9qiVcPklA9egx1Uk+my4HdN6x6T2gwDFp1MtOdYC6zTeRgdNtqUMPK1whfwkEPlYod94/wwa/Bqmgr/1E2vvMNnA=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1SPR01MB10.eurprd04.prod.outlook.com (10.170.239.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Tue, 15 Jan 2019 10:05:10 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 10:05:10 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v7 1/5] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Topic: [PATCH v7 1/5] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Index: AQHUrLnM7+Ij20wb5EO5zed9O3cV1w==
Date:   Tue, 15 Jan 2019 10:05:10 +0000
Message-ID: <1547546584-5254-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0123.apcprd06.prod.outlook.com
 (2603:1096:1:1d::25) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1SPR01MB10;6:oRWgzD5By+dTE8v80PgBDlw7ZF6JwnYkMvlXj46EkcV0qHUurBbnkyF4RTyjMLiCEE+azfmxKmscu1lw1O5mnmeqfU/48NtyUVLd3buy7OCsr6dHlMzy02X49lOrC/ZAONn60b1IoXa4eXcntoLZ6DUWCoB7qzaDufNcG7KEngBtLIkrvHf+nNkYK1/askvn22Ya2VXJodaYL6UGkIsdcBf1IASjdIKGFXB1ElkgaOGrf2teTd+DS9+CVq1+bp/iwOHKhTV+nsi88I147psDXhD4IJF7t5uIegNkjACp52Jl+UxyIeaBzEDG0mk4dp2+zwnKLnDVbn/SZj0L2bSPulE+72cFzCno03bcy6C9ee61qxp4XP6Y8JZfKv+qc45veFebb6Gqd1ZivD3MQzT/kxUZ7F52by1DOUxIqtwXu7u6CpbvpVeUf9Zi5qzkowABCj82PQt4OZdwPYk4z3RYsg==;5:m/t5+/BE63SfVlIrDmBxkOaW2QzJtjk/mq/43vTpKF+FrRTQbTYrxb2+O7mFykYhnPrzWmS5qM3F0jp0TWGqLCXZbbe3EBFhy0hw5TUSAaTmZT0HOkBHzjIO4qH7VelB8wM7KlNlCW+fFnOjinreC60zMicRFR6ojFMXSAZ3XVKeOXAWGStWDPsiUnDNAbkbbZsnZb/HPVgBZOklnv/COg==;7:o4QXDcK2mPryXRhX/+qqYiqrNe695mgjP/CoKWHBqsil1F/dpYYVsOij0eOaatb/EU9BtHpUVeirG55KMMPeIikwH3R7zN1tA9wqqsuwgiNNYPw6+vdaI+07aEekrEWInegX9v/CpsEFOX3KjQOWIw==
x-ms-office365-filtering-correlation-id: ccd3a162-7306-4c21-75d8-08d67ad0eef8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1SPR01MB10;
x-ms-traffictypediagnostic: VI1SPR01MB10:
x-microsoft-antispam-prvs: <VI1SPR01MB10377124BAC8FC05490D2C99810@VI1SPR01MB10.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(136003)(396003)(346002)(199004)(189003)(6486002)(97736004)(2501003)(6506007)(386003)(316002)(53936002)(55236004)(102836004)(5660300001)(106356001)(105586002)(68736007)(52116002)(36756003)(76176011)(86362001)(11346002)(71200400001)(3846002)(71190400001)(2906002)(446003)(6512007)(256004)(486006)(14454004)(2616005)(476003)(7416002)(78486014)(99286004)(25786009)(8676002)(6346003)(81166006)(81156014)(186003)(4326008)(2201001)(6436002)(8936002)(26005)(478600001)(66066001)(54906003)(305945005)(39060400002)(6116002)(110136005)(50226002)(7736002)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1SPR01MB10;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qHzJHsnm5lj2uVr/LFdqQZVZB2H78xNBopzemxYNjbnhjy+ONvdgRQn+0vEbGwwJMy+o6JQBTnTRVb/sX/8nR52Ny8AqTC29LRI/YzQN1o+LC0hz9OiSU3g6dsFW2XaZA1dKFLawGaMvWaiHuEEY6+htdIK8kfD+g6+TCha0NPjhXak6/5QxS33UAQ/GmFutMiX+bl5IYDqmyOgs5x6q3TO/tMAdDPhDN40PbAY+PyZjffpOMJIq+4FudAuD0h+MvdNAkzaqbE02WtURdb2MzFF/zw7bVDdQSNl6zcXzCR7hr3B0ri97trPP2oeOxSxUYIg2rixb5VXBjH9eFc7mPAMvL02lzZDH5fObZEq9Xm8TP9XTxh4ZH37hOmTxrDtb8IXmS3uGu10RChtdYgUe2iWggtD9q3ey1mTv5DqFvVQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd3a162-7306-4c21-75d8-08d67ad0eef8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 10:05:04.5705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR01MB10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add opcodes for octal I/O commands
  * Read  : 1-1-8 and 1-8-8 protocol
  * Write : 1-1-8 and 1-8-8 protocol
  * opcodes for 4-byte address mode command

- Entry of macros in _convert_3to4_xxx function

- Add flag SPI_NOR_OCTAL_READ specifying flash support octal read
  commands. This flag is required for flashes which didn't provides
  support for auto detection of Octal mode capabilities i.e. not
  seems to support newer JESD216C standard.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 16 ++++++++++++++--
 include/linux/mtd/spi-nor.h   | 16 ++++++++++++----
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 6e13bbd1aaa5..872d70722672 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -68,7 +68,7 @@ enum spi_nor_read_command_index {
 	SNOR_CMD_READ_4_4_4,
 	SNOR_CMD_READ_1_4_4_DTR,
=20
-	/* Octo SPI */
+	/* Octal SPI */
 	SNOR_CMD_READ_1_1_8,
 	SNOR_CMD_READ_1_8_8,
 	SNOR_CMD_READ_8_8_8,
@@ -85,7 +85,7 @@ enum spi_nor_pp_command_index {
 	SNOR_CMD_PP_1_4_4,
 	SNOR_CMD_PP_4_4_4,
=20
-	/* Octo SPI */
+	/* Octal SPI */
 	SNOR_CMD_PP_1_1_8,
 	SNOR_CMD_PP_1_8_8,
 	SNOR_CMD_PP_8_8_8,
@@ -278,6 +278,7 @@ struct flash_info {
 #define NO_CHIP_ERASE		BIT(12) /* Chip does not support chip erase */
 #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
 #define USE_CLSR		BIT(14)	/* use CLSR command */
+#define SPI_NOR_OCTAL_READ	BIT(15)	/* Flash supports Octal Read */
=20
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
@@ -398,6 +399,8 @@ static u8 spi_nor_convert_3to4_read(u8 opcode)
 		{ SPINOR_OP_READ_1_2_2,	SPINOR_OP_READ_1_2_2_4B },
 		{ SPINOR_OP_READ_1_1_4,	SPINOR_OP_READ_1_1_4_4B },
 		{ SPINOR_OP_READ_1_4_4,	SPINOR_OP_READ_1_4_4_4B },
+		{ SPINOR_OP_READ_1_1_8,	SPINOR_OP_READ_1_1_8_4B },
+		{ SPINOR_OP_READ_1_8_8,	SPINOR_OP_READ_1_8_8_4B },
=20
 		{ SPINOR_OP_READ_1_1_1_DTR,	SPINOR_OP_READ_1_1_1_DTR_4B },
 		{ SPINOR_OP_READ_1_2_2_DTR,	SPINOR_OP_READ_1_2_2_DTR_4B },
@@ -414,6 +417,8 @@ static u8 spi_nor_convert_3to4_program(u8 opcode)
 		{ SPINOR_OP_PP,		SPINOR_OP_PP_4B },
 		{ SPINOR_OP_PP_1_1_4,	SPINOR_OP_PP_1_1_4_4B },
 		{ SPINOR_OP_PP_1_4_4,	SPINOR_OP_PP_1_4_4_4B },
+		{ SPINOR_OP_PP_1_1_8,	SPINOR_OP_PP_1_1_8_4B },
+		{ SPINOR_OP_PP_1_8_8,	SPINOR_OP_PP_1_8_8_4B },
 	};
=20
 	return spi_nor_convert_opcode(opcode, spi_nor_3to4_program,
@@ -3591,6 +3596,13 @@ static int spi_nor_init_params(struct spi_nor *nor,
 					  SNOR_PROTO_1_1_4);
 	}
=20
+	if (info->flags & SPI_NOR_OCTAL_READ) {
+		params->hwcaps.mask |=3D SNOR_HWCAPS_READ_1_1_8;
+		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_8],
+					  0, 8, SPINOR_OP_READ_1_1_8,
+					  SNOR_PROTO_1_1_8);
+	}
+
 	/* Page Program settings. */
 	params->hwcaps.mask |=3D SNOR_HWCAPS_PP;
 	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP],
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index fa2d89e38e40..2353af8bac99 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -46,9 +46,13 @@
 #define SPINOR_OP_READ_1_2_2	0xbb	/* Read data bytes (Dual I/O SPI) */
 #define SPINOR_OP_READ_1_1_4	0x6b	/* Read data bytes (Quad Output SPI) */
 #define SPINOR_OP_READ_1_4_4	0xeb	/* Read data bytes (Quad I/O SPI) */
+#define SPINOR_OP_READ_1_1_8	0x8b	/* Read data bytes (Octal Output SPI) */
+#define SPINOR_OP_READ_1_8_8	0xcb	/* Read data bytes (Octal I/O SPI) */
 #define SPINOR_OP_PP		0x02	/* Page program (up to 256 bytes) */
 #define SPINOR_OP_PP_1_1_4	0x32	/* Quad page program */
 #define SPINOR_OP_PP_1_4_4	0x38	/* Quad page program */
+#define SPINOR_OP_PP_1_1_8	0x82	/* Octal page program */
+#define SPINOR_OP_PP_1_8_8	0xc2	/* Octal page program */
 #define SPINOR_OP_BE_4K		0x20	/* Erase 4KiB block */
 #define SPINOR_OP_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips */
 #define SPINOR_OP_BE_32K	0x52	/* Erase 32KiB block */
@@ -69,9 +73,13 @@
 #define SPINOR_OP_READ_1_2_2_4B	0xbc	/* Read data bytes (Dual I/O SPI) */
 #define SPINOR_OP_READ_1_1_4_4B	0x6c	/* Read data bytes (Quad Output SPI) =
*/
 #define SPINOR_OP_READ_1_4_4_4B	0xec	/* Read data bytes (Quad I/O SPI) */
+#define SPINOR_OP_READ_1_1_8_4B	0x7c	/* Read data bytes (Octal Output SPI)=
 */
+#define SPINOR_OP_READ_1_8_8_4B	0xcc	/* Read data bytes (Octal I/O SPI) */
 #define SPINOR_OP_PP_4B		0x12	/* Page program (up to 256 bytes) */
 #define SPINOR_OP_PP_1_1_4_4B	0x34	/* Quad page program */
 #define SPINOR_OP_PP_1_4_4_4B	0x3e	/* Quad page program */
+#define SPINOR_OP_PP_1_1_8_4B	0x84	/* Octal page program */
+#define SPINOR_OP_PP_1_8_8_4B	0x8e	/* Octal page program */
 #define SPINOR_OP_BE_4K_4B	0x21	/* Erase 4KiB block */
 #define SPINOR_OP_BE_32K_4B	0x5c	/* Erase 32KiB block */
 #define SPINOR_OP_SE_4B		0xdc	/* Sector erase (usually 64KiB) */
@@ -458,7 +466,7 @@ struct spi_nor_hwcaps {
 /*
  *(Fast) Read capabilities.
  * MUST be ordered by priority: the higher bit position, the higher priori=
ty.
- * As a matter of performances, it is relevant to use Octo SPI protocols f=
irst,
+ * As a matter of performances, it is relevant to use Octal SPI protocols =
first,
  * then Quad SPI protocols before Dual SPI protocols, Fast Read and lastly
  * (Slow) Read.
  */
@@ -479,7 +487,7 @@ struct spi_nor_hwcaps {
 #define SNOR_HWCAPS_READ_4_4_4		BIT(9)
 #define SNOR_HWCAPS_READ_1_4_4_DTR	BIT(10)
=20
-#define SNOR_HWCPAS_READ_OCTO		GENMASK(14, 11)
+#define SNOR_HWCPAS_READ_OCTAL		GENMASK(14, 11)
 #define SNOR_HWCAPS_READ_1_1_8		BIT(11)
 #define SNOR_HWCAPS_READ_1_8_8		BIT(12)
 #define SNOR_HWCAPS_READ_8_8_8		BIT(13)
@@ -488,7 +496,7 @@ struct spi_nor_hwcaps {
 /*
  * Page Program capabilities.
  * MUST be ordered by priority: the higher bit position, the higher priori=
ty.
- * Like (Fast) Read capabilities, Octo/Quad SPI protocols are preferred to=
 the
+ * Like (Fast) Read capabilities, Octal/Quad SPI protocols are preferred t=
o the
  * legacy SPI 1-1-1 protocol.
  * Note that Dual Page Programs are not supported because there is no exis=
ting
  * JEDEC/SFDP standard to define them. Also at this moment no SPI flash me=
mory
@@ -502,7 +510,7 @@ struct spi_nor_hwcaps {
 #define SNOR_HWCAPS_PP_1_4_4	BIT(18)
 #define SNOR_HWCAPS_PP_4_4_4	BIT(19)
=20
-#define SNOR_HWCAPS_PP_OCTO	GENMASK(22, 20)
+#define SNOR_HWCAPS_PP_OCTAL	GENMASK(22, 20)
 #define SNOR_HWCAPS_PP_1_1_8	BIT(20)
 #define SNOR_HWCAPS_PP_1_8_8	BIT(21)
 #define SNOR_HWCAPS_PP_8_8_8	BIT(22)
--=20
2.17.1

