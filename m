Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1293FC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 02:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BAA2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 02:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r9g2sajg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BAA2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJLJxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 05:53:17 -0400
Received: from mail-eopbgr20079.outbound.protection.outlook.com ([40.107.2.79]:35156
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbeJLJxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 05:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RR0fheseJS0Y34ZsDi2qOtZxgYYYJ91yfATJyKCgE0=;
 b=r9g2sajg13ge7h5knglk8845vm1ToZ+WptfdMDn51AvcVAAGhLILufgrKOsXJAZSQ+YgD63VZRtbLPv7Aro45Zo1agCuNZawI7b/4eMkV3Fhf+W94LykF6QVR3bOHF6iQppkQwRPDPF2uhWdGyu6ZBVlAuzIv7AfHNHnnGUHLdE=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1166.eurprd04.prod.outlook.com (10.162.121.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Fri, 12 Oct 2018 02:23:08 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1207.024; Fri, 12 Oct 2018
 02:23:08 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>
CC:     "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v3 1/2] mtd: spi-nor: add macros related to MICRON flash
Thread-Topic: [PATCH v3 1/2] mtd: spi-nor: add macros related to MICRON flash
Thread-Index: AQHUYdKDjlmkWwN6/UiXD412Qj9EqQ==
Date:   Fri, 12 Oct 2018 02:23:08 +0000
Message-ID: <1539310881-17438-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539310881-17438-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1539310881-17438-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1166;6:XyvNcEycB0wjFBhwPhoKxoZpzNswgIeorUh3Sr4zOdqmwQWZKMtjvoQ90iPoIzYX0UmBxSn5NNLe5pRWAUMvuKY6dYv9kx+CqywJOVeghjve1V6CXK4JyYBY8o6u0eEepLO+LGFn5a5/LFSWFxSEm1BUwPNHsGnPbvWVJ7N8wg95SXnyOA1MtpgtotvvtjIf0fk9b1pvwV7RGK6YKLAZ+W48UVWOy334e0jyzbgXy0wAonbyl8OeAnS+xhTLyRTLwdRQkz+8xVpQTvuzg4nz+h0BI52oh2OGzLfvnzgXpre4drGYukk6dobJBprYr4ukjnQtHaNQFjkyhoUK9EwD3OfNQKidUtGPY375+Xop5Rk/ZteY0alO797cZNMGXLa5qCa8DbhCRIUuG3GTaURj1+PNAznGKFubn9I+qQlSpUJy2zByc78XmmhO0e3vTZI0336EsfWn7WXMU2iZLpQ7nw==;5:k2widBcZAxgcAh2nxKzjfDWyO73ByveeWDvfYRy3txJlUAdg4Ra8PBpP5qoGOLFz1h9bGsDWhvOuGAugsm7G+/x6HVv1PDelmDLOCqwdlRqSToiHNALlrvW5rcxdY8P7kA2y5Y+m+ZxP1LHtoxLa5Pw/spNFJlo26jqRdQ5Nxak=;7:0ekpGVmpyr0LbZ4+vRA7BkIA2c47+MPKvxw/2yqWdFK4v/pdN08hj5XomGkGf1CyR1lv811YtNirJwsU0ZbO/xELEFCHzJ3ctnf8aisETcmuVW4LHFlflthi0K3Ddc/LmMbSb1kVCnehChSW1tc4mUwL16mEVHMdCJ/6WkqG2kaFACmp0rECwee9NnwB6pafT41qFqODu3QItuo6nyKoZGA25KhS9Xx4RUBGuVZkUdy5POmasdJcLUZEZtJ4uXuS
x-ms-office365-filtering-correlation-id: 1cbb3f47-b682-41d7-6bc4-08d62fe9a612
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1166;
x-ms-traffictypediagnostic: VI1PR04MB1166:
x-microsoft-antispam-prvs: <VI1PR04MB11668572F325760E83FC431D99E20@VI1PR04MB1166.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB1166;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1166;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(366004)(396003)(199004)(189003)(446003)(386003)(6506007)(486006)(55236004)(4326008)(53936002)(52116002)(11346002)(476003)(6436002)(25786009)(110136005)(54906003)(102836004)(99286004)(2616005)(6512007)(316002)(76176011)(66066001)(3846002)(2906002)(6116002)(97736004)(5660300001)(575784001)(86362001)(2201001)(2900100001)(5250100002)(2501003)(39060400002)(68736007)(305945005)(26005)(14454004)(36756003)(6486002)(81166006)(81156014)(256004)(8676002)(14444005)(8936002)(478600001)(71200400001)(7416002)(186003)(7736002)(106356001)(105586002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1166;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JlxuogUeQ4MbJCxEOlPxxaVYnDld6LezYOe7bnxu62+Z9WRSJWyDiHorkue3puudicY0aSfouQeDkDLYiW+JBVYQ1sMgflvT9SYVdRS/qM+r1Oz++xoxV4qsyIfqa4c3xPV32PotYPC/4YU0Ii1AwJkDTaLFu+QIRLW1hHk978HUeRlZxEfMzmSI6aBEcQDoQDKkzlviLew5J6ELCWHa5gJ/PXygseoV4QKEw5kAYTbD92B1q5D3ilz9Hhab9aCxflC0RUVAumIvvaXfP6eIQfkQu8S7k8ndsdPJJ/VqP6y6lfSbPUJQj5G+1PcWNkP58XaLjBLoBeZQLNaRRWzcATH7irIkrhXGGjndEP2Okpw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbb3f47-b682-41d7-6bc4-08d62fe9a612
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 02:23:08.5552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some MICRON related macros in spi-nor domain were ST.
Rename entries related to STMicroelectronics under macro SNOR_MFR_ST.

Added entry of MFR Id for Micron flashes, 0x002C.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
Changes for v3:
- None
Changes for v2:
- None

 drivers/mtd/spi-nor/spi-nor.c | 9 ++++++---
 include/linux/mtd/cfi.h       | 1 +
 include/linux/mtd/spi-nor.h   | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 9407ca5..b8b494f 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -284,6 +284,7 @@ static inline int set_4byte(struct spi_nor *nor, const =
struct flash_info *info,
 	u8 cmd;
=20
 	switch (JEDEC_MFR(info)) {
+	case SNOR_MFR_ST:
 	case SNOR_MFR_MICRON:
 		/* Some Micron need WREN command; all will accept it */
 		need_wren =3D true;
@@ -1388,7 +1389,7 @@ static int spi_nor_is_locked(struct mtd_info *mtd, lo=
ff_t ofs, uint64_t len)
 	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUA=
L_READ | SPI_NOR_QUAD_READ) },
 	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048, SPI_NOR_QUAD_READ) },
=20
-	/* Micron */
+	/* Micron <--> ST Micro */
 	{ "n25q016a",	 INFO(0x20bb15, 0, 64 * 1024,   32, SECT_4K | SPI_NOR_QUAD_=
READ) },
 	{ "n25q032",	 INFO(0x20ba16, 0, 64 * 1024,   64, SPI_NOR_QUAD_READ) },
 	{ "n25q032a",	 INFO(0x20bb16, 0, 64 * 1024,   64, SPI_NOR_QUAD_READ) },
@@ -3223,6 +3224,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 			params->quad_enable =3D macronix_quad_enable;
 			break;
=20
+		case SNOR_MFR_ST:
 		case SNOR_MFR_MICRON:
 			break;
=20
@@ -3671,8 +3673,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
 	mtd->_resume =3D spi_nor_resume;
=20
 	/* NOR protection support for STmicro/Micron chips and similar */
-	if (JEDEC_MFR(info) =3D=3D SNOR_MFR_MICRON ||
-			info->flags & SPI_NOR_HAS_LOCK) {
+	if (JEDEC_MFR(info) =3D=3D SNOR_MFR_ST ||
+	    JEDEC_MFR(info) =3D=3D SNOR_MFR_MICRON ||
+	    info->flags & SPI_NOR_HAS_LOCK) {
 		nor->flash_lock =3D stm_lock;
 		nor->flash_unlock =3D stm_unlock;
 		nor->flash_is_locked =3D stm_is_locked;
diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h
index 9b57a9b..cbf7716 100644
--- a/include/linux/mtd/cfi.h
+++ b/include/linux/mtd/cfi.h
@@ -377,6 +377,7 @@ struct cfi_fixup {
 #define CFI_MFR_SHARP		0x00B0
 #define CFI_MFR_SST		0x00BF
 #define CFI_MFR_ST		0x0020 /* STMicroelectronics */
+#define CFI_MFR_MICRON		0x002C /* Micron */
 #define CFI_MFR_TOSHIBA		0x0098
 #define CFI_MFR_WINBOND		0x00DA
=20
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 7f0c730..8b1acf6 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -23,7 +23,8 @@
 #define SNOR_MFR_ATMEL		CFI_MFR_ATMEL
 #define SNOR_MFR_GIGADEVICE	0xc8
 #define SNOR_MFR_INTEL		CFI_MFR_INTEL
-#define SNOR_MFR_MICRON		CFI_MFR_ST /* ST Micro <--> Micron */
+#define SNOR_MFR_ST		CFI_MFR_ST	/* ST Micro */
+#define SNOR_MFR_MICRON		CFI_MFR_MICRON	/* Micron */
 #define SNOR_MFR_MACRONIX	CFI_MFR_MACRONIX
 #define SNOR_MFR_SPANSION	CFI_MFR_AMD
 #define SNOR_MFR_SST		CFI_MFR_SST
--=20
1.9.1

