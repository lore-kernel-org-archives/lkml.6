Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752556AbeENRVZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:21:25 -0400
Received: from mail-bl2nam02on0088.outbound.protection.outlook.com ([104.47.38.88]:32817
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751978AbeENRUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:20:25 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v7 1/2] iommu - Enable debugfs exposure of IOMMU driver
 internals
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Mon, 14 May 2018 12:20:20 -0500
Message-ID: <152631842046.18929.1205439632866632871.stgit@sosxen2.amd.com>
In-Reply-To: <152631818082.18929.13970142119193316487.stgit@sosxen2.amd.com>
References: <152631818082.18929.13970142119193316487.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN1PR12CA0044.namprd12.prod.outlook.com
 (2603:10b6:802:20::15) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:d::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1449;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;3:spnS2ok72p3l3Oot9l3GOYx7A4uZhqoY9gvXfdxXdL1Rg/g3GRwF9pmQuRnineghJyIJxhvqGn+cUaooZj0aNeBYOTUtZx7xGrj0c0znRCe5fpExsX4rj2uQvWKfQeuJJF4GFPCmrdP9EK1eNDHJER+PFdXMFVaREkVIdI8lvVu4DZdfbIFwnX3vVy47hO8LPOCdyXhV6k53VPTfdnEp4PisAbYV/6kV9jXRMIaV8I0VMIrV09AjKUdkaHLHTzZ/;25:caqYtivl9x8q2oYGdmXlOpBi4fRndyKNG09YqErdPxQNvq17xJKwErZqKPh36nKO3Bg5YOn5Fl8A0LhEi3ZJID1Ndfu2pwP6rk9kOYmqi2Xm8FzdNsNGGVaY3Gqx12/cA4HMdk5ewDHuW3IE4hvovl3Q+DeA0p9oXwhMOYwPJPGHLRqSwZpUASvxZ0b2jV9sZzxWA78e8oNMPKDkTU9kDfSWoGwSBVWYEv3RGEKMDH3rZMO+gdQ8oN/WacurEcblBlvvi3lntXal2kyDdHEYVgwp5IGu9w3uHXmJNkKAdwtJW8HpkpF42Rf7+x8c7Mu9idS6rmV8u1K/W9UkAwMBpA==;31:dUWn3rTMlhhS88O7z8+CrHWOsGU/HjAbu18K/Aa63z291UmQq7ynSiN8LlxeZRK/kCWQqQXLqcKYGX89cVsrWSbvQvuuxie8xkWBTfw03pvZ0JfaMVOEkM2J1yPuPAt4TJGy+oFw1vd0T+1wdDc93ttdQ5BtVVlyrneO0mdvd95ZgrLmIzQEcRDTY5FLClh9tW5uBW0TwBtPWQY6eyyAzFdTFznKqzDLH5NdMg4qBpA=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1449:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;20:XqLXzxlHKTbDPyYFnPXdL918Czx2FctC2AmW7K4yx+I8dZhihy7SkNEI15grBrBTi7LtfP1D5IwXBH9jsQxRoSsAmp71tb7ueAAp+/yRLUM0TCuz/yDz+6AvcGzYHkj4ZekK75uDSV4/6yJccI2Rc59HjDEgxTj/86eTfxCCou+stQEHuzAZWWOBaJymz5deOutkvZX8A2RLmly5kthCBTzIe9qCBhxdgP2mCoHn4RzwqlNto5WSWyLH2o2RFdZyx7ge7KkQf9kjXey4hCLGXeYFxSisTi60anWmOuOLqeUcD9YzYmQaoIXpdit5sNM6W4KmjBVtDGAw3GLEXCJubdmWJCJOFL/wvCyr8k92l/b/0K9xEjfcFmZzu4cBdee+qeUuezikq0tBQW5+327BFK1L8XXRHXaFQPQsFIKvQJDNp0HNRhWl0e4SurulpccR/BfwbLlmqJD8XoC8wuxEPhyB+nXEVFfpAWe3lzagcDvp3SkyfSiq04DJH/xO3gMZ;4:qI8YaMuqoIHS8xp6uK0nbmPs4TTfzZ90ObFxwXrhBTInDR35WtkoLGfdx1lzLd0UQn6J1JtrMpw5N0Fw7Uj7FhQLKVVw2BBhih3cfTTi6gMudYAuNvWsdnQdxR2ZIsYjYcpotHvAj2gJJ7wr5oZz+DcsqwK/zGfC8aUvBJz+DsfJCIvALwf4qAYunShLesldAu9tM+iNwnvVd+EOvU/VuaWAljGwWfvtIjIHjJm5v4vwShm6tDnaXoYEI/Htl4M6WqKiRABGEBQ9mmr9oMbBNR251ZYMuoy0IEF43dsektX48AYmSQ7IEHlCMCzxk4ksjy6NJrBJfO2SDadyT0nRSg==
X-Microsoft-Antispam-PRVS: <DM5PR12MB144968E19E9185C911EEA9DDFD9C0@DM5PR12MB1449.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR12MB1449;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1449;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39380400002)(39860400002)(366004)(396003)(199004)(189003)(476003)(50466002)(103116003)(106356001)(2361001)(47776003)(956004)(486006)(2351001)(305945005)(478600001)(7736002)(5660300001)(8936002)(8676002)(72206003)(446003)(6916009)(2906002)(11346002)(81156014)(105586002)(55016002)(66066001)(53416004)(97736004)(230700001)(53936002)(2486003)(23676004)(81166006)(3846002)(6116002)(316002)(7696005)(52116002)(26005)(58126008)(386003)(76176011)(59450400001)(4326008)(16526019)(186003)(25786009)(86362001)(68736007)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1449;H:sosxen2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNDQ5OzIzOlNKQlRCSElpclUwVnZ3dnpHc0lpNmZhS1ZI?=
 =?utf-8?B?YTFaa0RFOCtrRzRBb1E5aDN1aWNOZE1qM1huZ3d4Mm1DaUpFVFExZFdWcFlZ?=
 =?utf-8?B?c0MzeFFEbmxJNUJ1YXA4OGN5ci9UQjZoVWVoeXlxNGRhWncxeWZhejVkTThx?=
 =?utf-8?B?bTZnWmwrNFJBMFJ5dktDbXVtUk4zMDRoamh6Qi9NdkFnNEZvRStkd3QzNGg2?=
 =?utf-8?B?ak9RMUZzL2FDeXRSc2RuZGZhYllJakl5VmhTYTA2bWFmeTNnMTQwbGxzdlpZ?=
 =?utf-8?B?MGV1UjYrYU1HV0w3UG8rMmpEb21RK25WSStjbXgwc1NlQ09yUDRqeFkzdkxU?=
 =?utf-8?B?bW5PZ3hqSnp1ZWJHVjVySStrWW9DM2tZZmRYRVJheTZ2cEQ3K3Fnc2l2dUFh?=
 =?utf-8?B?TTg3ZW5NUDJJUTQ4cHFLT1R4cXJIaUR3ZUlJbHZDM1VaUVpWWnBzRFhCVjJv?=
 =?utf-8?B?K1pza1pSQzhxcVZXc0k5cXhXS25UQmZkTDIvdThaZE9VUFI1OXA0a25iTlM1?=
 =?utf-8?B?bjBaTEJhd3o2VG56ckhISjkwV2c3YkVseUZaMnBDT3lpZ0M4TzhCdG95dmd2?=
 =?utf-8?B?TzRCaVRkTWdOWXdxY3dZYWtnNWh2a29IZnhvTkdVRkFmeDNMb3I2bXJ3VWww?=
 =?utf-8?B?YTI5SEhsbFpSWUQrTW54U1FZWkFxeStNb1lXTUE4MDRYZncvVkFsMlhNVDRH?=
 =?utf-8?B?SzFUMnlKNThBTVdFL3lYQkZuM28rUHA1YXpLWlJEbWFlM3NuTFBqY2lDMDlB?=
 =?utf-8?B?bTd5YmVIK2d3L3YvM1ZVZnQzRnVWdDhmSGJ4ak81T3NodDc1YXBNVUlsbEIy?=
 =?utf-8?B?WFhHN1ZvWmo4ZDlJNElnZUxTQXZhcWxrOG9SUS9rSnpEMGFLYngva2ZEQ3Vn?=
 =?utf-8?B?RVo2WFdHT0FmM21NS3N3Z3BTOWNDV053QndyTFFNenExelZ4dXpYcytsdWRq?=
 =?utf-8?B?bGlveUFaRWFaZjE2UzcvdXAyOGlVaHdveWU3V0FaR1JpWGpoUVJUODZBeEFL?=
 =?utf-8?B?aEkxUmwrczVBcGxod2dJZ3JuZ3pYdkZXeXptQ0JSK2xHSktzQ2xjU3FIZyt5?=
 =?utf-8?B?UTdjdzU3V2ZJd3BRNytScEg1T2VBRnFaalFzK0FaODl2dDZNUnRIZnRQNVhO?=
 =?utf-8?B?eXdiMnNXNGZpUWw0SllvekJSQ1dHaERUaTVYTmhwUDRKMGhYaEJ1MVVCcGJt?=
 =?utf-8?B?bFdMT2pyMEtTbGlnaittL1pwMzlUQjV2M1c4d1lMc2k2MWFBV21FQjRuaWRm?=
 =?utf-8?B?U0NOK1dGRmpMcjNDQlVzRzhhTXYrcW8yR1N2OHJ1Z010WU45R05xdlVINDVi?=
 =?utf-8?B?Q256R1pGbWNlMy85M0djeG9PYjJHeDhWT2tpc1VPa2R0WGdKVVhzWGx4VVpx?=
 =?utf-8?B?UnFmalNsSS9SVEw2aWpxdlhlVklIR294MGkzMUVBdGUwSCtNR0h1RzU2cTZQ?=
 =?utf-8?B?UFYwd2dBc1B4dWZBNE1JMWhrbEdhMWJGNjY0M0FQTldBSmNjSTlKUU5Pc3Fs?=
 =?utf-8?B?dzh3b2RqdUlPY3lINW1UVDFwVzRVemlCVkVDSVFJRHNsQmlhR2VGVm4rQUsy?=
 =?utf-8?B?NXJsa2xGU0V6emRGbnE1dHVIUFk2R0VkMjRBYkhRZzFWWXFqb2w0YW5YWEtR?=
 =?utf-8?B?a20ydWdXQzlGWWg0aDVidTg5d2x3UEQya2NvZjA4aDE0NlZhWE9sMWl4Wk1h?=
 =?utf-8?Q?qi+Y1RtjIKco12C69M=3D?=
X-Microsoft-Antispam-Message-Info: 27AOp0XTDsSIwszOfgfpR6pAe6/S+1GAsZlY0GwnDyaM5loAzX2Me3Ztiea25XXzEsFEOtIb9NbY0I49lWuWAoCVcviQFvU1o4KDsAaFCsrLAJA8bwEw9JeEVBxdMBzDRDCTzFlUJeJvcj0zjUczbSP+GlsTz3N8NqDd58KRIivqtMB0A63sp5kSyD1tUHgz
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;6:XolJDxozf1fbVfwKe1PTXCF+aU5tZC4jn5IWeKPm31G9FNKi+q1sgQjwzQHkky+MPXxJSp0suTJAkL3/yVKEHGVnHf3uExdwAGDSzswdkSgw5waCt2Fm1tavBMjs/TfVrd1TwJf0TYYwdqD0Cg7tbS2+GbC0P6dG1Q2EAwHW5MOpc8Ev/5pSQfD3zLKQj/FaZi9GsmDxdfkshOV7EtGRgAltfEB06R0w/RkVjmZ3pWsfpwS+S/tDUMWeNkAUS1BpQRPDpORwUaT7wbUfSJBOncgqPsj4pwXP2BU11v6GT/zmrx13DinuB4QBj6AaKSyC8QFmAZ1ZfMmZXzLK7dSlxpRXdc9NVqhpPq+aJ0BxKbYTNKARal7d4RQ1pssHXdBLkjUMMHZ0AhpsLRn4TRRvb/zFBmWwqwhlWFOvRpWkeTPFPjMqPkLDJ3X06tK1oiSvo2ia/LyJSXJSXQYyQSq8qQ==;5:1DvqCL2raGYm6wKC58U3Kar8OXTZ12Plqn7czmBRxr2Z0C9nc1zdthHubsXALcff/vrzSo8hFE69KiBdEsqum/maUPkcVQ0VUlspUq/HHesbrhtpyvfS8k4bCrCjZ8tN38oxTb8XXHKuShmJ1vvohpMaH043DHW1x18AYt8l+Gg=;24:0RYrUekds+qHZVnB3VCvRGkc4/9yTHb0AOvwLEPMxHTapzAE9mqf+f9KFrCzgSuIU6W2/52DYHecF4JRy05fwm8J91WgpdYOQgTAeTikJNw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;7:srpBX7IFHjVW63R7ouBMCn+JS2ccenISapsjInQhsQWh9A+DKpN8B/3iZ5MdUi+cP7SolZNhBXRmLCcyBeE47EcGEknFMVJV1XdvpiObdUF0GOs5jVOxl9HgLq7qX3MQrjSj0kY72z4oj/V/Urtx77ystNgOWgcbIIZXGq96E9yEJYhmXXPhdaEcb6pIIOGM1572ne2Cx5XRnYshf4Zwn4rSo6QJWjpHU5tOaaOwXw9aYDttXgxSPo5vsHhLjP2P;20:wkYx4Vbi24jjRptoTOYZTn4T0uLm4OCUsA2OY/DeWtNrZvpGWZsUo2C68SnX2ZiC1tsPbEzw/cuGQdZQUvJrWO5paih5977vAO1KbURpGzH1P/7xaxYRhUb3+xzrCUGMackBoMOuPHMW34B5kSuzzHVZaX1XrATPjFW1nIaDxieKgI13MoMasEef3GZVsaemZV7rM9gH0/bDGtKSxAx01/zS7xavjsCsdXCpt4AwDbAQuzFo65hu5JVVpdNepSSL
X-MS-Office365-Filtering-Correlation-Id: de775ab0-7fdd-4fd8-8184-08d5b9befa54
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 17:20:23.4591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de775ab0-7fdd-4fd8-8184-08d5b9befa54
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
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
index f3a21343e636..2eab6a849a0a 100644
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
