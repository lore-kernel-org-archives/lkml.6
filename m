Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7474C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7B621564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7B621564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbeI0X2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:28:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52815 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeI0X2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:28:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RH8q92102438
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 10:08:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RH8qxX102435;
        Thu, 27 Sep 2018 10:08:52 -0700
Date:   Thu, 27 Sep 2018 10:08:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pu Wen <tipbot@zytor.com>
Message-ID: <tip-cc9690cfc7a36873b219d569049e10f073dd22e4@git.kernel.org>
Cc:     mingo@kernel.org, bp@suse.de, puwen@hygon.cn,
        rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Reply-To: bp@suse.de, puwen@hygon.cn, mingo@kernel.org, tglx@linutronix.de,
          hpa@zytor.com, rafael.j.wysocki@intel.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <4db6f0f8537a93c172430c446a0297a6ab1c3c2d.1537533369.git.puwen@hygon.cn>
References: <4db6f0f8537a93c172430c446a0297a6ab1c3c2d.1537533369.git.puwen@hygon.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] cpufreq: Add Hygon Dhyana support
Git-Commit-ID: cc9690cfc7a36873b219d569049e10f073dd22e4
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

Commit-ID:  cc9690cfc7a36873b219d569049e10f073dd22e4
Gitweb:     https://git.kernel.org/tip/cc9690cfc7a36873b219d569049e10f073dd22e4
Author:     Pu Wen <puwen@hygon.cn>
AuthorDate: Sun, 23 Sep 2018 17:37:38 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 27 Sep 2018 18:29:00 +0200

cpufreq: Add Hygon Dhyana support

The Hygon Dhyana CPU supports ACPI P-States, and there is SMBus device
(PCI device ID 0x790b) on the Hygon platform. Add Hygon Dhyana support
to the cpufreq driver by using the code path of AMD family 17h.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org
Cc: bp@alien8.de
Cc: tglx@linutronix.de
Cc: mingo@redhat.com
Cc: hpa@zytor.com
Cc: x86@kernel.org
Cc: thomas.lendacky@amd.com
Cc: rafael@kernel.org
Cc: linux-pm@vger.kernel.org
Link: https://lkml.kernel.org/r/4db6f0f8537a93c172430c446a0297a6ab1c3c2d.1537533369.git.puwen@hygon.cn
---
 drivers/cpufreq/acpi-cpufreq.c         | 5 +++++
 drivers/cpufreq/amd_freq_sensitivity.c | 9 +++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index b61f4ec43e06..d62fd374d5c7 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -61,6 +61,7 @@ enum {
 
 #define INTEL_MSR_RANGE		(0xffff)
 #define AMD_MSR_RANGE		(0x7)
+#define HYGON_MSR_RANGE		(0x7)
 
 #define MSR_K7_HWCR_CPB_DIS	(1ULL << 25)
 
@@ -95,6 +96,7 @@ static bool boost_state(unsigned int cpu)
 		rdmsr_on_cpu(cpu, MSR_IA32_MISC_ENABLE, &lo, &hi);
 		msr = lo | ((u64)hi << 32);
 		return !(msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 		rdmsr_on_cpu(cpu, MSR_K7_HWCR, &lo, &hi);
 		msr = lo | ((u64)hi << 32);
@@ -113,6 +115,7 @@ static int boost_set_msr(bool enable)
 		msr_addr = MSR_IA32_MISC_ENABLE;
 		msr_mask = MSR_IA32_MISC_ENABLE_TURBO_DISABLE;
 		break;
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 		msr_addr = MSR_K7_HWCR;
 		msr_mask = MSR_K7_HWCR_CPB_DIS;
@@ -225,6 +228,8 @@ static unsigned extract_msr(struct cpufreq_policy *policy, u32 msr)
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
 		msr &= AMD_MSR_RANGE;
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		msr &= HYGON_MSR_RANGE;
 	else
 		msr &= INTEL_MSR_RANGE;
 
diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
index be926d9a66e5..4ac7c3cf34be 100644
--- a/drivers/cpufreq/amd_freq_sensitivity.c
+++ b/drivers/cpufreq/amd_freq_sensitivity.c
@@ -111,11 +111,16 @@ static int __init amd_freq_sensitivity_init(void)
 {
 	u64 val;
 	struct pci_dev *pcidev;
+	unsigned int pci_vendor;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		pci_vendor = PCI_VENDOR_ID_AMD;
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		pci_vendor = PCI_VENDOR_ID_HYGON;
+	else
 		return -ENODEV;
 
-	pcidev = pci_get_device(PCI_VENDOR_ID_AMD,
+	pcidev = pci_get_device(pci_vendor,
 			PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, NULL);
 
 	if (!pcidev) {
