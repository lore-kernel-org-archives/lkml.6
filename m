Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966309AbeE2SXq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:23:46 -0400
Received: from mail-by2nam01on0071.outbound.protection.outlook.com ([104.47.34.71]:3040
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965954AbeE2SX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:23:29 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v8 2/2] iommu/amd: Add basic debugfs infrastructure for AMD
 IOMMU
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Tue, 29 May 2018 13:23:23 -0500
Message-ID: <152761820371.2654.4551405686504157036.stgit@sosgrh1.amd.com>
In-Reply-To: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
References: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0501CA0095.namprd05.prod.outlook.com
 (2603:10b6:803:22::33) To DM5PR12MB1452.namprd12.prod.outlook.com
 (2603:10b6:4:d::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1452;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1452;3:yL4Sdx4/i65KJYVUByac2qnCbpAlALvaM3fKw5raFPrAXMxV2rICajlKvAnOS8jrwwMCcmeV9rsNcoBk+996sPQlLhgBQjK/DCCSBaUyBI0E6lTlWznu4VYU7rM8Bjywoa7IiLZX4l1vCvni7u6KF0j1FvY1ySZ6yR4VS9HdECcLX87pkekk4YttL2CEW+T6v3TCm2d/FZNHFRKNH9crhjwgHsjNtALcmygGq4XLrhLUu/RCQ04Bf9TUgSSmqw/8;25:ujXt8ticL9wZgUPIlgnuRj3FOGWgmGf/qNrhGyTh7QV3UcNfGRexd2ni7oFtDWQ4pF4dd9XKKrP3I8kTwMMOOfvWYasR7l9h09xonWGeMiZjWHKjaVzvOxk9uJOpEwEzhbavkHnnx6vghJRg1wRSdCEXg3z1rOThMhNa+dYMkLfp9SSuCG1RMHNXwmD2PR0R1DZFvHcKKdgL54n+gWT+LdYqH2Er7PaZZm/vPeAyVNkGwoPa0LWYBHwEukDN3+KuEEDR2EIKlD8wa4EGJptP4uVvdJxrrquRLW2Z0mzPPwZzKay2yldP5qXKtoou+S/W76c/WuLpP3dbK9g8xklgFQ==;31:5mBeNiPxe1bHFAh5K4Oa73aN0bNoc4If4F5JaYyTW+eTPevLg9MhBxE4fcaPO3gh3fDa9GbWd3vZKbTbQEGaNH97YVIi3H0sAL7rET5Rrxm4tSBr3AdtGu+lw4c3iIpGeDLZbZ2Tud1PfBh/FCgdeDvfRGV4eI3F9gzwTrLHky418s+PDTvmdOjH4I8Kjd5wPXvcDGOZg3s/TrclEVrxaeSr9RDX4NEcXDNuKLwdWnE=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1452:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1452;20:d0QWWONcTj/O6Zq45GAwFUSmgnJ1+dDQk41wtI3ObvOqnu3NN6rK16LGgW1HtFYN2PUd5gkmoP0bJNxNkkIx0jX9nPjKncTxD2QByKDm/wHv1TdaZuJQPKSXQtBGlPjbFVh9MrQZsyMf6L7QI6cLg0p+N7fbciXQeTi5bVey26tDPfOvCaXW1wwpAVhsyCUP0aQvXnaoudA9vNtdkauUZm+e1HyUxv7rRaYhlA2Pyg2fPCGqDP0qllbwCEgGxzWxrcWsZwRq2/iyVSlL+4LWwoEJeRau89QyTgJAobcgerXTt2Q284RDNjgwjJwsE9lsMURGaeHIwMeaIxNKjQiRTDruLA7lW5sIJaaZX0igSG5zpvPax+hzbAudDAOsWG3ONsuPUJVjuvovUVjZ7A4JftnCkV9rAO73Qcn/DSDKBj9TYKUh9y8xSdYOTpw1fqIWjFVlMl7QQBCKeP0hAiCoazpNa1CpCzXUgVwQ3HsrxKCRinsJHXX6ApXkgBz5/r0n;4:G4R7okD/p5UoUhra0+yE8AHA7VYopLO5X4BxqIFDC0OpvdK5wzy2OBF0AY2LAQcJN8VxJ2GxkocEraJl26gPO2rfu0BY0U+9RdGCKpJEUZsQYXmfZvdJWr0e9JoR+HL8hFxfKhWdpPMSiiGNpnLt6A+nH2KiAn4TxXwXJsSCTwkTtsASaZSBzpDWtyTMR/UqX8cUWClOnksGu3aEg38Khdtv4tRyFmJZVzhWTuizth661tnb8RY7RvWPIUw18Qq1l12VMGsfLs/GIBI5LWo5YMzb5cL97HjhY9o/DvJi5ZkQOxSwp23RsHinmFKTZjEs
X-Microsoft-Antispam-PRVS: <DM5PR12MB1452922720F080FEFC814702FD6D0@DM5PR12MB1452.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1452;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1452;
X-Forefront-PRVS: 0687389FB0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39860400002)(39380400002)(376002)(199004)(189003)(55016002)(386003)(58126008)(316002)(50466002)(25786009)(72206003)(8936002)(81166006)(8676002)(81156014)(86362001)(66066001)(575784001)(446003)(11346002)(47776003)(4326008)(486006)(2906002)(476003)(956004)(76176011)(26005)(68736007)(2486003)(5660300001)(105586002)(103116003)(6916009)(2351001)(2361001)(478600001)(7736002)(305945005)(52116002)(7696005)(53936002)(186003)(97736004)(23676004)(53416004)(6666003)(59450400001)(106356001)(16526019)(6116002)(3846002)(230700001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1452;H:sosgrh1.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNDUyOzIzOllUNVY5UzZPRkJyeUJPTGxRV3VIQnZMeHpM?=
 =?utf-8?B?NTlMYklYY3kzQmJWaGJYd2FvNEROTDVCY0NBd1JBWFlOSlkwa3hqRlMvMCtp?=
 =?utf-8?B?UXlDNGFXV2x3YWozYWtPbGxXQUM0QUs3N2xCVGxGdmVycGMybE9WSkRHZU9M?=
 =?utf-8?B?bGVXNWtZK2FZcENsZDZaMXVQbU1uRE5zWUJScm05VGlwMUVWVGEyZ1NvNDNJ?=
 =?utf-8?B?amwrRkpLQVVseTlKcTl2SExYbGdZdG83V3BKTnN2ZUY3MXBsR2xSWXhRcldz?=
 =?utf-8?B?UmNTQmdZckUrS0gyUTE1Z3lIZzlWd2t5OHEzMWs2RlF6VjBqOGZadEQ4SzJ6?=
 =?utf-8?B?a0dKWFFFMnk4THN6QW1oWG5rSStyc2RpU2YxbTFGZ2lkblVsZFVBbitxN0pR?=
 =?utf-8?B?b3NTeGRybGhwS1JVVlNSWk9DU3BySTJyK2JsaDlSQnpIWitNdHdDZ3NTaGJR?=
 =?utf-8?B?SGRCWUFpV0ZySWZiYUxCbXFvNlVYYko5dVpFSlBUeHBZaXFoQnNFbGNtV1Bv?=
 =?utf-8?B?T2lSNlFndzl2QTZPU2tHZkw5UEtQaXU0MzkzZkRrZzVaWFh6WEFudnBFK0FK?=
 =?utf-8?B?SmZ6aEM1Y3ljdDVXR1ZRbTNzeXhPakRCMFpXYkhLOFVndzZkU1RFZTFDZ2RG?=
 =?utf-8?B?azA3d0liN3h0SGFaU01nMFkzZDBnZ0d5WWk4TU9zeE5EcU1lQjRjenoyMTMw?=
 =?utf-8?B?eExNQ01kUWdGYVdFZE5kUGNKWTVrSnR5Y0lUY0tFbTcxbmUrYk82ZDV6ZnJZ?=
 =?utf-8?B?Q1NjbWpjRkhyRW9VU2c0NExpMk84MjdFUlFTa0lWSXFpeUpVVFhhVTNQMmk1?=
 =?utf-8?B?dFlGQkNzSnQrQWtLNXlSTDJxWkxkYTRCNUlxWk9IeU9pYmlTV1kxM2xPNUlv?=
 =?utf-8?B?WmNnT3ptbHUvdGhyNXVWdGc5aWJ4QW5pYWdTZ1N6M2Z6SjRQSEZTdmFhRmVn?=
 =?utf-8?B?S0JEaGFlUUhTZldqSjI5aHdPOXhmUEI0TXZsUWhGaXRqTXM5UVFmL2hESS9I?=
 =?utf-8?B?VmxUc2g1S05na2tWWWtFcUpTeCtYQWpXUHo3WTJJNWtpSjdwc1h6dDY4WFRk?=
 =?utf-8?B?bXZBM1lHTklqYko3SGliQjBwNEY2OGxVb29pMDBNREpHY0gvVSsxYXg5Y2Iv?=
 =?utf-8?B?M294Y25udnlKbXBBbW5lSkVETTFoSUlJUmNveUxtZ1liR2tWL2IxNXgwZVA0?=
 =?utf-8?B?dkI2Mlg5K2Z2N3FhZnhmVmJwcFNXejNNam13eGp2OThzVldNdTZjUnlDckZI?=
 =?utf-8?B?ZDg1cFJHUy83TmN1YWplU25YZ0ZSS2R5T3JaRjUvZldla2lqdjhmalp0NVY2?=
 =?utf-8?B?UnZ5WVVGcld5V2I2am9VcThFWVdWS3lGU1lNZGN5cjYxMHVLYVlNWit2bHBL?=
 =?utf-8?B?Z1kyMTU1VmtSdTRneEMzOEg2cTEyYW1sWGZJekRHeDRmUjJDR0lWYW51QUxi?=
 =?utf-8?B?cWEvZ3V5NUpYT2NKMTd5RzVpTzFNb1JxNzdJdmRQOGlyRlpaRmNlb1hZQVBY?=
 =?utf-8?B?N2lpSlBVclpqM2tYdTVONUw5dFpvL3N3VjNDbXBzRktOWjQyalc5NHFSTGJT?=
 =?utf-8?B?d2hvU2dZVWwzU2J3dG5rQW8yT3Y1QThQWnV4UmQrWnowWXd2UGxHK2VxeHhl?=
 =?utf-8?B?RE9rVUZYVThVVDhCNHJmejlSa1lFRnpnWW1WVERqcUlMcitUNXFYakx1ZHhL?=
 =?utf-8?Q?2swNAic/mj2ReZQUEm4NXK7mYjJIrjIi17hX6r+?=
X-Microsoft-Antispam-Message-Info: TJU8ZYzv+v9bTKiUhIBiV05mws3LAg098ewMLJPJ4tyZ63EX/IRmFbwtv1kfjqvGX8fzZHE8Kon5yOPqFeynXT+Fqlb70tlB6VfrwcD8RDxuwqUyM7vrd3s1EU3WIV0JlNxLXysOme8RW4UAOHRt/u4BTiIim3Ie7QiSTdkKp7N5SBgEjuGZ6UfO2IoztRtY
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1452;6:Pxu405MLFLHs4CnOUYWes0+c5ThmXYoWVLKTiBU1adsmK4+iudqwiK75oEqjZWbdIPqqr36m1oO6fFGfjrcKZCNfg9c5frZW11mX52rxdXoX2t+sPmDdgcNmZDUMrwetZKGCrJTYg+RxE90efojzPSL3iTOXvSZ4/ln5HX8SvKzEAs/QjAeGgjisCou2JAb0t0t4b01yjUVJDsFPHynPcWCve73Snz5aUG8nAGFJv3BNVk8W0PUNyP5GmVu6QyC8LRGRtUybYTXOh43xR6KzRTFwkFBLVJi9L0mcgzgo+SMLsh5mNo6ynIgU9TKUzyeFlLX9TV8RN7SsiR5kkqr+ABA58rH6dD0uprVckHi9IJa8GIBrPp2WSF9748iFaG7k993WNnENwiCXYQgcxkOb8VR3ZUoGxDJGHWoaRz0jNxbPwQ4WEHRadY080h04U4cjhgQ+CBFdZpdI0joShfpqYA==;5:PloX9/Ijh8+EkYRnTd4813FOD4gCpVGfvwM0RYPZjCRW9o0Otr8WRXz5sftetfHIYTTNHOLdfiPqVOiYQ9t9QXHikJCufWOqxGuYeWN+rgtOiUJOSX/eEoR/M/Wx43S3TMhpiwU65smgqe6qeIl3qYQ9pDt8I469ffujmHUQftA=;24:HfE685oibynoQ0k04aqM9/YI1mxbIqmfS1rFpU224gls70g1M1y8ja30Gr3kHSDVCbK0Sjf78hbnkXAuKHyOy6uCi79qEWYEc0+1ll7nxvE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1452;7:DYRX/Zs5OA1uUX+dvJXUzS3WPqyjHKBy6+EgP4fK48e4fG6zFHcRTAX7swUAqOyBBjK4XVBHfU5Oi+rnFPhqJF2NrtvlSqs5Jn6f32Ky0p5oWpGmi7uNXKAPvZhubzpb3wwuvgSXIJ3Exk7jvXEk/vq4flJeEdSlCBLgHbXM6ejxrYu0/BzEMYC60L0AyTA2GjhGkOrV4WR0kNG8qSEgnRF6UjkaTsAf1Oqn80cSx1uNgm71xaRnr+XRTa05AZ/u;20:Fnvw4XSZKdtUIz26BBnVKOC9CYy5Mz6UPzDXPc1mPYGhWJtShUxwwlRRG/uslTbfT/iOKF3sgeREm9x8eVvr27aBdMU86jUhuCdMrgqPQ+89JSt6GuzqIEirzX2TOv68U186m7ksxfSWWoPCpJPVnI8IoIjpxjgMN1ab7BeU45gZq/NIlJO5XYGH5zxzOEAT+W20BpsbriF8N2xGQmy8Hgw3QIggPULU6U/uhuT2AEOh56jSL94MMiSxmgEg0YP1
X-MS-Office365-Filtering-Correlation-Id: b73491c1-b31f-45ed-2156-08d5c59145c1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2018 18:23:27.1039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b73491c1-b31f-45ed-2156-08d5c59145c1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1452
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a skeleton framework for debugfs support in the
AMD IOMMU. Add a hidden boolean to Kconfig that is defined
for the AMD IOMMU when general IOMMY DebugFS support is
enabled.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/Kconfig             |    4 ++++
 drivers/iommu/Makefile            |    1 +
 drivers/iommu/amd_iommu_debugfs.c |   39 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    6 ++++--
 drivers/iommu/amd_iommu_proto.h   |    6 ++++++
 drivers/iommu/amd_iommu_types.h   |    5 +++++
 6 files changed, 59 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f9af25ac409f..ec223f6f4ad4 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -137,6 +137,10 @@ config AMD_IOMMU
 	  your BIOS for an option to enable it or if you have an IVRS ACPI
 	  table.
 
+config AMD_IOMMU_DEBUGFS
+	def_bool y
+	depends on AMD_IOMMU && IOMMU_DEBUGFS
+
 config AMD_IOMMU_V2
 	tristate "AMD IOMMU Version 2 driver"
 	depends on AMD_IOMMU
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 74cfbc392862..47fd6ea9de2d 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
+obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
new file mode 100644
index 000000000000..6dff98552969
--- /dev/null
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD IOMMU driver
+ *
+ * Copyright (C) 2018 Advanced Micro Devices, Inc.
+ *
+ * Author: Gary R Hook <gary.hook@amd.com>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/iommu.h>
+#include <linux/pci.h>
+#include "amd_iommu_proto.h"
+#include "amd_iommu_types.h"
+
+static struct dentry *amd_iommu_debugfs;
+static DEFINE_MUTEX(amd_iommu_debugfs_lock);
+
+#define	MAX_NAME_LEN	20
+
+void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
+{
+	char name[MAX_NAME_LEN + 1];
+
+	mutex_lock(&amd_iommu_debugfs_lock);
+	if (!amd_iommu_debugfs)
+		amd_iommu_debugfs = iommu_debugfs_new_driver_dir("amd");
+	mutex_unlock(&amd_iommu_debugfs_lock);
+
+	if (amd_iommu_debugfs) {
+		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
+		iommu->debugfs = debugfs_create_dir(name,
+						    amd_iommu_debugfs);
+		if (!iommu->debugfs) {
+			debugfs_remove_recursive(amd_iommu_debugfs);
+			amd_iommu_debugfs = NULL;
+		}
+	}
+}
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 904c575d1677..031e6dbb8345 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2721,6 +2721,7 @@ int __init amd_iommu_enable_faulting(void)
  */
 static int __init amd_iommu_init(void)
 {
+	struct amd_iommu *iommu;
 	int ret;
 
 	ret = iommu_go_to_state(IOMMU_INITIALIZED);
@@ -2730,14 +2731,15 @@ static int __init amd_iommu_init(void)
 			disable_iommus();
 			free_iommu_resources();
 		} else {
-			struct amd_iommu *iommu;
-
 			uninit_device_table_dma();
 			for_each_iommu(iommu)
 				iommu_flush_all_caches(iommu);
 		}
 	}
 
+	for_each_iommu(iommu)
+		amd_iommu_debugfs_setup(iommu);
+
 	return ret;
 }
 
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
index 640c286a0ab9..a8cd0296fb16 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -33,6 +33,12 @@ extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
 extern int amd_iommu_init_api(void);
 
+#ifdef CONFIG_AMD_IOMMU_DEBUGFS
+void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
+#else
+static inline void amd_iommu_debugfs_setup(struct amd_iommu *iommu) {}
+#endif
+
 /* Needed for interrupt remapping */
 extern int amd_iommu_prepare(void);
 extern int amd_iommu_enable(void);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 986cbe0cc189..cfac9d842b0f 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -594,6 +594,11 @@ struct amd_iommu {
 
 	u32 flags;
 	volatile u64 __aligned(8) cmd_sem;
+
+#ifdef CONFIG_AMD_IOMMU_DEBUGFS
+	/* DebugFS Info */
+	struct dentry *debugfs;
+#endif
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
