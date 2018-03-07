Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934033AbeCGQQr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:16:47 -0500
Received: from mtaout.hs-regensburg.de ([194.95.104.10]:1894 "EHLO
        mtaout.hs-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933985AbeCGQQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:16:34 -0500
From: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Cc: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpuid: Switch to 'static const' specifier
Date: Wed,  7 Mar 2018 17:07:34 +0100
Message-Id: <20180307160734.6691-1-ralf.ramsauer@oth-regensburg.de>
X-Mailer: git-send-email 2.16.2
X-PMX-Version: 6.3.3.2656215, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2018.3.7.160016, AntiVirus-Engine: 5.33.0, AntiVirus-Data: 2017.1.26.5330002
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report='
 MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_1099 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, LEGITIMATE_SIGNS 0, MULTIPLE_REAL_RCPTS 0, NO_URI_HTTPS 0, RDNS_NXDOMAIN 0, RDNS_SUSP 0, RDNS_SUSP_GENERIC 0, __ANY_URI 0, __CC_NAME 0, __CC_NAME_DIFF_FROM_ACC 0, __CC_REAL_NAMES 0, __HAS_CC_HDR 0, __HAS_FROM 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_TEXT_P 0, __MIME_TEXT_P1 0, __MULTIPLE_RCPTS_CC_X2 0, __NO_HTML_TAG_RAW 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NAME 0, __TO_NAME_DIFF_FROM_ACC 0, __TO_REAL_NAMES 0, __URI_NO_WWW 0, __URI_NS '
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only spot where the 'const static' specifier is used;
everywhere else 'static const' is preferred, as static should be the
first specifier.

This is just a cosmetic fix that aligns this, no functional change.

Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
---
 arch/x86/kernel/cpu/cpuid-deps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 904b0a3c4e53..2c0bd38a44ab 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -19,7 +19,7 @@ struct cpuid_dep {
  * called from cpu hotplug. It shouldn't do anything in this case,
  * but it's difficult to tell that to the init reference checker.
  */
-const static struct cpuid_dep cpuid_deps[] = {
+static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_XSAVEOPT,		X86_FEATURE_XSAVE     },
 	{ X86_FEATURE_XSAVEC,		X86_FEATURE_XSAVE     },
 	{ X86_FEATURE_XSAVES,		X86_FEATURE_XSAVE     },
-- 
2.16.2
