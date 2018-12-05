Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA37C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5B42084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="e7I/jChQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5B42084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeLEONh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:13:37 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39776 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727094AbeLEONg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:13:36 -0500
Received: from zn.tnic (p200300EC2BC09900B100099FAFCBAE1B.dip0.t-ipconnect.de [IPv6:2003:ec:2bc0:9900:b100:99f:afcb:ae1b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ABD071EC0B7A;
        Wed,  5 Dec 2018 15:13:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544019214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=tvk5nQC9MlcxU15qcdiZbqhHr+dwZOjB6FcSx9WQ1Q0=;
        b=e7I/jChQ5LoyDUsut+K3xSlWk8H93ag/ioHKx9LBrpp9KACqMXHxLaFromZsGOz1Jnhc/v
        uosaAI6Dc9S3NNdTTzPOUG/EUloVycdjgzXTVq5y+e19vXztM+Yc+uJg/LCA79P+G9Az0j
        v8wRPCIGnQgPXhu/1MZXWs1vtzPk7nw=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, X86 ML <x86@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: [PATCH] x86/mce: Streamline MCE subsystem's naming
Date:   Wed,  5 Dec 2018 15:13:23 +0100
Message-Id: <20181205141323.14995-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

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
---
 arch/x86/kernel/cpu/Makefile                           |  2 +-
 arch/x86/kernel/cpu/{mcheck => mce}/Makefile           | 10 +++++-----
 arch/x86/kernel/cpu/{mcheck/mce_amd.c => mce/amd.c}    |  2 +-
 arch/x86/kernel/cpu/{mcheck/mce-apei.c => mce/apei.c}  |  2 +-
 arch/x86/kernel/cpu/{mcheck/mce.c => mce/core.c}       |  2 +-
 arch/x86/kernel/cpu/{mcheck => mce}/dev-mcelog.c       |  2 +-
 .../kernel/cpu/{mcheck/mce-genpool.c => mce/genpool.c} |  2 +-
 .../kernel/cpu/{mcheck/mce-inject.c => mce/inject.c}   |  2 +-
 .../x86/kernel/cpu/{mcheck/mce_intel.c => mce/intel.c} |  2 +-
 .../cpu/{mcheck/mce-internal.h => mce/internal.h}      |  0
 arch/x86/kernel/cpu/{mcheck => mce}/p5.c               |  0
 .../cpu/{mcheck/mce-severity.c => mce/severity.c}      |  2 +-
 arch/x86/kernel/cpu/{mcheck => mce}/therm_throt.c      |  0
 arch/x86/kernel/cpu/{mcheck => mce}/threshold.c        |  0
 arch/x86/kernel/cpu/{mcheck => mce}/winchip.c          |  0
 15 files changed, 14 insertions(+), 14 deletions(-)
 rename arch/x86/kernel/cpu/{mcheck => mce}/Makefile (52%)
 rename arch/x86/kernel/cpu/{mcheck/mce_amd.c => mce/amd.c} (99%)
 rename arch/x86/kernel/cpu/{mcheck/mce-apei.c => mce/apei.c} (99%)
 rename arch/x86/kernel/cpu/{mcheck/mce.c => mce/core.c} (99%)
 rename arch/x86/kernel/cpu/{mcheck => mce}/dev-mcelog.c (99%)
 rename arch/x86/kernel/cpu/{mcheck/mce-genpool.c => mce/genpool.c} (99%)
 rename arch/x86/kernel/cpu/{mcheck/mce-inject.c => mce/inject.c} (99%)
 rename arch/x86/kernel/cpu/{mcheck/mce_intel.c => mce/intel.c} (99%)
 rename arch/x86/kernel/cpu/{mcheck/mce-internal.h => mce/internal.h} (100%)
 rename arch/x86/kernel/cpu/{mcheck => mce}/p5.c (100%)
 rename arch/x86/kernel/cpu/{mcheck/mce-severity.c => mce/severity.c} (99%)
 rename arch/x86/kernel/cpu/{mcheck => mce}/therm_throt.c (100%)
 rename arch/x86/kernel/cpu/{mcheck => mce}/threshold.c (100%)
 rename arch/x86/kernel/cpu/{mcheck => mce}/winchip.c (100%)

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
-- 
2.19.1

