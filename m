Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756172AbeD3T7M (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 15:59:12 -0400
Received: from mail-sn1nam01on0089.outbound.protection.outlook.com ([104.47.32.89]:45568
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753900AbeD3T7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 15:59:08 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v4 2/2] iommu/amd: Add basic debugfs infrastructure for AMD
 IOMMU
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Mon, 30 Apr 2018 14:59:00 -0500
Message-ID: <152511834052.8963.15911033411570981710.stgit@taos>
In-Reply-To: <152511783026.8963.5818249217042882958.stgit@taos>
References: <152511783026.8963.5818249217042882958.stgit@taos>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CO2PR07CA0067.namprd07.prod.outlook.com (2603:10b6:100::35)
 To BLUPR12MB0691.namprd12.prod.outlook.com (2a01:111:e400:5951::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR12MB0691;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0691;3:rq3fTyG2g+P+YHX33EGzrMbC4z5itSwiajBxWQlK1rnI3DlB7bW6eLrtv4y2uxphOkv16LnMywbcetZP44LuLo0KkD31ruWcsBMykvg6dpxszP2Mm/YPHnL6NAy7jC04s8dY2bHxsMa9KSYyO+x9W/k9CkyFtlZEzrUYx4yjj3WJOV4nv30UEKys7CjhWUJvDkgfDfB/d9mMB2OzbyscLO65MUh4hDJe+pWhNIzQvqoGWGiOUTv3HxyWu6zjVsDi;25:SmUIGxVw52p4ZFkr6eTNWmrfRfUFEs5oWODKJVsXhAlzLMX03I3lOlMC3rUtLE3ETegEu7fOVuMyE5m2e3Ra1HAfzIwxUF3zakFCNmQrlefpipCYHRTTPF/86WW9znJ9zmewDl4yrZF8BBWSRXcN15yHKcC7n3krBpqnz1f3E+4qYs/ygSyCu35T+YB68XtoK+NATvZM+SmCbxrtsOCmvTRACMjE/9gobsu19oOaNh5FNqGe7nyMjXoXo+NLYBNS/jfdU3cLtSmLMLVY/GU69MsgQbP0WA4xZjpJkMtycTVeC08wQ8Q0h9KA6CAWsSPGM3glHu3yCpvmsbrmquPA0Q==;31:AJHpK6nJpdc06yUTwdYULKGpa2284+8HbctiFgzHaoDI+yhTsS8fWdEisg0fQsfJ7QErpT2qH1Nj1H6fXvIizxtQVlqQTozeDTZcp4h9n5Ru4pAfsQWpa3rHHM41Bw+yU+yrNytYSIBQTrW7Ir8PnkzWgI8hCLLwDYAp0LJ1UxTP2PXVQ6C7zrPOTougR/WifZdZPbR9tWkXTWGNgwa0N/oH4oafQZ8mMJma2LD+nXY=
X-MS-TrafficTypeDiagnostic: BLUPR12MB0691:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0691;20:hiet56aAy6W5Ay6k3AMHWBHqnqDY98LpaFPY7IQuudLEM5xHv+uSBwkNIiVcdl+SKFLLzIJ3VlDHLX/vzVFSpbyMY18U2k/nzhBJT1l150V/uyCHTqj2k9o2fOsS3KMOFoI4ihiRzRPGha9uhWzJbEX6idRO8S3rkPSwmSk1oPLlXLo9AUpFdg4Dkaj3g97nq74I08WO8IS7IBYkQrccewJ84luammFnjuwvFvPofgXVqejCNtQ2rVBmMWzJxa38pxEBCJn7DVVzMqq/t+NzcLXEN8SMvH4ALLGEWl+oXkwHAGlPv7QR4m8/0teYv1suLjInvqsGKENnjxoKVPgIWzgtWQ4F5xfoz1oXmNYI/X5UIf8HOKNeYo38QR/WZh8wjBBDIz7u6U0zWRssLyeVqHzysPAQJk0GgkDLgqAHpnQN2udp7DAqei/16ZD5RQ+XWOO6/VOL/TSCBYxNugkrqCy7080aVnva98voluSLeXirRMWJMDbTsuM0sbw0BCuN;4:l/Wa8gp7JNGeX/zWtcvuOsufctEMOa9SmMYHE9oNpx7l9KNvM7DLGfQY6UW4yRN2TeRJlURH3GfuoWeCBxNOaa9mhO43e1r2RFNkFnp/r/hNEAQVo1sAiAgJ3uiOsV9pxsGPyy/egUAiQeIyF0/IlS5luuu6sf4S3wbJmokKDJpHO74OZleUXkCfhvtWclgLNWARt9eT3dyeYgnUduXfBw9Vyy8GhxXDhysHHf6PIX29/CZ90V0EkC9knQr+tDfopekFm62urR2rhgw2cblO2Jyt961pHYqmoMLzgPpuXSbfY+5GmfQ/7Pzqp5EV1Kph
X-Microsoft-Antispam-PRVS: <BLUPR12MB06919A85FBE3F5DE37E42E44FD820@BLUPR12MB0691.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BLUPR12MB0691;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0691;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(7916004)(396003)(376002)(366004)(346002)(39860400002)(39380400002)(199004)(189003)(81166006)(186003)(47776003)(26005)(3846002)(9686003)(6486002)(7736002)(230700001)(77096007)(8676002)(76176011)(8936002)(52116002)(305945005)(59450400001)(2361001)(81156014)(72206003)(2351001)(6666003)(105586002)(103116003)(6116002)(386003)(68736007)(106356001)(575784001)(11346002)(86362001)(4326008)(58126008)(486006)(16526019)(53936002)(316002)(476003)(2906002)(97736004)(478600001)(33716001)(16576012)(6916009)(2486003)(33896004)(23676004)(956004)(66066001)(5660300001)(446003)(25786009)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0691;H:[127.0.1.1];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjEyTUIwNjkxOzIzOmdWQSt6cFNuMkIxUXM4aDZEcjZMUHdjdWJZ?=
 =?utf-8?B?UW5PcUtDbVFOdjZTOFh5c1BLU2E3c0U0VlZ5cjN4Y0VtT2ZJWVlrTnMrT25X?=
 =?utf-8?B?Yk42SzRqVHkwL05XZHZOSzZkckt2Z0o4UFlISStMR3NaTFBPdTFDRkRvVWFC?=
 =?utf-8?B?a0E5bEpaNXRFUVIxRFdBaDkwcThDNzExZTlFYWJwM0FXWmFrK1MyeEEydnNM?=
 =?utf-8?B?ZFI1cUdWdGxJS0c4SWhRS2ZiZ3NCcXVpN3ZwZXZ2NERNVHpZWmZCcjhkTHZ1?=
 =?utf-8?B?YVpVaTcyOFY4dHVNaTkyenBsTmZXRTN1cERBT1FZeHFkZUROOVBYekY4TE8x?=
 =?utf-8?B?MHp4a1FIQks5TTJ0MSszS3N4NlVVZ0hqSWhxMlVBb3V1UHpJZmliZmxXcWNI?=
 =?utf-8?B?U2hnbGZmNHlFMXhYUVFMOU1QaFVMNlQ1OGFhVGFZVFQ2am4xZ3E4OFZiWG5m?=
 =?utf-8?B?UFNsUGkxYmdSTHN5aWtZampPdnIvQkpZYXNtcmRST0htNE9DK0I1WFBoM0xt?=
 =?utf-8?B?bG5RR29Bend1S0UxelVjL2J3WC9Gckw4T2QxaDNaTFZDUTZLWkMxRmIvZFFF?=
 =?utf-8?B?bnZ3dmRhdW1qS01EMThqZ2tZRkl6czEyK2YveHNIN0F0M2ZkaXNnZTRnNi84?=
 =?utf-8?B?MXIyQnlaODVHT0tjNXlOWTZybEZOUHZZUzZhS3V3RjFyYVlPdDBsdWlwelo0?=
 =?utf-8?B?eGg2YUJ2dTlZSkozaW5NSThyQnJ6Y25aak1LSndEY0oyc2dCME94enUyWTg0?=
 =?utf-8?B?UDkrWmhpeFM1VXVPaGtlcyt4bG42U250S0t2L0RRR1kxMlY0c3IxdDhsaENi?=
 =?utf-8?B?ZzdZbFFBQTdlaFdrcnduS0JPS1RqemdhMUFYNVJuZG1NYkpXZ2RDZEd4ckZq?=
 =?utf-8?B?TmpNK3VrUngwRmJ2RlBIRWxlUUhJcXhKSTFWQm9YUWc1d0ZHRVlVdEhFaDRT?=
 =?utf-8?B?YTIxa0NBMkxIUCsxak9SakJUVUU5dkhROVRtTW42ZjZVSlBYUXpiYVVhRlQ0?=
 =?utf-8?B?S2E0K2licStBTi80aHNYWUVVNE1QQjFocVJhL3RpYU45YTl2MlkzTXcrNGhv?=
 =?utf-8?B?SGozWlpIRXBrcy85WURGMERvUDJnUmUxNTJ1MnA3NU1FbDY3RytSL0YxNGlG?=
 =?utf-8?B?M3ZsMEhtMVMyRHNPdU5Ob3N4Wkg3WGN6QWwvNGc4K0pWVkVYZHVMKzE0RHFs?=
 =?utf-8?B?QmZESW1KTXBNaHRrMkR5bWttNzFwa3I4b0dHc0JFaWVrb3czOHdSQW50UDVa?=
 =?utf-8?B?SjZKL0hQY0s4bTJ4QU9pU25xQ0lNcGpldFBmWWE5SUh3WnNoK1RHYVJoMFlj?=
 =?utf-8?B?WldlM2hGVDBEYWE2R0RjY2lYR202MFdMSjJ5Rm52YThjQ1M5YjBoVkdISUcw?=
 =?utf-8?B?YWVoeG5RLzFLL1dmY2pkTXdUWkFkeENRd0xHVGZaWWNKS3czeEp6WDVJUnFa?=
 =?utf-8?B?eVQyb05xRVNVRUJrVnRLdmNhOHZoNVA0b1pFQkE1NytkelJNMmNoTTZxYWht?=
 =?utf-8?B?RGk1RTVjcmtVRmliQ2MvRDgzaFVsZ1grWjIrLzN4NGlLdGUwUGRTbDVEQU1p?=
 =?utf-8?B?TDhuK1JlWDAzZkNlUUdyUVVYaUtOaENoeHMrallEMDY1a1ZpUFEvTzVGTXp5?=
 =?utf-8?B?bHYwai9zOXhJUHVqVUFRTDl2Y2llN1A3Um96KzdZRjgrckN2OXhxODRWc3Bv?=
 =?utf-8?B?VUVqeHV4ZWhtb2Qxc1RPcytXbUg2OWMxaVNUSXdpM1JkTFdsZ01FbmdpVmpT?=
 =?utf-8?B?eEFEb3VkRTlEMUpoR3l2b2kybnZDK2tLTWFocVN5UWZQVE9KNEwzYUlrWTBR?=
 =?utf-8?B?UGt4QnNPYXE5SXdYa1lRNWVxRXNRNkNoQWlqRm1TTXo0YStLaUNHNlBRTHFr?=
 =?utf-8?Q?CEDoWUHZrWY=3D?=
X-Microsoft-Antispam-Message-Info: 0GMO4KeHQQWE/cows8hNyX92eBPofjTqKfk2s04MQA8/kg0zRSh/8Oc+MZSBqldRi9BH/u9/80VTBgoq7u/DbJyGYBHQ2ZgnUcM1VjoHZm5gc+VFmCx3egpsXnPI7bQvbMVeYChxXpjKsYE/YDmqd8KwqJCZEItBsAINUo8+8aFF3JaR+GOvGfBhymS6GpiW
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0691;6:6HuKdkGilduBW1G67K/Y+Ibe6EC1b8m5yiZ354POLrDIyL5C5CqzhRtdAX40hJjXucMuLFGvZCJVIo4CTB2ZS0M/Z8Ku+jx5vjbcvcD8npIxdjem8vorm5Q6/lZ18gjKEAcqaNE/F1ZfHQg3TfpT/mOWIfgY0S0e5S7LDSzTg6suJ3V63QDu+ii87yvuPILMLJ1H9fBTVWnIU8XkAkZaXRvKj987yWtx+jsMAtZAAZXZlDeTUzNV0VCw4XzY7oa7d2q/dmsSXAe4khmc+em727B0cP+agSz/ENa+lBI7cCQ0YNYhAprf6JBOUvtFT8ib3B1AN/rPdbPIrlD/swjGN+uoEW8CaLtqy55zkvMTu6dOXtHr364vuqVmb+4V26p4W62jeH/N7bW4s1YmfUdGZ3J24ld/onbFALi+cPvI/b2ShRxBXfQXNPn076etNzL3ZD+qyjjyj7/7ZHmjM08VfQ==;5:oVbZE8llnmwiuCMCT2THn+r8FWH7n0ei2IIcHMwwgBHrha7WuzqVV3yTEJcd1q5HJw/vTqlj7sKTFaT69z80gSJgXstC1J0qLjTE4/fsbnnlaSxfV63X28o2c3ztg0/gwwhmKbl3EDm2Kc/GaA31dAmBoAiOhdw/5aAeEYPCXQI=;24:chmI3BZw2g0BMoXb6zMxudKNKJxuIBbOtyvRgPTC+841waBhcQiidP/weyE8V/QDg+snlMQUo+i3qBDM/BnMbtiqsPd1YTC+CYaltb1uvSA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0691;7:fDoNsjnJqyHh0CJnaJBYm24oBQQjlh/lRzODUthvzWuvm8qEn/ZKTkMZYjlV1De954aBxDbHbKqvWL7sjkDRhq0akcLBFGXyIdKBc7ruclilnhdFQMu8SaiCY4GB1aJpLFablYyL/U25IQHUZMTfQYhyS3dNj8ft2Fw7GbUMLEnovA2Hj84wDOsKkkucjTo78L7BAX5L+KiE4oj/xDx7k614R2cY9wuEp7VsbwWfca1nc7lc2VcjR8H3wJh18P2c;20:6sQl1GX9TAoLmS4pk6+jvS6nOtkjX4AIrooC9Pamyvph5A2yB32MJyNwHF6x6k4WjTsa0wGjPMzsRUozZ7DR+gKjLtitkHyZzfCqY/WBEdr6sALXJWa8OpnJpnANOz3jkc67cCpNRrlNqLuy2RTzR65wEc039B176NYYOH2pKasXYzs9BTm3oPRLu0HgfzHTEVJuAlbhSxVfWucUSG2KLm0IkcE7LVrK66i9YcIC8z2sBwoCuV4hvWxO0U/xPuTc
X-MS-Office365-Filtering-Correlation-Id: ad998f95-b1d1-4e9e-6557-08d5aed4d4a3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 19:59:05.7052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad998f95-b1d1-4e9e-6557-08d5aed4d4a3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0691
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a skeleton framework for debugfs support in the
AMD IOMMU.


Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/Makefile            |    5 ++++
 drivers/iommu/amd_iommu_debugfs.c |   42 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    6 ++++-
 drivers/iommu/amd_iommu_proto.h   |    6 +++++
 drivers/iommu/amd_iommu_types.h   |    3 +++
 5 files changed, 60 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 74cfbc392862..dd980f7dd8b6 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -30,3 +30,8 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
 obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
+
+# This ensures that only the required files are compiled
+ifeq ($(CONFIG_IOMMU_DEBUGFS), y)
+obj-$(CONFIG_AMD_IOMMU) += amd_iommu_debugfs.o
+endif
diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
new file mode 100644
index 000000000000..34bb65cbd798
--- /dev/null
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -0,0 +1,42 @@
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
index 640c286a0ab9..39053f11dda3 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -33,6 +33,12 @@ extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
 extern int amd_iommu_init_api(void);
 
+#ifdef CONFIG_IOMMU_DEBUGFS
+void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
+#else
+static inline void amd_iommu_debugfs_setup(struct amd_iommu *iommu) {}
+#endif
+
 /* Needed for interrupt remapping */
 extern int amd_iommu_prepare(void);
 extern int amd_iommu_enable(void);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 1c9b080276c9..2ca0959ae9e6 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -593,6 +593,9 @@ struct amd_iommu {
 
 	u32 flags;
 	volatile u64 __aligned(8) cmd_sem;
+
+	/* DebugFS Info */
+	struct dentry *debugfs;
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
