Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751751AbeCNXFF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 19:05:05 -0400
Received: from mail-by2nam01on0045.outbound.protection.outlook.com ([104.47.34.45]:55981
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751549AbeCNXFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 19:05:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v3 1/5] iommu/amd - Add debugfs support
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Mar 2018 18:04:55 -0500
Message-ID: <152106869537.67212.11927240111825397411.stgit@sosxen2.amd.com>
In-Reply-To: <152106836233.67212.15861879210675477690.stgit@sosxen2.amd.com>
References: <152106836233.67212.15861879210675477690.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR1201CA0009.namprd12.prod.outlook.com (10.174.238.19)
 To CY1PR12MB0697.namprd12.prod.outlook.com (10.163.238.158)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72f90a7e-24d4-498b-05ee-08d58a0002db
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0697;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0697;3:oiZbG8jydY+Gjh4/uwecZ5rQjw7X+x5fCJ9RdF9b+bjC96tz9GcWYPqOe4E9ZGJg3pqfa3DSjeFStcp9rAc2YWAYvy6g+IKydtH6BZ5M/FXKk+PL4gn1mFam6ShkGo7hNwC2QKCxsh8sR/PCWce84fnxWrygyBpS9L7NxqPM3xSMRz/h5D7tnUhCH5opA9/dyE9t6HlkGaSysn04+7Glq4NDOIch9dIbuHQ4kCypzrM5l1ZudG2mnvmGihJaHn97;25:aEk5QK7TK8qU4lHb+lU2rX39DERRZJQpYlorpgGdQG7qFNZoDuvR8FG96amZoq/YIopuAl67ENopPAt3/dL1TEWM3Vc3y0rbf26Po1EXCSXiqIi7bhrR9k92u31OnJiEMzuHwK3cPyOGWb2UWLI7P7b8bQEX8qQBzEBBxlgvK1QYJ69xVVo4QKJjLVgL84k8OZyOMAoCffA6q+CmkUOAayGDCh+8EHuIs6tv3C4X1YxRMJRV3M0pKImbNFVbSn962qHDbDOVNgPudCIdL4FuKfuiE5sbDNhZRUZobQ9yRn7Jw5j3IUK7WqEISCiULfQslkhXqLTRDCkrkBwscT2w3g==;31:pMrfoT3Y/xEyFdO5G0A6w3LHIaGNoN4LrPWzga8hE/BoUF/rk9ltxKKWD++enOPO8fOI4vx87BlbjNF9iyhKKu7hECUHxoomh9H+dmrfTXeJroSqaoEyAL6bPEIox20pFgy1TAkS4aQYnZJavszfjBLdPJlpWYVxYtAhGcaFf2nAkEXyG/eJeU/xs8imCYrnRiEWcsX0n2iRqoYcp9JD6nY7piabqUp4g4eMaOsmFNs=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0697:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0697;20:fldOCCToHWSq4ztjK7I5Zyxf4SxWDFeYkshxQ2nyHRH0338peb42UbjLINi7eXboQKgNxXBQxS0RUegZWBkURcXXYi+IA4dKyuis5HuwjK/f6f/tjJ/kUE/qiqn4JyiFVmS8hsiybOEPSflCf/z4w0zY4QPd0d8nsMis3N4rNjAr8HqF/YfmoVJL6WuCrsCT2w+PgzqYt+FEqNyiFKvrmBUNOID19wNqsoauxrkTb3hke2qAvuVUYTKnIHbpYqVbxuwd75l4D7MeMLd76ADh2Qe4/bKUrrN3qqd88mD0ZBTFVlKZ95JTJ55Skjn+l/Xu5hM7NR8VGFIK5TBJmn+Imp0CSMTaPBe3mq365nXIo41lcBnsfnxFWp8DER6AsyojRGbiwLvqhW+61iKHPaS7oZRRzpYQXY9mxwAEG/GQAeR80eXJDJMNfhIL7D5OGpQgHVbOjwOrxJpEpB46VnFJbTT+jq8defh/5XfO5pmSs4wfFJcc5FjYsRAkp0x20XqX;4:HFOcs+/UeqKNNDztnphV3EaM4Y60ssZQSy6/Dk1+1RNA5VgVCS/lPm2cVEJ/h3A+nmTY5KQvst/AL+IjRwJamM4R21IGcpG0iilPVilEszyO4NuvycYx01uMLb+dLvXxOJ9kgkHTihnbr89DVx/3YQAskuNZPvfA4agV6eLs2RzuFQeBu49/styMo27iuikGShfF3VYre6Rsb2+HxGft7zw9RE55esPAr3cQ6e/8vp0p2TUWufUfo6AfGXQtY7/lgpOmIFeOa4+Y6ohagu+4bdHUy7ydTO7bj4w14GO/WUEbEZnDefNK7jo9/MlZITbq
X-Microsoft-Antispam-PRVS: <CY1PR12MB0697C15F687DC0947940113BFDD10@CY1PR12MB0697.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR12MB0697;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0697;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(346002)(366004)(396003)(189003)(199004)(53416004)(26005)(23676004)(103116003)(16526019)(81156014)(2950100002)(8676002)(230700001)(305945005)(105586002)(2361001)(386003)(6916009)(68736007)(52116002)(7736002)(59450400001)(50466002)(2906002)(6116002)(186003)(2486003)(7696005)(3846002)(72206003)(81166006)(8936002)(478600001)(66066001)(25786009)(2351001)(6666003)(53936002)(4326008)(55016002)(5660300001)(58126008)(76176011)(97736004)(86362001)(106356001)(316002)(47776003)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0697;H:sosxen2.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwNjk3OzIzOmlhUGJtU1pGSjNwTi81MXEvNFhRT0ZLd2lo?=
 =?utf-8?B?U3lTSHozYjVCR2pvUml1QUhhTHRIelZEVXVpek9seldPcDJjK0JBSk1QaVRi?=
 =?utf-8?B?cVhOak5UUlFybnEyclZyd1ZZSjZxb2hNWU1iemxOOEZmK3NvNkVoWm1CNnk5?=
 =?utf-8?B?K29hQTZBakdLUkVZTDFNcVYyQTJzRmV6Yi8vWGtkWkY1R29qQWozZ3NYUE1z?=
 =?utf-8?B?aDVDejZTZVBGWnN2VlNIaUYvdW1SOXlVb2FMTTEzNTFZYnhjK3RaWTRuY29H?=
 =?utf-8?B?aXlHeldNdVZBYkVUWXlZb0x5ZXh3MVF0a0xqTHNpcXpBRTdkdVcxeG1vRitC?=
 =?utf-8?B?ZVpkbWdndytMUFJBWUtRczNJSHBzYlRlK3ZRVjRRYmJDeWx1TU11VWZIem9U?=
 =?utf-8?B?YURubHA5UTlqTEFGL091VHpGSmczYTlYOGVWUXJpTDd5TU9LUHV1Qmp4VjVX?=
 =?utf-8?B?Qkw4bnVuM0loK3U5VFZLWTBKMUNQQ3FQTnAwckZ3cWg3UXhuQi9PMXg2SlY5?=
 =?utf-8?B?SEJGRHdpUFgrZWJ6VjBkQ1Rid0wrdWZabnBTNGs0Z01ONjN6V1pGQm0vaVlz?=
 =?utf-8?B?eGIwc0xnU2FadFVBSWpKclRYZ3FDRW5NQkphU2pLdjJIbTBzT3lTVWJxMjFR?=
 =?utf-8?B?aDNabWdJSkZ2SzhHQkxqZHN6YTBOOS9nUTAzU0Y3eEVXejNrN0lTT2JPMTBt?=
 =?utf-8?B?RVpwdmMwZFFPVkdRTFVGNlBCTFdrTHNJT3BPWHozV3NpQ00xNnJIU0ZnR3gz?=
 =?utf-8?B?dWU5ZEtySkJJazN2bjRaWFlqODQ0VVU5RkNhMEpIeEVzWFVRY0FXOUo0K21h?=
 =?utf-8?B?dCtzejFCL0txOVBWTjJtZXlVV1Z5N2FlMDVpZ2x4N1ZhQjVoYmZESS91aTRC?=
 =?utf-8?B?WUZ1aldDTnNJSXJGYVJNcmtiSlN4bTdXTHZ6MXhEZkxMKzFjRW1VZ0JPaWJQ?=
 =?utf-8?B?NlpkUzBQYW1xK0ZYSkR1L1lrMHhobE9DNXZIWG0xbmoxOVpzcVc0RGhEZkhL?=
 =?utf-8?B?M2N2dnd3a0ZuRE02ekxGUkNMc3pkVTlldVN4R0NYSFhqTXBKU0Z2WHpqbys0?=
 =?utf-8?B?T2pKRjhkWXE5dGlOVkpSU1dkdFNOdC9vWFZNNU5DdkZ1UU8va0s3UGphT1pp?=
 =?utf-8?B?SUZ3Y2gwRE50MHRwU1BkVDBQL2lxNytxT3dXV25XbEVFY0RCNFhJMWo1NzhY?=
 =?utf-8?B?Z3RiNURHTWxSbk9hQkRsVXdvUFJqZHVTa1g3V1dhVC9FZ3J6SkNjR2FGeWll?=
 =?utf-8?B?cERMdThuRFJDZm4xVG1xSkdzMmtTRlkvYTVZaHpQNVcreThHRGpBN1hOam5x?=
 =?utf-8?B?VTJmcml5Si9rOFFWSXJBK2Fodm02clBNRHdKOU5kMTlLUkRyY1FrMHdUcmRh?=
 =?utf-8?B?d1VxUHNrY0FUZG5yU1U2cld1TVpYby9MeE16T01DU2E4RHlHSVRoNDRaeHk1?=
 =?utf-8?B?UE90Y2JKQTNSYXFtNXQ5QlFHUUM1VzM1SmEzN3dDVC8rN2ZkcVVDN1o2RTNm?=
 =?utf-8?B?eDJrd2h4Z2JqbzhmbHhZb2RrRTM0RUk2TUVyeUZFL3U0RFJvOE1uWjA2SkdZ?=
 =?utf-8?B?aEs4dTdtdDV3ZFZ0K2RYa2kwbWVRMFA3djI3SDNDc1VjZjc1d3dLVGR6VVIv?=
 =?utf-8?Q?XAHt2mQ6fMGihHnGqoQE?=
X-Microsoft-Antispam-Message-Info: O6hCJxz+Z28E3LfYfnQuoFRWCoel4DgW/+GJKY7teVgZh6BT/qIaNov71QwblA20QptLNKu1jd9ImmVlvqqIRxNWRzJ90ZXZTq0QorwHAKirrDfHk8im9SN9EaOb0bFvXkUt2s5W5dvHPl2Rqxe9YKZk0/yc6fYLZonTA7hYdv8/ybLQxAytfIcIlgrWHdEK
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0697;6:oRsJ6YTKebuTeEmT11D+749AcFQd5SlQvSPvoiOhk49dHk9ai063Jitd9AzBvQioaebPNphEssrFbL2jSt71ZmL6DgR9PjLa5vrgZIKc9+Ps6SdlqhhbdpF1LzX9Iti6WOQeC5YLyQUrz2/LUehlfeV3pzbbsWzcH+pogOG7R9LHI/nTp6MApOzJORYtldDufm+q8idh9dKzKiFJImkGR+SfJiIf3mJ1vVsm3ccOnaD1eyeTxyirNye1sM7qvb1T/YBviD6jnI5WOJO0fJEwgXmD3yBczPXu/CAESNJ71nRzSgcobjesC0wq0RSboGaVQKTa92bOJlbLNbQTSXE2ifEBKNfGsBqCSDPMrc8nuic=;5:Pqnwuxkf/rVkgfTnwsLaJZh+oqvNf/68nHw5UASvROm5EkDFWbD5m/j+8/hkL4OpuX5LD559lRkRE1kvOSxG0Fo+UaImwBkf1UWyUgr4k9aKtiQkJ9h0xvycOEpZmdA+rmPyCEiazZNbqV0v+ZbuBhtrL+MnPvsUzVXiVZG0EoY=;24:e88lnHFJGObY7FJ4nGNea44BCg7y5SRT4Vlh4KHTHSdtqyQRuK/ibr+0Sazoz95Ihrh9+eogfytYouYZmrRp6uyEgfw8tz6oCQOCTZkzxbc=;7:n7VB4l82mp9QbBLJlyTmGX1LscLtXx0vNmsM/hDJcobjZK/L9YPLdw7sWyry8g0tJn3RkUQel24VePcdMnfEUvqCoP3ksEMpZ3lWdaPDJORcMReHfWCgMthES8MCvfWbT/aVG+AWCaykrNVI1kknpG80mTkoU713zyM3q0K5isJbpEIHY9+ZAQPYubuwsteHaBRsMgAPHMZRUqWG1/Invqg2EHOVPenGpFkN/kWOXXebqN9sKDN1XraS/FWiA9y5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0697;20:k1VwY5OppNQ8TO5pqtHmLDQpg3rPC6H9sNafXb8TJnCC1+JO6+4IwODp54zxu2p0p89pF9EQni/XIorEaWYb+Ghg9e2KlCn3EzWMCOheR/0XuqTgn7UkJV0RbLTBD/JuxLgf063al7z5QEqz1SyaZPBpfKoEPIVzCGwrGsrHAEbp0MOVWXVR3QVBHbnehdBtDOUGj4tY5QLcOpIyWF3wkyRQYoqfs0IdJBTX0kN87WcyATlB0LgdX0yqMKAU4BBP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 23:04:58.8615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f90a7e-24d4-498b-05ee-08d58a0002db
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0697
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the IOMMU MMIO registers and device table

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/Kconfig             |    7 ++
 drivers/iommu/Makefile            |    1 
 drivers/iommu/amd_iommu_debugfs.c |  122 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    6 +-
 drivers/iommu/amd_iommu_proto.h   |    7 ++
 drivers/iommu/amd_iommu_types.h   |    3 +
 6 files changed, 144 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f3a21343e636..8b2a5b8707c6 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -135,6 +135,13 @@ config AMD_IOMMU_V2
 	  hardware. Select this option if you want to use devices that support
 	  the PCI PRI and PASID interface.
 
+config AMD_IOMMU_DEBUG
+	bool "Expose AMD IOMMU internals in DebugFS"
+	depends on AMD_IOMMU && DEBUG_FS
+	help
+	  Provides debugfs access to IOMMU data such as registers and device
+	  table entries.
+
 # Intel IOMMU support
 config DMAR_TABLE
 	bool
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 1fb695854809..64fba8b1ca4f 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
+obj-$(CONFIG_AMD_IOMMU_DEBUG) += amd_iommu_debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
new file mode 100644
index 000000000000..4f0f05a89a41
--- /dev/null
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD IOMMU driver
+ *
+ * Copyright (C) 2018 Advanced Micro Devices, Inc.
+ *
+ * Author: Gary R Hook <gary.hook@amd.com>
+ */
+
+#ifdef	CONFIG_DEBUG_FS
+
+#include <linux/debugfs.h>
+#include <linux/iommu.h>
+#include <linux/pci.h>
+
+#include "amd_iommu_proto.h"
+#include "amd_iommu_types.h"
+
+/* DebugFS helpers
+ *
+ * This is intended to shrink the scnprintf statements used to produce
+ * debugfs output. Each function that uses OSCNPRINTF will need to declare
+ * local variables:
+ *
+ *	unsigned int obuflen = <max size>;
+ *	unsigned int oboff = 0;
+ *	char *obuf;
+ *
+ * wherein obuflen is the expected buffer length needed for the output text.
+ * Every statement then reduces to
+ *	oboff += OSCNPRINTF(<format>[, <arg1>[, ...]]);
+ */
+#define	OBUFP		(obuf + oboff)
+#define	OBUFLEN		obuflen
+#define	OBUFSPC		(OBUFLEN - oboff)
+#define	OSCNPRINTF(fmt, ...) \
+		scnprintf(OBUFP, OBUFSPC, fmt, ## __VA_ARGS__)
+
+static struct dentry *iommu_debugfs_dir;
+static DEFINE_MUTEX(iommu_debugfs_lock);
+
+#define	MAX_NAME_LEN	20
+
+static unsigned int amd_iommu_count_valid_dtes(int start, int end)
+{
+	unsigned int n = 0;
+	int i;
+
+	/* Scan the DTE table from entry 'start' through entry 'end' for
+	 * active entries
+	 */
+	for (i = start ; i <= end ; i++) {
+		if ((amd_iommu_dev_table[i].data[0] ^ 0x3)
+		    || amd_iommu_dev_table[i].data[1])
+			n++;
+	}
+	return n;
+}
+
+static ssize_t amd_iommu_debugfs_dtecount_read(struct file *filp,
+					  char __user *ubuf,
+					  size_t count, loff_t *offp)
+{
+	unsigned int obuflen = 64;
+	unsigned int oboff = 0;
+	unsigned int n;
+	ssize_t ret;
+	char *obuf;
+
+	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	n = amd_iommu_count_valid_dtes(0, 0xFFFF);
+	oboff += OSCNPRINTF("%d\n", n);
+
+	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
+	kfree(obuf);
+
+	return ret;
+}
+
+static const struct file_operations amd_iommu_debugfs_dtecount_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = amd_iommu_debugfs_dtecount_read,
+	.write = NULL,
+};
+
+void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
+{
+	char name[MAX_NAME_LEN + 1];
+	struct dentry *d_dte;
+
+	if (!debugfs_initialized())
+		return;
+
+	mutex_lock(&iommu_debugfs_lock);
+	if (!iommu_debugfs_dir)
+		iommu_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+	mutex_unlock(&iommu_debugfs_lock);
+	if (!iommu_debugfs_dir)
+		goto err;
+
+	snprintf(name, MAX_NAME_LEN, "iommu%02x", iommu->index);
+	iommu->debugfs_instance = debugfs_create_dir(name, iommu_debugfs_dir);
+	if (!iommu->debugfs_instance)
+		goto err;
+
+	d_dte = debugfs_create_file("count", 0400,
+				    iommu->debugfs_instance, iommu,
+				    &amd_iommu_debugfs_dtecount_ops);
+	if (!d_dte)
+		goto err;
+
+	return;
+
+err:
+	debugfs_remove_recursive(iommu->debugfs_instance);
+}
+
+#endif
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 4e4a615bf13f..a03142fd6179 100644
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
index 640c286a0ab9..db5872d3d40f 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -33,6 +33,13 @@ extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
 extern int amd_iommu_init_api(void);
 
+#ifdef	CONFIG_AMD_IOMMU_DEBUG
+extern void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
+#else
+static inline void amd_iommu_debugfs_setup(struct amd_iommu *iommu) {}
+#endif
+
+
 /* Needed for interrupt remapping */
 extern int amd_iommu_prepare(void);
 extern int amd_iommu_enable(void);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 6a877ebd058b..43c008dc7ade 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -593,6 +593,9 @@ struct amd_iommu {
 
 	u32 flags;
 	volatile u64 __aligned(8) cmd_sem;
+
+	/* DebugFS Info */
+	struct dentry *debugfs_instance;
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
