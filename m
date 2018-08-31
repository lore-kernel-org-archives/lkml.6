Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93952C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A7420837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uDqLy/9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A7420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeHaNLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:11:51 -0400
Received: from mail-ve1eur01on0050.outbound.protection.outlook.com ([104.47.1.50]:4384
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727703AbeHaNLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD0LOgJ0Ysxscp87Bb+YCfdKkxCcOFP+D56wT7bkoTE=;
 b=uDqLy/9AuR+AN6g0R3/M4loBok6DAqDhGUdPsUYRfM2wokWkShTeiVPCQAR5qA5wnQpnNPASKH7lOY3CxnbpP66ADNK76eQ6QXqqhFwfvyTlSDj7t+HJuGKqffwDlm8VeligpujCEDhSjEZ7L7BrfTg3R9epe6PW98zB+Q8hc3o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 DB5PR04MB1032.eurprd04.prod.outlook.com (2a01:111:e400:510c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Fri, 31 Aug
 2018 09:05:13 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com
Cc:     computersforpeace@gmail.com, frieder.schrempf@exceet.de,
        linux-kernel@vger.kernel.org, david.wolfe@nxp.com,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 1/2] mtd: spi-nor: add macros related to MICRON flash
Date:   Fri, 31 Aug 2018 14:33:01 +0530
Message-Id: <1535706182-26804-2-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535706182-26804-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1535706182-26804-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR06CA0128.apcprd06.prod.outlook.com
 (2603:1096:1:1d::30) To DB5PR04MB1032.eurprd04.prod.outlook.com
 (2a01:111:e400:510c::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45070f03-0b96-489c-2d7e-08d60f20dea8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1032;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1032;3:dqpJ38O4JzYz4o5EPUAPlYBwv8fjxmg483ypnc1FYTj++YRfqLFNtEV+FLG+OYwEdNJpY0ilkiUdU62Li/OPYgHXxm/AnW513J3iyTi5NSjcd958M3SzsM/JuLfMJGT1GTPd577Usuil76y49NooxS2Cn9M6oud6TKSrGMda/s3kFTtYrPAMA2J8808knQgSRQi/UQSEScKMQxMsHeLh+GQkMQFv/8y4aOY8xbd9Qlpt7El0MMMLIc2dxfKN5rPn;25:9I+HMbIe7NDMcHBXbFnPeuOtf4dNMDIWjQZ0CCX2cSMyZAbeAxALgqhOPQayVXY8ueamHMwiKj9dZ1eZiMXvwwA7utfXL0du7r1F2i2x7Dl4Syf/drxYuvrgsj68Qnki++XgjX8nt/pNYbxg6Y3Kx9bRt/H7JYT0NwAHVQ2hQLGtcjtxawnKIbxWl6kBigM/K4e8P9S8IebPiuH7Nhz660TewSxS2pLvS5ZOikvJybG4KtuqU9c5ndUrm846cl3ntC8+/wCZGq0LnWZF/0fqpwN4+ozd3kr7ynqStU8E//7cBfh2tTIkAvmRM+1j/Ufsa63FA+a+Y6uOYS0Z+XYbXw==;31:1I80nP9FkLRZLRTNWDPSTA/YxQFBI4ZowBC3d7ZX2J9xCLnibbypi3Ba11C0XcjHYSeJLvJyNUaEMzqAX0ltwAwnHU9OQlUcYdinybJtZTTyzMajJOEU2nkEIrQ31oUBUdZtFVHnWnr8Ey1eFa+Dsx4FeOfhmATYBDMG5LHDEBsa1e9+Ym4N2NnR7GIoapEtk4qJHmfZvkIXqCoYfbb0vL1v0GZyjiyu+uIuDFavLQc=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1032:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1032;20:LNTMyz2rzFAqU32ZpW1NZ+YEI++dqn2jy8DSedalNn1h8zQHGaEUTJVlMHgAPd0hoL3dCe+a37FAX3jS4kOVx1P11AMGVoI2a4S5zQEhpz84HavBx6i1NLCuwRSj63lxluMZ1TLS71JNEOMjnTOJ0kzKMiOaJngrEm41q4J6TftLoQ5q7ZaKl6i/bU7bB+8Xz5Eo81XE6h1pcYv2VHB9j09baUNGy263MDdZKlm3FaX1HqjyIFh02+O5xPASTSrvc4nYwMIMSnSFNz24AhCXlPoz1DpiIy/tU52bvLuUIzyoG1mOq/xmT0np/Y5gKG9ngRBMMGOdksLXK3USJ0UksCvUSOX0XiuPdldInZBCdvm/j75rnPbru3WeSeMdiQbcHLICzpUkWvLE3PJqznrhIWVvsw+CtaI8SneHSw6euFvCRgBgIxyPhnZ38oIZsUBbLMuUOOzjGQkSIGhr8FElPr5O7sChSEbd1TvtzfciaqazvRKby4JRB7meJaVg2MyV;4:2TZkMkgNQnKRfKP41/kCfbA7jcQGJOv/i5wkCsVDnUCQXQVDkewlH1A/V8Ar00tBu+ru4ZYZEgz6S6jgkysPajiY5IEINMIqpynML4kbVpoBY+Zb57UhCexgwfJp6g1MAMLTjsrlztKwbum/C4ymZC6PpM8Xsc2DTS8S/iAy0bWrRrjnY0B86hkeKKXiupEOu7cqP+uhLAdnSEseGNLk3+6YXuT3Xmit3/vM9THWyDjUjdUa/lXmyFAjNgNlRFGw5Pg9qrOAVzNWq0gOS8cwc4XD5x0rmQpJKyjQU55zGHUg/Bs0mwPEVRVU/paTd4+U2Z6iVY2pVvUsV3g+eluB3Wp7sYYAt9WmT6U4rLwNb3I=
X-Microsoft-Antispam-PRVS: <DB5PR04MB10324BEF749BDE3F33ABA7A4990F0@DB5PR04MB1032.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(269456686620040);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:DB5PR04MB1032;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1032;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(316002)(6512007)(6116002)(55236004)(8936002)(52116002)(5660300001)(26005)(76176011)(51416003)(6506007)(386003)(6666003)(50466002)(305945005)(7736002)(3846002)(2906002)(53936002)(81166006)(81156014)(5009440100003)(106356001)(8676002)(105586002)(48376002)(68736007)(478600001)(4326008)(47776003)(486006)(6486002)(11346002)(446003)(476003)(86362001)(50226002)(66066001)(16586007)(16526019)(36756003)(39060400002)(956004)(14444005)(186003)(2616005)(97736004)(25786009)(110426005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1032;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1032;23:cMsWed4oUfeGu8hnzPgww+MV8H9PrWNTlwTHRgD/Z?=
 =?us-ascii?Q?MSQwq6DazCx0Dc/mbz2SK7k2dAQekaJH1H7Tm8iXv1hqlNhspZzI42r8cNFD?=
 =?us-ascii?Q?ExWHYCQQJm9MYzxk1JBhG2LYauacFIhir5WqJbJAz4S3KVlh73FbhtwsT9Q9?=
 =?us-ascii?Q?t5mneoiit4smVsc7FkOnIadrgkm7pdv4xrSCnj7yNN7xEjofEgosJNSg0CCA?=
 =?us-ascii?Q?4kzfCK6qqZSEgJplxFn4KA474HxDOneR2yG0hF5C9gn0gWikD3QkRcPRVtfK?=
 =?us-ascii?Q?q1N9/q9flep0Fi24QQZRNpSXPK8wNdi/vAdoNTu2cpx/kVPu+5f+3LUiEVQM?=
 =?us-ascii?Q?fpaPUCPmMTnRyPvquF1dxPqoQuE2c2/cDfOLxb0VprfjcekEddq4heMcx9DI?=
 =?us-ascii?Q?KhycjrahISElxblVp1XsZb1PpwNe0gQRveCDNfuN3JxYme08B7otPD13at1M?=
 =?us-ascii?Q?gCKhV3sQuFcVhb7YwbiAu/YfRFk9czgh6KxBfIFcb+q4IInlnSTlHvakXW1N?=
 =?us-ascii?Q?9iHBpB4RjeXveJQNxKPC1CMhOnz2zu0q6UA0W8czNhLYYVUbcTGJ4I9y4630?=
 =?us-ascii?Q?dmjDnBTCPYBJeFs1BIJAXX044awEyE3cTj+i4f5nJTA1Fnb3tEa+tlaeWPjw?=
 =?us-ascii?Q?qfeviaJ/AR/jgR8JkNcQb/wnhS52mdt6EyeXOL3BZdcZs0GFYtHmFpYKMM4u?=
 =?us-ascii?Q?BVxE+JaqZ8xZXe5Id8MkWc21/7su7OkYP2WsMNs+lK7YlmQ9Tz3vwCulAYO6?=
 =?us-ascii?Q?pqKJTQ+LMDbuxifzK+z1okowwk0WvpuURmMM1ZCUgZzw8czDP8l7twRqNvhW?=
 =?us-ascii?Q?KofhRTNES+pHKm8yXM3lxMiXyrAJ/T5E57Lz3rEn3KXhhwVXIPWa4N7U9y2L?=
 =?us-ascii?Q?7dTc33ASXOWapA4sD23nh59a93kaMGPLk4Wer35g6XyNXjFOBhuxyhUPThv7?=
 =?us-ascii?Q?ISzflVjWZ9WiukZm4UcXWIm5OQbArEOcZNHyukzHebO1NBWd7QuYgIyFowRD?=
 =?us-ascii?Q?QyTvbCTz1/eCXJs+PXFyGTKt/NREn/LWW9kvyEUj7uetuZuQ2jazLvhQ7VXY?=
 =?us-ascii?Q?LL2NGA7LYLKylzCxRuHAIHFgLatmXtlDofFxPecvof8XasMosu2Jinou5aXH?=
 =?us-ascii?Q?QXXEioFkBaac3Dy+owv7ea6P/vLokVCD0CGLOUalgg0msJvrmMLiLr8Alq0P?=
 =?us-ascii?Q?nLYQ99502Ky7Su7qbivBsgw4ZNZLMjW9PCuwE48uRi07R22iv1f4CZHfuWrK?=
 =?us-ascii?Q?I7a4UhqV34Zo2v/qq5Z8Yi89y926WPrjZRukMI/8PKdLyiycAeFpzAvkXMc5?=
 =?us-ascii?Q?/FUbONTcbWRlB0OxaODaQvXgpb7j4h45L2kW2GLIgmGv7dzrM31LtukG2aTW?=
 =?us-ascii?Q?R3dLR8YjESuiNaBZIsvY1AfIPU=3D?=
X-Microsoft-Antispam-Message-Info: 51+xqc3LLaxklrixQisOOSrpiot8NPFfYlUezYCjfjlvSXexkVC+JLA7eDRqivc14wTsd2xloGSu1j8Pac1d0gok2BizK4i7cyeR6Td6SNJHamd7pMQOQpLjfDbSeBiCIMR3oVBXSVdpbixKs2M7Gfj03VtQQAm+7YD4MLtdoV/59UZyNVTWC/3G5rn5KdAga4AQEcyWgtvXW9REzPuSsk6B+aHZXX+o3FnZ1IzTzQtILwQt3u0CKVuNd5iN+GivcnWSqxdo26GypbFXw3qeiTuOyqCnZUTV2nyzPMm2Vl48SNRQYKmKoTK0wsCncy/x7P4IoG4ge+lBKY2UdTtnRiTVbAQsiw9uMQG8LJ4Vdmg=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1032;6:QT7EhmOZRpBbqpmsM2HvmJIc9ViA1LAfqCA/6PZlZTQ13i41Gri6VnkA/OcUsNNTpZ+wSrbRuYo7oAFqtRZmN4j+nWADtN/3rPch1AxcTqNFbVcK45wpnazp3sgw4Hu7PcjsApY0+48fliZb1oVGXEwGarrvZiRSdb6YPoeUqkACdfaD4C4J0bE8HroWk9zUkz1oK6tkVnVwQe1ld6dplJ6a8ZjhJMga4M7tY8I5IIIanWQNnxHhWQtdvZPM/HWE0hkJpqxUfEEj60GT2jNCiHbIjh/07dm33bg2wpLlDTmD4j6WWb5tknSB+7jDk8sgsRcHdM7IZvODWvU7i3GXOnxSA4ffC7Hco7sdaNkfWXIgVPccNUov+7VhASWzR3DTCYsNpNyiD6mYZ85rXMKv2DIlmy+txokDQWeUWig8oZDAn6qR8tBSuORWrwqTPqniUyt4w61ImbC1is8eXkQi/A==;5:WK7hFc28BMcQdv7dFG4+CUWyGUWl5/Jc3pmg7iTEouaxrxX1r0+SmGKEJXT5CT+q4678B+elyiKeUYAVxN8LfQutwBVPgt24yOLCdLWHqwf5Mq+vIidhx+WYcZdMv8dej0XFYnKx+VxVchGq2EllBhBtbRgrHdYzfZm9WZ49RXs=;7:K9P1e2rL7t7lZCzsoU1WvIJZBaENHu/pOR3C63LYt22s0l9lhBzGhXjHA8l+e7s7ZoxaKVdtkzX91g2jbUTcuUUDj7rfVsWBXmbrNUEK7SFWZywuG/nUPTuahPbVfBr0rzq8bJ2DZjto3hbGdwRrKJ2B+cqJHBGJejak7ggLLpokl0swK0gSoznqwXtUgleTRZ0nfHWJk5vWu/6l75A1xvO1jwDhhuoCm3FPQdkM3RbNdOpxl3MR+IYP8FCHMueY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 09:05:13.5861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45070f03-0b96-489c-2d7e-08d60f20dea8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1032
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

