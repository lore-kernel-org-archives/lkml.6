Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E46C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C82D21850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mnu1VmZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbeLSKMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:12:08 -0500
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:1377
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728714AbeLSKMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:12:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25dCj8hGlS15x+/9/sEtYrejSY//XTbc6QCkFRpG/4w=;
 b=Mnu1VmZcewhOAWkeg/CVdvfXBVNbKICVqOCIkDWDjCaYy3rKHeT+b+YShGMBO86j+9xnCLIMgy9kfS3rx5/o0WgAREpr2MoyPE4p1UMcCdxJLNZXCy2iIZyAqgYQjuwtEvZWff352cSJfUYEdJqqKjgERctmSC2KC/nHK7+ULVg=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB6096.eurprd04.prod.outlook.com (20.179.25.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Wed, 19 Dec 2018 10:12:02 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175%3]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 10:12:02 +0000
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
Subject: [PATCH v6 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Topic: [PATCH v6 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Index: AQHUl4NIuN4Xv5agnkiSp4/lDdT57Q==
Date:   Wed, 19 Dec 2018 10:12:01 +0000
Message-ID: <1545214186-16987-4-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:3:17::21) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB6096;6:zsjZV1J2NDAB0s1a50NAxu6UE7P238LhK9/Vd7dfdMeo46N4tEahSdrDJ7xQRajHSmubdf9yOx9s3tsNLIOlt3fsOjlQdiL87Ea/gENhDiB50ppUsUuThSMhGsrd0XX3mSm28GyLm/yXKRQ6PdFl1a65wxFaMaguWubxyny+7VgP3QrEGyQ2WOl9ATOu2FRbNqBW2vgkHs/px0j3YNxTUJagFHcNsFxzUtuS/FAoPc+mArq1j3aTErgIXR87AywKgYg3pQsWe7Yog5+2QC7lx4tbayBuk6M9EnnxIjFeII4oBPWSdXcFzOWm6s6Fqh8ncbXXeF1z+MMkQ4lw0Xye26l3SfLIqp1goN0c1+4NEbOB7KCxM4Ne6I2Jqkmr85UDkHNF2c0LTD1X85UgBTxUjsF4DpLT7mSm6nqSyyi5pCvUNkOAicF2oP2CHFPaDazMM1TM5zrxXUBPhfpLLmnoaA==;5:K+inu1nm2LcKUsddAgKZ9RrdWEkfvwuuZL9jQV9g3USiQRZqF2fpOq2ri+4BvNXMJe0scRgJl8mIjNT7LsE5rxJloEWQ+s7hDJRHjPS1kglVLpjV4HXPddsAp7Mk8eBRrFdh/TgyEEBxDjOTaxEZgTUM5/sqwOR4YKmS/PiL9NU=;7:XQCTZ2aY9WC+viI352nnMjKdmRviFvXGisqIf2M6J5MhJNODYuWNUyYqNVtnhfoc2uCvEu90hg1SD6q3kfdnUj4nHfurL/Nrm5N1sAYXam5csIiiZRJ87/PG17UmpQ/gLNiY2IBqYv8qLakXYaarvA==
x-ms-office365-filtering-correlation-id: 5d4a77ae-142b-48ea-5456-08d6659a6af5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6096;
x-ms-traffictypediagnostic: VI1PR04MB6096:
x-microsoft-antispam-prvs: <VI1PR04MB6096D1D88CFAFE3F41B20DE399BE0@VI1PR04MB6096.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB6096;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB6096;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(39860400002)(396003)(136003)(346002)(366004)(189003)(199004)(52116002)(316002)(6116002)(2906002)(76176011)(5660300001)(256004)(53936002)(305945005)(68736007)(81166006)(6512007)(3846002)(66066001)(7416002)(446003)(2616005)(8676002)(81156014)(11346002)(99286004)(97736004)(476003)(486006)(478600001)(14454004)(8936002)(78486014)(25786009)(36756003)(2501003)(6436002)(2201001)(39060400002)(4326008)(54906003)(6486002)(575784001)(106356001)(86362001)(105586002)(102836004)(26005)(71190400001)(110136005)(6506007)(7736002)(186003)(386003)(71200400001)(55236004)(21314003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6096;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RjXjquseOSXBdTjRMXjPUbB/OXh6ZPUsJd7mUNrWyHmsUDM9CFcFS1EDbOeJG/Tw2Kszbbj0tKcglHLxrCZ2MP2QqOxLIvZrkzb+WZFY2ZLrb+C+4mgfwWzj4ts92GiiE/Xwfb0tXjI11XTjS8GNk99SQ0LgCOSITepARxRcKNilyS58RCMZZFAQZ2DrjiezTUIjI4xgZZlvAfPvXQSJAXpG3U0ZdrXlNJrwbD297sOhZrJc6FAnNVeyuMiheOL7HCmkcLsm8cehOrMpG1eOcwBAUGbBbLkTdjVUEJHC/VQbHEvdHdxir5/8EqAZYMvj
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4a77ae-142b-48ea-5456-08d6659a6af5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 10:12:02.0367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add opcodes for octal I/O commands
  * Read  : 1-1-8 and 1-8-8 protocol
  * Write : 1-1-8 and 1-8-8 protocol
  * opcodes for 4-byte address mode command

- Entry of macros in _convert_3to4_xxx function

- Add flag specifying flash support octal read commands.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v6:
- Correct S-o-b tag with full author name as 'Yogesh Narayan Gaur'.
Changes for v5:
- Modified string 'octo' with 'octal'.
Changes for v4:
- None
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- Incorporated review comments of Boris and Vignesh

 drivers/mtd/spi-nor/spi-nor.c | 16 ++++++++++++++--
 include/linux/mtd/spi-nor.h   | 16 ++++++++++++----
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 6e13bbd..872d707 100644
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
index fa2d89e..2353af8 100644
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
2.7.4

