Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeDDF3I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 01:29:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40631 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeDDF3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 01:29:07 -0400
Date: Tue, 3 Apr 2018 22:28:54 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-m2yl8wj0uxs8pncq2ncfcx46@git.kernel.org>
Cc: wangnan0@huawei.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, tglx@linutronix.de,
        acme@redhat.com, kirill.shutemov@linux.intel.com, dsahern@gmail.com,
        jolsa@kernel.org, namhyung@kernel.org, mingo@kernel.org
Reply-To: wangnan0@huawei.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, acme@redhat.com, tglx@linutronix.de,
        jolsa@kernel.org, namhyung@kernel.org, dsahern@gmail.com,
        mingo@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers: Synchronize x86's cpufeatures.h
Git-Commit-ID: 5e2a146bbdae6095b13bca9ebe26a867030ae010
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

Commit-ID:  5e2a146bbdae6095b13bca9ebe26a867030ae010
Gitweb:     https://git.kernel.org/tip/5e2a146bbdae6095b13bca9ebe26a867030ae010
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 29 Mar 2018 11:46:53 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 2 Apr 2018 07:57:37 -0300

tools headers: Synchronize x86's cpufeatures.h

Due to these commits:

  1da961d72ab0 ("x86/cpufeatures: Add Intel Total Memory Encryption cpufeature")
  7958b2246fad ("x86/cpufeatures: Add Intel PCONFIG cpufeature")

To silence this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'

Nothing in those csets requires changes in tools/perf/, so just
sync it to silence the build.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-m2yl8wj0uxs8pncq2ncfcx46@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index f41079da38c5..d554c11e01ff 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -316,6 +316,7 @@
 #define X86_FEATURE_VPCLMULQDQ		(16*32+10) /* Carry-Less Multiplication Double Quadword */
 #define X86_FEATURE_AVX512_VNNI		(16*32+11) /* Vector Neural Network Instructions */
 #define X86_FEATURE_AVX512_BITALG	(16*32+12) /* Support for VPOPCNT[B,W] and VPSHUF-BITQMB instructions */
+#define X86_FEATURE_TME			(16*32+13) /* Intel Total Memory Encryption */
 #define X86_FEATURE_AVX512_VPOPCNTDQ	(16*32+14) /* POPCNT for vectors of DW/QW */
 #define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
@@ -328,6 +329,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
 #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
 #define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
