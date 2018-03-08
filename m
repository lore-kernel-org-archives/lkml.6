Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934576AbeCHL2R (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:28:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51607 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751374AbeCHL2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:28:15 -0500
Date: Thu, 8 Mar 2018 03:27:51 -0800
From: tip-bot for Ralf Ramsauer <tipbot@zytor.com>
Message-ID: <tip-52586b089cc12d4878e56ee98a4d110fa801758a@git.kernel.org>
Cc: mingo@kernel.org, ak@linux.intel.com, hpa@zytor.com,
        ralf.ramsauer@oth-regensburg.de, gayatri.kammela@intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, ak@linux.intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        gayatri.kammela@intel.com, ralf.ramsauer@oth-regensburg.de
In-Reply-To: <20180307160734.6691-1-ralf.ramsauer@oth-regensburg.de>
References: <20180307160734.6691-1-ralf.ramsauer@oth-regensburg.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/cpuid: Switch to 'static const' specifier
Git-Commit-ID: 52586b089cc12d4878e56ee98a4d110fa801758a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  52586b089cc12d4878e56ee98a4d110fa801758a
Gitweb:     https://git.kernel.org/tip/52586b089cc12d4878e56ee98a4d110fa801758a
Author:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
AuthorDate: Wed, 7 Mar 2018 17:07:34 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 12:23:42 +0100

x86/cpuid: Switch to 'static const' specifier

This is the only spot where the 'const static' specifier is used;
everywhere else 'static const' is preferred, as static should be the
first specifier.

This is just a cosmetic fix that aligns this, no functional change.

Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Gayatri Kammela <gayatri.kammela@intel.com>
Link: https://lkml.kernel.org/r/20180307160734.6691-1-ralf.ramsauer@oth-regensburg.de

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
