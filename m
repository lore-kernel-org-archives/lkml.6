Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14586C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD04321A6E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD04321A6E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbeGCLNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:13:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50185 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeGCLNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:13:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w63BDdZO258023
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 04:13:39 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w63BDd3c258020;
        Tue, 3 Jul 2018 04:13:39 -0700
Date:   Tue, 3 Jul 2018 04:13:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-e2ce67b2b34b6e9d77da2f375dba5b525508f7df@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        pasha.tatashin@oracle.com, hpa@zytor.com, mingo@kernel.org,
        andriy.shevchenko@linux.intel.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          pasha.tatashin@oracle.com, andriy.shevchenko@linux.intel.com,
          hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20180629193113.84425-2-andriy.shevchenko@linux.intel.com>
References: <20180629193113.84425-2-andriy.shevchenko@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/cpu: Introduce INTEL_CPU_FAM*() helper macros
Git-Commit-ID: e2ce67b2b34b6e9d77da2f375dba5b525508f7df
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

Commit-ID:  e2ce67b2b34b6e9d77da2f375dba5b525508f7df
Gitweb:     https://git.kernel.org/tip/e2ce67b2b34b6e9d77da2f375dba5b525508f7df
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Fri, 29 Jun 2018 22:31:08 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 3 Jul 2018 13:08:20 +0200

x86/cpu: Introduce INTEL_CPU_FAM*() helper macros

These macros are often used by drivers and there exists already a lot of
duplication as ICPU() macro across the drivers.

Provide a generic x86 macro for users.

Note, as Ingo Molnar pointed out this has a hidden issue when a driver
needs to preserve const qualifier. Though, it would be addressed
separately at some point.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Link: https://lkml.kernel.org/r/20180629193113.84425-2-andriy.shevchenko@linux.intel.com

---
 arch/x86/include/asm/intel-family.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index cf090e584202..7ed08a7c3398 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -76,4 +76,17 @@
 #define INTEL_FAM6_XEON_PHI_KNL		0x57 /* Knights Landing */
 #define INTEL_FAM6_XEON_PHI_KNM		0x85 /* Knights Mill */
 
+/* Useful macros */
+#define INTEL_CPU_FAM_ANY(_family, _model, _driver_data)	\
+{								\
+	.vendor		= X86_VENDOR_INTEL,			\
+	.family		= _family,				\
+	.model		= _model,				\
+	.feature	= X86_FEATURE_ANY,			\
+	.driver_data	= (kernel_ulong_t)&_driver_data		\
+}
+
+#define INTEL_CPU_FAM6(_model, _driver_data)			\
+	INTEL_CPU_FAM_ANY(6, INTEL_FAM6_##_model, _driver_data)
+
 #endif /* _ASM_X86_INTEL_FAMILY_H */
