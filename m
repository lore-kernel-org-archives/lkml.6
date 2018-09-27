Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09BBC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4ED21564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4ED21564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeI0X0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:26:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38203 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeI0X0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:26:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RH6cNs102192
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 10:06:38 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RH6cXc102188;
        Thu, 27 Sep 2018 10:06:38 -0700
Date:   Thu, 27 Sep 2018 10:06:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pu Wen <tipbot@zytor.com>
Message-ID: <tip-ac78bd72355d0da64c073c12927264d4ff19b886@git.kernel.org>
Cc:     bp@suse.de, hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
        puwen@hygon.cn, linux-kernel@vger.kernel.org
Reply-To: puwen@hygon.cn, mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, bp@suse.de, hpa@zytor.com
In-Reply-To: <87d8a4f16bdea0bfe0c0cf2e4a8d2c2a99b1055c.1537533369.git.puwen@hygon.cn>
References: <87d8a4f16bdea0bfe0c0cf2e4a8d2c2a99b1055c.1537533369.git.puwen@hygon.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/mce: Add Hygon Dhyana support to the MCA
 infrastructure
Git-Commit-ID: ac78bd72355d0da64c073c12927264d4ff19b886
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

Commit-ID:  ac78bd72355d0da64c073c12927264d4ff19b886
Gitweb:     https://git.kernel.org/tip/ac78bd72355d0da64c073c12927264d4ff19b886
Author:     Pu Wen <puwen@hygon.cn>
AuthorDate: Sun, 23 Sep 2018 17:36:04 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 27 Sep 2018 18:28:59 +0200

x86/mce: Add Hygon Dhyana support to the MCA infrastructure

The machine check architecture for Hygon Dhyana CPU is similar to the
AMD family 17h one. Add vendor checking for Hygon Dhyana to share the
code path of AMD family 17h.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: tglx@linutronix.de
Cc: mingo@redhat.com
Cc: hpa@zytor.com
Cc: tony.luck@intel.com
Cc: thomas.lendacky@amd.com
Cc: linux-edac@vger.kernel.org
Link: https://lkml.kernel.org/r/87d8a4f16bdea0bfe0c0cf2e4a8d2c2a99b1055c.1537533369.git.puwen@hygon.cn
---
 arch/x86/include/asm/mce.h                |  2 ++
 arch/x86/kernel/cpu/mcheck/mce-severity.c |  3 ++-
 arch/x86/kernel/cpu/mcheck/mce.c          | 20 +++++++++++++++-----
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 3a17107594c8..550f2c95dc1e 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -214,6 +214,8 @@ static inline void mce_amd_feature_init(struct cpuinfo_x86 *c) { }
 static inline int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr) { return -EINVAL; };
 #endif
 
+static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c) { return mce_amd_feature_init(c); }
+
 int mce_available(struct cpuinfo_x86 *c);
 bool mce_is_memory_error(struct mce *m);
 
diff --git a/arch/x86/kernel/cpu/mcheck/mce-severity.c b/arch/x86/kernel/cpu/mcheck/mce-severity.c
index f34d89c01edc..44396d521987 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-severity.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-severity.c
@@ -336,7 +336,8 @@ int (*mce_severity)(struct mce *m, int tolerant, char **msg, bool is_excp) =
 
 void __init mcheck_vendor_init_severity(void)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		mce_severity = mce_severity_amd;
 }
 
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 953b3ce92dcc..909f1d75165c 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -270,7 +270,7 @@ static void print_mce(struct mce *m)
 {
 	__print_mce(m);
 
-	if (m->cpuvendor != X86_VENDOR_AMD)
+	if (m->cpuvendor != X86_VENDOR_AMD && m->cpuvendor != X86_VENDOR_HYGON)
 		pr_emerg_ratelimited(HW_ERR "Run the above through 'mcelog --ascii'\n");
 }
 
@@ -508,9 +508,9 @@ static int mce_usable_address(struct mce *m)
 
 bool mce_is_memory_error(struct mce *m)
 {
-	if (m->cpuvendor == X86_VENDOR_AMD) {
+	if (m->cpuvendor == X86_VENDOR_AMD ||
+	    m->cpuvendor == X86_VENDOR_HYGON) {
 		return amd_mce_is_memory_error(m);
-
 	} else if (m->cpuvendor == X86_VENDOR_INTEL) {
 		/*
 		 * Intel SDM Volume 3B - 15.9.2 Compound Error Codes
@@ -539,6 +539,9 @@ static bool mce_is_correctable(struct mce *m)
 	if (m->cpuvendor == X86_VENDOR_AMD && m->status & MCI_STATUS_DEFERRED)
 		return false;
 
+	if (m->cpuvendor == X86_VENDOR_HYGON && m->status & MCI_STATUS_DEFERRED)
+		return false;
+
 	if (m->status & MCI_STATUS_UC)
 		return false;
 
@@ -1705,7 +1708,7 @@ static int __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
  */
 static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 {
-	if (c->x86_vendor == X86_VENDOR_AMD) {
+	if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON) {
 		mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
 		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
 		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
@@ -1746,6 +1749,11 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 		mce_amd_feature_init(c);
 		break;
 		}
+
+	case X86_VENDOR_HYGON:
+		mce_hygon_feature_init(c);
+		break;
+
 	case X86_VENDOR_CENTAUR:
 		mce_centaur_feature_init(c);
 		break;
@@ -1971,12 +1979,14 @@ static void mce_disable_error_reporting(void)
 static void vendor_disable_error_reporting(void)
 {
 	/*
-	 * Don't clear on Intel or AMD CPUs. Some of these MSRs are socket-wide.
+	 * Don't clear on Intel or AMD or Hygon CPUs. Some of these MSRs
+	 * are socket-wide.
 	 * Disabling them for just a single offlined CPU is bad, since it will
 	 * inhibit reporting for all shared resources on the socket like the
 	 * last level cache (LLC), the integrated memory controller (iMC), etc.
 	 */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
 		return;
 
