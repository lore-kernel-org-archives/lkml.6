Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226AkIEAAG6sMmhHpCD9TNMKg1veVFp3R1iWW94Q/nrnEBcftMKU7nBN1l+AgFEiIxfn4hhz
ARC-Seal: i=1; a=rsa-sha256; t=1518709314; cv=none;
        d=google.com; s=arc-20160816;
        b=YJM9QZnBBvO+8WqxjVLmcQkZdDlqm/IhWYiN0C50GMsHLc54B1j2k63daaijj6Ascq
         32b2RDpDJ9erk92F8oZ4wC84QbTyzTFGrDaYFte2+6ap9J6OeN6/D5WvraHFpK9CeXwq
         GMGe+aAPL+MlDBp6wYXWDycBKb5RNoPwSZWpRyaEo249OfXiAjuobbfkbKkq76xDYrXr
         2tdikzijUIkQDAQCzuW3cX/y02YqjGKpSSdat2Z2GsqfsCanI73+64lUMSUFZ82JoL4k
         eCs2ihzu5Fy+KwH/5sDsv2Bd7XlKJulP4xmEwUsbc92ZFyGrAau/iOgVQUxT1lWREY2K
         +8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mhwZv/Rr4alq4s5TIX7xDu+mqXx8TdpxUocbb149jvc=;
        b=SUGqGRELOOuQsVakem1MNfC5mrH0lUOCoE9bRkMkFK2P/rrHHIy4qoD8/YOPLQP7gy
         iFRI0igIgRpsEc/CQnuX4/0yiOFE1AfQPTUpD2WDx0w2lrxLtPMp7IdnkMptowchshIq
         aRpuTCAEQ1S/evqAatNYmBZ/7+eeqMSlZb4qjPFeLydpsKsCFm1Vl2R4Zg5syHeHEkKv
         me4Z/VpcW34kmdRKz0IEYg1wodnKzxAq2/3064liZRfku9+6JKRJjqUNiCuwaHqrEnQz
         3zcTdoyfeNKbdykpjRDUOi9ur0qmRbsoA+PM9rajozOtNioMehN3470J2k5J/J1L3XuQ
         EGUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christoffer Dall <christoffer.dall@linaro.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 073/202] [Variant 2/Spectre-v2] arm/arm64: KVM: Consolidate the PSCI include files
Date: Thu, 15 Feb 2018 16:16:13 +0100
Message-Id: <20180215151717.305503006@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481589033335801?=
X-GMAIL-MSGID: =?utf-8?q?1592482137821577244?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit 1a2fb94e6a77 upstream.

As we're about to update the PSCI support, and because I'm lazy,
let's move the PSCI include file to include/kvm so that both
ARM architectures can find it.

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/kvm_psci.h   |   27 ---------------------------
 arch/arm/kvm/handle_exit.c        |    2 +-
 arch/arm64/include/asm/kvm_psci.h |   27 ---------------------------
 arch/arm64/kvm/handle_exit.c      |    3 ++-
 include/kvm/arm_psci.h            |   27 +++++++++++++++++++++++++++
 virt/kvm/arm/arm.c                |    2 +-
 virt/kvm/arm/psci.c               |    3 ++-
 7 files changed, 33 insertions(+), 58 deletions(-)
 delete mode 100644 arch/arm/include/asm/kvm_psci.h
 rename arch/arm64/include/asm/kvm_psci.h => include/kvm/arm_psci.h (89%)

--- a/arch/arm/include/asm/kvm_psci.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * Copyright (C) 2012 - ARM Ltd
- * Author: Marc Zyngier <marc.zyngier@arm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef __ARM_KVM_PSCI_H__
-#define __ARM_KVM_PSCI_H__
-
-#define KVM_ARM_PSCI_0_1	1
-#define KVM_ARM_PSCI_0_2	2
-
-int kvm_psci_version(struct kvm_vcpu *vcpu);
-int kvm_psci_call(struct kvm_vcpu *vcpu);
-
-#endif /* __ARM_KVM_PSCI_H__ */
--- a/arch/arm/kvm/handle_exit.c
+++ b/arch/arm/kvm/handle_exit.c
@@ -21,7 +21,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_coproc.h>
 #include <asm/kvm_mmu.h>
-#include <asm/kvm_psci.h>
+#include <kvm/arm_psci.h>
 #include <trace/events/kvm.h>
 
 #include "trace.h"
--- a/arch/arm64/include/asm/kvm_psci.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * Copyright (C) 2012,2013 - ARM Ltd
- * Author: Marc Zyngier <marc.zyngier@arm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef __ARM64_KVM_PSCI_H__
-#define __ARM64_KVM_PSCI_H__
-
-#define KVM_ARM_PSCI_0_1	1
-#define KVM_ARM_PSCI_0_2	2
-
-int kvm_psci_version(struct kvm_vcpu *vcpu);
-int kvm_psci_call(struct kvm_vcpu *vcpu);
-
-#endif /* __ARM64_KVM_PSCI_H__ */
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -22,12 +22,13 @@
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 
+#include <kvm/arm_psci.h>
+
 #include <asm/esr.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_coproc.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
-#include <asm/kvm_psci.h>
 #include <asm/debug-monitors.h>
 
 #define CREATE_TRACE_POINTS
--- /dev/null
+++ b/include/kvm/arm_psci.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2012,2013 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __KVM_ARM_PSCI_H__
+#define __KVM_ARM_PSCI_H__
+
+#define KVM_ARM_PSCI_0_1	1
+#define KVM_ARM_PSCI_0_2	2
+
+int kvm_psci_version(struct kvm_vcpu *vcpu);
+int kvm_psci_call(struct kvm_vcpu *vcpu);
+
+#endif /* __KVM_ARM_PSCI_H__ */
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -31,6 +31,7 @@
 #include <linux/irqbypass.h>
 #include <trace/events/kvm.h>
 #include <kvm/arm_pmu.h>
+#include <kvm/arm_psci.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -46,7 +47,6 @@
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_coproc.h>
-#include <asm/kvm_psci.h>
 #include <asm/sections.h>
 
 #ifdef REQUIRES_VIRT
--- a/virt/kvm/arm/psci.c
+++ b/virt/kvm/arm/psci.c
@@ -21,9 +21,10 @@
 
 #include <asm/cputype.h>
 #include <asm/kvm_emulate.h>
-#include <asm/kvm_psci.h>
 #include <asm/kvm_host.h>
 
+#include <kvm/arm_psci.h>
+
 #include <uapi/linux/psci.h>
 
 /*
