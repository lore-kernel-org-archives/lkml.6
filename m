Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbeB0XZX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:25:23 -0500
Received: from mail-bn3nam01on0062.outbound.protection.outlook.com ([104.47.33.62]:29378
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752264AbeB0XZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:25:00 -0500
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
Subject: [PATCH 2/2] drivers: soc: xilinx: Add ZynqMP PM driver
Date: Tue, 27 Feb 2018 15:24:26 -0800
Message-ID: <1519773866-18196-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519773866-18196-1-git-send-email-jollys@xilinx.com>
References: <1519773866-18196-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39380400002)(39860400002)(376002)(396003)(2980300002)(438002)(199004)(189003)(7696005)(106002)(106466001)(76176011)(51416003)(39060400002)(110136005)(36756003)(356003)(2201001)(54906003)(48376002)(36386004)(478600001)(305945005)(50466002)(4326008)(72206003)(8676002)(2950100002)(107886003)(81166006)(81156014)(7416002)(316002)(63266004)(16586007)(8936002)(6666003)(9786002)(77096007)(47776003)(26005)(2906002)(186003)(336011)(5660300001)(59450400001)(50226002)(921003)(107986001)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR02MB3820;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT038;1:3gPQzS2vVQ/QQXP6C3VTFzOuBMqxiwYuhh4yFT4trplQXEeHMwtb/B9HChGujLYK/cP5ZodN/lMFHRKYQePph6VRbe3f5ywqiXa4Ljt91HiU0pzK4ITJgyfPpqlN6QbH
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4e56737-7e8d-41f5-6d36-08d57e394fa2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:MW2PR02MB3820;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR02MB3820;3:6mpvZZSuke+6CG9iPXEEc9548qYn0rHOmiuVzYs+8qWg/tTTpROaAETYclntUqmYrSp5nnlIK9C5KZQ1L6xhhJaMaIaITfvu0MeoTYqoqgNx6SYyu5R/LjUVyX/xMPKBmnOFQ8h7ElOsZJaLNkVZZQ9tVGnCXcytnFPrN+3FbPxAKsOXTg3s4BhB+WpAWKhbk+lVFbvp2vkjw8EOAcmmxm0DmSFe0CYZAXGJnq0pymscFgHCxRISZLGnv3hPmExMSFDLfQ2Dwply2QUng/ym1+64Bhe5+ilTi6UQXH1PGwvy8Xe2pGgLTEeOcp9f0VEIjuwVMF26Ot1dTOR0b7DLy+8SLVEXPY8TmvFkRM78CMA=;25:XXCC9ayVNff8wzZn+QKixsbAZAq5+huksOAispK04hY5HVfZTqfe5NlmELlqxlyA5ZCh0KG+QsiWjB+rF/9mclbvqrYszxDDLOr9QLTGXfFwBMYhwRCFl/uo6tfFeoLNDmY5gniBSn0Trs8kUcZsiO+W4GRkPt+jxKhpRnzrmzNrSL3jA4o13bIK9J7qM1NSjw2O9QKXUURQ7x5+iysv1FtyydWd9MexaiAEC/AXtoStaSE9vcf0JysFhEEqzuvaZCOllEqtfJIsYiqis6TI+ZVRY798W927RDY5p9i3aLFOfBP4Sl/zTRAcmyy7RTFi0F2WObRzYKIGg82eERSkKw==
X-MS-TrafficTypeDiagnostic: MW2PR02MB3820:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR02MB3820;31:4urmYlo1Wq2AgTlRHJ/uueTTzTmLxQflPeLmWLvgh/E/wNLJKf9kHAC6hT0AHp8iiIhLIJsJQm2ohOkmvbeWEMAtU6WdWWbsEcwS7h2onxE4mTZicErEBAJY0ysKf2JGoV8V54gpHDmD/qX1aAjydotsgULEj0QEx1OZPZ8MYnJ6IJy8LM7ph3iXuuWAVd6KOGHD6wmW6b5C0RlbJ0N329FLX35nT8xaSgqIolmBvJY=;20:0Nii9/zj/G/h5EIS4uZrDRlRp25Lr+WsjFyPV721iAgU6NgMCw59zlHzlDFqVu7bjx1gYhzmgFyrGweQ8+pU1x5OOVX7gyF47xrk1DTeS17JDNXDaTEXgBGFhrhCcW4hb/6dmAbL3RQDCOVUeFfSwRm+l4YWYBq3xUw87kHZ4FUYrxxS+9bbLd0XjI0lEYUDWO9ezZA9Xh69NW1UhulcXms2xIWGEodAjfe3kDWqVtlyEk/xH752XGhUjxLQr4P5jj9pShyaUDpm+cEzHWgxcn71MQjcmJG/rhnajpC5aXjStxNvoq1BVX2+BI9QUrNH8+DOMUQS22a1s1nL9iIKTIwob/lyozLtnvd+H/f94lOK7NQVLjKudwQ8Gr54C0ZVGRQ0hGl6H9hDm//avqEe3nitW/2R7AK2+xGOXhy/VQw6+Fhm9wiwKCo76Ae/Yyy8/ENUuYHFU/n2oxiqoJsDwf4/Z4CLkn/7cQKu41vKJAQOHjJsn3kHFb6mcPu4+Ob2
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MW2PR02MB38203D5F732408AF174F9ECAB8C00@MW2PR02MB3820.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(3231220)(944501208)(52105095)(10201501046)(6055026)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR02MB3820;BCL:0;PCL:0;RULEID:;SRVR:MW2PR02MB3820;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR02MB3820;4:82kPu5vWdhw2OJHk3Y7dQUF4uGsiCQIkXuexz9GO1Pe9O0iGxO4D7KWCSv8XBXJkOJWIeSgajcJ5BA20lirAolJ+hYX0leDOfV0HAaWOOiHwTDAcRtRGsOX5fxaGk/mb9+caJ2bt7yLJIao13yXE5EcblAMhZuDyu3z6L5/pCL4Q1jsrCJT2/Sx11O6cSlRSKWMw+LXIm/x9oknWuefeTKSCKXizWAdbQl64gm5Pe6om/TKT1f+V79PHg9d7gHIiYcLL5pt+kqdJiHBRNijoHTn6EY//mIihtCM4kX0S+PG3i1UZrI5/9EhsRxQoD5EB
X-Forefront-PRVS: 05961EBAFC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR02MB3820;23:0mzttJk6vktzKmBns8q4XdHUCvHjuj99UmD40w1Za?=
 =?us-ascii?Q?X+dL1ccWyB9TEFm/n+xObs4jahu40z7rPe+9s41uLHE9iqTcpWvHbBIzOQPG?=
 =?us-ascii?Q?p1+f13368QEeXsgAhVwdMPeSER/1J/kE3FgaMsYzY/sGGJeNv13SdvLektQB?=
 =?us-ascii?Q?DNZWOZ+Ev9iEvtqHb8XLE0uF0EL7tVQXGv0XYJiwVFH0gdfQN0V9csBsPXW2?=
 =?us-ascii?Q?8KLoJFJyjWam+LXBlHVLhO4q+nIfG8qi+Mg2QuOyrEgIX1SCwiIzklmTl6AL?=
 =?us-ascii?Q?kpGwTthL8lDFYEWPIB4pEhhpgfJZEiBlsO0zMwl3Ht4fPitC7C3QnV6EVg0K?=
 =?us-ascii?Q?uq16QkFfg6SoESdHiAlyPO9AbJoLvENhdXtTMF4NeEnQcPtbabHP+7ms6D1Y?=
 =?us-ascii?Q?se5Ko6LEf82teuccHoV6UE0cHUJq11ER95DazOHjTUg4J+XajaiDD01WvwiI?=
 =?us-ascii?Q?WpIg3jCHOxkjV5rsoPzTeYkgmoryIN6RZ6ada08YYpsAG/p/ki/nfKCktn8E?=
 =?us-ascii?Q?B53HgLhCGg5WoQCMdvaswr5IIOhVeyHKtJJQrlv+Mv8fRuu3JEXO3xII481N?=
 =?us-ascii?Q?+3BTeyfxhrr6LY7VxxgC1tvBo0cUbWXr7M9ZmAjnVVlxrK2xKpffS72dmpD3?=
 =?us-ascii?Q?fEfdHPyQcIwYAapRPNuDjU49pX4+4X6h68wNgZcxwDr9VpOTxTPnY8h81CLo?=
 =?us-ascii?Q?NcedTZA1ZDNbWud59Ra4G3Dvxr17I7ToVIrKeoaKSbf9/85SvUE+j/lAQWnS?=
 =?us-ascii?Q?p994EcdpjYeHYGLCSLYemYYZyXQdmm/nAj3Szf9SU0RwP5QNMbG6Rqjw2/MH?=
 =?us-ascii?Q?AlkvzlSb+n96nrbZ6lGo1LVDx9vCQqNTl6l6cK8rkeySbMc1CCmRs0eAg55j?=
 =?us-ascii?Q?l/702pr/+Y8NGs8TMQztRvJa8pC5t70h2WmFYUUC7Gd0XoKzRsCgdZgZ64a9?=
 =?us-ascii?Q?WS5xNPvhscH1Q92tSz/pQNYl2BX/NlHwvJrgitdw82mf3YlRRd1OnPEChHWk?=
 =?us-ascii?Q?wPNWWpTjZsp11KN+6eTxMjdsFR5uS2DdPVDugYckew0FdU5rRjPf2mPQyR7y?=
 =?us-ascii?Q?Xa38I9c4ezMmEzB8Gd+YoV3wko0ClUaNlkLcfwaFMwYkoeUKE6wmvwe/uEx1?=
 =?us-ascii?Q?Dcw+6Aro6LV99RF38C0YnhXbF25uSxs4nm4x3QjE/qDfrk6cjkVuI5SF5EU9?=
 =?us-ascii?Q?tk+OFfy/N9QlBZM9MHcmGerL6Hnaw/8owp4?=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR02MB3820;6:N2TnaNwwS3lzgOGRRsk3u5SUl68F9MyYE+HNW+v8wARwjA0RcC3dnL5LOl4W06ohJaWvt0fv2HY5G9B4Sa/vOU9QexOaeeDqZec3La6a9ItYklTf5MgIWTvw3Uv0qh1jv5Qt9LqeM4v4zwJ2Mzv5dL05imHwR1dZUkkzGqRVl9KILkfSNfQ0VLtUbTHZPNmC6t9iovPJET/qNFDY8rWBR5lo/JlZNLOQkerdcmDQjLwTLzC+zvsopiyCtM3mEMoPwHgTJlDxVk7Ay1l8LV8P0V1qQZz+lI51tPKN9FaKtQWZIDabLmVlYHn7b4ZV6/bv/FhBg8SJXP6jOsjb+i0o+Gl8WxGIW00DQ2t7oqckguE=;5:oXd2QHMYqHRRws4M9XAAR/5tm05VHUyOtgYPnPacRQUNEJeatbvUBdisZFn/kkUZshyxO+wGSOdAZef2RcoSIWJdlvDEKCwG4i4vM1MPGuVppJnoc0qKm0li3+xEbq+YYH0rF0fTGYP673yZC0IZakiR5ZMY3VZnhLx32juVi8Y=;24:/uKOjUPrw7djXkjNjURpMK5QKyWQB03pmDWiTqFC7W7Ry4FigTWuPyvlS+fEq55+nMUcZOqYSVt3oAwhrAlaGAXx+uCiLtrPIOPWBhi6zwc=;7:tpfsQ9WcPrqXeRGp1CBGCu0vltJJ++1oVBLJwCSSqTDJQRG1oT9YfdBMg1YzJBygtVSTcNPuXZ+dIlVSO+Y+vBIpgRS6xNt4mGx9jatLsW9IvdW71pkJrioimSe8iC/cOKxFFW/Yx+7RoGgo7c2EWB3gRBK8N+bSvzFEFzWKY86k7o2JOuMYA5dn2Zu9l7crjUdTgvWwoJNiO1Ow45lKxUbk10yL/sl+YzF6Z4f9gq6pXLY9ASKRBr+LjMWHg0cW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 23:24:55.1761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e56737-7e8d-41f5-6d36-08d57e394fa2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3820
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ZynqMP PM driver. PM driver provides power management
support for ZynqMP.

Signed-off-by: Jolly Shah <jollys@xilinx.com>
Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
---
 drivers/soc/Makefile                    |   1 +
 drivers/soc/xilinx/Kconfig              |   2 +
 drivers/soc/xilinx/Makefile             |   2 +
 drivers/soc/xilinx/zynqmp/Kconfig       |  20 +++
 drivers/soc/xilinx/zynqmp/Makefile      |   4 +
 drivers/soc/xilinx/zynqmp/power.c       | 249 ++++++++++++++++++++++++++++++++
 include/linux/soc/xilinx/zynqmp/power.h |  18 +++
 7 files changed, 296 insertions(+)
 create mode 100644 drivers/soc/xilinx/zynqmp/Kconfig
 create mode 100644 drivers/soc/xilinx/zynqmp/Makefile
 create mode 100644 drivers/soc/xilinx/zynqmp/power.c
 create mode 100644 include/linux/soc/xilinx/zynqmp/power.h

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 4052357..4d3c099 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
 obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
 obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
+obj-$(CONFIG_ARCH_ZYNQMP)	+= xilinx/
 obj-$(CONFIG_SOC_TI)		+= ti/
 obj-$(CONFIG_ARCH_U8500)	+= ux500/
 obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
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
index 0000000..0313764
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Kconfig for Xilinx zynqmp SoC
+
+menu "Zynq MPSoC SoC Drivers"
+	depends on ARCH_ZYNQMP
+
+config ZYNQMP_POWER
+	bool "Enable Xilinx Zynq MPSoC Power Management driver"
+	depends on PM
+	default y
+	select MAILBOX
+	select ZYNQMP_IPI_MBOX
+	help
+	  Say yes to enable power management support for ZyqnMP SoC.
+	  This driver uses firmware driver as an interface for power
+	  management request to firmware. It registers mailbox client
+	  to handle power management callbacks from firmware.
+	  In doubt, say N.
+
+endmenu
diff --git a/drivers/soc/xilinx/zynqmp/Makefile b/drivers/soc/xilinx/zynqmp/Makefile
new file mode 100644
index 0000000..b1cea09
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Makefile for Xilinx zynqmp SoC
+
+obj-$(CONFIG_ZYNQMP_POWER)	+= power.o
diff --git a/drivers/soc/xilinx/zynqmp/power.c b/drivers/soc/xilinx/zynqmp/power.c
new file mode 100644
index 0000000..8864341
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp/power.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx Zynq MPSoC Power Management
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/compiler.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/slab.h>
+#include <linux/suspend.h>
+#include <linux/uaccess.h>
+#include <linux/firmware/xilinx/zynqmp/firmware.h>
+#include <linux/mailbox/zynqmp-ipi-message.h>
+
+/**
+ * struct zynqmp_pm_work_struct - Wrapper for struct work_struct
+ * @callback_work:	Work structure
+ * @args:		Callback arguments
+ */
+struct zynqmp_pm_work_struct {
+	struct work_struct callback_work;
+	u32 args[CB_ARG_CNT];
+};
+
+static struct zynqmp_pm_work_struct *zynqmp_pm_init_suspend_work;
+
+enum pm_suspend_mode {
+	PM_SUSPEND_MODE_FIRST = 0,
+	PM_SUSPEND_MODE_STD = PM_SUSPEND_MODE_FIRST,
+	PM_SUSPEND_MODE_POWER_OFF,
+};
+
+#define PM_SUSPEND_MODE_FIRST	PM_SUSPEND_MODE_STD
+
+static const char *const suspend_modes[] = {
+	[PM_SUSPEND_MODE_STD] = "standard",
+	[PM_SUSPEND_MODE_POWER_OFF] = "power-off",
+};
+
+static enum pm_suspend_mode suspend_mode = PM_SUSPEND_MODE_STD;
+
+enum pm_api_cb_id {
+	PM_INIT_SUSPEND_CB = 30,
+	PM_ACKNOWLEDGE_CB,
+	PM_NOTIFY_CB,
+};
+
+static void ipi_receive_callback(struct mbox_client *cl, void *data)
+{
+	struct zynqmp_ipi_message *msg = (struct zynqmp_ipi_message *)data;
+	u32 payload[msg->len];
+
+	memcpy(payload, msg->data, sizeof(msg->len));
+	/* First element is callback API ID, others are callback arguments */
+	if (payload[0] == PM_INIT_SUSPEND_CB) {
+		if (work_pending(&zynqmp_pm_init_suspend_work->callback_work))
+			return;
+
+		/* Copy callback arguments into work's structure */
+		memcpy(zynqmp_pm_init_suspend_work->args, &payload[1],
+		       sizeof(zynqmp_pm_init_suspend_work->args));
+
+		queue_work(system_unbound_wq,
+			   &zynqmp_pm_init_suspend_work->callback_work);
+	}
+}
+
+/**
+ * zynqmp_pm_init_suspend_work_fn - Initialize suspend
+ * @work:	Pointer to work_struct
+ *
+ * Bottom-half of PM callback IRQ handler.
+ */
+static void zynqmp_pm_init_suspend_work_fn(struct work_struct *work)
+{
+	struct zynqmp_pm_work_struct *pm_work =
+		container_of(work, struct zynqmp_pm_work_struct, callback_work);
+
+	if (pm_work->args[0] == ZYNQMP_PM_SUSPEND_REASON_SYSTEM_SHUTDOWN) {
+		orderly_poweroff(true);
+	} else if (pm_work->args[0] ==
+		   ZYNQMP_PM_SUSPEND_REASON_POWER_UNIT_REQUEST) {
+		pm_suspend(PM_SUSPEND_MEM);
+	} else {
+		pr_err("%s Unsupported InitSuspendCb reason code %d.\n",
+		       __func__, pm_work->args[0]);
+	}
+}
+
+static ssize_t suspend_mode_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	char *s = buf;
+	int md;
+
+	for (md = PM_SUSPEND_MODE_FIRST; md < ARRAY_SIZE(suspend_modes); md++)
+		if (suspend_modes[md]) {
+			if (md == suspend_mode)
+				s += sprintf(s, "[%s] ", suspend_modes[md]);
+			else
+				s += sprintf(s, "%s ", suspend_modes[md]);
+		}
+
+	/* Convert last space to newline */
+	if (s != buf)
+		*(s - 1) = '\n';
+	return (s - buf);
+}
+
+static ssize_t suspend_mode_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	int md, ret = -EINVAL;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->set_suspend_mode)
+		return ret;
+
+	for (md = PM_SUSPEND_MODE_FIRST; md < ARRAY_SIZE(suspend_modes); md++)
+		if (suspend_modes[md] &&
+		    sysfs_streq(suspend_modes[md], buf)) {
+			ret = 0;
+			break;
+		}
+
+	if (!ret && md != suspend_mode) {
+		ret = eemi_ops->set_suspend_mode(md);
+		if (likely(!ret))
+			suspend_mode = md;
+	}
+
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR_RW(suspend_mode);
+
+/**
+ * zynqmp_pm_sysfs_init - Initialize PM driver sysfs interface
+ * @dev:	Pointer to device structure
+ *
+ * Return:	0 on success, negative error code otherwise
+ */
+static int zynqmp_pm_sysfs_init(struct device *dev)
+{
+	return sysfs_create_file(&dev->kobj, &dev_attr_suspend_mode.attr);
+}
+
+/**
+ * zynqmp_pm_probe - Probe existence of the PMU Firmware
+ *			and initialize debugfs interface
+ *
+ * @pdev:	Pointer to the platform_device structure
+ *
+ * Return:	Returns 0 on success
+ *		Negative error code otherwise
+ */
+static int zynqmp_pm_probe(struct platform_device *pdev)
+{
+	int ret;
+	u32 pm_api_version;
+	struct mbox_client *client;
+	struct mbox_chan *rx_chan;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->get_api_version)
+		return -ENXIO;
+
+	eemi_ops->get_api_version(&pm_api_version);
+
+	/* Check PM API version number */
+	if (pm_api_version <= ZYNQMP_PM_VERSION)
+		return -ENODEV;
+
+	zynqmp_pm_init_suspend_work =
+		devm_kzalloc(&pdev->dev, sizeof(struct zynqmp_pm_work_struct),
+			     GFP_KERNEL);
+	if (!zynqmp_pm_init_suspend_work)
+		return -ENOMEM;
+
+	INIT_WORK(&zynqmp_pm_init_suspend_work->callback_work,
+		  zynqmp_pm_init_suspend_work_fn);
+
+	ret = zynqmp_pm_sysfs_init(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to initialize sysfs interface\n");
+		return ret;
+	}
+
+	client = devm_kzalloc(&pdev->dev, sizeof(*client), GFP_KERNEL);
+	if (!client)
+		return -ENOMEM;
+
+	client->dev = &pdev->dev;
+	client->rx_callback = ipi_receive_callback;
+
+	rx_chan = mbox_request_channel_byname(client, "rx");
+	if (IS_ERR(rx_chan)) {
+		dev_err(&pdev->dev, "Failed to request rx channel\n");
+		return IS_ERR(rx_chan);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id pm_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-power", },
+	{ /* end of table */ },
+};
+MODULE_DEVICE_TABLE(of, pm_of_match);
+
+static struct platform_driver zynqmp_pm_platform_driver = {
+	.probe = zynqmp_pm_probe,
+	.driver = {
+		.name = "zynqmp_power",
+		.of_match_table = pm_of_match,
+	},
+};
+
+builtin_platform_driver(zynqmp_pm_platform_driver);
+
+/**
+ * zynqmp_pm_init - Notify PM firmware that initialization is completed
+ *
+ * Return:	Status returned from the PM firmware
+ */
+static int __init zynqmp_pm_init(void)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->init_finalize)
+		return -ENXIO;
+
+	return eemi_ops->init_finalize();
+}
+
+late_initcall_sync(zynqmp_pm_init);
diff --git a/include/linux/soc/xilinx/zynqmp/power.h b/include/linux/soc/xilinx/zynqmp/power.h
new file mode 100644
index 0000000..001d832
--- /dev/null
+++ b/include/linux/soc/xilinx/zynqmp/power.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Xilinx Zynq MPSoC Power Management
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#ifndef __SOC_XILINX_ZYNQMP_PM_H__
+#define __SOC_XILINX_ZYNQMP_PM_H__
+
+#define ZYNQMP_PM_MAX_LATENCY	(~0U)
+#define ZYNQMP_PM_MAX_QOS	100U
+
+#endif /* __SOC_XILINX_ZYNQMP_PM_H__ */
-- 
2.7.4
