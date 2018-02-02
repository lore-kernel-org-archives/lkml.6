Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbeBBWWS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 17:22:18 -0500
Received: from terminus.zytor.com ([65.50.211.136]:35113 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752151AbeBBWWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 17:22:12 -0500
Date: Fri, 2 Feb 2018 14:18:51 -0800
From: tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-4bf5d56d429cbc96c23d809a08f63cd29e1a702e@git.kernel.org>
Cc: dwmw@amazon.co.uk, thgarnie@google.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, ricardo.neri-calderon@linux.intel.com,
        tglx@linutronix.de, mingo@kernel.org, luto@kernel.org, arnd@arndb.de,
        bp@suse.de
Reply-To: bp@suse.de, arnd@arndb.de, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, ricardo.neri-calderon@linux.intel.com,
        linux-kernel@vger.kernel.org, thgarnie@google.com, hpa@zytor.com,
        dwmw@amazon.co.uk
In-Reply-To: <20180202213959.611210-1-arnd@arndb.de>
References: <20180202213959.611210-1-arnd@arndb.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/pti: Mark constant arrays as __initconst
Git-Commit-ID: 4bf5d56d429cbc96c23d809a08f63cd29e1a702e
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

Commit-ID:  4bf5d56d429cbc96c23d809a08f63cd29e1a702e
Gitweb:     https://git.kernel.org/tip/4bf5d56d429cbc96c23d809a08f63cd29e1a702e
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Fri, 2 Feb 2018 22:39:23 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 2 Feb 2018 23:13:56 +0100

x86/pti: Mark constant arrays as __initconst

I'm seeing build failures from the two newly introduced arrays that
are marked 'const' and '__initdata', which are mutually exclusive:

arch/x86/kernel/cpu/common.c:882:43: error: 'cpu_no_speculation' causes a section type conflict with 'e820_table_firmware_init'
arch/x86/kernel/cpu/common.c:895:43: error: 'cpu_no_meltdown' causes a section type conflict with 'e820_table_firmware_init'

The correct annotation is __initconst.

Fixes: fec9434a12f3 ("x86/pti: Do not enable PTI on CPUs which are not vulnerable to Meltdown")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/20180202213959.611210-1-arnd@arndb.de

---
 arch/x86/kernel/cpu/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index dd09270..d63f4b57 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -900,7 +900,7 @@ static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
 #endif
 }
 
-static const __initdata struct x86_cpu_id cpu_no_speculation[] = {
+static const __initconst struct x86_cpu_id cpu_no_speculation[] = {
 	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_CEDARVIEW,	X86_FEATURE_ANY },
 	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_CLOVERVIEW,	X86_FEATURE_ANY },
 	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_LINCROFT,	X86_FEATURE_ANY },
@@ -913,7 +913,7 @@ static const __initdata struct x86_cpu_id cpu_no_speculation[] = {
 	{}
 };
 
-static const __initdata struct x86_cpu_id cpu_no_meltdown[] = {
+static const __initconst struct x86_cpu_id cpu_no_meltdown[] = {
 	{ X86_VENDOR_AMD },
 	{}
 };
