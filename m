Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37107C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 10:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F062320883
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 10:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F062320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbeKJUgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 15:36:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35015 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbeKJUgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 15:36:39 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAAApuHt2757105
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 10 Nov 2018 02:51:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAAApuag2757102;
        Sat, 10 Nov 2018 02:51:56 -0800
Date:   Sat, 10 Nov 2018 02:51:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-d813dfb28641306f66cf1e2c3586f39ab4f84b27@git.kernel.org>
Cc:     wang.yi59@zte.com.cn, bp@suse.de, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, matz@suse.de, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
          wang.yi59@zte.com.cn, bp@suse.de, linux-kernel@vger.kernel.org,
          matz@suse.de
In-Reply-To: <alpine.DEB.2.21.1811081633160.1549@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1811081633160.1549@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Fix -Wmissing-prototypes warnings
Git-Commit-ID: d813dfb28641306f66cf1e2c3586f39ab4f84b27
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

Commit-ID:  d813dfb28641306f66cf1e2c3586f39ab4f84b27
Gitweb:     https://git.kernel.org/tip/d813dfb28641306f66cf1e2c3586f39ab4f84b27
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 9 Nov 2018 23:13:13 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 10 Nov 2018 11:19:16 +0100

x86/mce: Fix -Wmissing-prototypes warnings

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
---
 arch/x86/kernel/cpu/mcheck/mce_amd.c     | 3 ++-
 arch/x86/kernel/cpu/mcheck/therm_throt.c | 3 ++-
 arch/x86/kernel/cpu/mcheck/threshold.c   | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index dd33c357548f..87499b997039 100644
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
diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
index 2da67b70ba98..8a2a842d1a72 100644
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
+asmlinkage __visible void __irq_entry smp_thermal_interrupt(void)
 {
 	entering_irq();
 	trace_thermal_apic_entry(THERMAL_APIC_VECTOR);
diff --git a/arch/x86/kernel/cpu/mcheck/threshold.c b/arch/x86/kernel/cpu/mcheck/threshold.c
index 2b584b319eff..b0c60beb6312 100644
--- a/arch/x86/kernel/cpu/mcheck/threshold.c
+++ b/arch/x86/kernel/cpu/mcheck/threshold.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 
 #include <asm/irq_vectors.h>
+#include <asm/traps.h>
 #include <asm/apic.h>
 #include <asm/mce.h>
 #include <asm/trace/irq_vectors.h>
