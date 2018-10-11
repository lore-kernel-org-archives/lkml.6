Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED30C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4292085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="yJzgaFO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4292085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeJKPlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:41:55 -0400
Received: from mail-db5eur01on0044.outbound.protection.outlook.com ([104.47.2.44]:27765
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbeJKPlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sreQDWz7pMKn+fw5e70xFauAFue0JaWA0jL7S8T269s=;
 b=yJzgaFO+lEl6jCw4kHU8kmkUq4Jj8qcuSonGhyzAYQd2QCoJwtywzeNk0ynjTz/UWEalCkj9UB/iQCU7daRAw1JzXFid4xVA0EFCW8zFE1i2ci88g0onRs2aJIE2CDGiaz3vGNXUpkSP+weRzAulyGkuRPHqzRahRZ71D8ARIw8=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1294.eurprd04.prod.outlook.com (10.162.121.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Thu, 11 Oct 2018 08:15:40 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1207.024; Thu, 11 Oct 2018
 08:15:40 +0000
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
Subject: [PATCH v2 1/2] mtd: spi-nor: add macros related to MICRON flash
Thread-Topic: [PATCH v2 1/2] mtd: spi-nor: add macros related to MICRON flash
Thread-Index: AQHUYTqZJSSqGPTqb0+Lq8HmDDDYbQ==
Date:   Thu, 11 Oct 2018 08:15:40 +0000
Message-ID: <1539245630-26611-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539245630-26611-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1539245630-26611-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0088.apcprd06.prod.outlook.com
 (2603:1096:3:14::14) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1294;6:SQUeJRr5vcWC3tp564RX2u77kaCkg2VGI0KBiiaXGo2pH3ySLtnTrOiFp+UX+sywYs2m1ECbYZvwDfl5ail4PXlpeeKoSnVW5qlFrJc5xYOg+gSlJimC5mcDvsFInfcg0cCv0RWVVLIRgYc/XLRtTKKlnf3AL90DnHRJpdm4YZYfmwkNuOQAZXXrpEv6DnT+eOGeyORwJmfUC8crGnUWwhZTLeyATy382hqJ1vjJUW69YZJ2EinAlDKb9+ZqGUPRId2XJKdE564fbxbvGHPB03Bv/f9ylaeMCZaKxwY05a1BUt7lfoV3vTwV4OH+po2nsstU7pVPw8URymGYqGhuqglBJuQViIvWl4qDKyPSU95+bjolZ3OyGOFmCrDKAwZvOZarhZWI6T362iuuN+UGh04VqHw+yXctezbFgg5yjRJ2WgA5jXGfvbn5RqpQ73wUwniK2/aJN5L83xtceDVRWQ==;5:3r4tSmzQX6B4oVk6IPNOPVZwj9Y05Nd2fCfLoguLwnduREF4xSbsUcK/nEQmNnm+TPkG0MChEzkADp7u3hWO8wn8w+R95zkPXg5AMw4px5eYIVX1xs1Seq1sQghv/QjthBUo9K9mcBIOHi9ZSmpG0wQUqcRtwOSSZ7AUy/++vBc=;7:e2dqeo/fOu3KS+USMCqnBuZ+40V4RcxPwNCeQ8Rw8q5Y5JgkchpOaaOFQgdqma/AplwtNIbGJlTtpxkjnEnKk+UXtOVZ9gnVbCTponC9AV3oIoGktdBOEcWwcE2rG+qO2YrpcNIfJC76ZZLfiMexuIxceEW9v39pcjOuDjTTtq5dWSQcyh3e3bdFAcYAqLuysDy1T/khPOgCUZMZUWqzvXEdVXRBRP0UkKDy7+c9zkAMxAAsKSMOHPs5PlpzJst3
x-ms-office365-filtering-correlation-id: de07ccf0-3790-4801-31eb-08d62f51bb2b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1294;
x-ms-traffictypediagnostic: VI1PR04MB1294:
x-microsoft-antispam-prvs: <VI1PR04MB129440941EB72AA7F01BC6A599E10@VI1PR04MB1294.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991055);SRVR:VI1PR04MB1294;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1294;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(346002)(396003)(39860400002)(189003)(199004)(6116002)(7736002)(36756003)(305945005)(7416002)(97736004)(3846002)(316002)(6486002)(4326008)(39060400002)(106356001)(25786009)(66066001)(14454004)(2501003)(5250100002)(2900100001)(110136005)(76176011)(105586002)(256004)(478600001)(6512007)(186003)(14444005)(6346003)(102836004)(54906003)(5660300001)(26005)(52116002)(55236004)(11346002)(8936002)(99286004)(6506007)(575784001)(81166006)(81156014)(2616005)(446003)(71190400001)(68736007)(2201001)(86362001)(6436002)(2906002)(53936002)(8676002)(386003)(71200400001)(486006)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1294;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-microsoft-antispam-message-info: 1y7vIOqAMInmFz+5QNJiZiYSZpmKd29PR/fFmCD2BHTboMwMmfZYdElWO9TOyz6CT0J69tas9r4MBPZ+uHOYLb/Px/koZe13r+NS3APDj4OjQYeM/SQN0HMTpmIa4z6TPJzLKVuecOpdEV5glV160HjQ+9UwVe6hEwvsPiSWqd2dVwSdd1+Uf/6Br0Xfa6dOiECLIZ/QCvEJsZoeYMn3ESewev6sd0dSwjSf59dUeoR4MOTW2NT13cqr5Dodjh7uNSn8BaeGiaJ4mIg0FiixxdbKCTscxy++y3gZNXbI8lh2tcKNPoMC0OMqJKPjLzkDNKtcb7Ipk8qBTH2fI+/a7nbaTceSPZuwlAW6bWaPWz8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de07ccf0-3790-4801-31eb-08d62f51bb2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 08:15:40.6499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1294
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
@@ -1388,7 +1389,7 @@ static const struct flash_info spi_nor_ids[] =3D {
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
2.7.4

