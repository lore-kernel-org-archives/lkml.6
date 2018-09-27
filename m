Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E83DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0AC21566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0AC21566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbeI0XWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:22:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33465 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbeI0XWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:22:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RH3Hpg100133
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 10:03:17 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RH3H9c100129;
        Thu, 27 Sep 2018 10:03:17 -0700
Date:   Thu, 27 Sep 2018 10:03:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pu Wen <tipbot@zytor.com>
Message-ID: <tip-6d0ef316b9f8ea03fa867debda70b2f11a0b9736@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        puwen@hygon.cn, linux-kernel@vger.kernel.org, bp@suse.de
Reply-To: bp@suse.de, puwen@hygon.cn, linux-kernel@vger.kernel.org,
          mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <9d93ed54a975f33ef7247e0967960f4ce5d3d990.1537533369.git.puwen@hygon.cn>
References: <9d93ed54a975f33ef7247e0967960f4ce5d3d990.1537533369.git.puwen@hygon.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/events: Add Hygon Dhyana support to PMU
 infrastructure
Git-Commit-ID: 6d0ef316b9f8ea03fa867debda70b2f11a0b9736
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

Commit-ID:  6d0ef316b9f8ea03fa867debda70b2f11a0b9736
Gitweb:     https://git.kernel.org/tip/6d0ef316b9f8ea03fa867debda70b2f11a0b9736
Author:     Pu Wen <puwen@hygon.cn>
AuthorDate: Sun, 23 Sep 2018 17:34:47 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 27 Sep 2018 18:28:57 +0200

x86/events: Add Hygon Dhyana support to PMU infrastructure

The PMU architecture for the Hygon Dhyana CPU is similar to the AMD
Family 17h one. To support it, call amd_pmu_init() to share the AMD PMU
initialization flow, and change the PMU name to "HYGON".

The Hygon Dhyana CPU supports both legacy and extension PMC MSRs (perf
counter registers and event selection registers), so add Hygon Dhyana
support in the similar way as AMD does.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: tglx@linutronix.de
Cc: mingo@redhat.com
Cc: hpa@zytor.com
Cc: x86@kernel.org
Cc: thomas.lendacky@amd.com
Link: https://lkml.kernel.org/r/9d93ed54a975f33ef7247e0967960f4ce5d3d990.1537533369.git.puwen@hygon.cn
---
 arch/x86/events/amd/core.c             |  4 ++++
 arch/x86/events/amd/uncore.c           | 20 +++++++++++++-------
 arch/x86/events/core.c                 |  4 ++++
 arch/x86/kernel/cpu/perfctr-watchdog.c |  2 ++
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index c84584bb9402..7d2d7c801dba 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -669,6 +669,10 @@ static int __init amd_core_pmu_init(void)
 		 * We fallback to using default amd_get_event_constraints.
 		 */
 		break;
+	case 0x18:
+		pr_cont("Fam18h ");
+		/* Using default amd_get_event_constraints. */
+		break;
 	default:
 		pr_err("core perfctr but no constraints; unknown hardware!\n");
 		return -ENODEV;
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 981ba5e8241b..c7d745bc4136 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -507,17 +507,19 @@ static int __init amd_uncore_init(void)
 {
 	int ret = -ENODEV;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
 		return -ENODEV;
 
-	if (boot_cpu_data.x86 == 0x17) {
+	if (boot_cpu_data.x86 == 0x17 || boot_cpu_data.x86 == 0x18) {
 		/*
-		 * For F17h, the Northbridge counters are repurposed as Data
-		 * Fabric counters. Also, L3 counters are supported too. The PMUs
-		 * are exported based on  family as either L2 or L3 and NB or DF.
+		 * For F17h or F18h, the Northbridge counters are
+		 * repurposed as Data Fabric counters. Also, L3
+		 * counters are supported too. The PMUs are exported
+		 * based on family as either L2 or L3 and NB or DF.
 		 */
 		num_counters_nb		  = NUM_COUNTERS_NB;
 		num_counters_llc	  = NUM_COUNTERS_L3;
@@ -547,7 +549,9 @@ static int __init amd_uncore_init(void)
 		if (ret)
 			goto fail_nb;
 
-		pr_info("AMD NB counters detected\n");
+		pr_info("%s NB counters detected\n",
+			boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?
+				"HYGON" : "AMD");
 		ret = 0;
 	}
 
@@ -561,7 +565,9 @@ static int __init amd_uncore_init(void)
 		if (ret)
 			goto fail_llc;
 
-		pr_info("AMD LLC counters detected\n");
+		pr_info("%s LLC counters detected\n",
+			boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?
+				"HYGON" : "AMD");
 		ret = 0;
 	}
 
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index dfb2f7c0d019..9c562f5fbde0 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1776,6 +1776,10 @@ static int __init init_hw_perf_events(void)
 	case X86_VENDOR_AMD:
 		err = amd_pmu_init();
 		break;
+	case X86_VENDOR_HYGON:
+		err = amd_pmu_init();
+		x86_pmu.name = "HYGON";
+		break;
 	default:
 		err = -ENOTSUPP;
 	}
diff --git a/arch/x86/kernel/cpu/perfctr-watchdog.c b/arch/x86/kernel/cpu/perfctr-watchdog.c
index d389083330c5..9556930cd8c1 100644
--- a/arch/x86/kernel/cpu/perfctr-watchdog.c
+++ b/arch/x86/kernel/cpu/perfctr-watchdog.c
@@ -46,6 +46,7 @@ static inline unsigned int nmi_perfctr_msr_to_bit(unsigned int msr)
 {
 	/* returns the bit offset of the performance counter register */
 	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 		if (msr >= MSR_F15H_PERF_CTR)
 			return (msr - MSR_F15H_PERF_CTR) >> 1;
@@ -74,6 +75,7 @@ static inline unsigned int nmi_evntsel_msr_to_bit(unsigned int msr)
 {
 	/* returns the bit offset of the event selection register */
 	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 		if (msr >= MSR_F15H_PERF_CTL)
 			return (msr - MSR_F15H_PERF_CTL) >> 1;
