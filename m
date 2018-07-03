Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D176C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9159219EE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9159219EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753294AbeGCLPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:15:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57775 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeGCLPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:15:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w63BFPKC258369
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 04:15:25 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w63BFPIV258366;
        Tue, 3 Jul 2018 04:15:25 -0700
Date:   Tue, 3 Jul 2018 04:15:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-d99e5da91b36db5c35ddaf3653b280ee060971da@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, hpa@zytor.com,
        pasha.tatashin@oracle.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, bin.gao@intel.com, tglx@linutronix.de,
        andriy.shevchenko@linux.intel.com
Reply-To: hpa@zytor.com, pasha.tatashin@oracle.com,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mingo@kernel.org, bin.gao@intel.com,
          andriy.shevchenko@linux.intel.com
In-Reply-To: <20180629193113.84425-6-andriy.shevchenko@linux.intel.com>
References: <20180629193113.84425-6-andriy.shevchenko@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/platform/intel-mid: Remove custom TSC
 calibration
Git-Commit-ID: d99e5da91b36db5c35ddaf3653b280ee060971da
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

Commit-ID:  d99e5da91b36db5c35ddaf3653b280ee060971da
Gitweb:     https://git.kernel.org/tip/d99e5da91b36db5c35ddaf3653b280ee060971da
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Fri, 29 Jun 2018 22:31:12 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 3 Jul 2018 13:08:21 +0200

x86/platform/intel-mid: Remove custom TSC calibration

Since the commit

  7da7c1561366 ("x86, tsc: Add static (MSR) TSC calibration on Intel Atom SoCs")

introduced a common way for all Intel MID chips to get their TSC frequency
via MSRs, there is no need to keep a duplication in each of Intel MID
platform code.

Thus, remove the custom calibration code for good.

Note, there is slight difference in how to get frequency for (reserved?)
values in MSRs, i.e. legacy code enforces some defaults while new code just
uses 0 in that cases.

Suggested-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Bin Gao <bin.gao@intel.com>
Link: https://lkml.kernel.org/r/20180629193113.84425-6-andriy.shevchenko@linux.intel.com

---
 arch/x86/include/asm/intel-mid.h        | 14 -------
 arch/x86/kernel/tsc_msr.c               |  5 +++
 arch/x86/platform/intel-mid/intel-mid.c |  6 ---
 arch/x86/platform/intel-mid/mfld.c      | 36 ----------------
 arch/x86/platform/intel-mid/mrfld.c     | 74 ---------------------------------
 5 files changed, 5 insertions(+), 130 deletions(-)

diff --git a/arch/x86/include/asm/intel-mid.h b/arch/x86/include/asm/intel-mid.h
index fe04491130ae..376eb8ada62d 100644
--- a/arch/x86/include/asm/intel-mid.h
+++ b/arch/x86/include/asm/intel-mid.h
@@ -136,20 +136,6 @@ enum intel_mid_timer_options {
 
 extern enum intel_mid_timer_options intel_mid_timer_options;
 
-/*
- * Penwell uses spread spectrum clock, so the freq number is not exactly
- * the same as reported by MSR based on SDM.
- */
-#define FSB_FREQ_83SKU			83200
-#define FSB_FREQ_100SKU			99840
-#define FSB_FREQ_133SKU			133000
-
-#define FSB_FREQ_167SKU			167000
-#define FSB_FREQ_200SKU			200000
-#define FSB_FREQ_267SKU			267000
-#define FSB_FREQ_333SKU			333000
-#define FSB_FREQ_400SKU			400000
-
 /* Bus Select SoC Fuse value */
 #define BSEL_SOC_FUSE_MASK		0x7
 /* FSB 133MHz */
diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index f0951c2e9f28..27ef714d886c 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -29,6 +29,11 @@ struct freq_desc {
 	u32 freqs[MAX_NUM_FREQS];
 };
 
+/*
+ * Penwell and Clovertrail use spread spectrum clock,
+ * so the freq number is not exactly the same as reported
+ * by MSR based on SDM.
+ */
 static const struct freq_desc freq_desc_pnw = {
 	0, { 0, 0, 0, 0, 0, 99840, 0, 83200 }
 };
diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 2ebdf31d9996..aac15a4018d5 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -82,11 +82,6 @@ static void intel_mid_reboot(void)
 	intel_scu_ipc_simple_command(IPCMSG_COLD_RESET, 0);
 }
 
-static unsigned long __init intel_mid_calibrate_tsc(void)
-{
-	return 0;
-}
-
 static void __init intel_mid_setup_bp_timer(void)
 {
 	apbt_time_init();
@@ -191,7 +186,6 @@ void __init x86_intel_mid_early_setup(void)
 
 	x86_cpuinit.setup_percpu_clockev = apbt_setup_secondary_clock;
 
-	x86_platform.calibrate_tsc = intel_mid_calibrate_tsc;
 	x86_platform.get_nmi_reason = intel_mid_get_nmi_reason;
 
 	x86_init.pci.arch_init = intel_mid_pci_init;
diff --git a/arch/x86/platform/intel-mid/mfld.c b/arch/x86/platform/intel-mid/mfld.c
index e42978d4deaf..e66b51f5c206 100644
--- a/arch/x86/platform/intel-mid/mfld.c
+++ b/arch/x86/platform/intel-mid/mfld.c
@@ -11,48 +11,12 @@
 
 #include <linux/init.h>
 
-#include <asm/apic.h>
 #include <asm/intel-mid.h>
-#include <asm/intel_mid_vrtc.h>
 
 #include "intel_mid_weak_decls.h"
 
-static unsigned long __init mfld_calibrate_tsc(void)
-{
-	unsigned long fast_calibrate;
-	u32 lo, hi, ratio, fsb;
-
-	rdmsr(MSR_IA32_PERF_STATUS, lo, hi);
-	pr_debug("IA32 perf status is 0x%x, 0x%0x\n", lo, hi);
-	ratio = (hi >> 8) & 0x1f;
-	pr_debug("ratio is %d\n", ratio);
-	if (!ratio) {
-		pr_err("read a zero ratio, should be incorrect!\n");
-		pr_err("force tsc ratio to 16 ...\n");
-		ratio = 16;
-	}
-	rdmsr(MSR_FSB_FREQ, lo, hi);
-	if ((lo & 0x7) == 0x7)
-		fsb = FSB_FREQ_83SKU;
-	else
-		fsb = FSB_FREQ_100SKU;
-	fast_calibrate = ratio * fsb;
-	pr_debug("read penwell tsc %lu khz\n", fast_calibrate);
-	lapic_timer_frequency = fsb * 1000 / HZ;
-
-	/*
-	 * TSC on Intel Atom SoCs is reliable and of known frequency.
-	 * See tsc_msr.c for details.
-	 */
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
-	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
-
-	return fast_calibrate;
-}
-
 static void __init penwell_arch_setup(void)
 {
-	x86_platform.calibrate_tsc = mfld_calibrate_tsc;
 }
 
 static struct intel_mid_ops penwell_ops = {
diff --git a/arch/x86/platform/intel-mid/mrfld.c b/arch/x86/platform/intel-mid/mrfld.c
index ae7bdeb0e507..c5538ec2d62d 100644
--- a/arch/x86/platform/intel-mid/mrfld.c
+++ b/arch/x86/platform/intel-mid/mrfld.c
@@ -11,86 +11,12 @@
 
 #include <linux/init.h>
 
-#include <asm/apic.h>
 #include <asm/intel-mid.h>
 
 #include "intel_mid_weak_decls.h"
 
-static unsigned long __init tangier_calibrate_tsc(void)
-{
-	unsigned long fast_calibrate;
-	u32 lo, hi, ratio, fsb, bus_freq;
-
-	/* *********************** */
-	/* Compute TSC:Ratio * FSB */
-	/* *********************** */
-
-	/* Compute Ratio */
-	rdmsr(MSR_PLATFORM_INFO, lo, hi);
-	pr_debug("IA32 PLATFORM_INFO is 0x%x : %x\n", hi, lo);
-
-	ratio = (lo >> 8) & 0xFF;
-	pr_debug("ratio is %d\n", ratio);
-	if (!ratio) {
-		pr_err("Read a zero ratio, force tsc ratio to 4 ...\n");
-		ratio = 4;
-	}
-
-	/* Compute FSB */
-	rdmsr(MSR_FSB_FREQ, lo, hi);
-	pr_debug("Actual FSB frequency detected by SOC 0x%x : %x\n",
-			hi, lo);
-
-	bus_freq = lo & 0x7;
-	pr_debug("bus_freq = 0x%x\n", bus_freq);
-
-	if (bus_freq == 0)
-		fsb = FSB_FREQ_100SKU;
-	else if (bus_freq == 1)
-		fsb = FSB_FREQ_100SKU;
-	else if (bus_freq == 2)
-		fsb = FSB_FREQ_133SKU;
-	else if (bus_freq == 3)
-		fsb = FSB_FREQ_167SKU;
-	else if (bus_freq == 4)
-		fsb = FSB_FREQ_83SKU;
-	else if (bus_freq == 5)
-		fsb = FSB_FREQ_400SKU;
-	else if (bus_freq == 6)
-		fsb = FSB_FREQ_267SKU;
-	else if (bus_freq == 7)
-		fsb = FSB_FREQ_333SKU;
-	else {
-		BUG();
-		pr_err("Invalid bus_freq! Setting to minimal value!\n");
-		fsb = FSB_FREQ_100SKU;
-	}
-
-	/* TSC = FSB Freq * Resolved HFM Ratio */
-	fast_calibrate = ratio * fsb;
-	pr_debug("calculate tangier tsc %lu KHz\n", fast_calibrate);
-
-	/* ************************************ */
-	/* Calculate Local APIC Timer Frequency */
-	/* ************************************ */
-	lapic_timer_frequency = (fsb * 1000) / HZ;
-
-	pr_debug("Setting lapic_timer_frequency = %d\n",
-			lapic_timer_frequency);
-
-	/*
-	 * TSC on Intel Atom SoCs is reliable and of known frequency.
-	 * See tsc_msr.c for details.
-	 */
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
-	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
-
-	return fast_calibrate;
-}
-
 static void __init tangier_arch_setup(void)
 {
-	x86_platform.calibrate_tsc = tangier_calibrate_tsc;
 	x86_platform.legacy.rtc = 1;
 }
 
