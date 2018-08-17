Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CD1C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5632185A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bZlpcGQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5632185A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeHQRPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:15:06 -0400
Received: from mail-he1eur01on0045.outbound.protection.outlook.com ([104.47.0.45]:15904
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727410AbeHQRPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1CEkcKMXuHIkq1FzzQ5ZU4O0OIi6VqSJIBtUB9d7JQ=;
 b=bZlpcGQfQgj9Awudf0bS74tGwpVHDTv59sNdDtMldmmW8ZPLpEHkp/MPikHQ+9G0DRep3mfl4/s9SbvuLmQrmqKG1j/QOT8MiPArsZxMmLSFFjX1aTYFTuqyFe7S6pgN5AbBVEfkVd6Qfim571kK6ijOrKO/Dl0BLkIFykAsfPY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 AM4PR04MB1601.eurprd04.prod.outlook.com (2a01:111:e400:59e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.23; Fri, 17 Aug
 2018 14:11:25 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v5 1/5] dt-bindings: add binding for i.MX8MQ CCM
Date:   Fri, 17 Aug 2018 17:10:42 +0300
Message-Id: <1534515046-18529-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534515046-18529-1-git-send-email-abel.vesa@nxp.com>
References: <1534515046-18529-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1PR05CA0200.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::24) To AM4PR04MB1601.eurprd04.prod.outlook.com
 (2a01:111:e400:59e5::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1d04201-3778-4d55-d50c-08d6044b5269
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR04MB1601;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;3:eH++w1UiAaGTGfwit3J3yIT/m67F64URJQgaf9Pe46GEr0dS3UrkJrFsbxhp/emcnggiMCUWkIddYSQujT+0C7VODdDyznO2M6BSP5XhwSkfj6Y+jIeffZ6s9y35LsZp5xLkaQvaaMEgBrdAnsAnsh2PSY+OuSIimwhIZpxA+qWRYquNTSeW8cbnllelAdIjNMy5Zia7etZFcGNb+yvYGQuxP8P6vnW2SND2U3VOsx565m2FvpE8SWGeLB13Rxjb;25:RLl/LrQL+J+RTD/MZjSK3WrATJB2tqleWiH3zyrwwyxuKvdX4P63APUBGa1KpFOqGBZKl1bQPMHh30ShpsCvl0XaVE96QrLy2/b/8PA0lwdtAiRh72VKax5jf29U9Vq/Th0dmsRI5dAh5pGBReTmNBp3TKELu26SQxTe0gIfjDYYYomZ3gKSIqw9czP7tUGYSbM5kr+7UkNCtYDSjLGAu1P2I5+XTGZpi9Ni13z5WR30JruWZAxH3eEzzZtGvxfb4A0t1JZHvScZfWTQNidzutpwHsOeQAxpXyevnAkzgygGq11G+0oBYAGABK+aVZy684gYkN0H5st7Mq1sBCKH1w==;31:mZAHilXOJOmxm+4OWQ4/wLhLZ+DxeFnI9VAaOlmrx6Zr+KOhq/5YZNEd7p6s+aw0AL7yMLMkBUJB1PyF9Fi23x099+ru+lEVfJT6BwnzZK7biSYcSvI1Q3rWEWUTmIL+WVrKari2OT7+hojh3xIe6BTCkjQwKQBLEk2Qs/yT/oIGLhYmDcygP2yuxY0uM5Ih/FVoob8rgkivzZVfMklKn7Fq9tyvO41tWKMvfFVFjh4=
X-MS-TrafficTypeDiagnostic: AM4PR04MB1601:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;20:WgyCYC8xQO9pa73DhoXSXbhqeKHqdAwHwq+m7gUBTJRG3+rThvStspJu0TxEwV5TdnAJiCoJcXJ2LpsA3mJ9M/oVCTVDBG4eAFoFKdl7YK/4lpODYvo+V70m0+ImQvDdmq2n3GEcLhR1sBRlWLDWGUAjub/NXyAyGzA/D9sqmOOURlXp+kmrUUquA2kqDkwMo84n/5c9kMeWme628d2AqdlMzy+1jS229xmYVc/2wBgNKzIxP3JwbWdYNDX+1TqArv/wcvitigjBkbDFVFriFNk+eRE5bgmcu5acagHD5IlCcEZ7puWQMGs160KTAZeOuja5RanVHaaB07jLC+crVDTPRjB/1MI/26IkN8KQblQAI7b5H3Z6OehNdkl2MAL+vTLGC4YZpJn/mCZK/m75ze7doxklQiMyAve71Xzw4F6ahRcu/wYLMxhS12mwo2WdfSUcb01TS+Amrmq5ORqArqw/483KcZtF96v2MKeGjF6xMdFR2lYfvtbh53+fR8oz;4:Oe6OCDLmzd7jOhoLq2pkkggBNPhtr6YM92K7cs0Vy51gtuZMUQ6bZtTHDlIMlD7134oEqYfvKMjUT9BnF6zUgXvMrxDs7b1S1TbOhacIbMfIBJdDlk6p4lXKIRoWYSrvT1K/fkZmFpglYX7LQxnI892l8ITHSmZjvISdJUGX0lmUSz+oU7WZr3mGB8wEHNX5K8xV6z/1uVzR4mGIfZH9UfaIEjuv18sP03O+0n0sInbpB5+it3f9aqcolMdtxHbpyF5QjUpzH7+7Vz8WOqR9MPDxNVT9QSOFRx8J9/2IaBecsJ2r5bCAavVSOFvOwFY6
X-Microsoft-Antispam-PRVS: <AM4PR04MB1601E113755A29618DE6A6B6F63D0@AM4PR04MB1601.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301062)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:AM4PR04MB1601;BCL:0;PCL:0;RULEID:;SRVR:AM4PR04MB1601;
X-Forefront-PRVS: 076777155F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(39860400002)(376002)(199004)(189003)(50226002)(4326008)(50466002)(105586002)(51416003)(52116002)(6512007)(48376002)(76176011)(106356001)(86362001)(6116002)(6506007)(3846002)(68736007)(6486002)(36756003)(386003)(110136005)(478600001)(6636002)(97736004)(66066001)(7736002)(54906003)(956004)(25786009)(6666003)(316002)(305945005)(16586007)(16526019)(5660300001)(486006)(476003)(2616005)(26005)(7416002)(186003)(53936002)(2906002)(8676002)(81156014)(44832011)(446003)(8936002)(81166006)(47776003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR04MB1601;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR04MB1601;23:+gluTCGCgpjfWBBx9C1gEknys27ES5GgIg6hCPvui?=
 =?us-ascii?Q?+b08qaHNSLDUhl9D9ShoVD7aW3bkFAmd3wzyLs/vTCVTp5TQaZk5xqJ/g47o?=
 =?us-ascii?Q?TElrZyqf33Xpx5xL2LQECN+bQBmy7qiL6DsEIyF15wyWDp9O9UfKuR1nMBfs?=
 =?us-ascii?Q?xCa5Kb9JAfb11OXL0ghBgnxFchmsXFQLrZI93ILRhuY21rNRnN1jALnuri/s?=
 =?us-ascii?Q?y7J8NIvUhT9Ap01n+7i/wh5SjKI9Cy79b3jKWsNQ4Yt4fLF41rajmE2wJQ1h?=
 =?us-ascii?Q?h+qeHIwcFpc24Fpv9yhgi4v/BmKk78gvsyIFu6H1Bdz1KuFKr61OoVC1eDCY?=
 =?us-ascii?Q?AHOhUZ1vmyv2dNNtPrPMdMtkZmwDjFZxl47ej1SLAwlazcs2D8gkxeYnBFMZ?=
 =?us-ascii?Q?1UzKIN7mvPUJxMtQDXQ/mAi0r7n1bg1rmInVCsB+FjeKYZzZ5EY0+JDOrdWn?=
 =?us-ascii?Q?nUS76vOB2xu+dAMrEVfkckmMkuvY32rUVCQzCMrh3eKPf6dFm3AAa3ABf0dy?=
 =?us-ascii?Q?z+X2WywJD3rvlaZC/WraW8PlLoy12uxcMYjOYUE7b3TYvc92kTAAM5mgQ0nw?=
 =?us-ascii?Q?gZFAlJp/vpOju67R1hLyUgQHaCb1wNmrMTUwUg8UWvnf3chN83dlLj+k1qlg?=
 =?us-ascii?Q?6ZMmd7BcbKM+3Qv1LpgJw0J38b/v4Vt5yVsjMZ4aodH/X5pZdlEiSOuwiykT?=
 =?us-ascii?Q?On1InW7Cnoe8LAB2tCogrspr/jOorD+Hd8NgVIZD9UzUHr6uHZNQI/IrFW7Z?=
 =?us-ascii?Q?kD6n8NF//0bEXm1/AiZXAr8UzIpGFBWKdft9ebxKmeofejXXrDirDo4hnGhG?=
 =?us-ascii?Q?49Q5LQKhaORU+622OqS1MJQaasM3dohdzgFaTkzTfU5/nCcKoc1+Z1lRxc1S?=
 =?us-ascii?Q?Fyfbv+MDWiAyUftET4iSywYXXdHLlpravnrkrFI2wOKk9gnOIwZwavs80tnk?=
 =?us-ascii?Q?WFwS5SRzOZ4wEbw1uNwYRcJGr0mwwMIVjMadav/+4S+qJck107lOAXFDreWB?=
 =?us-ascii?Q?RB3bDlkYN/vXOXd1EJrN1rTgiv5uFfIG4ZuYKR5EzGs2CxQRPbyeQ0BJNmZa?=
 =?us-ascii?Q?Eh4JBH27+Y9gelUNxvkcHugQ26AgMyG2fvdxfWPPLnbB438/37aGQxUV9Z0C?=
 =?us-ascii?Q?qypNxnqniJP7b54pyq2CI7w4oNaRVrPj/+9p4Ewmj3+UV0A5R8cJeTRw7wP6?=
 =?us-ascii?Q?/sA9DKiYSvQcuv1JbPLAEOIyQc18OrtANmwKQpWROe9wRR0DD7KGFO8LdrC7?=
 =?us-ascii?Q?GRo0t4zLSr9MUh+L7Q=3D?=
X-Microsoft-Antispam-Message-Info: BKFy2BnCVCvD0txWrkULvQoOJFh2Qn+NQkSyrGOvFWf70OvtyLQK2A1yAbXC+y+w/6foKGuAi11Kbg4R8XWTXPq22IcTWMbJtd/6JrdzYF6PgDef8N85ct2CznMoWBfcwrqxnonMn82gT8RwB3AFUFkedT/wARwPnsoUp6ZCayn0ger9r1J59uT8S08q3RSMDyE9x+pwP0BnkwSmrzcHUBLkEt+RkB7r8zAM6ivluKb4Mvgrt0PCltdjHXKvMHPeviVgG7PbubJFhS+wjUHlWCXLHJ6zgbU3zF0tGyVBYcD8WtWNFQAkAS7DjPtIsS7rgp/8tsZP8rxwpNEojB2Cs7v9Vde1NZgqdfIWQ7ylAhw=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;6:Zx3z1HN2X8ZyqomgnVljvzg2JzP2ND05NTlMzK69r4QS8sdQRFJkRUxfHLKNTcg2m4Xgi1D5GVGoY8+z46FxmRId2+JlwNNjREco4CbN7fzCfDpmri7K8gb0bdU92DKYXbpKo7M53WkOUMIklXjcg9dP2Znn/pZr0RJksnzDfxU6P2yB5NIDfpfwr15dRziMSEgxPxs/q9tzRZOWd3lfqdSckRzqh+uc5E/nhIRuZA5co1KpA9P1dT0b/+bm9422kj2d97+1fmv9EQIS5RhAZIMYmCHRyEze+XEJkNOEsl20YHRaUnzmDfe9lu0jUJRgzf+voFynfwvINwBuvarKRjdA19w8tNB7z9a7+uXIchTmWhP6CfAkCWJlc5nj1zcQu0Vh13pM3FYZtfpRCyH6x/sfsj4/+HvN8MmE6j96u2r0k9gq9ATBmTIcK5xjMTR20prK024Nf4YYtoq2VZ/d+w==;5:F0kQL7t6NWch6eZO/ij+y4A97ZgVLcuTIveVdxe6DYrBEW87dDJOPrZIug7MJjEBX9KMXLlBpO0DYMKAWC2zpc/yCK62Q18b/fj5GUsMfE+tjx2FuJJz7lUafZ7LdeZwrfdnbkC+N9koPgIb5M5Ry6+/sEMZ0WLpZjn6WGbvAlM=;7:ggEZbo0Lwr/AQ3uixBxAA0S+/f3QAbF/DaFtGo5X6vgCMnT/CEzhZqHFcdexgvmZdYeIe0NJqBodOPwEDJNLB0wNkqYpAIUWJpC25/ktXpykwGeAkrlXcWOyCpfhx/xdblyTZLo/Ik6+bRl1ATTP1xhUTbfYjcX2Ylf5TSzmYAGavsksvuRCzHAVmfL6/zn5kJcWB7rjT8RK+asDfllU3PaufwG7SEzGGWaDeyWtbRSr25CdnThv1h1cPbmXurTN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 14:11:25.4996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d04201-3778-4d55-d50c-08d6044b5269
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
 .../devicetree/bindings/clock/imx8mq-clock.txt     |  20 +
 include/dt-bindings/clock/imx8mq-clock.h           | 410 +++++++++++++++++++++
 2 files changed, 430 insertions(+)
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
index 0000000..0d19bd9
--- /dev/null
+++ b/include/dt-bindings/clock/imx8mq-clock.h
@@ -0,0 +1,410 @@
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
+#define IMX8MQ_CLK_AHB_SRC		116
+#define IMX8MQ_CLK_AHB_CG		117
+#define IMX8MQ_CLK_AHB_PRE_DIV		118
+#define IMX8MQ_CLK_AHB_DIV		119
+/* AUDIO AHB */
+#define IMX8MQ_CLK_AUDIO_AHB_SRC	120
+#define IMX8MQ_CLK_AUDIO_AHB_CG		121
+#define IMX8MQ_CLK_AUDIO_AHB_PRE_DIV	122
+#define IMX8MQ_CLK_AUDIO_AHB_DIV	123
+
+/* DRAM_ALT */
+#define IMX8MQ_CLK_DRAM_ALT		124
+/* DRAM APB */
+#define IMX8MQ_CLK_DRAM_APB		125
+/* VPU_G1 */
+#define IMX8MQ_CLK_VPU_G1		126
+/* VPU_G2 */
+#define IMX8MQ_CLK_VPU_G2		127
+/* DISP_DTRC */
+#define IMX8MQ_CLK_DISP_DTRC		128
+/* DISP_DC8000 */
+#define IMX8MQ_CLK_DISP_DC8000		129
+/* PCIE_CTRL */
+#define IMX8MQ_CLK_PCIE1_CTRL		130
+/* PCIE_PHY */
+#define IMX8MQ_CLK_PCIE1_PHY		131
+/* PCIE_AUX */
+#define IMX8MQ_CLK_PCIE1_AUX		132
+/* DC_PIXEL */
+#define IMX8MQ_CLK_DC_PIXEL		133
+/* LCDIF_PIXEL */
+#define IMX8MQ_CLK_LCDIF_PIXEL		134
+/* SAI1~6 */
+#define IMX8MQ_CLK_SAI1			135
+
+#define IMX8MQ_CLK_SAI2			136
+
+#define IMX8MQ_CLK_SAI3			137
+
+#define IMX8MQ_CLK_SAI4			138
+
+#define IMX8MQ_CLK_SAI5			139
+
+#define IMX8MQ_CLK_SAI6			140
+/* SPDIF1 */
+#define IMX8MQ_CLK_SPDIF1		127
+/* SPDIF2 */
+#define IMX8MQ_CLK_SPDIF2		131
+/* ENET_REF */
+#define IMX8MQ_CLK_ENET_REF		135
+/* ENET_TIMER */
+#define IMX8MQ_CLK_ENET_TIMER		139
+/* ENET_PHY */
+#define IMX8MQ_CLK_ENET_PHY_REF		143
+/* NAND */
+#define IMX8MQ_CLK_NAND			147
+/* QSPI */
+#define IMX8MQ_CLK_QSPI			148
+/* USDHC1 */
+#define IMX8MQ_CLK_USDHC1		149
+/* USDHC2 */
+#define IMX8MQ_CLK_USDHC2		150
+/* I2C1 */
+#define IMX8MQ_CLK_I2C1			151
+/* I2C2 */
+#define IMX8MQ_CLK_I2C2			152
+/* I2C3 */
+#define IMX8MQ_CLK_I2C3			153
+/* I2C4 */
+#define IMX8MQ_CLK_I2C4			154
+/* UART1 */
+#define IMX8MQ_CLK_UART1		155
+/* UART2 */
+#define IMX8MQ_CLK_UART2		156
+/* UART3 */
+#define IMX8MQ_CLK_UART3		157
+/* UART4 */
+#define IMX8MQ_CLK_UART4		158
+/* USB_CORE_REF */
+#define IMX8MQ_CLK_USB_CORE_REF		159
+/* USB_PHY_REF */
+#define IMX8MQ_CLK_USB_PHY_REF		160
+/* ECSPI1 */
+#define IMX8MQ_CLK_ECSPI1		161
+/* ECSPI2 */
+#define IMX8MQ_CLK_ECSPI2		162
+/* PWM1 */
+#define IMX8MQ_CLK_PWM1			163
+/* PWM2 */
+#define IMX8MQ_CLK_PWM2			164
+/* PWM3 */
+#define IMX8MQ_CLK_PWM3			165
+/* PWM4 */
+#define IMX8MQ_CLK_PWM4			166
+/* GPT1 */
+#define IMX8MQ_CLK_GPT1			167
+/* WDOG */
+#define IMX8MQ_CLK_WDOG			168
+/* WRCLK */
+#define IMX8MQ_CLK_WRCLK		169
+/* DSI_CORE */
+#define IMX8MQ_CLK_DSI_CORE		170
+/* DSI_PHY */
+#define IMX8MQ_CLK_DSI_PHY_REF		171
+/* DSI_DBI */
+#define IMX8MQ_CLK_DSI_DBI		172
+/*DSI_ESC */
+#define IMX8MQ_CLK_DSI_ESC		373
+/* CSI1_CORE */
+#define IMX8MQ_CLK_CSI1_CORE		374
+/* CSI1_PHY */
+#define IMX8MQ_CLK_CSI1_PHY_REF		375
+/* CSI_ESC */
+#define IMX8MQ_CLK_CSI1_ESC		376
+/* CSI2_CORE */
+#define IMX8MQ_CLK_CSI2_CORE		377
+/* CSI2_PHY */
+#define IMX8MQ_CLK_CSI2_PHY_REF		378
+/* CSI2_ESC */
+#define IMX8MQ_CLK_CSI2_ESC		379
+/* PCIE2_CTRL */
+#define IMX8MQ_CLK_PCIE2_CTRL		380
+/* PCIE2_PHY */
+#define IMX8MQ_CLK_PCIE2_PHY		381
+/* PCIE2_AUX */
+#define IMX8MQ_CLK_PCIE2_AUX		382
+/* ECSPI3 */
+#define IMX8MQ_CLK_ECSPI3		383
+
+/* CCGR clocks */
+#define IMX8MQ_CLK_A53_ROOT			384
+#define IMX8MQ_CLK_DRAM_ROOT			385
+#define IMX8MQ_CLK_ECSPI1_ROOT			386
+#define IMX8MQ_CLK_ECSPI2_ROOT			387
+#define IMX8MQ_CLK_ECSPI3_ROOT			388
+#define IMX8MQ_CLK_ENET1_ROOT			389
+#define IMX8MQ_CLK_GPT1_ROOT			390
+#define IMX8MQ_CLK_I2C1_ROOT			391
+#define IMX8MQ_CLK_I2C2_ROOT			392
+#define IMX8MQ_CLK_I2C3_ROOT			393
+#define IMX8MQ_CLK_I2C4_ROOT			394
+#define IMX8MQ_CLK_M4_ROOT			395
+#define IMX8MQ_CLK_PCIE1_ROOT			396
+#define IMX8MQ_CLK_PCIE2_ROOT			397
+#define IMX8MQ_CLK_PWM1_ROOT			398
+#define IMX8MQ_CLK_PWM2_ROOT			399
+#define IMX8MQ_CLK_PWM3_ROOT			400
+#define IMX8MQ_CLK_PWM4_ROOT			401
+#define IMX8MQ_CLK_QSPI_ROOT			402
+#define IMX8MQ_CLK_SAI1_ROOT			403
+#define IMX8MQ_CLK_SAI2_ROOT			404
+#define IMX8MQ_CLK_SAI3_ROOT			405
+#define IMX8MQ_CLK_SAI4_ROOT			406
+#define IMX8MQ_CLK_SAI5_ROOT			407
+#define IMX8MQ_CLK_SAI6_ROOT			408
+#define IMX8MQ_CLK_UART1_ROOT			409
+#define IMX8MQ_CLK_UART2_ROOT			411
+#define IMX8MQ_CLK_UART3_ROOT			412
+#define IMX8MQ_CLK_UART4_ROOT			413
+#define IMX8MQ_CLK_USB1_CTRL_ROOT		414
+#define IMX8MQ_CLK_USB2_CTRL_ROOT		415
+#define IMX8MQ_CLK_USB1_PHY_ROOT		416
+#define IMX8MQ_CLK_USB2_PHY_ROOT		417
+#define IMX8MQ_CLK_USDHC1_ROOT			418
+#define IMX8MQ_CLK_USDHC2_ROOT			419
+#define IMX8MQ_CLK_WDOG1_ROOT			420
+#define IMX8MQ_CLK_WDOG2_ROOT			421
+#define IMX8MQ_CLK_WDOG3_ROOT			422
+#define IMX8MQ_CLK_GPU_ROOT			423
+#define IMX8MQ_CLK_HEVC_ROOT			424
+#define IMX8MQ_CLK_AVC_ROOT			425
+#define IMX8MQ_CLK_VP9_ROOT			426
+#define IMX8MQ_CLK_HEVC_INTER_ROOT		427
+#define IMX8MQ_CLK_DISP_ROOT			428
+#define IMX8MQ_CLK_HDMI_ROOT			429
+#define IMX8MQ_CLK_HDMI_PHY_ROOT		430
+#define IMX8MQ_CLK_VPU_DEC_ROOT			431
+#define IMX8MQ_CLK_CSI1_ROOT			432
+#define IMX8MQ_CLK_CSI2_ROOT			433
+#define IMX8MQ_CLK_RAWNAND_ROOT			434
+#define IMX8MQ_CLK_SDMA1_ROOT			435
+#define IMX8MQ_CLK_SDMA2_ROOT			436
+#define IMX8MQ_CLK_VPU_G1_ROOT			437
+#define IMX8MQ_CLK_VPU_G2_ROOT			438
+
+/* SCCG PLL GATE */
+#define IMX8MQ_SYS1_PLL_OUT			439
+#define IMX8MQ_SYS2_PLL_OUT			440
+#define IMX8MQ_SYS3_PLL_OUT			441
+#define IMX8MQ_DRAM_PLL_OUT			442
+
+#define IMX8MQ_GPT_3M_CLK			443
+
+#define IMX8MQ_CLK_IPG_ROOT			444
+#define IMX8MQ_CLK_IPG_AUDIO_ROOT		445
+#define IMX8MQ_CLK_SAI1_IPG			446
+#define IMX8MQ_CLK_SAI2_IPG			447
+#define IMX8MQ_CLK_SAI3_IPG			448
+#define IMX8MQ_CLK_SAI4_IPG			449
+#define IMX8MQ_CLK_SAI5_IPG			450
+#define IMX8MQ_CLK_SAI6_IPG			451
+
+/* DSI AHB/IPG clocks */
+/* rxesc clock */
+#define IMX8MQ_CLK_DSI_AHB			452
+/* txesc clock */
+#define IMX8MQ_CLK_DSI_IPG_DIV                  453
+
+/* VIDEO2 PLL */
+#define IMX8MQ_VIDEO2_PLL1_REF_SEL		454
+#define IMX8MQ_VIDEO2_PLL1_REF_DIV		455
+#define IMX8MQ_VIDEO2_PLL1			456
+#define IMX8MQ_VIDEO2_PLL1_OUT			457
+#define IMX8MQ_VIDEO2_PLL1_OUT_DIV		458
+#define IMX8MQ_VIDEO2_PLL2			459
+#define IMX8MQ_VIDEO2_PLL2_DIV			460
+#define IMX8MQ_VIDEO2_PLL2_OUT			461
+#define IMX8MQ_CLK_TMU_ROOT			462
+
+/* Display root clocks */
+#define IMX8MQ_CLK_DISP_AXI_ROOT		463
+#define IMX8MQ_CLK_DISP_APB_ROOT		464
+#define IMX8MQ_CLK_DISP_RTRM_ROOT		465
+
+#define IMX8MQ_CLK_OCOTP_ROOT			476
+
+#define IMX8MQ_CLK_DRAM_ALT_ROOT		477
+#define IMX8MQ_CLK_DRAM_CORE			478
+
+#define IMX8MQ_CLK_MU_ROOT			479
+#define IMX8MQ_VIDEO2_PLL_OUT			480
+
+#define IMX8MQ_CLK_CLKO2			481
+
+#define IMX8MQ_CLK_NAND_USDHC_BUS_RAWNAND_CLK	482
+
+#define IMX8MQ_CLK_END				483
+#endif /* __DT_BINDINGS_CLOCK_IMX8MQ_H */
-- 
2.7.4

