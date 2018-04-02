Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756615AbeDBT51 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 15:57:27 -0400
Received: from mail-by2nam03on0040.outbound.protection.outlook.com ([104.47.42.40]:6064
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754686AbeDBT5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 15:57:24 -0400
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-edac@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        bp@suse.de, tony.luck@intel.com, x86@kernel.org
Subject: [PATCH] x86/MCE, EDAC/mce_amd: Save all aux registers on SMCA systems
Date: Mon,  2 Apr 2018 14:57:07 -0500
Message-Id: <20180402195707.42875-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CY4PR13CA0082.namprd13.prod.outlook.com (10.171.162.20) To
 BN6PR12MB1905.namprd12.prod.outlook.com (10.175.102.11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 896aa6aa-bc0d-4274-cf5d-08d598d3f2d0
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1905;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;3:TyKRqvyY2Nkx5V7S4I3OkhEGVMH4rps7ibT+VFRimlW5kyEaY6sE/JlhYYSTdL8CKsKpojRcuxjSr1Kkrq9PliGs3wuHluobUsCPs015550uILdeHZvf7MVmUz8I+V7jBg1LHTSzOv1Hjzdk0NAD4xVBpEgek33uHUxUsbaqZ/uQdW3tpJAzIdv9mocPbHskwz+grBdALoajHrDxLBQYf/3Kf8hvwhNauIKRn0xhW9Y90IVYOpEiUQJksdmlURGX;25:2A3uN6dGBMFpvLUZs78bNOdyoolQqJVb+Y02uMZRSD0uuBT3fxGyFG9OyUDEtIaYG3j1XlE7KgJRMEy01PvJ1tu89Tf+ZZ9exsbcMHR0k2ZCETDxJ7zSn6tMuyU9Ynm8SsZ43ssTpLtCIRKH71fjNnzrGXjRZqwznGY7uJcrPpIBaU13MQUhRD6xZ4OYe22ijb3DJeRfS2VvdjRRNFKb/cAUfOd2ZeRQvy9ok3Vx174UvjsEx+orK8wbf6vSRYUpMPx5JCikqe30vdg8LmlfjwLPyFE8U+eXsFhEq/YzHhiaYSpophTfVC6GnoyUJe8pX0cZFvdmHuk8cNOqkp6oGQ==;31:mDQ9N7gf5DFFKpxa4Xu1iIpeDRt/6ApVt/bDIuVHwocs7IaHqEkkS5qImONSMHFMOQUh2B0Ouo1yFh5Jq9djJXfTlhG2pEuaySFKmQbszD2iHJ2qRgZoQNf7gxsJ409Z+MByVpy81nbyMe9pid0qvdvkTklx4yxfJfLgF2y84UGLOTpMbn5FYFDAoKyx1V4GbzLp2WQGcsT42vNkZ9ZzNw4Jg7MtrRa3xum9dqlte+0=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1905:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;20:vaTyeAuJ1cjXgzYQ7pBhFUyp1WAsDQrk5vzYeeKzCgZmo6qyNdf0hK+/hk8hzc2RkfivAq0/3Bbw4SxGyhc1wvv2+MGB0PJ7k+tf5aHVoH7ZwYw2naOPW95bppviyYk9smR4UkZZpIlxqKwej3vFNQ13928ATlGAfhKAIYW5RMsp5dxseEGJyLgG3eTGwEen9Ogls80D40n61dhOFEObZLkq+G9eUHFB0Z/WpzdaQfUgRb4lc52mOSV/BY8cRs/qodNfGixHziPHI+yZjZAs732lVezyUYQ5vCCw/JJKxvOeMZvmN4/D0oMtFkaQXUSgMb8/HSh0GxW5KbsPzUvknkaeQTp/W1TszS1PKkHt5QKp2P6NAjSzrczHatSAivQAa8w2y8xOcV0n8x6EJL6y92/owiHIaNa+2UKmWtJTst0eUTiokFauydOri3Lj5YdmFjT1Xf7iJIx/uXqIb1tGcKluIsxC9FRH9Gy/OeK/rsTTUMOM+kTCp165YtbCF0Fs;4:NBAQPCRTsAr5RjbuDTXw6qUvLmeHMw6THmtY6o2Lc6qFwrwp/Ga98U/ulIDUD1C7O9QLy6q5KVWAP+trJXG9TMunrcsfnnT6pfvLfHXfDQe0zCuBxYLYPSoQJtTjMHiEHXf2/+pP5BUHmzfPIHvIb8JkuJeQfXZb3tX3DLpxxYko0i1+ibtm5wST5UVj5UI0LQMPbY1StWSTfVQH5xkgy7bfsQyBtGEeb2VoMiSiS5G3xKBkUF1jOjnEmrAua68e33FTK6L/bgTp2Dl5DwVT9VTiPGnhd0HLpDcZnExSuKIvJ49/cW5dfACZEuHlxs9GASqme/suXbmXPNOJ4z3Bud/AxpXR0Ko+rAvd0EywRTI=
X-Microsoft-Antispam-PRVS: <BN6PR12MB190542F759AE623B54524E22F8A60@BN6PR12MB1905.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR12MB1905;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1905;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(366004)(376002)(39860400002)(396003)(189003)(199004)(6916009)(6116002)(48376002)(4326008)(36756003)(68736007)(52116002)(50466002)(2361001)(6306002)(66066001)(1076002)(53936002)(386003)(2616005)(51416003)(47776003)(956004)(478600001)(7696005)(16586007)(305945005)(486005)(486005)(476003)(72206003)(53416004)(186003)(7736002)(3846002)(966005)(59450400001)(316002)(6486002)(26005)(25786009)(6666003)(97736004)(2351001)(105586002)(86362001)(575784001)(50226002)(8936002)(16526019)(81156014)(2906002)(5660300001)(8676002)(106356001)(1857600001)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1905;H:yaz-diesel.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1905;23:fOMpF02Tpf4ZSAlmfh1sNkORdbnFm379sC5OdC4oQ?=
 =?us-ascii?Q?S3LtjATFWHKkHKyf1ellTVGm1oYKkpTmYTgNvrdABPr1Z8HcyuXwFp/KgkRt?=
 =?us-ascii?Q?n4mZdoiojOURYWBhbymzfbKincUjtl4uHsQS/46iWMDnSbH57obLaK2Bfzoy?=
 =?us-ascii?Q?Jxc5MGkMcRQLJmNemTFYLd5VQnRhJuz5b9MEyMb0DqKJIHI5jBlwysuWxP2P?=
 =?us-ascii?Q?54kNkEItD1IIyNo/Ifa/L08Ef8q0n5I3VhvE1DCZV7x5yuITUTA//eQqetQ0?=
 =?us-ascii?Q?Y2HAd7FWO9tk0qYTGEq+5RB/nvlH/DFfsk/F1gQkV8jXD2aFfFUNeAekGbhY?=
 =?us-ascii?Q?dM+ys3Mrzyll/9WD1lTlwMj0FH20nsVHu5nGPRieVQFDU0YwLp3hW8HCH+Jo?=
 =?us-ascii?Q?nXfSuBwvBR9GwTdGty9PyzQOnHUvfAW+wb3lfGkvBfbEindWb0gr94rmgtfp?=
 =?us-ascii?Q?hp+9po42o1plq3XmPaKfjbcC4Cv6vznHo1m8d409LuKHyEN92zq3vQBj6vdL?=
 =?us-ascii?Q?jjDFPyeuUM6XLXJLcxPtwhqMqisdZ5AfPAP4jgugo52eDVNLueUyOKnLMpxK?=
 =?us-ascii?Q?sV93umVCNmx1do0SAZKHq8cWOQ1gSBKSmeVUGMiupVZWN6nV84Uge1H1MOOz?=
 =?us-ascii?Q?ulOWSdsloVQjxt6VrD35haOJj45dTLQB++ySxLew+u1jUhxohyzOQYS9LL/y?=
 =?us-ascii?Q?TvtGvUQzxqsCbpRX14eOFFFl0PVoiEhxcqRN8JtQ8cf/2HfZUZILCkKxZRP5?=
 =?us-ascii?Q?e0f3hXOl5kWoCG1m8JgMnSAFWlPRLORYW14H5kzmweyDkp667GflySBTEYh0?=
 =?us-ascii?Q?rOHOMgFEF3vJ6cTnG67ebsJDlFZsq+zQ2pkTF+9ThYU3sxD8npR1b0s+Q728?=
 =?us-ascii?Q?Yxixn67IZik4owFlWXnCQIBhtMNDsgCVqp+fUOHAYvf6Lg8dKRasWs66VJKS?=
 =?us-ascii?Q?hFSHfIidVsgpNj8K/8GKwYoaFsB6ptPpoRS2j8VVpuh0eWAdiFKSEP8JVCp8?=
 =?us-ascii?Q?gek4MwxoHH678Lw58b6dQWdqs3lzKgzLEudjB1Hbj7LV9n9A168VInQSYIQT?=
 =?us-ascii?Q?psECCRixBnbCqtTduQ2dSbdZpwqmpnsjb3VQsizpDRpozTGQ+BiYZx6c7zXU?=
 =?us-ascii?Q?AS3ma5k1lDY/MEWokhS2FnMemlCqvAeQL0xi2GK2GQaeIWtXduV/DutRQkZR?=
 =?us-ascii?Q?7ZsgxZPA1RRP3DiVRyuQkfPotF8SwByAx7E3vTunwBs3l21HzOT7A0VxECB1?=
 =?us-ascii?Q?vd6hyvuFb9X1nB0vBVqJ4TwXTfgHFCXF7ll/zr3S+DANGFPUtgrSh8Maik5V?=
 =?us-ascii?Q?LT7jnuRkwoH2M3K8htw88XtafuYO0hFLY/VS3frbNgc?=
X-Microsoft-Antispam-Message-Info: owuWgUPpAo5gew2pE1TKNdJHoy6qmSbcRVzNa5/JCsKAIHQx05KslF+gH8TyZ+NCcRge6UnNkoQcr+wcf9+bZdkYeOywI2vqtpnonW4uNvtuyHe/Hsgdsg85mgsvZDAqOFWQntrkfVJfKfXtMOfRF4YWCl6GoERj/vdSNzxum0l8V5/ichqd7GDmX2X69o9o
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;6:YwC4l4PJ4tEmC/YyFHWROU//T352kzlDibZjzO7fSsgv4DSn8w1R703REoAdp8e3xLIHBEZDa0wzrNELn4auG/yt9Lzr142wSzYtqf3sMnAEdG0ZWi3X9BBAAn/xh+E38KTMV/jYRuYa+LqFZH3qCMFFlOykpiPRsiHhciXEZiH42Y1TyZ+j7zeiJecWUL6I7nBfSZ6TzCp6C/Zt+kh+dYh4OA6RONtQ/mx7NIHilB3ll1idNIl7TyjEbQdKQo9YhaeEpLEp4C2NW53jCp9J6aYhtWt8OQWa36Sx1NzJ76RtuTNBbrI9gm9cdQUIweZizUTnEFznegw+47tIPuWhYvtGJqMFsnaFciqdzJHLL4lhSeF0tbf8vft5/NsCKdoS49L56Iml3jsYa6VR3JKlSjjlnfvG+phQcD6gB1ZNcmX571+9JwS9JdkO13lMrRb96UAZBfak9zzw/bTyiAP1wQ==;5:pKhR9sp41PtoNUdwIm/v67EWRTUOgys0ouYNc10ei/BJGkPhv0pGjgtn0eXxFjHjmHyUk6+ZP1DS5716o7sb/TmW219wNFmhCPA9Qi05Wx3V4CiyuLIcf6re+HtOuGGP/QZ49YJXLJSjxVkAuNun3/GnBU/aMB7v7q7g7B4B2Bs=;24:2PfoneF6p6zDwPUgSMswA315N5433WxDRDngiFMxmE9WiKAveN5CF4aeX6CowXQqLM0lng3QWFcohhnIb/zgOD1GA1l22LO9IviRxkVa8CE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;7:7MYU5EwDcgx5XH3EP5VZbDWRh5gbUz+N0an+lQmbXEp1ci8SZTYAkhcFP2btFjZ70EJ2NJcrRiGCyKDWdKUMwjirXz+0b7zAvsNJ5et3WF1YP0bgymCc6sn6Wi4/qnyZfzCUwVQN0PdQfvAYL7XXTQtzSis4M7xcYxd05aLE890Q7smVxlp2IHhhWMrs1iTrWVtyqCJkSyIN4/4L3KGgaeJOMnNfa6U+bV2x1diVbJjWcHoDQydPgfE3EcfbIfnt;20:2erxm2ykA2GyC/MRIJ7gIwEobgr6GW5NxE0EtsLOLqs8bBCPUxxwDkzbVh/9m7t7A2zJ2oC6HqNoFA1yWZozMs/90LLzoKpor8VXOTZgSrtRAYl+iTTgYTIR6Xp0JX8cknckXpVky6zAZtHx5O08zcqcycy8mkecEwBCFg9YBrMd8S0WUwHrBcmFdm4fnJ/0yfTM1OxK0Z3MHy6N2B67utNh2MAmsoXHLvmv6EHiejtMab4Em+9kjbeyk+bnydVD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 19:57:21.3678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 896aa6aa-bc0d-4274-cf5d-08d598d3f2d0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1905
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The Intel SDM and AMD APM both state that the auxiliary MCA registers
should be read if their respective valid bits are set in MCA_STATUS.

The Processor Programming Reference for AMD Fam17h systems has a new
recommendation that the auxiliary registers should be saved
unconditionally. This recommendation can be retroactively applied to
older AMD systems. However, we only need to apply this to SMCA systems
to avoid modifying behavior on older systems.

Define a separate function to save all auxiliary registers on SMCA
systems. Call this function from both the MCE handlers and the AMD LVT
interrupt handlers so that we don't duplicate code.

Print all auxiliary registers in EDAC/mce_amd. Don't restrict this to
SMCA systems in order to save a conditional and keep the format similar
between SMCA and non-SMCA systems.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Links:
https://lkml.kernel.org/r/20180326191526.64314-1-Yazen.Ghannam@amd.com
https://lkml.kernel.org/r/20180326191526.64314-2-Yazen.Ghannam@amd.com

 arch/x86/kernel/cpu/mcheck/mce-internal.h |  6 +++
 arch/x86/kernel/cpu/mcheck/mce.c          | 20 ++--------
 arch/x86/kernel/cpu/mcheck/mce_amd.c      | 65 +++++++++++++++++++++----------
 drivers/edac/mce_amd.c                    | 12 ++----
 4 files changed, 57 insertions(+), 46 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce-internal.h b/arch/x86/kernel/cpu/mcheck/mce-internal.h
index 374d1aa66952..67a2c7c095ca 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-internal.h
+++ b/arch/x86/kernel/cpu/mcheck/mce-internal.h
@@ -59,6 +59,12 @@ static inline void mce_intel_hcpu_update(unsigned long cpu) { }
 static inline void cmci_disable_bank(int bank) { }
 #endif
 
+#ifdef CONFIG_X86_MCE_AMD
+bool smca_read_aux(struct mce *m, int bank);
+#else
+static inline bool smca_read_aux(struct mce *m, int bank) { return false; }
+#endif
+
 void mce_timer_kick(unsigned long interval);
 
 #ifdef CONFIG_ACPI_APEI
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 42cf2880d0ed..6be63e9e067d 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -639,6 +639,9 @@ static struct notifier_block mce_default_nb = {
  */
 static void mce_read_aux(struct mce *m, int i)
 {
+	if (smca_read_aux(m, i))
+		return;
+
 	if (m->status & MCI_STATUS_MISCV)
 		m->misc = mce_rdmsrl(msr_ops.misc(i));
 
@@ -653,23 +656,6 @@ static void mce_read_aux(struct mce *m, int i)
 			m->addr >>= shift;
 			m->addr <<= shift;
 		}
-
-		/*
-		 * Extract [55:<lsb>] where lsb is the least significant
-		 * *valid* bit of the address bits.
-		 */
-		if (mce_flags.smca) {
-			u8 lsb = (m->addr >> 56) & 0x3f;
-
-			m->addr &= GENMASK_ULL(55, lsb);
-		}
-	}
-
-	if (mce_flags.smca) {
-		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
-
-		if (m->status & MCI_STATUS_SYNDV)
-			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index f7666eef4a87..b00d5fff1848 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -244,6 +244,47 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 	}
 }
 
+
+static bool _smca_read_aux(struct mce *m, int bank, bool read_addr)
+{
+	if (!mce_flags.smca)
+		return false;
+
+	rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
+	rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
+
+	/*
+	 * We should already have a value if we're coming from the Threshold LVT
+	 * interrupt handler. Otherwise, read it now.
+	 */
+	if (!m->misc)
+		rdmsrl(msr_ops.misc(bank), m->misc);
+
+	/*
+	 * Read MCA_ADDR if we don't have it already. We should already have it
+	 * if we're coming from the interrupt handlers.
+	 */
+	if (read_addr)
+		rdmsrl(msr_ops.addr(bank), m->addr);
+
+	/*
+	 * Extract [55:<lsb>] where lsb is the least significant
+	 * *valid* bit of the address bits.
+	 */
+	if (m->addr) {
+		u8 lsb = (m->addr >> 56) & 0x3f;
+
+		m->addr &= GENMASK_ULL(55, lsb);
+	}
+
+	return true;
+}
+
+bool smca_read_aux(struct mce *m, int bank)
+{
+	return _smca_read_aux(m, bank, true);
+}
+
 struct thresh_restart {
 	struct threshold_block	*b;
 	int			reset;
@@ -799,30 +840,12 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 	mce_setup(&m);
 
 	m.status = status;
+	m.addr	 = addr;
 	m.misc   = misc;
 	m.bank   = bank;
 	m.tsc	 = rdtsc();
 
-	if (m.status & MCI_STATUS_ADDRV) {
-		m.addr = addr;
-
-		/*
-		 * Extract [55:<lsb>] where lsb is the least significant
-		 * *valid* bit of the address bits.
-		 */
-		if (mce_flags.smca) {
-			u8 lsb = (m.addr >> 56) & 0x3f;
-
-			m.addr &= GENMASK_ULL(55, lsb);
-		}
-	}
-
-	if (mce_flags.smca) {
-		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m.ipid);
-
-		if (m.status & MCI_STATUS_SYNDV)
-			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m.synd);
-	}
+	_smca_read_aux(&m, bank, false);
 
 	mce_log(&m);
 }
@@ -849,7 +872,7 @@ _log_error_bank(unsigned int bank, u32 msr_stat, u32 msr_addr, u64 misc)
 	if (!(status & MCI_STATUS_VAL))
 		return false;
 
-	if (status & MCI_STATUS_ADDRV)
+	if ((status & MCI_STATUS_ADDRV) || mce_flags.smca)
 		rdmsrl(msr_addr, addr);
 
 	__log_error(bank, status, addr, misc);
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 2ab4d61ee47e..d7badf80f13f 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -990,16 +990,12 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 
 	pr_cont("]: 0x%016llx\n", m->status);
 
-	if (m->status & MCI_STATUS_ADDRV)
-		pr_emerg(HW_ERR "Error Addr: 0x%016llx\n", m->addr);
+	pr_emerg(HW_ERR "Error Addr: 0x%016llx, Misc: 0x%016llx\n",
+		 m->addr, m->misc);
 
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
-		pr_emerg(HW_ERR "IPID: 0x%016llx", m->ipid);
-
-		if (m->status & MCI_STATUS_SYNDV)
-			pr_cont(", Syndrome: 0x%016llx", m->synd);
-
-		pr_cont("\n");
+		pr_emerg(HW_ERR "IPID: 0x%016llx, Syndrome: 0x%016llx\n",
+			 m->ipid, m->synd);
 
 		decode_smca_error(m);
 		goto err_code;
-- 
2.14.1
