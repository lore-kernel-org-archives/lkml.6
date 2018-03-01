Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2898263-1519909428-2-980897069414800887
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519909427; b=o4iWK7333zuSsqzfw4kSHL8XMD7jUKtYfZgJCJW1Y6YMs7/
    UM8Ggf1V/H5otIav+a0l/JxeVZ4uqu/B39TqF8BTv1e31pUu54afCVkvXmbAj0Hl
    eYXCvUgl2HGJgLc0Y7UEnXbIA0my+X8SYRIn17QPIYscdsgMjsfJLrh+chAM7U9A
    m3qV+/lsslgTNDl0u06rDOTo29r0Ck5KP8uEm5MsnCwp7sEjJD1Dj6iQ9pdunTu4
    VBuOrXgj/cLYgznQGRmx2EpSFdXEa7crLeddd73c9LABOHvb/WL0iklbd5HP3Xaj
    Q/tkAyVMuolTrwHxS1bPitD5CYdWXiG1zvJbNGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909427;
    bh=iXQ1ea6Hf/00SPSEn2cgvnnJnEbrG1bOJUxh9KRtS1o=; b=sX9SBcNjI3I2
    OCcv34UxJbcivoriHnzoIAIpwIBkiUc1jUAmXJ8wQdclKSM+XO0CWVBz8cSCzqOk
    4Tfj450ceK2yTIN6SwBWwY628TxvcsndLLTvL0Kwk8p7NgoA1fqLTXxntFAdLU15
    MatwipnQOHx8vqkiqY22Va+elsoGmDrsRfGxuXl0C0H+MnYHQQRuqL3IWJVPLdDh
    3SGCUmZmGs0xvc4ZTQfeW20tjEiFLeJCybj1hg8omPuwYgjA7ZBRX/P2Rkxa0Wpa
    NIYK+7Fr9vk1PC/iqwN83czFAGwl78R2C5kYaNkXqArjWHTdeVtfNu8fYVduzgv2
    b+cuwNAgDQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=HPw8khHD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=f7ky6Z5s;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=HPw8khHD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=f7ky6Z5s;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030881AbeCAM7i (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 07:59:38 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34449 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031016AbeCAM7g (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:59:36 -0500
X-Google-Smtp-Source: AG47ELuaIS0jmjIJ964QvMLYBcaW4Yqs4FXIAO3qBMWT2ePiR12CuhHRUkMNgkMcy0Kmj8LRBMpJWA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 31/45] arm/arm64: KVM: Consolidate the PSCI include files
Date: Thu,  1 Mar 2018 20:54:08 +0800
Message-Id: <1519908862-11425-32-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

commit 1a2fb94e6a77 upstream.

As we're about to update the PSCI support, and because I'm lazy,
let's move the PSCI include file to include/kvm so that both
ARM architectures can find it.

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm/include/asm/kvm_psci.h   | 27 ---------------------------
 arch/arm/kvm/arm.c                |  2 +-
 arch/arm/kvm/handle_exit.c        |  2 +-
 arch/arm/kvm/psci.c               |  2 +-
 arch/arm64/include/asm/kvm_psci.h | 27 ---------------------------
 arch/arm64/kvm/handle_exit.c      |  3 ++-
 include/kvm/arm_psci.h            | 27 +++++++++++++++++++++++++++
 7 files changed, 32 insertions(+), 58 deletions(-)
 delete mode 100644 arch/arm/include/asm/kvm_psci.h
 delete mode 100644 arch/arm64/include/asm/kvm_psci.h
 create mode 100644 include/kvm/arm_psci.h

diff --git a/arch/arm/include/asm/kvm_psci.h b/arch/arm/include/asm/kvm_psci.h
deleted file mode 100644
index 6bda945..0000000
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
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 4e4ae07..8588e67 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -44,8 +44,8 @@
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_coproc.h>
-#include <asm/kvm_psci.h>
 #include <asm/sections.h>
+#include <kvm/arm_psci.h>
 
 #ifdef REQUIRES_VIRT
 __asm__(".arch_extension	virt");
diff --git a/arch/arm/kvm/handle_exit.c b/arch/arm/kvm/handle_exit.c
index 4e57ebc..0a2b758 100644
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
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index a08d7a9..18f9e9d 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -21,8 +21,8 @@
 
 #include <asm/cputype.h>
 #include <asm/kvm_emulate.h>
-#include <asm/kvm_psci.h>
 #include <asm/kvm_host.h>
+#include <kvm/arm_psci.h>
 
 #include <uapi/linux/psci.h>
 
diff --git a/arch/arm64/include/asm/kvm_psci.h b/arch/arm64/include/asm/kvm_psci.h
deleted file mode 100644
index bc39e55..0000000
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
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 5b56b09..0231ebc 100644
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
diff --git a/include/kvm/arm_psci.h b/include/kvm/arm_psci.h
new file mode 100644
index 0000000..2042bb9
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
-- 
2.7.4
