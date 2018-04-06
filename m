Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbeDFNRy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:17:54 -0400
Received: from mail-sn1nam02on0067.outbound.protection.outlook.com ([104.47.36.67]:58976
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753116AbeDFNRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:17:51 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v3 1/2] iommu - Enable debugfs exposure of the IOMMU
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Fri, 06 Apr 2018 08:17:44 -0500
Message-ID: <152302066417.47565.4017200105445420643.stgit@sosxen2.amd.com>
In-Reply-To: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR14CA0027.namprd14.prod.outlook.com
 (2603:10b6:404:13f::13) To BLUPR12MB0691.namprd12.prod.outlook.com
 (2a01:111:e400:5951::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d40ba646-1d84-4b6d-b959-08d59bc0cad9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR12MB0691;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0691;3:LMUK2ARFpXbV68Q9VVjITinRimJG9gR7jRQ8Eqtu8IIJEFT5N9ykezXBSHdNDKF+sxXUXkDjfaSZyAb2QDR+rzWLkQrWx1ZQ7Omq+WDsJZlRYijH4Yj39NJaU0X8SFm7v0lVuCClxyWLJ48nEhv2MBQi/yftlQ8gBQ0f6DCKOrKUyjvJDwmgyMXoA5w8GPuT7XenftZcxBmwWH42t/vpOxSwwJwyoYoeGuE7uGr71yQ9ka02oWaWdvxEStsnpotY;25:gdc5iEKXye3uIb3gj99YQE8FFW1Dq6ndxif4Td8PMHFeda84NtrjP/nRGr8jFIu0XZFwxTuDZj9/H7L6WvTMYnIfrGJT6IB8IARAIz2/r7OvGCIYhQ9+wxW9DRiZuB5dl6LgAHOuntH0YzGKHTANLVlPqvxmbHi9m01DH1enBiRvYADCyY6lL1Wa3naTNhFkVseYeLSzW+pGe0oLUwNsW8f5hdbMfRQA4l/4mGVJxUv7gglXB6kpwAaw3Nh4OPbFmPU888ssLYbbL+IOYQn+yUUcfgPrThETZf186rABqo7DZAC0kAtMycj7XtE36o9OyCsiu3hmFD/g60s0hsStPg==;31:xlK8fXFZmakxeXs1bGG8AxBAe4IOdhmcV4VhS9n5miLhE6wM6NPiqnnh+7QtOKqNzuVRylSYs2YmbmB5Xmz41QOBxFg2KsfGVN9dBioIvWhGOpwdhwBmmhljWRHn9ApweNZLPGrld4KMuLPKpL/4agcnHm3PdHTvHqoHVFnDRc+3CHxz28iLwF2RVvbNE7PNFckNwytNLZEbfv87oCe63K7YolutgBIB30knFhvJDoA=
X-MS-TrafficTypeDiagnostic: BLUPR12MB0691:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0691;20:6083tdWm999R54zUkcRGiJGvMnmn2sJJfk3i3pELDHMXDBAVsqymIStbDhecvI1nqgtfnWA6rjPl7H4U1TKlcfDLgbd/dflCqX9jFuBZyQ9ym9gyF+6InldL2oYxYLnoVb3hBS91ySxEXnp70KbG9hCYgMqJOd7MwxrloJPGIYRjJ7sRTSqvUWVk27GXjmTKreO/8t9PL2lK6+RTsNks/U/ibgsWh6nhlbysqP/qnVHK8WtcoGtbuFpL/QWsOxWaOsRmZyLcxI0+QnC/erg8d8SURu/C6uY9ZM4BjgvMqNmDz+EUftcueYe2zOOhEYqYVjXopT5WUKyyj0FJDCGGLcyGamxx4ksVKU5He5w7sX1Z7FhA3kJf25qApU9ZVeH2NIKfHEb6xUw382jt9iJTTAdZWpoq3c+Yqmcjrf9b+5wzFY0xUORpm2YVcK9mqbBtPduWplft7WCP9z38Y3enZi9yb2JnnELJB9eGmejjSZdt3gzzKadjgdl0prQDee7o;4:1HKKH1sTtWu5WUD/CQZeDMCL/Iij9AH0TlEfyBdR2QXkgSNw/Yx8HdGCVjjg2TGp3uDqATGczbxL6upjdAWwO9+lYdpGA8eysoGVqG7CTikCMSN6wKkCuXp6sq1+CUI2CUMvS4ENz9c+AL8kP670E7PxX2nlo1Bqk+4ANCgkKL35G2L5qhG3umei5eacSaTqPTehP48/Eqv9PDkNa5VeUQrZsxrVBmdWSBGXLZc6CLD4YFSZJmyIgfvmzvCLwIPg2Yq4CJediqG2bjuLDZHKVl6wjpvQNeJGe+RnrAANzdNqbgDzDDA36fArOj2P+lDk
X-Microsoft-Antispam-PRVS: <BLUPR12MB0691E1932C1C391F411980A3FDBA0@BLUPR12MB0691.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BLUPR12MB0691;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0691;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(346002)(376002)(39380400002)(199004)(189003)(476003)(86362001)(446003)(5660300001)(47776003)(50466002)(97736004)(3846002)(6116002)(11346002)(26005)(25786009)(956004)(59450400001)(230700001)(386003)(305945005)(23676004)(2486003)(52116002)(7696005)(478600001)(106356001)(76176011)(81166006)(103116003)(72206003)(81156014)(7736002)(58126008)(16526019)(316002)(8676002)(53936002)(2361001)(2351001)(6666003)(4326008)(186003)(66066001)(55016002)(8936002)(53416004)(6916009)(2906002)(105586002)(486006)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0691;H:sosxen2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjEyTUIwNjkxOzIzOlZRZ0w2MGk2RzlzUitEd2VOOU5aMVdFa25y?=
 =?utf-8?B?Qll5RjJXU0pla3lTZGltRkpIZ0dJeVU3RHFVZUV5Y3puTWcyVStJVmp6OW41?=
 =?utf-8?B?UUFHNElvdWZ4VzI2TjljVHQxYmd1Q2F5bmJvUmhYb3FPSmJ2RS8rcEx5SW9i?=
 =?utf-8?B?TkkwTGVSb0t3ajJ1c0Rwc3NGMSt2K1J3QU5rUnFBU2JaVU11NzFOdVpyUHRK?=
 =?utf-8?B?V0dSNTgxekx2OVdrSzdLa2NEdGkyUWhCQ2RGU2RFeHA0eHFSY3VUbExjcFNt?=
 =?utf-8?B?SGorc0ZYWW9oMTlYZGxvMHRsbk16S3lLRkE5M3phTUlncHRCSnhsSjZ6ZUxl?=
 =?utf-8?B?aVJUSS90M2IrMS9MVjlwK09va3lXNk82MmwrakhTYnhORVNyTTFxQmZGaXNO?=
 =?utf-8?B?cVBvWk5USnZkUWlyZFF5emRNR2h3LzNPZ1IvRWZ0S05QL1hPTUlzTFNGdnpq?=
 =?utf-8?B?cEdPeE16R1FpdmhJeEptNTFISHUxdVhCWU9lUHVjY3pOWDU0ZWVHTHA2STA5?=
 =?utf-8?B?NE52MzBjKzI2cU84L1NTQ2VWMDlsRW1nc2ZDV21BT20vQkorR0hOOS9lZTRQ?=
 =?utf-8?B?UE9lUUh0b2lrenBJR0hPdmJmUlBRMWRBNXJUSk81bjU4cnlRQmJubU9GbVk3?=
 =?utf-8?B?bHh1Vi9vVTc5aElQWGc0SzhybjlGck9HMjBpOHJmOFhvQU9xcFhtN0ZacjZt?=
 =?utf-8?B?blliNnhPK0RGVGs0RTExS3FxTzZkUGpyd1A2L0ViZWIyT0F0NmltSWJvS2Nk?=
 =?utf-8?B?VEFWSFlUcFZoSE53Njh1dGtyQzhpY20yZUd6Y3g1azl5bURZcUM5WHlPSlNW?=
 =?utf-8?B?d1NwKzZZdU5neVhyNDdZc3hFd25SQ2JsdC9CbEQrQzl0S1ViTXdQbHVTdm1W?=
 =?utf-8?B?Z1pvNkVhZXJFYkIyS09pOGNSM3RCNmNrYlBIaGFOVEpURXVWWjEvVXFJNXRB?=
 =?utf-8?B?WlplZEp4MzBWSXREd3FyWDdiR2RMbWUyZ3dxRGJHVy9pczh6UldDeEdYUDVQ?=
 =?utf-8?B?bEIyR1VHVFVkY25nRVhoaVB5N0VLVmVNYjZiem16MFpKNzlLdmpkaVVpSmdS?=
 =?utf-8?B?aWl6VWZoUXNrZGExNy9uMXhYVGR1azdMTWhEdDgxOVVzc3VRdE5RSnlCb3h4?=
 =?utf-8?B?UWt5Mmw3ZXNDc1k4Z0VYdGJjMlNNeUJxVncvYmJxLy90UFJDR2JMUkdCcUx3?=
 =?utf-8?B?WmpycW45N3d6ZWRHaWo3eCtYN1RLMFEzd0x0RDYvSU5rZ3p5U0xoTmJoUGZS?=
 =?utf-8?B?d3RyckRUckpHMXBwMG9VN0hsSGpxSUI0enMxby9qSmNUWFRsMXRadjRCNUdU?=
 =?utf-8?B?eUtoWTlQVkE4VG5VU3hrbEpFQXN3aXlHQ2ZPaGRIdGdlNGRtc0d4dHY3c3dJ?=
 =?utf-8?B?RjhvWldTQ0JUazdpeFlBYkFKMVhwalVNa2orS1Fka0NuVzZvSG5NZUwyV3dK?=
 =?utf-8?B?aURPM0JXZzQrb1lWN1I3enVoZnc5WURHR2VWQkJEVytSVmh0TmRUMnlzYU9t?=
 =?utf-8?B?TFMyUDZON2ZybGpvblBEam1UazhSZzYxbVZpaHRrNlJSRzdzSWxodHFUT2FD?=
 =?utf-8?B?cVk1WlNCM3dhMkFyMllwTWlpTkVMcXVMcWF2aWpaVjJKbDhFb1p4T3JmNmpR?=
 =?utf-8?B?VXpMSy9Zd0tnaUg4VGI0K0J6OHJNZ1NVclBZU2VyYThtclY1bXVKK3JQcy9P?=
 =?utf-8?Q?rOzReSqdsg9lAgM2q4=3D?=
X-Microsoft-Antispam-Message-Info: aN3Cx7ZbcvXMO1fNbe9fWJ/osk+sjE2fwKeKeDEsxFabT/VxLODG5H1aPf7tc3eew4w8glNjC6qhnehjAIGGdpKyydyTTVutiojrq3zbvqg7cVPaWLYsbVNH5W2TS35L9GJjSTqh87o1YJyvS60Rs2evukmOELl4LMF5+BOAXTUAyJszc8RphnqGnEEMeR7y
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0691;6:AV5FKH9OwQ6MVr1dwqVvjKE4mfhvQ71bxz20Xi2wp8Zn+RRXr748oYJQn+zWyFoZMtABVC+Bo4rfCEfqS5rRoTgJyYCPa4lgqEhzV/P9pS3yJGiVasLh1kEO9g6RY6a5hgwYtOFDhwWlYjN6AN6MHz53yxXUYDpG/fETHTU2aWUnZLOHKS1slP8FLMQC/oENwzI1Lo/SqT0SHw4evXUWNndE83Yq3YJdx+I7cXJOWlETOvCq82mHN8qQj4Mlgydmiw6ZafgbqzESMwPLKQNPkopzxEZlEyFp9562M35Bu+B0dHs6eMoFaVr4gnk1L0/FDz9aWOk01PbInAlw7YZRMxHElSBfqbiQlpWkfccu5W1hWVxNAVaiN40RVGCL7yVQk571lvxOSAebdf4Zo9FsJYRWm6AVAKWECT5s6RnfDiYJEpzs4urS9epnMEQP2vedXTKUbWcv8/AVyswTX6EO8w==;5:vGer37OJ5SUToBYxVimcdZDwN64z5cZRrB00Rpf+0JcMAFOq2cqzIUB9pGkx5QtFna1L4P6hsaNSaec5FbtnSsQ2qnPrjWLxJdkdNH3FNwqkF+KdBXiX5kxKxFhIPmm2TkwZHNl9dy+5OWm8c3MqGSgErGviZj45XFCUe9GYODQ=;24:l1l3XY6fTQqANworr0KH2+CbKPQUMonEURe+6ZiAmmU6I/7WC8F2008PZ0pHQPinzTRckudgA0opTn9+XQxFqsDqsz7Zby2VEWWPVSO/GMo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0691;7:I0RlDvUrE/z7O3AsjXs0WlLNQVtLFX3Fz4KDVc4fu+1pE3IWwJ22CgpLlm+TfGv6AWALMsBQeta6iOigDAonMTcF6DTC0ogi3923omKg+lURDIvlYF9C8vTpr0fHH1Fsavb+0DyUISjAQPW5AtpISqIbc/Cg3mb3z7YitnPmH9lze0of7Uq2+dNP/6OvaIBgIi79XjkQAKjuKSAcQe06/qtA3YCi/8DrJXzxu5/vDBtg622WaClvlw57bgCFH5HU;20:XuYQ4PWSlE5A9gp+ej/8CI8e+gZgfBqoz7DLMWIXmCkqMZVXWnSuUGpew4QkTFOVhShSLBJ1R6JZ2r/2GEw7Gma6okBPkhkcpfy9Xo1AvlJoaJrluY2dD4WyikRn6C+tHqC/5XiDIeliYfrrcgDzUckdMSwDWxXJqMqaMMF2Z2cdcRffcD56kQL11GDZO+jAuWr14aPAQlx3sLhGrfSm5SUDRwK0QUlampms1axKiUj6ysfNADqMLcUkDkLMGiT2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 13:17:47.8832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d40ba646-1d84-4b6d-b959-08d59bc0cad9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0691
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide base enablement for using debugfs to expose internal data of
an IOMMU driver. When called, create the /sys/kernel/debug/iommu
directory.  Emit a strong warning at boot time to indicate that this
feature is enabled.

This patch adds a top-level function that will create the (above)
directory, under which a driver may create a hw-specific directory for
its use. The function

	iommu_debugfs_setup()

returns a pointer to the new dentry structure created for
/sys/kernel/debug/iommu, or NULL in the event of a failure. An IOMMU
driver should call this function first, and then create a directory
beneath it. A driver implementation might look something like:

static struct dentry *my_debugfs;

	struct dentry *d_top;
	if (!my_debugfs) {
		d_top = iommu_debugfs_setup();
		if (d_top)
			my_debugfs = debugfs_create_dir("vendor", d_top);
	}

Since the IOMMU driver can not be removed from the running system, this
patch only provides an "on" function.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/Kconfig         |   11 ++++++++
 drivers/iommu/Makefile        |    1 +
 drivers/iommu/iommu-debugfs.c |   58 +++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h         |    4 +++
 4 files changed, 74 insertions(+)
 create mode 100644 drivers/iommu/iommu-debugfs.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f3a21343e636..c1e39dabfec2 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -60,6 +60,17 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
 
 endmenu
 
+config IOMMU_DEBUG
+	bool "Enable IOMMU internals in DebugFS"
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
index 1fb695854809..5eb1121d54b9 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
+obj-$(CONFIG_IOMMU_DEBUG) += iommu-debugfs.o
 obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
diff --git a/drivers/iommu/iommu-debugfs.c b/drivers/iommu/iommu-debugfs.c
new file mode 100644
index 000000000000..add6f95120e4
--- /dev/null
+++ b/drivers/iommu/iommu-debugfs.c
@@ -0,0 +1,58 @@
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
+ * This top-level function that will create the (above) directory, under a
+ * driver may create a hw-specific directory for its use. The function
+ *
+ *     iommu_debugfs_setup()
+ *
+ * returns a pointer to the new dentry structure created for
+ * /sys/kernel/debug/iommu, or NULL in the event of a failure. An IOMMU
+ * driver should call this function first, and then create a directory
+ * beneath it. A driver implementation might look something like:
+ *
+ * static struct dentry *my_debugfs;
+ *
+ *    struct dentry *d_top;
+ *    if (!my_debugfs) {
+ *        d_top = iommu_debugfs_setup();
+ *        if (d_top)
+ *            my_debugfs = debugfs_create_dir("vendor", d_top);
+ *    }
+ *
+ * Since the IOMMU driver can not be removed from the running system, there
+ * is no need for an "off" function.
+ */
+struct dentry *iommu_debugfs_setup(void)
+{
+	if (!debugfs_initialized())
+		return NULL;
+
+	if (!iommu_debugfs_dir)
+		iommu_debugfs_dir = debugfs_create_dir("iommu", NULL);
+
+	if (iommu_debugfs_dir)
+		pr_warn("WARNING: IOMMU DEBUGFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL\n");
+
+	return iommu_debugfs_dir;
+}
+EXPORT_SYMBOL_GPL(iommu_debugfs_setup);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 19938ee6eb31..ccf7c1d800b0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -698,4 +698,8 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 
 #endif /* CONFIG_IOMMU_API */
 
+#ifdef CONFIG_IOMMU_DEBUG
+struct dentry *iommu_debugfs_setup(void);
+#endif
+
 #endif /* __LINUX_IOMMU_H */
