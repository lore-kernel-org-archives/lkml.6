Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203B4C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E021621906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358594;
	bh=+3l5PeRclh3BYlP1TMTU7nPg0CttrotEw3PWh2rjgAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hHsAqKIELBLGjjCUTzwx1uo5NxD0Gv81OYpkdeggRj3XwnAaAP+shZg6H6b9I++jR
	 PbUr8FV+Ij3tTsauYq3FNnKax1CPCM4rnxVH9H+JuQFWF+bhvqgRDpM7SdqVs+kp88
	 x/3Evj4sYPzHrPP9jFmu/uTibar4rcxTD2vrpgNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbfAXTgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:36:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732510AbfAXTg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:36:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55A58218FC;
        Thu, 24 Jan 2019 19:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358587;
        bh=+3l5PeRclh3BYlP1TMTU7nPg0CttrotEw3PWh2rjgAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zBUZyxq1ppxfDobVsiVoph3Dh7bObvN4+WwC7sbTkWUFD6dh2yd/LylAXHeQof+/L
         JLOshnpzAgv3DSCkeA+qov+qaEVG2L3mO5VHoIg5WeVO18TL6+p0MuD3gVHKOq1qnG
         Lr2xF7Uh9Ipfa2Gjp1qWJmdrWH7k+IMsi3m4ujOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Yi Wang <wang.yi59@zte.com.cn>, Michael Matz <matz@suse.de>,
        x86@kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 024/106] x86/mce: Fix -Wmissing-prototypes warnings
Date:   Thu, 24 Jan 2019 20:19:41 +0100
Message-Id: <20190124190207.886943656@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 68b5e4326e4b8ac9080835005d8254fed0fb3c56 ]

Add the proper includes and make smca_get_name() static.

Fix an actual bug too which the warning triggered:

  arch/x86/kernel/cpu/mcheck/therm_throt.c:395:39: error: conflicting \
  types for ‘smp_thermal_interrupt’
   asmlinkage __visible void __irq_entry smp_thermal_interrupt(struct pt_regs *r)
                                         ^~~~~~~~~~~~~~~~~~~~~
  In file included from arch/x86/kernel/cpu/mcheck/therm_throt.c:29:
  ./arch/x86/include/asm/traps.h:107:17: note: previous declaration of \
	  ‘smp_thermal_interrupt’ was here
   asmlinkage void smp_thermal_interrupt(void);

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Yi Wang <wang.yi59@zte.com.cn>
Cc: Michael Matz <matz@suse.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1811081633160.1549@nanos.tec.linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/traps.h             | 6 +++---
 arch/x86/kernel/cpu/mcheck/mce_amd.c     | 5 +++--
 arch/x86/kernel/cpu/mcheck/therm_throt.c | 3 ++-
 arch/x86/kernel/cpu/mcheck/threshold.c   | 3 ++-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 3de69330e6c5..afbc87206886 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -104,9 +104,9 @@ extern int panic_on_unrecovered_nmi;
 
 void math_emulate(struct math_emu_info *);
 #ifndef CONFIG_X86_32
-asmlinkage void smp_thermal_interrupt(void);
-asmlinkage void smp_threshold_interrupt(void);
-asmlinkage void smp_deferred_error_interrupt(void);
+asmlinkage void smp_thermal_interrupt(struct pt_regs *regs);
+asmlinkage void smp_threshold_interrupt(struct pt_regs *regs);
+asmlinkage void smp_deferred_error_interrupt(struct pt_regs *regs);
 #endif
 
 extern void ist_enter(struct pt_regs *regs);
diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index e12454e21b8a..9f915a8791cc 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -23,6 +23,7 @@
 #include <linux/string.h>
 
 #include <asm/amd_nb.h>
+#include <asm/traps.h>
 #include <asm/apic.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
@@ -99,7 +100,7 @@ static u32 smca_bank_addrs[MAX_NR_BANKS][NR_BLOCKS] __ro_after_init =
 	[0 ... MAX_NR_BANKS - 1] = { [0 ... NR_BLOCKS - 1] = -1 }
 };
 
-const char *smca_get_name(enum smca_bank_types t)
+static const char *smca_get_name(enum smca_bank_types t)
 {
 	if (t >= N_SMCA_BANK_TYPES)
 		return NULL;
@@ -824,7 +825,7 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 	mce_log(&m);
 }
 
-asmlinkage __visible void __irq_entry smp_deferred_error_interrupt(void)
+asmlinkage __visible void __irq_entry smp_deferred_error_interrupt(struct pt_regs *regs)
 {
 	entering_irq();
 	trace_deferred_error_apic_entry(DEFERRED_ERROR_VECTOR);
diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
index 2da67b70ba98..ee229ceee745 100644
--- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
@@ -25,6 +25,7 @@
 #include <linux/cpu.h>
 
 #include <asm/processor.h>
+#include <asm/traps.h>
 #include <asm/apic.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
@@ -390,7 +391,7 @@ static void unexpected_thermal_interrupt(void)
 
 static void (*smp_thermal_vector)(void) = unexpected_thermal_interrupt;
 
-asmlinkage __visible void __irq_entry smp_thermal_interrupt(struct pt_regs *r)
+asmlinkage __visible void __irq_entry smp_thermal_interrupt(struct pt_regs *regs)
 {
 	entering_irq();
 	trace_thermal_apic_entry(THERMAL_APIC_VECTOR);
diff --git a/arch/x86/kernel/cpu/mcheck/threshold.c b/arch/x86/kernel/cpu/mcheck/threshold.c
index 2b584b319eff..c21e0a1efd0f 100644
--- a/arch/x86/kernel/cpu/mcheck/threshold.c
+++ b/arch/x86/kernel/cpu/mcheck/threshold.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 
 #include <asm/irq_vectors.h>
+#include <asm/traps.h>
 #include <asm/apic.h>
 #include <asm/mce.h>
 #include <asm/trace/irq_vectors.h>
@@ -18,7 +19,7 @@ static void default_threshold_interrupt(void)
 
 void (*mce_threshold_vector)(void) = default_threshold_interrupt;
 
-asmlinkage __visible void __irq_entry smp_threshold_interrupt(void)
+asmlinkage __visible void __irq_entry smp_threshold_interrupt(struct pt_regs *regs)
 {
 	entering_irq();
 	trace_threshold_apic_entry(THRESHOLD_APIC_VECTOR);
-- 
2.19.1



