Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeCZGge (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 02:36:34 -0400
Received: from mail-bn3nam01on0077.outbound.protection.outlook.com ([104.47.33.77]:48357
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751171AbeCZGfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 02:35:41 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@suse.de,
        Borislav Petkov <bpetkov@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 1/4] x86/CPU/AMD: Remove unnecessary check for CONFIG_SMP
Date: Mon, 26 Mar 2018 01:35:13 -0500
Message-Id: <1522046116-22578-2-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522046116-22578-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1522046116-22578-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR1201CA0024.namprd12.prod.outlook.com
 (2603:10b6:405:4c::34) To DM2PR12MB0139.namprd12.prod.outlook.com
 (2a01:111:e400:50cf::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d33a3335-b506-427a-4a6f-08d592e3c98b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0139;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;3:flmnWu8ZkGE2sRs8YVO2zx5SFWJFgXi4HzQyKSvsIPYBts9agxIKBCMa27BLfAPM7Ymozwf/+z/qusypRm8DT8sMB8aQYpTTegvmvUrjj3OjcDFk6RTDz+WQjrxCJ1LGVTSBxFkgkA/8LoWOGXOsCJqLRlrEIqmFZ4JCNtdkOxzsctZBPuyRi5OFud8fgJZPuoj2dbB/PuvSf8c1kNnct+Uvfm/w/mVU3iyk5dgFE85QUbLlVXjBT91LQv7Mdkrd;25:duC47BGXdWh8znBqZNiXwpIMXI4pk2jEF+C1gRDqeH27OvpgQQpCXCj6KbnJ2yhqFYfWmXx+y9gjmn4U8CQKWyxzPIgzc0lytrhFNHYzqUB0B/1Q4ZRJUCG4Hh5ALlhlmhcXQmgLboiiMxAao5Se79aJanTOIoLQaVJ3ttkG0KFgpNFihp4PPjOY7484mDuqxJxnSsjuxzv33Kk+Yq1G4btq0Bu02MFwx3/FnAOKiqt7nQHLzP5TqlKNNICHSqElG+UZ6XIagiR9EQU6wfa9dLQOuHQHyQ7b7BV8XNemyteDjfKic25Gubk4442w8vjN18SRQrvP7GHT2Wb9KH1JHg==;31:w5bl32y6FYiw/bAN2I9qVKxMAsnNnxLHcnknXyebCc+nofTSpK9dfpk5BjBK6lPrGg+tRG5ugrFidBRaW46MNgIinCYnM58MH3zaPOQ4KZS61nj49yX5qRTh0htx2V+JZSpUsK8bgs/qb+DjysnQ/C97Bu4k44ysxDZjtNWNWqAAsThORpdFefhuqTxT2nefT87xuCQJLGIrnumnvNVz+/xgNVYT1E8vgh3b2tiD3pE=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0139:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;20:pujeV5YMNdC1+wouUqsN0bwSAlN0Z8YFtfVBawlloIOsc1KzhuN049FQpKYmX1XZVVMANUMOOeqkEDTte9FiQV14zQzyS7MRhLmdodDlQqcJ/zf33sUmh7EPc8AUsWtX7fpOdq4INF5LCqadgEp9m8IJqUmqtf86N2AD4hORivcD01Xr9sdvEfLbyvxrkMmbzXGCx/8NPKdaZi/I0DqKhxjh4ABfEMdn41bPNy3TIJ7CbodHrcM03vPnBaIEM50pZBMTyv8OnZLG72dMGWzNF7GFLUyQzHHSBqMaXyn4bBtmrH7YO7z6rougsRtIX5fkkMdOdUXcXZ5njtEiurkPG0G7tYqq4QRGnvJbYYGSzy03qiL7WEOAftnUwPT+RNWC4y9XDEoKJpnRlAguQx4gf+nsUXjz+tOqLvIrpp3qxLt+siPhClDA9YTFD09lKhJTDQmZ67GXfN43WKCCNKtp43xBRNYUEclWts5odOqgBEbrSYeERI6x/YZGPjye9+1X;4:s3EOOBcgh/RYDB94FncfquUeoLhk8TAFkyzM0L+DkAJ4hkZynwAPGCF8hU9egXwRADj0PztM5ROZxdc4vIZWx4hZ+Igbo7SgKmJEW+Dkk2Qr3LnqH40hDZUrJdSRCLWBg9rlsH5bZR+sR78nH0KuOq1qZ/nSpybJK6UkwdF4WFviFBWUBfnJkAV2SYD0XHW115g3QaoAjq717dWD7U9/oW5eCUKoj3mTufvXFlCuU5MAFMPjLiW40FottyPNo3Ip5ix9nJsyuVSo74pqVZE/+0rtDRm2BZ9/4TfUiSkceHyzUAkBW0N/3LlmDbJ56RE3
X-Microsoft-Antispam-PRVS: <DM2PR12MB01394C0E27F1EEBA5A14A457F3AD0@DM2PR12MB0139.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM2PR12MB0139;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0139;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(189003)(199004)(48376002)(76176011)(16526019)(6486002)(52116002)(316002)(186003)(47776003)(575784001)(86362001)(3846002)(6116002)(54906003)(106356001)(105586002)(53936002)(53416004)(68736007)(81156014)(81166006)(11346002)(478600001)(97736004)(8936002)(446003)(72206003)(8676002)(16586007)(956004)(6666003)(25786009)(7736002)(305945005)(50226002)(50466002)(386003)(4326008)(26005)(7696005)(51416003)(36756003)(59450400001)(66066001)(2906002)(5660300001)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0139;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR12MB0139;23:4A2vdKjSOMIOjys5PY9NBgI0qgkQNyApbAwykytkP?=
 =?us-ascii?Q?5xV61kHU+FLydpT2YSWVvCWO9e2ryc8W2IswqySMlLfxSkenVxk5bO+8uKl7?=
 =?us-ascii?Q?3uzU6as6hi/D5hqYa0k8MqVz5jJyhjyX1UGIUftofFBW+mnKXYqoJpKHsViJ?=
 =?us-ascii?Q?Zz8QT87X3aWK04UetSPSIvmxha1tNehE5+G4QTEtN159bk44LZ+1eaJn5QK6?=
 =?us-ascii?Q?j7afgdrwXHlAIgJWKMl+MAVFprZ5QZHENhQTh1zdmJsNDQ/jq6b3U507sNu2?=
 =?us-ascii?Q?UD4vPGFMwrBWahlOUZxF/TpOgOp25Fq1d7joklMuBpEiwoSlBUDnPhZ4cLH8?=
 =?us-ascii?Q?BSEFp4A5PFo5TEtmFOVkcsQtpA4HrLCSJP+/IOYGL0EyImORgDJladuk+stQ?=
 =?us-ascii?Q?w7NZnm2lSr21LQ1XIDH6X8aFFrndnnRU4RtMw2XJSpJVFyhQOZH+7bG2mmAU?=
 =?us-ascii?Q?1C0tjkN9WWGj4MsuosW+6BBhs+ZRvKkaWKNPTG9MmUq5M9uj417yJlVippn+?=
 =?us-ascii?Q?baASI/8p1I+EntBmKIKWw+D4AJypcze9dtQ+bzNzmDno4k8LKNng1akDaklc?=
 =?us-ascii?Q?V5l6hdjqidCGjgWdLktZ/LVEDslu56SJmGFLGlEffjTI389Qfclt4b1hDTs/?=
 =?us-ascii?Q?ThBACY7AzZQIU4OqXzCXlKGvrQciuOaIKXtFd7cxgAv5H3ksjH1taBSgp/so?=
 =?us-ascii?Q?78i4I4WAPk2sJPdne3a4uL9a9YOj1b8NxVdgFOk3ugKt4NBpwo15YyGdVtXr?=
 =?us-ascii?Q?VYB7jbBQK/6RqGpMFm7NguzsEBxy/ybzAxWjbheGC96YUr9651UZd1tyPLKc?=
 =?us-ascii?Q?7ez+15Cz3iKx/wvvWkTmMlUxx4pRhqH6JS6C0cOtunMaFIBa6oti4xl44O03?=
 =?us-ascii?Q?VohLJ/px3u2vS0/AaBpwMMMdR7XYRAutK/FIoK2EkLFgoiOXJ6ifEqiH8u8S?=
 =?us-ascii?Q?NCVjdqjQs0bSFwB+FZTNrQrOvS1VrdPMFs+hxAsS0mNrbTv8RNGPH3qaa52j?=
 =?us-ascii?Q?0DNbRKt2ssvWMaMoJFDiHem3orxsCKlXSg1EJWFN0lpdtJvLbBXTFy5goMeM?=
 =?us-ascii?Q?BqUtUhbeLe7FGyK4ZFP4GJrWdCVqKHoD9HNYd0GSmDF+tL3QBvEn/4BNV5+a?=
 =?us-ascii?Q?OQ0DiT2zdbZKvrm00D3NGLKz7kccUtYRGcI7v7P6kimPMUXUWVkCeRjOVz7H?=
 =?us-ascii?Q?1Nw3Ahl3PCQNZgZIYERPFZwu0nGt1GBfUeQZSGhmLre+SC5mrXCB8e/ew=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 1GoLh9dR832xH6W2usQozMF00Uh0of/3eUgyMLmgsGWBuQTqEqSiJTPFGxM4Y1BoWPjIMWHont/d4cs3QrXbfVtV6KBR2dUCcFhH3W1l/1VN5BWpxj/RPuIXgs8y6ZOFvuH2/LbqC/yRIMoWGK3FJGod4A3i72qez1PW2DFgpC2c0Si6uz4S/Ri7Oe5fS2J+
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;6:GyPgfekT6teSe15q5e79i1rxRrdceloHyExjZ3hDTOu97q65M9iSOAuIi5UmhXMh6u+LEzNEVmpXIuXykxBM+iaYnk2oT609lfr9fZjiCRwK2AA4Rafg+lW6is3E//wGvpyuyggIf+cezMj5oltRKDefMIEWs0tUCzpZkrVILIQeo+IYnpJH5+PjSxlKPR94SiPeELBchTOA/bco1eytAB1ISxSJ3t16DYArDBkzjGmJNu+SQQovk2U7G4IBQrAX5gxggXmwhySmuQfGaiNfcbZYLZdsl2b4L+CF26wJY9t57I2pP9ky4wEvRCtxIy72R8Sv/SmvLAsh8pRvmfB33wT3QHFdfce/oC1ruh8hH+w=;5:PmG9Xr0qrUq4EcyYjEnIRfFoqbRms9IVaQfWZV7QmBYOBpAfPNbsAZwMpvYx+fqdapjPY9WygqbGmSj6FNygjAOZi4hjuABLLpzCOs+XzmBePQdsefM2gOf3yxA7N8WKZPGJK0BlwmsPzJglVYkLLJ95yfJ5c6YoZ42xTevTqEM=;24:MvqV9HXOP9yphkYHOEYRXCQCI6CXDf/ispvuZc+Ufn+nPb8aW7dvUSdxuJrmsof+LaJ3ZF7Z/NHiV6NR6GxkAumumxfxssNaccMbd+J5FWQ=;7:MshPdf3+BEKMwHJFbH6n5aPfJccZuFrLrnNU4JRB+z5Ix6RkXyYGriTLWMg8xeYZDcJ4K6S79mUJOaC/whTK85lfR/jSJjpUgH++atFb+ny8i0SnJGup141WVWdSJtlEDNpHtRf9IFZfLU9FMwUw0L3eXLnlVulFZOIqEROQHTI7FSN+8iK2SxtM+V3jEE3IhOMOHg3/Uq66sH9X+9km5aL9AWT52vaRoeL9RHOv+M3u88DiB26Jo74vWASInZGr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;20:tvAo38oA4+EKytRw5tax4UxAaQgTyFJq5l62zFLygcWwbBhABU+nL0G9xKWCbpic7ZPDx0eO48O2UKsiYhvUMSxTNy/jzK2oYJ6fkjlFT0DCYIF6wkqsUVSyCTd4yTNpZQ0ZFYwQ8Y4SeCa9w+tDJjzMUqBT80ViMWbF55xAu/ZxfCBCu4Bj74YKxs1cCt79FraMNx58QD+TYQ6pcAR7hF1TogzirCuD8sPZs7OMh7/xrCu57P0YrRYt5NpeHnzJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 06:35:37.0467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d33a3335-b506-427a-4a6f-08d592e3c98b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bpetkov@suse.de>

Move smp_num_siblings and cpu_llc_id to cpu/common.c so that they're
always present as symbols and not only in the CONFIG_SMP case. Then,
other code using them doesn't need ugly ifdeffery anymore.

Signed-off-by: Borislav Petkov <bpetkov@suse.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/include/asm/smp.h   | 1 -
 arch/x86/kernel/cpu/amd.c    | 6 ------
 arch/x86/kernel/cpu/common.c | 7 +++++++
 arch/x86/kernel/smpboot.c    | 7 -------
 4 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index a418976..59a01f6 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -171,7 +171,6 @@ static inline int wbinvd_on_all_cpus(void)
 	wbinvd();
 	return 0;
 }
-#define smp_num_siblings	1
 #endif /* CONFIG_SMP */
 
 extern unsigned disabled_cpus;
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f0e6456..922f43c 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -297,7 +297,6 @@ static int nearby_node(int apicid)
 }
 #endif
 
-#ifdef CONFIG_SMP
 /*
  * Fix up cpu_core_id for pre-F17h systems to be in the
  * [0 .. cores_per_node - 1] range. Not really needed but
@@ -375,7 +374,6 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 		legacy_fixup_core_id(c);
 	}
 }
-#endif
 
 /*
  * On a AMD dual core setup the lower bits of the APIC id distinguish the cores.
@@ -383,7 +381,6 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
  */
 static void amd_detect_cmp(struct cpuinfo_x86 *c)
 {
-#ifdef CONFIG_SMP
 	unsigned bits;
 	int cpu = smp_processor_id();
 
@@ -395,15 +392,12 @@ static void amd_detect_cmp(struct cpuinfo_x86 *c)
 	/* use socket ID also for last level cache */
 	per_cpu(cpu_llc_id, cpu) = c->phys_proc_id;
 	amd_get_topology(c);
-#endif
 }
 
 u16 amd_get_nb_id(int cpu)
 {
 	u16 id = 0;
-#ifdef CONFIG_SMP
 	id = per_cpu(cpu_llc_id, cpu);
-#endif
 	return id;
 }
 EXPORT_SYMBOL_GPL(amd_get_nb_id);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 348cf48..2afd854 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -66,6 +66,13 @@ cpumask_var_t cpu_callin_mask;
 /* representing cpus for which sibling maps can be computed */
 cpumask_var_t cpu_sibling_setup_mask;
 
+/* Number of siblings per CPU package */
+int smp_num_siblings = 1;
+EXPORT_SYMBOL(smp_num_siblings);
+
+/* Last level cache ID of each logical CPU */
+DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id) = BAD_APICID;
+
 /* correctly size the local cpu masks */
 void __init setup_cpu_local_masks(void)
 {
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ff99e2b..91d48f3 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -78,13 +78,6 @@
 #include <asm/misc.h>
 #include <asm/qspinlock.h>
 
-/* Number of siblings per CPU package */
-int smp_num_siblings = 1;
-EXPORT_SYMBOL(smp_num_siblings);
-
-/* Last level cache ID of each logical CPU */
-DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id) = BAD_APICID;
-
 /* representing HT siblings of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
-- 
2.7.4
