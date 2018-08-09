Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C10DC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F9521E97
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HYCXDD6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F9521E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbeHIRLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:11:23 -0400
Received: from mail-eopbgr60044.outbound.protection.outlook.com ([40.107.6.44]:32576
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732295AbeHIRLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vz9ZKJ4i0EhlTv10eqFNSXWMNsv9R5vxNOgdXo4xdk=;
 b=HYCXDD6/7ahj4nEx+q+xdR6MX4ze5r4HbEDkfXr0sRSmoU34txSBI7fkoQbVkXaPutUSl/ZrjpK+giDXQqaesCvyDKVihV289v0C9y0zFqyjpzaZqjKgw+U2/gdmcEJ1QBAyjhrZw8040Rn0b8KsyrallBQB5tkYRTuZsetz9nM=
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 HE1PR04MB1611.eurprd04.prod.outlook.com (2a01:111:e400:59a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.18; Thu, 9 Aug
 2018 14:45:58 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v3 1/4] dt-bindings: add binding for i.MX8MQ CCM
Date:   Thu,  9 Aug 2018 17:45:38 +0300
Message-Id: <1533825941-17224-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533825941-17224-1-git-send-email-abel.vesa@nxp.com>
References: <1533825941-17224-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM3PR04CA0141.eurprd04.prod.outlook.com (2603:10a6:207::25)
 To HE1PR04MB1611.eurprd04.prod.outlook.com (2a01:111:e400:59a9::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1556f772-6950-4ee2-76d6-08d5fe06d26d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1611;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1611;3:Gy+DrS8GEmrSEFzS1ml4+3TinzrKLOIGRDuNLYKdl2rgGkZ2KUBhiv4totuXDnf3jvAnd4BOq5Hsid0GkL74ozy+MVLRS8I59wZMkfgjjqwQVgwfmVK5SIUyleSH6j6IkPVIwUrLuV5PqD4xibumh/X+SRBR02XXjLQig4QvUYGCdIJ44ODJj1Q6f/KfGVnlZQDPNrwUaAAJrC/Ac8ifXD++rzUgAP7U6S8H8qvTxrqf1NSpd/+r+Lk2vXuXVOYZ;25:4CkgAN83WSfsSjrQjd+S36d2cVLRa5++Q43lvelIazq/wMH9gE9KX4Fg9fMlcwciEndiff3FfS22MaTNANxvZXWAIN439XoJHa/I/NvPhThoS26QBcgvKPCSmc4+urh9R1OvaSjGAaKlRCbIETmJ0y7fsnnBzMl2yVDdu9V22MpJdxGiMQqlQXiQ1CKAYZ9FRtYnhR4C8/iijsR1V9qKk2hoZMUVl+XCeXQTOgus952l36hzrPWS/G1FxvHqqfqzgoAa3K//YpgPNxnBeBZtxKMAv85URRR0Pl9Er7eZKi3zVcM1wGTnEHCmD2zfaAbKHONCdor8bIH7ft0EQoA3xA==;31:/lradTtckfbUIEEhgovEEz8rd2qCjJAwEucG65YHMswP2lAIissvum2y7iFmf7qmezU33oLM6UeBbCvGp4uBAtojVNk3gru+qYd0ljWfMB8ECmYl5Il87tlelC84cQJ3VNJexaV3v6FT00AQ6BKOMusk4qNSbYbd0MbRDxgdqcllO/sWK5wDQtqrK6SLeC8oGsiGyP5CKw3Ch2jJ2Pztfjl+p4QC24Jv7C4aeTMd7j8=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1611:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1611;20:oVfUscjMmM+NrK9tp1oaHMYge+VCkh3oWZTiLSqIQcSsBHPb43t9B72XHfDQ5r3xGirpZ8OXJWGVMzvNYyFZC8SilIKjfYyvCHLu0jB0JmH108hgRt6fUQYZCbGz9J+vqXN8Flfne/fKXGXhyjB68mq/m+oNT/Sk9zJ9TBkP6qQ6l7XWjH6rQretVieei5goRbO4oMbpmrajuyVweaAtg8cokBTLD5qDKHTpnW0PAjchC4woJpW91ToWK9NBOOaAA2IGM9Km3Q5CrVNXzu4b1O6fHggz68fnlDrNkChbuQ90ExELN3ySizL6GizlVk5Tg5rV31UQ260SVVIYKdajvvnA2TM8Fy1D9/njND+CTAnTiD04RO6HBPuPrASiaaxGHxB7PsgOGZTFFa5LkPKBbtcx4iqE0OMPCAAPkvzxfg721ZyO+6G3BZ4VSOklaKGKBF4EU0UheAtXLxoi3uWC4PsTtPU1nBeQxs3m4zns1bv73CUPqYFrZ4+Zge1l+IZq;4:IAnAJEOdJ3W7GNGcB6Hwiwy5z92f1t+O0ZapgpHN69/05Xd0vpLFY7HolIUVhsTGt+B/e2Plwl4gdqT25k3yZvioPuKrdL1v4g9cFrsK89iN/X5guMhZBZTFiaNUxvUW0981lghv7+oPnzlCojzwhTeGvWmEktOGzl16buhaIPbjtN+5IKC0fS6hsBb9TGpnR8OUXwKf3wcYjqrGjoeemG8e5ZrkgeDYBhQ1hX/JT7TYycZslj11fpL+HZjWelsWyK3UZREWwqb7ElhQ4A0tvdKVM4XtO6Tn9NsVHEtT4Tebesik8Q4kluOUD/aY9+vE
X-Microsoft-Antispam-PRVS: <HE1PR04MB16116A930836443AB46B63B7F6250@HE1PR04MB1611.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1611;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1611;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(346002)(136003)(189003)(199004)(8936002)(47776003)(50226002)(53936002)(6116002)(81156014)(54906003)(110136005)(81166006)(8676002)(16586007)(5660300001)(68736007)(316002)(7736002)(305945005)(6666003)(7416002)(51416003)(66066001)(52116002)(76176011)(36756003)(3846002)(25786009)(105586002)(97736004)(6506007)(386003)(106356001)(48376002)(6512007)(186003)(2906002)(16526019)(26005)(4326008)(50466002)(478600001)(476003)(446003)(44832011)(2616005)(6486002)(11346002)(956004)(86362001)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1611;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1611;23:81ptWkx7bhleqCi5YfP5QDC9j00vzL9pje1RZbIC1?=
 =?us-ascii?Q?ov8xzDVy40jjbq7hOEa1COP7YMbckChNcxnYpKnruQs1dWAf7k/6WMW+oqcb?=
 =?us-ascii?Q?PTeuWDK0nbvVEiSk40MyhYuQZjUNff/wtXOzaoMqzzUDiFK6YEiSI7RjLLsX?=
 =?us-ascii?Q?5toOKquVfvFVWyD98AcD1El1mus8inoHUulqQ0XD/b+TBCSJAKxldVYdWVgX?=
 =?us-ascii?Q?5hhFzf9+yuqYwwCJfw8qIO51rVF0+QaBCgTrWCOeDusiYAOhraLl8+1dCAzT?=
 =?us-ascii?Q?1IrP+Z9Rf3QG+65+x/alinHUlzqfxHtPwikk3qp8SdoWyJqBPXPDcIsiyzF0?=
 =?us-ascii?Q?5hk+Sxei/eeLsxMgYLi2nK/yCSArWc4L5Muqd4W51H1ZM5jb4Tr9un1F2pKD?=
 =?us-ascii?Q?BqS4nfJW4cniLewfR/QCP4vwrE++QsmdHRpick6vswVUvXeGlgoh7fm6gTiQ?=
 =?us-ascii?Q?Ke1yK07OinBFZyo2HGnTnyLR4+dDcZXmQ+Nce/nGDzpg+wIKdBEGw9selP4b?=
 =?us-ascii?Q?iS2hABRJN/3TOo08ASHJSw6ATQaRg6lEHgrJbGISH9ESjWnXtdUvQoSgo8tP?=
 =?us-ascii?Q?en2NLC0U1RZPDkOYBk83rINAuOGky2Ukvk9ge8SG/qZsrZF2v2ZuUlnSEg/Z?=
 =?us-ascii?Q?FetFrXlRu6Tr5d/IZMw1P0heTiJdPyJ18G7L+0BFVGntqaOtnK+LYf9xyhFz?=
 =?us-ascii?Q?4+ggUn9CuDAkXdYTAPMu8tvmMMS11Z7zfIgIeN62xuPr4zdB7Ht+/EfltOD/?=
 =?us-ascii?Q?EWhSmOupAgfFADYhBceT/KLh+v2We42+ZoaP+lCNqTqSJ6DL3qDAKYJLs1Gy?=
 =?us-ascii?Q?gMm2Y0ZDtfp61Ra36nUnCzQDjoSqiln2pLp92oGDAgd2PU4HxHCb9yhjU5T4?=
 =?us-ascii?Q?G3w3qW9Ry0GJQN4VXf6ERHhJpu1ualU4AJ3iomKvnwJfsrl22fKJuTjPqu4x?=
 =?us-ascii?Q?NJ5KTj9dRcFHbZs0WQtrmgWz3VI6fG5D8EvTIhH7ush8rYfpcFXiY9eMxH3I?=
 =?us-ascii?Q?IM53AidztKOzpXOdyixzbLsVEVY2g8Ln31OM+BJWJyjC2pP3d4UbQyXgnboV?=
 =?us-ascii?Q?WdD1SoaP245IIzyNP89uc29FLuuz1xG+qOriEhOEj1U9lxW6cxhtvZ28pAc7?=
 =?us-ascii?Q?T+Y25wGQsTwphtHZe1ib4Tx+n7IQeGwfuMl2TBxtFOfY9SUYRziPxIuJ4GO9?=
 =?us-ascii?Q?JgHPUngao6Ijzeu8gu6HXrzyWr4quAGn/ypzVjYFF2Xm/i93/deYq+kNg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: YNOUWf3ZXtIcdZtgKjKQLajiuiJ9uhdgNvWswmwJ93tADxa+o7gq3aFcxpgtSAci9L9Cj/D094rGL9yZ29BMz9/BMxH99lmKJknedDG3NI1jjNRYjF9AxvTF5qt41SLnPAd/mZMf0Qo+oq62eSaZGo1xtT+BWySfn54/I/yOV/qF/hILomTU/cKFPAwNybzJe+dwFksYmTAh5WpLEnUKQ8Z2wwT7J+5v9eFClt2E5lbsyvVCBPqALm7uKDKF/77qjF1coEbRmxU9B7XkLnB2x9DZSCgoqC79Ao0QK3opbNO2fCy95eYQxEsZCX0PlTNSUBEcUPnkt2I8D9/teb/c5htrDA+NejUVznytvQTMi40=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1611;6:DJWRrJaRsZOVCbuSzDjs2zUc5HVFhPJphc9Jm2hicCkCdxNSJzBbywPL42X5dldmmIVKx71wLQuzN86UERFnd4GeCYGBuTYKDtmc75Dzxko9nmeGY/jPkFE14VI9d5lRT7hHrSJkuZ1JxMKU/JtNvfH4ylLhGDdxbAdMFA/nIcxl2zeLqbChuqCw3UuZ95sXG2LXSvph8GOEQUW9Thl4uNyPn3kY+1qPd5YxwyLkbOGG0RJdh+yS8V3skO+5bd0s32c0DJHiTfgykKnSLzXM17/SDI8tV8a5ECz5Lmj94nmdvKnyk/3wLvdWdluapK1iC15KZWB6i9EIcTPPgqVpfeFWGn71og6HdfOQO1K2IuOpqsg7S1yYaBFnG2wgauFDfXx3J+mkVGheAgLQlFj+LropRvntr0yi1usro0Y5m0XRFUdrxBghPeGj0GsxHA+qcAarufRQtPBYu5MDodpQ0g==;5:D9GL0EYPpG81xuWGk81zjp3FQzfpJn4B4qG9uZkUCtFHwPmU055+Ncr/49MaZFmVCmBfS9tGDsITdlsh6pyQes11vxCs6y50PuNKItqRacjfxcVUt2YrKkpEtTwVytdf/n7DmVJRjYY9qKtXYVbKQMazc3c/TmP37dWkQVeWRVk=;7:FEaX++LOGRN6sI4oqvLgqISZDpB6lya/mvNHUgE6jbJrJue3paBFlP7K1jdlOzbt/cwQ+tTAcDhIdnsZZZpp7WbOaGuTqGkYTKTiA2t7VexFebo9ndsyeOhkJWbmbOzZLuMiMfgyRoPVngbIunWYUgnHBm+qpDPDhrfLV+6Rl9MSheRL2P/HuvKyRibv4AjPCyt3vNL6Jc10uNm25jJEyVE7GfSKPQC+qPAL9e8jVft0821W49L7gRl19Ymoslh/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 14:45:58.3921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1556f772-6950-4ee2-76d6-08d5fe06d26d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1611
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This adds the binding for the i.MX8MQ Clock Controller Module.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../devicetree/bindings/clock/imx8mq-clock.txt     |  20 +
 include/dt-bindings/clock/imx8mq-clock.h           | 629 +++++++++++++++++++++
 2 files changed, 649 insertions(+)
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
index 0000000..7f88062
--- /dev/null
+++ b/include/dt-bindings/clock/imx8mq-clock.h
@@ -0,0 +1,629 @@
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
+#define IMX8MQ_CLK_MAIN_AXI_SRC		103
+#define IMX8MQ_CLK_MAIN_AXI_CG		104
+#define IMX8MQ_CLK_MAIN_AXI_PRE_DIV	105
+#define IMX8MQ_CLK_MAIN_AXI_DIV		106
+/* ENET AXI */
+#define IMX8MQ_CLK_ENET_AXI_SRC		107
+#define IMX8MQ_CLK_ENET_AXI_CG		108
+#define IMX8MQ_CLK_ENET_AXI_PRE_DIV	109
+#define IMX8MQ_CLK_ENET_AXI_DIV		110
+/* NAND_USDHC_BUS */
+#define IMX8MQ_CLK_NAND_USDHC_BUS_SRC		111
+#define IMX8MQ_CLK_NAND_USDHC_BUS_CG		112
+#define IMX8MQ_CLK_NAND_USDHC_BUS_PRE_DIV	113
+#define IMX8MQ_CLK_NAND_USDHC_BUS_DIV		114
+/* VPU BUS */
+#define IMX8MQ_CLK_VPU_BUS_SRC			115
+#define IMX8MQ_CLK_VPU_BUS_CG			116
+#define IMX8MQ_CLK_VPU_BUS_PRE_DIV		117
+#define IMX8MQ_CLK_VPU_BUS_DIV			118
+/* DISP_AXI */
+#define IMX8MQ_CLK_DISP_AXI_SRC			119
+#define IMX8MQ_CLK_DISP_AXI_CG			120
+#define IMX8MQ_CLK_DISP_AXI_PRE_DIV		121
+#define IMX8MQ_CLK_DISP_AXI_DIV			122
+/* DISP APB */
+#define IMX8MQ_CLK_DISP_APB_SRC			123
+#define IMX8MQ_CLK_DISP_APB_CG			124
+#define IMX8MQ_CLK_DISP_APB_PRE_DIV		125
+#define IMX8MQ_CLK_DISP_APB_DIV			126
+/* DISP RTRM */
+#define IMX8MQ_CLK_DISP_RTRM_SRC		127
+#define IMX8MQ_CLK_DISP_RTRM_CG			128
+#define IMX8MQ_CLK_DISP_RTRM_PRE_DIV		129
+#define IMX8MQ_CLK_DISP_RTRM_DIV		130
+/* USB_BUS */
+#define IMX8MQ_CLK_USB_BUS_SRC			131
+#define IMX8MQ_CLK_USB_BUS_CG			132
+#define IMX8MQ_CLK_USB_BUS_PRE_DIV		133
+#define IMX8MQ_CLK_USB_BUS_DIV			134
+/* GPU_AXI */
+#define IMX8MQ_CLK_GPU_AXI_SRC			135
+#define IMX8MQ_CLK_GPU_AXI_CG			136
+#define IMX8MQ_CLK_GPU_AXI_PRE_DIV		137
+#define IMX8MQ_CLK_GPU_AXI_DIV			138
+/* GPU_AHB */
+#define IMX8MQ_CLK_GPU_AHB_SRC			139
+#define IMX8MQ_CLK_GPU_AHB_CG			140
+#define IMX8MQ_CLK_GPU_AHB_PRE_DIV		141
+#define IMX8MQ_CLK_GPU_AHB_DIV			142
+/* NOC */
+#define IMX8MQ_CLK_NOC_SRC			143
+#define IMX8MQ_CLK_NOC_CG			144
+#define IMX8MQ_CLK_NOC_PRE_DIV			145
+#define IMX8MQ_CLK_NOC_DIV			146
+/* NOC_APB */
+#define IMX8MQ_CLK_NOC_APB_SRC			147
+#define IMX8MQ_CLK_NOC_APB_CG			148
+#define IMX8MQ_CLK_NOC_APB_PRE_DIV		149
+#define IMX8MQ_CLK_NOC_APB_DIV			150
+
+/* AHB */
+#define IMX8MQ_CLK_AHB_SRC			151
+#define IMX8MQ_CLK_AHB_CG			152
+#define IMX8MQ_CLK_AHB_PRE_DIV			153
+#define IMX8MQ_CLK_AHB_DIV			154
+/* AUDIO AHB */
+#define IMX8MQ_CLK_AUDIO_AHB_SRC		155
+#define IMX8MQ_CLK_AUDIO_AHB_CG			156
+#define IMX8MQ_CLK_AUDIO_AHB_PRE_DIV		157
+#define IMX8MQ_CLK_AUDIO_AHB_DIV		158
+
+/* DRAM_ALT */
+#define IMX8MQ_CLK_DRAM_ALT_SRC			159
+#define IMX8MQ_CLK_DRAM_ALT_CG			160
+#define IMX8MQ_CLK_DRAM_ALT_PRE_DIV		161
+#define IMX8MQ_CLK_DRAM_ALT_DIV			162
+/* DRAM APB */
+#define IMX8MQ_CLK_DRAM_APB_SRC			163
+#define IMX8MQ_CLK_DRAM_APB_CG			164
+#define IMX8MQ_CLK_DRAM_APB_PRE_DIV		165
+#define IMX8MQ_CLK_DRAM_APB_DIV			166
+/* VPU_G1 */
+#define IMX8MQ_CLK_VPU_G1_SRC			167
+#define IMX8MQ_CLK_VPU_G1_CG			168
+#define IMX8MQ_CLK_VPU_G1_PRE_DIV		169
+#define IMX8MQ_CLK_VPU_G1_DIV			170
+/* VPU_G2 */
+#define IMX8MQ_CLK_VPU_G2_SRC			171
+#define IMX8MQ_CLK_VPU_G2_CG			172
+#define IMX8MQ_CLK_VPU_G2_PRE_DIV		173
+#define IMX8MQ_CLK_VPU_G2_DIV			174
+/* DISP_DTRC */
+#define IMX8MQ_CLK_DISP_DTRC_SRC		175
+#define IMX8MQ_CLK_DISP_DTRC_CG			176
+#define IMX8MQ_CLK_DISP_DTRC_PRE_DIV		177
+#define IMX8MQ_CLK_DISP_DTRC_DIV		178
+/* DISP_DC8000 */
+#define IMX8MQ_CLK_DISP_DC8000_SRC		179
+#define IMX8MQ_CLK_DISP_DC8000_CG		180
+#define IMX8MQ_CLK_DISP_DC8000_PRE_DIV		181
+#define IMX8MQ_CLK_DISP_DC8000_DIV		182
+/* PCIE_CTRL */
+#define IMX8MQ_CLK_PCIE1_CTRL_SRC		183
+#define IMX8MQ_CLK_PCIE1_CTRL_CG		184
+#define IMX8MQ_CLK_PCIE1_CTRL_PRE_DIV		185
+#define IMX8MQ_CLK_PCIE1_CTRL_DIV		186
+/* PCIE_PHY */
+#define IMX8MQ_CLK_PCIE1_PHY_SRC		187
+#define IMX8MQ_CLK_PCIE1_PHY_CG			188
+#define IMX8MQ_CLK_PCIE1_PHY_PRE_DIV		189
+#define IMX8MQ_CLK_PCIE1_PHY_DIV		190
+/* PCIE_AUX */
+#define IMX8MQ_CLK_PCIE1_AUX_SRC		191
+#define IMX8MQ_CLK_PCIE1_AUX_CG			192
+#define IMX8MQ_CLK_PCIE1_AUX_PRE_DIV		193
+#define IMX8MQ_CLK_PCIE1_AUX_DIV		194
+/* DC_PIXEL */
+#define IMX8MQ_CLK_DC_PIXEL_SRC			195
+#define IMX8MQ_CLK_DC_PIXEL_CG			196
+#define IMX8MQ_CLK_DC_PIXEL_PRE_DIV		197
+#define IMX8MQ_CLK_DC_PIXEL_DIV			198
+/* LCDIF_PIXEL */
+#define IMX8MQ_CLK_LCDIF_PIXEL_SRC		199
+#define IMX8MQ_CLK_LCDIF_PIXEL_CG		200
+#define IMX8MQ_CLK_LCDIF_PIXEL_PRE_DIV		201
+#define IMX8MQ_CLK_LCDIF_PIXEL_DIV		202
+/* SAI1~6 */
+#define IMX8MQ_CLK_SAI1_SRC			203
+#define IMX8MQ_CLK_SAI1_CG			204
+#define IMX8MQ_CLK_SAI1_PRE_DIV			205
+#define IMX8MQ_CLK_SAI1_DIV			206
+
+#define IMX8MQ_CLK_SAI2_SRC			207
+#define IMX8MQ_CLK_SAI2_CG			208
+#define IMX8MQ_CLK_SAI2_PRE_DIV			209
+#define IMX8MQ_CLK_SAI2_DIV			210
+
+#define IMX8MQ_CLK_SAI3_SRC			211
+#define IMX8MQ_CLK_SAI3_CG			212
+#define IMX8MQ_CLK_SAI3_PRE_DIV			213
+#define IMX8MQ_CLK_SAI3_DIV			214
+
+#define IMX8MQ_CLK_SAI4_SRC			215
+#define IMX8MQ_CLK_SAI4_CG			216
+#define IMX8MQ_CLK_SAI4_PRE_DIV			217
+#define IMX8MQ_CLK_SAI4_DIV			218
+
+#define IMX8MQ_CLK_SAI5_SRC			219
+#define IMX8MQ_CLK_SAI5_CG			220
+#define IMX8MQ_CLK_SAI5_PRE_DIV			221
+#define IMX8MQ_CLK_SAI5_DIV			222
+
+#define IMX8MQ_CLK_SAI6_SRC			223
+#define IMX8MQ_CLK_SAI6_CG			224
+#define IMX8MQ_CLK_SAI6_PRE_DIV			225
+#define IMX8MQ_CLK_SAI6_DIV			226
+/* SPDIF1 */
+#define IMX8MQ_CLK_SPDIF1_SRC			227
+#define IMX8MQ_CLK_SPDIF1_CG			228
+#define IMX8MQ_CLK_SPDIF1_PRE_DIV		229
+#define IMX8MQ_CLK_SPDIF1_DIV			230
+/* SPDIF2 */
+#define IMX8MQ_CLK_SPDIF2_SRC			231
+#define IMX8MQ_CLK_SPDIF2_CG			232
+#define IMX8MQ_CLK_SPDIF2_PRE_DIV		233
+#define IMX8MQ_CLK_SPDIF2_DIV			234
+/* ENET_REF */
+#define IMX8MQ_CLK_ENET_REF_SRC			235
+#define IMX8MQ_CLK_ENET_REF_CG			236
+#define IMX8MQ_CLK_ENET_REF_PRE_DIV		237
+#define IMX8MQ_CLK_ENET_REF_DIV			238
+/* ENET_TIMER */
+#define IMX8MQ_CLK_ENET_TIMER_SRC		239
+#define IMX8MQ_CLK_ENET_TIMER_CG		240
+#define IMX8MQ_CLK_ENET_TIMER_PRE_DIV		241
+#define IMX8MQ_CLK_ENET_TIMER_DIV		242
+/* ENET_PHY */
+#define IMX8MQ_CLK_ENET_PHY_REF_SRC		243
+#define IMX8MQ_CLK_ENET_PHY_REF_CG		244
+#define IMX8MQ_CLK_ENET_PHY_REF_PRE_DIV		245
+#define IMX8MQ_CLK_ENET_PHY_REF_DIV		246
+/* NAND */
+#define IMX8MQ_CLK_NAND_SRC			247
+#define IMX8MQ_CLK_NAND_CG			248
+#define IMX8MQ_CLK_NAND_PRE_DIV			249
+#define IMX8MQ_CLK_NAND_DIV			250
+/* QSPI */
+#define IMX8MQ_CLK_QSPI_SRC			251
+#define IMX8MQ_CLK_QSPI_CG			252
+#define IMX8MQ_CLK_QSPI_PRE_DIV			253
+#define IMX8MQ_CLK_QSPI_DIV			254
+/* USDHC1 */
+#define IMX8MQ_CLK_USDHC1_SRC			255
+#define IMX8MQ_CLK_USDHC1_CG			256
+#define IMX8MQ_CLK_USDHC1_PRE_DIV		257
+#define IMX8MQ_CLK_USDHC1_DIV			258
+/* USDHC2 */
+#define IMX8MQ_CLK_USDHC2_SRC			259
+#define IMX8MQ_CLK_USDHC2_CG			260
+#define IMX8MQ_CLK_USDHC2_PRE_DIV		261
+#define IMX8MQ_CLK_USDHC2_DIV			262
+/* I2C1 */
+#define IMX8MQ_CLK_I2C1_SRC			263
+#define IMX8MQ_CLK_I2C1_CG			264
+#define IMX8MQ_CLK_I2C1_PRE_DIV			265
+#define IMX8MQ_CLK_I2C1_DIV			266
+/* I2C2 */
+#define IMX8MQ_CLK_I2C2_SRC			267
+#define IMX8MQ_CLK_I2C2_CG			268
+#define IMX8MQ_CLK_I2C2_PRE_DIV			269
+#define IMX8MQ_CLK_I2C2_DIV			270
+/* I2C3 */
+#define IMX8MQ_CLK_I2C3_SRC			271
+#define IMX8MQ_CLK_I2C3_CG			272
+#define IMX8MQ_CLK_I2C3_PRE_DIV			273
+#define IMX8MQ_CLK_I2C3_DIV			274
+/* I2C4 */
+#define IMX8MQ_CLK_I2C4_SRC			275
+#define IMX8MQ_CLK_I2C4_CG			276
+#define IMX8MQ_CLK_I2C4_PRE_DIV			277
+#define IMX8MQ_CLK_I2C4_DIV			278
+/* UART1 */
+#define IMX8MQ_CLK_UART1_SRC			279
+#define IMX8MQ_CLK_UART1_CG			280
+#define IMX8MQ_CLK_UART1_PRE_DIV		281
+#define IMX8MQ_CLK_UART1_DIV			282
+/* UART2 */
+#define IMX8MQ_CLK_UART2_SRC			283
+#define IMX8MQ_CLK_UART2_CG			284
+#define IMX8MQ_CLK_UART2_PRE_DIV		285
+#define IMX8MQ_CLK_UART2_DIV			286
+/* UART3 */
+#define IMX8MQ_CLK_UART3_SRC			287
+#define IMX8MQ_CLK_UART3_CG			288
+#define IMX8MQ_CLK_UART3_PRE_DIV		289
+#define IMX8MQ_CLK_UART3_DIV			290
+/* UART4 */
+#define IMX8MQ_CLK_UART4_SRC			291
+#define IMX8MQ_CLK_UART4_CG			292
+#define IMX8MQ_CLK_UART4_PRE_DIV		293
+#define IMX8MQ_CLK_UART4_DIV			294
+/* USB_CORE_REF */
+#define IMX8MQ_CLK_USB_CORE_REF_SRC		295
+#define IMX8MQ_CLK_USB_CORE_REF_CG		296
+#define IMX8MQ_CLK_USB_CORE_REF_PRE_DIV		297
+#define IMX8MQ_CLK_USB_CORE_REF_DIV		298
+/* USB_PHY_REF */
+#define IMX8MQ_CLK_USB_PHY_REF_SRC		299
+#define IMX8MQ_CLK_USB_PHY_REF_CG		300
+#define IMX8MQ_CLK_USB_PHY_REF_PRE_DIV		301
+#define IMX8MQ_CLK_USB_PHY_REF_DIV		302
+/* ECSPI1 */
+#define IMX8MQ_CLK_ECSPI1_SRC			303
+#define IMX8MQ_CLK_ECSPI1_CG			304
+#define IMX8MQ_CLK_ECSPI1_PRE_DIV		305
+#define IMX8MQ_CLK_ECSPI1_DIV			306
+/* ECSPI2 */
+#define IMX8MQ_CLK_ECSPI2_SRC			307
+#define IMX8MQ_CLK_ECSPI2_CG			308
+#define IMX8MQ_CLK_ECSPI2_PRE_DIV		309
+#define IMX8MQ_CLK_ECSPI2_DIV			310
+/* PWM1 */
+#define IMX8MQ_CLK_PWM1_SRC			311
+#define IMX8MQ_CLK_PWM1_CG			312
+#define IMX8MQ_CLK_PWM1_PRE_DIV			313
+#define IMX8MQ_CLK_PWM1_DIV			314
+/* PWM2 */
+#define IMX8MQ_CLK_PWM2_SRC			315
+#define IMX8MQ_CLK_PWM2_CG			316
+#define IMX8MQ_CLK_PWM2_PRE_DIV			317
+#define IMX8MQ_CLK_PWM2_DIV			318
+/* PWM3 */
+#define IMX8MQ_CLK_PWM3_SRC			319
+#define IMX8MQ_CLK_PWM3_CG			320
+#define IMX8MQ_CLK_PWM3_PRE_DIV			321
+#define IMX8MQ_CLK_PWM3_DIV			322
+/* PWM4 */
+#define IMX8MQ_CLK_PWM4_SRC			323
+#define IMX8MQ_CLK_PWM4_CG			324
+#define IMX8MQ_CLK_PWM4_PRE_DIV			325
+#define IMX8MQ_CLK_PWM4_DIV			326
+/* GPT1 */
+#define IMX8MQ_CLK_GPT1_SRC			327
+#define IMX8MQ_CLK_GPT1_CG			328
+#define IMX8MQ_CLK_GPT1_PRE_DIV			329
+#define IMX8MQ_CLK_GPT1_DIV			330
+/* WDOG */
+#define IMX8MQ_CLK_WDOG_SRC			331
+#define IMX8MQ_CLK_WDOG_CG			332
+#define IMX8MQ_CLK_WDOG_PRE_DIV			333
+#define IMX8MQ_CLK_WDOG_DIV			334
+/* WRCLK */
+#define IMX8MQ_CLK_WRCLK_SRC			335
+#define IMX8MQ_CLK_WRCLK_CG			336
+#define IMX8MQ_CLK_WRCLK_PRE_DIV		337
+#define IMX8MQ_CLK_WRCLK_DIV			338
+/* DSI_CORE */
+#define IMX8MQ_CLK_DSI_CORE_SRC			339
+#define IMX8MQ_CLK_DSI_CORE_CG			340
+#define IMX8MQ_CLK_DSI_CORE_PRE_DIV		341
+#define IMX8MQ_CLK_DSI_CORE_DIV			342
+/* DSI_PHY */
+#define IMX8MQ_CLK_DSI_PHY_REF_SRC		343
+#define IMX8MQ_CLK_DSI_PHY_REF_CG		344
+#define IMX8MQ_CLK_DSI_PHY_REF_PRE_DIV		345
+#define IMX8MQ_CLK_DSI_PHY_REF_DIV		346
+/* DSI_DBI */
+#define IMX8MQ_CLK_DSI_DBI_SRC			347
+#define IMX8MQ_CLK_DSI_DBI_CG			348
+#define IMX8MQ_CLK_DSI_DBI_PRE_DIV		349
+#define IMX8MQ_CLK_DSI_DBI_DIV			350
+/*DSI_ESC */
+#define IMX8MQ_CLK_DSI_ESC_SRC			351
+#define IMX8MQ_CLK_DSI_ESC_CG			352
+#define IMX8MQ_CLK_DSI_ESC_PRE_DIV		353
+#define IMX8MQ_CLK_DSI_ESC_DIV			354
+/* CSI1_CORE */
+#define IMX8MQ_CLK_CSI1_CORE_SRC		355
+#define IMX8MQ_CLK_CSI1_CORE_CG			356
+#define  IMX8MQ_CLK_CSI1_CORE_PRE_DIV		357
+#define IMX8MQ_CLK_CSI1_CORE_DIV		358
+/* CSI1_PHY */
+#define IMX8MQ_CLK_CSI1_PHY_REF_SRC		359
+#define IMX8MQ_CLK_CSI1_PHY_REF_CG		360
+#define IMX8MQ_CLK_CSI1_PHY_REF_PRE_DIV		361
+#define IMX8MQ_CLK_CSI1_PHY_REF_DIV		362
+/* CSI_ESC */
+#define IMX8MQ_CLK_CSI1_ESC_SRC			363
+#define IMX8MQ_CLK_CSI1_ESC_CG			364
+#define IMX8MQ_CLK_CSI1_ESC_PRE_DIV		365
+#define IMX8MQ_CLK_CSI1_ESC_DIV			366
+/* CSI2_CORE */
+#define IMX8MQ_CLK_CSI2_CORE_SRC		367
+#define IMX8MQ_CLK_CSI2_CORE_CG			368
+#define IMX8MQ_CLK_CSI2_CORE_PRE_DIV		369
+#define IMX8MQ_CLK_CSI2_CORE_DIV		370
+/* CSI2_PHY */
+#define IMX8MQ_CLK_CSI2_PHY_REF_SRC		371
+#define IMX8MQ_CLK_CSI2_PHY_REF_CG		372
+#define IMX8MQ_CLK_CSI2_PHY_REF_PRE_DIV		373
+#define IMX8MQ_CLK_CSI2_PHY_REF_DIV		374
+/* CSI2_ESC */
+#define IMX8MQ_CLK_CSI2_ESC_SRC			375
+#define IMX8MQ_CLK_CSI2_ESC_CG			376
+#define IMX8MQ_CLK_CSI2_ESC_PRE_DIV		377
+#define IMX8MQ_CLK_CSI2_ESC_DIV			378
+/* PCIE2_CTRL */
+#define IMX8MQ_CLK_PCIE2_CTRL_SRC		379
+#define IMX8MQ_CLK_PCIE2_CTRL_CG		380
+#define IMX8MQ_CLK_PCIE2_CTRL_PRE_DIV		381
+#define IMX8MQ_CLK_PCIE2_CTRL_DIV		382
+/* PCIE2_PHY */
+#define IMX8MQ_CLK_PCIE2_PHY_SRC		383
+#define IMX8MQ_CLK_PCIE2_PHY_CG			384
+#define IMX8MQ_CLK_PCIE2_PHY_PRE_DIV		385
+#define IMX8MQ_CLK_PCIE2_PHY_DIV		386
+/* PCIE2_AUX */
+#define IMX8MQ_CLK_PCIE2_AUX_SRC		387
+#define IMX8MQ_CLK_PCIE2_AUX_CG			388
+#define IMX8MQ_CLK_PCIE2_AUX_PRE_DIV		389
+#define IMX8MQ_CLK_PCIE2_AUX_DIV		390
+/* ECSPI3 */
+#define IMX8MQ_CLK_ECSPI3_SRC			391
+#define IMX8MQ_CLK_ECSPI3_CG			392
+#define IMX8MQ_CLK_ECSPI3_PRE_DIV		393
+#define IMX8MQ_CLK_ECSPI3_DIV			394
+
+/* CCGR clocks */
+#define IMX8MQ_CLK_A53_ROOT			395
+#define IMX8MQ_CLK_DRAM_ROOT			396
+#define IMX8MQ_CLK_ECSPI1_ROOT			397
+#define IMX8MQ_CLK_ECSPI2_ROOT			398
+#define IMX8MQ_CLK_ECSPI3_ROOT			399
+#define IMX8MQ_CLK_ENET1_ROOT			400
+#define IMX8MQ_CLK_GPT1_ROOT			401
+#define IMX8MQ_CLK_I2C1_ROOT			402
+#define IMX8MQ_CLK_I2C2_ROOT			403
+#define IMX8MQ_CLK_I2C3_ROOT			404
+#define IMX8MQ_CLK_I2C4_ROOT			405
+#define IMX8MQ_CLK_M4_ROOT			406
+#define IMX8MQ_CLK_PCIE1_ROOT			407
+#define IMX8MQ_CLK_PCIE2_ROOT			408
+#define IMX8MQ_CLK_PWM1_ROOT			409
+#define IMX8MQ_CLK_PWM2_ROOT			410
+#define IMX8MQ_CLK_PWM3_ROOT			411
+#define IMX8MQ_CLK_PWM4_ROOT			412
+#define IMX8MQ_CLK_QSPI_ROOT			413
+#define IMX8MQ_CLK_SAI1_ROOT			414
+#define IMX8MQ_CLK_SAI2_ROOT			415
+#define IMX8MQ_CLK_SAI3_ROOT			416
+#define IMX8MQ_CLK_SAI4_ROOT			417
+#define IMX8MQ_CLK_SAI5_ROOT			418
+#define IMX8MQ_CLK_SAI6_ROOT			419
+#define IMX8MQ_CLK_UART1_ROOT			420
+#define IMX8MQ_CLK_UART2_ROOT			421
+#define IMX8MQ_CLK_UART3_ROOT			422
+#define IMX8MQ_CLK_UART4_ROOT			423
+#define IMX8MQ_CLK_USB1_CTRL_ROOT		424
+#define IMX8MQ_CLK_USB2_CTRL_ROOT		425
+#define IMX8MQ_CLK_USB1_PHY_ROOT		426
+#define IMX8MQ_CLK_USB2_PHY_ROOT		427
+#define IMX8MQ_CLK_USDHC1_ROOT			428
+#define IMX8MQ_CLK_USDHC2_ROOT			429
+#define IMX8MQ_CLK_WDOG1_ROOT			430
+#define IMX8MQ_CLK_WDOG2_ROOT			431
+#define IMX8MQ_CLK_WDOG3_ROOT			432
+#define IMX8MQ_CLK_GPU_ROOT			433
+#define IMX8MQ_CLK_HEVC_ROOT			434
+#define IMX8MQ_CLK_AVC_ROOT			435
+#define IMX8MQ_CLK_VP9_ROOT			436
+#define IMX8MQ_CLK_HEVC_INTER_ROOT		437
+#define IMX8MQ_CLK_DISP_ROOT			438
+#define IMX8MQ_CLK_HDMI_ROOT			439
+#define IMX8MQ_CLK_HDMI_PHY_ROOT		440
+#define IMX8MQ_CLK_VPU_DEC_ROOT			441
+#define IMX8MQ_CLK_CSI1_ROOT			442
+#define IMX8MQ_CLK_CSI2_ROOT			443
+#define IMX8MQ_CLK_RAWNAND_ROOT			444
+#define IMX8MQ_CLK_SDMA1_ROOT			445
+#define IMX8MQ_CLK_SDMA2_ROOT			446
+#define IMX8MQ_CLK_VPU_G1_ROOT			447
+#define IMX8MQ_CLK_VPU_G2_ROOT			448
+
+/* SCCG PLL GATE */
+#define IMX8MQ_SYS1_PLL_OUT			449
+#define IMX8MQ_SYS2_PLL_OUT			450
+#define IMX8MQ_SYS3_PLL_OUT			451
+#define IMX8MQ_DRAM_PLL_OUT			452
+
+#define IMX8MQ_GPT_3M_CLK			453
+
+#define IMX8MQ_CLK_IPG_ROOT			454
+#define IMX8MQ_CLK_IPG_AUDIO_ROOT		455
+#define IMX8MQ_CLK_SAI1_IPG			456
+#define IMX8MQ_CLK_SAI2_IPG			457
+#define IMX8MQ_CLK_SAI3_IPG			458
+#define IMX8MQ_CLK_SAI4_IPG			459
+#define IMX8MQ_CLK_SAI5_IPG			460
+#define IMX8MQ_CLK_SAI6_IPG			461
+
+/* DSI AHB/IPG clocks */
+/* rxesc clock */
+#define IMX8MQ_CLK_DSI_AHB_SRC                  462
+#define IMX8MQ_CLK_DSI_AHB_CG                   463
+#define IMX8MQ_CLK_DSI_AHB_PRE_DIV              464
+#define IMX8MQ_CLK_DSI_AHB_DIV                  465
+/* txesc clock */
+#define IMX8MQ_CLK_DSI_IPG_DIV                  466
+
+/* VIDEO2 PLL */
+#define IMX8MQ_VIDEO2_PLL1_REF_SEL		467
+#define IMX8MQ_VIDEO2_PLL1_REF_DIV		468
+#define IMX8MQ_VIDEO2_PLL1			469
+#define IMX8MQ_VIDEO2_PLL1_OUT			470
+#define IMX8MQ_VIDEO2_PLL1_OUT_DIV		471
+#define IMX8MQ_VIDEO2_PLL2			472
+#define IMX8MQ_VIDEO2_PLL2_DIV			473
+#define IMX8MQ_VIDEO2_PLL2_OUT			474
+#define IMX8MQ_CLK_TMU_ROOT			475
+
+/* Display root clocks */
+#define IMX8MQ_CLK_DISP_AXI_ROOT		476
+#define IMX8MQ_CLK_DISP_APB_ROOT		477
+#define IMX8MQ_CLK_DISP_RTRM_ROOT		478
+
+#define IMX8MQ_CLK_OCOTP_ROOT			479
+
+#define IMX8MQ_CLK_DRAM_ALT_ROOT		480
+#define IMX8MQ_CLK_DRAM_CORE			481
+
+#define IMX8MQ_CLK_MU_ROOT			482
+#define IMX8MQ_VIDEO2_PLL_OUT			483
+
+#define IMX8MQ_CLK_CLKO2_SRC			484
+#define IMX8MQ_CLK_CLKO2_CG			485
+#define IMX8MQ_CLK_CLKO2_PRE_DIV		486
+#define IMX8MQ_CLK_CLKO2_DIV			487
+
+#define IMX8MQ_CLK_NAND_USDHC_BUS_RAWNAND_CLK	488
+
+#define IMX8MQ_CLK_END				489
+#endif /* __DT_BINDINGS_CLOCK_IMX8MQ_H */
-- 
2.7.4

