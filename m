Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbeDBPSe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 11:18:34 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39229 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752248AbeDBPS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 11:18:28 -0400
X-Google-Smtp-Source: AIpwx4+K61GjpkaMVsCckaKaDP2JrnTqbKVAzZnvfKQMrDDzcD/cgRfrwKSpVtOAsVFVRO9ZhDZBkg==
From: Khan M Rashedun-Naby <naby88@gmail.com>
To: tglx@linutronix.de
Cc: mingo@redhat.com, hpa@zytor.com, x86@kernel.org, bp@suse.de,
        thomas.lendacky@amd.com, jgross@suse.com, r.marek@assembler.cz,
        qianyue.zj@alibaba-inc.com, linux-kernel@vger.kernel.org,
        Khan M Rashedun-Naby <naby88@gmail.com>
Subject: [PATCH] Fixed some style warnings and errors
Date: Mon,  2 Apr 2018 21:17:43 +0600
Message-Id: <1522682263-11935-1-git-send-email-naby88@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Khan M Rashedun-Naby <naby88@gmail.com>
---
 arch/x86/kernel/cpu/amd.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f0e6456..1a6e45e 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -32,7 +32,7 @@ static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum);
  */
 static u32 nodes_per_socket = 1;
 
-static inline int rdmsrl_amd_safe(unsigned msr, unsigned long long *p)
+static inline int rdmsrl_amd_safe(unsigned int msr, unsigned long long *p)
 {
 	u32 gprs[8] = { 0 };
 	int err;
@@ -50,7 +50,7 @@ static inline int rdmsrl_amd_safe(unsigned msr, unsigned long long *p)
 	return err;
 }
 
-static inline int wrmsrl_amd_safe(unsigned msr, unsigned long long val)
+static inline int wrmsrl_amd_safe(unsigned int msr, unsigned long long val)
 {
 	u32 gprs[8] = { 0 };
 
@@ -157,6 +157,7 @@ static void init_amd_k6(struct cpuinfo_x86 *c)
 		rdmsr(MSR_K6_WHCR, l, h);
 		if ((l&0x0000FFFF) == 0) {
 			unsigned long flags;
+
 			l = (1<<0)|((mbytes/4)<<1);
 			local_irq_save(flags);
 			wbinvd();
@@ -178,6 +179,7 @@ static void init_amd_k6(struct cpuinfo_x86 *c)
 		rdmsr(MSR_K6_WHCR, l, h);
 		if ((l&0xFFFF0000) == 0) {
 			unsigned long flags;
+
 			l = ((mbytes>>2)<<22)|(1<<16);
 			local_irq_save(flags);
 			wbinvd();
@@ -268,8 +270,7 @@ static void init_amd_k7(struct cpuinfo_x86 *c)
 	 * Don't taint if we are running SMP kernel on a single non-MP
 	 * approved Athlon
 	 */
-	WARN_ONCE(1, "WARNING: This combination of AMD"
-		" processors is not suitable for SMP.\n");
+	WARN_ONCE(1, "WARNING: This combination of AMD processors is not suitable for SMP.\n");
 	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_NOW_UNRELIABLE);
 #endif
 }
@@ -384,7 +385,7 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 static void amd_detect_cmp(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_SMP
-	unsigned bits;
+	unsigned int bits;
 	int cpu = smp_processor_id();
 
 	bits = c->x86_coreid_bits;
@@ -419,7 +420,7 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 #ifdef CONFIG_NUMA
 	int cpu = smp_processor_id();
 	int node;
-	unsigned apicid = c->apicid;
+	unsigned int apicid = c->apicid;
 
 	node = numa_cpu_node(cpu);
 	if (node == NUMA_NO_NODE)
@@ -468,7 +469,7 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 static void early_init_amd_mc(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_SMP
-	unsigned bits, ecx;
+	unsigned int bits, ecx;
 
 	/* Multi core CPU? */
 	if (c->extended_cpuid_level < 0x80000008)
@@ -820,14 +821,22 @@ static void init_amd(struct cpuinfo_x86 *c)
 		clear_cpu_cap(c, X86_FEATURE_MCE);
 
 	switch (c->x86) {
-	case 4:    init_amd_k5(c); break;
-	case 5:    init_amd_k6(c); break;
-	case 6:	   init_amd_k7(c); break;
-	case 0xf:  init_amd_k8(c); break;
-	case 0x10: init_amd_gh(c); break;
-	case 0x12: init_amd_ln(c); break;
-	case 0x15: init_amd_bd(c); break;
-	case 0x17: init_amd_zn(c); break;
+	case 4:
+	  init_amd_k5(c); break;
+	case 5:
+	  init_amd_k6(c); break;
+	case 6:
+	  init_amd_k7(c); break;
+	case 0xf:
+	  init_amd_k8(c); break;
+	case 0x10:
+	  init_amd_gh(c); break;
+	case 0x12:
+	  init_amd_ln(c); break;
+	case 0x15:
+	  init_amd_bd(c); break;
+	case 0x17:
+	  init_amd_zn(c); break;
 	}
 
 	/*
@@ -970,17 +979,14 @@ static const struct cpu_dev amd_cpu_dev = {
 	.c_vendor	= "AMD",
 	.c_ident	= { "AuthenticAMD" },
 #ifdef CONFIG_X86_32
-	.legacy_models = {
-		{ .family = 4, .model_names =
-		  {
+	.legacy_models = { { .family = 4, .model_names = {
 			  [3] = "486 DX/2",
 			  [7] = "486 DX/2-WB",
 			  [8] = "486 DX/4",
 			  [9] = "486 DX/4-WB",
 			  [14] = "Am5x86-WT",
 			  [15] = "Am5x86-WB"
-		  }
-		},
+		  } },
 	},
 	.legacy_cache_size = amd_size_cache,
 #endif
-- 
2.7.4
