Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeCZIGn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:06:43 -0400
Received: from mail-bl2nam02on0080.outbound.protection.outlook.com ([104.47.38.80]:49600
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751204AbeCZIGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:06:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 1/2] x86/CPU: Modify detect_extended_topology() to return result
Date: Mon, 26 Mar 2018 03:05:58 -0500
Message-Id: <1522051559-23415-2-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522051559-23415-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1522051559-23415-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM3PR12CA0080.namprd12.prod.outlook.com (10.161.151.152) To
 BY2PR12MB0130.namprd12.prod.outlook.com (10.162.82.156)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72105457-4211-4968-3432-08d592f07070
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0130;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0130;3:9Uh7nDyph0T1WpHBqjT0mJxBKZU9/GHUcOTsWY+8Dxvk7JEwCXZLzKAJ7CmDvshcpwX2o2XNz+1Fd2AggBz86J206M9RJg1Kpg3eRhUvTTgadiO3YiDHUPhqYT35bFAiKSOSx7fRh/FprrI87SHgcCTjyWg7ddEadv8+lgsP7gGorJJySKEFQDdyXtpo1C4hNkqUsLEH37561GEVmW6NAF89b4bSatFvN8EPEEWCVaBT23RSer54tnO3tGSKgTfi;25:aIfgDy7Nv7Yc6WX5MnDI3JHjUCfvPVQUM4knKPlb/jLY1Obw6SQ/kDR7/rnmRtSiEJJX5wX7xMp+hWfBfBGwAuWG4Bj7kz0Qbrp+5anvYSJNyDoope1nHtfl9Ia9yLivM/da891FI0tAPt2jbZlznGp/sipqOhFBpsWbJRp9ExPxS2pxophgCQW035diY6/dYwh9pGsY0AnJBbSMTeYISwJJz/XqpL3BW7hcaMWU7uZHRcarYLldPVYu7cQaLOSVfNg60CwIunDXxGFxStB4dT1f82sKsdzDi7Dvp49FUrxWencho8fHbkYxjA3K3pItAjaunhgZnpFQAPORM9bcQQ==;31:MP87Up7UAaKN0k4GW3Uukwhf7/67PvoidAEJGt1H6zqPDZLT3tqMcDl4J1YEhgVCf3EHz2RQ8fEDyBrIhd6lUX8pnlQ9TRBZX696T5jPC0bbwKxpRKx9UPI2OPN8jIst4wI29nw6mvHZ06Lt+CYS3erlPitHutg/35MdybIrRecQQ6rb1k5Z6Hx+0eS8fsy/ARjK99KlRKgnbeJY9av3wWpVOyn0j/v4mp1Se28KZ78=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0130:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0130;20:H+AkZbbR5rcd1LyJsgOISFyG1PVbJWlst6UfNMNg5PR4IQuXTak1NFv0L2DHLZ6rjN2D4Fkxjud4/yNr/qof3UgnIOdlqYSlVl7DVw/v3DdKU1XsbGrnG7mK5GFGSkCcD1kLfakA7w/yXC70CRrQsI+s+WcCJPYRN9nf1LIu0dfgTrs/u5Rl0X2MItrX73JTrpGCmM8oAQ5UaDXJza7daIyoxuBY9ycT+SVvx8h4BuuvJaDsT8PtjevlRIPBGx98V8o6pXjWfGfBt3yjt34E97pKv4k23Gko9EkZ1QQqJTTu9z55qCsApnXGOUiYelwgl+B6XpYQ3nAm9w568PSHzL4QPMJsA2ij2RBPsuaL/IygtHBCmxQIa/vO1+YBoRrAXg/KjqsfuCe03+O0Rx2NLe8/4WZ8p90QBCfnmaUS1Aos9JAyn9WtHUPA5cJmoxUnlXq6dCrpk6GzztgFJLaui28K8qPKZuNW3KsFTrS7qdGvAl4fWsS5vmw6RFDLxrz+;4:AqQBzbK3u9QVDEMzUNBgmQXulpO4koX6VwX0IXqAeWz81hoETiMbQqhOul69FBqtjdeyNVaDm6nveywSJnCtYbwVVWN8sb0uFXY0I0tFhqxh1aHTVzg1drwfJStyp7rNROBkP4VR5g0hxBPP57ixNc4dXTiXfsNBZ8tyiVpd3ojElXomfFxtdqcFX0MU3wYUjRxkgY3i8vGIeOhup9RZnvy0FzAzzo+dE+fkFh3cEMihDYuyCwmhJ4gy3HofVOkwC1zwUPfvrqjpbNSkQ2R5MCiZcu3LR+fnzF+NcdCfdu9rjNpL+hoNh/J3QLlfbIdo
X-Microsoft-Antispam-PRVS: <BY2PR12MB0130108A7A8055775373EC3DF3AD0@BY2PR12MB0130.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BY2PR12MB0130;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0130;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39380400002)(39860400002)(396003)(366004)(189003)(199004)(16526019)(26005)(105586002)(53936002)(97736004)(86362001)(575784001)(7736002)(305945005)(3846002)(16586007)(8676002)(478600001)(6116002)(316002)(81166006)(956004)(2616005)(186003)(53416004)(50226002)(106356001)(8936002)(81156014)(36756003)(2906002)(5660300001)(50466002)(6666003)(52116002)(51416003)(76176011)(72206003)(7696005)(6486002)(48376002)(446003)(4326008)(386003)(25786009)(47776003)(11346002)(59450400001)(68736007)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0130;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR12MB0130;23:tElVU+n2GZ+JHzchkuOOVzhqDtiWq47KQpJ9GpcHh?=
 =?us-ascii?Q?w0dIG3vA359+IHH4Ms1Nbs5HQ5qep2t6q36yYVg48Uu4zUryKipKrQMjEEhQ?=
 =?us-ascii?Q?qRsNsc1nGWIyHBFxxasT+778zZdcd5oo42RMBdGbf0lJByXvylAYfg4Sr0qZ?=
 =?us-ascii?Q?4H3YLwk6qG4GjnbmqiPaC1as/LNlY+jxQkzhfQG2RwVMkU3oo6o2uQ3eh6Ry?=
 =?us-ascii?Q?lEsfOiLUhQsMQZnmT4q6C6HWCGCSgDkUTlAaCLUZyM5Yhm5XwqWFBkxhpErz?=
 =?us-ascii?Q?1vKr9CYzCea8kc8/ko/6xqJnIJMeN0clE7OG3iOPzhFaWZFrcW2zr1JI8GjE?=
 =?us-ascii?Q?ChU3E+7LMxx6A34sIO0Rrja3bnv58c468KCMPrauQfV99NIFj7B00jzPrq/3?=
 =?us-ascii?Q?Tl0KOi1GXq4EDuSwVcyh+u3xbMC/pSowtbwMDAuuLoO3dfr6mDvh8fg/eVBI?=
 =?us-ascii?Q?HULcSbiddkCDAHxW8++t/cDU1Ij14Xw3ANDcqAK9p7E+nGZBkJGq0jbmBcna?=
 =?us-ascii?Q?p00Ao+pOcXicEB70ywPGv4RaJFRgs+M3VnAPj7pRGh9JpBfBAjXOzc1uUah6?=
 =?us-ascii?Q?qhtoGoDEKaLEJD5qVKuHrYMAqDLBccZGhAJfXmEGxYG73gR3MX1Kif7JojBS?=
 =?us-ascii?Q?mSO6wleUWhsFTuisE0W6H2MtyNK3AU5LlY7g+2p0cqVr1MOkW2nTpz1/J12H?=
 =?us-ascii?Q?zPpDoY0nwS5FBq19JV55NP5wEYP7zJRvX267LtxsTRxQn8CPOxn8so0HsUFK?=
 =?us-ascii?Q?iWBicrFPg4gXy27NynIWpsbFb10PfQ2LH4BSWJgDiUkdDF+408RVP+EMsZj5?=
 =?us-ascii?Q?bC8dgqgXwzW9J0LRmQmEPcMufnZMJCBTJvodYckNw3wD06zXQ7AwJmuMMq3+?=
 =?us-ascii?Q?s2U8nlx0Q2u5uGh6y1wAUSirjBut7UnaSnPwMWlq7+KTaT9Qm7P/bqzWYZYj?=
 =?us-ascii?Q?MIz3su7oA8/EtjeCoII3akeZ9CRB5FW8oSbC5AOv3e8LXpv3KjOlqMdEn0Jl?=
 =?us-ascii?Q?yPzSNHu/cyvwXIG0b+LyJMpCbaHSHsZtkAIqjLWxhnplKmSY/fiWA4i90zg6?=
 =?us-ascii?Q?30dF8sEYRPkNerxOCk5fMYgw6Pia/D63ml4I56a7/OMIih6QJQUtiLxfq2XQ?=
 =?us-ascii?Q?efyHjcCBBUx5jO9AdaWLsOtdRfJVg2igNgQ+pArQ9pZZ0K6kQRzQvSQ0f6/B?=
 =?us-ascii?Q?DPZQx9hxrcZ3pc7vvdLRzLoy/+1iFh59z7P?=
X-Microsoft-Antispam-Message-Info: ziPvurdGKNIgOdIoXsFz+s44EXc2DYfSFKziPwAd+914zey6KlsMkwYXGxbfVZ5mS7/n+k89impw5TCpswLZpJRZGNx23r0rmIO5bdBcIuAy14Q4OE3wjM2da4KnA0D377KOoAnhSDTuAx1klQya7ZuqiMFx0PYYG4lYsrvdXUtZ46x4XmGHl/Y8r4dTtadP
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0130;6:E3LujZizWRa8Sq974Juaj+m5FZG0lAJvxZ2STktELHOGCV4Ypr0Wn6tErq54IBmHpEjQokbZxUnY090FwsymoV9CnAf0eU1S8SBcj0CeUuQ4ojVc82knI1j9+UeJDCVlbjcWYqJ1TNv5jQmFefNC4PN1J36S8kxwV438laISsYhjZibophtj3kYTHIYi1vXqW2ehdRe5TLPa+qqRENVTRDrXusRUmDkEAuDSMSD2WBqpisvhAL17K+PVAdTtLhdaF88Cpp/Od+LRGDc5yxVdipuMOTlz2ZkPox3yCgfEsko9gjaqKkyGfv5urJG1hAc5l0HzntG2kwKSrKZCDTxKBVotmvlDbxD/lDOre9s6FCtYNh49lBknV8t6MxDIimfluz1Bpk/9jBKN5bau8IS2kITtjsoptl0NOUdGN7o++Zcv9or9ZoGx3NUOrm8uSAaUxBANGKoKxKAItkLp4BviuQ==;5:ztHiqyU+qam4btYbJn/X06DaolKG1sZbtce7MKz/gew4WVCEYySr8P51g4A9oSKtFnxans64JSkQ7kH0n8r8Pqqh9+bbAonzufKp78woFxfRY1gWfGhOqB26n8ZRCB0nOLCW98alSnYzp3ZdzQ2Oe+GU/j8h+cV2Lxe1yXBdaic=;24:eEt/2qpixJatwLxy5U9eejr3m+C3alK2kVQ8Fv0obqOP3yCGmUgre/kP6uYPMyo81rwzyxBhGnaESyU2gALcU5EKTCjWsmklY8RUnJaeguQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0130;7:mFCM7+kGiavTZsJIfPBnG1sjOWFtlvqehguiC9K4knVFrFArYe0Ly1Gc8vMUJ/Ymrxa5huM757A7x6TIePJ4icg/Rn8tWooUieoSfq/Zp6JYLugn+8PEb/quW5FWV+tQUmiXdVZxOX8o2H1QC+ocLWkSFsd2DnciVBnqwokk3XruLm6xFQK4B+Akha1AIvnAz/bCbH32pbt+1sHGriCW+yYCfIAk+aJ8fEXsI8hI+qZmo90gbREp5lgCBdMX/j83;20:KSE6KVZjr+HgkgFlNvDtnKV5sn3Jlh44Z6RP1VlumQxRwUn0pPqfyOLMl/Im1pot/rIBfnT2Gv2aLp7atWbmqlSBk0iafGhpDDKsSMnDUEUh/KIHYCgIMI46oKavrvOYnYyuTNsCDD1qbVHGJNrRqnSmR/El2HEE7N/8K9Q67Yn4Xq9IPfWoO6j40e+TFnXk8riSUPnROpZkdWxIfiC42OvpBT5Tg8k+EBr6M72ASgDVP+ObeP+0sdRrQ75X7bFe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 08:06:11.2186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72105457-4211-4968-3432-08d592f07070
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0130
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation does not communicate whether it can successfully
detect CPUID Fn0x0000000B information. Therefore, modify the function
to return success or error codes. This will be used by subsequent patches.

Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/include/asm/processor.h | 2 +-
 arch/x86/kernel/cpu/topology.c   | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index b0ccd48..2a5d5ed 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -193,7 +193,7 @@ extern u32 get_scattered_cpuid_leaf(unsigned int level,
 extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
 extern void init_amd_cacheinfo(struct cpuinfo_x86 *c);
 
-extern void detect_extended_topology(struct cpuinfo_x86 *c);
+extern int detect_extended_topology(struct cpuinfo_x86 *c);
 extern void detect_ht(struct cpuinfo_x86 *c);
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index b099024..81c0afb 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -27,7 +27,7 @@
  * exists, use it for populating initial_apicid and cpu topology
  * detection.
  */
-void detect_extended_topology(struct cpuinfo_x86 *c)
+int detect_extended_topology(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_SMP
 	unsigned int eax, ebx, ecx, edx, sub_index;
@@ -36,7 +36,7 @@ void detect_extended_topology(struct cpuinfo_x86 *c)
 	static bool printed;
 
 	if (c->cpuid_level < 0xb)
-		return;
+		return -1;
 
 	cpuid_count(0xb, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
 
@@ -44,7 +44,7 @@ void detect_extended_topology(struct cpuinfo_x86 *c)
 	 * check if the cpuid leaf 0xb is actually implemented.
 	 */
 	if (ebx == 0 || (LEAFB_SUBTYPE(ecx) != SMT_TYPE))
-		return;
+		return -1;
 
 	set_cpu_cap(c, X86_FEATURE_XTOPOLOGY);
 
@@ -95,6 +95,6 @@ void detect_extended_topology(struct cpuinfo_x86 *c)
 			       c->cpu_core_id);
 		printed = 1;
 	}
-	return;
 #endif
+	return 0;
 }
-- 
2.7.4
