Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966257AbeE2SX1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:23:27 -0400
Received: from mail-dm3nam03on0083.outbound.protection.outlook.com ([104.47.41.83]:40208
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965954AbeE2SXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:23:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v8 1/2] iommu - Enable debugfs exposure of IOMMU driver
 internals
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Tue, 29 May 2018 13:23:14 -0500
Message-ID: <152761819480.2654.5371070582955429468.stgit@sosgrh1.amd.com>
In-Reply-To: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
References: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0601CA0011.namprd06.prod.outlook.com
 (2603:10b6:803:2f::21) To DM5PR12MB1450.namprd12.prod.outlook.com
 (2603:10b6:4:d::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1450;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1450;3:X8n79YCAg6SorqacExifWydAPzstDblbb6NMDmD6FfmpEwAmHUW0+msz4YPYIXM2DRcn9PUPQDm6NMslSPIa0M5gKNHzCccDCVHTtmv2vVsiY3CRtU6Yr9oaeKIqQXZLTl3/9Y53Js8KR9CLcaI8IWR9KaWBEqfVtBSlvEsrTbPgsXMRiIV/UTH5zcwZCmx9WD4mbW+fgiVJmcpiGRUZqFj2WxOlyBY04+VB2xfQDAmp4GUkOiyRS83zI36PzPXp;25:80AbH03rd5ZWWsqGVDgDSYZ8GjmGGOqS/HDVG+4GmWzkNKSHBzRUTavwW6h9W03MUBAknRA0KT1x/LFLxGE4GwLrui08k3VssdugLdNkRA20n+NNzKu/IxhpwciipYnRPLwh7/f6tYClAv2KEquQi5czYv1U9/dEcjCcekYz4zVMio/HbcSKVx5FVINrAX6SfCuNbTfRoiu+0DxfUc95QsecepXlYZxvRsdoQ6GXJEP0HnjfbFbaOvktKDaAUz/W5J8k+nF/iwdT+Z4dflObbKKuXdPmdedKvm8XG386/1w6XU1zPL7xa3YZXRPer0A3GlFOjYYZ7rMRGdT1EK4yHw==;31:Wlzkf/3ur4+eyik7KiFM3gmWgUAfOB5xnDSDzo1FKlqBvKLkF1AAz+WmXdwj0J8f2P3UzXfju/qmYutnAiO5NwXH6zzXEgG8vhWcUEbgm0OIRrS3PNx9TX/ifLhU91iKD1KyJgPCL9tUULb0XEXAt5GcyMuvrHD/FTg1FV/fb+r+yP/vfG7WQINsBJLG7P8PWlpVbsE5MczyK/oVeUzJVdhp1qfIeXp5f6uA6KCdVZQ=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1450:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1450;20:B+OcPety7vIEpCq4CqTAQX5/R7qOYqJC4j9elb6QhdvWg7ZNTPCOoblNFqLpU7UspoPOjlQCDPlJY7aaANRLZxLi9LGHjiaGh+tqOLDEeJGBoEQLCUgnulyNr1wEOho/qv2wPyjFrf9EDCMxsJ5qBmCnWq3EGRQHJWxtnJPSV+awtQN4ThftblBS9RfGEekTMm3pM6fgUXgdIZ3n+7Z7/zHqMiiXv//FI1ROt+U5iYY64rrKd7zn2xVb7omnmILsxbbacft6aVZlufdMS6y3L7PuR3Vp0R+uU99KsXB+e0wQxA1LNILHlPkQpRVjouBvm6zApjhE6zYHPmON4LC/xDHKUi7NsFmFYUs+3QVWOKEBVGpFocCg5eWrHZ4VfbS9im+QKOpnSZtebTHdGfiSQbpiNc76d8K8KzZr3Gx90iDfTUalii0sNw+Mv7Kp6jOQp+cD849FwRtopowrf9XDNitvs/Yyud3wLK3CMDLmph2v+Ywbobi47r7vbfcwBhtb;4:L8NRsPS2a6H5dH7HrCLVxBjCgist+l4Oh8NwiQJAIgkZ4NG4MRYtvFfTkC6DVtRfjWLv1ptrkIvNFiWEiZruVsRugh7dxzD5ZWbgGRphkNNXMvVLXrs+OLMBnle5Smohon7dkFHOc2Hb0wMQtl5SdaTRxNzTK+phJWRjtsTtNNmVT3YpQb7yK9ksnsaTJEMSCRQC1/jLHrNXY9NHp9zYr+61WryxBMN9g0OXTw7j8isDc75rVFJN49gouKIkqPNgpdmV0FiYYw8QTTePAF6Cp90b0nPCK6vh0HHUadhhH5oKo2zo5nmQhGFsFl5Osy+OGhRv0BuRooj9qH7COlDOEq+aaihMTdWxKJsICvjl1rE=
X-Microsoft-Antispam-PRVS: <DM5PR12MB1450AFF49B9D21ECEAE7EDD0FD6D0@DM5PR12MB1450.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1450;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1450;
X-Forefront-PRVS: 0687389FB0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(346002)(39860400002)(396003)(366004)(189003)(199004)(106356001)(956004)(476003)(4326008)(50466002)(81156014)(81166006)(316002)(8676002)(53936002)(446003)(26005)(11346002)(16526019)(186003)(2361001)(2906002)(25786009)(68736007)(103116003)(8936002)(2351001)(230700001)(486006)(3846002)(6116002)(66066001)(386003)(575784001)(72206003)(86362001)(97736004)(5660300001)(6666003)(6916009)(47776003)(55016002)(59450400001)(105586002)(53416004)(7696005)(52116002)(76176011)(23676004)(305945005)(58126008)(7736002)(2486003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1450;H:sosgrh1.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNDUwOzIzOnJvNmRldkk4Q0Y0RWt1VFh2TU5CUk9GdTlV?=
 =?utf-8?B?a3g5MS9VUVlOQ3RYbkZpSCtXNVNiOUdOYm0wY1pzRktIMFdpKzVaVUcrdzkw?=
 =?utf-8?B?RzAvcWN1TWJtZG9QaEswZUNnNEd0RDVlOXZnTWlHaHlmVmRkWWtha0pZOVBD?=
 =?utf-8?B?N2M4U21RUlBYMDZmYU04c21GeGQ0SDR4anpIcDRMOWJaQ1BxVzN1OE83WDJn?=
 =?utf-8?B?ekZ3SW5CNEZyOUV4S2tRZ1pPcGxpb2oxd2tISWxYVks5aW5BZThBWk10N2JK?=
 =?utf-8?B?MU45VWljODlqc05reGV4SlRQQmZtdFBISEJSZnh0OTVqdXFyUURLTGtNZEtl?=
 =?utf-8?B?Q3Q5clBveEZMQzhmTjJGTTc1U0RLMG52clpKWXVra0NoZXhZTndtNS9adC9E?=
 =?utf-8?B?YWxVeE5JdS9xS3Y2TVNGYUtxMjJDYnVvN0oyZHJ3c2I0ODkwY0hFczNLVWE5?=
 =?utf-8?B?dDFhRE9jblpmeWZraS85SEY3UXBQcW53M3R1M0NYUkJRZVd0bDIyaENvckpV?=
 =?utf-8?B?T3IxQzhLM09nbCtWZWhOd3R4ek5hMFZnaUNVOTZmV0h1cEVBT29UUXk2Tkhw?=
 =?utf-8?B?TzRGdnNsOXZ0WERWcG1EWjRMc3c2TFJjYm0wTmZFb0dvenVaYnA4dXJ0QnZq?=
 =?utf-8?B?dHB1STRtU2JYcUhVdnVsL1NNaTVoWXhucmx3V1Y2allFek5iNk1OSHZHUDR0?=
 =?utf-8?B?ZlZ2cmR4Y3ljT1F2aTN5K3R2SXllQVlpa29SamhLR0I3WElEdDNkSXNOK2lX?=
 =?utf-8?B?ZXJtQUFJZHlNVDZQMU0vUEZNbVlORWU5cDFqVzhmUmttYnBWeVVPU3RnWjdr?=
 =?utf-8?B?SkxDM0RZY08xcXV3NzE4Tnc3OVk4Nkt3bXV0M1k0ZEFlSWVQa1FvYy9HOHZU?=
 =?utf-8?B?K2J4WVpzYS9sVVd5Q1c1cWhtU0xERzJTK0ZSUVh0c3JTN25Ta2xBUFQwR1BU?=
 =?utf-8?B?VVM4cHJvaW11dURFbmdjdnZwQnIyK081TmgzTE54bmo1bEkrYWloWk45Rldz?=
 =?utf-8?B?Y2FuZ2ZyOHZraE56bTM2QkZ2ankzcmZ1SHJTbWJ6OTJLYXZiUXpxeEFKS0N1?=
 =?utf-8?B?YVJSZzZtS29yRGhCK3Y1aVNsSEZVWlpzQzAyUHZ5Z2p3VFAzUlZHMzRubEMr?=
 =?utf-8?B?QjFuYXZOczhORGZZTzcrYkZ6S3R2TkxTMWpHL1V5RTJVZlRnZ21tbWtmWkFs?=
 =?utf-8?B?dU85a2dOL0tFcWZPdXpZTlF5MDhsZUJ0bGtIaEZiYTdCblZIV3pYekpTUUpR?=
 =?utf-8?B?bnFMaUptdmMvTWtONSsyc2ZxdVJkc2VrZHFlT3NQQUNvNGlKaks5VzRUWHBq?=
 =?utf-8?B?VkxYc2treEJUL2IzTDVJOGMrNWJpQm1FWUsyUmRnZHZUamxYZC8xTXN4dDdN?=
 =?utf-8?B?N2M1enpwWDlrMzliMUdLVHJ2eVFpdXJxRGlYT2Q2TUNhM1p1MVZuNkhMcVYz?=
 =?utf-8?B?MHlyTk9wRUpOb3RGOU5xN2dXcUVMcTZ0eVJKL1RYZXpyZlRMZDc0UXJQSXNq?=
 =?utf-8?B?czd4NGsvcm5TY0NuUGgzNEdiWmMvblBwRVBtbTRyS0xkWGVQdjNiV3BGNmdK?=
 =?utf-8?B?SUcxRmxwb0dBS2FnU25oOUVUc3kvZ3JkUjdxcEdDLzdXZ0ZOM0ZEQnpqVkUr?=
 =?utf-8?B?eDdzazEwcWNEMENRRUdVdlFPVHFScmI2ditnY2IyOVd2TkUrbWNYMTA5WXc1?=
 =?utf-8?Q?0uh4BDmEGBOLi/r0M/STmPaiabqFCz3sRbSoMTe?=
X-Microsoft-Antispam-Message-Info: 1uD8lQHe4QZOFUhv6ApK339ycMhCDu9UZPvcoCTEfhr1wQb/SaFLCC5RiuKStARlEe7OoAznzwzaiaP3LD+2unphHhOz3mIEOorsujvwu0RGEQhgJ97VFt2+LJL1Cqey1gWcsHUFH3lm6iyLwKuM0UzXQvsHcH+ynwAvDdDYuARTH4NNub0TaLF/brks+Udr
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1450;6:CFCH+W2mj9aAue5dPpzjubtKV6Xu/4KR6BdxbTz1l79NItNou2y7QEYAsKZ3wFWbLJnau9PpaWnxHBazXeUI4HKAD0RPs6zWWQ4c+dsCVG0BAk19Jp0+KdVZYE3Ea1y6caInC6aAEerq5ViyonV9V10q3anQG0iV/7brwgC3tqZG3ZHRUT5kVuK3Um/omjzjwGqeYIao+OR59MPwMId4Js5aHv/6EuGyfxiYb8iQj05CHJ3CNFjSb93FyzNeddDIFge+5nGYoLqsNeVLPNKmEg1pVFA9BeVhFzY+4o17iSf5uIcUbRfQfx/UOo7xPVQrRudGE5mCl2qjvFvurZ4eX+fpTCsYXlm224lRjiVSVGapJY9il9MDo5Cqk/3MX78XqtTah4Gml1Uobvd/UXD9GJ2aPiyhHyAUcHC9d4C9mFLABdSVRXvtBZJ6moyKy6L87wFE0QSjRf+wRnw429n4eg==;5:Ddefa+eUbUN7Btivk7Pd3QDegGBGjIoBxi+Wl2+7juVpSLcod60OYTb6A/5qmALJRoM1GQ9y/EJ2TQP6WKr5L6WsXinUfqDmsKjWBgPjdWSAV/Valq0Yf05RzT1gmpB0H71RP77R3uim+pVLQlCawzS4/ZCeOagnirQwsfAIPd8=;24:LU64EGjw5sPFQ7jLYSDB8FizOiNRChviiifT5D7oN+nm6AgIsdxWr8fYXW9+8qPp1SivF2kW/RdLZL75DXF/n09Bx7iRjqpBRlbHcRjTmRE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1450;7:kFD14mni5a6Z8uJbLiztrj7IYnx2cGZ2w2v16Zv48IRUCRdYUK9NcEbjzryhW/BSOplzHbg030Ym7vUPx4pIMVm1RA0JmEKJn5jT99ZKDuhAbutXVgdOgBXrEJUg9niMvgXtfga0kraidiOwYIjXPNLU2+RiBvyb5cypGQr6hb4sxIUTs4IjiP8gI5t/ZP9SkvV1Fgsm5m5p0cHsdAhqcceMBGaB4x9k5qi69ohMvUhlqhvHjH1WTyJNbyBTPZy6;20:+s5l/Q4YejBfRqgRX3rPgOpZ5m1ZYSbtYiDMQrpST42n67sscFBEdbMk280aY22dr6xbvpWv79NrX8pGMMaHR1vDU6A8NqaCplGkaRuUBZ50KQQ/T5TdD3EKXJbaC8CsHHLZq9hGozPa8bQNXtT2yDKLGaY+MZ2Mc+Vuxe4AOLjdDwoLHkMqTJAGsrFzxjrGfDbT5g98ShYHIsLI/1qSJ2O+lkjZ4IUXeosyBEwg3/BRuXZQzIBjwj5Iwbd/RBCs
X-MS-Office365-Filtering-Correlation-Id: 597b4143-f135-4a4d-a205-08d5c5914060
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2018 18:23:18.0828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 597b4143-f135-4a4d-a205-08d5c5914060
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1450
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
 drivers/iommu/Kconfig         |   10 ++++++
 drivers/iommu/Makefile        |    1 +
 drivers/iommu/iommu-debugfs.c |   72 +++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c         |    2 +
 include/linux/iommu.h         |   11 ++++++
 5 files changed, 96 insertions(+)
 create mode 100644 drivers/iommu/iommu-debugfs.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c76157e57f6b..f9af25ac409f 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -60,6 +60,16 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
 
 endmenu
 
+config IOMMU_DEBUGFS
+	bool "Export IOMMU internals in DebugFS"
+	depends on DEBUG_FS
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
index 000000000000..bb1bf2d0ac51
--- /dev/null
+++ b/drivers/iommu/iommu-debugfs.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IOMMU debugfs core infrastructure
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
+/**
+ * iommu_debugfs_setup - create the top-level iommu directory in debugfs
+ *
+ * Provide base enablement for using debugfs to expose internal data of an
+ * IOMMU driver. When called, this function creates the
+ * /sys/kernel/debug/iommu directory.
+ *
+ * Emit a strong warning at boot time to indicate that this feature is
+ * enabled.
+ *
+ * This function is called from iommu_init; drivers may then call
+ * iommu_debugfs_new_driver_dir() to instantiate a vendor-specific
+ * directory to be used to expose internal data.
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
+/**
+ * iommu_debugfs_new_driver_dir - create a vendor directory under debugfs/iommu
+ * @vendor: name of the vendor-specific subdirectory to create
+ *
+ * This function is called by an IOMMU driver to create the top-level debugfs
+ * directory for that driver.
+ *
+ * Return: upon success, a pointer to the dentry for the new directory.
+ *         NULL in case of failure.
+ */
+struct dentry *iommu_debugfs_new_driver_dir(const char *vendor)
+{
+	struct dentry *d_new;
+
+	d_new = debugfs_create_dir(vendor, iommu_debugfs_dir);
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
index 19938ee6eb31..0933db261b9d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -698,4 +698,15 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 
 #endif /* CONFIG_IOMMU_API */
 
+#ifdef CONFIG_IOMMU_DEBUGFS
+void iommu_debugfs_setup(void);
+struct dentry *iommu_debugfs_new_driver_dir(const char *vendor);
+#else
+static inline void iommu_debugfs_setup(void) {}
+static inline struct dentry *iommu_debugfs_new_driver_dir(const char *vendor)
+{
+	return NULL;
+}
+#endif
+
 #endif /* __LINUX_IOMMU_H */
