Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeCWTLa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:11:30 -0400
Received: from mail-bl2nam02on0066.outbound.protection.outlook.com ([104.47.38.66]:40852
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751843AbeCWTL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:11:26 -0400
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
From: <chinnikishore369@gmail.com>
To: <p.zabel@pengutronix.de>, <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Nava kishore Manne <navam@xilinx.com>
Subject: [RFC 2/2] reset: reset-zynqmp: Adding support for Xilinx zynqmp reset controller.
Date: Sun, 25 Mar 2018 00:41:00 +0530
Message-ID: <20180324191100.18363-2-chinnikishore369@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180324191100.18363-1-chinnikishore369@gmail.com>
References: <20180324191100.18363-1-chinnikishore369@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--5.568-7.0-31-1
X-imss-scan-details: No--5.568-7.0-31-1;No--5.568-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131663058842457574;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(376002)(346002)(2980300002)(199004)(189003)(316002)(305945005)(336012)(16586007)(82202002)(498600001)(110136005)(5660300001)(86362001)(356003)(2616005)(36756003)(26005)(47776003)(77096007)(2201001)(446003)(426003)(61266001)(73392003)(55446002)(83322999)(86152003)(9786002)(105596002)(106466001)(50226002)(87792001)(50466002)(87572001)(76176011)(51416003)(6666003)(8676002)(8936002)(76482006)(48376002)(81156014)(2906002)(73972006)(63266004)(1076002)(4326008)(2876002)(11346002)(107886003)(81166006)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2530;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;PTR:unknown-60-83.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT062;1:sXkc/jZNwrbv0bAptYWCfX9SZ8vWY/aSbbuntTzbhYm18KvJsRnee6RvvnpfCVG9Dd6mFJ5x+C2hg663w8PUKf53HOwPPDUePCzTgB2vkgCk/Ai5Oj7CLCWBneepsyVO
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 703c75c8-c82e-43d3-3390-08d590f1decd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BN6PR02MB2530;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2530;3:+COYpMmD6KVoA7Z5ih5gwgeoWXOCXsw3xoOy4Auv3CY1XRswYPciFDnEwUUeU26Kj5JmigM+70j3eR2OEsxwwFonFPTM7q6aULivTSYGGAbd4XNOlKI1EIcHBDTTok9+25/hJBt2w+B7YNBczsLEl0vOs4GJVJFZI8oF3+4W0rhC37FiEvrHPHBpAd9kTyGrvdqz4bpLsudS6f0oLD3yZvEF/xaB7tkSX9/DCOIQABijuv/GlC6s0H5eFGVxhRk/dKyrtVAFT0OFBLlqM8+q3seB9CvW5Da93S8Y+9x3KFWmbQIVHcvA2c95uWKQcCh2hlz8GZ+d3751TOq+NBgc8P72lwWvd4QptB3bAYZgd7M=;25:aMOcuKsmGisD4z/2LMwlJIuAu0KiZE06V57OfyNlqIGtTqnnasX1TT0qgyUWySXJwcVNBwypZRS/0VTPypCi7YxMq4MdE6+8W/mZeBG9XL4X5ejJQM6hjz6EGMLK48wlc8CS2q2uAaUlYoABsP96yfTOoUs4HaxUqX2izLBry8/wAHwAHMFUjE3QB/IH30bj2jHZr/5hJcnZeLkCRzYyGrn+auGdxeYch8tzTrXLDHD1AQHCt0s8T2ATZLU7IYWg6QLdQhKat3Z03u9LG2bKOUe0Er/xM9cvFSiI749sl/eh3kMUVDHY1m3yfXnhT65IJpLU1Xx4f7ILhiBxzsyQBg==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2530:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2530;31:YglpYvohdnYYKvMMh6HuPGCvQRPXwo4SNRbkMvwz8YRxH7hmprPaLzfDC3BAQH7QNgHO/er5qv2fjwjtpIvaEn0Qz5IQN4Mvex2OnbnBO8L7r+GXmRjat9eM8HbDIwRW3fruLI89Q7wKW4/n6McC+Go96vHdePtieP59372sffAmCcEhIs/SI/ncr8YHPPrO5aOlzmapFV98WwMwUjLED3atATLcKuk/BdeS1oDHDy4=;4:34CnWyhiRwHdlTPhZQxZGD03e6xJc38x+Rqt51SOrIhll6k3NGc6TVvvLpMa8KTaGNNeFmgbRpLlUd3QN9bSHX1rulgVDuzAhyog/ReckkNsDLCUKuPz/h48o+ohQ4ld3ViiTK/J0aT24odKTIknM1mmLD3nkhm7V6baRFcZmxnPZGnHURnABcyUnuhO2kkDq1ZYxnmzc/6i0p2qbk+jOY5n/7QU50HJuHFQUQFww2BH87HcbD7m7+UKygBzRlvyS3GXstRmqjG7PINpCHjtSZSJN4WB5lSd9x1rzBn7EJagtHvjQo1F5qubWjE/IYPh
X-Microsoft-Antispam-PRVS: <BN6PR02MB25300209E32034FD455B817D8DA80@BN6PR02MB2530.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6096035)(20161123565025)(20161123556025)(20161123563025)(20161123559100)(20161123561025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011);SRVR:BN6PR02MB2530;BCL:0;PCL:0;RULEID:(400006);SRVR:BN6PR02MB2530;
X-Forefront-PRVS: 0620CADDF3
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2530;23:bOVp5qhFVPscgFqOEGn5QW0DxTeVBAmzm37J0hRLW?=
 =?us-ascii?Q?dpft/apXgY/BIbHnJ/XB+BBaL2lpWOdHxrj1ZnKTh5NMNq1VZ2OJLyaOPjDu?=
 =?us-ascii?Q?NpX39UcH2g9CrWZb4c5ltr35s2WNiX932UdkqKZX8lMFZfiUQuV1Hz0r7Ahu?=
 =?us-ascii?Q?G/pVKUOfgN62HtPdtPAG/+kJhU4/JLdBrRdAY8QTC3YHAQI9Vc9Y6kyLoJlq?=
 =?us-ascii?Q?+bNvaoSKkbds6vvFZa8GGHCcAdPLeAn8z8BfV+QIiZ8PLQrGA6NxqWs3fwtL?=
 =?us-ascii?Q?saiDwbI/pLT2DyO2cbOps3ZaRJyFirgtXSkW2y6B95mIl7Ur165v5Bolha/l?=
 =?us-ascii?Q?n9rH6r5WtA3i4fMSI3/bhr58aekAdLz7mA3MhPrctEOQGyMnw5L55YIkwNOf?=
 =?us-ascii?Q?oZmQQYBL7oao6woVetZsLKbXL8Ch79CTvHCJpehMdKw9PM+F+gCoSSS6WE2x?=
 =?us-ascii?Q?wO8G/l7AsVGub8Rg/G31rXXrMMtDMbeaDMGuB0NjlAiTEQyKJS08PNnsp8EL?=
 =?us-ascii?Q?r8yjgSMHBU/EQ7VvvpFNyNOgl/LiGLzsYWmf/VJrW8GqA1yOf7ZkBaFZ5gl7?=
 =?us-ascii?Q?IilW+ON9AQFbrnoZw1QYvgz/Ldq5BQIx/pKCkWMZrxCSQB7mkhPNvV8FB4jm?=
 =?us-ascii?Q?olS0RITiOC4aTUvFElZMzrY9u92WwV+w2Hvl/gk5ycaQQDcb63Jm3IrCYisJ?=
 =?us-ascii?Q?L2A8VVmXKw4sfdrRV7nJ9TOoIDPk4DJNM52xmh6hbvINo7iGn4LgOQhaAEea?=
 =?us-ascii?Q?d9g8n0f8bH8RX7d4RnzkGohLBBs8auLzrDpkUgB3jR3m4ntsF4l1bQDYA9Go?=
 =?us-ascii?Q?uoulnG02J4munz5rfmSM6ikegrroYd/vwWNHNuMBNcV3yLPmukU1/F+3S8x3?=
 =?us-ascii?Q?C6ceSZkH1LUT7Mj5TdZrSN36FVhG2bpmekw16wmYULeBmAiilFF0qL/cBaou?=
 =?us-ascii?Q?0BPTN/03YncfMr/2Gi2wG4FH+oz2skcKMANiSVIMMLfi9N1zGao8u2BK7kyB?=
 =?us-ascii?Q?C7pVja8uyUIdwZILZ9I8+ML+PmH0E3G4O/eYMDI27H0GFXa/e+9I+6T0o7g2?=
 =?us-ascii?Q?JRHUt0h78kQiKsfXK+r65c0SAfByHvty7Rmd0YlFMDslu9pXpzBBtkKVcS5L?=
 =?us-ascii?Q?fZy8jCnqGR2pbLlHyqlwIAFmwTZxw0+/HYbaOknHut+I7TW7n3jiXeAAV1Ek?=
 =?us-ascii?Q?kDiosb0YYs97G/lnI70kFqyMT7IcnUd7mf4lo362c2sfpxsVmdT11tUoV+dY?=
 =?us-ascii?Q?Oy5b9+2oBZpGdrDcU5W8hB0CI+zJbXasqRsLMN2LRDHO/KdhJqpOMy2Ldhat?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: TsMmTMtuy1hibz90uXk13WD+b/oykoaR6cN9p96jVUI8E43lJx8+qxmzRQq4CE5x9sY4I2/XZfNOD1EhQRRM0M69PiLq7QIliWVJ6vgdvqKs5VEw9v7h45bEWhHhhfk5MaiY28A6ADHM1MnSy70Ov0NywyEzI3pf933QOH1ICOpJvdg4Mac7R8mWSXh9El1t
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2530;6:7FdWkg4FQa9IxwHs68yBeuiVgjy1n4UsXCL/Lh1uACg2KqMFIHqwgtlPiwvVPyOrCmIzIYmKAd+mG2/6q/TrFz/TiuUHcpxpMCb+il9SM6Ta5Ivm8PPJ54Z+VDG/lPqt/QB3FQcjnuAK32m6TrYCBW4TVr6x5plAdF9nrW7evLhw0LdJiyrruu1aAVjnD79236y+VRo4onTtLycL1vsKVdOwabKZ0zyt65k33UCJyLvHrYzh6mcQ538b+FL/gm7NALqVoEMQWz9S/8uroF7VByZINjWax65aFcn8joYpzi88nNj6s/KZ/rDPWFe2YnVpSvA7LzFrZ3tpqVcVVHjkK4WkhDf1EUZ3jopg+P2KCWckoEK55n+nGOZ5boS0zyS6ed9I9Ydjgb3zvekVPML6A/L0DfGtdXu+ieWLxBGutlmTvWm2NMbLgkoZNLjeq3dIzeMy19p+grLgAc+UWd/JzQ==;5:YLYEQUNC0LroF7u5pSJk5xYtR2n6VHwyGQtXhb2vR1G0fynkssxn10zg6fG7cQVNeq4vcV+71rKKgbmRd7Cq7zSeKq8md1BbH+rUqv83zN+ER0NzQ7Er059V2Urn48ChGXGb9sl8d7TjV/t5qi5WOs+pY2apb3Hw1A8LXD0DEoc=;24:bwpI/NCicRsiBKJNZoa8ATxms8fSi7ivm4n3fzGv2A5B/KtnR/wyLIYtjYRbLnhMPq21DuEjzngiD9SS40SM0067I+i1piBdlQWSjjHyvqM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2530;7:St9tm/YQYoOua8oAnbVzi8QXxc/FGU/qH1tFHUPojNcZBDU+cXvKJQJYo8A+LrzYQ7JkmjXppkMlYzA3FuNGJYSIdYDyN6r0HiXLsyydOAJ0kXllIF514bt5zuuadlp5Qe09tVU/0NV9ioMgbmo94YmPuepQK1w5hOzyMWxBlRRBpLJlsJKfbKbFI9oAD34ea66pBVnTJJhNvHZZ0j6jjZydnSY8lF709ywhYH8EFg2Kt6ljkse1QFRqx1tL2vaj
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 19:11:23.6676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 703c75c8-c82e-43d3-3390-08d590f1decd
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2530
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nava kishore Manne <navam@xilinx.com>

Add a reset controller driver for Xilinx Zynq UltraScale+ MPSoC.
The zynqmp reset-controller has the ability to reset lines
connected to different blocks and peripheral in the Soc.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
---
 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-zynqmp.c | 106 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 drivers/reset/reset-zynqmp.c

diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 132c24f5ddb5..4e1a94acf83f 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -20,4 +20,5 @@ obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
 obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
+obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
 
diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
new file mode 100644
index 000000000000..c8510fa93ad9
--- /dev/null
+++ b/drivers/reset/reset-zynqmp.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Xilinx, Inc.
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/firmware/xilinx/zynqmp/firmware.h>
+
+#define ZYNQMP_NR_RESETS (ZYNQMP_PM_RESET_END - ZYNQMP_PM_RESET_START - 2)
+#define ZYNQMP_RESET_ID (ZYNQMP_PM_RESET_START + 1)
+
+static const struct zynqmp_eemi_ops *eemi_ops;
+
+struct zynqmp_reset {
+	struct reset_controller_dev rcdev;
+};
+
+static int zynqmp_reset_assert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	return eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
+						PM_RESET_ACTION_ASSERT);
+}
+
+static int zynqmp_reset_deassert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	return eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
+						PM_RESET_ACTION_RELEASE);
+}
+
+static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	int val;
+
+	eemi_ops->reset_get_status(ZYNQMP_RESET_ID + id, &val);
+	return val;
+}
+
+static int zynqmp_reset_reset(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	return eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
+						PM_RESET_ACTION_PULSE);
+}
+
+static struct reset_control_ops zynqmp_reset_ops = {
+	.reset = zynqmp_reset_reset,
+	.assert = zynqmp_reset_assert,
+	.deassert = zynqmp_reset_deassert,
+	.status = zynqmp_reset_status,
+};
+
+static int zynqmp_reset_probe(struct platform_device *pdev)
+{
+	struct zynqmp_reset *zynqmp_reset;
+	int ret;
+
+	zynqmp_reset = devm_kzalloc(&pdev->dev,
+				sizeof(*zynqmp_reset), GFP_KERNEL);
+	if (!zynqmp_reset)
+		return -ENOMEM;
+
+	eemi_ops = zynqmp_pm_get_eemi_ops();
+	if (!eemi_ops)
+		return -ENXIO;
+
+	platform_set_drvdata(pdev, zynqmp_reset);
+
+	zynqmp_reset->rcdev.ops = &zynqmp_reset_ops;
+	zynqmp_reset->rcdev.owner = THIS_MODULE;
+	zynqmp_reset->rcdev.of_node = pdev->dev.of_node;
+	zynqmp_reset->rcdev.of_reset_n_cells = 1;
+	zynqmp_reset->rcdev.nr_resets = ZYNQMP_NR_RESETS;
+
+	ret = reset_controller_register(&zynqmp_reset->rcdev);
+	if (!ret)
+		dev_info(&pdev->dev, "Xilinx zynqmp reset driver probed\n");
+
+	return ret;
+}
+
+static const struct of_device_id zynqmp_reset_dt_ids[] = {
+	{ .compatible = "xlnx,zynqmp-reset", },
+	{ },
+};
+
+static struct platform_driver zynqmp_reset_driver = {
+	.probe	= zynqmp_reset_probe,
+	.driver = {
+		.name		= KBUILD_MODNAME,
+		.of_match_table	= zynqmp_reset_dt_ids,
+	},
+};
+
+static int __init zynqmp_reset_init(void)
+{
+	return platform_driver_register(&zynqmp_reset_driver);
+}
+
+arch_initcall(zynqmp_reset_init);
-- 
2.16.1
