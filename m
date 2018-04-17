Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/mhR+b9UIn3wausGuHm94EzsZTifCvAothQ3QklGVWXort7d5w0L9vSeXGBhfyPCTZZJSy
ARC-Seal: i=1; a=rsa-sha256; t=1523981458; cv=none;
        d=google.com; s=arc-20160816;
        b=lmvteAjEjv/NPmFa29A74y3PqNsI7H5PUl5f3LMERchifWhZ8PJgiYc+yAE5Gj4Ukq
         U/SskR81Qk0U/PRLfL8OTuEuG/3jytOEWv+VJrsFXz3PsW05LI+AWZnU/OV2P3tZprN/
         En/8J9nIBp8O4IJ8deJF2Xmq526Hz2lhUfqNs1l/Y3QH0xTjm6NcXfMG8+VAtEbmZFDR
         hHWdz1vXF0K6SM1lU8SETpNFd9U08SsOGHcDlOKWMHvdj0SX+VxE7+sW/mFAKkTT3SOp
         zsCNzen2qvh0zOZ0r974CWUfwIdtva9ea34wc2bO2cO+hCQ8hBXZM4QjzJSyqmX8X0xe
         HxTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Q8f0YuLGuBpD84cP5/gXXb66wKgkMeYvkm6OBvG7knQ=;
        b=MlAOWN+FiPuR1oxS8AJ/EnCAWUzlusUrX1gCGFsl11lCt5FMBf/cy6317+CgBHzoUP
         mPADal4gwx0xRHgr/HuYQ9ZQE5VwauQsnjPF8mz550z7x6LY1ADj9N2UEo5BI1lXgsJu
         bpvACK32bFTEBv6/zSpDO+TdKDoUsD3fUhcNlj4uLNfemW+FC2eq9Ul/Tb5JNEwgu0Ql
         VPJVIq1hHG8zKXcTXMJGHwQx2oJvLCx+togbS+D6CQWh+R/MKP7/jH5OEVGLn8W5Swqp
         Gf9+48XRb9r7hnrwNfHIRgiU/1EtNZcgYvG1g6nFkFp7glZ37qE/Cwn0q9oHbMRTdVWT
         60hA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoffer Dall <christoffer.dall@linaro.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 36/66] arm/arm64: KVM: Consolidate the PSCI include files
Date: Tue, 17 Apr 2018 17:59:09 +0200
Message-Id: <20180417155647.436281606@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010382207638535?=
X-GMAIL-MSGID: =?utf-8?q?1598010382207638535?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Marc Zyngier <marc.zyngier@arm.com>

commit 1a2fb94e6a771ff94f4afa22497a4695187b820c upstream.

As we're about to update the PSCI support, and because I'm lazy,
let's move the PSCI include file to include/kvm so that both
ARM architectures can find it.

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[v4.9: account for files moved to virt/ upstream]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/kvm_psci.h   |   27 ---------------------------
 arch/arm/kvm/arm.c                |    2 +-
 arch/arm/kvm/handle_exit.c        |    2 +-
 arch/arm/kvm/psci.c               |    3 ++-
 arch/arm64/include/asm/kvm_psci.h |   27 ---------------------------
 arch/arm64/kvm/handle_exit.c      |    5 ++++-
 include/kvm/arm_psci.h            |   27 +++++++++++++++++++++++++++
 7 files changed, 35 insertions(+), 58 deletions(-)
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
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
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
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -21,9 +21,10 @@
 
 #include <asm/cputype.h>
 #include <asm/kvm_emulate.h>
-#include <asm/kvm_psci.h>
 #include <asm/kvm_host.h>
 
+#include <kvm/arm_psci.h>
+
 #include <uapi/linux/psci.h>
 
 /*
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
@@ -22,12 +22,15 @@
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
+#include <asm/debug-monitors.h>
+#include <asm/traps.h>
 
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
