Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751743AbeDDSzR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 14:55:17 -0400
Received: from mail-bn3nam01on0062.outbound.protection.outlook.com ([104.47.33.62]:35248
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751693AbeDDSzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 14:55:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v2 2/2] iommu/amd: Add basic debugfs infrastructure for AMD
 IOMMU
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Apr 2018 13:55:06 -0500
Message-ID: <152286810663.3286.1200646003836116320.stgit@taos>
In-Reply-To: <152286703837.3286.11286329185822795742.stgit@taos>
References: <152286703837.3286.11286329185822795742.stgit@taos>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR1701CA0011.namprd17.prod.outlook.com
 (2603:10b6:301:14::21) To BY2PR12MB0695.namprd12.prod.outlook.com
 (2a01:111:e400:52df::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 811483c9-57f4-4068-bac9-08d59a5d980e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0695;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0695;3:GXBUYnZSmPBNZC+YtWojWVn6pZM1t+nfnT/DzydAzMEYZg15iA1kIsN37EY66IPxGIcC595et0Jn7PpX9dUmjorZih24IIkW1DfaFNNlU0u31q0ZTb5R3kFqR5nrrX/4DYynkvUaRpPQGTKW06yT21efOrHxnoufnPFDfZrb1trHnB7DFcJzBSUZVQU3oyV0SHrtN+xvHpC/lUg4YOqW+CQQsHEYU//d0aVmTYfaomVVlqdIRKA8bY9W4Vds8I3K;25:9G5yLk9ngiFjB66bsIAKeGltrS+l9Qjq5IS39Fu0qnmmM0kpmnzGref/76LQgICMfDWzpfDvfCt48g6qmz6rjM9IY1JRcvAshYpptYxTX3QIu2pCSP+N9Mhgcx8gMpr0opc8mH0EHQeOvrOg2d6bunuouPfYa2HBdICUox80E+UMTxS0pPXs3bWDlmJRVN9HxefFOJ+NRYqB1mYY72hpYYs2YlDu2IdBfWMOEIeV88NH0X5vPdNjO6PR+vVDIrjSG7vbDCz8lLzc+uZk5lf6sfMg2IL346yOUhWsuVDfB2T1GQsX9g3jpG/xi94Qn01y3n82J7NW/n0csqTDorrJ8g==;31:gTxTpTau0ZNMCy65DNcsLN0toYRRigYLzyVTZiUYqXP6Dn2FYHXPBIY8cUdllGWtNQapL+3XFlPf1Tf4pp4yx7UCP/4O/bOoag98tNjyw47qv79VLnjRSMFBg5PxR0LL8fi99uxfat5xY2Pyl+G4MEGgwjz6G1FpA/CtEG/bkdvvU33Pz/5WDjrgdbUT6jdtBb14jMrYxgic+hCYDamJ9JCMYIYpQyc2MqALF4+WyyU=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0695:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0695;20:hDgs5fQVH+oevgR6KGGH7zjB28RopxCph2x4XFCvAO4Hhn7D6HpNZb9pRkGGu5tInay2oiJLQzGQfEAAsgQP48modY5Aj0BZ0C5StbFyVDM496WUmXJzKI+ba1QizWn693wEhvyzAJTYw5/ooZgbpKjl3YB7zmWBzbzfrgLhgW9UOi7ILdQWCmYyNiwCKbJLYwDrh1X1Gk301HF5F0WIfzhLFFh9OvF+zvRDkwj4tq1Oi9JKknBbdMdeQsCMz1jMKF8+r3hzEVUqDn1FnHXsUVFVzYvcxZhiG9cDGSilZwDzrQveigzmctjSLXnYrtklBW3GKyNqW6rXiOvf6kNKNngcElSvlo+3wm0Y0ocAf9j/lyMna+bQc8F5ctf9zq/gI00NU7Tf8tTRebciP99HYzGFQz4A+DUrf3msAgc8W6uEnQrtFpXiPzJTtu2WKPCyGCPCf+sxvxDvWsr7HdUmFypT7CRgXBpnFPv8oOLcMeCubjSMOY/YtzckUu1iZzGm;4:Fp5+WmsAXckXnDn+fXye2hrdpdWapHmtD8I9xnk4JH3Hzc1jsuVgcCXyzyA4KBdTK8asReTeSmWGFrg7qE5ORqPJmluw862GvadZX9nJNhvYwK9GE5a1NySFPxhcOzkoLjZakT633jHJMuYhEnAoBetQuUMTabbjYAdFeDCuSNvmRl8m2dSJImvWElyJs7c2mI/py+exdux/vBRijtzWY4i06EacvbFxdpgHECWLEwCruOWDEEKC9PToEUavLg+dAEbw/j+G31rfUBi6gpMB/IjvvWxut8VadSiqXN1CwFvhWwqklZbCHH0iRuBwmhNg
X-Microsoft-Antispam-PRVS: <BY2PR12MB0695529147E9B8500DD01B4EFDA40@BY2PR12MB0695.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BY2PR12MB0695;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0695;
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(7916004)(346002)(39380400002)(376002)(396003)(39860400002)(366004)(189003)(199004)(2361001)(103116003)(52116002)(53936002)(105586002)(6486002)(4326008)(23676004)(9686003)(25786009)(50466002)(2486003)(68736007)(7736002)(6666003)(2351001)(97736004)(6916009)(66066001)(230700001)(76176011)(305945005)(16576012)(5660300001)(106356001)(8676002)(386003)(33896004)(2906002)(72206003)(186003)(33716001)(16526019)(476003)(956004)(59450400001)(11346002)(77096007)(26005)(47776003)(446003)(316002)(8936002)(81166006)(81156014)(6116002)(486006)(3846002)(478600001)(575784001)(86362001)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0695;H:[127.0.1.1];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwNjk1OzIzOlhvNFd5OFZFUWxqbko2NjJPTVlmVndpSTly?=
 =?utf-8?B?NktMazhZSDZaRGJYRXhiOFNOdmxYeUZBcDVYQzh6b2hpM2NPKzVtQ3h5dllV?=
 =?utf-8?B?WHFtemNCNzNUS1BqdVF5eUYzRFladW5qRXhZZ1Q3ZklDYVFEQlQxakRKazlB?=
 =?utf-8?B?bmp5MWRod016K3BuRlVBMktadHBzc0ZJdnVhTUZYWG15T3dmeGVGQkhod0Fr?=
 =?utf-8?B?MDI3K2xyRzJDTjY0T0R5WHA4bURubFdVYmM3ajRWOUdCN1Q0eXJDUFhjbzMz?=
 =?utf-8?B?cHpFaXh4M25mWkhaRk5KOEM1N0svR1lYQUlFeHNNYnowWHlIQi90ZHJPYThw?=
 =?utf-8?B?R0I3NjdQdlZGS0NmSzdXa05vc01BaVRKVXdSdlRpM3lpWVJ4SDVTUSs3c0FC?=
 =?utf-8?B?bnpJbFp6T2NLenhaYmdLUFV0WGQ1MzAyRXFndWEzOGpmN0lrK2ZkOE9jYU5r?=
 =?utf-8?B?MU5ieEZxWFpEMnhuV0FkMWdmNGVYd0o3OGtUNUZHcERocHcxdzVkY3g1UjNN?=
 =?utf-8?B?YitjTCtybnpEenB1T2FuUXlsa2gxaEhSSnZmdFJWSndmcTcweERTZ3c1eitZ?=
 =?utf-8?B?dHhyeHJIOFdxTDBKK0dYbDFSalprR0hlcy9HcUM0RGhjbHFtd3lHVXdSOGNs?=
 =?utf-8?B?QzBFWjM0ZWtZSkxnbFlIQXR1amJCNHRtUGkxdENnOU5ZR0tVTk5QQlJlaTBw?=
 =?utf-8?B?ODFCeHBFMUlpeFYvNWNkbzJGT2xjejdpS0dRWGZ0Si9OTjZMM0F1R1V5K0Vw?=
 =?utf-8?B?WHgrak9Pbzk1MCt2ejhMbkxjNGFZUWVGQ1RnVlM5YVJLSWo0UUZ3NEdVdlYw?=
 =?utf-8?B?RVg2T2lob2w3NXM2UkxVZ056RGNqNFF2cjh2WTh4V0RkMC8zb0dtMDAvRkk2?=
 =?utf-8?B?OWhCVXY2emhBaEQ0bDdFM1F4LzU0NVhZc3g3YVZIL3htRDR5azB2YkJLV0VI?=
 =?utf-8?B?UW5SYjhyOUtUd09Gb1k0TitGYWxvMFJraTZ3ckZjUEg0cXJRTG50V29RWEFm?=
 =?utf-8?B?bDBUMXFoOFE1Zm16blV1SlBxazZEakVjaWwyZXh5TURiaGxOTmMrVERkbnZ6?=
 =?utf-8?B?Y3BKVDdRbGhGNHRIMjRicFRQMHQxUVFZVUorb04wTngzcHlDazY3MitZOU42?=
 =?utf-8?B?N0FHUDJSWGJobFpzR24vSnZ0anVpQmVsdEJGZ3BhbFdTdXpBMThsQkpiSng2?=
 =?utf-8?B?MEtSZDkzNUE1TjhsVkc2SGNJQnJKNkJXaGYvSUJmZE05dzlqNXd6YnJCUWh6?=
 =?utf-8?B?am5lMmk0czNNcUFiN3Y5ZVNUSXZnZkZoRkZLOENlcXFDQ1N0LzhoWjFGbzMr?=
 =?utf-8?B?U2JqQlJOeC9uNzA3ZUpPbEtseEY4cThzQnAvN0luVE40TkljMFdMRElwVTBJ?=
 =?utf-8?B?aU9CNERlajRzdkNmWXBPaFdwbUtHOVJWQlYySzRNYUhXYTNCZWNWL1JSVXR0?=
 =?utf-8?B?ZmRWejJNRUI4Z1owU0hoNTZVUTZ3UVRpdTRKS0JEYTBwMFFQZHp3NE1ncGw2?=
 =?utf-8?B?eXpTVW93anpyWVJwL1pKUWpQeWZYNEdLbVMyK2FLZVlsWDIzQyt6REZLVExt?=
 =?utf-8?B?TnNYUndpb1UyU3JPa0kraWM4a3hGS0d0R01DVGYvbFVtLzJyWG5kQ3RoLzVZ?=
 =?utf-8?B?Vld2RFkzY1ZVcWpyS3R6YUczeDRReVcyMzNkcmdNU3d5Sk5lK0llMjRUNExG?=
 =?utf-8?B?Q05uSnIzOWR5RXlpZGgwakpMQUx4Qy9odnV4aHFBTFp3Q0RSRVJRdzl4Q1Rs?=
 =?utf-8?B?VzNveDJkb0YwSmo5dzQrdnBsekN1WDZobTdJZ04zVzNDVXIycnN6QUJMWkcy?=
 =?utf-8?B?N09DK3dsSjBGc3ZsNVp5dG5xNUxxcVltQjRRSW9jWkdRUUsxV2VJR3RwN2tD?=
 =?utf-8?Q?v9AbZn9R5KI=3D?=
X-Microsoft-Antispam-Message-Info: GjY4yk8H14TVag8AOok5q4I9iBS2k5IFzC/UMRA/R5xMN+5uE9znAhtQgD1/Z08dBf6KrqOHfLfBeceCmpzjkSk04BFCpPolb8de5vJhYd5kc8Q8rSb5NIiA7pjvbLAgke7tn/E2ybAFSA/SUr1ncsrP2A70mO0cneOf4cxGEbzHMsBlYJJ+4UjGKAOf0rDf
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0695;6:+CGUPRuYK5m0p2UeZFkHKOcTvtRw2OqKNSqCddvwSczLUQwm8h5o5wHhEKHUzlUjsQ/fBACjlKqOuXJjRzuY4wIYUx/3U2Nhh61TDb9PX3QxKESbGOtttAEUw89ybQqcaMXuopymu0b3xdkMltpWkCRrnN8tJGjeRTZ74wTnhhH0hzS1Pd3qT3oJoLUpQgErdutSiS/zauoZGMWCuy3owpvEUDRAkVJSXQcti5ZEbVI1K5iOmQXq1ObSOlJaepnGOW2id79jKfN2rMtB/hovSvfqM3cHbXdiMnn9vSTsvvL4KRneI9gY1jHgL7f7FN3d1+Pdxnj+r4RcjVW4ATpa4t9Am45bn8L0ASaFWEOTVobhNo8six/0qo7CDecDiinNFoJy9mZtz+wPQBQoHiXfXZTkOLOBrdKahzjZSXHagGj1K4kRHOOE1rNY6f57kFIAhAqwAxablS29eheVTc0UIA==;5:VoBVETu55mBFh350ReKTmngi9Y8Vqlj72E2z8mLlVTz6eJw3cmh1t8KgTD8Hthsv8442QmQMXk0UKlYyoqC5/UjhyRVW1A96Oyw/Z+K721ZbtW6Z8EcBjNxFMwg01E1k7epTVsBs8c2IBlh9f92tn0GEqu1+jBgy3R62q/yXrLw=;24:OlQOYSDpFX2yVWGK4BgrWjyfXlr6vbEgdiIZRvmzxD+94muliGmnHK6dtHoYkqAz+LlqXrMn8ldDaDIH44VLEM/D7WG4Q62lWudw90yD+yk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0695;7:/QEszLjmqObrjQ5dJG4JmdnB4/AlFC5Yg8uoxftEVq04/KqpyJyod3UFKniCv/Ecc38yZlu6gUeQTirHj7UeyTCIn5q3OQheAHUHsav0USHcPfLlrVy8+wtYz2oxNJSftQRr7fm5lRQLVs5lQXUuA3QzDQnnjnVEUS6Av+PxZbVV6TJbtkdlj6fYy5GkmgzV2Pql5FweCK2TQ+119qn8OSivfSAC5VgF5/Ei03b/c8J14w/mnbW9qahpBz+KJXz/;20:uAFX9IAwtG9bt4ZDMX47j28l4TqNHS7/lL4vNaPZAupciCOZzB8QMdKVcROEwD0TGpI3o71kgTYH7EMOVvmw4xCa+V8v9B9UKQw+Vh2wPLAJWNkBmZaqta5QdPbmydU0FfKesffh+awF5JrPskv7sFYGb2t7BZVEA6DsrovKTQkr7GkbTJWk3xT1C+UUrMF4s8b0REIiKFOxBaDA37Qam5BdCfg2WpW67BHEEndDiNxEFDf7SKi7+OzYNiV3+lgM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 18:55:11.0124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 811483c9-57f4-4068-bac9-08d59a5d980e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0695
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a skeleton framework for debugfs support in the
AMD IOMMU.


Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/Makefile            |    1 +
 drivers/iommu/amd_iommu_debugfs.c |   45 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    7 ++++--
 drivers/iommu/amd_iommu_proto.h   |    8 ++++++-
 drivers/iommu/amd_iommu_types.h   |    3 ++
 5 files changed, 61 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 5eb1121d54b9..0ca250f626d9 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
+obj-$(CONFIG_IOMMU_DEBUG) += amd_iommu_debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
new file mode 100644
index 000000000000..282100a655b3
--- /dev/null
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -0,0 +1,45 @@
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
+	struct dentry *d_top;
+
+	if (!debugfs_initialized())
+		return;
+
+	mutex_lock(&amd_iommu_debugfs_lock);
+	if (!amd_iommu_debugfs) {
+		d_top = iommu_debugfs_setup();
+		if (d_top)
+			amd_iommu_debugfs = debugfs_create_dir("amd", d_top);
+	}
+	mutex_unlock(&amd_iommu_debugfs_lock);
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
index 6fe2d0346073..43856c7f4ea1 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -89,6 +89,7 @@
 #define ACPI_DEVFLAG_ATSDIS             0x10000000
 
 #define LOOP_TIMEOUT	100000
+
 /*
  * ACPI table definitions
  *
@@ -2720,6 +2721,7 @@ int __init amd_iommu_enable_faulting(void)
  */
 static int __init amd_iommu_init(void)
 {
+	struct amd_iommu *iommu;
 	int ret;
 
 	ret = iommu_go_to_state(IOMMU_INITIALIZED);
@@ -2729,14 +2731,15 @@ static int __init amd_iommu_init(void)
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
index 640c286a0ab9..1cfaae28c2cd 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -33,6 +33,12 @@ extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
 extern int amd_iommu_init_api(void);
 
+#ifdef CONFIG_IOMMU_DEBUG
+void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
+#else
+static inline void amd_iommu_debugfs_setup(struct amd_iommu *iommu) {}
+#endif
+
 /* Needed for interrupt remapping */
 extern int amd_iommu_prepare(void);
 extern int amd_iommu_enable(void);
@@ -58,7 +64,7 @@ extern int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, int pasid);
 extern struct iommu_domain *amd_iommu_get_v2_domain(struct pci_dev *pdev);
 
 #ifdef CONFIG_IRQ_REMAP
-extern int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
+int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
 #else
 static inline int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 {
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index f6b24c7d8b70..43c52797810e 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -591,6 +591,9 @@ struct amd_iommu {
 
 	u32 flags;
 	volatile u64 __aligned(8) cmd_sem;
+
+	/* DebugFS Info */
+	struct dentry *debugfs;
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
