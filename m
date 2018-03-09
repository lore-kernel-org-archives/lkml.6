Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbeCIAu7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 19:50:59 -0500
Received: from mail-bn3nam01on0059.outbound.protection.outlook.com ([104.47.33.59]:32075
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751005AbeCIAu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 19:50:57 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v2 1/5] iommu/amd - Add debugfs support
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Mar 2018 18:50:47 -0600
Message-ID: <152055664720.63229.16209149030018336339.stgit@sosxen2.amd.com>
In-Reply-To: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR17CA0008.namprd17.prod.outlook.com (10.173.147.18) To
 BY2PR12MB0696.namprd12.prod.outlook.com (10.163.113.18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1935e00f-5289-4bfb-d3f0-08d58557cf30
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0696;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0696;3:8ANR7NmskfzXuHz+AeO3vyKK7D2TurWkLoj1E44ZBv7Qfi//4gY9MKsidjfGza5GfLJC5dOL5h/8Tps0H5YvkIpjq/cy35LQyqH0eKn5pnnCoZZvToTDuNQLd8bjTxA6Z7ZCeA13F9P9OPpOQ+C2P6IMLlgg2yb6M1IWaXZbo7M+n5b5LBLMDLfOd1qLa+ffpUKEENiimCK/d6RPVekdbve30o2J1NSwsSVD50wt7UovlrIx/Vsj9tkBMgHPbLDb;25:ix7A5yjSzjmSMdg9SXlmWkjDM2sxMnX+Gi25XH+nkD3d64Kpd+NDHpxGD3i0cXnD6iDtCES8GwO7wL2AnhMgMYasWhkOgcqY3HbvPR+9NWCpFlsC4lAiJh5HUe5oieSVfvw92WIghn2W+G8LAg2Ja3KGvrWGls2AyA9gfY0GjSczYHgRkQ3TTDYBDdGA8kXrLY4PoabH/yqD/Z5l0Oua/v9+lfoUTjK+9ejQkSmd++UnMSSEREGN779Xg1yaXC9WKw8wedq40Y9ZER6SlNhvM+MTFINDYoSXweNlXcbWZUSggecq2EbJOpQC8/4FZW1I8Izrl7Jwv5t5sbud5UXD7Q==;31:wt3UieD791iz1ysas32AKJfYzfJuvv/hV4bmxnJRipnlbgu/ZoM3emCUX7tahH5NUm/yj6BPzrgM3tdC6FZUnoZcLvXeBfvhTLJbfxhZFVwRCs1rVywb1UronQUK9RKjTxeWOceee/lzIUhlI3Bs5wPcSajeyLcU0J3S656QFo7TMn3Mnd5BOsVXybMrs8VmPSB3sZrcDVidw6FmfjOZWDOW0T+VPt0O9q03M2YtxV4=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0696:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0696;20:MOcWEO05JhK99qMl2CPGBKB6Jom/veG2whkrCeAnIYxeiy9ngWKkxOkbJkPcBC2ecZaOpCf2OfAgo+DFDoP18RkrWU928ntxP6CvN2KmkodJz75IUII/m8jHv9pQ3EKmly0mJC444tlNu8XKpjBnDZ/TE708STfxWcUTAjFcq4+DrvnP/j/CL+Xjioz/rVs/IfDRilXnWZsH14k5YJPTVvCP3AFjdqAhnideVKp5gtnwEIrLFp8L6Qucuk+GGG/ygmRtKfFENGPA7moaM+N5sPX0i5KGznY9FiqEic74sR7FClIAqmlQQpRg20RPQVihsxQZfq4mBtBHqTDShTgMwuqqPBkwEy4Lo8bo8KEtoXsDbVejmDG51I7m9q386ZKBOziz2IOQ2s8tJuBudjvT71qHkpb6Tz26ohSFnymuSeDnF7CG8h28Jps2FBxSNhBZHoGbuB8Brgnrvj5Js9huOIT8RSlLXjv8EFIJrlWpSnc1fDjucYHx3qlP8TBjIm1N;4:PZLPUxSH6opfOF+hgKswTh0Ga8D2y8AyLUV0rsD8mLfkZuoEcxAHGz+B14NV4SMGeIs3WAySvuD/fojPwWP80u/S80o1KoNi7sW9s2Y61r1W1eARdXjLpnYZBDQ6C63n61Nd8H0TAAmEDqUxW08TX1Iyg+WeiaPFO2lraa1asxmp8LKRL+7Dy3K9v6/c2DxvT7wdMSkbCmJOn0taj3uZTjFOSqASeKxcWAtSMv8zJOlkFYW9xMSQvkJssMLKv1tCN1BtsxAVXVINIC2dkwePdpCbdrbxqQMQNazL4KrDqClMruICpmsSI6XGM0+ozP6e
X-Microsoft-Antispam-PRVS: <BY2PR12MB0696C912E99365AC4BCAE4D9FDDE0@BY2PR12MB0696.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040521)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(6041309)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BY2PR12MB0696;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0696;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(366004)(39380400002)(376002)(189003)(199004)(386003)(76176011)(86362001)(8936002)(81166006)(2361001)(575784001)(81156014)(8676002)(3846002)(6116002)(2906002)(2351001)(55016002)(7696005)(186003)(53416004)(16526019)(52116002)(2950100002)(6666003)(305945005)(7736002)(478600001)(316002)(26005)(58126008)(68736007)(59450400001)(6916009)(105586002)(103116003)(53936002)(106356001)(2486003)(4326008)(5660300001)(47776003)(23676004)(72206003)(50466002)(97736004)(66066001)(25786009)(230700001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0696;H:sosxen2.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwNjk2OzIzOmx6MlhZODR1Sno1OEZQdm5hY2xmWXpOd3oy?=
 =?utf-8?B?R0hMaFN0U1NyUmF6UDdJVHlFTzdZR293SGx1cWt6NkYwVk5ob0FYbTNsbDRS?=
 =?utf-8?B?a0ZRODUyY0xUc2t3cjlTTFExb3BQVFZDWS9FbU56MXVWT3hVNXd3bUpNeURk?=
 =?utf-8?B?dVYvVVkwQ00yTUcrTzNxRjNmQlFmbHBWOURQQzF1QXF1ZGE5WEJxbkRPVnI4?=
 =?utf-8?B?aTc5cDhMQ1IyUThZTElZTTNyUU42bm8rOTR0NDZkQlBqaG9wYUlOSDY0RXVh?=
 =?utf-8?B?a2VtMDQrS0lwSDBWTVJPTW02N0I1ODViOVgxVEZ5TEo0ZW9nOVlQa3dWMHN2?=
 =?utf-8?B?Qzc4RkorYkdVOU82SHJSUDErKzkrdWFNZ0ZxenFFc0k2NFNMT3A4eldQUXEx?=
 =?utf-8?B?RHNwWXE4cSt4aklvaW55dXJieGxxbTVZNSszaGZ1bTRKcE1DN3lwVElELzVC?=
 =?utf-8?B?N1BqbFZ6bDVTWENEaEVOZWdPVXZLNkJkWm0yUVlNSkcwLzdyVFo4VlhlQ0FI?=
 =?utf-8?B?ZVlJTGlrTXNTb3lFbll0b2JvRlR2NGYzaVFMVUJhR2NiNUpJQWp1cEZmNTFq?=
 =?utf-8?B?WVAycmNyK1RBK1NmMU1oTER0RWpVUzY2R09PTkV3bjBPUVpWUGN4bTR1THNQ?=
 =?utf-8?B?N1NWNno2YVQza2R1QWZHMTErSDVra0h1VmEvSGRzTHVlKzZJN2k0dUtrd1Rr?=
 =?utf-8?B?NXNjZDdvNWFCVWRlTkJwVUpxclM0dUpNbVhEZDk2cGdlVDVzaFVjWS9xM0to?=
 =?utf-8?B?anp6ZGE0OGNZTS9EVm8rTkErY0dRNHhaWHhIOFRmS3h5TlJQRm9GWFVRU0dX?=
 =?utf-8?B?WFlKVVhyS1p4cWR1ckgyeU9EdlJadlAxMVpWRnBEaWRIRDlKMUlZQ1dLdnll?=
 =?utf-8?B?T0gwalBxcnd2a2lidTVvK1NpalNKRnJnRWg5d3BEa1VwTjZwTzJneWhFZWlu?=
 =?utf-8?B?cnRvYUJyZ0RTR2YrWkxMdHdWbHI5SkZENVFWS1RZd3hLV2FEcktjaXNDYjFs?=
 =?utf-8?B?TEcyV0hpV0U1SEw4bGdkOUo3NDVEdVNEM2xXRWlSVmxOOEd1NVZBSXl4SkN6?=
 =?utf-8?B?YWdBazNmWDZHWEtWanVQU1lxdllVQlRqUXdTd0RnaXAwYkR4V1VFSW9idXpD?=
 =?utf-8?B?dE1qZ21tdjN0Vm1vY0lQdlYrYUVVSml6L0k4OTRFT3NHSmRwUWFHUnBjQTNq?=
 =?utf-8?B?bm43dllScnNVSWhRckdjWTJ3ZEVBRGU2K1E5clFYd3owa2lYNkQ5TnlEZ2lZ?=
 =?utf-8?B?R1FRNjBkQ3ptSXN6aTFIR051VWo5OG96N3I2ZG9MV2ZORHhDUWhVZi9oQlJp?=
 =?utf-8?B?ejZNUG1RcnJOcG5Eb014cHhNVHVVL2xwQnI4MHdaUHR1c2JMMmVtUitFcnNL?=
 =?utf-8?B?eXlDRHVycWVuV3J0WGcyRDlWdUlIS0F0Z1QyaFJVWUlZSUR2N0d3MDZseWZw?=
 =?utf-8?B?Q3hxSzM3NUl6RFBreXp1ZXllQ0dMaUU0M0cveU9LUVRtUTF2T3U5TlpmMFJu?=
 =?utf-8?B?QnJwc1hLcDl1b3lUNTVHREo1NmN3dWZTTUNGVGJDQ1kyV041YllrVDZURmM5?=
 =?utf-8?B?ckxaOHQ0SndNVWFqUjVNaklSQkZSU0VDRFQ4SGtMempPTEVOVmhvZklDc3Ur?=
 =?utf-8?Q?ntQGaqpv2dufbKzIFZIT?=
X-Microsoft-Antispam-Message-Info: Db5UZ6D2DQ+SFZ43NyI4NI+jykONdZOcrBphU7woaoFLJNMg6qPP/KvyFwXmMcf5sn0EyLCiy4NMb9jFFRyrRdt0ORy+O54uPB2Jv9Ogz3cycAzTet/4fXZeXUHbudCdOoExai+aGCgebFiWOjjZulR3FFCnoy2nwuXYn0IjWNR0SzEykFvKtAJQriAfpEvx
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0696;6:AgzPuQDT9AA7XlQVgeANgwOZGfEZ1S/M9E9DdTaI/OPjGnOULKYdLDHqILX4Dzjj2P7V6eynRLt5PtWIuZYm1gDBCAcy1Q56dvvKuq72j8kW0n0eXO9NVvIzgNetV1IcqAG82trfKf3YRQsMHVzR+vHkGMeOkTMB88YnSbyaMxK79OuEVpIG4Gq9490TJRpOvWQugK/pTzVOIXsw/RnlsCAJ4KlORJt/gIufCda4w1jibB1WhqmSB7KdrXtqpsmd81SdIimSsMC7pnQfWDd8Lfokq3BPwIBe8mXUTmjnLaArjsCn5pPJP7PRLcTNTi4i8Uk9RAddmS7QLvXdTT5tsCI+zTfZxYFc1Eyayn9SIKI=;5:1vc/SgaRvJh7lg86/NudZ0CslCFZGsIDme/brIDL3YIGnFPG+xeC+73todn9LdjtCliOcsqBiNjb2yKCPM5SjHQwaQ4WnumK9pdImw3W7mefIXc4IqBIX36PRId28xtmovKNNrq6qFZkLTguBuvHli8VHzE/+dTjtbYpK/XnZY4=;24:jBfJbvzjVB8EqRmYOQ7jlk72N+wXuPzfcqm9fHsw6s79u7ssPF5vqV4lkuQjjSUnfTaQ2IkGu4FJ6oSU401X0Rs2Z7AR+OwPdT+YZIhc3NQ=;7:oYUybIe23w2k1uiEODuDng8xoGtHTXvXZ2U5+TzVEI7B4MvDPu+tMosTmovhLWBUmXMaBu+qp0e5msqr4VxNRNn4YkINxmVdqspmW9MXfgonmw9xsApsxT+5BNQXKvc103JJ4TPc3aEvAF5+0uBFfEp6zS6RPdiEV14BTsSdxE3wUSXPEEI4bhLoVjE0QcoeS9dMt1FJVUgOJJTCZQ5MtHmkk5i8z0LTn+hv4p21ODfhYEb7KpzxIPq6xZ3T43vF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0696;20:lQiQtnzv742E4/kIZeILiG2ZwRHyf9BbSj5zU7Lj9rhIeffi9XO39Z03ULIe2rAGGDurCU5Lr/g28oLFypfNUwFbeSNsNFDtUSUh8tiKguhYwEMSh7TdM0VuHR7SpE5Le1ePE+koIv6mub1Y2m4ANZ8nxjj5/2fc7trXaWcd2yQ9SC96Y34plp1YEhp/cgPi04yqNTimySLqJDop74MSyHOMHIKGsJPM4XgemfjZ0DmqmIOPDV2hz6RZNRFJl8cv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 00:50:51.9713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1935e00f-5289-4bfb-d3f0-08d58557cf30
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0696
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the IOMMU MMIO registers and device table

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/Kconfig             |    8 +++
 drivers/iommu/Makefile            |    1 
 drivers/iommu/amd_iommu_debugfs.c |  112 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    7 ++
 drivers/iommu/amd_iommu_proto.h   |    7 ++
 drivers/iommu/amd_iommu_types.h   |    3 +
 6 files changed, 136 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f3a21343e636..0fa85e73d5dd 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -135,6 +135,14 @@ config AMD_IOMMU_V2
 	  hardware. Select this option if you want to use devices that support
 	  the PCI PRI and PASID interface.
 
+config AMD_IOMMU_DEBUG
+	bool "Expose AMD IOMMU internals in DebugFS"
+	depends on AMD_IOMMU && DEBUG_FS
+	default n
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
index 000000000000..b0395a47bc32
--- /dev/null
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -0,0 +1,112 @@
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
+#include <linux/pci.h>
+#include <linux/iommu.h>
+#include <linux/debugfs.h>
+#include "amd_iommu_proto.h"
+#include "amd_iommu_types.h"
+
+/* DebugFS helpers */
+#define	OBUFP		(obuf + oboff)
+#define	OBUFLEN		obuflen
+#define	OBUFSPC		(OBUFLEN - oboff)
+#define	OSCNPRINTF(fmt, ...) \
+		scnprintf(OBUFP, OBUFSPC, fmt, ## __VA_ARGS__)
+
+static struct dentry *iommu_debugfs_dir;
+static DEFINE_RWLOCK(iommu_debugfs_lock);
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
+	for (i = start ; i <= end ; i++)
+		if ((amd_iommu_dev_table[i].data[0] ^ 0x3)
+		    || amd_iommu_dev_table[i].data[1])
+			n++;
+	return n;
+}
+
+static ssize_t amd_iommu_debugfs_dtecount_read(struct file *filp,
+					  char __user *ubuf,
+					  size_t count, loff_t *offp)
+{
+	struct amd_iommu *iommu = filp->private_data;
+	unsigned int obuflen = 512;
+	unsigned int oboff = 0;
+	unsigned int n;
+	ssize_t ret;
+	char *obuf;
+
+	if (!iommu)
+		return 0;
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
+	unsigned long flags;
+
+	if (!debugfs_initialized())
+		return;
+
+	write_lock_irqsave(&iommu_debugfs_lock, flags);
+	if (!iommu_debugfs_dir)
+		iommu_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+	write_unlock_irqrestore(&iommu_debugfs_lock, flags);
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
index 4e4a615bf13f..501433c29a3e 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -89,6 +89,7 @@
 #define ACPI_DEVFLAG_ATSDIS             0x10000000
 
 #define LOOP_TIMEOUT	100000
+
 /*
  * ACPI table definitions
  *
@@ -2721,6 +2722,7 @@ int __init amd_iommu_enable_faulting(void)
  */
 static int __init amd_iommu_init(void)
 {
+	struct amd_iommu *iommu;
 	int ret;
 
 	ret = iommu_go_to_state(IOMMU_INITIALIZED);
@@ -2730,14 +2732,15 @@ static int __init amd_iommu_init(void)
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
