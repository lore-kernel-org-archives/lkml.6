Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbeEGUCM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:02:12 -0400
Received: from mail-sn1nam01on0056.outbound.protection.outlook.com ([104.47.32.56]:14628
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752389AbeEGUCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:02:10 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v5 1/2] iommu - Enable debugfs exposure of IOMMU driver
 internals
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Mon, 07 May 2018 15:02:03 -0500
Message-ID: <152572332370.3235.16541462864315443906.stgit@sosxen2.amd.com>
In-Reply-To: <152572281179.3235.11484188869064303333.stgit@sosxen2.amd.com>
References: <152572281179.3235.11484188869064303333.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0501CA0094.namprd05.prod.outlook.com
 (2603:10b6:803:22::32) To BN6PR12MB1443.namprd12.prod.outlook.com
 (2603:10b6:405:10::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1443;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1443;3:pCLlALJJTLsvym9Pc82ee1xPuGngLVvYlTJENJOh625mOYdatJGbXLF6W1HhnKEDs19Sw15xAZaDllCOF7u6zKagZMNWiCPhCvWV916vRlt6IYmCtf2ZKrEQQWwmJOepsDkTAuOBaphBKkczNiVm3vlYBDwFy9Oy1zSa63QudlfDIBk4p9YFVaqkJ7OYcFfLfGdqnTHNB3iiPfiVGHSYrUznrmIwbmGFJVE1fyk/SN9AV9r2h3PZKcwkdRO/2efv;25:Gua9EXbh3ynx8446RT6GSHkJRTvi41SbvuUXpZn5xU0b9AapHW+dLBvz0vXujZUyiUrzD9rIX1jfv4qbhlnN6U81p2CoOBbWXCXjO6v9AIaQnYAFzR/uqERupYWxuOiXf62VqRByohWkt8ERe/vl/mQFI8azgI2nzRut/RQMefmh15uQsIGIGTGIjJbPgoCdzj1Pjyr61wHokMmkkDFmpJ7vLi2uL2dWHAS9eQYYvjcxKN1lPv6YOwKC5s+69GvFIdD5MAxg4gZuyD1JofvwmZ6I9Gbp8f80m8yg5uRLeL1mpYkJqWbka2zAjWZzKiW5H0B5sAUSmqd2EygNs8EZ5Q==;31:mS2K/8L8iKlEB3BT539dtnTLfrzkrK5ppRXGRXJbalzdIa/+Wpn2XhEoDP6oiD24cSfQB+s5YVfvF04SakVAPn6+tUCmsDTkreMAdpkfu3vQuPszZK6I5VQRz2Av45LywBZ+OZQ4B61nILEcwPERvnOs18tHaXWglvT5n0hLtRq8wS/yiew+qsUnXtnAmQiXd8XFPjI4WKHU0hTfABtgdyaFFuwSAkt4WxfWqe14IrY=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1443:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1443;20:youQr1vZJLiveTttGs+UeTQO+WReoifw4FA6hYOhHkeB+m0ik6l2NRNrVLk9/YZOBGBkgsOeEm5oGZkJtAvP4K68fWFgCiV2gQyslna32W2EmKFpTon76CEKq7Yh5WaRdL4U+abiWBOCleqWYKUv1AbEYPt9oekAbZslgqCdOYTev+g0Sg3AtGU22/2ufirwSH/aiJnJKns3FYU9VdiRBukUh/KclmabIQAKcLLmFFZR+aXv2EqX6wdkXM5L5k+vP81xc5sjjwHS23+3Wg9bgXeKUeiA6pSJOaawJoTrH1CkqBHJK1OmlH8wvUuRIEqlx2g5qm/z+95S2fforrwVaxNfe+apAV1pkFHhg5CssVS7D8nOcVA/KMCvjc/q6VST5Qt1QylMPEXv5i3bMhfXWIC2GnJ7ZCUkrQt4GHJGD7eHMwxGOA1/e338/LmlJuXMr3Htk71h8Y7AWjnjOk69p4umYAgmHoczj3jZn8I+C4LbVBDtEgCm6JEw5BVvD9U/;4:ibAtrf7tf6FFmbtgdonYBxLqAj2XWxyi9WItnvQX8o49kPJn4Bn11pvmUhcATeGo2Z53Ea9vcTA09/bPZ7kyEHX79ge+p/wou/LKbK5oNnpdvSHA+xsNSP8dtTFBwnmpXCCgBfLML94zPE8vSiwA5xMPzcxg1w0aWv/evBcy5od9IZkoW9rZhaxBYzSQY1b2hLHSJrriSa6l6TvJY5/z85PF4D7XHXxn7fDhJ/mO5grFj1J3Esp29zjYJZTh9Yr0vBL7KPXqEs4coBEMQufGDZE7UC902aoayy17oS7Aure62canvqyvZafsRa4Qn0dWLjhVutLUfeSGIMAdWO4sEw==
X-Microsoft-Antispam-PRVS: <BN6PR12MB1443944B4B0E77F1D9FD99B8FD9B0@BN6PR12MB1443.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR12MB1443;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1443;
X-Forefront-PRVS: 066517B35B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39380400002)(39860400002)(376002)(189003)(199004)(6116002)(8936002)(81156014)(81166006)(8676002)(2906002)(66066001)(50466002)(106356001)(2486003)(52116002)(2361001)(2351001)(53936002)(3846002)(23676004)(7696005)(305945005)(59450400001)(956004)(55016002)(97736004)(68736007)(230700001)(486006)(386003)(478600001)(316002)(72206003)(7736002)(47776003)(86362001)(105586002)(4326008)(5660300001)(76176011)(103116003)(6916009)(6666003)(53416004)(26005)(11346002)(16526019)(58126008)(446003)(25786009)(186003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1443;H:sosxen2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNDQzOzIzOkhQL2paTFl1L3YyaEk1cXpjcndoUUp2dldk?=
 =?utf-8?B?MDVDNFhPQisvaGV6cXlkR2ZHblpGWkhxL0M4Y21oMjExdjlzZTR1QWROcTRo?=
 =?utf-8?B?QnQvb1RqVC91U1lnL25qMC9TdzhsdHRKcTlKbnZNZWkrQWk1ZjNyQWwvV2NB?=
 =?utf-8?B?V0NRSnVoQWp5bFI5dHBFR0FIUFhuODBoY2RkWTk3N3UvOEpYQ2xPbU1kUjdl?=
 =?utf-8?B?SWlid3pHc1c1NDNNVVNBNnR0VHcxa1NQRGRWUUVNcVp2bkRqUjl4WndSTTU5?=
 =?utf-8?B?VnJ1Wkk0WTA1WnNCZFVlbkowQ0dLZ1FtWmR4WHNxODY4SEMxTXJuSHhpdHE0?=
 =?utf-8?B?RjgvcVgxcWpFQnhMaDVYMjRjaXFjbGNuYkJDTm5tS1RGRzFUWGphNm95aUtx?=
 =?utf-8?B?TXdKNXFpTnFEWWkwY1NkNFJVM0pudHdCbEd1SHNkWTE5OVNYa3RjL3JFcDAr?=
 =?utf-8?B?Qk5WdEEwVU53b2hwOU9JZlZmWHB3SU44a3FpSmgyM2l5Q0VIbWtHMklMaWYv?=
 =?utf-8?B?ZXJFcTlaM1dsZVZ3c2pYNjh2TDllWGFMa244QVk3R2tmaE1PTXhVQkdyZ3NP?=
 =?utf-8?B?RXl6cWM0TUtiRDBPWUpCN0Vvb0ttbnp0T0lRVSs4cEx3RHh6c3l1Y1ZJdktQ?=
 =?utf-8?B?a25mWnRoOEFGMk8vcXdnckQyZFJaQ0tVcXZzTkZVQUtTdjk1ZzhRbWMzbExV?=
 =?utf-8?B?dHZFY2t4RURCbHZ5RU15YjdVK2hFOXFtVC9ZYU45c1kwWEpWNHgyTE9KR21u?=
 =?utf-8?B?TzZldzBSeDlGQ09BK3dBVXU5TmgvelFyV2JlQUlicFVESmJlOUdKZ01xa08z?=
 =?utf-8?B?dUhEeXJJNThINGZDaUZpK05ZbGZqeVpBaHlXRkVOQlFCVTNUelV1SVJCV2t5?=
 =?utf-8?B?VVdldXVZcW5xS214OTk1Qm1XYWp2QlpFMWYxVFBoUFhKQmNkL0d6YVhOcDY3?=
 =?utf-8?B?Vk5FeUxtRXFmRWdBZWtSZVJsKzEzSWtJQkRETDR1c1haUjBBMVpPNWFrQmQx?=
 =?utf-8?B?aFBUbTN2dllvSTRQSDFoZFhPZUdPUjBndGl1a0tvaUwzNVJvYWMrVlNzOWFW?=
 =?utf-8?B?ZkwyUDlJb2FBejFENW9oUnI3WW9qYnVxR1JnM0RWUmE2bGt1TURMdi9BK2RW?=
 =?utf-8?B?K25zMDlFaERPUmZnODJkOUJWVUFkUUtPSHltSCs4WTIwM3loY2lBSmNZeXYz?=
 =?utf-8?B?dVJ3V3JPcXAzckRqaDhib3pCSjdQK0gyZDd2MGhndlhnek9iL09uMG4wTWFF?=
 =?utf-8?B?ZjVyZ081U3lLTi9HM2krWXBWZkl6TVRsQ2hGOWFjZDFwdDhEY0JkNmFxWmlw?=
 =?utf-8?B?bVNOWi9sMEFiN2l5YzJZZVU5eU8wOHZ3STBMRWovckI1ekRWTUY4V0ZrWm1q?=
 =?utf-8?B?ZWdtNHg2MVY4QXdSRzRDRk44L1VNTzhzeEpjcE1jTjhxUGdqNXkwSW95ZUZC?=
 =?utf-8?B?NVJoV2N1elJmSiszdGlpMEFyc1htTzZ1OEJacGNNMWFpeE95QzBmSEFZUzAx?=
 =?utf-8?B?NWllRHp0S1JtZ1hrVTlYY3p6UGFveUVuNG5DL3ZOOU1nQXJodlRuSWYycUlZ?=
 =?utf-8?B?NzV2WG40R0RpRERqWGdQZk0rMGdEcUQrekl1eWU1RWpGaEZnaDA1T3gwQWZh?=
 =?utf-8?B?c0t6b2NlZmlMSDBFOWVPNmtuckRITFcwSnVhdXNjSlhZTnc1WEZMUnh1VXhZ?=
 =?utf-8?Q?vDol3OMpNBVg+kVsKA=3D?=
X-Microsoft-Antispam-Message-Info: pfjOFnOw/WVT/okPE9cQKiimU9tse3pjQaLxlWrbeG1SJyinZSX2W6Sn3A+QhOR4dprgU0PfohYQIgtHhipX+pZEaPyg228upVJ0L08g0l0q24aYUGU7EnnT2JFxfc7GICefeUjisTwE9ILssOwdtk4Amb8M+Pl3+iH5ugQ+m91/BJ3erhTzXOUR0F2IqHgG
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1443;6:8iwcMyg8AOvI6nVSKsLTkB8A2cKE4/0O822/ezgWXZsSeyYywkW6tF9RRLME90yAPpFQnZCIk81XHOHTtbLROlS0lGxcJ9PZzFJUmJe2o46FLli9mM2k25ps3bxTg+AaCWQpYsic27kgoawvmlZifX1xfqPQg0bsuCQEbxqrUNO+Jhe2lg0PYGb4H3UQstNNMyDs1F1/oK20k4O3JTe0Z9IOTPBh+ftfaxb2s+3pCpKHe8nF+Ru7zEZfhu/r/jyHPJ5V3SXGl8zQm3KQaHRhkUZh88ZehL6kZn9oPeN1qOa7p6qMbTdHdZNkdtEPoe1oUBEf3SVpBjAeFKQLduH/BwqjzHmADrBzzzmX4CSbBV+y9CCnt4dQz766C7P7VEgcVuh1kdGUGKzM1aSNPhjP7PEKHZA+zujuPVvyI4JOI+CHEy9+8V80BvgPTU6NErk+6Cavx/r8OLIA3LpvATbyxg==;5:/6lRwIJW4B/5Et5iF1DrxJXkeGLM4OUzaV05Py32K2SE3udRJL/+nv1FoDToRyVSgJczb10ygj+hl0MmTqaFxYN85YPv0k75tYOzxdnRXc/AelG5kSpU4N4FU2fQssAAKhGWupY43z8tkVFpklMdeRVtyM5iNTnCCASyJoMGkN0=;24:8ezF3FDyHMKAJKNLJKVEcp9Fm3qVzpRjWtCU5ESPcnaTNzok81bDE0jwymcO6nX+HnV8ffn/13emKW1Up2k+d7KOwVk8GWXd+vOGMUGf30g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1443;7:GQpR9ausbHtcLn/R8gOFEtRg4FK0la7VrsDVqMjl/tpzFZVX74HcIzoG6FmxVvmJmwPN1IFMMGBW6wEzvJWRngdIELGbNf+q/pjC0uf4TJuWhOX83T6t1qVfBdz/x7q5rQW9mIXFryvA8HlaXAq7L8c/536QbDPzfxXWlAhpidMBS5EafF9WOePUBL6LLHQduiCoMXHRKzI0WWUznwzMf4e23j4r8sNJp8H5kjIltfSCiHZ/d3pWij54y1YXNp6G;20:yJQu/JC5mDl92N3CEy228MuxDhB5w8bul/xqAI8VIoktj8eastJijQPaFberhGYGdlwjpUGFmrXA5CDp/DYNgNtmL8QBCIV/M2HniSEMTxoMUrI9ag8eIzWnIOqZKqqa/Ql43+FQ4H8Kicdr4eUdXDeIH6DYzsU89HQsDqoPMWLLQrmYoIZuw4oUL3ooy2RPY6VAWLywnF3T7/7ZUbQdhD3CXcMgXFwFL4iibeTbJQWw8wLs3NzxPGepv1oqWGly
X-MS-Office365-Filtering-Correlation-Id: 2ce30de7-b18d-43d4-188c-08d5b4556959
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2018 20:02:07.1836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce30de7-b18d-43d4-188c-08d5b4556959
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1443
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide base enablement for using debugfs to expose internal data of an
IOMMU driver. When called, create the /sys/kernel/debug/iommu directory.

Emit a strong warning at boot time to indicate that this feature is
enabled.

This function is called from iommu_init, and creates the initial DebugFS
directory. Drivers may then call iommu_debugfs_new_driver_dir() to
instantiate a device-specific directory to expose internal data.
It will return a pointer to the new dentry structure created in
/sys/kernel/debug/iommu, or NULL in the event of a failure.

Since the IOMMU driver can not be removed from the running system, there
is no need for an "off" function.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/Kconfig         |   11 +++++++
 drivers/iommu/Makefile        |    1 +
 drivers/iommu/iommu-debugfs.c |   64 +++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c         |    2 +
 include/linux/iommu.h         |    8 +++++
 5 files changed, 86 insertions(+)
 create mode 100644 drivers/iommu/iommu-debugfs.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f3a21343e636..ff511fa8ca7d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -60,6 +60,17 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
 
 endmenu
 
+config IOMMU_DEBUGFS
+	bool "Export IOMMU internals in DebugFS"
+	depends on DEBUG_FS
+	default n
+	help
+	  Allows exposure of IOMMU device internals. This option enables
+	  the use of debugfs by IOMMU drivers as required. Devices can,
+	  at initialization time, cause the IOMMU code to create a top-level
+	  debug/iommu directory, and then populate a subdirectory with
+	  entries as required.
+
 config IOMMU_IOVA
 	tristate
 
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 1fb695854809..74cfbc392862 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
+obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
 obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
diff --git a/drivers/iommu/iommu-debugfs.c b/drivers/iommu/iommu-debugfs.c
new file mode 100644
index 000000000000..d82a10b2478b
--- /dev/null
+++ b/drivers/iommu/iommu-debugfs.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IOMMU driver
+ *
+ * Copyright (C) 2018 Advanced Micro Devices, Inc.
+ *
+ * Author: Gary R Hook <gary.hook@amd.com>
+ */
+
+#include <linux/pci.h>
+#include <linux/iommu.h>
+#include <linux/debugfs.h>
+
+static struct dentry *iommu_debugfs_dir;
+
+/*
+ * Provide base enablement for using debugfs to expose internal data of an
+ * IOMMU driver. When called, create the /sys/kernel/debug/iommu directory.
+ *
+ * Emit a strong warning at boot time to indicate that this feature is
+ * enabled.
+ *
+ * This function is called from iommu_init, and creates the initial DebugFS
+ * directory. Drivers may then call iommu_debugfs_new_driver_dir() to
+ * instantiate a device-specific directory to expose internal data.
+ * It will return a pointer to the new dentry structure created in
+ * /sys/kernel/debug/iommu, or NULL in the event of a failure.
+ *
+ * Since the IOMMU driver can not be removed from the running system, there
+ * is no need for an "off" function.
+ */
+void iommu_debugfs_setup(void)
+{
+	if (!iommu_debugfs_dir) {
+		iommu_debugfs_dir = debugfs_create_dir("iommu", NULL);
+		if (iommu_debugfs_dir) {
+			pr_warn("\n");
+			pr_warn("*************************************************************\n");
+			pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **\n");
+			pr_warn("**                                                         **\n");
+			pr_warn("**  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **\n");
+			pr_warn("**                                                         **\n");
+			pr_warn("** This means that this kernel is built to expose internal **\n");
+			pr_warn("** IOMMU data structures, which may compromise security on **\n");
+			pr_warn("** your system.                                            **\n");
+			pr_warn("**                                                         **\n");
+			pr_warn("** If you see this message and you are not debugging the   **\n");
+			pr_warn("** kernel, report this immediately to your vendor!         **\n");
+			pr_warn("**                                                         **\n");
+			pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **\n");
+			pr_warn("*************************************************************\n");
+		}
+	}
+}
+
+struct dentry *iommu_debugfs_new_driver_dir(char *name)
+{
+	struct dentry *d_new;
+
+	d_new = debugfs_create_dir(name, iommu_debugfs_dir);
+
+	return d_new;
+}
+EXPORT_SYMBOL_GPL(iommu_debugfs_new_driver_dir);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d2aa23202bb9..350819f1c5e1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1747,6 +1747,8 @@ static int __init iommu_init(void)
 					       NULL, kernel_kobj);
 	BUG_ON(!iommu_group_kset);
 
+	iommu_debugfs_setup();
+
 	return 0;
 }
 core_initcall(iommu_init);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 19938ee6eb31..6bdfe942068b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -698,4 +698,12 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 
 #endif /* CONFIG_IOMMU_API */
 
+#ifdef CONFIG_IOMMU_DEBUGFS
+void iommu_debugfs_setup(void);
+struct dentry *iommu_debugfs_new_driver_dir(char *);
+#else
+static inline void iommu_debugfs_setup(void) {}
+struct dentry *iommu_debugfs_new_driver_dir(char *) {};
+#endif
+
 #endif /* __LINUX_IOMMU_H */
