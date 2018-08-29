Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38917C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B1520847
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B1520847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbeH2QnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:43:03 -0400
Received: from smtp17.cstnet.cn ([159.226.251.17]:51056 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727684AbeH2QnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:43:03 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-09 (Coremail) with SMTP id swCowADXt+yFlYZb36z_BA--.6S2;
        Wed, 29 Aug 2018 20:46:02 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com, trenn@suse.com, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pm@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH v5 16/16] tools/cpupower: enable Hygon support to cpupower tool
Date:   Wed, 29 Aug 2018 20:45:56 +0800
Message-Id: <30d0bae54fd0255a5a51d5578d69bcbaf915dcae.1535459013.git.puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1535459012.git.puwen@hygon.cn>
References: <cover.1535459012.git.puwen@hygon.cn>
X-CM-TRANSID: swCowADXt+yFlYZb36z_BA--.6S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww4DXFyrJr1kuF15ZF1UZFb_yoWxJryrp3
        90krZ8J3y8tr98X3Wktr1UWa15CF4kurZFqwn7Gw1rAF17Zr4vqr4DJFy5Kr9rXF97Ja1F
        va93Kw1UXan7GaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
        7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv
        67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43
        ZEXa7VUbKLvtUUUUU==
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tool cpupower is useful to get CPU frequency information and monitor
power stats on Hygon platforms. So enable platform support to cpupower
for Hygon Dhyana Family 0x18 processors by checking vendor ID & family
and vendor string by using the code path of AMD family 0x17.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 tools/power/cpupower/utils/cpufreq-info.c               | 6 ++++--
 tools/power/cpupower/utils/helpers/amd.c                | 6 ++++--
 tools/power/cpupower/utils/helpers/cpuid.c              | 8 +++++---
 tools/power/cpupower/utils/helpers/helpers.h            | 2 +-
 tools/power/cpupower/utils/helpers/misc.c               | 3 ++-
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c | 3 ++-
 6 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index df43cd4..56e54ea 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -170,6 +170,7 @@ static int get_boost_mode(unsigned int cpu)
 	unsigned long pstates[MAX_HW_PSTATES] = {0,};
 
 	if (cpupower_cpu_info.vendor != X86_VENDOR_AMD &&
+	    cpupower_cpu_info.vendor != X86_VENDOR_HYGON &&
 	    cpupower_cpu_info.vendor != X86_VENDOR_INTEL)
 		return 0;
 
@@ -190,8 +191,9 @@ static int get_boost_mode(unsigned int cpu)
 	printf(_("    Supported: %s\n"), support ? _("yes") : _("no"));
 	printf(_("    Active: %s\n"), active ? _("yes") : _("no"));
 
-	if (cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
-	    cpupower_cpu_info.family >= 0x10) {
+	if ((cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
+	     cpupower_cpu_info.family >= 0x10) ||
+	     cpupower_cpu_info.vendor == X86_VENDOR_HYGON) {
 		ret = decode_pstates(cpu, cpupower_cpu_info.family, b_states,
 				     pstates, &pstate_no);
 		if (ret)
diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index bb41cdd..dbce56c 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -45,7 +45,8 @@ static int get_did(int family, union msr_pstate pstate)
 
 	if (family == 0x12)
 		t = pstate.val & 0xf;
-	else if (family == 0x17)
+	else if (family == 0x17 ||
+		(family == 0x18 && cpupower_cpu_info.vendor == X86_VENDOR_HYGON))
 		t = pstate.fam17h_bits.did;
 	else
 		t = pstate.bits.did;
@@ -59,7 +60,8 @@ static int get_cof(int family, union msr_pstate pstate)
 	int fid, did, cof;
 
 	did = get_did(family, pstate);
-	if (family == 0x17) {
+	if (family == 0x17 ||
+	   (family == 0x18 && cpupower_cpu_info.vendor == X86_VENDOR_HYGON)) {
 		fid = pstate.fam17h_bits.fid;
 		cof = 200 * fid / did;
 	} else {
diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
index 732b0b4..5cc39d4 100644
--- a/tools/power/cpupower/utils/helpers/cpuid.c
+++ b/tools/power/cpupower/utils/helpers/cpuid.c
@@ -8,7 +8,7 @@
 #include "helpers/helpers.h"
 
 static const char *cpu_vendor_table[X86_VENDOR_MAX] = {
-	"Unknown", "GenuineIntel", "AuthenticAMD",
+	"Unknown", "GenuineIntel", "AuthenticAMD", "HygonGenuine",
 };
 
 #if defined(__i386__) || defined(__x86_64__)
@@ -109,6 +109,7 @@ int get_cpu_info(struct cpupower_cpu_info *cpu_info)
 	fclose(fp);
 	/* Get some useful CPU capabilities from cpuid */
 	if (cpu_info->vendor != X86_VENDOR_AMD &&
+	    cpu_info->vendor != X86_VENDOR_HYGON &&
 	    cpu_info->vendor != X86_VENDOR_INTEL)
 		return ret;
 
@@ -124,8 +125,9 @@ int get_cpu_info(struct cpupower_cpu_info *cpu_info)
 	if (cpuid_level >= 6 && (cpuid_ecx(6) & 0x1))
 		cpu_info->caps |= CPUPOWER_CAP_APERF;
 
-	/* AMD Boost state enable/disable register */
-	if (cpu_info->vendor == X86_VENDOR_AMD) {
+	/* AMD or Hygon Boost state enable/disable register */
+	if (cpu_info->vendor == X86_VENDOR_AMD ||
+	    cpu_info->vendor == X86_VENDOR_HYGON) {
 		if (ext_cpuid_level >= 0x80000007 &&
 		    (cpuid_edx(0x80000007) & (1 << 9)))
 			cpu_info->caps |= CPUPOWER_CAP_AMD_CBP;
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index 41da392..9021396 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -61,7 +61,7 @@ extern int be_verbose;
 
 /* cpuid and cpuinfo helpers  **************************/
 enum cpupower_cpu_vendor {X86_VENDOR_UNKNOWN = 0, X86_VENDOR_INTEL,
-			  X86_VENDOR_AMD, X86_VENDOR_MAX};
+			  X86_VENDOR_AMD, X86_VENDOR_HYGON, X86_VENDOR_MAX};
 
 #define CPUPOWER_CAP_INV_TSC		0x00000001
 #define CPUPOWER_CAP_APERF		0x00000002
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 80fdf55..0be93ee 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -26,7 +26,8 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
 		 * has Hardware determined variable increments instead.
 		 */
 
-		if (cpu_info.family == 0x17) {
+		if (cpu_info.family == 0x17 ||
+		   (cpu_info.family == 0x18 && cpu_info.vendor == X86_VENDOR_HYGON)) {
 			if (!read_msr(cpu, MSR_AMD_HWCR, &val)) {
 				if (!(val & CPUPOWER_AMD_CPBDIS))
 					*active = 1;
diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
index d7c2a6d..f2a7e9c 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -241,7 +241,8 @@ static int init_maxfreq_mode(void)
 	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_INV_TSC))
 		goto use_sysfs;
 
-	if (cpupower_cpu_info.vendor == X86_VENDOR_AMD) {
+	if (cpupower_cpu_info.vendor == X86_VENDOR_AMD ||
+	    cpupower_cpu_info.vendor == X86_VENDOR_HYGON) {
 		/* MSR_AMD_HWCR tells us whether TSC runs at P0/mperf
 		 * freq.
 		 * A test whether hwcr is accessable/available would be:
-- 
2.7.4

