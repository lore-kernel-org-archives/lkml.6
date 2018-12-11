Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A110DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1712082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1712082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbeLKNbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:31:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57129 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeLKNbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:31:06 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBDUsuD4004708
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 05:30:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBDUrxt4004705;
        Tue, 11 Dec 2018 05:30:53 -0800
Date:   Tue, 11 Dec 2018 05:30:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-21afaf181362b4aeb5be72705d2914673b336149@git.kernel.org>
Cc:     hpa@zytor.com, bp@suse.de, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, hpa@zytor.com, bp@suse.de, tony.luck@intel.com
In-Reply-To: <20181205141323.14995-1-bp@alien8.de>
References: <20181205141323.14995-1-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Streamline MCE subsystem's naming
Git-Commit-ID: 21afaf181362b4aeb5be72705d2914673b336149
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

Commit-ID:  21afaf181362b4aeb5be72705d2914673b336149
Gitweb:     https://git.kernel.org/tip/21afaf181362b4aeb5be72705d2914673b336149
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Sun, 18 Nov 2018 15:15:05 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 5 Dec 2018 18:00:29 +0100

x86/mce: Streamline MCE subsystem's naming

Rename the containing folder to "mce" which is the most widespread name.
Drop the "mce[-_]" filename prefix of some compilation units (while
others don't have it).

This unifies the file naming in the MCE subsystem:

mce/
|-- amd.c
|-- apei.c
|-- core.c
|-- dev-mcelog.c
|-- genpool.c
|-- inject.c
|-- intel.c
|-- internal.h
|-- Makefile
|-- p5.c
|-- severity.c
|-- therm_throt.c
|-- threshold.c
`-- winchip.c

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20181205141323.14995-1-bp@alien8.de
---
 arch/x86/kernel/cpu/Makefile                                  |  2 +-
 arch/x86/kernel/cpu/{mcheck => mce}/Makefile                  | 10 +++++-----
 arch/x86/kernel/cpu/{mcheck/mce_amd.c => mce/amd.c}           |  2 +-
 arch/x86/kernel/cpu/{mcheck/mce-apei.c => mce/apei.c}         |  2 +-
 arch/x86/kernel/cpu/{mcheck/mce.c => mce/core.c}              |  2 +-
 arch/x86/kernel/cpu/{mcheck => mce}/dev-mcelog.c              |  2 +-
 arch/x86/kernel/cpu/{mcheck/mce-genpool.c => mce/genpool.c}   |  2 +-
 arch/x86/kernel/cpu/{mcheck/mce-inject.c => mce/inject.c}     |  2 +-
 arch/x86/kernel/cpu/{mcheck/mce_intel.c => mce/intel.c}       |  2 +-
 arch/x86/kernel/cpu/{mcheck/mce-internal.h => mce/internal.h} |  0
 arch/x86/kernel/cpu/{mcheck => mce}/p5.c                      |  0
 arch/x86/kernel/cpu/{mcheck/mce-severity.c => mce/severity.c} |  2 +-
 arch/x86/kernel/cpu/{mcheck => mce}/therm_throt.c             |  0
 arch/x86/kernel/cpu/{mcheck => mce}/threshold.c               |  0
 arch/x86/kernel/cpu/{mcheck => mce}/winchip.c                 |  0
 15 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 1f5d2291c31e..43afe707c6fb 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -40,7 +40,7 @@ obj-$(CONFIG_INTEL_RDT)	+= intel_rdt.o intel_rdt_rdtgroup.o intel_rdt_monitor.o
 obj-$(CONFIG_INTEL_RDT)	+= intel_rdt_ctrlmondata.o intel_rdt_pseudo_lock.o
 CFLAGS_intel_rdt_pseudo_lock.o = -I$(src)
 
-obj-$(CONFIG_X86_MCE)			+= mcheck/
+obj-$(CONFIG_X86_MCE)			+= mce/
 obj-$(CONFIG_MTRR)			+= mtrr/
 obj-$(CONFIG_MICROCODE)			+= microcode/
 
diff --git a/arch/x86/kernel/cpu/mcheck/Makefile b/arch/x86/kernel/cpu/mce/Makefile
similarity index 52%
rename from arch/x86/kernel/cpu/mcheck/Makefile
rename to arch/x86/kernel/cpu/mce/Makefile
index bcc7c54c7041..765759765ab7 100644
--- a/arch/x86/kernel/cpu/mcheck/Makefile
+++ b/arch/x86/kernel/cpu/mce/Makefile
@@ -1,14 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y				=  mce.o mce-severity.o mce-genpool.o
+obj-y				=  core.o severity.o genpool.o
 
 obj-$(CONFIG_X86_ANCIENT_MCE)	+= winchip.o p5.o
-obj-$(CONFIG_X86_MCE_INTEL)	+= mce_intel.o
-obj-$(CONFIG_X86_MCE_AMD)	+= mce_amd.o
+obj-$(CONFIG_X86_MCE_INTEL)	+= intel.o
+obj-$(CONFIG_X86_MCE_AMD)	+= amd.o
 obj-$(CONFIG_X86_MCE_THRESHOLD) += threshold.o
-obj-$(CONFIG_X86_MCE_INJECT)	+= mce-inject.o
+obj-$(CONFIG_X86_MCE_INJECT)	+= inject.o
 
 obj-$(CONFIG_X86_THERMAL_VECTOR) += therm_throt.o
 
-obj-$(CONFIG_ACPI_APEI)		+= mce-apei.o
+obj-$(CONFIG_ACPI_APEI)		+= apei.o
 
 obj-$(CONFIG_X86_MCELOG_LEGACY)	+= dev-mcelog.o
diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mce/amd.c
similarity index 99%
rename from arch/x86/kernel/cpu/mcheck/mce_amd.c
rename to arch/x86/kernel/cpu/mce/amd.c
index e12454e21b8a..4a2fb59a372e 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -28,7 +28,7 @@
 #include <asm/msr.h>
 #include <asm/trace/irq_vectors.h>
 
-#include "mce-internal.h"
+#include "internal.h"
 
 #define NR_BLOCKS         5
 #define THRESHOLD_MAX     0xFFF
diff --git a/arch/x86/kernel/cpu/mcheck/mce-apei.c b/arch/x86/kernel/cpu/mce/apei.c
similarity index 99%
rename from arch/x86/kernel/cpu/mcheck/mce-apei.c
rename to arch/x86/kernel/cpu/mce/apei.c
index 2eee85379689..1d9b3ce662a0 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -36,7 +36,7 @@
 #include <acpi/ghes.h>
 #include <asm/mce.h>
 
-#include "mce-internal.h"
+#include "internal.h"
 
 void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 {
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mce/core.c
similarity index 99%
rename from arch/x86/kernel/cpu/mcheck/mce.c
rename to arch/x86/kernel/cpu/mce/core.c
index 36d2696c9563..b0ae12cf7827 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -52,7 +52,7 @@
 #include <asm/msr.h>
 #include <asm/reboot.h>
 
-#include "mce-internal.h"
+#include "internal.h"
 
 static DEFINE_MUTEX(mce_log_mutex);
 
diff --git a/arch/x86/kernel/cpu/mcheck/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
similarity index 99%
rename from arch/x86/kernel/cpu/mcheck/dev-mcelog.c
rename to arch/x86/kernel/cpu/mce/dev-mcelog.c
index 27f394ac983f..41d9169d27fa 100644
--- a/arch/x86/kernel/cpu/mcheck/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -15,7 +15,7 @@
 #include <linux/kmod.h>
 #include <linux/poll.h>
 
-#include "mce-internal.h"
+#include "internal.h"
 
 static BLOCKING_NOTIFIER_HEAD(mce_injector_chain);
 
diff --git a/arch/x86/kernel/cpu/mcheck/mce-genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
similarity index 99%
rename from arch/x86/kernel/cpu/mcheck/mce-genpool.c
rename to arch/x86/kernel/cpu/mce/genpool.c
index 217cd4449bc9..3395549c51d3 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-genpool.c
+++ b/arch/x86/kernel/cpu/mce/genpool.c
@@ -10,7 +10,7 @@
 #include <linux/mm.h>
 #include <linux/genalloc.h>
 #include <linux/llist.h>
-#include "mce-internal.h"
+#include "internal.h"
 
 /*
  * printk() is not safe in MCE context. This is a lock-less memory allocator
diff --git a/arch/x86/kernel/cpu/mcheck/mce-inject.c b/arch/x86/kernel/cpu/mce/inject.c
similarity index 99%
rename from arch/x86/kernel/cpu/mcheck/mce-inject.c
rename to arch/x86/kernel/cpu/mce/inject.c
index 1fc424c40a31..8492ef7d9015 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -38,7 +38,7 @@
 #include <asm/nmi.h>
 #include <asm/smp.h>
 
-#include "mce-internal.h"
+#include "internal.h"
 
 /*
  * Collect all the MCi_XXX settings
diff --git a/arch/x86/kernel/cpu/mcheck/mce_intel.c b/arch/x86/kernel/cpu/mce/intel.c
similarity index 99%
rename from arch/x86/kernel/cpu/mcheck/mce_intel.c
rename to arch/x86/kernel/cpu/mce/intel.c
index d05be307d081..e43eb6732630 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -18,7 +18,7 @@
 #include <asm/msr.h>
 #include <asm/mce.h>
 
-#include "mce-internal.h"
+#include "internal.h"
 
 /*
  * Support for Intel Correct Machine Check Interrupts. This allows
diff --git a/arch/x86/kernel/cpu/mcheck/mce-internal.h b/arch/x86/kernel/cpu/mce/internal.h
similarity index 100%
rename from arch/x86/kernel/cpu/mcheck/mce-internal.h
rename to arch/x86/kernel/cpu/mce/internal.h
diff --git a/arch/x86/kernel/cpu/mcheck/p5.c b/arch/x86/kernel/cpu/mce/p5.c
similarity index 100%
rename from arch/x86/kernel/cpu/mcheck/p5.c
rename to arch/x86/kernel/cpu/mce/p5.c
diff --git a/arch/x86/kernel/cpu/mcheck/mce-severity.c b/arch/x86/kernel/cpu/mce/severity.c
similarity index 99%
rename from arch/x86/kernel/cpu/mcheck/mce-severity.c
rename to arch/x86/kernel/cpu/mce/severity.c
index 44396d521987..dc3e26e905a3 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -16,7 +16,7 @@
 #include <asm/mce.h>
 #include <linux/uaccess.h>
 
-#include "mce-internal.h"
+#include "internal.h"
 
 /*
  * Grade an mce by severity. In general the most severe ones are processed
diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
similarity index 100%
rename from arch/x86/kernel/cpu/mcheck/therm_throt.c
rename to arch/x86/kernel/cpu/mce/therm_throt.c
diff --git a/arch/x86/kernel/cpu/mcheck/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
similarity index 100%
rename from arch/x86/kernel/cpu/mcheck/threshold.c
rename to arch/x86/kernel/cpu/mce/threshold.c
diff --git a/arch/x86/kernel/cpu/mcheck/winchip.c b/arch/x86/kernel/cpu/mce/winchip.c
similarity index 100%
rename from arch/x86/kernel/cpu/mcheck/winchip.c
rename to arch/x86/kernel/cpu/mce/winchip.c
