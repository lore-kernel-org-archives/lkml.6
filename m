Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbeE3U6M (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:58:12 -0400
Received: from mail-bl2nam02on0056.outbound.protection.outlook.com ([104.47.38.56]:18496
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932316AbeE3U4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:56:10 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC: <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v7 02/10] firmware: xilinx: Add Zynqmp firmware driver
Date: Wed, 30 May 2018 13:55:17 -0700
Message-ID: <1527713725-1086-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
References: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(2980300002)(438002)(189003)(199004)(39060400002)(11346002)(77096007)(16586007)(59450400001)(36756003)(76176011)(7696005)(51416003)(575784001)(186003)(26005)(54906003)(2201001)(5660300001)(50466002)(476003)(2616005)(47776003)(7416002)(316002)(486006)(126002)(110136005)(44832011)(9786002)(426003)(336012)(356003)(63266004)(478600001)(81166006)(48376002)(8936002)(81156014)(6666003)(50226002)(8676002)(446003)(2906002)(305945005)(72206003)(107886003)(106466001)(4326008)(36386004)(106002)(921003)(107986001)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0201MB1443;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT050;1:q3ieMQ/iQtKv4BRvgl5yx1VdhqbQ9kdHK4b/KJqVwf8cwGKoV+nPuYHzsV0lslKmGQApB+3v428ejFOIvIuXZJ72ASXrE4sadGpp1BBucgVI7v83HzJbl0tvuhXEAQjT
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BLUPR0201MB1443;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1443;3:Y4qei1jOI4qRP4E9LGrNO/3UgjIyM+Ju6zfoC8hyhMBJ6cxq7/xaSE9zeHM6bljouJ97NSEx9thPWo5Fx0lB+qs4AmH5yYyOw8pZOiCMCz0kbur1TZydAKD8Mtv3MSvra6sKO/7AQs7CqZei7zul7lhoZTw4wgiWtuht0gr3Vcm1q26gB8KNCXOd9jXHqMIop8qtQ+Fu/dglJXf5YPEu/OW59KtxcEjW4uOo88ZCwr/fP4kH0YsRBcAQeyAWWcIYag86htNX7fFdnwwYbUGZjtbTGzo63fSoabPl2P8K4SLEP9xrSKrffIae7mzfTyGVaIGvF3EDv0cM9HJ3l8GH/N5RUgnF8QzynBm8R7TEbYE=;25:X7xQDHfwsD/jindLL82P9uGRruy95hHwd3xOtfLdyUZ68537B/6aq3MzqG8QyzEqY9O7/wtB/Qpi+AYo4UhIYeIi+f3oF6WFdDrpHsSeYnKUFgWWZ1Cvl6M8p2Iz/L2qcMMwkpfbCWgUUYcnAvi//83eXl3dJCxjCF43XGxEFEemn7USlj0BvZpaflGcJOmdnnLnR3kZAPuwEF6M3bxLjuQjWYlIm8xIVppk/El2mlC3XnFmI6EBMd+RkwiPVZ18WQQchHgAJBivJr+1IZ9+zTkvDkcfgHzlTPeVjvymTh1NOZYm9iuKGQKJCWlyjz12MDzqZcJlr2d+K9WlqG6Oeg==
X-MS-TrafficTypeDiagnostic: BLUPR0201MB1443:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1443;31:lqLO1QH4Llf/rQV4989Rf7tzNoBWJmF39pLnGvl2GsrKxgzSpkat4sTym5N4rqPWE1sZJ496Fmbgu/+CrbdWWtmDWpAM/Ovc7NTfe4orKIe823RDzbenSzZUNKLad7HSV5q9+RrRzbiA796kUTpRDscZRucSL4tu56CQfptPMxwntsblx1sWBz2dMN6Gh199FQHO1TJ/HjSRsjlZx8L6w2kKSBWUmrsq8wPEs2gnRUA=;20:gzfOZy6ZzfVT7/ZIDED1gk7Lv86FT50xCLMwxvIJPCAl/LdpDLvxnYQ4ww0tXwhfr0YezLJqlcGarNkx8C/sB+LFt9pxsLv09P+kHL8sUlH/R8PPJltX0UO5MdXKIK2uOeREHPfmf9LxO39VzLw3GAV/hrLU0T6m92hWo54/Dxu2OW01h5ZAJd5aAOsqZ1V39HD9z+fyC/6Uqn89uhimaH9iS/dCga9Hlphm2Gr5zuLN6n057tejqFYmaQ3JoOL98R1E5XqouSRYV2BO+herCfJ3WIWGeRfui90le4tIutNnCUp+EIFb11NYTaMwpbqQrtsNMcPw/aM8knUeJXt9Ce57EGC5b1iYCg7stBP3yJ/+1kl+EmkrO0vJgug9TjqyPRIzvPVgHL39H/gGtNnxbbGnwrHiLB1bvJ+fnz71UWRvmGz5iXaLgC+di7FMVXylPBLBf1Ur1+3L5vBL8c+13Xzk6cZLDLsLB2gy9RFjkjsqclDHR7cclgiincSoZq8A
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR0201MB1443B8B2E98D84A3437BCF0AB86C0@BLUPR0201MB1443.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BLUPR0201MB1443;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0201MB1443;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1443;4:W61HwYLR4/IyIWSfffUUZqn+fXDg41hSOJ77X4y3B3s2jOxGapx+1mK5eQKHt8ZvOLVuj4zlAQWQgqFc5SdXetRHQg1oz8PLfPdVl5HLQ9lQx43FgoV9yjrJqkWl6wOuV+Wu/eCL013mXyKopfmc76VowHdavTOY+Q3OMm/7lrgLunyK3CnpwKPXo64lvPf9G4ckCu3E5LHApytkUsaqYq2z0hDy5GrL2jU4n32BpBBRw6YmUS7NZbBXbn8MOPzbNwYms+4Bm6fHD6yml0eaf7I8ivl7VesjD6WbJ6hWCb6f0BXctKrxgwsLBvaLJ+T8
X-Forefront-PRVS: 0688BF9B46
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0201MB1443;23:lwDUY1ZQQQKmx3OUSJWdW2+mqkC1pEN9gmeXnJX?=
 =?us-ascii?Q?WkdrTb1KEJTWLrq9UrFbHGrmQOFMRR+Zg2M0f/q/SxYbbWXCLwiTadfMvTbQ?=
 =?us-ascii?Q?bG+VReaqEnSE4WSNCxtldOYvlmGaxdiB2AwDjagt1/DG0CdFI2nlvLygGQQT?=
 =?us-ascii?Q?yKal7o3QDSATuulh3ynCPbXDOLAzowYJSDDKgAxGz4gqPqKoaq+yZmhFqy3O?=
 =?us-ascii?Q?Zc0nbJUpWulHFWhmLt2b7f+QPsp3Hq9KJsfRgIgskYpHHcPq1SK6Vbdmbw8i?=
 =?us-ascii?Q?MsJbFpmt08IfhSuIPdX7RTU37H/qmP9a93xIMcgy8LNnuyPBY1W5TkzLAxUJ?=
 =?us-ascii?Q?hg9ePvo0nRr3NPof/mrwy8m1C6PN48SXsuj4z7aeghC2gjPEqH5vPKWxG831?=
 =?us-ascii?Q?4fIoA4owdUwNv7TNcyLdvAfuWFfOlGG+DPSF3b8MFY6nwpEW2FeX5nj7r5oB?=
 =?us-ascii?Q?td6QForwkvmyArPRjhYkC495EPsfsfs/Tvi64B5o3bFuupE7h4voBNAdt/34?=
 =?us-ascii?Q?JlM9PJhrKTe5x9x8RrcsnSoEQTZi4Rlypbmgtr67kjLW5DoEJwUmBwsYmLkH?=
 =?us-ascii?Q?HXHltzLNvA1ih6Py0EM/72dJkmUsEt3xwE20u+jsYelZq4NtsPQVQZIveLOe?=
 =?us-ascii?Q?i1hY8hed3vhpZJXAvX5g14k6WXuZMbKSEDWXQX/Fa7aK3wfg/YEjmXlpnkba?=
 =?us-ascii?Q?z/cX4wAS8oyK8JixrJqs6n25ceFH26lZ3u51GV8lu30k2KIglj5SNG+g81nv?=
 =?us-ascii?Q?fD4MSo7nlbMNxufPfobZnrrvMuMyeIjiuqrdZ10DDLjYQ+GJ7hCglQSXcuSG?=
 =?us-ascii?Q?3emOlPh6Jh6OT/+TPb3a3TnR26tgGkI9gkRNxUaXvKASkR1oCRVwHR3ODnem?=
 =?us-ascii?Q?IxoVTJDcFG+OPt9Gjcu3iYdiTf0nHbdfOvDfEatAe/eshxKZt0YpLKrQ8zmH?=
 =?us-ascii?Q?iZYQDMTQPbs1y/RQuVjTVM/RQ2haONmkeceSUzhbPtlgcO1wiJEPO9YRSlI6?=
 =?us-ascii?Q?33dh6C1wT3yxmmbJdC/y+1GcKXv1J1rU4C9tzRUM2AMds2GTH7naug6ZPPlG?=
 =?us-ascii?Q?dymjIkdLZuFvZHXvKtl8xOvd/22NPWO30Af7bzExe2R+7Uc0tPFeeFhjNF4z?=
 =?us-ascii?Q?RYVR+czdQlUFK/KVrlZJomrHqhPSMY4CLMoozmSp6wlbGxbSGJM4mXG9JG9L?=
 =?us-ascii?Q?sOJo2BaxOmHIioeJ6Xcw4YP4djrF+B8kJiZHvcPpa4fQ/n3OPon70aS/Yigz?=
 =?us-ascii?Q?/GzNiiWBA0makP3tXHxlBDpzi8yp8BWB+o8jDF+3EtOKE2fmOu1MoR7YP9TT?=
 =?us-ascii?Q?GTAqs+2nljXhtgGpYwyl85Qfsn2Fv6zfTqWPg5ELaZtit?=
X-Microsoft-Antispam-Message-Info: /DDUIJrl1BtGSSSr15Hk/hgtsP+BBORu7kzTSpDivM+KS3J6nwGVwx45MhejYIh6yI9ka7t0OixRCd9hFdJ+ZSGn6C0YQy9IbffNoBpJl7KpAx1fXYhx65RDZeUKUM0E4uCW7Ji/iAH2E2dcZ7dNlOw5Z2ZRdIT/PECoItARXo7hb3DBLHPT7XGSCk2M2p7t
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1443;6:xQDVb+YjKv0E2mmAzRPnxbi6PEYgYGcmBJE8LFkfC2/VPyzj4/obAFEC/qw8F/9pqfz7fCzbkYjD0dYKMjDDN07PM1LofujzYW2WJ4VCje3+uiRBIxZDv2eVxZCy/rBqXjZ6fu40vDfpZIqiJiBNyvESNqDuiVHr3+Lvx04Ch4OYjaF8bfm276zzAg9S63vSayi982M4ZMfrG4zCrBt4WcXp5okUfHZDk4o6YjFxxQjGAEVGpIaqO2uZ+nXXzhusH6zGMA4ebp5BcKYzSRQfnJpydQU0/6dypsP5UIhWI1SsHH1mO0TzT3o8H6Oo82hNMTjBhD7eDTYsmZUdTur6/v7D+3yiZKKlrfyPH4sGRSB6+Bxrn1r9v7YtZQ039QLGE+WVW34ILCYGcN/b2G6s+VSdTG/naiIav78727zbZptPtvbbUFtWUNO9lrutHG5ZouM51RQ0HNoEv8ZPCjQ3EA==;5:5ITlBmAlFNRNp8ae8RFS285fLcXRAX4k9QKkI4qXbiD1uOH2Q85QrN5yb3gxin5JQ9MK1UmS1X5yHeIp0Q+9PRpsi4uYxmDXAQlLlasv5gf/XMKOjxkrbefTR6ev06gHouJ88rARKWYWR61pOcDYWUc5Z95xQAfKa2GeG6FfjDM=;24:DwiqUfoExvgG20LGEYNHzWsg+6uaRk4TGYkWjREeXhc9Alr5FJFVhOtCkxvkLcRcru9dpeukvTd4qKvdAUnW/ydvBCpSGV+DG5b9wVwgpjo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1443;7:lamOlJQPgfx5/yA8zaEKXX7kEuWA/+9JOSpxgkEq4A5AWMyhP0vRW+zYPqgHdyB9SsnQFbNABVv3PdkMeh2JW+FaimzTWgnAwQBQIYQuVsZ5+O53sMjbdL3ZEvSMU6fHnLBWq/+cEDZed2XYOzcsreOdjz8YAV4bTE2R0bAPdlN2GC/L5baq0728Wx5iigPRNJEo1eWkLPRKat3Qqc8RMVm3X/OVnc5EwAyQhbZRFlsOOyC55osm6uRbN/zsW70B
X-MS-Office365-Filtering-Correlation-Id: ea8fee2c-378d-4b00-5608-08d5c66fc2a7
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 20:56:04.4083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8fee2c-378d-4b00-5608-08d5c66fc2a7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0201MB1443
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

This patch is adding communication layer with firmware.
Firmware driver provides an interface to firmware APIs.
Interface APIs can be used by any driver to communicate to
PMUFW(Platform Management Unit). All requests go through ATF.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 arch/arm64/Kconfig.platforms         |   1 +
 drivers/firmware/Kconfig             |   1 +
 drivers/firmware/Makefile            |   1 +
 drivers/firmware/xilinx/Kconfig      |  16 ++
 drivers/firmware/xilinx/Makefile     |   4 +
 drivers/firmware/xilinx/zynqmp.c     | 337 +++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  63 +++++++
 7 files changed, 423 insertions(+)
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp.c
 create mode 100644 include/linux/firmware/xlnx-zynqmp.h

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index fbedbd8..6454458 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -274,6 +274,7 @@ config ARCH_ZX
 
 config ARCH_ZYNQMP
 	bool "Xilinx ZynqMP Family"
+	select ZYNQMP_FIRMWARE
 	help
 	  This enables support for Xilinx ZynqMP Family
 
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b7c7482..f41eb0d 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -257,5 +257,6 @@ source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
 source "drivers/firmware/meson/Kconfig"
 source "drivers/firmware/tegra/Kconfig"
+source "drivers/firmware/xilinx/Kconfig"
 
 endmenu
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index b248238..f90363e 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
 obj-$(CONFIG_EFI)		+= efi/
 obj-$(CONFIG_UEFI_CPER)		+= efi/
 obj-y				+= tegra/
+obj-y				+= xilinx/
diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
new file mode 100644
index 0000000..cce4e4f
--- /dev/null
+++ b/drivers/firmware/xilinx/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+# Kconfig for Xilinx firmwares
+
+menu "Zynq MPSoC Firmware Drivers"
+	depends on ARCH_ZYNQMP
+
+config ZYNQMP_FIRMWARE
+	bool "Enable Xilinx Zynq MPSoC firmware interface"
+	help
+	  Firmware interface driver is used by different to
+	  communicate with the firmware for various platform
+	  management services.
+	  Say yes to enable ZynqMP firmware interface driver.
+	  In doubt, say N
+
+endmenu
diff --git a/drivers/firmware/xilinx/Makefile b/drivers/firmware/xilinx/Makefile
new file mode 100644
index 0000000..29f7bf2
--- /dev/null
+++ b/drivers/firmware/xilinx/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for Xilinx firmwares
+
+obj-$(CONFIG_ZYNQMP_FIRMWARE) += zynqmp.o
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
new file mode 100644
index 0000000..70e335a
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/compiler.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/**
+ * zynqmp_pm_ret_code() - Convert PMU-FW error codes to Linux error codes
+ * @ret_status:		PMUFW return code
+ *
+ * Return: corresponding Linux error code
+ */
+static int zynqmp_pm_ret_code(u32 ret_status)
+{
+	switch (ret_status) {
+	case XST_PM_SUCCESS:
+	case XST_PM_DOUBLE_REQ:
+		return 0;
+	case XST_PM_NO_ACCESS:
+		return -EACCES;
+	case XST_PM_ABORT_SUSPEND:
+		return -ECANCELED;
+	case XST_PM_INTERNAL:
+	case XST_PM_CONFLICT:
+	case XST_PM_INVALID_NODE:
+	default:
+		return -EINVAL;
+	}
+}
+
+static noinline int do_fw_call_fail(u64 arg0, u64 arg1, u64 arg2,
+				    u32 *ret_payload)
+{
+	return -ENODEV;
+}
+
+/*
+ * PM function call wrapper
+ * Invoke do_fw_call_smc or do_fw_call_hvc, depending on the configuration
+ */
+static int (*do_fw_call)(u64, u64, u64, u32 *ret_payload) = do_fw_call_fail;
+
+/**
+ * do_fw_call_smc() - Call system-level platform management layer (SMC)
+ * @arg0:		Argument 0 to SMC call
+ * @arg1:		Argument 1 to SMC call
+ * @arg2:		Argument 2 to SMC call
+ * @ret_payload:	Returned value array
+ *
+ * Invoke platform management function via SMC call (no hypervisor present).
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
+				   u32 *ret_payload)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+
+	if (ret_payload) {
+		ret_payload[0] = lower_32_bits(res.a0);
+		ret_payload[1] = upper_32_bits(res.a0);
+		ret_payload[2] = lower_32_bits(res.a1);
+		ret_payload[3] = upper_32_bits(res.a1);
+	}
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
+}
+
+/**
+ * do_fw_call_hvc() - Call system-level platform management layer (HVC)
+ * @arg0:		Argument 0 to HVC call
+ * @arg1:		Argument 1 to HVC call
+ * @arg2:		Argument 2 to HVC call
+ * @ret_payload:	Returned value array
+ *
+ * Invoke platform management function via HVC
+ * HVC-based for communication through hypervisor
+ * (no direct communication with ATF).
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
+				   u32 *ret_payload)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_hvc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+
+	if (ret_payload) {
+		ret_payload[0] = lower_32_bits(res.a0);
+		ret_payload[1] = upper_32_bits(res.a0);
+		ret_payload[2] = lower_32_bits(res.a1);
+		ret_payload[3] = upper_32_bits(res.a1);
+	}
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
+}
+
+/**
+ * zynqmp_pm_invoke_fn() - Invoke the system-level platform management layer
+ *			   caller function depending on the configuration
+ * @pm_api_id:		Requested PM-API call
+ * @arg0:		Argument 0 to requested PM-API call
+ * @arg1:		Argument 1 to requested PM-API call
+ * @arg2:		Argument 2 to requested PM-API call
+ * @arg3:		Argument 3 to requested PM-API call
+ * @ret_payload:	Returned value array
+ *
+ * Invoke platform management function for SMC or HVC call, depending on
+ * configuration.
+ * Following SMC Calling Convention (SMCCC) for SMC64:
+ * Pm Function Identifier,
+ * PM_SIP_SVC + PM_API_ID =
+ *	((SMC_TYPE_FAST << FUNCID_TYPE_SHIFT)
+ *	((SMC_64) << FUNCID_CC_SHIFT)
+ *	((SIP_START) << FUNCID_OEN_SHIFT)
+ *	((PM_API_ID) & FUNCID_NUM_MASK))
+ *
+ * PM_SIP_SVC	- Registered ZynqMP SIP Service Call.
+ * PM_API_ID	- Platform Management API ID.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
+			u32 arg2, u32 arg3, u32 *ret_payload)
+{
+	/*
+	 * Added SIP service call Function Identifier
+	 * Make sure to stay in x0 register
+	 */
+	u64 smc_arg[4];
+
+	smc_arg[0] = PM_SIP_SVC | pm_api_id;
+	smc_arg[1] = ((u64)arg1 << 32) | arg0;
+	smc_arg[2] = ((u64)arg3 << 32) | arg2;
+
+	return do_fw_call(smc_arg[0], smc_arg[1], smc_arg[2], ret_payload);
+}
+
+static u32 pm_api_version;
+static u32 pm_tz_version;
+
+/**
+ * zynqmp_pm_get_api_version() - Get version number of PMU PM firmware
+ * @version:	Returned version value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_api_version(u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!version)
+		return -EINVAL;
+
+	/* Check is PM API version already verified */
+	if (pm_api_version > 0) {
+		*version = pm_api_version;
+		return 0;
+	}
+	ret = zynqmp_pm_invoke_fn(PM_GET_API_VERSION, 0, 0, 0, 0, ret_payload);
+	*version = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
+ * @version:	Returned version value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_trustzone_version(u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!version)
+		return -EINVAL;
+
+	/* Check is PM trustzone version already verified */
+	if (pm_tz_version > 0) {
+		*version = pm_tz_version;
+		return 0;
+	}
+	ret = zynqmp_pm_invoke_fn(PM_GET_TRUSTZONE_VERSION, 0, 0,
+				  0, 0, ret_payload);
+	*version = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * get_set_conduit_method() - Choose SMC or HVC based communication
+ * @np:		Pointer to the device_node structure
+ *
+ * Use SMC or HVC-based functions to communicate with EL2/EL3.
+ *
+ * Return: Returns 0 on success or error code
+ */
+static int get_set_conduit_method(struct device_node *np)
+{
+	const char *method;
+
+	if (of_property_read_string(np, "method", &method)) {
+		pr_warn("%s missing \"method\" property\n", __func__);
+		return -ENXIO;
+	}
+
+	if (!strcmp("hvc", method)) {
+		do_fw_call = do_fw_call_hvc;
+	} else if (!strcmp("smc", method)) {
+		do_fw_call = do_fw_call_smc;
+	} else {
+		pr_warn("%s Invalid \"method\" property: %s\n",
+			__func__, method);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct zynqmp_eemi_ops eemi_ops = {
+	.get_api_version = zynqmp_pm_get_api_version,
+};
+
+/**
+ * zynqmp_pm_get_eemi_ops - Get eemi ops functions
+ *
+ * Return: pointer of eemi_ops structure
+ */
+const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
+{
+	return &eemi_ops;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_eemi_ops);
+
+static int zynqmp_firmware_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	return of_platform_populate(dev->of_node, NULL, NULL, dev);
+}
+
+static const struct of_device_id zynqmp_firmware_of_match[] = {
+	{.compatible = "xlnx,zynqmp-firmware"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, zynqmp_firmware_of_match);
+
+static struct platform_driver zynqmp_firmware_driver = {
+	.driver = {
+		.name = "zynqmp_firmware",
+		.of_match_table = zynqmp_firmware_of_match,
+	},
+	.probe = zynqmp_firmware_probe,
+};
+module_platform_driver(zynqmp_firmware_driver);
+
+static int __init zynqmp_plat_init(void)
+{
+	int ret;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
+	if (!np)
+		return 0;
+	of_node_put(np);
+
+	/*
+	 * We're running on a ZynqMP machine,
+	 * the zynqmp-firmware node is mandatory.
+	 */
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp-firmware");
+	if (!np) {
+		pr_warn("%s: zynqmp-firmware node not found\n", __func__);
+		return -ENXIO;
+	}
+
+	ret = get_set_conduit_method(np);
+	if (ret) {
+		of_node_put(np);
+		return ret;
+	}
+
+	/* Check PM API version number */
+	zynqmp_pm_get_api_version(&pm_api_version);
+	if (pm_api_version < ZYNQMP_PM_VERSION) {
+		panic("%s Platform Management API version error. Expected: v%d.%d - Found: v%d.%d\n",
+		      __func__,
+		      ZYNQMP_PM_VERSION_MAJOR, ZYNQMP_PM_VERSION_MINOR,
+		      pm_api_version >> 16, pm_api_version & 0xFFFF);
+	}
+
+	pr_info("%s Platform Management API v%d.%d\n", __func__,
+		pm_api_version >> 16, pm_api_version & 0xFFFF);
+
+	/* Check trustzone version number */
+	ret = zynqmp_pm_get_trustzone_version(&pm_tz_version);
+	if (ret)
+		panic("Legacy trustzone found without version support\n");
+
+	if (pm_tz_version < ZYNQMP_TZ_VERSION)
+		panic("%s Trustzone version error. Expected: v%d.%d - Found: v%d.%d\n",
+		      __func__,
+		      ZYNQMP_TZ_VERSION_MAJOR, ZYNQMP_TZ_VERSION_MINOR,
+		      pm_tz_version >> 16, pm_tz_version & 0xFFFF);
+
+	pr_info("%s Trustzone version v%d.%d\n", __func__,
+		pm_tz_version >> 16, pm_tz_version & 0xFFFF);
+
+	of_node_put(np);
+
+	return ret;
+}
+early_initcall(zynqmp_plat_init);
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
new file mode 100644
index 0000000..cb63bed
--- /dev/null
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#ifndef __FIRMWARE_ZYNQMP_H__
+#define __FIRMWARE_ZYNQMP_H__
+
+#define ZYNQMP_PM_VERSION_MAJOR	1
+#define ZYNQMP_PM_VERSION_MINOR	0
+
+#define ZYNQMP_PM_VERSION	((ZYNQMP_PM_VERSION_MAJOR << 16) | \
+					ZYNQMP_PM_VERSION_MINOR)
+
+#define ZYNQMP_TZ_VERSION_MAJOR	1
+#define ZYNQMP_TZ_VERSION_MINOR	0
+
+#define ZYNQMP_TZ_VERSION	((ZYNQMP_TZ_VERSION_MAJOR << 16) | \
+					ZYNQMP_TZ_VERSION_MINOR)
+
+/* SMC SIP service Call Function Identifier Prefix */
+#define PM_SIP_SVC			0xC2000000
+#define PM_GET_TRUSTZONE_VERSION	0xa03
+
+/* Number of 32bits values in payload */
+#define PAYLOAD_ARG_CNT	4U
+
+enum pm_api_id {
+	PM_GET_API_VERSION = 1,
+};
+
+/* PMU-FW return status codes */
+enum pm_ret_status {
+	XST_PM_SUCCESS = 0,
+	XST_PM_INTERNAL = 2000,
+	XST_PM_CONFLICT,
+	XST_PM_NO_ACCESS,
+	XST_PM_INVALID_NODE,
+	XST_PM_DOUBLE_REQ,
+	XST_PM_ABORT_SUSPEND,
+};
+
+struct zynqmp_eemi_ops {
+	int (*get_api_version)(u32 *version);
+};
+
+#if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
+const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
+#else
+static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
+{
+	return NULL;
+}
+#endif
+
+#endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4
