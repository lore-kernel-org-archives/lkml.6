Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1qqJAIfVG1s6SQAAmS7hNA
	; Sat, 09 Jun 2018 13:26:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C25BA608B8; Sat,  9 Jun 2018 13:26:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 39862607BB;
	Sat,  9 Jun 2018 13:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 39862607BB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753301AbeFIN0a (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 09:26:30 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:39232 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753171AbeFIN01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 09:26:27 -0400
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Jun 2018 09:26:25 EDT
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-01 (Coremail) with SMTP id qwCowAB3V5g11RtbSWFEBA--.860S2;
        Sat, 09 Jun 2018 21:26:04 +0800 (CST)
From: Pu Wen <puwen@hygon.cn>
To: trenn@suse.com, shuah@kernel.org, tglx@linutronix.de,
        zhangpanyong@hygon.cn
Cc: bp@alien8.de, mchehab@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, lenb@kernel.org, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com,
        peterz@infradead.org, tony.luck@intel.com, pbonzini@redhat.com,
        rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-x86_64@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH 11/11] tools/cpupower: Add support for Hygon's Dhyana Family 18h processor
Date: Sat,  9 Jun 2018 21:25:00 +0800
Message-Id: <1528550700-28580-1-git-send-email-puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowAB3V5g11RtbSWFEBA--.860S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF15Zr4fAr4fGFWkAw1kXwb_yoWrZry5p3
        9YkrZ8t3y8tw1DGa4ktr1UWa15Gr4kZ3y2g3s7Cw1rAF4UZF4vqr4DtFy5Kr9rXas7JF4F
        vas5Kw10qanrGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
        xVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv
        67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43
        ZEXa7VU1s2-UUUUUU==
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the cpupower tool support to Hygon Family 18h CPU:
- Add "HygonGenuine" in cpu_vendor_table[] to match Hygon vendor ID.
- Add definition X86_VENDOR_HYGON in enum cpupower_cpu_vendor.
- Add Hygon Family 18h support in get_boost_mode(), get_cpu_info(),
  init_maxfreq_mode().

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 tools/power/cpupower/utils/cpufreq-info.c               | 6 ++++--
 tools/power/cpupower/utils/helpers/cpuid.c              | 6 ++++--
 tools/power/cpupower/utils/helpers/helpers.h            | 2 +-
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c | 3 ++-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index df43cd4..75c2140 100644
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
+	if ((cpupower_cpu_info.vendor == X86_VENDOR_AMD ||
+	     cpupower_cpu_info.vendor == X86_VENDOR_HYGON) &&
+	     cpupower_cpu_info.family >= 0x10) {
 		ret = decode_pstates(cpu, cpupower_cpu_info.family, b_states,
 				     pstates, &pstate_no);
 		if (ret)
diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
index 732b0b4..0e513b1 100644
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
 
@@ -125,7 +126,8 @@ int get_cpu_info(struct cpupower_cpu_info *cpu_info)
 		cpu_info->caps |= CPUPOWER_CAP_APERF;
 
 	/* AMD Boost state enable/disable register */
-	if (cpu_info->vendor == X86_VENDOR_AMD) {
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
