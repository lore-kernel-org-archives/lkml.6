Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F98C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 04:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8132098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 04:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hWPRbwrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8132098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbeISK2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 06:28:25 -0400
Received: from mail-eopbgr30063.outbound.protection.outlook.com ([40.107.3.63]:9568
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727728AbeISK2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 06:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoM/W/pnDrDICSM03ZPdfkhcJ/XaOury2+BzaFD0U2Q=;
 b=hWPRbwrIxY20cROGHAonSjT364/4ycWNKUr+hqhDXNQrZh58o3bQ4Zn1ij3tJL0VXtqFMwmNebqyZssU9Ih1+vry8VpaytdexrZBrYY7ZAXHLlDrB7tBGThIsUSDuj9td1jrnqhmK6EpB5vcI0pKAXZGiJl4BE0dbHhALksgSEg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 HE1PR04MB1034.eurprd04.prod.outlook.com (2a01:111:e400:581a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Wed, 19 Sep
 2018 04:52:11 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Cc:     marek.vasut@gmail.com, cyrille.pitchen@wedev4u.fr,
        boris.brezillon@bootlin.com, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [RESEND PATCH 2/2] mtd: spi-nor: add entry for mt35xu512aba flash
Date:   Wed, 19 Sep 2018 10:20:08 +0530
Message-Id: <1537332608-19561-3-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537332608-19561-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1537332608-19561-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To HE1PR04MB1034.eurprd04.prod.outlook.com (2a01:111:e400:581a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 174d42b5-f866-4da5-7c89-08d61debab98
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1034;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;3:eSOxRjg8k21V8uRUvf1dkvQJHqKkaOZpPh9wxDCw41iLANdS7HxlVebDpX5QDV7GFSVU21LTGfjSlyfxNGBY4eU5VfX3psp8WWa3k/ZEa4A2dfDX8s6qDQ4W1tpoOBFN7BOuBRj6LYTPvsL9+HC9RiKBbwlc1LWYaCHxSVk0kGnfSG9CQxly/nJ+brdf/USgpyjlHrqvRja+796zhtJmdPJlHto2aXQWGU/gMGu6agCmgwYZN84KyRhwFXTMsmsX;25:/nCjKQUYVQXsuLYFaDQuItKfwfvhWCMrc5c2uysd0nGbmwBdmUmtAXWmbrVAGIXcJ89ksHHGx/cAFO19/QfERT197hVuwLf2PjfU6lvlz0Oxj4tQXTAqKab8YIxPx9Kpp2+sOiZYov99FhTYg1ZfXAlSD5NGvrThmZNuztdlHAUlsrix2ux35xY2wWjs2cg9gUIxYXBYkqJ8ZPLvvAiByWxmVtxpZCThFNHOLbQyVVAb4jcwDODvWfGhYzFHnNeafL2fQ4GnPSGGiKLpXPJZU48Q8Fc2sslbeqqQjchruUs/czN0PG6dmlvmBQP2R5uUyTIfFGZ0hVt+BAMf8AIQNQ==;31:9M4UOvT2kIc9JIkwGy1pV3LRqS0Cc16ImQ71p/4BVFV+BPYyvsITZmbtm8hn8osU4PdeoV8cOH3FWfvRA8+m/j52tki04AuWxZ3rJ++fDJh9xgIuBaaEzMWkDOwvhtVWcnZn75I+GuAgP26Z2NjH3k3WBCJYFhpC+saKP/u/660BKl2OEveCcZYM71OSLNLS7sUqmqWSebMA6gEJdvMOUiraNR+blGcDVLAPyDr7KY0=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1034:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;20:5kY1/s2DZcfdzi1f3AXlslY6AM6ni5+IIEdWvbsJXFFkDgkTEqOf9JUvIAR0nvLmHXHsqMXW2cjQvSBOFe0LuWE+VyVZuyYzH8eOTtRasOrz79UtEwFgjhOlEi6GdcZrKdcIhrF01voNo+wIdYpR582LwR02Crq7Z60KDXEFh8ps/LpQMdPEPF2lWJnkiJdfgbCaM56jrMTnvZJhtrepqRofQ17d4d66FV49pLdlzOt7E8cla9xp5P9JNBJ2ynoIFiVhm70lceN4EDnDBK9qMq5HL4PvG6kdcHHQHIqbP9BK9xaXkRNq1qGX1eEEFCHOuziaa+GZX4BaUJaKaXrUDtTa3l77qd3RazBEympYqdeKm1EBwdCW/tyiegbEgSs3+LHg0uUllZ3bVZ1ENdhDcBvg233H8MVEDU+7jg4CVNAaATB8gL7riWJE7TepNfAcdSh0g7+nCMrmRLZwCQC1EvjpzxenXVoNIu+/+/Nis+u3cfMJYQazNo6mXqz0X0+9;4:H54f0u5Fxe8vzw8Fq42DZTdZLL2VpmMkLUAycpFd7U9YDjY622fg7/MgFXIMObJ1KpG0EKQmytzzhP8CrixRKeKxUiNWr2aJb08/NJr1yJPZIcxeO773K0QBahGJIjq4ZpXO4oRaGIeAiMHRmKe9cvm1sClkGi3oODI6J/8TK3rV4o+tIqLLM1cibzqP/HTcPzyy0b1XAIWc5/zGynohlBnChHs9sLN6h2ZTAuFrwIbI6KUQnSiG7w+Zq86GvtIplSOeXqat9KjJlPYLAHSIGZlEHSk0SYfhF7ifqyy02jsZChI1hOe2kXcfM+/03VQs
X-Microsoft-Antispam-PRVS: <HE1PR04MB10347F51BD21288CCC6B6CA5991C0@HE1PR04MB1034.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:HE1PR04MB1034;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1034;
X-Forefront-PRVS: 0800C0C167
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(136003)(346002)(189003)(199004)(105586002)(4326008)(52116002)(5660300001)(316002)(106356001)(39060400002)(25786009)(6486002)(51416003)(14444005)(86362001)(47776003)(6116002)(3846002)(53936002)(6512007)(16586007)(5009440100003)(6666003)(217873002)(81156014)(81166006)(8676002)(36756003)(476003)(2616005)(11346002)(486006)(956004)(446003)(26005)(76176011)(478600001)(8936002)(50226002)(6506007)(386003)(16526019)(55236004)(7736002)(186003)(48376002)(2906002)(66066001)(305945005)(97736004)(50466002)(68736007)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1034;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1034;23:oodCphPfgY4hwktCbpAoYtUy1JmGcgdGApLORf3Un?=
 =?us-ascii?Q?DSiWkfZCNMkZot93eEAhx9W1aj26mmu3Si2gQBgOy6BM89Nt6R7Oa8VfvoRL?=
 =?us-ascii?Q?vfOGbaCw1SxY7uGxIni2NnY76Tn6hLjVtBdJZ0fXTtJRbN8HJdFT+I9AtAAN?=
 =?us-ascii?Q?5GN9maIqTmnyuijvX2GQblYj8FrYJABBEOWG+7sclKdzRVtxRZCKkDqV9EI0?=
 =?us-ascii?Q?ATekxsjX1WxycUgrNRfQ8MRUhxcBkTXEGvA0EaT4oXxf8jU9jwMXgoFT0UML?=
 =?us-ascii?Q?aGNAQ2iQSHB0AlFZ0nrg1gyuY8IXS4qVm3XSCj3TPamCpXNnk2tybaFxLXKL?=
 =?us-ascii?Q?gIJQ8/GHjCncN2av9lowqUBQgraPBIgtQ4aG9+oXzPNToIM9zixabYrRMSH7?=
 =?us-ascii?Q?6oXmCS6mu9HPu5qif0exxQWyjjl/MnsjgTFtHrpN6aLC7RHEAO9bDP8fdNxH?=
 =?us-ascii?Q?FrVUg1hIFBcmX/5EzZYCvXvjpDIw8JSB8khDcVnJqXPkq3Rb37/5xHEDqT/+?=
 =?us-ascii?Q?xg4oSHWPv9s/S+CztoVK7lTyMi+OGeBDh7/5tupuDE2BzY8m0LOAZGeY6Z7P?=
 =?us-ascii?Q?HKeJn1ZKm+AH+/8zcHcONFruq7kXaXKmfzvSTdMjQMP4AVvInatj7V3sb9NM?=
 =?us-ascii?Q?j81Mlkl2HlHsrxnm9avW0KXazpTQ1T7ITT4Fc719Rv5zyko2ED/Zj8jmt3h0?=
 =?us-ascii?Q?Rb4rHkRFW7zAPpV9yDn7Q2lIk7duwYF6KXovl1tKS/9VYwOu4RVcm7LFC9m6?=
 =?us-ascii?Q?mJ6YZxWg/O9WXC5I5agEuu2qt6fJ0E2Xn+pGdhU/dZ2bJBVM3q/sEQRVwBxY?=
 =?us-ascii?Q?NeXCUDK5+Fr3NXX+boeLsYeCpynn5hcsH+ofRMRHEDHBOWsrqRJUbKUEep3Z?=
 =?us-ascii?Q?GZow/t/YpGQ1A9Flbc9AHycZRVLrSWvx2RmYlJtSUsT59c7wg7bZva/mGq4j?=
 =?us-ascii?Q?8hA8U6AE363RVZtIB5LCqD7iRNdjXnBFY9Fm46pfx+yUlaDRAb7FEinvj/xJ?=
 =?us-ascii?Q?i8u/H+WZu5wEnF0zRdhqlu0TXICsHYSbpo9T0w9daHdLxooTgAGCcLIbKPyM?=
 =?us-ascii?Q?uoRVs+Gp+YGjUGFQebcMtOJuUsv4K4ZUxsyLSNiwVGV0LuDT8fiP0gUSglMg?=
 =?us-ascii?Q?IEQOObVnzmK/L505YGrprSYEBcUSViDletUV7XSlN3/ugKMlwVlLQobUWkq3?=
 =?us-ascii?Q?vRiB+9QsEvKtuzaRi+f27ptb3RaeC5zyHAVJ3yUtkXUfs3AU2ice1H4yMu/3?=
 =?us-ascii?Q?ZS3OucfpKe1R9r3w3r5Q5KE/FADYfrG0I79a20HfpaG+l9TC78NQLAvx+hRR?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: aiM2ObG8tSb5vQF0pXXof6Ugpu9pWRxyiKL9v3Ug4+eGwML7+QQFEq3GYXexEo1/0cDTZpnpAI0NMs9Hzl/ZdkxSh54Xbbi3/Y3VteqXFAqNrhQ6yubF85HzBtAUpEuE2LiXnuXgMUPeIg3coKe9/ySFrf9ISX+vg3vbq7io6ZFBNCfQMT8xvxBy19Fx3Zb/HszDP057bCymFf0PDu42MthU96VSc/t/fCGaUNkglRbK7KmvkisKQmUCrKrdeGpxznRPv/VEVXM85zl+HkXmnb1gj1Ah3L0MUH7g9xO7rb2zaOFVyNPFgj8UszBvRWMOxfKT6dlTBRdgGOd+1XBXzU1aZnNBJjCyn/MsmTa9Lk4=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;6:T1XU5cqA2UJFnUKyUUGX2DLY1OnK+ID5gXfQ4O5qB89fBXlSoVV5AcxndtmmG1miIGKvTN7m27X64Qow41WksWXo9NpAe2BZQ97zYcnblFH5ieplAKMJilhWf//H/K1ZKKpj4OfToEFxuDwhVirJX1r/GYM8QAhr//Zys7HinQgbUkQdSZ0slh8VEOciXeBpGJyS8MdT9NfawIEdEIiXDz+aFafF8vvAPIFVmLzFaJ5eF+w1AS9SN3uEzegv/mUxTqo9/YYmf7thN0Y3XJR9yWOnxpXj06SjlF8HU0MCyWdIudpY4Uh/CjWXjAWsFmlatf+Q6HZxfw25qn/HA+3TF3kINDMVkK6KLhupQSJzWsFmUN+czMM1r5zcfXkr5/HybTVcM/U2VOZSLN7yi6LbI5REnK46OMagXn+ulgGcopcfUcJ7ye4CWqCsJQxpR8aU03GrvTTFJXZFY/TLhiiHDA==;5:fP2xwS8k78myVC7TH1MQU8fbakwjaFrKC/I87ptI4iYjYfMyiL26iJWppJQcZFB/CV5EAsTLZZZuhc+NKHeGG0+A6c5EC6Vv9X92gx0GtzMrJjt3Uqp+HiIJKpB4+Hycti1Ix8ItMHQ1hSCIJVPgthYx9utUgtzs6EBdEeHKWJ8=;7:mu9XuLwD/TZ+8DRdUYlpkVgzemU/7dvbPgpl0mTKiakO/XX/SvQ4gE3qxgJ+DX50g2tVdJ2nJrZu0b4VAG+7jvTY8YzPWQ5wMjWBJBZ/6itnugjvGJBaeGc+oLAlp+omnMHb+2okXdNyN1V//x76oo56Za26p2yHSVP8IwkPBq86OIlTfht+Xg62v/qghYUYnxCR3Q6jBhFdwibqndGPxkqQurwcjh9au/NzOcWab6fUJlp/ewV89lCL5XB7vd+h
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 04:52:11.8604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 174d42b5-f866-4da5-7c89-08d61debab98
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for mt35xu512aba Micron NOR flash.
This flash is having uniform sector erase size of 128KB, have
support of FSR(flag status register), flash size is 64MB and
supports 4-byte commands.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 33a55bc..6042df8 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1113,6 +1113,9 @@ static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	{ "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 
+	/* Micron */
+	{ "mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512, SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES) },
+
 	/* PMC */
 	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2, SECT_4K_PMC) },
 	{ "pm25lv010",   INFO(0,        0, 32 * 1024,    4, SECT_4K_PMC) },
-- 
1.9.1

