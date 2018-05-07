Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752817AbeEGUCX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:02:23 -0400
Received: from mail-bn3nam01on0083.outbound.protection.outlook.com ([104.47.33.83]:23990
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752081AbeEGUCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:02:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v5 2/2] iommu/amd: Add basic debugfs infrastructure for AMD
 IOMMU
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Mon, 07 May 2018 15:02:12 -0500
Message-ID: <152572333293.3235.6665347563158972538.stgit@sosxen2.amd.com>
In-Reply-To: <152572281179.3235.11484188869064303333.stgit@sosxen2.amd.com>
References: <152572281179.3235.11484188869064303333.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0701CA0020.namprd07.prod.outlook.com
 (2603:10b6:803:28::30) To CY4PR12MB1445.namprd12.prod.outlook.com
 (2603:10b6:910:f::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1445;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1445;3:x0e0aOzOrEFAbMzTJIH1+HV57qaea3p8p/sR64k56+YyqTNDnSU1dqoZ/duLt6f4dJafMiF8baT66Eeb1wPlCue+M21Ej5dnbyZZM4fLOH1HQN0eyo1AtHzqK6X5uErZ8wfdVqO7jKpPx18Q2KicLGOEIWj6YWVrmxzXmUx58B4kCH+Gy1g0Yn4vtCzbDsL5/Q6MxWfDxuxelhPEY62FxsFLRmTyH42UCzzsdNLGw3NzzcQHsHDSVqu8h5NodH+f;25:Qwv/G1vHpA5F5Foz0HGnjVHxd0heiP1eSN55KC0GWuqJpFxtaQMqjzMmwbM2IeAAZl2xF3yj3MEamWszDMKJn9JqfZPmuSx1HFF9U406sDpYtyE/uTFwGyHU0WyiBPucrYWvC/iXsic4XzEgOjySuyAb2DXVBz8EMecpVXU1/lGiGXg6ZvmQiQtJ8wRhYKsMk/YjUvaB5jxDtyQTEBxBWuHN/QDrYwBzCm71JqpDt/ER8nT3VOgjlD4ZY3w03N28YAwcUq5wPBUoT0Ss0jXJW1JXR7Q1G/qUxvpMJbshRqXOYNYpM41TmnMzpeUMxLqNPUqgTFZenWRM5D6hzJdNBQ==;31:MyC3/HBCqgiMg3MuV9fs5t5NL2Wm2Fczf3Iu4cUg89Y2tYUwa/yyTh/bvG+lKxGIU2zOZJN725S5MDVCh833KRdi46aoJgairAsdFIUJEQY9wqUiRFuY/hfaVOA/3a+Wp0MtIreuR/oazENSXRqhBWYJknEGqTnNuiI/44DIThOAyLfPmnh2PKKdlPHqAY5YPpVr4WcxTdn2UQw97vlPkv6RtmX6pUVpbGvj0N7vshA=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1445:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1445;20:sBgrmvZhg7uhWWU0LK0d3Jon3GREyrClPu1glxmWed+oRgocsw8Mgr+ODT2TZOmDZDPEgfETRS2rdteySGXEKKxM99zuRcf3k+GCMMU+BUfnXMwFtnQ55QdKcbV0d7PbCRpHD0fkLSgaMr0jaN7gFZYfUs0TA7WLJjpA9DBD6ZBsBKyTKE06cBm56X3cU3dlXvmKJg1JfmS2f+fi+sYDpk4rrjuGNTrctWWK6OBoq0KhA7Ap8Nlto37JaTFxQ6cskIGeQ2jKYdTvaOjg83nOJIoWV/YtNOFJ5dhvuuBzEhavIZKU2u0d1EdkxmVg4DUfpuGC8tYnVvtCYJVNSTMrBTBxTHMquom0UF7Z8I1UxUFrUHDMFaB4DaoHmk15oCtoxgfCTbUB5wQ9UGKiYDa6fiHu33y3rcjQwLLXoP//UyLEGuxg5uYCHEtSO6+Y8gv7JOnt8a/VcML/T3QDNIc1S4IDzZcjyI+HxHqcukACPmBI36MwVrrpS/v9A131DWxj;4:hZ1leBHUfWDEZRk1Oegq8yKMwU41noGNjCTtq1bFYfg6oDHxBV9F+d915GchDxJGvXOn9HrqWJetNw6oFbK6+gk51Q7AevWq2XYUQYFo9h0OIu7tVudBmZjjYrTS9TdEQ7au3tGl0Nm3reDqxAtTDIZPrm1bRx55AjBhoySFx+UPxSAuo2DXvsYjKfTBOZyWQifBEIjkrIHPjg8MUQ4uXfirZj8upgT978SwRwhSiTOiXqD5h62UwZSiI0idVI99+QSuRqcVA37BM8sX+urgcvKhtIXTiY0/G2HHWRZKNKB+kPCjBnC+R8TroBHLf/r2
X-Microsoft-Antispam-PRVS: <CY4PR12MB144506E40447E7A573F30AE8FD9B0@CY4PR12MB1445.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR12MB1445;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1445;
X-Forefront-PRVS: 066517B35B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(346002)(39860400002)(366004)(396003)(189003)(199004)(7736002)(76176011)(47776003)(26005)(3846002)(305945005)(6116002)(186003)(16526019)(476003)(53936002)(59450400001)(386003)(81166006)(81156014)(446003)(8676002)(7696005)(66066001)(2486003)(52116002)(23676004)(8936002)(956004)(575784001)(86362001)(55016002)(4326008)(53416004)(2351001)(106356001)(2361001)(316002)(2906002)(25786009)(5660300001)(58126008)(103116003)(478600001)(6916009)(486006)(105586002)(11346002)(230700001)(6666003)(50466002)(72206003)(68736007)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1445;H:sosxen2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNDQ1OzIzOjM1UGR4OExNczBMWWQybml6bFJiL2R0eXF4?=
 =?utf-8?B?QmFKYWVwc2YzU3VFNWhoNjlxRFZWQ2J4bUF4NWsyQXFnMmhFNEIyeTBKMGlr?=
 =?utf-8?B?bVluNVpSeHJyd1pwR0hEM0ZabWdhaDFJSXUrK1g2Y0p1bFlOWVNWUW1VdnJE?=
 =?utf-8?B?QUkzQ2J4VmY3b2VDYytFdCs0cVh4QlZhdlVyb0Z2S2ZFcEp4WU1LcENJRG9Y?=
 =?utf-8?B?TjVuTUtvd1JyRS9Na2Z4MFdscHl1TjV3eWVMZ2xaWlpZMUoxZCttUDJ6NGM3?=
 =?utf-8?B?YnNIZFFtaVFZOGwwdFRSZVBQQkI0Z0xsVFd6QkYyeVNpSm5xSzNZeVJmUkFk?=
 =?utf-8?B?dEx3MTF2ekNzaU1aU0RDU2JZYjRFK1RpRnJVQllzZTBONTZ6RGlhWUJVWTg5?=
 =?utf-8?B?SXgrZnJCOXNCb3dPcVZSSjBkeDgrWjdKWnhwaTFpcUFGMFIzYTNQZ2RPNDZY?=
 =?utf-8?B?TkEvRXVUbmhwT2ZMTDBiSys0NW9Ic2tNVGpjb1V6WldSNWtKNzEzcWh5eGZN?=
 =?utf-8?B?VmpvODNOeDBUaGY5RnQySkwyNFdUK2lJS2NpYVEzU1ZubmtWaWt4NnZJVG5V?=
 =?utf-8?B?ZFhXNVMrNFlER1ZKaXl4V1hqeHYxdkZlT2JuL1dUMUZmYTV2emFFTDhEZXZK?=
 =?utf-8?B?Ym0xYXlzUWVWaFV1YmpOR0VRdExwd0lyTWRtV1phM3BxN0ViZzhVVXJkVDBt?=
 =?utf-8?B?WkxUTVpyWGNrcmJSK3VpTUFMbncwSFN6aWRVcjk3Z3ZDdzg2WmtYcVFYNG1Q?=
 =?utf-8?B?TU9keHBTaXhLcHF1ZDh3aTRkWW9JK0pCUGR3Mm9oSzQ1dStPNlhuNS95M1RL?=
 =?utf-8?B?N09qNlN5bVYxdCtRKzRMOG4vMndlOG95WW45alFuVlZiM25RbExoaUxTQnBY?=
 =?utf-8?B?ZzBCL25iMEFFUlV2VVNsZkNBYVQ4clZNbzZEYlBCQStuSDZWUndoODBkN0Y4?=
 =?utf-8?B?dFd1SVhIcXBrRU1McC9RTlZ1TUpaMFpWZHlvVGFsL3kvNmFHMEtTSThNZzN2?=
 =?utf-8?B?T2s5WHg0di9iakdVRkpRRTB3SlBQYTU3bU56QStvZW9sd3hRbUFpcUk4Z1J0?=
 =?utf-8?B?Vjg3TFJIRjJZNDMrdnVRY0lGSHhsdGlFaHFqbXFTQkZRcFBnMmRCUHVsaGlz?=
 =?utf-8?B?QlFJZ3A3NEVqVzhsazVkdXZNb0x4WVFGZlhqeUM5NG9LTW5ZR1EzUWdvNXJn?=
 =?utf-8?B?aURrUDVsckR6TGU4Z25EZUg0SWVKdVZOQ28vOW5nWFMrSC9lWXJQMTNwcENM?=
 =?utf-8?B?SmQyOWxCQnJVeHNhWmJDb2hidWJRdDd1cDR2N2svMnJGbzM0UXpHTFVZZDlV?=
 =?utf-8?B?T0UrdUVMbHgzUmV0RDVuQkwyUTZFV0gvYndmUmxxSmU2V0R2cStFVjhESFVn?=
 =?utf-8?B?Q1paTW1kcHQwZUlFTHRBZzl6TmZ0czEvaXhQVlNGZFdGV2RGRDRVQ1lPK1ZR?=
 =?utf-8?B?UVBkU001Qi9JR09ZU3Y0c29oMTJLL2FLelk5bUxhQjA5QmRmNzB2Sjg0RXJU?=
 =?utf-8?B?UVBSRW9KZnRzU0lMMEhpY0h1cEFDb1kwR3cxQ29tZmdoaC9TVXl1V3llZzhT?=
 =?utf-8?B?YkFSTEtvRS9jWVU2M3d4MDVGOUprYTNWNXdKZUlNd2pYMHNWb0N0RExHcFFB?=
 =?utf-8?B?UHZpYytaVEhvcmg3bTdTOFhFem1rQUs3WnNmdkFwM0xRQkVtWkdmMXk3ekVL?=
 =?utf-8?Q?qMBeqSl1eQa2OQrF6ty7IC9coUZg0ZJ6F6ejFvA?=
X-Microsoft-Antispam-Message-Info: kI+9T3+x/LsMhFqe98t+U8VJ7lQYp/MKG5KquO3Odn0lqcXFM4/kVFKbH10j5Md0u3zHmomPomVeII+wJnxne6CrJHy+iINhotraPSb0hhsY5j3tekyi+pExrmJVg3TcgaxIfuTtiOVLBIL9HMDIZxHFJOV8b+F8zAU9+FtP+zaSCkj8UMNP3P/ZUPtGCr12
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1445;6:7LXbVQ7oFcQnoPRfXsBR02yWFkKixNtCkOCZ5PnnwYlRsUaeyc17bZgFuny2DJ5DaKhf5yOuYFeZ/VOqmp7Gi68wCT2GhEXZxr5oFflsStjzLuk1wr2PJPKZvFQVoB1Y9+hH+dIuqeZj39Yj0q0QGG5qtbaf2eMZVp1gTzqO9lLKhF7vM3NrZB2gBjA27q3pAffTy6Z9eMTEHpuY8qwemAOyVixcRjQs7ebBRoEjD4FRddyRjoErzKsabtsOf3P+jtAfiW1Qi+pB/e3Vo3vCBsgwuEC5Thu2/2QMiHBRY2x/ADgzAvKEaqZb2ZjoQlbJ/KKrwlHCIhVVbQjVLfzAQIOVivGHxsbDAjvdQQPLwLCdzqKhKhHXX8PpNTKgBw9Qihz8XKUWE/ftvM2roWdNEQijTJW04+msXOcghPv19fpUCy8YybH9S6mFepF0NtnWtpuhRBmWVyLhl4ZmVynrNg==;5:Dk567xd1pdskoeUJNWmKHooDCdN0vS/JhPt5T2kypoxBoGzfEVCSILbTZBrJpgTP7hzOhjDlwMsfazhcKZOQL42TY8pxI76Wv6FSTHXLt+szXUs/vm9Toejfz4NaMeIn3pYzDyAb1TBs9JDViQhpUAMvVdLjOoUbWBqvSZh816s=;24:HSrFSlajV6nJ6UOR3Sqt3KmOls0BwzwDLM0wC+vGmKDRKQU3hTOML80qL14ieOTJ1h7ktQH4paXVJMmYk/L6BTYojDky6VA+S3YhZ5MTt5A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1445;7:Qa03xzKRg9VdsmUysIuYkDXPfFMNSd6SDDKVi5CLqdVriWlmKuPlKEnQ/eNQTO1VvGtwREdNAv2A3ZRsf2r44SObxFFWcO/wFIvg1HZyXtyofannArMAiEVlJTy5jO+UL1FH5wve/bPDWcepOxCfn/z+GMnTff/qNL+pc3i4w+t+nhTxvf8uvdaYF/jv9Vjfxc1IQ84n83OD1JXTFSAFT8hURWhSBODV/e6Bt+M6TCyjnAg09TA0gid2yyGPWqh3;20:5+NHDUdr8Jw41QxkJFa4n0l+BnZm2UC6r5ITrxSW6MN6oRfS3U/Rrd6G3rx+8C0MJXoX4wN2gCQWqfsHOO1COPVXm+fVznm1I+07IHeuat1mvMjR/u0rqxWK8yz/SmzJASu/LDs3+owjHozBan5wHdP+229DESlSi/bYk0lO2sHZutGgxOBbZr71cxLk7QvABk379of4qxY3iVl/eGOcrImCpdhcOlOEiGxSWRSzzKhSgukNVODMedVjkSArHqfg
X-MS-Office365-Filtering-Correlation-Id: fb390ffd-4989-49b9-cec4-08d5b455705d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2018 20:02:19.0240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb390ffd-4989-49b9-cec4-08d5b455705d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1445
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a skeleton framework for debugfs support in the
AMD IOMMU.


Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/Makefile            |    5 +++++
 drivers/iommu/amd_iommu_debugfs.c |   41 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    6 ++++-
 drivers/iommu/amd_iommu_proto.h   |    6 +++++
 drivers/iommu/amd_iommu_types.h   |    3 +++
 5 files changed, 59 insertions(+), 2 deletions(-)
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
index 000000000000..2b351b9f9130
--- /dev/null
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -0,0 +1,41 @@
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
+pr_warn("GRH: %s:%d\n", __func__, __LINE__);
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
