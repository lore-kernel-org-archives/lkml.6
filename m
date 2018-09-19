Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858BDECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 04:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299322098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 04:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xP2/EEJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299322098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbeISK2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 06:28:22 -0400
Received: from mail-eopbgr30081.outbound.protection.outlook.com ([40.107.3.81]:59208
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727728AbeISK2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 06:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD0LOgJ0Ysxscp87Bb+YCfdKkxCcOFP+D56wT7bkoTE=;
 b=xP2/EEJZQ1CGAvbxfF8aMgTi5J1cX+otD8kEQf1f6Vefg6/z2jV3ACd/npZWdIUJxGhpoGTnATGZLMJtkpwYs/UwfK7KNHBkAjshYFI2S/P90343avCIMuxBq61uUjwDq2vlNDYGDR63UvLKUX1APz5PMPMg67XTI7PVCNtSX7w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 HE1PR04MB1034.eurprd04.prod.outlook.com (2a01:111:e400:581a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Wed, 19 Sep
 2018 04:52:07 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Cc:     marek.vasut@gmail.com, cyrille.pitchen@wedev4u.fr,
        boris.brezillon@bootlin.com, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [RESEND PATCH 1/2] mtd: spi-nor: add macros related to MICRON flash
Date:   Wed, 19 Sep 2018 10:20:07 +0530
Message-Id: <1537332608-19561-2-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537332608-19561-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1537332608-19561-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To HE1PR04MB1034.eurprd04.prod.outlook.com (2a01:111:e400:581a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fe8b898-02df-4084-3d84-08d61deba91b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1034;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;3:DDqqNIeb7MwQ3BwroP4ON0sNfyfHdkrdysxv4WLXZrnrMY9In9+YWtELEyC+qRr/wPCluiuyAgxFr9DFNQXLMhhzWvCp+MVDT/uPHwKK847g1SJNioYRTr+fMTUp/WxjSElbm01jNolVnzEHGxktFyGY+7jXNRj0INKDbgKKZiou25wswxjOKJAEwWl94MzTJLxI68nVSj0UNzwd5v0Cr2ofVVFdGCIn+MMcegYVNQVUEbKuvHAZZpNdD3LoeOQ1;25:xSEpA1EiT1pnxE6eG9xbgElDOnmba8+RsQa39QS1lp4vyPwT/Of0y5VwcsnqkTk8X8wTtsoLBIeZT5wev8CVrnzjaZDOlX8qx9MpYZauN2Jff1ksG2MvNnHfsx6FX6GCtE+Pq4jKtFFhDTJGSOVis5Fw4aH4s8rRnqVu1kbi2YXyi3w/vHdbsCcYspkfF70HHO+FGSVCD0jzm04ET0wHyqhkEP+AxXSXYMGp80YnPesG9JBJ+IwDNRPr2DQI2az1tYm+9cn5WwmpNMnxcPrx+95t5Rf8hd1zQwjpc27c7DEskWqc4vgmIGmOYvZhGLG5/3mnWo+UyN7Q3SpSfHRjOg==;31:8xFMYyStQlCmiVLoy6UJGZT1HIfNBN8IW4f7LcEWl5LVcVIZTkRJA3cD8m9KrJ3iVxk+UsRmgA27rpXsuDdZGrMe8I0tXAw4kuO1/mhEmx4TlX6qma9ihRZFRdL23A3cPsGU4LfWvRpAagW/XV8wUy3cn4GR9UMgMgOWnSjJbDo2uESTtlEqZOy8+w/4UMun4V3yhxl8JCRzT0uUlYhk3arHNlO9htEejz0EivKjd2k=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1034:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;20:p6lzxUa8avLsmb8n8Kb7hI1T2UWdLq1blLb+LXncCXB/76P0tCO1eyKSHUWKf0uWSQBJ09DMp2jEx3R543VjNQ7Bn9SCgyuEnyFRMMTpxMAyVC8o0xF4ExepgpNnz0b/Jxvbcn7hVEOZEtPHda9YyL3CXzZbTwygrvoUEoSg7oJUYzgVlasMWGISG1BWM6R0V4tSdrgMXIJUhF+Wio5OcZUjbfPv+GTkCQoPxPB2IbT939Asvc/VQ+BFiPY3YviEldEKNidh4G/MHk07+mijbss9X3l+bPRHJYweqdTcGf0ieSLPJ2DmtHpjo9f1g32kWkvveun0bVtW7CoFs9j9l12uTSl5ZMD1hwML2kNsXDQOJxyF0U+W6CchNCWffOMQmZGtsG3C0qniCZZX1l9HpdD2FUU4uJyv0Ic03Yw4ak9ZQq2gcXKdt9QGCVXEgqVhtSsQBd/phn1w/77A5Fury4iBTofEYjE3Gl2SQA/DGXD++h1j1R7pPQ6rdyddIQ3T;4:bCEgZPBjcDB88PDdPY+PuMWi4jrkI969AcOHXguSGYWwN4Wg5SjjY+2ENDtN2mLFlm5eynLwJry3XWFctKPwqklVjhbeBXxjczBBZbzZS40QM5D06wcEirAldd+FVzG9VfhQyo/JPd6EpjgQdyxACLcfmn2ja+aBYCtnKJQyuq7DWGGBF/P52krKYdAAVLA7C2Tsw/n13w3ppIVkjhR3V6MDGzurNOPLV4bjvXc6N+IwYPE8z6JXTDqgGYSJbiaTl7Ce8cWi+yrlgWQUeZxGak6BuG/ZyvJAiTIlo9TfIkkQTP2Ly3bqp0LiZqbmbW1XQS6/8sKrvqKDTmcR5GBKEOBEzyuxy8Ty5MqXGdAc1D8=
X-Microsoft-Antispam-PRVS: <HE1PR04MB1034900562D1956033D5985B991C0@HE1PR04MB1034.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(269456686620040);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:HE1PR04MB1034;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1034;
X-Forefront-PRVS: 0800C0C167
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(136003)(346002)(189003)(199004)(105586002)(4326008)(52116002)(5660300001)(316002)(106356001)(39060400002)(25786009)(6486002)(51416003)(14444005)(86362001)(47776003)(6116002)(3846002)(53936002)(6512007)(16586007)(5009440100003)(217873002)(81156014)(81166006)(8676002)(36756003)(476003)(2616005)(11346002)(486006)(956004)(446003)(26005)(76176011)(478600001)(8936002)(50226002)(6506007)(386003)(16526019)(55236004)(7736002)(186003)(48376002)(2906002)(66066001)(305945005)(97736004)(50466002)(68736007)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1034;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1034;23:vHcqW/v+ZTATOfDcD2Ts/X+BO9VE0K7ZAuW/l6vlS?=
 =?us-ascii?Q?PypdfxHYcjwXH8C4rE0TjTvzR1JWN11DNGaJwgI8Mmk3cyXNQmv0b1dzSLZo?=
 =?us-ascii?Q?toiG8LVIlCP5aaxGW5W8a7zhFjrzj6cow4GSK/NgWwfuQChzAz7DMxsMplcq?=
 =?us-ascii?Q?eW+r+Q6MEsO1fEYIo/zzkQM3bYO9vPClkfyXANHViSpXR1jDyN/Waj78Xehu?=
 =?us-ascii?Q?k4zadGmYL7KE7VJ0OqhFY/h2DeqT+js3ePS1V9EPMtK+5dvurrIVi5BjBdq/?=
 =?us-ascii?Q?xnaEQynLiuOYo6F0oYftbb9Xx4c+PyNA7zcfCjfL1yZ1Gr5WZTjoJ0FXupHG?=
 =?us-ascii?Q?kTWxLpUmouQoJbTOIOh1Y9pGhV2aSsDVWBD/IqWx6EtAvWaUJre6QUqMLzrv?=
 =?us-ascii?Q?27fiTk2Ym030h0r/GOty8NpsnFBDqm26N4+L7B9FkzAOUT7uzy1+w8FTHH4e?=
 =?us-ascii?Q?WC/gv+b++Xui0BfOF5NBu2GnlHhbHVjkUA3/FXOxC6aUqYA4vmgxHjtBxWYS?=
 =?us-ascii?Q?tNrt0lIlTJdTJSMrnIgUj7mdKWO/csLugO1RmfGO0nSbG8ttgGqfCh1xnff8?=
 =?us-ascii?Q?G00GotHxAEgEw6rfptK9ESxwzSMCwg9sYwIhCn723n7+8ApA43szU9F6kLaq?=
 =?us-ascii?Q?CnBF3+y8oIbW9rewMOq/fMBsx3V/X7xm3w1Kn29RlnR6dy/xrUVk5gIWyMyO?=
 =?us-ascii?Q?ezvU0GQgzxZKFRGC7BoqQ5Pm7bwUrZyf0Fbd7UVE72oEhbHE7Tfbf3QdK3S/?=
 =?us-ascii?Q?NAK+oMNnlyLMd6hr7C+Gr4R3IIYSpOIW6+JNx1B87ufln/pFGWz0/qscIeuj?=
 =?us-ascii?Q?nL1FPmqx8zZuR026ZLD70QjekMjI11dMFRl1GiEWPADYpp7Z5Xj2XToMI7gS?=
 =?us-ascii?Q?EFYmUi5MdenDfxv+H5Vcx8p3VA6tq0ooH4QDJCgon5CavEXAU8ytCUNh7X41?=
 =?us-ascii?Q?4GRc082CEocux+gw4XAXxublZghDGeGV90Cnqn6nOsRuHZ+DtNKUeMXQhNvX?=
 =?us-ascii?Q?oDFBFLtl027cZKAR915bcgo0nUoZj+hsauIXqHau6FRi8YJxEBSCJK7pEqCI?=
 =?us-ascii?Q?d3J6QDJxEVu67b1XNI6Qe88C+htyCNBDsiHFYiONneGsrY/vWxlm7GVf9oDV?=
 =?us-ascii?Q?7Zdg9Qgxe9XaABwANxAs1wF4HuSPDGlIWNntcx7zWlfHL5XOis9CINRHlNoo?=
 =?us-ascii?Q?6wTq/Jt0lJ6H8DFCPOv3f24UUbacZsEFMRQIEaQtYE2FMRQ8MfyC9ASr/OJj?=
 =?us-ascii?Q?Ghz8wLD4yoHEMU8J4ZhLw6o+gEHER3/Y3X9kNrd?=
X-Microsoft-Antispam-Message-Info: 9OuCgMbeynhUcFnW9imvu75R3qlLmy+AeCYGvu36UdlsEoca0/jqnzWtR8dD2vIMzpeXktIx7bR88usq81/7b/4C4eqAp2VL3Hb9Cp0/utOw/NEBXS5BFApYl5yR4GDAGLuY0D+wa/FlF6a7eeBxwN0p2OXd9PFYHa9WHy6eJ2KHyKE7U0X60XNntCfRfA4C6AM3P+jAJ7bOVlEHL9HVdWNQYeg3NBQtrjboUECRPeC6GgkNjx5rtiqNYIRdj7NSFxAoTvWVTdRBx3araWlOEGdJsEzAOig/r3fL8v2JxJO3kz0aSbfznATHvjsVPhjnhuCO4Gb6OIRQfTU1mRfXIPjUVPJUsL/dRdxwcaO19L0=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;6:91qKSGGDw5fDCOfUErOjL7Q5xD5gFt7+FXsJrpbW753+E1vw/Z7ktwNv35BOhLJRRlShHVQlJ81ovoYlLj3d8yIZvdq1hzDCPPPbysUp6lkrCuaWJjFf1zsxQ6LUcghT1Dlf3cgMRc0TOsYdtynyhs8s+7vK/6JAFYops7Gsfuee+gvq+96faJsx3zXojjeEVBgmaND9uczPDSxp7ma3DbpjekG+hrB8QN48hg6aQuHyKNozNAFLSErggnhndzruAwMeR8B/EmAoNGRu+GvzeWijD5QFj3EYC0FkI5t1hOGVZXsSlple7StomoJAnMULQnVqbgEsDTZ4ld0tCR0a1Nhjd6pQWHOVlOoj5bB7iw+3+sKzQZtnvQjh7cuj52+9i7mUxRUR0PlPFUxQWPEZ3Umyyz5+sZxBrhmPKt0CvWsJ00sKeW+f8D/EPg2JLktJOSjefQ1I6AOg1NGe2qyxHw==;5:Ll5yArEGaH8TdGAPVM91qURfT6xKIPq4M+galteuUE592S0W0RMKb7v/O0nT69kImNXsPLTLqBnXVJakiCOWGdSoVgOQ/5Z/K/9gO4voEIT/5jKzDfidAHd0zjtWQDlYwB7OB4q4lDloiQh7EK2hvriuhwcOijiWOhOYWrYgkIQ=;7:zFgQ/F9HXQ1l1I7Tk+8hg7yqnRZpDBgWuS7b8vOck1ch8hg7zB5CmntpEWkDjXSXvMtZJEjVcPVuHB0XVa2qOePRxir81ycyAt72CzWZ81YKtONX9VYE/s2EW0P1gZK9Pj/sSRdRbJ3RlX0hDABIf26n2KUoQN1fXVwmcLR3CQqRSO7rACLpFinF5EOFY8ZUR30ehMQ9DAgzZWBSXEV4SPCZC9K/5PA7/vPvyatBdkIY5aM632rUmO8yWr2EDfUM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 04:52:07.6851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe8b898-02df-4084-3d84-08d61deba91b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1034
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

