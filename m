Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2D8C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AAF214C6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfAZKcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:32:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41467 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfAZKcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:32:04 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0QAUvFB519941
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 02:30:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0QAUsXm519937;
        Sat, 26 Jan 2019 02:30:54 -0800
Date:   Sat, 26 Jan 2019 02:30:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Gustavo A. R. Silva" <tipbot@zytor.com>
Message-ID: <tip-6fcebf1302b43e7a610d1d2fa89f41e693249aa5@git.kernel.org>
Cc:     nstange@suse.de, dianders@chromium.org, rppt@linux.vnet.ibm.com,
        keescook@chromium.org, mhiramat@kernel.org, x86@kernel.org,
        gustavo@embeddedor.com, mingo@kernel.org,
        suravee.suthikulpanit@amd.com, mingo@redhat.com,
        will.deacon@arm.com, tglx@linutronix.de,
        daniel.thompson@linaro.org, linux-kernel@vger.kernel.org,
        JBeulich@suse.com, christophe.leroy@c-s.fr, ebiederm@xmission.com,
        oleg@redhat.com, puwen@hygon.cn, frederic@kernel.org,
        hpa@zytor.com, bp@suse.de, davidwang@zhaoxin.com,
        akpm@linux-foundation.org, bhe@redhat.com
Reply-To: oleg@redhat.com, christophe.leroy@c-s.fr, ebiederm@xmission.com,
          mhiramat@kernel.org, x86@kernel.org, JBeulich@suse.com,
          puwen@hygon.cn, dianders@chromium.org, nstange@suse.de,
          daniel.thompson@linaro.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, keescook@chromium.org,
          rppt@linux.vnet.ibm.com, mingo@redhat.com,
          akpm@linux-foundation.org, davidwang@zhaoxin.com, bhe@redhat.com,
          will.deacon@arm.com, bp@suse.de, hpa@zytor.com,
          gustavo@embeddedor.com, frederic@kernel.org,
          suravee.suthikulpanit@amd.com, mingo@kernel.org
In-Reply-To: <20190125183903.GA4712@embeddedor>
References: <20190125183903.GA4712@embeddedor>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/kernel: Mark expected switch-case
 fall-throughs
Git-Commit-ID: 6fcebf1302b43e7a610d1d2fa89f41e693249aa5
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

Commit-ID:  6fcebf1302b43e7a610d1d2fa89f41e693249aa5
Gitweb:     https://git.kernel.org/tip/6fcebf1302b43e7a610d1d2fa89f41e693249aa5
Author:     Gustavo A. R. Silva <gustavo@embeddedor.com>
AuthorDate: Fri, 25 Jan 2019 12:39:03 -0600
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 26 Jan 2019 11:19:13 +0100

x86/kernel: Mark expected switch-case fall-throughs

In preparation to enable -Wimplicit-fallthrough by default, mark
switch-case statements where fall-through is intentional, explicitly in
order to fix a couple of -Wimplicit-fallthrough warnings.

Warning level 3 was used: -Wimplicit-fallthrough=3.

 [ bp: Massasge and trim commit message. ]

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: David Wang <davidwang@zhaoxin.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jan Beulich <JBeulich@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190125183903.GA4712@embeddedor
---
 arch/x86/kernel/apic/io_apic.c  | 2 ++
 arch/x86/kernel/cpu/cacheinfo.c | 1 +
 arch/x86/kernel/hw_breakpoint.c | 1 +
 arch/x86/kernel/kgdb.c          | 1 +
 arch/x86/kernel/uprobes.c       | 1 +
 5 files changed, 6 insertions(+)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 2953bbf05c08..264e3221d923 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -812,6 +812,7 @@ static int irq_polarity(int idx)
 		return IOAPIC_POL_HIGH;
 	case MP_IRQPOL_RESERVED:
 		pr_warn("IOAPIC: Invalid polarity: 2, defaulting to low\n");
+		/* fall through */
 	case MP_IRQPOL_ACTIVE_LOW:
 	default: /* Pointless default required due to do gcc stupidity */
 		return IOAPIC_POL_LOW;
@@ -859,6 +860,7 @@ static int irq_trigger(int idx)
 		return IOAPIC_EDGE;
 	case MP_IRQTRIG_RESERVED:
 		pr_warn("IOAPIC: Invalid trigger mode 2 defaulting to level\n");
+		/* fall through */
 	case MP_IRQTRIG_LEVEL:
 	default: /* Pointless default required due to do gcc stupidity */
 		return IOAPIC_LEVEL;
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index c4d1023fb0ab..395d46f78582 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -248,6 +248,7 @@ amd_cpuid4(int leaf, union _cpuid4_leaf_eax *eax,
 	switch (leaf) {
 	case 1:
 		l1 = &l1i;
+		/* fall through */
 	case 0:
 		if (!l1->val)
 			return;
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 34a5c1715148..7d6f91f2869a 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -279,6 +279,7 @@ static int arch_build_bp_info(struct perf_event *bp,
 			hw->len = X86_BREAKPOINT_LEN_X;
 			return 0;
 		}
+		/* fall through */
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 5db08425063e..4ff6b4cdb941 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -467,6 +467,7 @@ int kgdb_arch_handle_exception(int e_vector, int signo, int err_code,
 		ptr = &remcomInBuffer[1];
 		if (kgdb_hex2long(&ptr, &addr))
 			linux_regs->ip = addr;
+		/* fall through */
 	case 'D':
 	case 'k':
 		/* clear the trace bit */
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 843feb94a950..ccf03416e434 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -745,6 +745,7 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 		 * OPCODE1() of the "short" jmp which checks the same condition.
 		 */
 		opc1 = OPCODE2(insn) - 0x10;
+		/* fall through */
 	default:
 		if (!is_cond_jmp_opcode(opc1))
 			return -ENOSYS;
