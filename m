Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751158AbeDQEoX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 00:44:23 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:51550 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeDQEoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 00:44:21 -0400
X-IronPort-AV: E=Sophos;i="5.48,462,1517875200";
   d="scan'208";a="735647716"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH] x86/headers/UAPI: Move DISABLE_EXITS KVM capability bits to the UAPI
Date: Tue, 17 Apr 2018 06:43:58 +0200
Message-Id: <1523940238-10863-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move DISABLE_EXITS KVM capability bits to the UAPI just like the rest of
capabilities.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: x86@kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/x86.h       | 7 -------
 include/uapi/linux/kvm.h | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 98d3503..acb1502 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -303,13 +303,6 @@ static inline u64 nsec_to_cycles(struct kvm_vcpu *vcpu, u64 nsec)
 	    __rem;						\
 	 })
 
-#define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
-#define KVM_X86_DISABLE_EXITS_HTL            (1 << 1)
-#define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
-#define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT | \
-                                              KVM_X86_DISABLE_EXITS_HTL | \
-                                              KVM_X86_DISABLE_EXITS_PAUSE)
-
 static inline bool kvm_mwait_in_guest(struct kvm *kvm)
 {
 	return kvm->arch.mwait_in_guest;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index aefaf6c..077d16f 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -676,6 +676,13 @@ struct kvm_ioeventfd {
 	__u8  pad[36];
 };
 
+#define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
+#define KVM_X86_DISABLE_EXITS_HTL            (1 << 1)
+#define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
+#define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT | \
+                                              KVM_X86_DISABLE_EXITS_HTL | \
+                                              KVM_X86_DISABLE_EXITS_PAUSE)
+
 /* for KVM_ENABLE_CAP */
 struct kvm_enable_cap {
 	/* in */
-- 
2.7.4
