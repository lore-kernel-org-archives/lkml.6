Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AC1C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FE1214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s0sPHmLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FE1214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbeHVROF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:14:05 -0400
Received: from mail-he1eur01on0051.outbound.protection.outlook.com ([104.47.0.51]:19992
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728396AbeHVROF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1CEkcKMXuHIkq1FzzQ5ZU4O0OIi6VqSJIBtUB9d7JQ=;
 b=s0sPHmLnxZsCq40cCSmy34/gqEYiMMCmwy+liw4Zil9I9Z4NeFUVz+wpUHrJa6GZ4QYhBvahAwPHkFQleMyZ+QmodIRj21tKrIkTQX+Yf1hMHkb3sBWmRJ+jCGUjWstxJKaGSzdaEavTgZrFXiM4XDlTgbJ+wzaMaKW+XSspL7U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 HE1PR04MB1612.eurprd04.prod.outlook.com (2a01:111:e400:59a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.21; Wed, 22 Aug
 2018 13:48:36 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v6 1/5] dt-bindings: add binding for i.MX8MQ CCM
Date:   Wed, 22 Aug 2018 16:48:19 +0300
Message-Id: <1534945703-4730-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534945703-4730-1-git-send-email-abel.vesa@nxp.com>
References: <1534945703-4730-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1PR0202CA0043.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::29) To HE1PR04MB1612.eurprd04.prod.outlook.com
 (2a01:111:e400:59a9::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c67a4f5d-a1d4-4762-0cdc-08d60835f642
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1612;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1612;3:blhTXtYpt82ys9osKGII3XiwGVzmLOb8fKAEhToGzPhiWf2AIjI9xejnV5VtVEHMtOZ/KO5gq0B+YYgHFN3VYen+/SwEKIT+73hFZ5DYDHvahs8xXrMZg5tpBTRvM9Mj2IDBnF2mlfqkdEY/EuQdD3AeyQH8Ai5h/PgnHWCOMCHD/0L4SGGsyYCW6S9HTkNgcg+rIPswqAXpGfSuMim+lAWJaageRrsqAUPvUr6TPdsJFzcPyy4KMkrM5wnYXrxd;25:FbDrKMEQhvHYahDGFJmZaQPV8dTJ3+j4iNgaByeJiYwcb8BPtUSKE01R1sUjqTzXhODwGcIcD14vF0kLDrcdcBap9evoO4tfvGaH25KGVECkfCZGqJUgY0PCZVdQbQCev4f7ATMOMBbj1kvw7EaPyj0LvZq9W/9OFk41lB5b5awM9tI2exyI15o+erVw3bw//h6rMPwfFr/Fy8t7f0iXsw5SyjCCf3S9SSeVA9ZbB8pSsu+H1LtP8PN7cZzdD6V9Gpe8sID8zqhNzejBvvHqAfPb9c54/uWXo7DE2fTk3a7qMvIX69EKLnwVTTUb4vsHIN/f8x+H7VZLoJnafvifZg==;31:DMY1jueQT4K3xLZuu2RFTkDRdkrN7RbRJmrONVP1HHBG8n/zVBPYBSyqUnhBEUKMNhKp89pqC43ncq4GgDZ+4j1REnulyJmrcyMdQiWtAH3cYOBR07rvcTfVdPQ4Ogp52BMso/dGa2OQaAb0f81dG2RVJIvCzO4ju1k5E6QoK3VyMsyU/1J5BC0+sQ6g+rcwgYSvNVgUtbLQHaraHKts7wP4QcnzCDkT9E2EZFdRs8I=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1612:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1612;20:e76RgxG0h/02NQoK7A7FE6AQX2CdcsPw+F6uub2p6bHGlvDTx8/fQ6+NTbtKa0lbUnFSJSueFE+JA3XmxsKbzreOPi1vsdiHmdx93By9YR9lCjVSC/Tywo8R82tnmpm1HNVbLf7vtFwn43kRd7enBX8SUWFDX0tqEf6dirOrH1qOhCK3BeHL6O/2sq/RBA/TPz5Cs/65AQjEd+5Yjo7Gh5RlAwho7n3pvgbt7HxUJoKXCw/yhSO87yKisBgu+ZNTjL3pw6qGv7kwm69XyawIPMOFkKDuYXm9l6ZohxKhe8JdD2oEjiL1QQH+tVUNoAmrL0NopBDCsXpHkQcUSzJfm8x92NL+zKZ1bqqHMNdO4GEOgn844wAHQjh8f4C2WenUl2umHrgdGPcG1xdJd5gqxfd7+1rNh7/AX6Pe9MfqiSYvsZr308JeBA2IvZv7euSZUT+Uuek7XGPZ46tn4qrcWoTZ5U4yEhD3sXUDIJNotANPyGMkphYoQ/Jcavzq3uGL;4:kHgDgM2KyO2yllDESoqTzlWa7D1g8uJsyr4CbBHSvW02tgwboBTjFgesyHQDs3IUkq6sTeWBOGcKQ5vi/zpnb8y2x5TRykG6MS42NiwcBRSnCytmZC13TdPKtl39jpwkwxyTaap9DB0EJewamNFeISuGNt1Q7qOeHIjpUO6B7jRp5T2EaYH3MZDrmVorVWOS9kIGiKniYu4oProCp+Xybekqs4WZfor60VkehEyUFM23PYOvy4Qb9K+DlNHjsMPONLQhxm3WV8x+km9zoGpxnrx7CuXc5Jz+PLdIIPRQqRwk9/Oc+pDd2rqMvIN9tUPk
X-Microsoft-Antispam-PRVS: <HE1PR04MB16127ED395B95D8CFBE3D34DF6300@HE1PR04MB1612.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:HE1PR04MB1612;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1612;
X-Forefront-PRVS: 0772E5DAD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(366004)(136003)(189003)(199004)(36756003)(6116002)(186003)(26005)(16526019)(51416003)(386003)(52116002)(316002)(47776003)(66066001)(110136005)(6506007)(50466002)(76176011)(48376002)(8936002)(54906003)(97736004)(478600001)(16586007)(44832011)(105586002)(25786009)(5660300001)(446003)(86362001)(2906002)(11346002)(3846002)(6636002)(50226002)(106356001)(6666003)(476003)(486006)(4326008)(7736002)(8676002)(81156014)(68736007)(53936002)(7416002)(2616005)(956004)(81166006)(6512007)(6486002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1612;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1612;23:3tX+0/RXzamVH9E1xAbMMJmFTL9rE6f1z4uSWpf9d?=
 =?us-ascii?Q?QIv+tY+3YsxKET23bJhf+ITXedMH2w1oRyU7q5+QDIx77fatUWjfl5BmG6Bu?=
 =?us-ascii?Q?OBgZpiYpKlL4Oo70uxKnOeJMj5iKFPwo6acIKGhu3J6G+U/kbg6H1T74HOBj?=
 =?us-ascii?Q?tc7RCJ+z92TTTEfsXLW3OTwa+C6jhnQolwkU8VbfrZMJbpGhm8dT+XIK2EeN?=
 =?us-ascii?Q?TIp4phwxR/zYv27L7tHUid5hzyxbjhrR7szzLTs8fT42UnnA7tp9SBqrE65x?=
 =?us-ascii?Q?EcqzL3w5zBzSAob75/rYwM8U5awXKum5PXcIt3G8nL59ipDWMWXNkL9tS5Bn?=
 =?us-ascii?Q?KG0FMysOCGOWhk2syI5J01NVmF4kTExsf/Wywg73+eajQfVmBf2wCNZh55ef?=
 =?us-ascii?Q?Rv/ArGaTGPYFvj+mutHISfUV5DbMocMe2YrCbiakX4HS8rA3cYOBYsHNBoY5?=
 =?us-ascii?Q?HTEtmguBs3FlxBkXFIP/BQBSu2dd76lC61EiPvs8nPu77288+j2k49yAcohn?=
 =?us-ascii?Q?AtuRpgT1dGO3Vcd7ta8OpNoiP+/JAfHUDrA+ECkChedYRf6EeoZbni/GMenZ?=
 =?us-ascii?Q?iojVuTBpwLSadkARM9rZ8rjMlkTLPE9TJdIxZxdlK5EkycSe3hZYtaHX8zzf?=
 =?us-ascii?Q?ZGg7LGz0f2Bu7sqgc/RVZ37aJyvGXtawvmKp5pvgpInafAo88/KU5UEYO55A?=
 =?us-ascii?Q?/lrbkTwzf0sJieZtNPhyW+m1c23Z1JFGJ3rHMv4nt9aP9B1YjXciFjRgv9n0?=
 =?us-ascii?Q?sWRZBXfyv4fJ9Odv5PKVVPXMAL49ttLKz7s4QJ6GD/r50UYSLOQOaZMJyW+w?=
 =?us-ascii?Q?RM3odCajxNimd9H3MrhNTUpJFXM21fHIbgDR4wZ54evsSuLRaY2j8YHQtCbb?=
 =?us-ascii?Q?5UwtVT60EbaLbu0ZjPCW5zUJJ1XIe/SuZhvuv3InZEn7Qc5TvjpKkYsUrhrX?=
 =?us-ascii?Q?0n4F+i8unu6Y6ZDfbry9noNluZnviwjHKor341p+j34RnmwEVLLTAzx/rS0U?=
 =?us-ascii?Q?t5kAtYYTwGGrE6AKIs2+MBZFjvrGOzBQ71/2jK6U8SIILvRV49rAbQrSUeQD?=
 =?us-ascii?Q?qooET0N84ythYtawXU8pweR8MiBop3HUB42hqr4N9ZNmm+m++7PqtTqpo/zV?=
 =?us-ascii?Q?rDk2fWfS+jltDT8Fa6rqt3VyPpIQ2kYIrIXZXDNbvYShmS1vX+GJZCYsNeHz?=
 =?us-ascii?Q?nsE935xWJQGQv99zeIeGioKUAWFhDIKhB3YgLUgHT/4JNiH/S95/cgWZT1jx?=
 =?us-ascii?Q?yFj3EsXZXEUBjFkOAc=3D?=
X-Microsoft-Antispam-Message-Info: CjOpP+skx0RDS/Vfeek0BvZZYLK/jQbwi3mPkTk4LAW64VGlg6jHg1WcPfRQTuyGkuK6QriVjbKGVk5nYQS5I3O94Mnv1gx8rsTuXGR4zEc9dCCJagFZzl/ak7GHWGQN+xqDU2CxOiHVQ3ZDw3Cvi9R3vOqZrngCDX+pWm0CMwT4YSLcqmDFDG2K//6uqQEK+Pxxeefs/3JHKBxzsuvKsMOy75p3ytQiVSW7X0+1TUNtu7Tr+Pp120eshJ5jiXnkJliJUkwKq2DVPG/8c6Nt2NdZOob6bRYqcs1ALJj8EN9scBQTLWFp7DEfmnIYebIaNiO9tMAw2VpRMXhfgabb20/hnnCwTRFkQdBlXCOEG70=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1612;6:weDW2x28S2nrgq1Zq8NQ6TZ2dp0Ho6dAjlsThcI5SA6UrQ1jNERK+MjrpaNUtzyMaYfUdK2+HorJ3N0mcIzQAcntCEgC8j7LqEgZRrn2fjUIzAJGaeQk5tDn/VegHLQkewkRi9KFWqnniWpt7i9jHAYFZ2pRRQJKSC1WF1syOverCr/c/RSex51SxoVtpYmiidUbAFqB1+CI7RSYcXTygIjTZ1AY3QbqXN1j5GXeSQqhEUN+gkAG7mhzjUbLX/bvJt+S7JJjGaxL7QUjQDodahNoqxNNVqxN/aJ256sHW7r16lJ702m6lqwP29toq7//ThbEUxnJWMvGhtX3wSArvQfOV9sUeaffH++W9D7NtGcrp0UIRNuZfER4KTej1KPEECCWyQxRgFkHp/SMTNQxTsiuBAa7ND1bF2debJdUEwb7/s6mN7lB+CSY4U8Yhl8fPx1CS/gBr60mEKY1pH1vNQ==;5:M6THevts6uuDL4L6m42qBPm4u50L75CkADvHhhqO9l4vNVnZqumurqyEuVIWhMloL94FT/K1L/xUKeQY4QYHkHLHSQ38Q0KMbwTZU7zR2dKoBOnkn+YDTlk+sYQKXFzANDeczKjOX/Knr3wTqYyGNMrZz7J2nX0uOB/DW6Ye9JM=;7:9KqsWMiQyT7GTVrK3D9MNlAvcf306VFLxLKMspHUB7PDsYsfJJBxlSdgze1JRQ50cPJmqiTC0DQsMgwSCw2JsoeGt2EZK/nZbrRoDjUK/5nJXmr20vfzJNXEvy4xVD/cqxj1CpsjtuW8liePu00hOoOqg3qOy03bzriHyDKUqDaI08RiX92ugS16FpRiyrwj1vjGk5MHEwMIVovj5W4aC2IaZLG0dxSDH0Debgt/PnO/Psqq+SC5ts3eF8gK905C
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2018 13:48:36.5937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c67a4f5d-a1d4-4762-0cdc-08d60835f642
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1612
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

