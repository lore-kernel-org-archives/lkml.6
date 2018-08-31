Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0C2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC9020837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xmwyPAAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC9020837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbeHaNEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:04:40 -0400
Received: from mail-ve1eur01on0045.outbound.protection.outlook.com ([104.47.1.45]:12752
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727705AbeHaNEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD0LOgJ0Ysxscp87Bb+YCfdKkxCcOFP+D56wT7bkoTE=;
 b=xmwyPAAPhrXgGTomYQcmBbeeh+r+h1oqNZyG4t9pJp8PulETPHV1Fe852GNRMwaSKzSrtsZt9mKLhoA+cXQyHOrYJKo0Dw5orJDdmSoO3PQ9/Y/JvXllF2mh1i0I38nkB9ZDus9i8B89LSnO/gkFvi12+bUjXzB6Txvx1MUzh+4=
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 HE1PR04MB1035.eurprd04.prod.outlook.com (2a01:111:e400:581a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Fri, 31 Aug
 2018 08:58:04 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com
Cc:     computersforpeace@gmail.com, frieder.schrempf@exceet.de,
        linux-kernel@vger.kernel.org, david.wolfe@nxp.com,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 1/2] mtd: spi-nor: add macros related to MICRON flash
Date:   Fri, 31 Aug 2018 14:26:02 +0530
Message-Id: <1535705763-26369-2-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535705763-26369-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1535705763-26369-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR0302CA0018.apcprd03.prod.outlook.com
 (2603:1096:3:2::28) To HE1PR04MB1035.eurprd04.prod.outlook.com
 (2a01:111:e400:581a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e7ee7fa-1d94-45bd-1a04-08d60f1fdefb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1035;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1035;3:kfl2Wps+pGcP/7V7yI/Ywsi1VZA/rIZSkW5YwChKIS6stENs2JmNGXx3ThVDh3D3rvYBjD4B5AUMMWmqbvXPbfTWJIgHNELWyVGgCzTttInHMvF+HH9DnigdwAsH2Pba6DvzGzg+rFRY15WmP1qqnHeSy+VtffJAIV9F3Gti4DCCOjRW8zRTDE4Bvd7x17//ftB8XzSz0EVtnBNN+j2sDDcBSevytOlb+o/9d/PhXsU8wBeUz3Y9qdwyCgtQ7K//;25:lnxOkyXBZHStinDsg0Zn0DWGsBrwDhCLjSyyktWgZMiGICZFW08p+1IcP9H+V9imIHEsKL1K/vrKPQZ0vNCa4sCvIk4RXpAqKz9FvMWJgY69hMFmVv8fYOFjZYQuJVzSrHjlZhd/S5iWOd45p+UAX8ynsmEs4r+e6jlMA+kXjVnw47A2zBLsEmvdfHaRilGqPpzLgtUMdOl6jo4WfXdqOSV0KpKt000odeUXg1RzG8xNHr2jCT01kTmt98YSe+Oy+GQw3uob4CUUDdbUEsfZ+MNuKbc/3RBJvYXRl/QYbLfIvpOaVD0+J2uW0u++Ms0uyb5ajEEDw6uMKt4rDy6YTA==;31:LQ+J2sqPLcY0NnRRzXLLTXsWYOV7pd6iEmyTKN+a0Eo6YpCieF80tdsRZ1RbIeCWvSz8c4l0KqY11pGJlcsXs4Ov1pTWmRr4cYI+Fzy3J1kFZipjLQDhRckkkbs6sIrZuCDKm/1zi7ET7vdt4svtPCw/pXSeHAZvSZJBjS+Vel4zSCLFjlY+G/XjZmiAz333stLl8+73t5vmCcXBayTNRrhg3NVPKgFAH+Iob+VFP8Q=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1035:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1035;20:JV0Y4zRbW4aWknT65fPpbvbxFTJEd5+I0fEkB2BxfIlADz4tTQvws1n8+gxxXfdFdUT/BszBwKhMGfkh2ZRa0fcnBwlYmmtHV+dVUKsGTa7TrSPP9ipLs0vV+IN7iUrur6skStUV3R8r+7UEBAJtADi8hJd68OKC35gC0eNpE4YKjIvk0CnrbGWO/GrtwU41o6EvcprVEs8sYNWhzQ5GOn1ynVRKV6Y4TmTtyf4qxkOEQuEmzI+N+8Kfxv8F0o+w4InnMvQh8ajrVkTQjg1LpQgsjz2ELuwX6NevzjO3lx9/zsG6rYBGskzbW++qSjQ+/jeEuoETxbxuerFXJ6FWrvD0UhkREp1ro3fxE0YxNLap8YjX/NF1RWCcptdKkKd1cxl33XS4/KO+B9hGTJmhkRS71n5slU3EcdfML0/IuMZcnA2DNFzkYQZFIi/0PnbWwRpAcCkcyXUnTK94kWySxKd0EPE8TUU5SShso0W7aMJwfqarT3hfA8kZ1QyVCstz;4:NMrJjiwn96KCtlp8VTLwbjdmqZrvDz3EDZysx8dR4oBnBuiSNBirNAnsPCiHUrpzC6v8nv96njs0zgaxntLfTPxInJ8RUU2qd3Xqfup0vfRPFvKYFuGP/xwjlsjIPNjz956itZzXhxoqOGGoIL/T1k627TGKTkaADpi3FPk8w2v0r4+TrwN//iGg2g6sbMoNJj7Y6LnjKqEzPAR3No9E5DwA6VEUG4xQJHfvvFUe+210sYwxxYIfUkO5iJotxXy6D4+/SGTiDM599o1ZJkNFE1xodJJC4f++sUEkvgyJ/g3Q8fqZhHKcDt83RXJGxY/sR9+vdOSdtZnoQ+hTH+JVnGpibrZKvfW7SO9A1eqhsPc=
X-Microsoft-Antispam-PRVS: <HE1PR04MB1035035D9EB09446436F3DB0990F0@HE1PR04MB1035.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(269456686620040);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:HE1PR04MB1035;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1035;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(396003)(136003)(199004)(189003)(486006)(66066001)(47776003)(16586007)(316002)(476003)(11346002)(2616005)(956004)(478600001)(68736007)(446003)(2906002)(3846002)(50466002)(6116002)(106356001)(105586002)(36756003)(81156014)(25786009)(53936002)(6486002)(81166006)(4326008)(6512007)(5660300001)(39060400002)(26005)(55236004)(8936002)(16526019)(186003)(8676002)(97736004)(305945005)(5009440100003)(386003)(6506007)(7736002)(14444005)(50226002)(86362001)(48376002)(76176011)(51416003)(52116002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1035;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1035;23:6hhs2om/70EUuzBuZnEtyOiJGKaNDqC5lq/ms6V6l?=
 =?us-ascii?Q?D/1DxxavruYPiHmLkMXK12ay4fXv5FD2YbV+MGVcXtQmyU6Dz5mXhsxWyaoV?=
 =?us-ascii?Q?GmiwBMhahn06A3YLYlDhN66aL8bwFVciMKdJ6Fk6WoENa6x3uIbVSoIEIdDi?=
 =?us-ascii?Q?9NxodXX5Neh9KNLUpZEvVZTPbynyG7HrR+/tUxRjL5Liy5G7T4R89oZSosWB?=
 =?us-ascii?Q?LwLBhgTF5dxi2GTIGHfyOFUTWzDflodpc2dQC6ocbMrlv6mPziYzs4X3upLL?=
 =?us-ascii?Q?7bzGEJNAEEPltVM9bYqvosflunCA+nBZMOEI8nfNn7JPObt6wFC3pwRMn4kF?=
 =?us-ascii?Q?JyUU6r5eQI/7oywF7GYPBMDD2/pvhd49qjWvKAXNVh+09hwD6/ENZNn1FVy7?=
 =?us-ascii?Q?LAO7BZ7pjiaVTmU/G66HjGmg+8vfI+8Qlc8No1jEihDx3cC+eL+mW98XyGEh?=
 =?us-ascii?Q?7Zs+HPiD1CoRgPp5c05NWXHniZl905hNkDN0aHZmoQ8BcAYmYYxC288wLvuv?=
 =?us-ascii?Q?Yk1vPhdsy3TMhsToYyfLJhH0JZsrLCIhuDfc5iSdTtlGz6V9RYvuyzkoaIM7?=
 =?us-ascii?Q?pWHKVBSCwd2TxNGEhiMXo+T9SlPDEQ6dT1haAucGvHUZplQzq5Rp/8vy83fv?=
 =?us-ascii?Q?0yoO7K2gd6fm6gVyGgYIcirQtLsyNiJs80/r04GCYl5kYfXjrbC1znrNgzfy?=
 =?us-ascii?Q?CAtTQpSvJi2TQuHvlWEBwEiYvh4d53Z00+OIh9IZibBx5tWBK1bc+sRh+HD4?=
 =?us-ascii?Q?9fO8XCk+jAra3woZUfAPl7t7I2HPwdYTfl7I9Cf4NGlSFtMqcKWCYfvpMKGq?=
 =?us-ascii?Q?7krWPmLs96sT07Bw2TaKNKO4jZQT6sWzxzaUIWliJCP7BCpJgHepABYimuW1?=
 =?us-ascii?Q?UUKNexH8AhBJfEfJT+cM+30IFyN1NqfcAkZNqw5S3ykEUFUy8E4m3/uSg3Pz?=
 =?us-ascii?Q?teyE7Wu3v/Rq/6itf89JGSnP3I+HZRJS6k2pDfOMwtB6ZKXVF2N9miJJQYic?=
 =?us-ascii?Q?pxUz8MxXZMIK8VeUy0eZBlSY6A7dGJS5UPWSz/Hodc6kI8KzkEM5kJPMpDDv?=
 =?us-ascii?Q?v4Xz8PCdPBs4p4e/+JIfD3SEMWRWBDAnOIC+myBrB+S54qpXzuEMBKBhq7dQ?=
 =?us-ascii?Q?G1wip45sVEDCGtKlDDoDm4JWYrugXk1WnJSbm1S/83yVAJcKAxrLDk0TWeY0?=
 =?us-ascii?Q?hQ9gxLDTwi40lCD0gRS5ahYvdjtExLs4+xWlXIvwl/UwJB2vXAUik09WIUqd?=
 =?us-ascii?Q?LSyxErirKW36pQxaUM=3D?=
X-Microsoft-Antispam-Message-Info: A3ExURwRuqVGol6Hi80m1bk40HCfwPaFc47Exvlx6PC/79q97eS7ZnyvpoTsXNkZaK3bgZww9I3OsNOu5Jvcl+PVHaTLiqxRGykdmmJzLBi+28TFgOTOK6kzRfLyunyq2ArApba3rBUZkQvaWb7yR37Dd9eiRTMcxlp+5VeIj+pxTBdirlFbW2x6lwPH5a7CKQkJ14eoYnbkj70hmOlNrP4rvBF0H37FGb6xNGpH7awrkzubBhLL57qnN3jnd0WQ6vtfr6kDEsTNE3o+eTnTkwv9rKNRDZwiua1Ooc0KtysLtrEA3MPbete89x12lvkzHctP5n2uNqi8GcCRFs8t8GkPYtCpzWJCiTr0+4B3DGg=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1035;6:+ibb7pVN0QvCtf2CiyNK4VaaC8ABwlwHOoLyPgUwD9vOzYHzwI6RDaNUgOQoxWln4ajXkxtn7Aql3hQBnK9k4TR2AFAV5vO7ylSLbYvNltwDtANRRc5fx/tjfaykPWweanRSZQI/zej8w7O0GFH4mwxrGwwSL52j0/HyFteW4u0zCXdG3EH4jVp/AZjguUezyusLeqGzCt9I3+yPRlUZS6qAy1vHuZQDgK9IB469hFxeQ8C+zQZxgNIB2AnjQPQpN8yl7jO3x1QjFyEaTyzd6GzKaNE+R+IXCh9+B8kZnD5jbzbonrQtIEh+ggrulxouxNOxA/ENLpzBUDOzaYqTHNAce99FCe02tVQnvIEUjmkHTRNijItA9zn5W4hpYLd3xKDvRId0S29NaN6v5LbopUPLrJ13BYrPICytwjtxSqUYORuDqUbxg5knsl9bAo2rWMNzdUWa7k/jVQQ0g6kRMw==;5:d2HhlI8Dhrk5HsVvecTXhjcTaaH0ZXcdrVUjCpNOJxAQ4TDfeYUrEs7Kp23VycN1zlOGLQg0T/K6/qmcf3rzgOZTJABbfhQ6/FcAN5sBJQHiY9RrZUS3yblEvulHjACuQXyzZdTiXJZDMxFbEuW42FkDPyLolTMI39FnKs3iXjo=;7:dNnxFlyuvAojM17o8gpC91LfgBppZbDMkidnCYxSyQcP2NmErgKAWKTGbKgjUfUSrFnrJJR2NnNjDIo4Ar2a5UnOecz3Svaetm2pgoF/fat/vtVXxSMkb/7Q0oCbrKsx7BHUH1mREcXQWsLENgqpnxkZJDgoEoZAjpr7P3vAfcN729CzgKKkHGwZpZNKkgeGJS70Vxldm9bd7A6QPwydo+dxmTIlubTJGObfdDaBX7ZgTgggitrZ0DDw6QH2VXmd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 08:58:04.5623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7ee7fa-1d94-45bd-1a04-08d60f1fdefb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some MICRON related macros in spi-nor domain were ST.
Rename entries related to STMicroelectronics under macro SNOR_MFR_ST.

Added entry of MFR Id for Micron flashes, 0x002C.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 9 ++++++---
 include/linux/mtd/cfi.h       | 1 +
 include/linux/mtd/spi-nor.h   | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index f028277..33a55bc 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -271,6 +271,7 @@ static inline int set_4byte(struct spi_nor *nor, const struct flash_info *info,
 	u8 cmd;
 
 	switch (JEDEC_MFR(info)) {
+	case SNOR_MFR_ST:
 	case SNOR_MFR_MICRON:
 		/* Some Micron need WREN command; all will accept it */
 		need_wren = true;
@@ -1096,7 +1097,7 @@ static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048, SPI_NOR_QUAD_READ) },
 
-	/* Micron */
+	/* Micron <--> ST Micro */
 	{ "n25q016a",	 INFO(0x20bb15, 0, 64 * 1024,   32, SECT_4K | SPI_NOR_QUAD_READ) },
 	{ "n25q032",	 INFO(0x20ba16, 0, 64 * 1024,   64, SPI_NOR_QUAD_READ) },
 	{ "n25q032a",	 INFO(0x20bb16, 0, 64 * 1024,   64, SPI_NOR_QUAD_READ) },
@@ -2502,6 +2503,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 			params->quad_enable = macronix_quad_enable;
 			break;
 
+		case SNOR_MFR_ST:
 		case SNOR_MFR_MICRON:
 			break;
 
@@ -2876,8 +2878,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	mtd->_resume = spi_nor_resume;
 
 	/* NOR protection support for STmicro/Micron chips and similar */
-	if (JEDEC_MFR(info) == SNOR_MFR_MICRON ||
-			info->flags & SPI_NOR_HAS_LOCK) {
+	if (JEDEC_MFR(info) == SNOR_MFR_ST ||
+	    JEDEC_MFR(info) == SNOR_MFR_MICRON ||
+	    info->flags & SPI_NOR_HAS_LOCK) {
 		nor->flash_lock = stm_lock;
 		nor->flash_unlock = stm_unlock;
 		nor->flash_is_locked = stm_is_locked;
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
 
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index c922e97..f43bfc5 100644
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
-- 
1.9.1

