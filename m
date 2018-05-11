Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeEKDgw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 23:36:52 -0400
Received: from mail-sn1nam01on0105.outbound.protection.outlook.com ([104.47.32.105]:20544
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750751AbeEKDgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 23:36:49 -0400
Authentication-Results: spf=fail (sender IP is 64.157.242.222)
 smtp.mailfrom=nxp.com; nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=fail action=none header.from=nxp.com;
From: Yinbo Zhu <yinbo.zhu@nxp.com>
To: <yinbo.zhu@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Catalin Marinas )" <catalin.marinas@arm.com>,
        "Will Deacon )" <will.deacon@arm.com>,
        "Lorenzo Pieralisi )" <lorenzo.pieralisi@arm.com>,
        Li Yang <leoyang.li@nxp.com>
CC: <xiaobo.xie@nxp.com>, <ran.wang_1@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Changming Huang <jerry.huang@nxp.com>,
        Minghuan Lian <Minghuan.Lian@nxp.com>, Zhao Qiang <qiang.zhao@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "jiaheng . fan" <jiaheng.fan@nxp.com>, Po Liu <po.liu@nxp.com>,
        Nipun Gupta <nipun.gupta@nxp.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Priyanka Jain <priyanka.jain@nxp.com>, Sumit Garg <sumit.garg@nxp.com>,
        costi <constantin.tudor@freescale.com>,
        Bogdan Purcareata <bogdan.purcareata@nxp.com>,
        Meng Yi <meng.yi@nxp.com>, Wang Dongsheng <dongsheng.wang@nxp.com>,
        "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS"
        <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "open list:FREESCALE SOC DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
        Tang Yuantian <Yuantian.Tang@nxp.com>, <ying.zhang22455@nxp.com>,
        Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH 1/9] armv8: pm: add rcpm module support
Date: Fri, 11 May 2018 11:35:22 +0800
Message-ID: <20180511033530.7931-1-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.14.1
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:64.157.242.222;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(1496009)(396003)(376002)(39860400002)(39380400002)(346002)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(53936002)(81166006)(51416003)(8676002)(59450400001)(81156014)(50226002)(1076002)(77096007)(2616005)(476003)(126002)(6666003)(97736004)(47776003)(44832011)(26005)(6636002)(5660300001)(486006)(8936002)(336012)(106466001)(86362001)(498600001)(54906003)(110136005)(48376002)(305945005)(356003)(85426001)(7416002)(316002)(8656006)(105606002)(16586007)(36756003)(7406005)(2906002)(4326008)(50466002)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR03MB2182;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD020;1:ms15d6VkVj9REkrdedynDa5LwWgiB8IWKrwpEf50dY4MTUmeNTMLG2vRl0IPsBcQ9f1KomrXNWcF06Oxfy+jxe1j/coOwRRn83WQP9glzKHr62jI/IF7sIRQCCh9sHOe
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(5600026)(2017052603328);SRVR:CO2PR03MB2182;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2182;3:SyryYKRD2z/dZ+Bwnw2PR2ahNSFzAKbAfYsG8rKxC4EtCaT2zOq4SzBIDSwuncRPTWHVvaQNL95tVqjrGkcQI+DJiAJCjD9Bf4jcJqqkb/IiN+vS2U9dAri+5qDrUDbLUEPaz0tt5VbTZKBzve6UfPGQMCo6eNijLx3XEHKxtAyhvJhJmoqljsKQc9vVxfzYJ6VRpZzCB7e6LwsANf9QCnTQJBlu3HAG3RZYYTrFghl86LuzqwHTndBrK5ucv6zafOAAPRti0aQjpxyUaQq8GZDMlkNgtGTzEwZk0VeOKI+Up5HKJHuZtjvUVVFIHyQPb/7SMhZV2cATMBc4tPYpszPwdB8B0TnS9zLCpikr1gA=;25:/pBZtY0tEsOBinSRn8B40Av3Qlqm7CYyUG0KbqCqCWOejSeM2eMsyr0ELwo2j0Ofz0gM9hHRK9WQmyBPcwG8ATqPg9F0mBnJdDa5BDyTx7txS0USq1K7scaR+QETFouiEhMZAgcSYv/x24jTMQMNILk4B2NlfOcL+5S4zVyC0JW6UtOr7mRJo+GBKWC4VM4hYTl53ExcdrQgN+76KPtJ0/bNUi3lZAG3IwTR1wG0oEIOP4W55udajYXYiMTpd1yWFFAyaFOYnyk76aDpGJjg4hAgzTO3VTbhSfOIF33yCr31qYjvoqNiDD5VbnJNBk+XkWGg1TJbuAOTDHuf9UW4Aw==
X-MS-TrafficTypeDiagnostic: CO2PR03MB2182:
X-LD-Processed: 710a03f5-10f6-4d38-9ff4-a80b81da590d,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2182;31:zZoRIY8Alu0gXIaL886FX/xbP/P/WdD1XCe/TrWTmsWjz4JI+wEuti1zfPW5zm+7Hd9Wcr+IO0MgknfEmoRgVEMInIBEjFfwEeV0p8ZmvvAZZ2OrHCXo0CvOyIj+jopKTbe4RoeestkWzlAtl9r4nmel0HFN1z9sOF05GcYAw4QXzybR0kTAsoJQMZJMAFCXl5STVpX1CYkUzpfm6UlmG51H16CO2VBMeSIULIw9bZ0=;20:WIDPy6gB64qL08/85CNd5laZ7awl7RVypRPY2FetC/tN2IWz7vTbh/UnjFvSre4fp9XWvmS9hmMyA0JTfqH4t9ydBJnEj3Q+p0Kg/9ww3TpZnjbPqh/5TktYDFt7SOTlDE2CFPeChOwRg54+kD0IKFozn0QReTh0m/KyPRueLzAVwFRHNPL9APgKs3wLA62zYr1Ln5OnIQbYa7MSUo4MroTas7UB9yNo2gmRHotgaIV6Tn7MvPybxWqeTySW4pSSRzzwYRbyDVoyjxPS3Gk/HcdNtTmIvarumhYGgHACjuHsqDtgCX3+pAH8gx++XicCIW622xTANCLQvJYU0gTEUMW8OKJSkwLJKidRH8HbfDSJRNE+LKjyM93t2XVXafC9UpFmRkCje336pwhhV2ftehtcuetpGp603P8LH/ipZ9dyzJXlzbH84ZyFjdRAxPNfpHUSiRrsa4SZLBn6gkFknaOywCP5DU9eCeEyJCVsVx0UcCz3A6LdnL5Jh1410wPnPkG/PUTURrfUOcBDT4/uASfUdNOGURtDs5upbdjNzZYewX4SBQZyLtMLEyAyVIoXqlD7NhRtE91xNhXrEKt/VtnJP2/YECDJ92qayWWpVnA=
X-Microsoft-Antispam-PRVS: <CO2PR03MB2182139BC0D530B5071B519FE99F0@CO2PR03MB2182.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 0
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93003095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CO2PR03MB2182;BCL:0;PCL:0;RULEID:;SRVR:CO2PR03MB2182;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2182;4:i/t2Mv6sXJDARF+1IYckvI+itGF/bgwLyoPqunl7d83p4nN2PJ4OCbIQRxwbRfGTq9+d6VZNfFEGiTgGSLFGmqzwaxTuV7Lk6thbwvFZ9B9mg2v6TEcEJEhVAfhmRe4v7Wu9ktNVMJeJqNd8EojQ/FdhLOblTQhYBRksGHisUwb60UNML9X+/8JNpUPfxk5kbGLzc6pVpBjJ4eBsVr1b9b3D+iVmMLX7h3/Nh9LnB2Pyo5qW27HGVlcfMbauVuRwDISi7ovH+LmNalmEAndC1O4AW+kPV9EfrKhNaVY5DbaaMfJANHdJGN3knaJYcwYs
X-Forefront-PRVS: 06691A4183
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR03MB2182;23:eSDUC+KEZKDCi/zTSm3j/K1P5nMOc5UOci+2/4EiO?=
 =?us-ascii?Q?JPRiAcouH7t+7vNK6tXnJyWYHUzW7/BN2PeV2rpWdBwInOou+xr4mcVIGIu1?=
 =?us-ascii?Q?C4oYYXz0wBTH9abcLURDjGhoIXFgq/DQ4kmbjvl/XFR/VFhHZWkPh9EqkCwi?=
 =?us-ascii?Q?cXI/OEeuujB3exa3YEoZSwT4VaN1/Qme7valXlzj2a67Bgfh9adT0bD2Ge09?=
 =?us-ascii?Q?GQLpcEtHBB3qRyjuF2prNIPMe6pv3CtvYkEp0efPiQfKNWF8XmytwEEdNpkJ?=
 =?us-ascii?Q?QDm/Hg09/I87K7+EENt9xsSdPVH3KbSqCNisobryfy2QtJHFxue9ojP53ooL?=
 =?us-ascii?Q?Ydy/xJM9psI6MuUVHZD01U/ZCknXY14vXOiDDczOyx8kthSeTISeLK1soTzT?=
 =?us-ascii?Q?pfS4kOgoBdUTdhBMx+/txhix9rdyJbxFo2R5vYEml4y9cL/DIWbLMBh5TfZG?=
 =?us-ascii?Q?9aIDaqVkaoD60T4WW1wBqa+U45KWw2DiHVH7SU1GYCzX8GY+rRYInNb8SC7B?=
 =?us-ascii?Q?35QENNDmFl96LMQ2p2aK09/vmn/Y6EyY//aUDk3vdKcpQ7CARzDz5mVSZ7Nc?=
 =?us-ascii?Q?BJcP5JwomKS6Rv0ockP0CwkikQNza5W3sTk6oZIgY8Z97th0eSwmZZZDn/gq?=
 =?us-ascii?Q?24yiREkGAXPcAl00QiRXgVmA9nIqgLD1WlnldLc3ge+PMZ1yw4szFJQrDgpJ?=
 =?us-ascii?Q?mCB8W5eYVS/j6oxPnqrFMUY/TxLuvmAyItJQhCIRnxeYZqcJwCmzbCxNS+DH?=
 =?us-ascii?Q?vqIdA6jWqfCnoylUnztqKlnF7BvofO1GiOv1jKw9AvY9DGZJwgrRnVqFekbw?=
 =?us-ascii?Q?Vr4gRwdySbvJ3d04p3n/ct7tVuSN8ojg15fB1PUzirpNVaktAKIPmbEcjpB0?=
 =?us-ascii?Q?eJS8ooUHcyDDIPewz6z6/+2dMmBZDbEk+D/BbAzHlnmRxdsUmTLn3/i0W8Fu?=
 =?us-ascii?Q?Dd+rPua/RCBXILgcxYBY8epXfFho10lOA4Up3/8+1ZZgnwOWnZDOM2EdnnQm?=
 =?us-ascii?Q?txjNQHy0nTcUFB6lZNBXKtEgcBXHTwNhnqx6xpcv3W9Og9ba8RjjFIcOCq7H?=
 =?us-ascii?Q?YqvaGW1SQ7o+uBCqwavUD2T0jjiO3zMBsESJ1ZhxekIY4iDBDxW35S6tl9Op?=
 =?us-ascii?Q?wIwWcWg9MR9OJpjKYODAJcadphVrjJH6woYe6szqI8/MreD632ooELlyhJbm?=
 =?us-ascii?Q?+kiDKCEoce0r35mZfBrVrt7XpatAow1HvZhuN03kLFrr9t6Rw/2Xf/dow=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: Ry+ZewpW0GxdgQfD1iIG2pvZhzOB1YbONNj0q8U9iMTHJW0DYM2eoqUmeNlbrOmBjlBCMkr0S3fu0x/XV1AZCAEX8K0Cs0r6PWLR6N0VBtJ1qMqYwVYmw/U9QR3OqTEMVbviNqUaGZ2zssnVxgR06pObsrxfhaXtZ3WmFlm0NabE0+b95ZVvk2TZuZgx9nzU
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2182;6:9vxNxRygEFBBTxMzTowETjJYP85GdgOdWtarBZMsA7ACql/0+o5xP7QktRBvNIYdzbyUaNbCXCjpH4jtMtv52gWXJPg1Zfye6c5i1DT+hrSHD5f2pUvsTCbE2NjTXVU0WFD2I1SE3uKp4DGArUmI2Gzxs2ezsT1ZEf6NdtBTe1eQcoKTLtV+8FqXt3UT69u9QcDEX1vA2e/3rGKMzl61zB12VlFyu3zGo84cMAFCYPG63BumsM07Nrq8mVVSkxJ9s6hTvp3KG+lEjjhU7DPVruXk3k+gJ6b+KkbNo1mXPb80Hb1D64JIzfuNtbspuclmM9DiuNPzEJ2bQOqDIAFyW3QZqswGsbSiLmmAigK7+ChFofCwg5vjb9ax2CWBSKsvMh+XG9+VaAahJLUsaUCgjmF9GDD4K1b7j77gulLPrE0E/wcUc3gdufLl6Pj9J2kzFoqVAvr3rNtykpSURSpIqQ==;5:t48meVm/sEto2Me5jIxPzYeG3zRx9WvKRZXIAib123ycpff7DXTaTUxBjB2QRCzaDkzxpeBKUFE0zAJYaCKlbqL5xdLPsXOYFtpSdfpdMj0E3D8X2peuVFDnEByW/n7Es1s+xjDLXTy2nLoDVgj66hNTqludRsqkVYrQCgx5HEg=;24:3WbK4NmjGxnCRQ2t1DBqnTSPvADl4NQQzy3uXLzdVN9/7/2ObPiyKlwuMZmD9B+sdGE+oViT/4uGXIKDt/JuMevP3fcat2dV194G7AQaxck=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2182;7:nUI74Lu8QVV2NP3W1r6uu0BGwmFuGzQwRd0/n8VMOYaKrQ33MzoctrOvZITmTQWs2CwUffaprGZAEyS8Gqr37wTaR3m489mhk7U8IreaRxdO+/dnzX62v/IT/vr2Q9om9UAEpoaEcJEAdYwqFLX6H2PZ7xOhBa++9adjRcq+uOcp9z1O+HM3VfMAhlDjRLI5kzGGYkI2YbtuWTZjIGl9UCrthER8F9NYQxDnzGIyA89sz87u5XngpiBF0RFEWh63
X-MS-Office365-Filtering-Correlation-Id: 9481e755-57a5-46c0-5b30-08d5b6f06826
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2018 03:36:39.5579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9481e755-57a5-46c0-5b30-08d5b6f06826
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[64.157.242.222];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2182
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

The Run Control and Power Management (RCPM) module communicates
with embedded cores, coherency modules, and other device platform
module to provide run control and power management functionality

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 drivers/soc/fsl/Makefile |    1 +
 drivers/soc/fsl/rcpm.c   |  153 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+), 0 deletions(-)
 create mode 100644 drivers/soc/fsl/rcpm.c

diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 629dab8..68fcd71 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_FSL_DPAA)                 += qbman/
 obj-$(CONFIG_QUICC_ENGINE)		+= qe/
 obj-$(CONFIG_CPM)			+= qe/
+obj-$(CONFIG_SUSPEND)            	+= rcpm.o
 obj-$(CONFIG_FSL_GUTS)			+= guts.o
 obj-$(CONFIG_FSL_LS2_CONSOLE)		+= ls2-console/
 obj-$(CONFIG_LS_SOC_DRIVERS)		+= layerscape/
diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c
new file mode 100644
index 0000000..ff0477b
--- /dev/null
+++ b/drivers/soc/fsl/rcpm.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2016 NXP
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#define pr_fmt(fmt) "RCPM: %s: " fmt, __func__
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/suspend.h>
+
+/* RCPM register offset */
+#define RCPM_IPPDEXPCR0			0x140
+
+#define RCPM_WAKEUP_CELL_SIZE	2
+
+struct rcpm_config {
+	int ipp_num;
+	int ippdexpcr_offset;
+	u32 ippdexpcr[2];
+	void *rcpm_reg_base;
+};
+
+static struct rcpm_config *rcpm;
+
+static inline void rcpm_reg_write(u32 offset, u32 value)
+{
+	iowrite32be(value, rcpm->rcpm_reg_base + offset);
+}
+
+static inline u32 rcpm_reg_read(u32 offset)
+{
+	return ioread32be(rcpm->rcpm_reg_base + offset);
+}
+
+static void rcpm_wakeup_fixup(struct device *dev, void *data)
+{
+	struct device_node *node = dev ? dev->of_node : NULL;
+	u32 value[RCPM_WAKEUP_CELL_SIZE];
+	int ret, i;
+
+	if (!dev || !node || !device_may_wakeup(dev))
+		return;
+
+	/*
+	 * Get the values in the "rcpm-wakeup" property.
+	 * Three values are:
+	 * The first is a pointer to the RCPM node.
+	 * The second is the value of the ippdexpcr0 register.
+	 * The third is the value of the ippdexpcr1 register.
+	 */
+	ret = of_property_read_u32_array(node, "fsl,rcpm-wakeup",
+					 value, RCPM_WAKEUP_CELL_SIZE);
+	if (ret)
+		return;
+
+	pr_debug("wakeup source: the device %s\n", node->full_name);
+
+	for (i = 0; i < rcpm->ipp_num; i++)
+		rcpm->ippdexpcr[i] |= value[i + 1];
+}
+
+static int rcpm_suspend_prepare(void)
+{
+	int i;
+
+	WARN_ON(!rcpm);
+
+	for (i = 0; i < rcpm->ipp_num; i++)
+		rcpm->ippdexpcr[i] = 0;
+
+	dpm_for_each_dev(NULL, rcpm_wakeup_fixup);
+
+	for (i = 0; i < rcpm->ipp_num; i++) {
+		rcpm_reg_write(rcpm->ippdexpcr_offset + 4 * i,
+			       rcpm->ippdexpcr[i]);
+		pr_debug("ippdexpcr%d = 0x%x\n", i, rcpm->ippdexpcr[i]);
+	}
+
+	return 0;
+}
+
+static int rcpm_suspend_notifier_call(struct notifier_block *bl,
+				      unsigned long state,
+				      void *unused)
+{
+	switch (state) {
+	case PM_SUSPEND_PREPARE:
+		rcpm_suspend_prepare();
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct rcpm_config rcpm_default_config = {
+	.ipp_num = 1,
+	.ippdexpcr_offset = RCPM_IPPDEXPCR0,
+};
+
+static const struct of_device_id rcpm_matches[] = {
+	{
+		.compatible = "fsl,qoriq-rcpm-2.1",
+		.data = &rcpm_default_config,
+	},
+	{}
+};
+
+static struct notifier_block rcpm_suspend_notifier = {
+	.notifier_call = rcpm_suspend_notifier_call,
+};
+
+static int __init layerscape_rcpm_init(void)
+{
+	const struct of_device_id *match;
+	struct device_node *np;
+
+	np = of_find_matching_node_and_match(NULL, rcpm_matches, &match);
+	if (!np) {
+		pr_err("Can't find the RCPM node.\n");
+		return -EINVAL;
+	}
+
+	if (match->data)
+		rcpm = (struct rcpm_config *)match->data;
+	else
+		return -EINVAL;
+
+	rcpm->rcpm_reg_base = of_iomap(np, 0);
+	of_node_put(np);
+	if (!rcpm->rcpm_reg_base)
+		return -ENOMEM;
+
+	register_pm_notifier(&rcpm_suspend_notifier);
+
+	pr_info("The RCPM driver initialized.\n");
+
+	return 0;
+}
+
+subsys_initcall(layerscape_rcpm_init);
-- 
1.7.1
