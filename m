Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224/qaSf3ksViAhAIPpGsciDLy+uki0ZzHzNxg3hxWJql91KoC2APuD6Q6uFb0E8UPP5BkRf
ARC-Seal: i=1; a=rsa-sha256; t=1518708791; cv=none;
        d=google.com; s=arc-20160816;
        b=PSEpJYqZWZ5+OekS7wK/JRmCfKbtFne2oCYT6uPDJoh8mPxOBQeafEDCl6ejd6pUlx
         c4i/pApaMwXfM1rzz5eHGUQSZgb/+KDSRxd7XuTJNjzqHEX0aGDHfuH2ADXU4OSTybpL
         DqAm4jwP+IibJz6TyCglZxzQVk3fDo47p71OUv8RG96U2/xSxQnjDPI29NB8G3zYPdMv
         y6PMQboEB2aZZA0DRKGdAGZi2Z5/aPROyVb11K+Nr/NlBgazYYE4jU65ztwDCu1o6FKF
         +plM90bqIbrkSvysW6bfEuhzmKPgM6Qz6wJpP6GRVrfKv23Zj/FK+6Ly0Cp68mRaar6Z
         5YZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3OBxOFFEXbYbZhBK9wwwAGgS7RX47Litr4a+/A8EBVs=;
        b=vnlgpuPW3u1SpDTU8NJs1RaLzHcia62X9SnGvwROFkQszqtfl4N6PzOxDQ8kruW87+
         cYfkmA1phKqHle+nD/no6H8jvc+gnlSkf31vipgLont+D30qPY7tIw604Di65m1NniyU
         VF6jSWyYhr+GAtONZMLWYPA1KA85IHEruuZlVlS39JdeD4TYYV+XHEX5+HVqiy0Rf0lt
         0s+xoYnaYMIrVsXcAHvxR9ufBGo+VYnR+lJlrFwU8OF02614CDhyjgoPndO6nEdMo4yP
         qysgX0d3mudcTbNFFuVutfLTYOOjNJdZJ6xHlzZvsIdO2Dc0phSF81vsSY6jso6uAIuT
         MGxA==
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
Subject: [PATCH 4.14 080/195] [Variant 2/Spectre-v2] arm/arm64: KVM: Consolidate the PSCI include files
Date: Thu, 15 Feb 2018 16:16:11 +0100
Message-Id: <20180215151709.695367923@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481589033335801?=
X-GMAIL-MSGID: =?utf-8?q?1592481589033335801?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
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
@@ -29,6 +29,7 @@
 #include <linux/kvm.h>
 #include <trace/events/kvm.h>
 #include <kvm/arm_pmu.h>
+#include <kvm/arm_psci.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -44,7 +45,6 @@
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
