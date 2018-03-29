Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeC2Wyy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:54:54 -0400
Received: from mail-sn1nam01on0043.outbound.protection.outlook.com ([104.47.32.43]:26432
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752105AbeC2Wyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:54:52 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH 1/2] iommu - Enable debugfs exposure of the IOMMU
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, jacob.jun.pan@linux.intel.com,
        linux-kernel@vger.kernel.org
Date: Thu, 29 Mar 2018 17:54:44 -0500
Message-ID: <152236408441.3266.6015804200548808265.stgit@taos>
In-Reply-To: <152236384612.3266.1451709369164076985.stgit@taos>
References: <152236384612.3266.1451709369164076985.stgit@taos>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR22CA0020.namprd22.prod.outlook.com
 (2603:10b6:300:ef::30) To BY2PR12MB0693.namprd12.prod.outlook.com
 (2a01:111:e400:52e0::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a7a2ceb-a238-4c01-7bc7-08d595c8135b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0693;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;3:8NItTkopSxYEpeFusKiD1/XYsdNESG5CgiFQn6d+WIwGGk+VAULDlAu5kLlNXKICaPSuU0TUwsKGhBgKjcgc19rXksmYkIB1WUiTERac+XZ5Q3PlcuhsycjeMuUPx8teV+SGC+Pk03MMwc90unQcuH/it0nUZNabtiJRGojlNoEqHd0p07FcwR4viHsBUJkiAUOD299qiAdLM7sURoCw3BrNy6dbz1zHfaLP2TL+MoGTf9Z/jwYhvpMeS7kq20pf;25:4EXlH6rzFMky4MmrtpbkWLS/n+xnYJJTuaXpNnsfrk1zIcthKx86vhJkPcish0rcvoRyttRJfdqbOeRS83d9UwvJkYTdHTsZjz6PNpaZMetmX8pvifwtnkZ4ku2R03d0rhI4Yqa4jv3pvndFjaSZHugHB/EfHwl8LCyX9nnwJFzGWQrcWtT/uYYWHNupQZRCUWKHrs2eX98cLtjFDhMrUu/vHpC9bLndX/1Vw+H0qscVpmbKGwsTR3q3dfagW+eXQlDzEwaM5+qGi+wDKKVYIX/uaIuGeJdRJGloc/EJoGga+65WfoWHh61OM6jtv3TNY9Vfz6WuPNO82Lz23+5eopcu5ReiyxPGo0pruLQ4ecU=;31:9v3Xoy8s9qADO9lDo16fUTzMJM3AqxHIRsN737lwR2A8pMnl7HOGO3S+tgAxO494ATYaxic+pzibxl2YDWkEidtIwIBBK7GySVN4Uox63TUJAKIon3LcA8Iwb86HI7ovlpTktNpvPghVAW1SLrKjcZlNFCw2bIRH0YN1FGbV0IcjbdQqDLelfeQ9N666DEbXRIcb+htBAMraR+J7lZJH3S6bO6dbTr3pieFLqPczPYY=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0693:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;20:cLnVyiSvqbr0GReZxvepuL//jbUk5zu6u+gUhkSYOLu7oMMGtvtnlhP1iQTgOyDZ3WkNm9BEt+NC69YmDK2IKl4sDVGgEhu5Zaq1GNhRFJSeT8zgVhvCAmhoCLCRxO4SUjsTfCGncdoLJ3FvxCMU5jm2wAjJ1P/1zAdSugTvsEQ56z3JxnrXywTvJwo4dNZyh2kUROcrXBOJ+kq6U/TiYuIrC20pfkeNN0IKT9lPb5ozDxfKqrvpLhVdYofxaZWHT8r4T4DC6eFVFI8F4OAYpaYQPfVEycW6i/sPa65w6VwJauQkYD8xIoqf4wZ/TSpUJsBXpXmo5Byo+dPfS0yUg5N0gprE6jYehQ3O/vbcg4/ueZA391Fv4lMHBcWLwEimGmCh0CPnJIRLNv4ELx67UOG74qtpV2RD24X5CYvyVvgqRBZKcaa1iDoSCcHxqyhTRvwlDWSmvRdbWlzXnKz1OIbEHPJaleSlt7pMZouWin5VoMx3Fe0USqh3UfRDaDtY;4:/FoT9Rm7k6wzEY8bJiToZwi1EtW56UqEEuZzr9zWALXdvXlLrQTfFAwtFo+4b53SiqhJovJXPD8kzWGsfIPgGEL10eHD5TPavJOAnqSXWQLujSegK0Ks3RQRr5ZK+XT4tNsNIGTj+CPylTNciVthUY/50SMCGfqlQ0Y4RIj+b/zzwY1H70wDKDShJ3Ls3cefB4FYmTvvXWfYpBtEXloZjTWHtfeoJN8TbZoalHX7/K+p/iWt0y3DZDlKuynf7zVdZOa9Io2aUSaaei5S6uFiMIxLNkQbFYPyNqx4L9Q7FCeq1VticBsGv1Ycht/d5Yes
X-Microsoft-Antispam-PRVS: <BY2PR12MB06930D3DAEAF40F2986EFA25FDA20@BY2PR12MB0693.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BY2PR12MB0693;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0693;
X-Forefront-PRVS: 0626C21B10
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(7916004)(376002)(366004)(396003)(39380400002)(39860400002)(346002)(189003)(199004)(230700001)(33716001)(81166006)(8676002)(316002)(58126008)(81156014)(2906002)(16576012)(4326008)(8936002)(53936002)(6486002)(9686003)(86362001)(68736007)(66066001)(3846002)(59450400001)(486005)(77096007)(2361001)(478600001)(6116002)(486005)(2351001)(7736002)(446003)(6916009)(386003)(105586002)(72206003)(5660300001)(52116002)(476003)(33896004)(25786009)(11346002)(47776003)(956004)(97736004)(16526019)(106356001)(76176011)(50466002)(23676004)(26005)(6666003)(2486003)(103116003)(186003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0693;H:[127.0.1.1];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwNjkzOzIzOi96a2p1Zk1pMXV3Y3B6UEVHNU1WRG0zOVlR?=
 =?utf-8?B?c2w5WjNuODBsUW5HL0JOUjFkd3FVRVM4NDdrc2VQeDdoUDcxVHpOT3RFejVN?=
 =?utf-8?B?dkYyVXowczE4WGJwbmQ0eTVia0NEeUJJRkRTNFVWY3VWaUNLWjRjb2xmS3Ey?=
 =?utf-8?B?Y1loejV2cERMeE81OGdWTTgvQXRQUGVpblc3T0FUWWMyVXZmVWtqK0Q1b3lY?=
 =?utf-8?B?Tk9XVWVRUUpVNUtRRHJUNlB2S1hnTC82WHFxelZGKzcrdXhDRjZ4TWF2UFZN?=
 =?utf-8?B?aE9aaHowQVJBWVJJOUxGWUNMQ3JUM0hrUDdlb3U4M3JFT1puUTZJSzREUHhz?=
 =?utf-8?B?T2ViRkN3aTlFaEd4alZWeDZmdndZVnNsaE9tUE0vV09qWTRCZGd5ZHUwWi8y?=
 =?utf-8?B?SnhNc0dLeTlyK3paMWF0K0NNeXQyRTZoSWh4TlVVdEVPdkw3azlhK2IzMFF2?=
 =?utf-8?B?ZXVLOHRvYnBHdjBzdGpocm9kMEhCSDlyZkI3V1VRbW5PSEI5WnlaUW5lQzlP?=
 =?utf-8?B?K1B3djYwMlNNaG9kRkw5MzJjbmhuWlRuSkNFQ0JwaUZJNlAyY0JBYnBUOXV6?=
 =?utf-8?B?a0JaY2MzaVVYRHBUQTdab1YwUGoyVkdvRi9iV3laZndwMVo1U1NFcWdOd2hG?=
 =?utf-8?B?YjRUWjFlNC9mSnh6MWdnNEV5a1BRSlRwZmJOTFFPOGVCUWR3K2RCaUlZN3BJ?=
 =?utf-8?B?MlBkZFd5cVdoM0dPL05VSHNjeElkdTE4YXg3R3orL24wR05kKzVvWnFiOTRl?=
 =?utf-8?B?QlNxbFhlWFc2T3BBLzhINGlzNi91YVNhTHRROWJhNTJyUDF2S3BOQ3V2THVT?=
 =?utf-8?B?K1N5dHpNV0QrQzlHL0JtOVl5a2hKeVlEQ0J3UTNsQnE4U3hCdklRVVhJYVZh?=
 =?utf-8?B?eENoNDg0QnBMUW9FOEFmZ1AwSFRUVk9JWExlNmRKZnpoZWtLekU4cHhRSHNC?=
 =?utf-8?B?NndDUHVRT1p5ekFWUGI3TDR0SlpleGF4NHdhRTVrdmtTMnNlQUxQOXRXdVZX?=
 =?utf-8?B?amVWKy9pZzJpQVhZM0t6YzJJRE9LMlBRdmovSGNpcGtnMTlBMVkvcjQzNlJi?=
 =?utf-8?B?NHc4YUhaaTZ5MWNWWGRFSTI3NWplWU8ycVEzNnhRMUlrRW5tS25DWWNYcmly?=
 =?utf-8?B?NFNGT2RnT3lVVlVJWlJTTTFPSVFiaWFGRUJkMGJvYUJMNGhQQjFRTGplSWZG?=
 =?utf-8?B?KzQzUzNuYzFjOEQrOUVZYWkySmNkYVV5d043c05QellVdTkyVEVWMmdnYmRP?=
 =?utf-8?B?eUV0QkYzZ0hSR0JwaDVTSXdXdDdMQ0txVTIza1NJUHZZZVZvNldzcDBNYU8y?=
 =?utf-8?B?MHd4d2lyOFlZZUVLanBRV1dJVGszeU9Ca1Ewa3ZydjJKWmFEUjg4WjlzV1BI?=
 =?utf-8?B?aEJXSzRrNkh3aGk2Y3FxQjRwK1IyZDdnL3JvcGVhcnZwV3VZOTlmbmJyTEhX?=
 =?utf-8?B?ZU9OcnlwV3VzdW4wUDM1aE5CU1FMbjlqWXd2RjN6L2x5NittYnNUbU43d24w?=
 =?utf-8?B?d1owRnVQbm1ZMjJONnhzZE42UGE3T0tieDdqcUdrNytyWVZSMnVKTlNPYmlJ?=
 =?utf-8?B?bGJhbHI1cUduZCtJbG14RTd6eEJVODhnUW5iZ3FrNXpoaEFaaGU4RGZ6OGJ5?=
 =?utf-8?B?L29Vdm9oZk9LbnM2REp1ZDI4OHF6bmp0MThDYytSUFNhazFZVGFzNW03WXZW?=
 =?utf-8?B?QTAwUVduSXNMVnA1aDFrQll6R0FmaEdhek02S0VOR2xQWS9xeUZUall0R3hL?=
 =?utf-8?B?d3dXOGR2dW9mc3ZIQ3NKSXhoZ1NLeHVXVmFROVRHSm9lbXdlS2hHQjY1cFd3?=
 =?utf-8?B?Nm9BbWxMMk9SRTVxMnNZcmZrK2JoRlZGeFRkTzJqMGtReEE9PQ==?=
X-Microsoft-Antispam-Message-Info: 4v6k9rnEF4nrDkzZcKl9p1IU9A1xvE76G1DtT24LrCPgJHxVdaXRmAu2YwZdUXmnlHs+kc9wd9FmwI7iP4+VR31d7UAzToYsYA18PVXsu4TW1J6TjZa0RGoe4lEiDSc7jfk4omxuOSvrEH7jrJNWGExHo+5LsMu19qwR9tH9/6Riiku0LwhbyNp7JlAphCSZ
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;6:S3tVvPhp3PXUwVXe9r7w8MSIbckO+44DvXx8m8hddcIi3N0FbNCDxeFN2gs/pBxQhLrbahSLMK1aMmqGdUdeCyii+LRvzaggzDi1IZmpDacQvMFAIxZC/oHriXQWIIwUPIV0gs+9LwolW/yEjgcYy2Tj1HLbbJ9xIEHS6VMQB2Y356x2AiTeK5GSevQNl8cb8QMMZ9eGoF9QiB+MR9I7hb+00rOFAe1QBZC4VHIOxR40aZDw+Msaf8zk6xjl0lquo0kaChrgp6ctP/bep1CG6Z4bCme6LH1MGlp27Fe/QUBatMMU/x2PxWYsuW/LOJPeohfBol1d00BEPtZnnj7KcoK3JQkzd9u22hcFnEDr+qlsujGczGZFDJmv+f5/QfOS1L4mn7I+cUbJKuGS0IFf4HCHQKc6vdYllxeBqH4sUVjI58jf8oducXtmYhmZtVD77LA/1tJBAWpEzkJcc6Ug9A==;5:edSabKrWX9/Pto8qqcEK2Eerc7uXQvgUTgKkfkrCpjD2+xxNcfenvP8yENLgLMTY/R/3avMeJtPBdamkNa7doIS9pY9sYdiIG453u2SdxdiWdKngeaRWyDu5AvNWyTg8t5VuNNKYmi6KXaDlQwJ1GYEuHQW5+pfkrfGJDV6veCo=;24:0vwiX9Lj7+PlJWS1ot2nZbF0w6boluR9FRgZpdqtmXHxP2zMazKYn6oDMSx8n3zoBdMk65MV7PLc4mhYWc2Y+5VweOj6qSDz0Pm41A0eiF4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;7:EuZ6LDZgOoPNTLvxEqtDxpMLbHHmhXnMCG5QOFJ7lCCY5HnBfcqU/kuwUGjtYqdpyfUoTaZZTUYEIml26fnF5ca8DOsPPWdaW81b/PiJcX0havvKcyqTERaO/shE+syPTsIY96Sm4Ul872RNTCo9XsUVRd63AH8SiK93n+yJUSSG4svhwZUMy3tYf63LhRYFC2UW06QXos+CnEs+u90ekcfnFMxjCydBurj2TPppV7UWp2fUi3V54x5aEPC/Xjwn;20:Oqo9u93XaRFT96tJU1Ixr84QMrpZuGbzCBkN+ZeMvCtUqh5uR/4Gd1RVwKyJ2uNRJ2d6LIjZP+0P35ciufczTVPfJZMYLf1GD2Z5bnqRIK2uhKzESYCClc+HIJyxHxAHkM2LQH8K5nas1C2+yzrsTYECVcz5Mrmqot/3e3zQM7vkdwXc4O2Jfsezpqo04ucmx1BlbzUDbP7h1iKNKpfxRNzMlcU7GkamxgjwnLgExxFpfv5atsYuUpFOwYNXC/VX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 22:54:48.6209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7a2ceb-a238-4c01-7bc7-08d595c8135b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0693
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide base enablement for using debugfs to expose internal data of
an IOMMU driver. When enabled, create the /sys/kernel/debug/iommu
directory.  Emit a strong warning at boot time to indicate that this
feature is enabled.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/Kconfig          |   11 +++++++++++
 drivers/iommu/Makefile         |    2 ++
 drivers/iommu/amd_iommu_init.c |    2 ++
 drivers/iommu/iommu-debugfs.c  |   32 ++++++++++++++++++++++++++++++++
 include/linux/iommu.h          |    4 ++++
 5 files changed, 51 insertions(+)
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
index 1fb695854809..5e5c3339681d 100644
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
@@ -10,6 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
+obj-$(CONFIG_AMD_IOMMU_DEBUG) += amd_iommu_debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 6fe2d0346073..99d48c42a12f 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2783,6 +2783,8 @@ int __init amd_iommu_detect(void)
 	iommu_detected = 1;
 	x86_init.iommu.iommu_init = amd_iommu_init;
 
+dump_stack();
+
 	return 1;
 }
 
diff --git a/drivers/iommu/iommu-debugfs.c b/drivers/iommu/iommu-debugfs.c
new file mode 100644
index 000000000000..94c9acc63b65
--- /dev/null
+++ b/drivers/iommu/iommu-debugfs.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD IOMMU driver
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
+#define	MAX_NAME_LEN	20
+
+/* Return a zero on failure; 1 on successful setup */
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
index 41b8c5757859..cb2957dac43b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -696,6 +696,10 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
+#ifdef	CONFIG_IOMMU_DEBUG
+struct dentry *iommu_debugfs_setup(void);
+#endif
+
 #endif /* CONFIG_IOMMU_API */
 
 #endif /* __LINUX_IOMMU_H */
