Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0875C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E028214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cQIFzy5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E028214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeJJPIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:08:05 -0400
Received: from mail-he1eur01on0049.outbound.protection.outlook.com ([104.47.0.49]:18219
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726717AbeJJPIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkzLnxln/eM1dgawK1A1Aqswt8x5zMffupoLOmJN2Gc=;
 b=cQIFzy5oucu5VzATuKCZOFtWeVy1ZsqaCfpXxVnvBLw6iz3IarRaK+Fm/ziPzY6asQ3QkrfpsdxsQsY/PCJIplUGAOnFvUbwJVgoZBwF5Tgw2WeYD+bsjoYrGvCTaTdPOoTZKK5NC4p44OGCApP8WntB0C/JmxPVJaxSibbuuSg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ro-buh02.nxp.com (95.76.156.53) by
 AM4PR04MB1601.eurprd04.prod.outlook.com (2a01:111:e400:59e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.27; Wed, 10 Oct
 2018 07:46:59 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v11 1/5] dt-bindings: add binding for i.MX8MQ CCM
Date:   Wed, 10 Oct 2018 10:45:16 +0300
Message-Id: <1539157520-25081-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539157520-25081-1-git-send-email-abel.vesa@nxp.com>
References: <1539157520-25081-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: CWXP265CA0044.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2d::32) To AM4PR04MB1601.eurprd04.prod.outlook.com
 (2a01:111:e400:59e5::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b96415b-a5f2-4092-32dd-08d62e848fbc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR04MB1601;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;3:ITIi/30i2dGMXZ48GbsixroVjSh+oMQa7GAE6/x0jb541idlrcXz1xadbKLw1CLodkAXFtZx1gRpKamJQxjWDHFY/c0HNrjPcHxIc2KwCN5Qlich1EAjNaYPjSTN5LkLo9CbW78kimZdVq3KdOOsAphXzqL9ItSWLMrbdkmAniPcf0MQY9GWzMEwB7phJYT9S3obHkL7tlWNolwATf7tlP/Gx56O8y3d5yIJTX2Hh8aRUmhl0Kq+mWJIJfYOGdla;25:WiGgYQlbxSvycHshBNevxHelhmADa+gHELlsicMSoLau+BouXEjB+lKtlrYYL4dnBhRI/pid31sub3r82sjbGHaAzxNIfNCh4ll2cTGkpjeDc/jgyCmTq6XUIwE/YAwUIihO+B0w0z1yKMDBIiNPciD2ywxMle1BnQNMIhB468030bMsOYbEacaii1m7O6+I/c1bDpEHUYdwwX/eaY18bhHOCGpCCGQhJ727cl8Jv8qgyn4NxTR6aTNfEQom255V7CMjouMWCOTreMC0RbWP88p6A2hCdHGjn2Xfj6Obb99vd1U7QX4Xg56GmTpboeRzlNBdrZpd1cc+zppwT9uk8uuioDhkaKMCu3azZ57aF7s=;31:Kr9tY/0OdHgOH2lk63jgjPILbluab0vaSphT2+SSFwwyR8/p2m1lS0dV9RnmztjNQkPJT//bBhB4tHOuul1eoY9IBU2+STCxtD3rLK3RxkVvLtcXHQMB7FB10eRt8Mf3O5DU1a0e0FJeeAkLJOoD9CFrxrjST6f6sAilgtReyT+j/UAaqrfr1vTi0XBAWK6LLgRaC1VEZjB01D1crjRYFxAscVB+gFTuz8cKQHeaiLA=
X-MS-TrafficTypeDiagnostic: AM4PR04MB1601:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;20:MpNq0DXQEXUhPMZr6UpIfA/8u+OjtcFh7DyPCdkbo2suIBJ4bEuk9eiBaXHv3pIquBbwE2tnZP1e2j+JOgDwMlnu1itemuqZsd9MJ+6GmRSJgr0t4WEm5aTTDUKUiTuDV+l1LICtN2TR95LW7Wu75qYD8nQB2ZUJYhdX6zYFNXtgC7g+0XxKrrlV8euye0zWn2Rnpd5UactWLCAHmPAP7PK3bpphmDbXk6dmxtm/VnV7LO+ATVsAmqsi1Sx5PHdO8yJaSgHwMoRsaydjv9KwzIj94F93FdVH7ulNrtKxlMtMqXknwAdArfQ2qxFu6biOJsohQLC/n4kBv27qAAiSLfJmtkxW4JtMyyekrEuu3UfuVGjp1QklxL/smTmoxB8t0tvYTCzKCewDcsn5oVn2t8GE66uRfhwO8WyJGY7nt3vPyDMGR+ui4b7reNb0Tc23lvvwADpZuH4fEIjHHCgLTr7tVmLdrrJSRpW/pKmLPek+6LTLJ+CSonqEeaZhiIrX;4:yeSVHpnghMuxYqex3H9gl7M1esDMPCv2ZaS3hxKKu1m2xs6nRMgeGjs7ZpjmEF0YKfLZfNBDs/dRsptBo4CreefzQjOOmXXt1cHVQvEQvmd8BT1317+cveidebG36pFE6OIxpcLliuQYvHDzYIPsSEDVEL7CKXaVFj9ib1inQdkawtMyIxZWV/fUnfvSwRfIkXtvGNfbxDsgznt1OlSaYVNOfPcMfCZGpzAnVsyW/vrWitkYbH+p+OOusXxK3Ve4G1bkcI6OQWCuZ0C39nV3N7V4/8TeqJpQ4JNxd5RK5pUguWEQKppvjTgsUPqiT27t
X-Microsoft-Antispam-PRVS: <AM4PR04MB16015FC4F6502DA6DAB36BC8F6E00@AM4PR04MB1601.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM4PR04MB1601;BCL:0;PCL:0;RULEID:;SRVR:AM4PR04MB1601;
X-Forefront-PRVS: 08213D42D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(396003)(376002)(189003)(199004)(7696005)(51416003)(52116002)(48376002)(4326008)(6486002)(76176011)(105586002)(50466002)(25786009)(16586007)(478600001)(11346002)(86362001)(186003)(386003)(486006)(16526019)(44832011)(97736004)(26005)(106356001)(446003)(68736007)(2616005)(4744004)(2906002)(956004)(476003)(47776003)(7416002)(50226002)(66066001)(7736002)(53936002)(81166006)(81156014)(8676002)(110136005)(36756003)(54906003)(316002)(6636002)(6666003)(3846002)(305945005)(8936002)(5660300001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR04MB1601;H:fsr-ub1664-175.ro-buh02.nxp.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR04MB1601;23:3Djob3njD1B+Oi2kvlLB623sNY24tchw4QC2cMG6S?=
 =?us-ascii?Q?vnZTSb+iBLPkZEApzgBWLuJUo/HcIdzvRSwSAL7BH7UnV/8UVLOqDshNJigP?=
 =?us-ascii?Q?4uJrbv1FtMkigpBaa6eifKcrC4QFRaLlXyDGJXajnfCs+4jI65ccduxuqbGR?=
 =?us-ascii?Q?OukCzUiObuHWN+DghkA2Kynjom2d4zRW3XvImIP2+z9PMx0bfZ4msl6WrV2Z?=
 =?us-ascii?Q?kBsSTKR61eq1DNe8UA+ks4oK55SXkKyIbVdjDh0C/XZF/1UYEXsZN0Q/qRj2?=
 =?us-ascii?Q?EfdJQYJPS7UDtx3t766qmE3534kr7s6louYgO0sUUFYYFwgmosQUwAIRpPm6?=
 =?us-ascii?Q?TJK0xhNhc1zGWTtBMn6D3ZwycoDoPHKC6fRhc3FMeOm+oYykn95eMYvGv+62?=
 =?us-ascii?Q?vWYektjDD9NF2nWUc4ayVtI0Gee0BQhvfGOMK5A3qJRcwo/JsHxR9VB5QB6n?=
 =?us-ascii?Q?flZNcLZ0Q4UQd9su6qkRuBU29iK86OFgS82bcBOz8jjgkeHsDbDcRlBL2Zxj?=
 =?us-ascii?Q?5UZzayCmFMdCBf5EbMVNX2T7wl4WmCTCsiWahbTFt7V8FNJIE/vZxNGzl4VD?=
 =?us-ascii?Q?NpCkXOsAJedp2l5UoQ8e+cDNtcyV7fQDHhs0CLZtqd0/QA+AyGh16x7uNPMH?=
 =?us-ascii?Q?27hD16C4zNJG8NmEycxQDZ/uCm97hXq9RIA9XryJXAdAJnrkvxvMWohNFfp5?=
 =?us-ascii?Q?NeKVV3Z5V0X7O80DU90GkQclAldlU1lPO8pHBXGELjsQTJoXlmhiIaeDIUr3?=
 =?us-ascii?Q?dhCTp50EmNqC2kuA6MJW7macLes8pZWm/iFFjeeYMbWX2v0LV0W600SfYa0+?=
 =?us-ascii?Q?jllvqS3IFs713EbLfztO1rS+Hkv1tmoUVZMJDToAZ37CbVAZdnQGZBhOgCUI?=
 =?us-ascii?Q?JZZ7xnQJ4zsehPsZw/ajqtL4zJvC10nl/7sit73Kebn42DKqMM9kKRWa5ROb?=
 =?us-ascii?Q?Mr7LcE8pT78c71dss0p62VKiLlnN8P0K45pwB8ls/yf/vXovLhvB80OQaSY2?=
 =?us-ascii?Q?X20A4eVvMdpTu5oeB72bsYWbF1UxWiJJbR1gviPgAtzZzKN5OxDBKfzkews8?=
 =?us-ascii?Q?Kps3T1Porkkhuxqb6BCmaGdhCN6uHj5148aa+uRZEwcM8ZI7uwB32KxCF2Hc?=
 =?us-ascii?Q?qKpcEfu4+gS5/yLx4HeDGUU9DnMdXa5tPbPVey6TYzCP4q6lwNkggfLWTbGO?=
 =?us-ascii?Q?2YAn1a/Wd4TprDBA3dOr5Lq4PlgQtCdtYg0vD1eD8YTWKVCZQMnazzwDEBkP?=
 =?us-ascii?Q?DW1Sa2G14gFt5w1NrQ=3D?=
X-Microsoft-Antispam-Message-Info: 8T/JgqfC4QHlSi36VCfuv7nk2f7YW3SXRmljSVCIP2qKtSPHbRyywVypSip/MBu5OrGEVza1VHfR6U45gB0QpdEy1i5ooLJqF4eDmCAjho0lXLyE6gJutJ3wr+6K216Kxvm/AWlEXYoNT+aacjjynyw/ScbpLNQzjMT1VMQgcKQuDCnPD0Nd1YlnZd8CZ9KFudH/6mUNU2jrf4SoZDp+M9KuMZzSWD7420pl+8d2npqXAAL32x4yg5wWjANEikQt7SxqLp9lF8H8VbJa//lCOmVslWd/Ln1OyfH024CXGgfLSH06+h1ETN546+gXIF1JFlzsGqUH/OCHfgyAHx8IQ0h/EECrLMyOvVNtAk6YgAM=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;6:jTYEFda5Loeh1VZK/E6ZVLXOogCizCvkbbFff8b2q8VPa+uxlZcVga1JBUGOgDBuHhfjHa9VDFTNopNEuQcXBZ58MSYPEChE0uPaxbixLKVaFzlZzgY3vdWJVg6wbGKeaOketG5vHgJqdq0tL02mzroOHPYddjd0iqjddtgVl34UujeNgb5IBhi7uEnVVmlFL6/MB78I9lNpMnE/XVcA9+8xYHzVagiXqqRAZPgLTPx5O9hmhh/uBsfi9jwWJIFTN0YzT/EDW3WwWOtNUdSZnycFhAnofzfZlda6nEaGtwyuZPfPwNTvd7Oh1OhnLyykPqm0xjmfiIMzJDnz0NMQuP5RqRC8dzSdHJvBOKjipPULTGc6vlz11hix2BkO6WTQmoOBsQAcLRQ7wzn06Gn3WUPXU/guufNjd40wnG19ENWD0e2QKjaOa0U7eibFb6bEafNmwn+EkXIFzOG11l6ECg==;5:zY2RRaHwE2Fk0RLxxXY2lI+GwCVMIpPnjpo9P2gWTRi82nmPdTsbv/KV/D+PPEIBbHHh2fqSCV3UjF6x8N9l1UKXQeK1nFfQ+79FoQWL9v1vub9qlyVpXQ3hpkSFDb1C99w5vqM+fTzOPR0411MZUod3yV3g8R69RlW5sar+lqE=;7:BVy0B63AetJ3q7cXg7TnromH4cjVpJ3am1srxGwVKgxU31hweDK+vPNDlZkX1vpezwx2ESXTB2DlcMB03ON208DzAK02xXtnBhk7oZ/nIiLnFDt8QHc3KKvgo4ORSUId2vVI2PfXQ6Oo7RRGRU5P0EqkFIt6rOGM4PCAbQjBGrMdS/W5UplDaRuHH8hreTs3vNF0qrwzY3vxs2ASa0Sd+3FjX90GfOkoKch7SZcygcbbwqwrHSBKkfiAsbczJxYU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2018 07:46:59.0861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b96415b-a5f2-4092-32dd-08d62e848fbc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR04MB1601
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This adds the binding for the i.MX8MQ Clock Controller Module.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/imx8mq-clock.txt     |  20 ++
 include/dt-bindings/clock/imx8mq-clock.h           | 395 +++++++++++++++++++++
 2 files changed, 415 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.txt
 create mode 100644 include/dt-bindings/clock/imx8mq-clock.h

diff --git a/Documentation/devicetree/bindings/clock/imx8mq-clock.txt b/Documentation/devicetree/bindings/clock/imx8mq-clock.txt
new file mode 100644
index 0000000..52de826
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx8mq-clock.txt
@@ -0,0 +1,20 @@
+* Clock bindings for NXP i.MX8M Quad
+
+Required properties:
+- compatible: Should be "fsl,imx8mq-ccm"
+- reg: Address and length of the register set
+- #clock-cells: Should be <1>
+- clocks: list of clock specifiers, must contain an entry for each required
+          entry in clock-names
+- clock-names: should include the following entries:
+    - "ckil"
+    - "osc_25m"
+    - "osc_27m"
+    - "clk_ext1"
+    - "clk_ext2"
+    - "clk_ext3"
+    - "clk_ext4"
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.  See include/dt-bindings/clock/imx8mq-clock.h
+for the full list of i.MX8M Quad clock IDs.
diff --git a/include/dt-bindings/clock/imx8mq-clock.h b/include/dt-bindings/clock/imx8mq-clock.h
new file mode 100644
index 0000000..b53be41
--- /dev/null
+++ b/include/dt-bindings/clock/imx8mq-clock.h
@@ -0,0 +1,395 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017 NXP
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMX8MQ_H
+#define __DT_BINDINGS_CLOCK_IMX8MQ_H
+
+#define IMX8MQ_CLK_DUMMY		0
+#define IMX8MQ_CLK_32K			1
+#define IMX8MQ_CLK_25M			2
+#define IMX8MQ_CLK_27M			3
+#define IMX8MQ_CLK_EXT1			4
+#define IMX8MQ_CLK_EXT2			5
+#define IMX8MQ_CLK_EXT3			6
+#define IMX8MQ_CLK_EXT4			7
+
+/* ANAMIX PLL clocks */
+/* FRAC PLLs */
+/* ARM PLL */
+#define IMX8MQ_ARM_PLL_REF_SEL		8
+#define IMX8MQ_ARM_PLL_REF_DIV		9
+#define IMX8MQ_ARM_PLL			10
+#define IMX8MQ_ARM_PLL_BYPASS		11
+#define IMX8MQ_ARM_PLL_OUT		12
+
+/* GPU PLL */
+#define IMX8MQ_GPU_PLL_REF_SEL		13
+#define IMX8MQ_GPU_PLL_REF_DIV		14
+#define IMX8MQ_GPU_PLL			15
+#define IMX8MQ_GPU_PLL_BYPASS		16
+#define IMX8MQ_GPU_PLL_OUT		17
+
+/* VPU PLL */
+#define IMX8MQ_VPU_PLL_REF_SEL		18
+#define IMX8MQ_VPU_PLL_REF_DIV		19
+#define IMX8MQ_VPU_PLL			20
+#define IMX8MQ_VPU_PLL_BYPASS		21
+#define IMX8MQ_VPU_PLL_OUT		22
+
+/* AUDIO PLL1 */
+#define IMX8MQ_AUDIO_PLL1_REF_SEL	23
+#define IMX8MQ_AUDIO_PLL1_REF_DIV	24
+#define IMX8MQ_AUDIO_PLL1		25
+#define IMX8MQ_AUDIO_PLL1_BYPASS	26
+#define IMX8MQ_AUDIO_PLL1_OUT		27
+
+/* AUDIO PLL2 */
+#define IMX8MQ_AUDIO_PLL2_REF_SEL	28
+#define IMX8MQ_AUDIO_PLL2_REF_DIV	29
+#define IMX8MQ_AUDIO_PLL2		30
+#define IMX8MQ_AUDIO_PLL2_BYPASS	31
+#define IMX8MQ_AUDIO_PLL2_OUT		32
+
+/* VIDEO PLL1 */
+#define IMX8MQ_VIDEO_PLL1_REF_SEL	33
+#define IMX8MQ_VIDEO_PLL1_REF_DIV	34
+#define IMX8MQ_VIDEO_PLL1		35
+#define IMX8MQ_VIDEO_PLL1_BYPASS	36
+#define IMX8MQ_VIDEO_PLL1_OUT		37
+
+/* SYS1 PLL */
+#define IMX8MQ_SYS1_PLL1_REF_SEL	38
+#define IMX8MQ_SYS1_PLL1_REF_DIV	39
+#define IMX8MQ_SYS1_PLL1		40
+#define IMX8MQ_SYS1_PLL1_OUT		41
+#define IMX8MQ_SYS1_PLL1_OUT_DIV	42
+#define IMX8MQ_SYS1_PLL2		43
+#define IMX8MQ_SYS1_PLL2_DIV		44
+#define IMX8MQ_SYS1_PLL2_OUT		45
+
+/* SYS2 PLL */
+#define IMX8MQ_SYS2_PLL1_REF_SEL	46
+#define IMX8MQ_SYS2_PLL1_REF_DIV	47
+#define IMX8MQ_SYS2_PLL1		48
+#define IMX8MQ_SYS2_PLL1_OUT		49
+#define IMX8MQ_SYS2_PLL1_OUT_DIV	50
+#define IMX8MQ_SYS2_PLL2		51
+#define IMX8MQ_SYS2_PLL2_DIV		52
+#define IMX8MQ_SYS2_PLL2_OUT		53
+
+/* SYS3 PLL */
+#define IMX8MQ_SYS3_PLL1_REF_SEL	54
+#define IMX8MQ_SYS3_PLL1_REF_DIV	55
+#define IMX8MQ_SYS3_PLL1		56
+#define IMX8MQ_SYS3_PLL1_OUT		57
+#define IMX8MQ_SYS3_PLL1_OUT_DIV	58
+#define IMX8MQ_SYS3_PLL2		59
+#define IMX8MQ_SYS3_PLL2_DIV		60
+#define IMX8MQ_SYS3_PLL2_OUT		61
+
+/* DRAM PLL */
+#define IMX8MQ_DRAM_PLL1_REF_SEL	62
+#define IMX8MQ_DRAM_PLL1_REF_DIV	63
+#define IMX8MQ_DRAM_PLL1		64
+#define IMX8MQ_DRAM_PLL1_OUT		65
+#define IMX8MQ_DRAM_PLL1_OUT_DIV	66
+#define IMX8MQ_DRAM_PLL2		67
+#define IMX8MQ_DRAM_PLL2_DIV		68
+#define IMX8MQ_DRAM_PLL2_OUT		69
+
+/* SYS PLL DIV */
+#define IMX8MQ_SYS1_PLL_40M		70
+#define IMX8MQ_SYS1_PLL_80M		71
+#define IMX8MQ_SYS1_PLL_100M		72
+#define IMX8MQ_SYS1_PLL_133M		73
+#define IMX8MQ_SYS1_PLL_160M		74
+#define IMX8MQ_SYS1_PLL_200M		75
+#define IMX8MQ_SYS1_PLL_266M		76
+#define IMX8MQ_SYS1_PLL_400M		77
+#define IMX8MQ_SYS1_PLL_800M		78
+
+#define IMX8MQ_SYS2_PLL_50M		79
+#define IMX8MQ_SYS2_PLL_100M		80
+#define IMX8MQ_SYS2_PLL_125M		81
+#define IMX8MQ_SYS2_PLL_166M		82
+#define IMX8MQ_SYS2_PLL_200M		83
+#define IMX8MQ_SYS2_PLL_250M		84
+#define IMX8MQ_SYS2_PLL_333M		85
+#define IMX8MQ_SYS2_PLL_500M		86
+#define IMX8MQ_SYS2_PLL_1000M		87
+
+/* CCM ROOT clocks */
+/* A53 */
+#define IMX8MQ_CLK_A53_SRC		88
+#define IMX8MQ_CLK_A53_CG		89
+#define IMX8MQ_CLK_A53_DIV		90
+/* M4 */
+#define IMX8MQ_CLK_M4_SRC		91
+#define IMX8MQ_CLK_M4_CG		92
+#define IMX8MQ_CLK_M4_DIV		93
+/* VPU */
+#define IMX8MQ_CLK_VPU_SRC		94
+#define IMX8MQ_CLK_VPU_CG		95
+#define IMX8MQ_CLK_VPU_DIV		96
+/* GPU CORE */
+#define IMX8MQ_CLK_GPU_CORE_SRC		97
+#define IMX8MQ_CLK_GPU_CORE_CG		98
+#define IMX8MQ_CLK_GPU_CORE_DIV		99
+/* GPU SHADER */
+#define IMX8MQ_CLK_GPU_SHADER_SRC	100
+#define IMX8MQ_CLK_GPU_SHADER_CG	101
+#define IMX8MQ_CLK_GPU_SHADER_DIV	102
+
+/* BUS TYPE */
+/* MAIN AXI */
+#define IMX8MQ_CLK_MAIN_AXI		103
+/* ENET AXI */
+#define IMX8MQ_CLK_ENET_AXI		104
+/* NAND_USDHC_BUS */
+#define IMX8MQ_CLK_NAND_USDHC_BUS	105
+/* VPU BUS */
+#define IMX8MQ_CLK_VPU_BUS		106
+/* DISP_AXI */
+#define IMX8MQ_CLK_DISP_AXI		107
+/* DISP APB */
+#define IMX8MQ_CLK_DISP_APB		108
+/* DISP RTRM */
+#define IMX8MQ_CLK_DISP_RTRM		109
+/* USB_BUS */
+#define IMX8MQ_CLK_USB_BUS		110
+/* GPU_AXI */
+#define IMX8MQ_CLK_GPU_AXI		111
+/* GPU_AHB */
+#define IMX8MQ_CLK_GPU_AHB		112
+/* NOC */
+#define IMX8MQ_CLK_NOC			113
+/* NOC_APB */
+#define IMX8MQ_CLK_NOC_APB		115
+
+/* AHB */
+#define IMX8MQ_CLK_AHB			116
+/* AUDIO AHB */
+#define IMX8MQ_CLK_AUDIO_AHB		117
+
+/* DRAM_ALT */
+#define IMX8MQ_CLK_DRAM_ALT		118
+/* DRAM APB */
+#define IMX8MQ_CLK_DRAM_APB		119
+/* VPU_G1 */
+#define IMX8MQ_CLK_VPU_G1		120
+/* VPU_G2 */
+#define IMX8MQ_CLK_VPU_G2		121
+/* DISP_DTRC */
+#define IMX8MQ_CLK_DISP_DTRC		122
+/* DISP_DC8000 */
+#define IMX8MQ_CLK_DISP_DC8000		123
+/* PCIE_CTRL */
+#define IMX8MQ_CLK_PCIE1_CTRL		124
+/* PCIE_PHY */
+#define IMX8MQ_CLK_PCIE1_PHY		125
+/* PCIE_AUX */
+#define IMX8MQ_CLK_PCIE1_AUX		126
+/* DC_PIXEL */
+#define IMX8MQ_CLK_DC_PIXEL		127
+/* LCDIF_PIXEL */
+#define IMX8MQ_CLK_LCDIF_PIXEL		128
+/* SAI1~6 */
+#define IMX8MQ_CLK_SAI1			129
+
+#define IMX8MQ_CLK_SAI2			130
+
+#define IMX8MQ_CLK_SAI3			131
+
+#define IMX8MQ_CLK_SAI4			132
+
+#define IMX8MQ_CLK_SAI5			133
+
+#define IMX8MQ_CLK_SAI6			134
+/* SPDIF1 */
+#define IMX8MQ_CLK_SPDIF1		135
+/* SPDIF2 */
+#define IMX8MQ_CLK_SPDIF2		136
+/* ENET_REF */
+#define IMX8MQ_CLK_ENET_REF		137
+/* ENET_TIMER */
+#define IMX8MQ_CLK_ENET_TIMER		138
+/* ENET_PHY */
+#define IMX8MQ_CLK_ENET_PHY_REF		139
+/* NAND */
+#define IMX8MQ_CLK_NAND			140
+/* QSPI */
+#define IMX8MQ_CLK_QSPI			141
+/* USDHC1 */
+#define IMX8MQ_CLK_USDHC1		142
+/* USDHC2 */
+#define IMX8MQ_CLK_USDHC2		143
+/* I2C1 */
+#define IMX8MQ_CLK_I2C1			144
+/* I2C2 */
+#define IMX8MQ_CLK_I2C2			145
+/* I2C3 */
+#define IMX8MQ_CLK_I2C3			146
+/* I2C4 */
+#define IMX8MQ_CLK_I2C4			147
+/* UART1 */
+#define IMX8MQ_CLK_UART1		148
+/* UART2 */
+#define IMX8MQ_CLK_UART2		149
+/* UART3 */
+#define IMX8MQ_CLK_UART3		150
+/* UART4 */
+#define IMX8MQ_CLK_UART4		151
+/* USB_CORE_REF */
+#define IMX8MQ_CLK_USB_CORE_REF		152
+/* USB_PHY_REF */
+#define IMX8MQ_CLK_USB_PHY_REF		163
+/* ECSPI1 */
+#define IMX8MQ_CLK_ECSPI1		164
+/* ECSPI2 */
+#define IMX8MQ_CLK_ECSPI2		165
+/* PWM1 */
+#define IMX8MQ_CLK_PWM1			166
+/* PWM2 */
+#define IMX8MQ_CLK_PWM2			167
+/* PWM3 */
+#define IMX8MQ_CLK_PWM3			168
+/* PWM4 */
+#define IMX8MQ_CLK_PWM4			169
+/* GPT1 */
+#define IMX8MQ_CLK_GPT1			170
+/* WDOG */
+#define IMX8MQ_CLK_WDOG			171
+/* WRCLK */
+#define IMX8MQ_CLK_WRCLK		172
+/* DSI_CORE */
+#define IMX8MQ_CLK_DSI_CORE		173
+/* DSI_PHY */
+#define IMX8MQ_CLK_DSI_PHY_REF		174
+/* DSI_DBI */
+#define IMX8MQ_CLK_DSI_DBI		175
+/*DSI_ESC */
+#define IMX8MQ_CLK_DSI_ESC		176
+/* CSI1_CORE */
+#define IMX8MQ_CLK_CSI1_CORE		177
+/* CSI1_PHY */
+#define IMX8MQ_CLK_CSI1_PHY_REF		178
+/* CSI_ESC */
+#define IMX8MQ_CLK_CSI1_ESC		179
+/* CSI2_CORE */
+#define IMX8MQ_CLK_CSI2_CORE		170
+/* CSI2_PHY */
+#define IMX8MQ_CLK_CSI2_PHY_REF		181
+/* CSI2_ESC */
+#define IMX8MQ_CLK_CSI2_ESC		182
+/* PCIE2_CTRL */
+#define IMX8MQ_CLK_PCIE2_CTRL		183
+/* PCIE2_PHY */
+#define IMX8MQ_CLK_PCIE2_PHY		184
+/* PCIE2_AUX */
+#define IMX8MQ_CLK_PCIE2_AUX		185
+/* ECSPI3 */
+#define IMX8MQ_CLK_ECSPI3		186
+
+/* CCGR clocks */
+#define IMX8MQ_CLK_A53_ROOT			187
+#define IMX8MQ_CLK_DRAM_ROOT			188
+#define IMX8MQ_CLK_ECSPI1_ROOT			189
+#define IMX8MQ_CLK_ECSPI2_ROOT			180
+#define IMX8MQ_CLK_ECSPI3_ROOT			181
+#define IMX8MQ_CLK_ENET1_ROOT			182
+#define IMX8MQ_CLK_GPT1_ROOT			193
+#define IMX8MQ_CLK_I2C1_ROOT			194
+#define IMX8MQ_CLK_I2C2_ROOT			195
+#define IMX8MQ_CLK_I2C3_ROOT			196
+#define IMX8MQ_CLK_I2C4_ROOT			197
+#define IMX8MQ_CLK_M4_ROOT			198
+#define IMX8MQ_CLK_PCIE1_ROOT			199
+#define IMX8MQ_CLK_PCIE2_ROOT			200
+#define IMX8MQ_CLK_PWM1_ROOT			201
+#define IMX8MQ_CLK_PWM2_ROOT			202
+#define IMX8MQ_CLK_PWM3_ROOT			203
+#define IMX8MQ_CLK_PWM4_ROOT			204
+#define IMX8MQ_CLK_QSPI_ROOT			205
+#define IMX8MQ_CLK_SAI1_ROOT			206
+#define IMX8MQ_CLK_SAI2_ROOT			207
+#define IMX8MQ_CLK_SAI3_ROOT			208
+#define IMX8MQ_CLK_SAI4_ROOT			209
+#define IMX8MQ_CLK_SAI5_ROOT			210
+#define IMX8MQ_CLK_SAI6_ROOT			212
+#define IMX8MQ_CLK_UART1_ROOT			213
+#define IMX8MQ_CLK_UART2_ROOT			214
+#define IMX8MQ_CLK_UART3_ROOT			215
+#define IMX8MQ_CLK_UART4_ROOT			216
+#define IMX8MQ_CLK_USB1_CTRL_ROOT		217
+#define IMX8MQ_CLK_USB2_CTRL_ROOT		218
+#define IMX8MQ_CLK_USB1_PHY_ROOT		219
+#define IMX8MQ_CLK_USB2_PHY_ROOT		220
+#define IMX8MQ_CLK_USDHC1_ROOT			221
+#define IMX8MQ_CLK_USDHC2_ROOT			222
+#define IMX8MQ_CLK_WDOG1_ROOT			223
+#define IMX8MQ_CLK_WDOG2_ROOT			224
+#define IMX8MQ_CLK_WDOG3_ROOT			225
+#define IMX8MQ_CLK_GPU_ROOT			226
+#define IMX8MQ_CLK_HEVC_ROOT			227
+#define IMX8MQ_CLK_AVC_ROOT			228
+#define IMX8MQ_CLK_VP9_ROOT			229
+#define IMX8MQ_CLK_HEVC_INTER_ROOT		230
+#define IMX8MQ_CLK_DISP_ROOT			231
+#define IMX8MQ_CLK_HDMI_ROOT			232
+#define IMX8MQ_CLK_HDMI_PHY_ROOT		233
+#define IMX8MQ_CLK_VPU_DEC_ROOT			234
+#define IMX8MQ_CLK_CSI1_ROOT			235
+#define IMX8MQ_CLK_CSI2_ROOT			236
+#define IMX8MQ_CLK_RAWNAND_ROOT			237
+#define IMX8MQ_CLK_SDMA1_ROOT			238
+#define IMX8MQ_CLK_SDMA2_ROOT			239
+#define IMX8MQ_CLK_VPU_G1_ROOT			240
+#define IMX8MQ_CLK_VPU_G2_ROOT			241
+
+/* SCCG PLL GATE */
+#define IMX8MQ_SYS1_PLL_OUT			232
+#define IMX8MQ_SYS2_PLL_OUT			243
+#define IMX8MQ_SYS3_PLL_OUT			244
+#define IMX8MQ_DRAM_PLL_OUT			245
+
+#define IMX8MQ_GPT_3M_CLK			246
+
+#define IMX8MQ_CLK_IPG_ROOT			247
+#define IMX8MQ_CLK_IPG_AUDIO_ROOT		248
+#define IMX8MQ_CLK_SAI1_IPG			249
+#define IMX8MQ_CLK_SAI2_IPG			250
+#define IMX8MQ_CLK_SAI3_IPG			251
+#define IMX8MQ_CLK_SAI4_IPG			252
+#define IMX8MQ_CLK_SAI5_IPG			253
+#define IMX8MQ_CLK_SAI6_IPG			254
+
+/* DSI AHB/IPG clocks */
+/* rxesc clock */
+#define IMX8MQ_CLK_DSI_AHB			255
+/* txesc clock */
+#define IMX8MQ_CLK_DSI_IPG_DIV                  256
+
+#define IMX8MQ_CLK_TMU_ROOT			265
+
+/* Display root clocks */
+#define IMX8MQ_CLK_DISP_AXI_ROOT		266
+#define IMX8MQ_CLK_DISP_APB_ROOT		267
+#define IMX8MQ_CLK_DISP_RTRM_ROOT		268
+
+#define IMX8MQ_CLK_OCOTP_ROOT			269
+
+#define IMX8MQ_CLK_DRAM_ALT_ROOT		270
+#define IMX8MQ_CLK_DRAM_CORE			271
+
+#define IMX8MQ_CLK_MU_ROOT			272
+#define IMX8MQ_VIDEO2_PLL_OUT			273
+
+#define IMX8MQ_CLK_CLKO2			274
+
+#define IMX8MQ_CLK_NAND_USDHC_BUS_RAWNAND_CLK	275
+
+#define IMX8MQ_CLK_END				276
+#endif /* __DT_BINDINGS_CLOCK_IMX8MQ_H */
-- 
2.7.4

