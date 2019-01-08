Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C470C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA962063F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976860;
	bh=48bQnrM6wI53NnxGDXhqzme14jKpIr6unrH/cgFCt8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a3+lQL7WSwIFC7PWM/tzxId1YyimzLjRJpB098Ntl3ddfnRlP6j9lAJIlKV/pj8Qh
	 yYG55ofwgs9hE8s/L2JtZ3swgaJ7qrfKAPRz5XM9jGGomc384/KJTcvhaNbDWa7OTL
	 +0QNwG77eRoFOzi7EP83lxD3sFsdlx6XHLEUPQyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbfAHTco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:32:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731397AbfAHTcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:32:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96CEE20645;
        Tue,  8 Jan 2019 19:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975954;
        bh=48bQnrM6wI53NnxGDXhqzme14jKpIr6unrH/cgFCt8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kyM+sjc5j1O/8XjdcjGd2dtkz3ZVAlG8avQzFxCJBh/ugQXUHNdwKyXoTndD9SCCp
         lNBoTsi3ihkgB/m8y33XwIBcm0rQsGMl4Df7ztH40ysYaZS18h9cQu45F/CozdlRIh
         frKT1ohdGAJBOb7nsHzl8RG/Fz5NrIrcWrG1eKrg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Borislav Petkov <bp@suse.de>, Yi Wang <wang.yi59@zte.com.cn>,
        Michael Matz <matz@suse.de>, x86@kernel.org,
        Sasha Levin <sashal@kernel.org>, linux-edac@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 07/53] x86/mce: Fix -Wmissing-prototypes warnings
Date:   Tue,  8 Jan 2019 14:31:35 -0500
Message-Id: <20190108193222.123316-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193222.123316-1-sashal@kernel.org>
References: <20190108193222.123316-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

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
index beec0daecbc5..4fa97a44e73f 100644
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
@@ -823,7 +824,7 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
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

