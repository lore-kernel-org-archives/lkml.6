Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387525-1519633900-2-8632632053775624099
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: to='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519633900; b=jRFb63jo4HahqhxzDk4xyRzNsafX1yJNoiAw3n3FPC/uTTk
    1zU87hoSJJmlv3mMALyHX5Zb7MX5Arpx3jZNKeI/+Cbcv8pdhEe0O63S9UChgejf
    Nuzp2AGlmXStwyciydGP8fpsILBYPl+SnnfUFO2ZGZG+5o9Kq0H1KYMOG/g+/nho
    GUNCf72eAbzfg93OzArR1ZpfNxKwaf+P4vF/Lei8jNE1t8OjI+Sp4vZOx26GbSK9
    PEcqNK+mOdopZbuwGO8mJmG+iXm4H4ievoZKanbXRV2e8/v9xQInBcv3vSkD2x3b
    DPwRUuK64vnosVI4NpiIVsW6IpwwG8CqmCV4RvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633900;
    bh=KviX1yLvB2tH9OuAASVpED/B9xVdJyxLoOBcpgguMMM=; b=fHTx/EADdUvA
    jPi6rqRVyuGeWuHOvSnPyf3S4HSszjSS6luOMbVq61z1OyZ9hHZBLnqRdRYM2fzv
    y7DK+nkQN9BCzlWOtnsqyKQS/fbgVDCuYim2qkPjQg4IWfZODu/G1xq6Py2guG/v
    nVihsjJbAP5Klw2LpX7g6qXOlERU4t5+MGcgqafFY5jCtUclavSaNHa95iB3uZiM
    aabKihq/Z5wM2PS7E2sRuF4dUDqHg/5rSwh8hcBRM+x1JCqhY2NV13wsi+oZreNK
    5un49nwEv0X7HgEKY2sPOyg6e8I7d1OR/ErBoKYVHxTKYmVj+pnQR+lAv+JHiyXz
    Yy+u+rf4WA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=cT9Fkj5j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tFJjROc8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=cT9Fkj5j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tFJjROc8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbeBZIY6 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:24:58 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40699 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752329AbeBZIYx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:24:53 -0500
X-Google-Smtp-Source: AH8x227zw1Bv31BKBQO9wj+rlsRzDfA/aR6UyiNYcMmg8Yk51c11BYDQl/Lh9qxYTC6+iNf2pl/qwQ==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org (moderated list:KERNEL VIRTUAL
        MACHINE (KVM) FOR ARM),
        kvmarm@lists.cs.columbia.edu (open list:KERNEL VIRTUAL MACHINE (KVM)
        FOR ARM),
        kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE (KVM)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 31/52] arm/arm64: KVM: Consolidate the PSCI include files
Date: Mon, 26 Feb 2018 16:20:05 +0800
Message-Id: <1519633227-29832-32-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
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

Conflicts:
	need kvm/arm_psci.h in files:
	arch/arm64/kvm/handle_exit.c
	arch/arm/kvm/psci.c and arch/arm/kvm/arm.c
	no virt/kvm/arm/arm.c and virt/kvm/arm/psci.c
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
