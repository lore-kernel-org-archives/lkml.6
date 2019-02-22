Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2706BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36DF2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="vYVDSAHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfBVAhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:37:20 -0500
Received: from mail-eopbgr680065.outbound.protection.outlook.com ([40.107.68.65]:51648
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726637AbfBVAhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEjVBZn/Rd5Rfm7bFRmaze3D+Uu9D38egH5k9yZKYW4=;
 b=vYVDSAHW/uM9ikiBbRLQej0HJLr9Gk/nvdcRSDjSURtzMQ6uOhi9YU3sLyHOYEOoLtLpKMIHfp+aPcaCWEOKgYiGjYPWoUa5ivWA7KNpa8uCwXwrB4BGo/KWHpYjsMA9bpC6n2DFjhpbFbMSWwJtkxVMC/iISN5ClJruR4A6R4A=
Received: from MWHPR0201CA0047.namprd02.prod.outlook.com
 (2603:10b6:301:73::24) by BL0PR02MB4627.namprd02.prod.outlook.com
 (2603:10b6:208:4d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.16; Fri, 22 Feb
 2019 00:37:12 +0000
Received: from BL2NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by MWHPR0201CA0047.outlook.office365.com
 (2603:10b6:301:73::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.15 via Frontend
 Transport; Fri, 22 Feb 2019 00:37:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT057.mail.protection.outlook.com (10.152.77.36) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Fri, 22 Feb 2019 00:37:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:57005 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1gwypy-0003dH-JQ; Thu, 21 Feb 2019 16:37:10 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1gwypt-0007dx-FI; Thu, 21 Feb 2019 16:37:05 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1M0aswP004113;
        Thu, 21 Feb 2019 16:36:54 -0800
Received: from [172.19.2.167] (helo=xsjjliang50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1gwypi-0007cY-64; Thu, 21 Feb 2019 16:36:54 -0800
From:   Wendy Liang <wendy.liang@xilinx.com>
To:     <jassisinghbrar@gmail.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Wendy Liang <wendy.liang@xilinx.com>
Subject: [PATCH v8 1/2] mailbox: ZynqMP IPI mailbox controller
Date:   Thu, 21 Feb 2019 16:36:33 -0800
Message-ID: <1550795794-27594-2-git-send-email-wendy.liang@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550795794-27594-1-git-send-email-wendy.liang@xilinx.com>
References: <1550795794-27594-1-git-send-email-wendy.liang@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(2980300002)(199004)(189003)(51416003)(7696005)(36386004)(15650500001)(76176011)(14444005)(30864003)(186003)(6666004)(9786002)(356004)(5660300002)(305945005)(8676002)(81166006)(81156014)(8936002)(50226002)(36756003)(106002)(16586007)(54906003)(106466001)(110136005)(63266004)(316002)(48376002)(47776003)(77096007)(26005)(486006)(2906002)(107886003)(476003)(336012)(446003)(11346002)(478600001)(2616005)(50466002)(426003)(126002)(44832011)(4326008)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4627;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c9c4b28-0279-4b9e-9b95-08d6985de252
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4608103)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BL0PR02MB4627;
X-MS-TrafficTypeDiagnostic: BL0PR02MB4627:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4627;20:r4su5OST9+TDOzTn6TZU8kSCaAasOiS+u0Hish+O+Nvbdc3jldIUZpJHNUQtDfXoyI30T3Hg8YBzH4s75vsOcD3//NNMaKnuyrNaKtF/YYQG+kqYDX40fMfNMBIT8pxfpLNCJfj4rO1UGZCafkHpvOIouE3TzgZOvw1ESchvqbxv95b0cdPvysLKl47Wgh/PmrDFetjRHGx3q7Wo3qIh1IUxl5TqITQOYBcZ7rmabX1Jmq9k5tXp6WiqBAbs+VYAa4vvhGcWVD8FpLJRJXt3B08U5LUhh7QCIL/p2wPmyYZkEFfRBulv1bDcKWOrdHt2Kfnupfjywmksp9uCDv8GXaAarq1Ckl+HOkB1YebJmqYRPe8q4JEBQQlW89r7Vz1+E7TWNAiBknxph4Ykkc/89cNIG6YsIHMo6DL6gkb1Eyz9WHcAZZpUmFSD79weRH3DHeL4Ev9tCVXkB+/uHRqvm9/7Wg4xLdcSBMEdHlguCv3Q/0z/5fvl8Yzmu+VAcALE
X-Microsoft-Antispam-PRVS: <BL0PR02MB4627F68A39EB241A62257F43B07F0@BL0PR02MB4627.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09565527D6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4627;23:stz6IE6gE/fmbmaQhiWcKgBCd8HjDlhfQGNs9SF+H?=
 =?us-ascii?Q?cVlI81kYS/qvzHZNFUDVa3vpreUGC8OE8Zf4FlPaTBiUxw+I8IWPDADTO5Nw?=
 =?us-ascii?Q?DBbMWr7CYi2KxSeaZHhhcQReakCq6DwIfz1ZVIeH0oKPhJ7juVns3rvDT1su?=
 =?us-ascii?Q?JnYlSLj3Y61QPc++MtwPfGcg5blDaKBYSO6fHQfeNM7SR5Jv9Ok++0KYpC1E?=
 =?us-ascii?Q?apHgMNBxm85Kpa52jjeql9P6Vmg1CyNAhG2vf44YpmZlcYxctNHFEz6vT/PD?=
 =?us-ascii?Q?iaepfyQyGM9ZAuZmECbjpbVtQTU8Drl4/RUOfPshS1FZNX6wegQiD4ZPUj5d?=
 =?us-ascii?Q?ZWKP5Sy44OvJq3dugIPuOQrRfwFglhuchTLk+Q+Rg0APp5rj1VcpEZjHyB4P?=
 =?us-ascii?Q?dYTM5ICBhBdv7RlKiTfl9iBOJXnw0x33hseAJumtQZ2h+xk8yv24C33fTc7T?=
 =?us-ascii?Q?J5K0Zs0W1NwDzARrjdCaf0HOmcYXuQwuNt98Qlf5+X/J7z9FIHbCkC/kx18J?=
 =?us-ascii?Q?SIwTEsqEfbArWzBELs8skkbtbnd9Hbuk2Ijrljue/hdD5cR477Rw1d7oweju?=
 =?us-ascii?Q?ME1XaTScnemXd4nxYjHtwTOpk5eIdEBqetT+3qCLj73NrtSu3CTKYbo6JWmo?=
 =?us-ascii?Q?XnpzsKl3JOragyzGqxEjyJ3TNVt7FheLQy0/sBFFAjtslojh6mnmtu3R4lk7?=
 =?us-ascii?Q?iUpXeeJa1Ao7ZxuZRfg1UUuxznOLRAcVcfE2SyjAPrkxR3oHiMf5/TlHB/d1?=
 =?us-ascii?Q?qBK99FwnFD5kqdBd6tkuBY2P63qO5dMSzNBGBCozla1Bzz+K3IVurhi8WaaF?=
 =?us-ascii?Q?Oy2F0tsLzrBUFY0Lw+9sB8cp/Q1pRPhWbW1UFPteKaXcmdY7FqhKk1BfyAvX?=
 =?us-ascii?Q?aRU3Jhi4xerAkw6tn1R9D8kbbLMEmCc1WZP7zvwh95jLofvzpywJIUpFYpgq?=
 =?us-ascii?Q?j2N79Pv4C9d0U+Espk8Fp2gc2s123pX1UnaGYS4RkujZz/fdFbKJT9H6/nzC?=
 =?us-ascii?Q?NUrLvI7cHRMPG8wGgvo9Qn2xgjDCgyUMcS14DSYD2B2Lne9VBMFllVaBK3e8?=
 =?us-ascii?Q?xjvmaziI0LU9JMhDUbyLbEctXBFzCB3vTpVrOyywxj3gf3s3rY1zyQswjvkL?=
 =?us-ascii?Q?dxd//D4W3ljVQgmmmZ8PYzCMOaBP2Gfmr9lf2U7/0Q2rMQgCVyk5sj5qNXeU?=
 =?us-ascii?Q?yEO+JWNXvkPIBIjvKECIz4smmZPVWXwJVDe?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ouaRadaKw8RxEk67y+7cIAUjeGGLmuRS7aDjFMc6PTCK4L1szGLtW38ASfwyXJbvMn1u06CcTMTSXER1lPuwkUw8gMAyeUIibzTXwf1PdxpbR4CGOokf+s3vCyebxUn9Ltwm2k8Gy7I5Q2avQu2GI2TfqmguqoGWCOpmr9NajX7Q0u0u2Esb5Knaye4wHCfB1Fstrs4jbM2qZ4PAqnmFthawJTU5A/65Lgk7fvhiN5GPePeyxwLFMkpDHdPvUljsumBbTMAu7V8AlDGFGROIHQIWeqYw8oegUkpSRIV1zN+hsRYanPad9qC1KQPcsEDpCVYBJQe1g7xgQM50u3F/c2grLLsD5Q0shxMxpAOD4Y0tSoxaaYWYULeQB0krymPhd+MPRu0wrNHsQGDGkkiK7p4aR7bKKYyjJ8CS+oElAzo=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2019 00:37:11.2185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9c4b28-0279-4b9e-9b95-08d6985de252
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4627
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to introduce ZynqMP IPI mailbox controller driver
to use the ZynqMP IPI block as mailboxes.

Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
---
 drivers/mailbox/Kconfig                    |  11 +
 drivers/mailbox/Makefile                   |   2 +
 drivers/mailbox/zynqmp-ipi-mailbox.c       | 725 +++++++++++++++++++++++++++++
 include/linux/mailbox/zynqmp-ipi-message.h |  20 +
 4 files changed, 758 insertions(+)
 create mode 100644 drivers/mailbox/zynqmp-ipi-mailbox.c
 create mode 100644 include/linux/mailbox/zynqmp-ipi-message.h

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 3eeb12e9..d86e7a4 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -205,4 +205,15 @@ config MTK_CMDQ_MBOX
 	  mailbox driver. The CMDQ is used to help read/write registers with
 	  critical time limitation, such as updating display configuration
 	  during the vblank.
+
+config ZYNQMP_IPI_MBOX
+	bool "Xilinx ZynqMP IPI Mailbox"
+	depends on ARCH_ZYNQMP && OF
+	help
+	  Say yes here to add support for Xilinx IPI mailbox driver.
+	  This mailbox driver is used to send notification or short message
+	  between processors with Xilinx ZynqMP IPI. It will place the
+	  message to the IPI buffer and will access the IPI control
+	  registers to kick the other processor or enquire status.
+
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index c818b5d..8be3bcb 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -44,3 +44,5 @@ obj-$(CONFIG_TEGRA_HSP_MBOX)	+= tegra-hsp.o
 obj-$(CONFIG_STM32_IPCC) 	+= stm32-ipcc.o
 
 obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
+
+obj-$(CONFIG_ZYNQMP_IPI_MBOX)	+= zynqmp-ipi-mailbox.o
diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
new file mode 100644
index 0000000..86887c9
--- /dev/null
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -0,0 +1,725 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Inter Processor Interrupt(IPI) Mailbox Driver
+ *
+ * Copyright (C) 2018 Xilinx, Inc.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox/zynqmp-ipi-message.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+
+/* IPI agent ID any */
+#define IPI_ID_ANY 0xFFUL
+
+/* indicate if ZynqMP IPI mailbox driver uses SMC calls or HVC calls */
+#define USE_SMC 0
+#define USE_HVC 1
+
+/* Default IPI SMC function IDs */
+#define SMC_IPI_MAILBOX_OPEN		0x82001000U
+#define SMC_IPI_MAILBOX_RELEASE		0x82001001U
+#define SMC_IPI_MAILBOX_STATUS_ENQUIRY	0x82001002U
+#define SMC_IPI_MAILBOX_NOTIFY		0x82001003U
+#define SMC_IPI_MAILBOX_ACK		0x82001004U
+#define SMC_IPI_MAILBOX_ENABLE_IRQ	0x82001005U
+#define SMC_IPI_MAILBOX_DISABLE_IRQ	0x82001006U
+
+/* IPI SMC Macros */
+#define IPI_SMC_ENQUIRY_DIRQ_MASK	0x00000001UL /* Flag to indicate if
+						      * notification interrupt
+						      * to be disabled.
+						      */
+#define IPI_SMC_ACK_EIRQ_MASK		0x00000001UL /* Flag to indicate if
+						      * notification interrupt
+						      * to be enabled.
+						      */
+
+/* IPI mailbox status */
+#define IPI_MB_STATUS_IDLE		0
+#define IPI_MB_STATUS_SEND_PENDING	1
+#define IPI_MB_STATUS_RECV_PENDING	2
+
+#define IPI_MB_CHNL_TX	0 /* IPI mailbox TX channel */
+#define IPI_MB_CHNL_RX	1 /* IPI mailbox RX channel */
+
+/**
+ * struct zynqmp_ipi_mchan - Description of a Xilinx ZynqMP IPI mailbox channel
+ * @is_opened: indicate if the IPI channel is opened
+ * @req_buf: local to remote request buffer start address
+ * @resp_buf: local to remote response buffer start address
+ * @req_buf_size: request buffer size
+ * @resp_buf_size: response buffer size
+ * @rx_buf: receive buffer to pass received message to client
+ * @chan_type: channel type
+ */
+struct zynqmp_ipi_mchan {
+	int is_opened;
+	void __iomem *req_buf;
+	void __iomem *resp_buf;
+	void *rx_buf;
+	size_t req_buf_size;
+	size_t resp_buf_size;
+	unsigned int chan_type;
+};
+
+/**
+ * struct zynqmp_ipi_mbox - Description of a ZynqMP IPI mailbox
+ *                          platform data.
+ * @pdata:		  pointer to the IPI private data
+ * @dev:                  device pointer corresponding to the Xilinx ZynqMP
+ *                        IPI mailbox
+ * @remote_id:            remote IPI agent ID
+ * @mbox:                 mailbox Controller
+ * @mchans:               array for channels, tx channel and rx channel.
+ * @irq:                  IPI agent interrupt ID
+ */
+struct zynqmp_ipi_mbox {
+	struct zynqmp_ipi_pdata *pdata;
+	struct device dev;
+	u32 remote_id;
+	struct mbox_controller mbox;
+	struct zynqmp_ipi_mchan mchans[2];
+};
+
+/**
+ * struct zynqmp_ipi_pdata - Description of z ZynqMP IPI agent platform data.
+ *
+ * @dev:                  device pointer corresponding to the Xilinx ZynqMP
+ *                        IPI agent
+ * @irq:                  IPI agent interrupt ID
+ * @method:               IPI SMC or HVC is going to be used
+ * @local_id:             local IPI agent ID
+ * @num_mboxes:           number of mailboxes of this IPI agent
+ * @ipi_mboxes:           IPI mailboxes of this IPI agent
+ */
+struct zynqmp_ipi_pdata {
+	struct device *dev;
+	int irq;
+	unsigned int method;
+	u32 local_id;
+	int num_mboxes;
+	struct zynqmp_ipi_mbox *ipi_mboxes;
+};
+
+static struct device_driver zynqmp_ipi_mbox_driver = {
+	.owner = THIS_MODULE,
+	.name = "zynqmp-ipi-mbox",
+};
+
+static void zynqmp_ipi_fw_call(struct zynqmp_ipi_mbox *ipi_mbox,
+			       unsigned long a0, unsigned long a3,
+			       struct arm_smccc_res *res)
+{
+	struct zynqmp_ipi_pdata *pdata = ipi_mbox->pdata;
+	unsigned long a1, a2;
+
+	a1 = pdata->local_id;
+	a2 = ipi_mbox->remote_id;
+	if (pdata->method == USE_SMC)
+		arm_smccc_smc(a0, a1, a2, a3, 0, 0, 0, 0, res);
+	else
+		arm_smccc_hvc(a0, a1, a2, a3, 0, 0, 0, 0, res);
+}
+
+/**
+ * zynqmp_ipi_interrupt - Interrupt handler for IPI notification
+ *
+ * @irq:  Interrupt number
+ * @data: ZynqMP IPI mailbox platform data.
+ *
+ * Return: -EINVAL if there is no instance
+ * IRQ_NONE if the interrupt is not ours.
+ * IRQ_HANDLED if the rx interrupt was successfully handled.
+ */
+static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
+{
+	struct zynqmp_ipi_pdata *pdata = data;
+	struct mbox_chan *chan;
+	struct zynqmp_ipi_mbox *ipi_mbox;
+	struct zynqmp_ipi_mchan *mchan;
+	struct zynqmp_ipi_message *msg;
+	u64 arg0, arg3;
+	struct arm_smccc_res res;
+	int ret, i;
+
+	(void)irq;
+	arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
+	arg3 = IPI_SMC_ENQUIRY_DIRQ_MASK;
+	for (i = 0; i < pdata->num_mboxes; i++) {
+		ipi_mbox = &pdata->ipi_mboxes[i];
+		mchan = &ipi_mbox->mchans[IPI_MB_CHNL_RX];
+		chan = &ipi_mbox->mbox.chans[IPI_MB_CHNL_RX];
+		zynqmp_ipi_fw_call(ipi_mbox, arg0, arg3, &res);
+		ret = (int)(res.a0 & 0xFFFFFFFF);
+		if (ret > 0 && ret & IPI_MB_STATUS_RECV_PENDING) {
+			if (mchan->is_opened) {
+				msg = mchan->rx_buf;
+				msg->len = mchan->req_buf_size;
+				memcpy_fromio(msg->data, mchan->req_buf,
+					      msg->len);
+				mbox_chan_received_data(chan, (void *)msg);
+				return IRQ_HANDLED;
+			}
+		}
+	}
+	return IRQ_NONE;
+}
+
+/**
+ * zynqmp_ipi_peek_data - Peek to see if there are any rx messages.
+ *
+ * @chan: Channel Pointer
+ *
+ * Return: 'true' if there is pending rx data, 'false' if there is none.
+ */
+static bool zynqmp_ipi_peek_data(struct mbox_chan *chan)
+{
+	struct device *dev = chan->mbox->dev;
+	struct zynqmp_ipi_mbox *ipi_mbox = dev_get_drvdata(dev);
+	struct zynqmp_ipi_mchan *mchan = chan->con_priv;
+	int ret;
+	u64 arg0;
+	struct arm_smccc_res res;
+
+	if (WARN_ON(!ipi_mbox)) {
+		dev_err(dev, "no platform drv data??\n");
+		return false;
+	}
+
+	arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
+	zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, &res);
+	ret = (int)(res.a0 & 0xFFFFFFFF);
+
+	if (mchan->chan_type == IPI_MB_CHNL_TX) {
+		/* TX channel, check if the message has been acked
+		 * by the remote, if yes, response is available.
+		 */
+		if (ret < 0 || ret & IPI_MB_STATUS_SEND_PENDING)
+			return false;
+		else
+			return true;
+	} else if (ret > 0 && ret & IPI_MB_STATUS_RECV_PENDING) {
+		/* RX channel, check if there is message arrived. */
+		return true;
+	}
+	return false;
+}
+
+/**
+ * zynqmp_ipi_last_tx_done - See if the last tx message is sent
+ *
+ * @chan: Channel pointer
+ *
+ * Return: 'true' is no pending tx data, 'false' if there are any.
+ */
+static bool zynqmp_ipi_last_tx_done(struct mbox_chan *chan)
+{
+	struct device *dev = chan->mbox->dev;
+	struct zynqmp_ipi_mbox *ipi_mbox = dev_get_drvdata(dev);
+	struct zynqmp_ipi_mchan *mchan = chan->con_priv;
+	int ret;
+	u64 arg0;
+	struct arm_smccc_res res;
+
+	if (WARN_ON(!ipi_mbox)) {
+		dev_err(dev, "no platform drv data??\n");
+		return false;
+	}
+
+	if (mchan->chan_type == IPI_MB_CHNL_TX) {
+		/* We only need to check if the message been taken
+		 * by the remote in the TX channel
+		 */
+		arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
+		zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, &res);
+		/* Check the SMC call status, a0 of the result */
+		ret = (int)(res.a0 & 0xFFFFFFFF);
+		if (ret < 0 || ret & IPI_MB_STATUS_SEND_PENDING)
+			return false;
+		return true;
+	}
+	/* Always true for the response message in RX channel */
+	return true;
+}
+
+/**
+ * zynqmp_ipi_send_data - Send data
+ *
+ * @chan: Channel Pointer
+ * @data: Message Pointer
+ *
+ * Return: 0 if all goes good, else appropriate error messages.
+ */
+static int zynqmp_ipi_send_data(struct mbox_chan *chan, void *data)
+{
+	struct device *dev = chan->mbox->dev;
+	struct zynqmp_ipi_mbox *ipi_mbox = dev_get_drvdata(dev);
+	struct zynqmp_ipi_mchan *mchan = chan->con_priv;
+	struct zynqmp_ipi_message *msg = data;
+	u64 arg0;
+	struct arm_smccc_res res;
+
+	if (WARN_ON(!ipi_mbox)) {
+		dev_err(dev, "no platform drv data??\n");
+		return -EINVAL;
+	}
+
+	if (mchan->chan_type == IPI_MB_CHNL_TX) {
+		/* Send request message */
+		if (msg && msg->len > mchan->req_buf_size) {
+			dev_err(dev, "channel %d message length %u > max %lu\n",
+				mchan->chan_type, (unsigned int)msg->len,
+				mchan->req_buf_size);
+			return -EINVAL;
+		}
+		if (msg && msg->len)
+			memcpy_toio(mchan->req_buf, msg->data, msg->len);
+		/* Kick IPI mailbox to send message */
+		arg0 = SMC_IPI_MAILBOX_NOTIFY;
+		zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, &res);
+	} else {
+		/* Send response message */
+		if (msg && msg->len > mchan->resp_buf_size) {
+			dev_err(dev, "channel %d message length %u > max %lu\n",
+				mchan->chan_type, (unsigned int)msg->len,
+				mchan->resp_buf_size);
+			return -EINVAL;
+		}
+		if (msg && msg->len)
+			memcpy_toio(mchan->resp_buf, msg->data, msg->len);
+		arg0 = SMC_IPI_MAILBOX_ACK;
+		zynqmp_ipi_fw_call(ipi_mbox, arg0, IPI_SMC_ACK_EIRQ_MASK,
+				   &res);
+	}
+	return 0;
+}
+
+/**
+ * zynqmp_ipi_startup - Startup the IPI channel
+ *
+ * @chan: Channel pointer
+ *
+ * Return: 0 if all goes good, else return corresponding error message
+ */
+static int zynqmp_ipi_startup(struct mbox_chan *chan)
+{
+	struct device *dev = chan->mbox->dev;
+	struct zynqmp_ipi_mbox *ipi_mbox = dev_get_drvdata(dev);
+	struct zynqmp_ipi_mchan *mchan = chan->con_priv;
+	u64 arg0;
+	struct arm_smccc_res res;
+	int ret = 0;
+	unsigned int nchan_type;
+
+	if (mchan->is_opened)
+		return 0;
+
+	/* If no channel has been opened, open the IPI mailbox */
+	nchan_type = (mchan->chan_type + 1) % 2;
+	if (!ipi_mbox->mchans[nchan_type].is_opened) {
+		arg0 = SMC_IPI_MAILBOX_OPEN;
+		zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, &res);
+		/* Check the SMC call status, a0 of the result */
+		ret = (int)(res.a0 & 0xFFFFFFFF);
+		if (ret < 0) {
+			dev_err(dev, "SMC to open the IPI channel failed.\n");
+			return ret;
+		}
+		ret = 0;
+	}
+
+	/* If it is RX channel, enable the IPI notification interrupt */
+	if (mchan->chan_type == IPI_MB_CHNL_RX) {
+		arg0 = SMC_IPI_MAILBOX_ENABLE_IRQ;
+		zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, &res);
+	}
+	mchan->is_opened = 1;
+
+	return ret;
+}
+
+/**
+ * zynqmp_ipi_shutdown - Shutdown the IPI channel
+ *
+ * @chan: Channel pointer
+ */
+static void zynqmp_ipi_shutdown(struct mbox_chan *chan)
+{
+	struct device *dev = chan->mbox->dev;
+	struct zynqmp_ipi_mbox *ipi_mbox = dev_get_drvdata(dev);
+	struct zynqmp_ipi_mchan *mchan = chan->con_priv;
+	u64 arg0;
+	struct arm_smccc_res res;
+	unsigned int chan_type;
+
+	if (!mchan->is_opened)
+		return;
+
+	/* If it is RX channel, disable notification interrupt */
+	chan_type = mchan->chan_type;
+	if (chan_type == IPI_MB_CHNL_RX) {
+		arg0 = SMC_IPI_MAILBOX_DISABLE_IRQ;
+		zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, &res);
+	}
+	/* Release IPI mailbox if no other channel is opened */
+	chan_type = (chan_type + 1) % 2;
+	if (!ipi_mbox->mchans[chan_type].is_opened) {
+		arg0 = SMC_IPI_MAILBOX_RELEASE;
+		zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, &res);
+	}
+
+	mchan->is_opened = 0;
+}
+
+/* ZynqMP IPI mailbox operations */
+static const struct mbox_chan_ops zynqmp_ipi_chan_ops = {
+	.startup = zynqmp_ipi_startup,
+	.shutdown = zynqmp_ipi_shutdown,
+	.peek_data = zynqmp_ipi_peek_data,
+	.last_tx_done = zynqmp_ipi_last_tx_done,
+	.send_data = zynqmp_ipi_send_data,
+};
+
+/**
+ * zynqmp_ipi_of_xlate - Translate of phandle to IPI mailbox channel
+ *
+ * @mbox: mailbox controller pointer
+ * @p:    phandle pointer
+ *
+ * Return: Mailbox channel, else return error pointer.
+ */
+static struct mbox_chan *zynqmp_ipi_of_xlate(struct mbox_controller *mbox,
+					     const struct of_phandle_args *p)
+{
+	struct mbox_chan *chan;
+	struct device *dev = mbox->dev;
+	unsigned int chan_type;
+
+	/* Only supports TX and RX channels */
+	chan_type = p->args[0];
+	if (chan_type != IPI_MB_CHNL_TX && chan_type != IPI_MB_CHNL_RX) {
+		dev_err(dev, "req chnl failure: invalid chnl type %u.\n",
+			chan_type);
+		return ERR_PTR(-EINVAL);
+	}
+	chan = &mbox->chans[chan_type];
+	return chan;
+}
+
+static const struct of_device_id zynqmp_ipi_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-ipi-mailbox" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, zynqmp_ipi_of_match);
+
+/**
+ * zynqmp_ipi_mbox_get_buf_res - Get buffer resource from the IPI dev node
+ *
+ * @node: IPI mbox device child node
+ * @name: name of the IPI buffer
+ * @res: pointer to where the resource information will be stored.
+ *
+ * Return: 0 for success, negative value for failure
+ */
+static int zynqmp_ipi_mbox_get_buf_res(struct device_node *node,
+				       const char *name,
+				       struct resource *res)
+{
+	int ret, index;
+
+	index = of_property_match_string(node, "reg-names", name);
+	if (index >= 0) {
+		ret = of_address_to_resource(node, index, res);
+		if (ret < 0)
+			return -EINVAL;
+		return 0;
+	}
+	return -ENODEV;
+}
+
+/**
+ * zynqmp_ipi_mbox_dev_release() - release the existence of a ipi mbox dev
+ *
+ * @dev: the ipi mailbox device
+ *
+ * This is to avoid the no device release() function kernel warning.
+ *
+ */
+static void zynqmp_ipi_mbox_dev_release(struct device *dev)
+{
+	(void)dev;
+}
+
+/**
+ * zynqmp_ipi_mbox_probe - probe IPI mailbox resource from device node
+ *
+ * @ipi_mbox: pointer to IPI mailbox private data structure
+ * @node: IPI mailbox device node
+ *
+ * Return: 0 for success, negative value for failure
+ */
+static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
+				 struct device_node *node)
+{
+	struct zynqmp_ipi_mchan *mchan;
+	struct mbox_chan *chans;
+	struct mbox_controller *mbox;
+	struct resource res;
+	struct device *dev, *mdev;
+	const char *name;
+	int ret;
+
+	dev = ipi_mbox->pdata->dev;
+	/* Initialize dev for IPI mailbox */
+	ipi_mbox->dev.parent = dev;
+	ipi_mbox->dev.release = NULL;
+	ipi_mbox->dev.of_node = node;
+	dev_set_name(&ipi_mbox->dev, "%s", of_node_full_name(node));
+	dev_set_drvdata(&ipi_mbox->dev, ipi_mbox);
+	ipi_mbox->dev.release = zynqmp_ipi_mbox_dev_release;
+	ipi_mbox->dev.driver = &zynqmp_ipi_mbox_driver;
+	ret = device_register(&ipi_mbox->dev);
+	if (ret) {
+		dev_err(dev, "Failed to register ipi mbox dev.\n");
+		return ret;
+	}
+	mdev = &ipi_mbox->dev;
+
+	mchan = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
+	name = "local_request_region";
+	ret = zynqmp_ipi_mbox_get_buf_res(node, name, &res);
+	if (!ret) {
+		mchan->req_buf_size = resource_size(&res);
+		mchan->req_buf = devm_ioremap(mdev, res.start,
+					      mchan->req_buf_size);
+		if (IS_ERR(mchan->req_buf)) {
+			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
+			ret = PTR_ERR(mchan->req_buf);
+			return ret;
+		}
+	} else if (ret != -ENODEV) {
+		dev_err(mdev, "Unmatched resource %s, %d.\n", name, ret);
+		return ret;
+	}
+
+	name = "remote_response_region";
+	ret = zynqmp_ipi_mbox_get_buf_res(node, name, &res);
+	if (!ret) {
+		mchan->resp_buf_size = resource_size(&res);
+		mchan->resp_buf = devm_ioremap(mdev, res.start,
+					       mchan->resp_buf_size);
+		if (IS_ERR(mchan->resp_buf)) {
+			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
+			ret = PTR_ERR(mchan->resp_buf);
+			return ret;
+		}
+	} else if (ret != -ENODEV) {
+		dev_err(mdev, "Unmatched resource %s.\n", name);
+		return ret;
+	}
+	mchan->rx_buf = devm_kzalloc(mdev,
+				     mchan->resp_buf_size +
+				     sizeof(struct zynqmp_ipi_message),
+				     GFP_KERNEL);
+	if (!mchan->rx_buf)
+		return -ENOMEM;
+
+	mchan = &ipi_mbox->mchans[IPI_MB_CHNL_RX];
+	name = "remote_request_region";
+	ret = zynqmp_ipi_mbox_get_buf_res(node, name, &res);
+	if (!ret) {
+		mchan->req_buf_size = resource_size(&res);
+		mchan->req_buf = devm_ioremap(mdev, res.start,
+					      mchan->req_buf_size);
+		if (IS_ERR(mchan->req_buf)) {
+			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
+			ret = PTR_ERR(mchan->req_buf);
+			return ret;
+		}
+	} else if (ret != -ENODEV) {
+		dev_err(mdev, "Unmatched resource %s.\n", name);
+		return ret;
+	}
+
+	name = "local_response_region";
+	ret = zynqmp_ipi_mbox_get_buf_res(node, name, &res);
+	if (!ret) {
+		mchan->resp_buf_size = resource_size(&res);
+		mchan->resp_buf = devm_ioremap(mdev, res.start,
+					       mchan->resp_buf_size);
+		if (IS_ERR(mchan->resp_buf)) {
+			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
+			ret = PTR_ERR(mchan->resp_buf);
+			return ret;
+		}
+	} else if (ret != -ENODEV) {
+		dev_err(mdev, "Unmatched resource %s.\n", name);
+		return ret;
+	}
+	mchan->rx_buf = devm_kzalloc(mdev,
+				     mchan->resp_buf_size +
+				     sizeof(struct zynqmp_ipi_message),
+				     GFP_KERNEL);
+	if (!mchan->rx_buf)
+		return -ENOMEM;
+
+	/* Get the IPI remote agent ID */
+	ret = of_property_read_u32(node, "xlnx,ipi-id", &ipi_mbox->remote_id);
+	if (ret < 0) {
+		dev_err(dev, "No IPI remote ID is specified.\n");
+		return ret;
+	}
+
+	mbox = &ipi_mbox->mbox;
+	mbox->dev = mdev;
+	mbox->ops = &zynqmp_ipi_chan_ops;
+	mbox->num_chans = 2;
+	mbox->txdone_irq = false;
+	mbox->txdone_poll = true;
+	mbox->txpoll_period = 5;
+	mbox->of_xlate = zynqmp_ipi_of_xlate;
+	chans = devm_kzalloc(mdev, 2 * sizeof(*chans), GFP_KERNEL);
+	if (!chans)
+		return -ENOMEM;
+	mbox->chans = chans;
+	chans[IPI_MB_CHNL_TX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
+	chans[IPI_MB_CHNL_RX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_RX];
+	ipi_mbox->mchans[IPI_MB_CHNL_TX].chan_type = IPI_MB_CHNL_TX;
+	ipi_mbox->mchans[IPI_MB_CHNL_RX].chan_type = IPI_MB_CHNL_RX;
+	ret = devm_mbox_controller_register(mdev, mbox);
+	if (ret)
+		dev_err(mdev,
+			"Failed to register mbox_controller(%d)\n", ret);
+	else
+		dev_info(mdev,
+			 "Registered ZynqMP IPI mbox with TX/RX channels.\n");
+	return ret;
+}
+
+/**
+ * zynqmp_ipi_free_mboxes - Free IPI mailboxes devices
+ *
+ * @pdata: IPI private data
+ */
+static void zynqmp_ipi_free_mboxes(struct zynqmp_ipi_pdata *pdata)
+{
+	struct zynqmp_ipi_mbox *ipi_mbox;
+	int i;
+
+	i = pdata->num_mboxes;
+	for (; i >= 0; i--) {
+		ipi_mbox = &pdata->ipi_mboxes[i];
+		if (ipi_mbox->dev.parent) {
+			mbox_controller_unregister(&ipi_mbox->mbox);
+			device_unregister(&ipi_mbox->dev);
+		}
+	}
+}
+
+static int zynqmp_ipi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *nc, *np = pdev->dev.of_node;
+	struct zynqmp_ipi_pdata *pdata;
+	struct zynqmp_ipi_mbox *mbox;
+	int num_mboxes, ret = -EINVAL;
+
+	num_mboxes = of_get_child_count(np);
+	pdata = devm_kzalloc(dev, sizeof(*pdata) + (num_mboxes * sizeof(*mbox)),
+			     GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+	pdata->dev = dev;
+
+	/* Get the IPI local agents ID */
+	ret = of_property_read_u32(np, "xlnx,ipi-id", &pdata->local_id);
+	if (ret < 0) {
+		dev_err(dev, "No IPI local ID is specified.\n");
+		return ret;
+	}
+
+	pdata->num_mboxes = num_mboxes;
+	pdata->ipi_mboxes = (struct zynqmp_ipi_mbox *)
+			    ((char *)pdata + sizeof(*pdata));
+
+	mbox = pdata->ipi_mboxes;
+	for_each_available_child_of_node(np, nc) {
+		mbox->pdata = pdata;
+		ret = zynqmp_ipi_mbox_probe(mbox, nc);
+		if (ret) {
+			dev_err(dev, "failed to probe subdev.\n");
+			ret = -EINVAL;
+			goto free_mbox_dev;
+		}
+		mbox++;
+	}
+
+	/* IPI IRQ */
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(dev, "unable to find IPI IRQ.\n");
+		goto free_mbox_dev;
+	}
+	pdata->irq = ret;
+	ret = devm_request_irq(dev, pdata->irq, zynqmp_ipi_interrupt,
+			       IRQF_SHARED, dev_name(dev), pdata);
+	if (ret) {
+		dev_err(dev, "IRQ %d is not requested successfully.\n",
+			pdata->irq);
+		goto free_mbox_dev;
+	}
+
+	platform_set_drvdata(pdev, pdata);
+	return ret;
+
+free_mbox_dev:
+	zynqmp_ipi_free_mboxes(pdata);
+	return ret;
+}
+
+static int zynqmp_ipi_remove(struct platform_device *pdev)
+{
+	struct zynqmp_ipi_pdata *pdata;
+
+	pdata = platform_get_drvdata(pdev);
+	zynqmp_ipi_free_mboxes(pdata);
+
+	return 0;
+}
+
+static struct platform_driver zynqmp_ipi_driver = {
+	.probe = zynqmp_ipi_probe,
+	.remove = zynqmp_ipi_remove,
+	.driver = {
+		   .name = "zynqmp-ipi",
+		   .of_match_table = of_match_ptr(zynqmp_ipi_of_match),
+	},
+};
+
+static int __init zynqmp_ipi_init(void)
+{
+	return platform_driver_register(&zynqmp_ipi_driver);
+}
+subsys_initcall(zynqmp_ipi_init);
+
+static void __exit zynqmp_ipi_exit(void)
+{
+	platform_driver_unregister(&zynqmp_ipi_driver);
+}
+module_exit(zynqmp_ipi_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Xilinx ZynqMP IPI Mailbox driver");
+MODULE_AUTHOR("Xilinx Inc.");
diff --git a/include/linux/mailbox/zynqmp-ipi-message.h b/include/linux/mailbox/zynqmp-ipi-message.h
new file mode 100644
index 0000000..9542b41
--- /dev/null
+++ b/include/linux/mailbox/zynqmp-ipi-message.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_ZYNQMP_IPI_MESSAGE_H_
+#define _LINUX_ZYNQMP_IPI_MESSAGE_H_
+
+/**
+ * struct zynqmp_ipi_message - ZynqMP IPI message structure
+ * @len:  Length of message
+ * @data: message payload
+ *
+ * This is the structure for data used in mbox_send_message
+ * the maximum length of data buffer is fixed to 12 bytes.
+ * Client is supposed to be aware of this.
+ */
+struct zynqmp_ipi_message {
+	size_t len;
+	u8 data[0];
+};
+
+#endif /* _LINUX_ZYNQMP_IPI_MESSAGE_H_ */
-- 
2.7.4

