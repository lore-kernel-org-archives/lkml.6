Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202F3C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB3A213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB3A213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeJDO41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:56:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48691 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbeJDO41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:56:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9483ruY2668272
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Oct 2018 01:03:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9483qUA2668269;
        Thu, 4 Oct 2018 01:03:52 -0700
Date:   Thu, 4 Oct 2018 01:03:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pu Wen <tipbot@zytor.com>
Message-ID: <tip-995d5f64b62f20f05b8e0972f07ec4d6c23333c9@git.kernel.org>
Cc:     puwen@hygon.cn, hpa@zytor.com, shuah@kernel.org, prarit@redhat.com,
        trenn@suse.com, bp@suse.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, prarit@redhat.com, hpa@zytor.com,
          shuah@kernel.org, puwen@hygon.cn, bp@suse.de, trenn@suse.com
In-Reply-To: <5ce86123a7b9dad925ac583d88d2f921040e859b.1538583282.git.puwen@hygon.cn>
References: <5ce86123a7b9dad925ac583d88d2f921040e859b.1538583282.git.puwen@hygon.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] tools/cpupower: Add Hygon Dhyana support
Git-Commit-ID: 995d5f64b62f20f05b8e0972f07ec4d6c23333c9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  995d5f64b62f20f05b8e0972f07ec4d6c23333c9
Gitweb:     https://git.kernel.org/tip/995d5f64b62f20f05b8e0972f07ec4d6c23333c9
Author:     Pu Wen <puwen@hygon.cn>
AuthorDate: Thu, 4 Oct 2018 09:21:43 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 4 Oct 2018 09:57:25 +0200

tools/cpupower: Add Hygon Dhyana support

The tool cpupower is useful to get CPU frequency information and monitor
power stats on the Hygon Dhyana platform. So add Hygon Dhyana support to
it by checking vendor and family to share the code path of AMD family
17h.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
CC: Prarit Bhargava <prarit@redhat.com>
CC: Shuah Khan <shuah@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Thomas Renninger <trenn@suse.com>
CC: linux-pm@vger.kernel.org
Link: http://lkml.kernel.org/r/5ce86123a7b9dad925ac583d88d2f921040e859b.1538583282.git.puwen@hygon.cn
---
 tools/power/cpupower/utils/cpufreq-info.c               | 6 ++++--
 tools/power/cpupower/utils/helpers/amd.c                | 4 ++--
 tools/power/cpupower/utils/helpers/cpuid.c              | 8 +++++---
 tools/power/cpupower/utils/helpers/helpers.h            | 2 +-
 tools/power/cpupower/utils/helpers/misc.c               | 2 +-
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c | 3 ++-
 6 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index df43cd45d810..56e54eabc65c 100644
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
index bb41cdd0df6b..65beaeefeef0 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -45,7 +45,7 @@ static int get_did(int family, union msr_pstate pstate)
 
 	if (family == 0x12)
 		t = pstate.val & 0xf;
-	else if (family == 0x17)
+	else if (family == 0x17 || family == 0x18)
 		t = pstate.fam17h_bits.did;
 	else
 		t = pstate.bits.did;
@@ -59,7 +59,7 @@ static int get_cof(int family, union msr_pstate pstate)
 	int fid, did, cof;
 
 	did = get_did(family, pstate);
-	if (family == 0x17) {
+	if (family == 0x17 || family == 0x18) {
 		fid = pstate.fam17h_bits.fid;
 		cof = 200 * fid / did;
 	} else {
diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
index 732b0b41ba26..5cc39d4e23ed 100644
--- a/tools/power/cpupower/utils/helpers/cpuid.c
+++ b/tools/power/cpupower/utils/helpers/cpuid.c
@@ -8,7 +8,7 @@
 #include "helpers/helpers.h"
 
 static const char *cpu_vendor_table[X86_VENDOR_MAX] = {
-	"Unknown", "GenuineIntel", "AuthenticAMD",
+	"Unknown", "GenuineIntel", "AuthenticAMD", "HygonGenuine",
 };
 
 #if defined(__i386__) || defined(__x86_64__)
@@ -109,6 +109,7 @@ out:
 	fclose(fp);
 	/* Get some useful CPU capabilities from cpuid */
 	if (cpu_info->vendor != X86_VENDOR_AMD &&
+	    cpu_info->vendor != X86_VENDOR_HYGON &&
 	    cpu_info->vendor != X86_VENDOR_INTEL)
 		return ret;
 
@@ -124,8 +125,9 @@ out:
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
index 41da392be448..902139689315 100644
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
index 80fdf55f414d..f406adc40bad 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -26,7 +26,7 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
 		 * has Hardware determined variable increments instead.
 		 */
 
-		if (cpu_info.family == 0x17) {
+		if (cpu_info.family == 0x17 || cpu_info.family == 0x18) {
 			if (!read_msr(cpu, MSR_AMD_HWCR, &val)) {
 				if (!(val & CPUPOWER_AMD_CPBDIS))
 					*active = 1;
diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
index d7c2a6d13dea..f2a7e9cfd577 100644
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
