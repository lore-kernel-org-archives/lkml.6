Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeB0X4U (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:56:20 -0500
Received: from mail-bl2nam02on0063.outbound.protection.outlook.com ([104.47.38.63]:5312
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751767AbeB0X4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:56:14 -0500
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH 2/2] drivers: soc: xilinx: Add ZynqMP power domain driver
Date: Tue, 27 Feb 2018 15:55:50 -0800
Message-ID: <1519775750-21297-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519775750-21297-1-git-send-email-jollys@xilinx.com>
References: <1519775750-21297-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39380400002)(39860400002)(2980300002)(438002)(50944005)(199004)(189003)(5890100001)(106466001)(47776003)(81156014)(316002)(48376002)(2201001)(50466002)(59450400001)(72206003)(63266004)(51416003)(356003)(305945005)(7696005)(7416002)(9786002)(478600001)(76176011)(110136005)(54906003)(26005)(107886003)(77096007)(50226002)(6666003)(8676002)(39060400002)(2950100002)(5660300001)(336011)(106002)(36756003)(16586007)(4326008)(186003)(2906002)(8936002)(81166006)(36386004)(921003)(107986001)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB3813;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT028;1:NlAw0i4c9OlUT1f4T7Zs1blkzhj1bt4Lyl9AjJtWYegjy2mUvC2dhRhlO+YFGSIV3ZdOpYuQfAFUcmuKnShHZH+4cyqy8b5cPTVd7ywHCWeOMQbzDSSqNt53W4nROmhx
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a2922d4-9833-4e0a-0b5e-08d57e3dad18
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:DM5PR02MB3813;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB3813;3:BYsvzZ1kuPsE5m60D+0gjl6h4djJXMF6SaMlmmK8ffRFRLXaqwb5P/j13D7pMg0iGXvweGQDlwc/+0rxHoDldrNn7vazzVv3MnIdWynkyFs4b2K6fgsgqjhFygZJZNzmTqUPZh9QElXMgToJiSrZ8sRsD/elBv+gJUOh6tmJhM+NZVbpFWE9DlgPuic7W4A3xNq+5E60gDQrwmbrpHb/o8nnVhSPzbMRKpbsS/KcXp9+ybdHT+lLuqjw5hT/5UuDCTxOEtiWBBZwPExhOMkTB9x4V0ERoJCkgfSfis2kOA2tcsbcYOwa5NRdzCIcwUzBr32lCDNzc4HikMpd7YiEOMYRxBIEaReMsZHoUGXsASs=;25:SQRFgQm9bfDoMPt4RHZ8tQ+tghYPUjs2JRzGnYFSlywUtG8rfNHofWow+YO1FT+JHsGpSQEWC1Q1y8lV0B1laiZNYEVQLvAd0W4PSN6wzwg4Is3xKjYevyG2jx+r28olRuQhhKOafk2fX4iQ302vqfA5Pnd2zWQpeMZwAIr9l75ne/todTB7dNOBty0dz6jw4ZGhxNf+Ii+wnGF/kRUX0oqtqwos1qMe7VHDRfnvnlXLH8EW00KfEBCTMx30wW2s82Sny0UOnlik9Qr0B2W+5TLCCFuTp53+ZZzijkoNfYbmoMq07/F9bao5EKBfx1D6L50iRL/rORrQMKnOSkpJXw==
X-MS-TrafficTypeDiagnostic: DM5PR02MB3813:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB3813;31:E+4cjCEmpZ3iUD5jAk3idi5rVXZsjAagIHTnLORufalOktKQ2cKiH1/pyfbQL+yFv8LQ4QHqvSldSWajJ/sMKvpr7mI25Zxdi9BANF3G8dZQSeYr4EkPkhrRIqd+78aqktgfG1y9d9x2x7CS25PkE0LDONhNLO2FINEAYCrSkiTHZq9Tq6qwt0KWe88xcQ+Mjby/7o4Dp7Lu5anETljmZ1oxlRyXjfqOiAlNHq6c0Gs=;20:rQksdEBLtpYmjUThuH4zzEi7DRC7C+nGPJ9Bam2ogOQEEIbpO1g1ngqUnMFNk4e7Wkh3kyXBQsKNIfvpghCgRaJuI5ntKyp/LM3tPsbZxv7B2fcNK/cFwQsBFRln8BALCeSIYFYjhvoka8pV5dmgGgds4JEznEbFbs6I7LliXB6qrlM5VlHh3AXBnicEhbB5+I1pcxl+q/c4FWuINxsJTg4Fb8tQ1hrOG0kvAeZkDESvBKHWP+ZozVaiWQtfoCELvAYOgcADnkj7dPbff4Bsh1N7yTmBJUoGLP7ihDMNLwQgYkCR8P+sDTKZuX39VLxWkv6ebz5A6bE0kD7uMNCamoUuGOQkxjC7CZL6kGpmUKmiP15K/rGa7xOpbVLCqFh0bEaxtOukCcxMSbYA+kMUoolhvGek2hMCfnLJpCyhv16xnF8vL/GoCmO9RfWSQiQP6c24Hm/uQsOjd1qFQ/6ln0Z0qm165LAYJ8U9vbpxRwLXZ5+Gj7uK8ALK8j6tw428
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB381387727661C22C152E1362B8C00@DM5PR02MB3813.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(10201501046)(3231220)(944501161)(52105095)(6055026)(6041288)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR02MB3813;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB3813;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB3813;4:rSYkh7UjqbfyueqORPrqIYcHHqzujocmE+3fENbvllCbQ950ijIJyKM7/ymfFv+N6pYkA1zz3kNDgS9KLuNnLljKxEzl2G05imHx/EzJXDlSOE87IxlK1qsW+MP/3t/Zlw/gxVfhGbNMd7itFXRkQofltZZOSb/mRv9TVY9pB8RA/KqMRa3PaX74W7FJmABzIuRJW6cozJB4FPRS8/7JqnXbes1zHWB2PDyVXMtEb++eCPw33XjFbAWYBf39bkUa58Dm/wBNIfVy1NFoMDui4IBfXwTaW9vJ2Vp+AdOSUr9pweDxPaeadOBrlQaXxXlml8aymISBKl5uNCEs3QVCtBliizd+zlPGkkvElCcWDu8=
X-Forefront-PRVS: 05961EBAFC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR02MB3813;23:u7hRhUdZ7j6Mnd/dfa9PSn4ChKGLdEhXGjlFinxhY?=
 =?us-ascii?Q?xpYJ/3h3PyAq9PCIm5jMIqKDFZURyIJPfq6EQJcPhkAOYZH4kAMpeff7qRnv?=
 =?us-ascii?Q?GuD44BNZ6knZYsuxwflsJVOJ0p9HZ4JXnxtdT+JhyQpXwn9Ct1cRbM9tWx58?=
 =?us-ascii?Q?ra2RlbLRPrBYnSDi4t1tjtLI3xGJvA1tZJnpbZ6DFWVyqaukU8oTWUBggAnT?=
 =?us-ascii?Q?WMP0l5Gx2tzafHf+1njhjdo0YgS+dsiWNg4lcZujyhxSWIWWY0reo6oNZ8dZ?=
 =?us-ascii?Q?2ZRehuvvXZ09RRZtvztioPHK7QiRbTEDjZ3Qp3Vfm+0rfZYDzZHPc1heKO+H?=
 =?us-ascii?Q?wR4sah8gfkaOgArOMRHPX+xpfN5gRDlLkR4wV0h4GUOIZYxV4H33ca4/fcFW?=
 =?us-ascii?Q?Jf4uv9q3tBo0/G2TeCYXh8hKZ1mZLgPT5sVJJngFYS2FVs+/mXDwW2JgStpB?=
 =?us-ascii?Q?gkKgIth6CjmKJYGrLymU1McoqqMrA46iIVUO9JZWecFfzZlrVvC37+53rkiz?=
 =?us-ascii?Q?q9UqiPvw/hu261+r0oK2lY+neTHpKCoe9Bcsezi/rGrNcf9z+pXY9qADL9k7?=
 =?us-ascii?Q?AnmUNbxcwICjkJk7rHSa8ew6U18rggXYpA/Wh0vNyHD5aWhGi61HJ4L3/76W?=
 =?us-ascii?Q?ILuk5cUkpeTJaF5uJuX6OtAvY3CPempP2GKC3eFIfwjMiOPpUAdhVY0gWjA1?=
 =?us-ascii?Q?onNALIHRtz3OVyy+aBas/yBiLPzwAd6ZFsUuTtexueuLPFWZNgin0fuYxaWn?=
 =?us-ascii?Q?seUT2+QGkxQAxXMPtT42NX0LoowGaQzJz4VcRtiUYzPQfp2Jn+/4Mom05TbT?=
 =?us-ascii?Q?0O4vx9JkFoabtddvu+Hb7AmJU7OGZNyDx614so2H7SFQkHx0GvBNEzQQpMy5?=
 =?us-ascii?Q?RYIHBy/b5/QX96ojAPeoQUrSgNh0m00VyZrLve8Le6w0AC0G0rYoyBkK3br5?=
 =?us-ascii?Q?cHgci3EtG0ueyvyCT9CzQdoPznlFcaeYE8gbcnQ8ms+bSHw2E1ebrcVL/0a3?=
 =?us-ascii?Q?6N7+cLocOsnpnUktED+si/2EqqUukUeTNeyaSbTLTn+5i1iRUfh619ROx54+?=
 =?us-ascii?Q?EXg3aPOKA03N82Y5+lncDyLmZYCyULuxgRd42OO7kchp7FM+4T79OfeS7sBU?=
 =?us-ascii?Q?WYULW7pqI5ytZmRZp8UY2k3r9xjYyYI5qLsyUQrei/FaBNmnkQOocsHtVJIo?=
 =?us-ascii?Q?iYmMNkfxcHXdvlFmwfsiqjbgDs6tdOOdQhMbs/mnvffAeeVDCfuobdjcvsSh?=
 =?us-ascii?Q?V6FCtMLeVaDyUw0aZQ=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB3813;6:zk0s/PhzLV/x45g5o4foIlQ+727MHJmJl0BFVwKrg5DdyJ7S3QlUY6zTswkOlXITvuhH7Jn+Qp5WqDzFwLlKYTSmunFRzQtkUJDw1EoTJe2uk8qDeDVy7a/WR8mWP+EwPwBX7CsrML0ywQ08GKkqkLxNtVyUPiP/x0NJSOab/4z0F21xT4HBPbVg48VnIJgGQZ7/2TofDYEjCkRlpJaWr/JNqjsVmxG/73eM2ZEGTGl7Y8IvDG2/RMLYh/tmkZJ3XE9mV/VJwqmQQgPPKmj54lWdBg1yismR7NjrlMSR8ueUjQaO4yIlr9vP10+xTcvNIv7OZ+07YmXxRLrrRlkBr0V4/RLemzxcGb/Xl2+DlhQ=;5:zWmDTp0pnKfwgTjUgMi4OnDqvgvq/qh1oHhCYUlmcGLiqOXUaf7BTWLcc9Rbc+GqwEAocPeWUCuYEITO3G6dnSbLoubHC+GvXT6z9lv5UK86prIJBBoUok64+KpJksYYefLPF650VNROqs4q5jrmxiqpzMpREvnmo0JQ+6Pnbpc=;24:Iw04XZrkRogEHDLNfbz2BqOI90gIsBrO0XvCKw7JPVpHFgpAwnSKXiF4kaBqTJKX10Qy7kRG1rZtT6IZ7yT0aZZUQJZvZFZe0m0lmxqdJMM=;7:VxrU5mMSxw8oSZT1+nS4cA89jyKcDzI1OGrgFPtjBk0Q66KPp+ebsoghpIDeMSRhJKWHGy64+ynNUWnXNJM4YIO+g8vnMxwLb/FUGxVDFY5+UJQvfHZkG/9pywX++17Pr/85f3w64FIqwq2RJxwWXur/2OmB4O0+CYz6bZKkCIXSBCJY5hJ2mvD8EKEuQDYcbf/KIAftyDvXR34FnKwukyLIzimn+R8IqVW0h0z2iLF3JT29kITqP6JyrTSn/+aM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 23:56:09.7119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2922d4-9833-4e0a-0b5e-08d57e3dad18
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3813
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zynqmp-genpd driver communicates the usage requirements
for logical power domains / devices to the platform FW.
FW is responsible for choosing appropriate power states,
taking Linux' usage information into account.

Signed-off-by: Jolly Shah <jollys@xilinx.com>
Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
---
 drivers/soc/xilinx/Kconfig             |   2 +
 drivers/soc/xilinx/Makefile            |   2 +
 drivers/soc/xilinx/zynqmp/Kconfig      |  16 ++
 drivers/soc/xilinx/zynqmp/Makefile     |   4 +
 drivers/soc/xilinx/zynqmp/pm_domains.c | 339 +++++++++++++++++++++++++++++++++
 5 files changed, 363 insertions(+)
 create mode 100644 drivers/soc/xilinx/zynqmp/Kconfig
 create mode 100644 drivers/soc/xilinx/zynqmp/Makefile
 create mode 100644 drivers/soc/xilinx/zynqmp/pm_domains.c

diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
index 687c8f3..1c98d7f 100644
--- a/drivers/soc/xilinx/Kconfig
+++ b/drivers/soc/xilinx/Kconfig
@@ -17,4 +17,6 @@ config XILINX_VCU
 	  To compile this driver as a module, choose M here: the
 	  module will be called xlnx_vcu.
 
+source "drivers/soc/xilinx/zynqmp/Kconfig"
+
 endmenu
diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
index dee8fd5..e132897 100644
--- a/drivers/soc/xilinx/Makefile
+++ b/drivers/soc/xilinx/Makefile
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_XILINX_VCU)	+= xlnx_vcu.o
+
+obj-$(CONFIG_ARCH_ZYNQMP)	+= zynqmp/
diff --git a/drivers/soc/xilinx/zynqmp/Kconfig b/drivers/soc/xilinx/zynqmp/Kconfig
new file mode 100644
index 0000000..95d8665
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Kconfig for Xilinx zynqmp SoC
+
+menu "Zynq MPSoC SoC Drivers"
+	depends on ARCH_ZYNQMP
+
+config ZYNQMP_PM_DOMAINS
+	bool "Enable Zynq MPSoC generic PM domains"
+	default y
+	depends on PM
+	select PM_GENERIC_DOMAINS
+	help
+	  Say yes to enable device power management through PM domains
+	  In doubt, say N
+
+endmenu
diff --git a/drivers/soc/xilinx/zynqmp/Makefile b/drivers/soc/xilinx/zynqmp/Makefile
new file mode 100644
index 0000000..0bd522b
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Makefile for Xilinx zynqmp SoC
+
+obj-$(CONFIG_ZYNQMP_PM_DOMAINS) += pm_domains.o
diff --git a/drivers/soc/xilinx/zynqmp/pm_domains.c b/drivers/soc/xilinx/zynqmp/pm_domains.c
new file mode 100644
index 0000000..7ddca8e
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp/pm_domains.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ZynqMP Generic PM domain support
+ *
+ *  Copyright (C) 2015-2018 Xilinx, Inc.
+ *
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/firmware/xilinx/zynqmp/firmware.h>
+
+/* Flag stating if PM nodes mapped to the PM domain has been requested */
+#define ZYNQMP_PM_DOMAIN_REQUESTED	BIT(0)
+
+/**
+ * struct zynqmp_pm_domain - Wrapper around struct generic_pm_domain
+ * @gpd:		Generic power domain
+ * @dev_list:		List of devices belong to power domain
+ * @node_ids:		PM node IDs corresponding to device(s) inside PM domain
+ * @node_id_num:	Number of PM node IDs
+ * @flags:		ZynqMP PM domain flags
+ */
+struct zynqmp_pm_domain {
+	struct generic_pm_domain gpd;
+	struct list_head dev_list;
+	u32 *node_ids;
+	int node_id_num;
+	u8 flags;
+};
+
+/*
+ * struct zynqmp_domain_device - Device node present in power domain
+ * @dev: Device
+ * &list: List member for the devices in domain list
+ */
+struct zynqmp_domain_device {
+	struct device *dev;
+	struct list_head list;
+};
+
+/**
+ * zynqmp_gpd_is_active_wakeup_path - Check if device is in wakeup source path
+ * @dev: Device to check for wakeup source path
+ * @not_used: Data member (not required)
+ *
+ * This function is checks device's child hierarchy and checks if any device is
+ * set as wakeup source.
+ *
+ * Return:	1 if device is in wakeup source path else 0.
+ */
+static int zynqmp_gpd_is_active_wakeup_path(struct device *dev, void *not_used)
+{
+	int may_wakeup;
+
+	may_wakeup = device_may_wakeup(dev);
+	if (may_wakeup)
+		return may_wakeup;
+
+	return device_for_each_child(dev, NULL,
+			zynqmp_gpd_is_active_wakeup_path);
+}
+
+/**
+ * zynqmp_gpd_power_on - Power on PM domain
+ * @domain:	Generic PM domain
+ *
+ * This function is called before devices inside a PM domain are resumed, to
+ * power on PM domain.
+ *
+ * Return:	0 on success, error code otherwise.
+ */
+static int zynqmp_gpd_power_on(struct generic_pm_domain *domain)
+{
+	int i, status = 0;
+	struct zynqmp_pm_domain *pd;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->set_requirement)
+		return status;
+
+	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
+	for (i = 0; i < pd->node_id_num; i++) {
+		status = eemi_ops->set_requirement(pd->node_ids[i],
+					ZYNQMP_PM_CAPABILITY_ACCESS,
+					ZYNQMP_PM_MAX_QOS,
+					ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+		if (status)
+			break;
+	}
+	return status;
+}
+
+/**
+ * zynqmp_gpd_power_off - Power off PM domain
+ * @domain:	Generic PM domain
+ *
+ * This function is called after devices inside a PM domain are suspended, to
+ * power off PM domain.
+ *
+ * Return:	0 on success, error code otherwise.
+ */
+static int zynqmp_gpd_power_off(struct generic_pm_domain *domain)
+{
+	int i, status = 0;
+	struct zynqmp_pm_domain *pd;
+	struct zynqmp_domain_device *zdev, *tmp;
+	u32 capabilities = 0;
+	bool may_wakeup = 0;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->set_requirement)
+		return status;
+
+	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
+
+	/* If domain is already released there is nothing to be done */
+	if (!(pd->flags & ZYNQMP_PM_DOMAIN_REQUESTED))
+		return 0;
+
+	list_for_each_entry_safe(zdev, tmp, &pd->dev_list, list) {
+		/* If device is in wakeup path, set capability to WAKEUP */
+		may_wakeup = zynqmp_gpd_is_active_wakeup_path(zdev->dev, NULL);
+		if (may_wakeup) {
+			dev_dbg(zdev->dev, "device is in wakeup path in %s\n",
+				domain->name);
+			capabilities = ZYNQMP_PM_CAPABILITY_WAKEUP;
+			break;
+		}
+	}
+
+	for (i = pd->node_id_num - 1; i >= 0; i--) {
+		status = eemi_ops->set_requirement(pd->node_ids[i],
+						   capabilities, 0,
+						   ZYNQMP_PM_REQUEST_ACK_NO);
+		/**
+		 * If powering down of any node inside this domain fails,
+		 * report and return the error
+		 */
+		if (status) {
+			pr_err("%s error %d, node %u\n", __func__, status,
+			       pd->node_ids[i]);
+			return status;
+		}
+	}
+
+	return status;
+}
+
+/**
+ * zynqmp_gpd_attach_dev - Attach device to the PM domain
+ * @domain:	Generic PM domain
+ * @dev:	Device to attach
+ *
+ * Return:	0 on success, error code otherwise.
+ */
+static int zynqmp_gpd_attach_dev(struct generic_pm_domain *domain,
+				 struct device *dev)
+{
+	int i, status;
+	struct zynqmp_pm_domain *pd;
+	struct zynqmp_domain_device *zdev;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->request_node)
+		return -ENXIO;
+
+	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
+
+	zdev = devm_kzalloc(dev, sizeof(*zdev), GFP_KERNEL);
+	if (!zdev)
+		return -ENOMEM;
+
+	zdev->dev = dev;
+	list_add(&zdev->list, &pd->dev_list);
+
+	/* If this is not the first device to attach there is nothing to do */
+	if (domain->device_count)
+		return 0;
+
+	for (i = 0; i < pd->node_id_num; i++) {
+		status = eemi_ops->request_node(pd->node_ids[i], 0, 0,
+						ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+		/* If requesting a node fails print and return the error */
+		if (status) {
+			pr_err("%s error %d, node %u\n", __func__,
+			       status, pd->node_ids[i]);
+			list_del(&zdev->list);
+			zdev->dev = NULL;
+			devm_kfree(dev, zdev);
+			return status;
+		}
+	}
+
+	pd->flags |= ZYNQMP_PM_DOMAIN_REQUESTED;
+
+	return 0;
+}
+
+/**
+ * zynqmp_gpd_detach_dev - Detach device from the PM domain
+ * @domain:	Generic PM domain
+ * @dev:	Device to detach
+ */
+static void zynqmp_gpd_detach_dev(struct generic_pm_domain *domain,
+				  struct device *dev)
+{
+	int i, status;
+	struct zynqmp_pm_domain *pd;
+	struct zynqmp_domain_device *zdev, *tmp;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->release_node)
+		return;
+
+	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
+
+	list_for_each_entry_safe(zdev, tmp, &pd->dev_list, list)
+		if (zdev->dev == dev) {
+			list_del(&zdev->list);
+			zdev->dev = NULL;
+			devm_kfree(dev, zdev);
+		}
+
+	/* If this is not the last device to detach there is nothing to do */
+	if (domain->device_count)
+		return;
+
+	for (i = 0; i < pd->node_id_num; i++) {
+		status = eemi_ops->release_node(pd->node_ids[i]);
+		/* If releasing a node fails print the error and return */
+		if (status) {
+			pr_err("%s error %d, node %u\n", __func__, status,
+			       pd->node_ids[i]);
+			return;
+		}
+	}
+
+	pd->flags &= ~ZYNQMP_PM_DOMAIN_REQUESTED;
+}
+
+/**
+ * zynqmp_gpd_probe - Initialize ZynqMP specific PM domains
+ * @pdev:	Platform device pointer
+ *
+ * Description:	This function populates struct zynqmp_pm_domain for each PM
+ * domain and initalizes generic PM domain. If the "pd-id" DT property
+ * of a certain domain is missing or invalid, that domain will be skipped.
+ *
+ * Return:	0 on success, error code otherwise.
+ */
+static int __init zynqmp_gpd_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct device_node *child_err, *child, *np = pdev->dev.of_node;
+
+	for_each_child_of_node(np, child) {
+		struct zynqmp_pm_domain *pd;
+
+		pd = devm_kzalloc(&pdev->dev, sizeof(*pd), GFP_KERNEL);
+		if (!pd) {
+			ret = -ENOMEM;
+			goto err_cleanup;
+		}
+
+		ret = of_property_count_u32_elems(child, "pd-id");
+		if (ret <= 0)
+			goto err_cleanup;
+
+		pd->node_id_num = ret;
+		pd->node_ids = devm_kcalloc(&pdev->dev, ret,
+					    sizeof(*pd->node_ids), GFP_KERNEL);
+		if (!pd->node_ids) {
+			ret = -ENOMEM;
+			goto err_cleanup;
+		}
+
+		ret = of_property_read_u32_array(child, "pd-id", pd->node_ids,
+						 pd->node_id_num);
+		if (ret)
+			goto err_cleanup;
+
+		pd->gpd.name = kstrdup(child->name, GFP_KERNEL);
+		pd->gpd.power_off = zynqmp_gpd_power_off;
+		pd->gpd.power_on = zynqmp_gpd_power_on;
+		pd->gpd.attach_dev = zynqmp_gpd_attach_dev;
+		pd->gpd.detach_dev = zynqmp_gpd_detach_dev;
+
+		/* Mark all PM domains as initially powered off */
+		pm_genpd_init(&pd->gpd, NULL, true);
+
+		ret = of_genpd_add_provider_simple(child, &pd->gpd);
+		if (ret)
+			goto err_cleanup;
+
+		INIT_LIST_HEAD(&pd->dev_list);
+	}
+
+	return 0;
+
+err_cleanup:
+	child_err = child;
+	for_each_child_of_node(np, child) {
+		if (child == child_err)
+			break;
+		of_genpd_del_provider(child);
+	}
+
+	return ret;
+}
+
+static const struct of_device_id zynqmp_gpd_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-genpd" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, zynqmp_gpd_of_match);
+
+static struct platform_driver zynqmp_gpd_platform_driver = {
+	.driver	= {
+		.name = "zynqmp_gpd",
+		.of_match_table = zynqmp_gpd_of_match,
+	},
+};
+
+static __init int zynqmp_gpd_init(void)
+{
+	return platform_driver_probe(&zynqmp_gpd_platform_driver,
+				     zynqmp_gpd_probe);
+}
+subsys_initcall(zynqmp_gpd_init);
-- 
2.7.4
