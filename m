Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbeDDSzH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 14:55:07 -0400
Received: from mail-co1nam03on0060.outbound.protection.outlook.com ([104.47.40.60]:14308
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751588AbeDDSzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 14:55:04 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v2 1/2] iommu - Enable debugfs exposure of the IOMMU
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Apr 2018 13:54:55 -0500
Message-ID: <152286809539.3286.15989683808164726981.stgit@taos>
In-Reply-To: <152286703837.3286.11286329185822795742.stgit@taos>
References: <152286703837.3286.11286329185822795742.stgit@taos>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR1701CA0019.namprd17.prod.outlook.com
 (2603:10b6:301:14::29) To BY2PR12MB0693.namprd12.prod.outlook.com
 (2a01:111:e400:52e0::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef4af4f2-684b-46ed-9519-08d59a5d91d9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0693;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;3:UmysYFa/DLBprOJwoDbSWKjgpfoBz8IZPJxMQj7WJyF2NhLd6gANJx4x0zaUmJ49wv6En1cvhri7R3KIcom8ydr4gPm6l4T8F1lJuk4mEym7Hi/ChZXOtDkt/tskszHB595u2Vu+K9jiYOxIyp+FLp4tOfZmll7T4gW3obIIgmzo0Hp+CLCws0B93e4a8a6Xt3i1CzsG0vlJ/ghG1GxBUGJR1coD0wl4DxeXpvg39uIBT2dbvzTyn0BmVEwocAHl;25:Itrn+IG1kPmqb0X0KDz5t9unMrCrVCQm/uV3v7hdUcsEBgznkw5CYAVPXY10naz4QTb1Mf2BUlGbcOweduumr/D3wIpnVc23quprL5f1j3O1g7hYv+y2Qs8qsUKXFktWkigsPBPl1D8TpDbfVuSun2SCRqswVwKtdu/ZquBCWulVu595hHAJGSSXN4nzIk/cLxM3V3AVgYLAjWC8/5Ld309C9RKOc0Y6cpbVLX1XD0kp2EjS8+FAyX7Cifu+ztXVr/8reaSlri69x9qiamPaFPeqiP099Qwy0w3JnySw3fLcC6r5HylGkGg2afdLj0adbn+6n2YsYSHh51xGwuMRkw==;31:On24WWh/XTP4b4JJY0t9h5xeaY8uds+HaEBgbgsqbBagO2qIp10tMeadIbcPb+xlePaWrpJrXv35rcZpl4m01OG9XPCvR6RAwhL4o3PEuJJ+Qd2OzYihTbzsO7seEy+WXqLKPE0gdliMpK13O/DIbm31aCdss7bvxU820ophMtCpakuQ5r6UMW/LQIPPlFKbvB8xIJ0+wi5GmqjmLztOjGGdCcPUDxCc9HtVAY/UoZo=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0693:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;20:a0okun5qhNXySqtJx5yNVl9tCO+arpelO3unx3hmVFozZJrW5lIq6v7Tswq8669SV0Pr6JOfcJb1NNblvjDvhM6yDq07OhJRJXjaUT72jHKOAIIWd8ujQlAHznhhHatv0DXFkLelY1Gn9Kc15eAT3zsW+KJHaJ1DfIl90xeGKfpOFdmw7uvz72nDpVk4V1zBwRZM9Tw27bBwZWhOmBv0FjZiw0sRTtaNW2fdLLDkizbxaoM4bGoszDS//QyMZdIrZHsoTYFuPDN2FrbnpXNu9KA/y2pBNMP0RWFUvQ9mPSNXpXjcW9xHyRGLvR0xCqlsv35Dx6oBP1HVANUDwUQvVQRfDvzjyaGn6e+Afz84x7AlD75CKkZX0OAR/4+/MANn8XSswyCwThJOplCYKuSlL4PqfQsALNiBYAR2d/WW7DBvhV45uO/Ij7sHpOOP7Rd/bbzwBny9P7LIAg+wuEZ3wow8jjGxPzM3Jw/iFUIQSveRlBQpqpwn1gZ4MojzCXe4;4:+XSTTOpHI99h2HUBovWTyYuSz9z57oTkiPizdCu69PTk70R/MXj2jVII1MRuDNU/caJZq0goL21/b/BqYPpz1ZWIj4+jI5AfEwo/o9AO1yJ9aF+sRRkq521rBKcZYUtm7xZplnIxanNhSHZWnRcLycMJ1F0ZJ4ifgNgFy34URlUGtssj4ESr4Ciz7koJDfwiBAB6h1rgSFEQjULUPN+ziRHVgGjOixNZwplewn13q2SPn1bS3YfCnBt95E1cXCwBmBHyzdZqvoSopWUEqWFYKkUZ9VokBbYzCCAR9ZJKVM2AwuWEQsLZxQbuYyRLeEJH
X-Microsoft-Antispam-PRVS: <BY2PR12MB069323DDE18FBECFDE0B58B0FDA40@BY2PR12MB0693.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BY2PR12MB0693;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0693;
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(7916004)(39860400002)(396003)(366004)(376002)(39380400002)(346002)(189003)(199004)(16576012)(52116002)(186003)(8936002)(76176011)(8676002)(2351001)(2361001)(81156014)(16526019)(103116003)(97736004)(956004)(81166006)(106356001)(50466002)(105586002)(486006)(2906002)(72206003)(230700001)(446003)(4326008)(7736002)(23676004)(2486003)(33896004)(11346002)(59450400001)(3846002)(478600001)(6116002)(386003)(316002)(6486002)(33716001)(86362001)(25786009)(5660300001)(68736007)(26005)(77096007)(6666003)(6916009)(47776003)(305945005)(66066001)(476003)(58126008)(9686003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0693;H:[127.0.1.1];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwNjkzOzIzOlk0K096N0FZTFlnMmNpRGhxNEFhanBYNDR0?=
 =?utf-8?B?VzJLckl1YmM1S0dkYzF2NGNsaGtrdkFSd1lEelZKUzhlTThQUDBVeTcrRERW?=
 =?utf-8?B?N3ZOWW14M2lNV3hTNkhxeHdUbWN4TE9DMHZoWTZGUGcyNmp1bm9jN3hqQkFo?=
 =?utf-8?B?NzFRbS9nY0s4VzIxT0JXS29GSkVNelVtenhpejBPdDJwMUtBYlYwVFNRNVFm?=
 =?utf-8?B?T1FqZTlYRmUzcmxZWXFhSWlMVHNUYkJhSk4vVDQrRzY1bm01V1R0cWxNaGdF?=
 =?utf-8?B?azRsd00xWGhGa3IyZWVwZUM3L3pzek80aDFOVkdvUlRqS2xIeDRqakNpcWZB?=
 =?utf-8?B?azgvaWNRaXAwdCtSVmE5TTdnbEk3NEhWZHN3cDMxR0xYWFdINWdtUTl2bnpG?=
 =?utf-8?B?Vk9tRFRDenFzVVhGYUhLK1l3eDh3TXRrY2ptdE50TWQvbkNYZlhXelYyVW1N?=
 =?utf-8?B?TFpCd2Mxbjk0aVM2Rlc3cnJXUDJFRStrRmZxaUhkMnJJMXdPK1laMUlRNDdL?=
 =?utf-8?B?T0w3SWRQdmFYQ2ZieitYaW5USmtuM0UydU1GeWJoMkZjUWxSb0dpMEU5dnRG?=
 =?utf-8?B?eEFWdFJxWFAzNklTT3lmYlBDN1JNWUJISklPT041Q2xGOVhpa2tMOUM5YlV2?=
 =?utf-8?B?SEFud2ZKblYzdytoTHJPcWJxaXkxSFNWREJXUGx4VU5pVkE5NTMyWHBtZ2pE?=
 =?utf-8?B?RU9URElkWUg4aytyWTVUMTRhYVZQc1JEU1RVNTEwNHA0eHlJWTFvOE9lQTZR?=
 =?utf-8?B?b3U5aGlqTkc4cktLbHAyY1hIZTcwd2lpR1gzMEVYUWFpVVRWaVFBK1VqNFh1?=
 =?utf-8?B?dnNNZUxjZThVODdzNnQxaVJtUUhLMFUzSTBLRHVCaStaK3AydGpicUNJWHlN?=
 =?utf-8?B?N3dqRzl0dVozMHU0YmI3N2padjJFQ29mdFMxUXdHNERDRGVZVGNDaHZYWHFR?=
 =?utf-8?B?S2ordlZjZXV0N21wZFBRdi9jSUZRaVNWMWxzTElzNDZhOEx5em9JOW1GWW9U?=
 =?utf-8?B?cGo4MW54Wm9tU2Nuam0rbWdXc3BlbElrejU3dzEyeXVRR3llNDdKZEJoV1p6?=
 =?utf-8?B?UTBicjZ2RTVMVlgrUVkwN1dML1dZK3RlcGwwYlgyenB2V2RZS25OTm02eFVJ?=
 =?utf-8?B?aEhuWDBxa1pqTUFvOWcwamxWbUJiRnVtbGV4NHh4Q2tmZEs3NzRCMzdWTHY4?=
 =?utf-8?B?aHhEV1VHVkVqVi8zanlaWWNqR3lIRGx1a3g5Rkg0WCs1eWFZUU1IRXlBa0g4?=
 =?utf-8?B?aG1zTFZRdlBLbFBUZUJlbmVJSzFlby9QTEhJdHc4ZTNiVmlqSzZadEJzSW5h?=
 =?utf-8?B?ako0T0RUVGx3aGJMczlWUlBJVWI5UUxzRW9TM2haZ1ltL0FYN0FybjhFc04v?=
 =?utf-8?B?bnhUVnhyK1F1NU9qVThZOU9hSzIrcmlrbDAyTXZrT1Q2NkJMQ0p4VXBuUFFW?=
 =?utf-8?B?d3V3M0RUZExNZzlVMVFVc0dtYVBYQ2l5OUxVdXYzcXdrcUlqSEpWajdWWTBu?=
 =?utf-8?B?eW9JWnpvWXJoRUxWR3phR0xFWC9WOGNneWQwZUZGYmhHR0R4S2pNOGpxTkFG?=
 =?utf-8?B?TUpTUWxYd0FrYjkxdkF0S0lnY0V4c3dsbWhUcjBWSEpKb2pmMVNCRzNTTXRL?=
 =?utf-8?B?cU5tdFBrck4vRjRkUkNRcE94cUdBNStmSWc3bXBuMlV2REtCZG1nd3g5M3Q1?=
 =?utf-8?B?SjFyMmJhYTBNZmVSZW5CRlkrM0gvMXZlY2pvMmsxdHZjb3VJSndKZWN2c2ZK?=
 =?utf-8?B?aUpGQVB0UHVid1YrSUpiWkRtWDhyN0JwZ2N3K0Rwb2d5c1p4QXNyV1RnK1lD?=
 =?utf-8?B?MFJBeEpOWjJ2K2x0SWxmTnFvd2RacVBJVDIrcW9wd29EMVE9PQ==?=
X-Microsoft-Antispam-Message-Info: vXj5srTrM3FyhccJHfXstq7+RkF1MoSq4hlrpZoQOWYRCi59X1Ghx/rKpDf2UM/m49i0BkT3TzjZ5yE8bA8W/PyL6g5tnwbsKyf9EgM5GTVNlNt8e9UtiaRYnZ5m5f4SXnV8sosKg6n8THHraxKz7lGgA946KxoGMbR5+IEBpEvqeArjw3d6ekwkyosRpiAL
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;6:cuak7XAqzwjv2nwm5MJaf/eVLE8sB9CNxGJVe6u2gDrmS9QDGujrbRRQLui8VPfJNwaI+ty1r3uMt24FdfaJfz/kuxGB7LoR6eQi/EX3lk1vvgRUO3JExOXtBM/zJvbKMsmRQ0u/6baQN1m8k2KbnpN7W88xL0gDLIE74T+hDsmI0hopUQ/rPjmQSBHHk+kLCi+n3h/IlxJMFyx9fMMl4ldA7CqXK05gEfHd/pTpRHxeMHbdz0aONbx57LUttwa9dXs0Jeu4yUj8CMyX9P2n1iJStPKVnfHm4YONpsYmIWUbWittNlH4TwYoo4/v5YDK4BJ3cP6qC0fjz3CnyNRtS6gCc8hgbFcrM0d0knSmZIlpzY28ejfw8hRXNquKD3k2YekEgV1cak652y6vdbHhLIWenP9TGOr1SvEkSAh7JmmM7UhpJgQ0DYd+IPIyro+ahHxsbbLaVFS/7cijCNtphw==;5:Imxj28hU13HT+qjEFqm3vdtw8VjeLVElg+L6LKYGVPn5aKHvwHVkA4eHmKQEttohpGcvSSwV6G/DZIgrK1NNCxJWTommyOln7GK+ae0eIU4GxUvjIvgkA4akQm7gBwDnwXwK6Rn8HPZB9A4pjppNUbxM4hjMc+hcNmjCjfwx/B8=;24:Gft7izNEcCGaBjXJpSCw7Eovtj6MmHzRT1XwMzimWDic/Jf35fsDV3RS7sLRUPvyFb3tUqYloGgIN+hC2DThzTu1Z4GKgmuC7abnc+kcWkU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;7:vm5zJ1O6RCrNKeK74tvreFPQhW6MzzWNjMaF82WnkvK505UIFySiQaJS1U/he68bqzId0Oz2QdQ76f2AkcpmKQ6EE/Uet3vqcWaOvxOClv9UIs7FcCBoHaLu+s1KpQ5SPRspcGLMbvHIlcd23b2qXOq1cfIUgrnnxy8DtXdeB96eg3MjK0gcANfgVn3kCfvpKGSNx682egpA101f6VPmn7DM1YSw/sMsUmrAK8C3YgASdxrmQt5yiGtkV52z6m+H;20:LKdFfJ24s/Igu1uk1exe/Itp0M0+aSE9hvF6LkRTnqvj+6BAybDCKGMtjeGYgDOfF04ReejgpZtAsxyrBvu3LmKSuLETy+bJupEbaxTl+PIfQgGxlBOlc6ynEjcJjKDe/B+SaAgSlNR/aAwrh06NE+FlA+YRaLWwq++Jqc6qG/P/PQPZsvWssENc5ceSxMfa055J0wgRvzQ1VdwpL+6djpQQmZdPR0NgbrCdw5sUbr9mgGMKi1GZijHuXVb+p0sf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 18:55:00.5978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4af4f2-684b-46ed-9519-08d59a5d91d9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0693
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
index 41b8c5757859..3dd2e73d31c4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -412,6 +412,10 @@ void iommu_fwspec_free(struct device *dev);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
 
+#ifdef CONFIG_IOMMU_DEBUG
+struct dentry *iommu_debugfs_setup(void);
+#endif
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
