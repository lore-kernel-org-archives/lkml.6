Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7853ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698DB214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wS1RVlJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698DB214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbeIRL5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 07:57:02 -0400
Received: from mail-eopbgr60043.outbound.protection.outlook.com ([40.107.6.43]:27376
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727202AbeIRL5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 07:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nS6zmtPpJX0mAscP8F2uy/cKsZTsc4He2u2hCKTJeDk=;
 b=wS1RVlJxB2e6Kgrda5sWdCr0WFvRHMgZSSfPWwoNph90HHGxGegN1lfDHVIJ18UQTKjXPC96sSUXuP5YcsvZraNtVbo3/jJTVgK4FTuSL2Zf23USYu4AkXnMHWF/eJ7tcrRKCoN821Ln+rJx5m7Urqrax1t+wUZTLAUozU3k6tE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB3PR0402MB3915.eurprd04.prod.outlook.com (2603:10a6:8:f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 18 Sep 2018 06:24:10 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk,
        mturquette@baylibre.com, sboyd@kernel.org, ping.bai@nxp.com,
        Aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/4] ARM: imx: add i.mx6ulz msl support
Date:   Tue, 18 Sep 2018 14:19:06 +0800
Message-Id: <1537251548-27845-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537251548-27845-1-git-send-email-Anson.Huang@nxp.com>
References: <1537251548-27845-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::27) To DB3PR0402MB3915.eurprd04.prod.outlook.com
 (2603:10a6:8:f::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4778ba2b-08e6-4235-c832-08d61d2f5bc7
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3915;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3915;3:6ud4VsbtcJP1UzuF85LYOsXTNqieIrmZA7UXPgO4fmB5Un040uh/a0Irm8aurDfNbLc7+EEy3+6pMTl+Z35ZbvGg3BGP2LyUVnV9BWY/GmWDDcPedV18vebIPJXkiT0RhBwYEopA36YJPIiQDBB2cqb9fbRCy6ahW3PvXwC9NQ9ounA9qVfVlxUFOu8tbFtevnwGtZAk4fEv+Mtf3imu/Rn0DvMRq81vsRoE1aN95Ige/rIPPecyM+0uw4WCcGax;25:o55tD4oQR3lL3/UdKmNGJAlBH2z0H5yB6S4V7LeEWF+1cItomMk7WMWNKNINiKJge2paVbeNKI/OlwohBkIsmdpWjC4RQzEkAjvB45Q1M/dxOfxyY4dCRBfK431Xj6tcLVEsNyAeEoNdH6rXug+xupX2sfUo1YEZ8avAzC6D6KbVDiGtx34KImWXJac+LSjzUMZDwDavMEAkG8O7+Rs6JDHW8LHp/65wnfv3ivR89RRWiBkRfo5C3wMxCYUChpLWDQ1c/AVdOV8QNTmjsevdBnOEjiO8gwcCIbJZ4P5N/kAUZirSAcOoVlkqNH3Y42ewrGfwtwVxYUeFJ3WbNyPsoQ==;31:lEKIy7orJIUyWfNin+ks6LwufNFR4rTgvAvx3ezN4MxPHUKDY6hWrlwlkyu5xLD/9pDQhjZ+s+UrXmuJBzCvUsCsm6UU+YL4y446ghpoLLV/ZquDfJ8YnWxs/wpy8p2I0+YziuAkTtydIwIvHvPgtWd4lv3VWIf3R7ZaBSIuqLFR/5hkvMnFkgSp3WXaiO5TeostmstKdlFxboK9OOLUDCQGplkfy/USNccYFzq3kzE=
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3915:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3915;20:mQQSCmo9FiEcEII5ekUiBMhax6waCyAKrcly1XYIu4nwpKimVNiOmHzYpwf2DCZVIOEqSKmjY1eavBo7MOkMIqnmqXe+rZ71xUtQtpWRmjj1NBnnwYhWT0DS88ryGSne3suHQ/WKp8T+wm/nXIqrBIO4bcNaMwV2+Cq0eBDJbbjf6S/aW177nCXK8RuAGb1SPyeJtSejPLqAzBUFjnrSzvobwlEd94RWyIFIrk/53SnDx9Qtih1AB8MBNcOHdoSaiQXVROkmF3Ca5VZ7N7WqrhVYh8EaNdhDF94VsyncFiM5ndEi40RIw1d6eoQCpFGhOwSg3JgN7ypmA04NTB+RKhyz4Me8333FaPjMlR9D/DuWoIIm/lVgFH4oVnvPdNgyFML8gA2JMunS8Je5BLD/W634oGZjK2SxXZ8BO2fT91E6Zko74J2nkFzOkU/NgOSxB0tF2sJ4g8qaNV/386udLa9pslVa74FwpFKyXfJmFus8WfFrmBWx1zT+OYUsWhIS;4:XcwOFrExlPjpXqVoREa1myce254isRkZjag7pP5R9M8rVJxe0BvGT8Otn1KSzZ5g8nV11WAqLjRbs0xpkHBdyhEghxrIzjoAM3IgUNxQEAF5BkGTNZ8zZTrk2OWqRTPSdAxbZDBSRk+5Ja6g2wPoAK14uaVkEY1MC4gJe06r9uZCIQM2xQv7ZBJwUUFyrLJtxbKa1906tWws5H/oSGIY47RNeyx7YyTkg7AEWcxridL/JeAGkE+0BQjBzUa+zefeaVZICTnnNRDTKZxfBVQy+QS4HE5cxaoOxxutwmmoZVsCwuf3KlqY4g4+nYp/NGqY
X-Microsoft-Antispam-PRVS: <DB3PR0402MB39154EDA9566157B43FAF95EF51D0@DB3PR0402MB3915.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699050);SRVR:DB3PR0402MB3915;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3915;
X-Forefront-PRVS: 0799B1B2D7
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(186003)(50466002)(50226002)(8936002)(47776003)(105586002)(106356001)(478600001)(68736007)(52116002)(2906002)(76176011)(66066001)(5660300001)(23676004)(97736004)(6666003)(25786009)(305945005)(4326008)(7736002)(26005)(316002)(16526019)(6486002)(3846002)(6116002)(476003)(2616005)(956004)(8676002)(7416002)(6512007)(53936002)(6506007)(386003)(486006)(86362001)(36756003)(81156014)(11346002)(2870700001)(81166006)(446003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3915;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM5MTU7MjM6TGJUVXRlK1NyZEliY0l5emhjMk9PM1kv?=
 =?utf-8?B?bzBKSWV6ell3WDUxcFI5VVZ5QXhXMHVlSnVISk9jMmlaZVlwK3MwR1ZyeGpO?=
 =?utf-8?B?eHlzdnp4cG13ZEhCOGFnbUZkTGgrb29lZytySjJHQUtjMXJ1NnlVZ0pWandr?=
 =?utf-8?B?ZVFvMHBiRENvaSthZS9ENnp2bUNzeG4vbEdrK1VqREM1UWdKWUF5V3d0OWM2?=
 =?utf-8?B?RHFpbHZ2OENORU1DTlhEZi9zOW9ZM2k1aHpKQlhnTmNyQjJOUTJSdTlMaEQ3?=
 =?utf-8?B?Q1JsS0l4TkxiYk1QVWFrTDc3Ylh2ajBrQ1U5TERRYTM2c3BzWGdZRFNwWTF0?=
 =?utf-8?B?eUs1OW1QNjl4aDgyb1RrdTQ2dElKaFNMQllnck93ZHdEVWRMSVdOaFlhbGxi?=
 =?utf-8?B?RlhraTZJWHp0ZEpweU9xREZVcDA4WGhxb2VNc3hXYkJ1ODg0ZXUvcXdDbENa?=
 =?utf-8?B?Ym1mZmR0Q2QvZnpBTkhUN0JmTTBpdzVaeGtqanpaa2h5ZVQ4ckdmZDU3d01N?=
 =?utf-8?B?NU9rVytjbFFYRVo1VGc3TzJGUFlqUG1RU2FsZ3MwT24yeUU3YTk4NktEUkZ2?=
 =?utf-8?B?VTFEUHhvck8vZE1ySmxKOFB2MVhmTGQ5ZzhrL1JYWjFVKzMvOFEvTnBmS3Mx?=
 =?utf-8?B?TkttZ1ZKOFRyTm8rK2VSRktTbFg0TkhjcVNDMmdlVENXQktVdWNrS215K2d6?=
 =?utf-8?B?eWREM1VabnNoZUdxVlVSeGxYM2xWUTFvTlhGSkRoU0UvcDBMREpRenpqbEVK?=
 =?utf-8?B?U00yK2JreHNiaGplTTRMYlpXN05YRURYT01tL2lBb2k3TzNnYld6d2NQWlg1?=
 =?utf-8?B?bFMwZjdMV0JFRDBBeS91dDdBTnhPVGxTYXg2RU12TjdZZHlkS0Q5bjk3aVEw?=
 =?utf-8?B?MEprSXVXQlNud1hTRFRCaFlIaGpQcEtHdlpyUkFkYjFRczRNeXBRR2lCcjB6?=
 =?utf-8?B?T2Y4M2VLSXBmVkUreWlwaDBDVnJpK0NLM092MzZCQ0R2L2wyZS9QVzBhTERj?=
 =?utf-8?B?Q0FQbXVFUmNWOTVKcUYrYU5kcGp0RWFqS0pDb2IzTnBqWTc1MWZJd3NBZTBO?=
 =?utf-8?B?QUNEeE5YSmJlQkNySTJYbGMxQkcrL0tFOG1ESWdybmdtVngyVUNXWFJiZHo5?=
 =?utf-8?B?Z0k1RkNISEhQdGxLRWxzV0JsY1JUcDRSK1Jqei9MS2ZGMnRSNTQ0bWFydVpZ?=
 =?utf-8?B?VWlFc1FCQ3ZjZjlYTU9sMFJzaFlmZEFOVkhuL3M2MFg5RkI3TVpRSUZ6Znh6?=
 =?utf-8?B?STUrOXdvbDRoV3NXL2tPT0lLdG9KditzWDJ3dFUzd080ak1uaUtIcDlFQThq?=
 =?utf-8?B?dGNUTFZVbTdlY3Q2dzlDQXFJMEtUNGI4bENRTlh6SU0wMldNbDBIdW5VSHIz?=
 =?utf-8?B?REh4SktBbW4wL2pFRHY2bENkNU9Dekdsc3A2bm4vQVNDS0YxN3NpdDZmTklO?=
 =?utf-8?B?T0d6NFBpeEo2T3FKNVp4VUxvSlZuR3JaaFI2WjUvUmlvbE5RdEhocWVVbVJr?=
 =?utf-8?B?WUczb01RUy9CdUk2cEg5VGZkYTduUlJ2V0NHRnBUMGtGWkdSbSt3R3lHLzM3?=
 =?utf-8?B?NEZpeDBDZWdTVFZubWt2NkRqdm5MdXkxRENQQWZ4cVFweDlrS292RDdNVVli?=
 =?utf-8?Q?Y=3D?=
X-Microsoft-Antispam-Message-Info: JGgGwqDW1SlzdWVO2YMGUkyjZz9mubV89q4KQrLYvqy+xQKkLQIc6iHKkULlJZ3/sHmeN70Cj1Yag7y/LXsR9kSRiY8KT6xGyuc68M4uE65yD19iMzGWifOERpPX5MkirOH+Ij01HHxny18IuRaAHn3pcjqyVsJRn0WcMcaxDQMd3dnV4j/29nWIDTMy6V/KGniNOQfGjEt3XfjAvP3bBFBT7o2Jh4NSdnY9PO7bOjFRRhHTczrFRNOUBE98g7WDRTQHBnFGdpcK6gOOE1LDKb5YU8X5N0UEGb4S6as8OPDRr3JafyYlEg3pLbWaKCYlLly/Rs/kUayusSFBooGw3YO69pGQdLFTABSIINFglzI=
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3915;6:TmhElVSrh/kcQpMqjlgcwaXogmyMHnwPR95BXSquamCyIzGuBqBmgHE+CiPZf3JhUP3xwwdaJS+uwuPtdM12kJlcqW30LCFCHbtND3p8Elt0xDwSxNiPw0XDdmm/avGaxy4pE9EhwGKwCp7TqFXT9XE+G4pIehenCk+BvY5tmg9VTlyHbcGKUgKETzAyiccMXJI3lGYJUEiv1GqJp2/E+2j3oJR5ekmhZZvh9Mk8Ph8Z3/7W4tKtKhpBjTPzws7AP4Kv431+a7YMcQZcJfjqnCZTgptowf+xGoOgcfjoFHow45xppixQstjIp6u2xEmtbAeg5MQ9QC9u0cHQtfdJ0ZO/dRuvNc/W4ZuQosasVZ2p5cU38Q9q3G28K8EE/6RlJStSFsaVIwCp3GJD/FMDWRvxv9Gx4A9bTDSECIwFLSokqwOJ0Mr+5Mq6aDHn2hCCNHXibirO03phxWNmswFZDA==;5:7zGxmAlBCoGbH2OvcWEr8Yqxgow/VqoNEcB5vW3VsJW9GvYrseDiDsUp46jAL3mSCa4onf4KwKX2nc7kK+F4qs4ohHZJXwdIifBMpYrQqB7IhFnuOsCYk9c8TUiAxrU5HBnIZOPHwfyPbxPRuAOuaKH7KjG0U1kYHbjenXnUG2Y=;7:JR3v0xsnkaq3ICUqgaWbu0kpIac7ZrNocDQWArYKOSTEiI6MNKh93Rtyy5Y+iTfvMsZR0qJ5TAOzcwfKp8l3Bebih+dZNRuvBEBPTIzEkWhU6d4m8Jzn78pz5+/MYS8jVIarH7QbDf6229tZVdBuM1CoG64/kdWnds2EhMfH2oUTJddZS39PQI7xuOw3Sy+yP2DAxwQiUvTLp6Jgdi69YBhk6oO1IesAL5ACKlKHJ0u6Ten24NVOZ8zqLm1K0m4+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 06:24:10.0018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4778ba2b-08e6-4235-c832-08d61d2f5bc7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX 6ULZ processor is a high-performance, ultra
cost-efficient consumer Linux processor featuring an
advanced implementation of a single Arm® Cortex®-A7 core,
which operates at speeds up to 900 MHz.

This patch adds basic MSL support for i.MX6ULZ, the
i.MX6ULZ has same soc_id as i.MX6ULL, and SRC_SBMR2 bit[6]
is to differentiate i.MX6ULZ from i.MX6ULL, 1'b1 means
i.MX6ULZ and 1'b0 means i.MX6ULL.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/anatop.c      | 20 ++++++++++++++++++++
 arch/arm/mach-imx/cpu.c         |  3 +++
 arch/arm/mach-imx/mach-imx6ul.c |  1 +
 arch/arm/mach-imx/mxc.h         |  7 +++++++
 arch/arm/mach-imx/pm-imx6.c     |  4 ++--
 5 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index 61f3d94..45d618a 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -31,6 +31,8 @@
 #define ANADIG_DIGPROG_IMX6SL	0x280
 #define ANADIG_DIGPROG_IMX7D	0x800
 
+#define SRC_SBMR2		0x1c
+
 #define BM_ANADIG_REG_2P5_ENABLE_WEAK_LINREG	0x40000
 #define BM_ANADIG_REG_2P5_ENABLE_PULLDOWN	0x8
 #define BM_ANADIG_REG_CORE_FET_ODRIVE		0x20000000
@@ -148,6 +150,24 @@ void __init imx_init_revision_from_anatop(void)
 		major_part = (digprog >> 8) & 0xf;
 		minor_part = digprog & 0xf;
 		revision = ((major_part + 1) << 4) | minor_part;
+
+		if ((digprog >> 16) == MXC_CPU_IMX6ULL) {
+			void __iomem *src_base;
+			u32 sbmr2;
+
+			np = of_find_compatible_node(NULL, NULL,
+						     "fsl,imx6ul-src");
+			src_base = of_iomap(np, 0);
+			WARN_ON(!src_base);
+			sbmr2 = readl_relaxed(src_base + SRC_SBMR2);
+			iounmap(src_base);
+
+			/* src_sbmr2 bit 6 is to identify if it is i.MX6ULZ */
+			if (sbmr2 & (1 << 6)) {
+				digprog &= ~(0xff << 16);
+				digprog |= (MXC_CPU_IMX6ULZ << 16);
+			}
+		}
 	}
 
 	mxc_set_cpu_type(digprog >> 16 & 0xff);
diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index c6b1bf9..c73593e 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -136,6 +136,9 @@ struct device * __init imx_soc_device_init(void)
 	case MXC_CPU_IMX6ULL:
 		soc_id = "i.MX6ULL";
 		break;
+	case MXC_CPU_IMX6ULZ:
+		soc_id = "i.MX6ULZ";
+		break;
 	case MXC_CPU_IMX6SLL:
 		soc_id = "i.MX6SLL";
 		break;
diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index 6cb8a22..4ffe3c8 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -90,6 +90,7 @@ static void __init imx6ul_init_late(void)
 static const char * const imx6ul_dt_compat[] __initconst = {
 	"fsl,imx6ul",
 	"fsl,imx6ull",
+	"fsl,imx6ulz",
 	NULL,
 };
 
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index 026e2ca..b130a53 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -40,6 +40,8 @@
 #define MXC_CPU_IMX6Q		0x63
 #define MXC_CPU_IMX6UL		0x64
 #define MXC_CPU_IMX6ULL		0x65
+/* virtual cpu id for i.mx6ulz */
+#define MXC_CPU_IMX6ULZ		0x6b
 #define MXC_CPU_IMX6SLL		0x67
 #define MXC_CPU_IMX7D		0x72
 
@@ -80,6 +82,11 @@ static inline bool cpu_is_imx6ull(void)
 	return __mxc_cpu_type == MXC_CPU_IMX6ULL;
 }
 
+static inline bool cpu_is_imx6ulz(void)
+{
+	return __mxc_cpu_type == MXC_CPU_IMX6ULZ;
+}
+
 static inline bool cpu_is_imx6sll(void)
 {
 	return __mxc_cpu_type == MXC_CPU_IMX6SLL;
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 529f4b5..87f45b9 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -313,7 +313,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 		if (cpu_is_imx6sl())
 			val |= BM_CLPCR_BYPASS_PMIC_READY;
 		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul() ||
-		    cpu_is_imx6ull() || cpu_is_imx6sll())
+		    cpu_is_imx6ull() || cpu_is_imx6sll() || cpu_is_imx6ulz())
 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
 		else
 			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
@@ -331,7 +331,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 		if (cpu_is_imx6sl() || cpu_is_imx6sx())
 			val |= BM_CLPCR_BYPASS_PMIC_READY;
 		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul() ||
-		    cpu_is_imx6ull() || cpu_is_imx6sll())
+		    cpu_is_imx6ull() || cpu_is_imx6sll() || cpu_is_imx6ulz())
 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
 		else
 			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
-- 
2.7.4

