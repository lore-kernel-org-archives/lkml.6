Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B051EC10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B057217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="0xPrcwTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbfB0Uvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:51:39 -0500
Received: from mail-eopbgr750047.outbound.protection.outlook.com ([40.107.75.47]:36241
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730131AbfB0Uvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eNNWge4FNeF/gb2t2+RayD722X0oILwPTV4+dw2DK0=;
 b=0xPrcwTieaxHdiaOFBBvYB/jZrDPZzWRVJjiVPOpwoH5fmpMg9TBkONB5k8QCsqP9wAL9I2rFEk3bAwHpi5yBYTYtL+FGzpvpIGjcUX9gauOLCN/FC32PODoS3iCoivJuMrUwjl55XAK2ekZsBOPk2S8L0CetSF6qszkNMwM5ew=
Received: from DM6PR02CA0060.namprd02.prod.outlook.com (2603:10b6:5:177::37)
 by SN6PR02MB4526.namprd02.prod.outlook.com (2603:10b6:805:af::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.15; Wed, 27 Feb
 2019 20:51:29 +0000
Received: from CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by DM6PR02CA0060.outlook.office365.com
 (2603:10b6:5:177::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Wed, 27 Feb 2019 20:51:29 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT052.mail.protection.outlook.com (10.152.74.123) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Wed, 27 Feb 2019 20:51:29 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gz6Aq-0007dS-PH; Wed, 27 Feb 2019 12:51:28 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gz6Al-0002WZ-Lo; Wed, 27 Feb 2019 12:51:23 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1RKpKIq021081;
        Wed, 27 Feb 2019 12:51:20 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1gz6Ai-0002Vn-15; Wed, 27 Feb 2019 12:51:20 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <robh+dt@kernel.org>
CC:     <michal.simek@xilinx.com>, <rajanv@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH 1/2] include: dt-binding: clock: Rename zynqmp header file
Date:   Wed, 27 Feb 2019 12:51:09 -0800
Message-ID: <1551300670-6949-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551300670-6949-1-git-send-email-jollys@xilinx.com>
References: <1551300670-6949-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(2980300002)(199004)(189003)(76176011)(51416003)(7696005)(446003)(106466001)(426003)(6346003)(2351001)(6666004)(336012)(486006)(2906002)(50226002)(16586007)(47776003)(8676002)(5660300002)(316002)(305945005)(26005)(8936002)(48376002)(81166006)(54906003)(81156014)(50466002)(14444005)(72206003)(478600001)(36756003)(9786002)(77096007)(186003)(63266004)(356004)(107886003)(36386004)(106002)(2616005)(44832011)(476003)(126002)(4326008)(11346002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4526;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1812a6c2-1aee-4bd0-0d6f-08d69cf5591f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:SN6PR02MB4526;
X-MS-TrafficTypeDiagnostic: SN6PR02MB4526:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4526;20:QVa8YRUjXMEJrw2Bng+hNeu8hH9GcmpKL1esCW4gVK4x2nE+gqGpKuJt4n2GzKdTLEEBzYwdqhkAdnfDyWNxucW0GoqN3BRDXvk/LK7A8Ser4EApMEksWZie4bRfar8fKDIGbmZfDFJVWT/ABeayid9yuMGYb2fM0gzeJZr3cpszIdaiJfQzktByKxDKqncJOJ+zBtEfsdo/+qG0l0daqrggBXWiCt+ukQzbnow45fEVRtu/eK8jMdttZB4pt4kvl63tNi8aMj1RQtyJ1T+4jxcZgJnFN36QnwbD9vJMOIKM2mM4j5XBaIO0g46sfWWb9WNW0ATA8gWGDnFwGE3phK6UgXCu4xbNQLa3C4xApHt95nEr2C3uLbrJbyjw+c4eWBZCfJC3jG3RnVbiMDc+djAicm/xF9E1/JmUm04etXUjBLl1VOJJNSh3hQ96tuDnmA2rk0Df8TguMPX+7B1usi5wL+XbzRUhMVGemoCLMRCp1fNK8jY9psL6pIlD2kBO
X-Microsoft-Antispam-PRVS: <SN6PR02MB45264A8AE3045A07BFDFEADCB8740@SN6PR02MB4526.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0961DF5286
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4526;23:/s1fAyNRzijW/TgvVf6P8gntZOqvQ8b3WUA3fNnUA?=
 =?us-ascii?Q?gJvlEN4lcTol8bfFr5ZuREBLKGl92GrBpQuSjyDUtq37JxTG8vgrtPYOgGDz?=
 =?us-ascii?Q?wvv18cBsize8Ljq6+bzAT90jsDe0kTXCVzukmmnwj2x/G25uaYru0VwOzhmB?=
 =?us-ascii?Q?FMmUiDRAzNN7FcOMu8EM9VlCw4+6WdKeBuPDFL88Tfc7y3vNo4XWlQmA7xJz?=
 =?us-ascii?Q?wirdxvYN42FremV6aJUKZAAhm4L1AGjugZChwaiYiheY187YO4k+rlgURvAv?=
 =?us-ascii?Q?Sq6Ux3I5quVeVTPD9lnhJMjjzpvtKthy8AER6rnb+EU4NTvRRDl/Y7ajoHha?=
 =?us-ascii?Q?bj5qrKSQhzMtAwSPYWo7IAJSpCF+xyVLH/fuKGYRAYMdjBYX2TCT1rnm6G80?=
 =?us-ascii?Q?xOwumR65bartNnkF13mtaVaTdC8MWYMaXr0CL3LrRv+QtRYh3k6p3lmwvqyB?=
 =?us-ascii?Q?iTeiCQNDuWPdI/XfX26f0tRL+5Csj/TiKrQt0z4K4AR+rJVMn8XZ/WKF1NGZ?=
 =?us-ascii?Q?3kuez6NzSaW/9oKAwwaq0cW4TWf9vPiXWa++CKw8TDGFSqeA3EubXmjGDsso?=
 =?us-ascii?Q?S37cNe3UhlNtfutjtgL/UazusH8ZvoVyFuZCyHUZ3OR9qjQ4Y58rjFpA+NzL?=
 =?us-ascii?Q?BsTDuAeggYxEe3rtrB0MR3bshSTri8YVsnXiDhzthUi26xuU8oRkrlwesVWI?=
 =?us-ascii?Q?f9d3XfpUgVhwLH2xoBdSjoCUt5cq99MMiQX2w77abacNFPd7HZGqcdizCWnw?=
 =?us-ascii?Q?3KlPjO6I6jqsOAYQZChmnvGpGXtRs2V0PEhsbLZ4sr2Grw1kr7yr6Xyue75n?=
 =?us-ascii?Q?wyjLrOHo1PjhtB6Y6sj6ZM04BS5q7HEnes5eMCijPfKXkfkZ2IFOClivZawf?=
 =?us-ascii?Q?Wz3uvHOWLImA/gsLKXVwua6ymHIB8YLno8NapGQPQp0F53AQbyu4V4J2CWrK?=
 =?us-ascii?Q?zElKCXqRYXy3B0qv7B6SOswGoQYVcD4ZuzrIn4je9P4XTGBgRlgDKjE1g5oD?=
 =?us-ascii?Q?cvQncFLF0UOdniWiEyYyTK8ootZnz+aDWmaN/GcKtux9PzK5wwvtfkf+dFoe?=
 =?us-ascii?Q?xhq6nzi2CHR1wOrhFEj5/MCdCGT0EUbhbjQSUPZ8NQj5BGGkFz7Wunmz9LF+?=
 =?us-ascii?Q?ByKJ5PC8Rk46hDaCNLwJOBi1d42oh/ZioTmRYCs2UgYhX1c5chOyw=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: r9iFccaUk9HodWPX9/47OIBtVJdGNHD1ug6ybSDMRoriX3c+wx6+8TUKbTRA4mjeqdTo+vb+KdjV1nCaz8Om0AnXQmbEwSdyMdo2aVZf4tvCef/Y8Fr0QDwKOmskc2tKOyy91Pz6Hi/BmHbe5iDPrqVJ52pHZoQhJdbU1tmHmk5ZLteyICmTODPAhnXNF+/Ltcg0uUFMzElTaYb6GI1C6MLOsi9ZC5bEyx+RThNXVn5uXQGCQMad/KlXe3TSREl/y8WEjAyLuFpdqfeWALtKmcPxaOoJzYGReJRi7SSn/Cb802z51yiMWfZXNdC5zz9UkrttaR14lxLX4L7MNNCl/cw0jTllqCsD9C/c7Whip08+UYdEDm7i3tz+FTHGOzT4mnGaapAkMpFh4bVqTB++QScXdszPzWIK/OMcIqG34xg=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2019 20:51:29.2273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1812a6c2-1aee-4bd0-0d6f-08d69cf5591f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4526
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename file name of ZynqMP clk dt-bindings to align with
file name of reset and power dt-bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |   2 +-
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 -------------------
 include/dt-bindings/clock/xlnx-zynqmp-clk.h        | 126 +++++++++++++++++++++
 3 files changed, 127 insertions(+), 117 deletions(-)
 delete mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h
 create mode 100644 include/dt-bindings/clock/xlnx-zynqmp-clk.h

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index 614bac5..45d259c 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -62,7 +62,7 @@ order to provide an optional (E)MIO clock source:
 
 Output clocks are registered based on clock information received
 from firmware. Output clocks indexes are mentioned in
-include/dt-bindings/clock/xlnx,zynqmp-clk.h.
+include/dt-bindings/clock/xlnx-zynqmp-clk.h.
 
 -------
 Example
diff --git a/include/dt-bindings/clock/xlnx,zynqmp-clk.h b/include/dt-bindings/clock/xlnx,zynqmp-clk.h
deleted file mode 100644
index 4aebe6e..0000000
--- a/include/dt-bindings/clock/xlnx,zynqmp-clk.h
+++ /dev/null
@@ -1,116 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Xilinx Zynq MPSoC Firmware layer
- *
- *  Copyright (C) 2014-2018 Xilinx, Inc.
- *
- */
-
-#ifndef _DT_BINDINGS_CLK_ZYNQMP_H
-#define _DT_BINDINGS_CLK_ZYNQMP_H
-
-#define IOPLL			0
-#define RPLL			1
-#define APLL			2
-#define DPLL			3
-#define VPLL			4
-#define IOPLL_TO_FPD		5
-#define RPLL_TO_FPD		6
-#define APLL_TO_LPD		7
-#define DPLL_TO_LPD		8
-#define VPLL_TO_LPD		9
-#define ACPU			10
-#define ACPU_HALF		11
-#define DBF_FPD			12
-#define DBF_LPD			13
-#define DBG_TRACE		14
-#define DBG_TSTMP		15
-#define DP_VIDEO_REF		16
-#define DP_AUDIO_REF		17
-#define DP_STC_REF		18
-#define GDMA_REF		19
-#define DPDMA_REF		20
-#define DDR_REF			21
-#define SATA_REF		22
-#define PCIE_REF		23
-#define GPU_REF			24
-#define GPU_PP0_REF		25
-#define GPU_PP1_REF		26
-#define TOPSW_MAIN		27
-#define TOPSW_LSBUS		28
-#define GTGREF0_REF		29
-#define LPD_SWITCH		30
-#define LPD_LSBUS		31
-#define USB0_BUS_REF		32
-#define USB1_BUS_REF		33
-#define USB3_DUAL_REF		34
-#define USB0			35
-#define USB1			36
-#define CPU_R5			37
-#define CPU_R5_CORE		38
-#define CSU_SPB			39
-#define CSU_PLL			40
-#define PCAP			41
-#define IOU_SWITCH		42
-#define GEM_TSU_REF		43
-#define GEM_TSU			44
-#define GEM0_REF		45
-#define GEM1_REF		46
-#define GEM2_REF		47
-#define GEM3_REF		48
-#define GEM0_TX			49
-#define GEM1_TX			50
-#define GEM2_TX			51
-#define GEM3_TX			52
-#define QSPI_REF		53
-#define SDIO0_REF		54
-#define SDIO1_REF		55
-#define UART0_REF		56
-#define UART1_REF		57
-#define SPI0_REF		58
-#define SPI1_REF		59
-#define NAND_REF		60
-#define I2C0_REF		61
-#define I2C1_REF		62
-#define CAN0_REF		63
-#define CAN1_REF		64
-#define CAN0			65
-#define CAN1			66
-#define DLL_REF			67
-#define ADMA_REF		68
-#define TIMESTAMP_REF		69
-#define AMS_REF			70
-#define PL0_REF			71
-#define PL1_REF			72
-#define PL2_REF			73
-#define PL3_REF			74
-#define WDT			75
-#define IOPLL_INT		76
-#define IOPLL_PRE_SRC		77
-#define IOPLL_HALF		78
-#define IOPLL_INT_MUX		79
-#define IOPLL_POST_SRC		80
-#define RPLL_INT		81
-#define RPLL_PRE_SRC		82
-#define RPLL_HALF		83
-#define RPLL_INT_MUX		84
-#define RPLL_POST_SRC		85
-#define APLL_INT		86
-#define APLL_PRE_SRC		87
-#define APLL_HALF		88
-#define APLL_INT_MUX		89
-#define APLL_POST_SRC		90
-#define DPLL_INT		91
-#define DPLL_PRE_SRC		92
-#define DPLL_HALF		93
-#define DPLL_INT_MUX		94
-#define DPLL_POST_SRC		95
-#define VPLL_INT		96
-#define VPLL_PRE_SRC		97
-#define VPLL_HALF		98
-#define VPLL_INT_MUX		99
-#define VPLL_POST_SRC		100
-#define CAN0_MIO		101
-#define CAN1_MIO		102
-
-#endif
diff --git a/include/dt-bindings/clock/xlnx-zynqmp-clk.h b/include/dt-bindings/clock/xlnx-zynqmp-clk.h
new file mode 100644
index 0000000..cdc4c0b
--- /dev/null
+++ b/include/dt-bindings/clock/xlnx-zynqmp-clk.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ */
+
+#ifndef _DT_BINDINGS_CLK_ZYNQMP_H
+#define _DT_BINDINGS_CLK_ZYNQMP_H
+
+#define IOPLL			0
+#define RPLL			1
+#define APLL			2
+#define DPLL			3
+#define VPLL			4
+#define IOPLL_TO_FPD		5
+#define RPLL_TO_FPD		6
+#define APLL_TO_LPD		7
+#define DPLL_TO_LPD		8
+#define VPLL_TO_LPD		9
+#define ACPU			10
+#define ACPU_HALF		11
+#define DBF_FPD			12
+#define DBF_LPD			13
+#define DBG_TRACE		14
+#define DBG_TSTMP		15
+#define DP_VIDEO_REF		16
+#define DP_AUDIO_REF		17
+#define DP_STC_REF		18
+#define GDMA_REF		19
+#define DPDMA_REF		20
+#define DDR_REF			21
+#define SATA_REF		22
+#define PCIE_REF		23
+#define GPU_REF			24
+#define GPU_PP0_REF		25
+#define GPU_PP1_REF		26
+#define TOPSW_MAIN		27
+#define TOPSW_LSBUS		28
+#define GTGREF0_REF		29
+#define LPD_SWITCH		30
+#define LPD_LSBUS		31
+#define USB0_BUS_REF		32
+#define USB1_BUS_REF		33
+#define USB3_DUAL_REF		34
+#define USB0			35
+#define USB1			36
+#define CPU_R5			37
+#define CPU_R5_CORE		38
+#define CSU_SPB			39
+#define CSU_PLL			40
+#define PCAP			41
+#define IOU_SWITCH		42
+#define GEM_TSU_REF		43
+#define GEM_TSU			44
+#define GEM0_TX			45
+#define GEM1_TX			46
+#define GEM2_TX			47
+#define GEM3_TX			48
+#define GEM0_RX			49
+#define GEM1_RX			50
+#define GEM2_RX			51
+#define GEM3_RX			52
+#define QSPI_REF		53
+#define SDIO0_REF		54
+#define SDIO1_REF		55
+#define UART0_REF		56
+#define UART1_REF		57
+#define SPI0_REF		58
+#define SPI1_REF		59
+#define NAND_REF		60
+#define I2C0_REF		61
+#define I2C1_REF		62
+#define CAN0_REF		63
+#define CAN1_REF		64
+#define CAN0			65
+#define CAN1			66
+#define DLL_REF			67
+#define ADMA_REF		68
+#define TIMESTAMP_REF		69
+#define AMS_REF			70
+#define PL0_REF			71
+#define PL1_REF			72
+#define PL2_REF			73
+#define PL3_REF			74
+#define WDT			75
+#define IOPLL_INT		76
+#define IOPLL_PRE_SRC		77
+#define IOPLL_HALF		78
+#define IOPLL_INT_MUX		79
+#define IOPLL_POST_SRC		80
+#define RPLL_INT		81
+#define RPLL_PRE_SRC		82
+#define RPLL_HALF		83
+#define RPLL_INT_MUX		84
+#define RPLL_POST_SRC		85
+#define APLL_INT		86
+#define APLL_PRE_SRC		87
+#define APLL_HALF		88
+#define APLL_INT_MUX		89
+#define APLL_POST_SRC		90
+#define DPLL_INT		91
+#define DPLL_PRE_SRC		92
+#define DPLL_HALF		93
+#define DPLL_INT_MUX		94
+#define DPLL_POST_SRC		95
+#define VPLL_INT		96
+#define VPLL_PRE_SRC		97
+#define VPLL_HALF		98
+#define VPLL_INT_MUX		99
+#define VPLL_POST_SRC		100
+#define CAN0_MIO		101
+#define CAN1_MIO		102
+#define ACPU_FULL		103
+#define GEM0_REF		104
+#define GEM1_REF		105
+#define GEM2_REF		106
+#define GEM3_REF		107
+#define GEM0_REF_UNG		108
+#define GEM1_REF_UNG		109
+#define GEM2_REF_UNG		110
+#define GEM3_REF_UNG		111
+#define LPD_WDT			112
+
+#endif
-- 
2.7.4

