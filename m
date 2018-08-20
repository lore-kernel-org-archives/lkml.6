Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161F2C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFE2208FA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z+tLh1c5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFE2208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbeHTKa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 06:30:59 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:40384
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbeHTKa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 06:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1CEkcKMXuHIkq1FzzQ5ZU4O0OIi6VqSJIBtUB9d7JQ=;
 b=Z+tLh1c5w3Ekp1Ox9blJGym1xrX9skgGdIp6gakPq0/8HRfRylKIKP3t0wO7Kk0VP93O8DCMTIJ6iVJUViOFoci8V3dwhOImkz4gmlUiGYZSMsy5uzLLaBEicKUwGobxImmveGHpkLVdegQyRwp7g+JjQhzUffHgpYxLZhrwmHg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 DB5PR04MB1608.eurprd04.prod.outlook.com (2a01:111:e400:5994::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.22; Mon, 20 Aug
 2018 07:16:21 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [RESEND v5 1/5] dt-bindings: add binding for i.MX8MQ CCM
Date:   Mon, 20 Aug 2018 10:16:03 +0300
Message-Id: <1534749367-31085-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534749367-31085-1-git-send-email-abel.vesa@nxp.com>
References: <1534749367-31085-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1P190CA0037.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::26)
 To DB5PR04MB1608.eurprd04.prod.outlook.com (2a01:111:e400:5994::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34351a56-c89e-47b2-f1fb-08d6066cd5b0
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1608;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;3:EMifjdWHS9MZlsOUGy8WC0HggfvbqIRjeeBOPOZreEIcKCtAne3NW4K2DeUqhLxs7/52uw8P2ACSq+dMJ9Mu4hNiM8sdAPbYUVi+J6VUT7etiAHce8/r2CZgs7knvQJEachSm614m7RzV/wWaTHBCESOyBvUpf/Mo+vQFZ4FnJeLs7MQ4a7VNuhS5L28Ofx51NAUiiNcnukvffReymapbzX1pEWqVA2ZMzBDs7p8weLmm14znlEdX3jKnk7NFqom;25:9DON4fdufzpZ3gbEQDHGtLiedVmTJdhANYlz74dPpu7MsSJZ3DovEdOcbsB3/Na3HGhJWy5afoFFZH4uRPVVd9mgMb9Ltf0EKZ89r111/yATJMN5eYcFdeJSSqk84NhdR+y022T9QPrKiWow+KPhlWV/7hlyUNUnsK2W0B/0UgC5aplwPJVyQkqGL0BfQSJNMxkz15LLKtnN1SQfDR8c1oGO7+4ngbzrFd85uUblM3LKb1JcjNK9a4P4aIjjs5PPAvhcwm03bIPKEOaJTzBwCCgUX1IhDqXIski0tNiwiDAYbU/XRlcrfjLBNsF/15CSE7IeKxTC7ksjN+LXqPZIMw==;31:3gAGzb1V4DxrvuqPv9SzbfJHegYMz22FC7zDlTcujPJ076KfRLuhUVeacoPO8rc82JmXgJ4dRw/XqLMkiLt9hIA2E2iWjI3T/4AxDoKSSORM/Eu9i1rjeSrw2MPDYDA0GqHDsSXFzlTM3amBFwUKEoYkAYfrzL3E/gGWlKpIvOv6qfnsg9vmHBzqmZoyfenzONq8CbqVnHUxz3KtnWJtleGs82XeBhHma4pCoipJNe8=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1608:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;20:NdFcDvJy112ENW7AS+09Ix2TaAXOwYdc2MEf60zJ/O7krSz0G/oMhazRd2En1xw1i7DL/PZMoZMFCAuzhABISFn1pyHddNjrNhxjnxTBtjJlTg2PbuJC6hVNcLj8qqxtc3iqgL1msvsc/MgjfXn6FbttyO+mlaCMXX6xu5U2TSLYqM8fdOVbDYMocjx7we64MM7XBa1zC6dbIJFssSaptGOw4oubbg19pDfcuXoJA12fkUmgitG/CFXtZiZb1yXyoKlpdKPzUGI3x7xbBRQ2VpSRnkXuIULd0W3wE4jflwyO0nnA8AbOaS0H0bQGcICjale19hqzsMjO2TbpREr+JmkixWVrQckNRsaSshCUDpslR9CZglthNYsMFntl3JATq9E+sgzA7bId3uAiw5YFLq0Nc4DfBLHZHChHrhpWkp7b+Ob4NFZdj0Lpn5E0oF6kWgjihW7FxvRx8CUEPep+hMLA4Uh5d8ch7BE4RHrYBogs4KvGay0ahgMBKJcMG2gT;4:UTQp0d9jBv1JlnxLgQLq2TJU5iws3batdfZpKm3eTMy+9/6YEFQ2M4DGvUGjSWC+61B7ac1zsbJhAoWJw9thGS3xajCG6HROD862Cd8dJEhdciOfChKTVQ7kCL1YWzWIElXzglMnj0HGyIA3N5lBmr52NSn900hRLjun0cc26R+NIuByK0Xjn87bRPpTQUQVtL9jE/7vYNyrSVZRGHgd00GW/SMRLVTsyY8i6wR7vFvzd0JAQKvr9PGTvCceK2mjTDtxRVRCo3VfJZhL7CgD1sTnHmIKI+BVBtVmqhP9uOIQykZovqCiE5PdQgzGVFK6
X-Microsoft-Antispam-PRVS: <DB5PR04MB16086B25A34C034347903B3FF6320@DB5PR04MB1608.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:DB5PR04MB1608;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1608;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(346002)(39860400002)(189003)(199004)(5660300001)(7416002)(50466002)(6636002)(6666003)(305945005)(6486002)(48376002)(4326008)(25786009)(86362001)(51416003)(66066001)(81156014)(81166006)(316002)(76176011)(7736002)(47776003)(44832011)(16586007)(110136005)(52116002)(54906003)(8676002)(16526019)(478600001)(386003)(186003)(6506007)(6116002)(97736004)(106356001)(68736007)(53936002)(105586002)(3846002)(2906002)(36756003)(8936002)(50226002)(446003)(6512007)(2616005)(476003)(486006)(26005)(11346002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1608;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1608;23:CblPlFKCRMgRlzfnkoXixxZo/wvXgtxOn00vNZq4d?=
 =?us-ascii?Q?XcNzVjwnumyzFU4CvtAQSiR7sQU/SwhDxP9wpe6mOvZ92SkoCYMjDlHtkuVv?=
 =?us-ascii?Q?kbsE+ErVdP/ILHEzrwFsIuk7V8pM/thqPd8nEqy6aTaf5Nif1PO2kOjlb2CA?=
 =?us-ascii?Q?CxtHETqr7lo6mA83t5tL5jmTIdUAHvprnp94+D0UvlkRv6e4+ZwcA1f3zPhY?=
 =?us-ascii?Q?2EoS83M3zh3wm9mfxomXy/Ml7uPBtiKG5iY4NcpcZOyNeYN1FUc1QAeI97fH?=
 =?us-ascii?Q?br0KQm0YyHLL63yfAXeza5n3a20CpX0vt4x+X170YGwQ61oayz3yQFeGsQTQ?=
 =?us-ascii?Q?pSyFTkTTc+1unnW9NxoHU9c7qyCWmKjAQ4/cqY/QdjHlg31blSSA4/x3pnXQ?=
 =?us-ascii?Q?tqAABc0Iiyc9dqNJeU9BAgNGKEPgU1kXMgzvjpazVmNBYp0/4uslqyFnu9tq?=
 =?us-ascii?Q?cjR5qlIdoIvID/CZTz4ZL34FMnuoPD6z3SSOVBC8HXg0XUUy+ZgrjIOj6IFp?=
 =?us-ascii?Q?TvEADtYTBgq7PNrVXTv8MU7VnJ0F+n15iH/7UC0HJ1CnMt6h0MC2TgexnNNR?=
 =?us-ascii?Q?yObBDllHqmKPgrnL8CCncTa76A+a63EwOxXKAu9DaijzS/t1QD0ZmNPD3FA+?=
 =?us-ascii?Q?eO8X3fOcwqsjygqmQwT5L6ONEAcsNl16uVGSETevp/nU22m8Zhz0giLMvFkM?=
 =?us-ascii?Q?F2d0FEeiwX857Bfwk09BbrhWnJHrEXGVpF1bGIIjWfagXGEKfiC5PF8p+iFj?=
 =?us-ascii?Q?NqACzB719mggm6CVmgwSAk7a3RQ1EmHgkDjQwlfySmIWP5Ogm90dZeagHuF2?=
 =?us-ascii?Q?DynlWfW8P3+DXVrvkiZmh4daFjtorfAETIwfbU0xQW2919LYo8NDD4lSURkn?=
 =?us-ascii?Q?qFxiYdJZXRRNENy0LUb8GjFqBAqpWJUb0YFVqpudwkLPRFeyfIYYBwxbo5yA?=
 =?us-ascii?Q?d1RzNe+dFkn51v/7/GKrUUe6Kir5LEW79cpD1oIE9HdUIVlfFHWFGo7N69Xm?=
 =?us-ascii?Q?yZK7DJXeeAOPTwQYOZKavsR323xK4X8et0e0vqwHxKOjsmQ5x7f8J7CAzphj?=
 =?us-ascii?Q?Vot7TojbuSwYm4se3+SyB89Xw2cAzirAq7UBp3sVMvSI87G5D3aPD/gkHtXT?=
 =?us-ascii?Q?ikWfJg2GT2+3z7JoCaDzi4NW27U8VYncB+0JHQQW9hUFKwhXBcld/4/90NYR?=
 =?us-ascii?Q?HP+GeCvGIAIKQFyW+HTR4ed/P8mVx4gnk/4WpKRp5aPOHrTm+4tMIaDl9wKp?=
 =?us-ascii?Q?k7UM8jGAe16W3wT8P4=3D?=
X-Microsoft-Antispam-Message-Info: hSM43yFNnG6BlJylDBW6Z0PvQk4CcJZcbOfhU7UvIgcVL/uTG1qHZGKl2H/hNN5Sxg3mj+TeCc0vJdDj0Rx7i1v6hL3ftQdQMWQ4q6OSLu45Wko96CL5qKxEJ4OSmpBF1zSIWmHFJwHL8TZiNhX1bPablDw4KDRhiRDR+qa7qZ5EQsXLMK8tDWoJJtc7GHKObEDYkW9qy2ccSaaH0BqOshaPNKRuzNC8nE+snnsJllfxmHO2ALsFHGtfEaHrHrsnPgrfvM1023QDNE5Vun3FfbgHnacg7GYSQMNHyO7SrsClSnBvxWQPNH2zBwsfZRACwC0nzBm1Mz8lJUx7VboPp1DSpjfAXHEdR47fhtehUBk=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;6:zGQDvwFYNbr5THWErQhiKjpafPkbLS2I8tO13UZLZWRU0tYtNxaM3G5aA+3x5kM2t/5TtHsbjpMgYzJzSSSneTThm6zAGsMYdU1W38HshdiKMu//NSih9Nc0C9qqzArYo656ZyXDe7CW8XPigFLUCpE3d8jaIzB7nRZ2uJazrfxVmLSKNfIDBjajJ08f2t/QU1EIRH9PBCyEOtgGaU4CxKQy10H/RD5XeWTamy1tAdGDKNlPa4AURC3S0i1YU7owed3OGiMO4wmr8574Jlw0/MG61IGwBGH1RwswB9iZpfduZLwbX+hwUp59FZkSLdw+e+Rz0+d1P/99dtT2rwEiTQHBYam56u8yVvpDIItsIDboQPOmhmADR6ZU8nS4ifOxWk+YILdYiXC1lkYegpboCoELGtQuZCJ2qgVxqz7y+iTt3IaxJiu7+a6qVxOe6qe6krFEY7xcy0dhemqUyX4t3A==;5:Z9emdDAEwHm73TXelMBM5/rcZ/HaXFhITVyRpE+33UHml2w8dTo16WcLgxbvXHm2S+JPMVk+neV/+ijZTQe035Goiz0slWKtxiRVaEeL3RKhtTjpUdowjgqulkTTWKG3VLmMX5178qQ3VD60Lg9oQzpFwiUAgda3nyOYmCu2Tag=;7:7s9y3gZLd+w8Y0zlRUlnc5CIL6JuiiBSNo+2mRMWwsNSxn9zNMUM8WCzkeYWhMO7IrWsE57hDgsPsa8IKuJpbhRimnoYCFgaySeITo7lP36gpixch03SWbbXZ8Gdl8MsbjfRgQSft6dCbyZG4SvgsZnEQ9oIrHYrKFDYfMRXCgY/lsvGrPvicozf5Fq9Z/uKpPhHsyd8YUyhTSHiYS/bnU7PFpexIUmbtBOeAqh2M5SYWjipCt+BLf5jjpUAO/Ob
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 07:16:21.1818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34351a56-c89e-47b2-f1fb-08d6066cd5b0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1608
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

