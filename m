Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756141AbeD3T7D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 15:59:03 -0400
Received: from mail-bn3nam01on0066.outbound.protection.outlook.com ([104.47.33.66]:46976
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755265AbeD3T66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 15:58:58 -0400
Subject: [PATCH v4 1/2] iommu - Enable debugfs exposure of the IOMMU
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Mon, 30 Apr 2018 14:58:49 -0500
Message-ID: <152511832970.8963.10801049423048266747.stgit@taos>
In-Reply-To: <152511783026.8963.5818249217042882958.stgit@taos>
References: <152511783026.8963.5818249217042882958.stgit@taos>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CO2PR07CA0052.namprd07.prod.outlook.com (2603:10b6:100::20)
 To SN1PR12MB0701.namprd12.prod.outlook.com (2a01:111:e400:c42a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0701;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0701;3:GkZXWzX4IzBl03ieUPBDYWBci1erIsucEbJk3aGeK/f5Jcrh9TBjsJseQFElDRUYC08Oy6XThUlqUXdWFy8Q43FBD2CGO5czQ172SAIPUhhFU0urvCYEWsmVmLgzoZz1m5XyCLcx+bQmz2jnOhvTSqh1YJGENlmOmVO05U2gOXQqMacBCHsJaldiELAt5fD056tgUtEdjGUf3dgZfX8LofyjiV+5kL0HmhwuTXXF64oNyiF9Ld2cfvPiunCKknXl;25:3qLkOpgay8JFhh2vTWny/nM4AYVprLyBDwhJWiJ8Kl6+sTIu5Bpdc81paKnaQlEVn3el5+FOXYQG23NWxGfkH7nSYEh+hViygOYLAKGAK5TeLy6VxDNyGzu2neDzLYyfUXrbQLXt1U+reBJcC00FwV8kVkRdgzG4VXj7JcZS7sMP3b8q1BjqbMJPlAjYJ9d5IZLN1Es+DU3TvhkGRcuDmYl/iOi8PeJHoCM0HKoxL8yspVZk205KnamlwXrNw80erz0OZ7m8JsUmp6Q407JQCIud66IUZTe3pWVXut/M4qpZCDJwLbGltBo9wTGe4qQXxpw5cah3aI+wZTsQ7QM7lQ==;31:j95RG2c2uNdx50HE2+6FmEmBmBNw0ZtAS7q/mNt9rET4uTo26rQX1wX5J7ou3zkTnwRl+9XgFMbtpZ38+mhZmArc8M8Kr4g+RyEgxRYhD/F0BhNKsNZNAlRgO39svikLNgZOAIsblviXhHCGz4JMuo5/SAdDnGqSXZgxFc1oQMu5q+ZvdWL2K6uY4DkmmLDKezEunyn0RuxHa39Fcy4i9Zq/9Ure9QBToCtcq0dUKQ0=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0701:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0701;20:uKCqEOHwsaJWEafVcwa1HBDtTCAnkF2Kn8U7gBpHDszTGsJfCJ4HitIAP8AOUQlLpYn+qjvKMZ05DDvBC4Md2qlzvIJjEydSlZSuAvc2zHz4lU33m7oK0V2R8TTmM94VSMxgxcSjQtdeixHljXSXhjokPCiw7seDD+ZG/ajNaAY20AnTMGLnlAc03ofc0VISlbqYMtjKy9wjZEYzwY9kPnC75NojLoV+HscYxV21JyR19DvKOEHFUhYQ40x4l1oBcJhw6DxNvOU6t6nL2bNo3kkitUZYFKveA187P+hK2y/KymDH2VW4GWtKFHNx4jOMvbUot86nTGYpH3Z+VmOB4LlQhEGln8jFswZDf4knzVqlsytnRp2R8ojssQ3HAv/49g4Q45vqvneRZhlEFzVregoOp2ZyjkoX0dr5oLFq6uEoCQ0kLgPK2vgCCkDxGhSo1GTxYK4eKNy1WkDtsT4iEgRF/azEkmYsob/zyzeNn/O7Lq5weC+/HuzI+qzIKydl;4:d2mYSV/oO2o7B5baa6Xf1pmL0MgCxCSaao55UQb04ZUeCXCwc853uiGLOOLIO9jf5Y0xBN5hTSEMQ7EotgpROu0ZfY+/7oOSPtmcOGEMYVndsPn90HawzcRKGNvHZ4Um3/+HbjrYmSNtGvr8YHHrVPH5YoEvCjD+beLLR2Og/WnfYiIx8VAb8FpUrOG9kooHsPgmeInj3kkAidWgweYG2RJr1BXRhx8WnKy9Z+HpyJ1GjIscvdL41k011SoZrYgmLAW2UC4BdNmdmh8thZcXJWAi5j2KyzBpG/0F7Wot9/02dOByHHE7bmyk5XxRdOhK
X-Microsoft-Antispam-PRVS: <SN1PR12MB07016FACDFFE09E214C85844FD820@SN1PR12MB0701.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN1PR12MB0701;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0701;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(7916004)(376002)(39860400002)(346002)(366004)(39380400002)(396003)(199004)(189003)(26005)(50466002)(105586002)(68736007)(486006)(3846002)(103116003)(230700001)(2351001)(575784001)(72206003)(2361001)(4326008)(478600001)(476003)(6346003)(86362001)(5660300001)(6116002)(2906002)(25786009)(33716001)(305945005)(6486002)(6916009)(6666003)(81166006)(33896004)(8676002)(8936002)(9686003)(2486003)(23676004)(52116002)(956004)(58126008)(7736002)(53936002)(386003)(11346002)(16576012)(76176011)(77096007)(186003)(59450400001)(16526019)(97736004)(106356001)(446003)(316002)(47776003)(81156014)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0701;H:[127.0.1.1];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwNzAxOzIzOi9wbGtqbHlFZWo1WHZLY2ZuNXlYYkRFNnkx?=
 =?utf-8?B?QXcvL2hnbHFjNWY1blAxajJmR2xBNFFvc0xUNUlyK0tSNjZpamI0SitnVXpS?=
 =?utf-8?B?M1ZPNmN0VE1DbCs2eEFDMzFnWG43ajdFQTRtN1cxVDArOGVzQjl1bENtSTNW?=
 =?utf-8?B?V2RqQVFzZkloY2dBc1dLdmFlbm1HMllEZHlVMW9YdkwvQ09vV1NnM0FQbnFP?=
 =?utf-8?B?UHFmb1FjL3FVTko3bzRpN0thYlRWL0NlQktaS3lQbWQ5MHgyb1c4MCtEcTZ0?=
 =?utf-8?B?QUQyWDVNMmtJUllyNW9mMHMxQkNUWnBPOEVmUUFaWnc0UWQ2OHNVMHlnT2Vr?=
 =?utf-8?B?K01WVi96eHdJOThHWXlPN3ArdS9uekRLN2ZjbjRSc2VXUDRKY2dwMEU3MmRP?=
 =?utf-8?B?KzBSRjVqczFxSUVPNVZwanF2QWR3cEphWGRpYmxQTENIYjFFMWJzNmZ2Zk50?=
 =?utf-8?B?NndUV0RnN21NTERHMGdaT0ZFdXR3bWUwbXBYZmFHOUJsdUhaS2Via0daeEYw?=
 =?utf-8?B?RjJZN1o4NFpIU2s1bytlalRiY1FUWDRuS1pCdVJUalVDUWYrNTYvNmx5MXJR?=
 =?utf-8?B?YzdZak9QZEtIdkRxQzNOQVU5cTl5RlVVSkp3SVM0N2o5aW5pT0hKaUxFNFhU?=
 =?utf-8?B?N2lBaXVpbkZMdm5ZN09SUU1NdmVVNkV2dk5vVGpMSmNDZnI1VFk0TkNUVUJL?=
 =?utf-8?B?dGRyZW90NDFtWE5CZS9XdHRPb2ZEMTJRZ0xVbmRUVTM1Unc2czh6WStleC9p?=
 =?utf-8?B?ZWJOM3hseFJzazgwQm9hNTBJTm5mZGxoamNwV21mOUI0a3VldXg1bDlKOGgv?=
 =?utf-8?B?TXp0SXduMWlDVE1ncUMvWkZoWWZXdFRndHl4SklQUWdiS29Sc1hST1pFUHpM?=
 =?utf-8?B?KzQxSFdwSmM3L1lGWk5DTGFib09pSk0yc3dTWGxkNXA2anZoVHQ5dXliK3M4?=
 =?utf-8?B?c2E1dFJrYUIwZ1phRCt4elZ2YTFLV2NJa0t0bE03RVFxY3R6aGpYMi90TTNX?=
 =?utf-8?B?NU9sRmd1MVRvNW16eHNpSlFBRDNETUw5TkJ2RStiTGZydHRUZjAxbEhsL1JS?=
 =?utf-8?B?dURvdmtocFpYVEhTcHN5S2NOMU1vMXJIUWhuTUN2djdBekVmK2xmblBCZk50?=
 =?utf-8?B?WW9MMVZHZHMzcDd6REVIT3EyNGI1b09qcXVnVG5hMW9vcXBabk1SOXZTQzlk?=
 =?utf-8?B?N1V3OGNWUkZPWmF2S0FPUTBxdzU4M05tL1RaRENXOWthWlFFTGF6MkRkVzRy?=
 =?utf-8?B?UVd6UFJaMDZiT1pRTlN3bmZIeE8zdWxwamFCb1Y0TW1yZXloaFlZcWxwckNv?=
 =?utf-8?B?N3lYWkVRbTVjejFUVklUemdwaXlMVDF0NEtLWjJISnB2dnZIbGNLM1p0YUgr?=
 =?utf-8?B?eHh0bE9sT2ZBT0lxSkpEa1VEQzhpL2ExRUYzRmF1THFUTHorMFVhcHhRcE9M?=
 =?utf-8?B?bGJxaGJVeU5qYjdybEFVYUd5VllYQnN3cGxpcEJPdmpnNGYzdEJDajlFZ29N?=
 =?utf-8?B?aGhqakd5ZHhMRml4QTNJcm5wTnU4SjAvdVV5NVRkSFJSeWNOeWhGdWp2aGYx?=
 =?utf-8?B?eEs4Wk5TM3MwOU5EendkNThOLzNYZW11OGp2dDI1aXVpem5WZGttdmdqbVYr?=
 =?utf-8?B?ZExYd2ZKTnNQSzdkYy9DZGZpMEFsQm54dVNmTlNaSjUrd05xb1djazE5RjJk?=
 =?utf-8?B?Y3NoaXhITzNVMU16Q2FzWGtTb3FCbTdDZUIxeEh3R1Z5Q3hHdXRUTFZSa3RP?=
 =?utf-8?B?UzVEODNpcDRSSFhZUTFEbXIzWTJscHVJY3lFUTdENGNHV1VTOXdLb21QSHVX?=
 =?utf-8?B?akdNRU9GM05scjNmNUwwR1pTcU94dmZ2SytENkVvSzNONWVpWnRBUTFKN1FY?=
 =?utf-8?Q?22STtjcWVDowZFR6LZorDDcqWeXVB2pC?=
X-Microsoft-Antispam-Message-Info: 07Qgn3HhvFH6lFE8Q60dgYLyH2TAHPc8I0oFP3wbWTqUkExL+DhQLCoRdAJEXh1df3O7ApmtOyl0PmkPDjqM0I+E80syzALjxz/r5Hx0WzJfbxPjBa+dxfzKg8wEP2KozhS1+e+au9Fl0blpv3PwwxTIMtwFWEmqPEgv8zaGKdUebAFgceKTMUqSUiZo2/Ya
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0701;6:lqToICoUGSaYj98TAgK8Or5L7pKB3XREPta4LeJotE3fRuGU5Z2r4+mW/kjaw7wvK9Yt2GXy0CWADlE82B3oJDExvp5V9cOTyQe3vlR95fD4kHQDO4RHBJuixwfMl5I8oA9Ss+amxj2mAtyM9f/M65d+twbeynkd0mlcLPNvgbdRTx5r0jKplAUWhKYPheA++TqgkAsD9AHKw1L7nr00OIHvqWww9WL3SNCmyEnBeOVxs6b5JcptJWn4n3xH23btGuQbRIMaD0DP0pD+fqmwv6smtbxCr9/NZb3sDZcD13cB+EV+H7o+3JfHjIg3H4DwoGtc7CfJnYYkMvZhcc/M2qfhQ9MwFISHD7S/ooL+h+FkAvIkXU8wvUqsva7/hYchUlFt6frJa2j/wO5QJLPWuJ31lh9X/opfuW0owDzVH2j9dyF/+4h5OoNyF+yXnz410P0Y+TYJzWPbBNhRHcRV6w==;5:GqaQKRl7UTZllx9jEw0RrvtdlthKPh5sQwxuOwx9mz4bghyu2vYDlXC/06YerbpwBpc679aNY7LGF57M28DGkNwj6/ww/tnP4j75f7DIGWkiz7nh4rHfV297NEXr3ZFjAY4knlho0furtiSiduucV7NtDo95XivseI1zBEvURDs=;24:JrqkLnhGTZpb3zGwgxYireqdqUoRKJ/5LBbhjaZZzzYYYtiuvBnThtko/seROfJdqSAeH/O2km0cEHCI+/ylhdKZfXaHhoy9a3ULlMGWMaA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0701;7:O3pWaDz8o99Emapv33rpIp+nt68I66Cxjr+Cm1Tu+INzmM9OMsp0fpF1MXQHzXuLJDpNBgGSR9VX6AeMoph064HAEjuJGQw0M8lj1z51u0XeqS2WKubsTrl9r1DaMGMgNATmJ3rQc4oxeL2HMPdcD9ntPQnRZTdGi4PwIbr+IIed1E3pH914ejl6QOSZ3jVbY//mNv2SvO0RAs1nnDQMCdz9aVaAG6lrRew6uNKdPNtSNcQmuwHoN4OeodG5tHC1;20:rkKj87aVUfDKHft6+VCNRsWGJC0PksptmIZ3ih4a83SJVZpvlLYPEGtRoi/yEm6HYRsNvvO+3t9q1AYL1MmO4FcxmlzPzI+NO2qc5IqLX6IjLB+uGaDxF4T1dSz8aE07gRwY+wk9tuOv5yHWr0kSWRE/z+WP/6/71wrRHbPzMSCpCHoQhhQ5PEvdjlCiD5q/hf7Fj76+clpnDTuP/UfVsgP2dqhtZqNtOr2AxKzKtIpCiY6Pf8L4tqDW1fzakHiY
X-MS-Office365-Filtering-Correlation-Id: 8060b203-f252-420d-969f-08d5aed4cdb9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 19:58:54.2772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8060b203-f252-420d-969f-08d5aed4cdb9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0701
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
 drivers/iommu/iommu-debugfs.c |   55 +++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h         |    4 +++
 4 files changed, 71 insertions(+)
 create mode 100644 drivers/iommu/iommu-debugfs.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f3a21343e636..81a6c281e69f 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -60,6 +60,17 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
 
 endmenu
 
+config IOMMU_DEBUGFS
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
index 000000000000..409691ca0ff9
--- /dev/null
+++ b/drivers/iommu/iommu-debugfs.c
@@ -0,0 +1,55 @@
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
+	if (!iommu_debugfs_dir) {
+		iommu_debugfs_dir = debugfs_create_dir("iommu", NULL);
+		if (iommu_debugfs_dir)
+			pr_warn("WARNING: IOMMU DEBUGFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL\n");
+	}
+
+	return iommu_debugfs_dir;
+}
+EXPORT_SYMBOL_GPL(iommu_debugfs_setup);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 19938ee6eb31..e5657c70f90c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -698,4 +698,8 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 
 #endif /* CONFIG_IOMMU_API */
 
+#ifdef CONFIG_IOMMU_DEBUGFS
+struct dentry *iommu_debugfs_setup(void);
+#endif
+
 #endif /* __LINUX_IOMMU_H */
