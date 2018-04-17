Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/TGUL5KT2CpQ9i9w8OCurqkeQBk4bbowzx7klCIrTu2ve7vKeWGlv5FFZ9XHvdfB3ytWnK
ARC-Seal: i=1; a=rsa-sha256; t=1523981377; cv=none;
        d=google.com; s=arc-20160816;
        b=jm/NXpS4CpfJruFEmtlCHZnQcbTlkQab7aOi5WAPGSOlUqr0MxjxqPLC2kiDLkM1uA
         HDJJLOlqUWvPpjfh0uvD/jMroHlViMtyvOSpIS0vIkdTdVv0ARNRlpO1e36S9OrlBtEk
         49pai7sj7C/goBKnSlZ1jxUWrc/dY3HhjihjA/nKxstx8Hrz4VETPzWKuT7GDoj9iEbc
         8rfU1GlN2RAR/4hjx4iYWKdqlOsQno/fDgsGgx3ONZGCnmEvxced3nvtIqu2pXXSYlnf
         Io86FRScIqDX7ZXhzz4xUxrvCGZjdsAw8GaInSlUtOdWNJ6x2npc2cSo6xsr64hhs4oJ
         F8oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DCz/WwByDbruCaXTvJphaOvtQ1oLFIjtshS9XSvAro0=;
        b=bHVPefe1t5dNDRBt3DUoU9kXvYOxtzJzuvbMd550i40kyuhSWwVRsspigCsiMNrlrS
         vg7N191ucHVcqI90n0064HFCi+rtVUO+CPnVWOPn83p9v6avid5bTAtbI19L/LSOvA8D
         KwyvvUAQikBHyB/HVIRi3vYSIdK0AU/xOgMC2TeTBzvWhkzwpjbsDT71VachRR0tQGmZ
         Wpsa6iAus4/QPYkHBKPW4T0GO96ooQ6BUbZLzTdHkB1kqsF/E1qWu+0GlA/ZMOS857BV
         Z5RTDeltdZbQ0BkMu2AeM2PS0sfR123ESYaCwQEs0mQ8fz2ZWXNeSB6S6pEBU22YKrbE
         GjLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Christoffer Dall <christoffer.dall@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 43/66] arm64: KVM: Report SMCCC_ARCH_WORKAROUND_1 BP hardening support
Date: Tue, 17 Apr 2018 17:59:16 +0200
Message-Id: <20180417155647.744959583@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010296822899917?=
X-GMAIL-MSGID: =?utf-8?q?1598010296822899917?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Marc Zyngier <marc.zyngier@arm.com>

commit 6167ec5c9145cdf493722dfd80a5d48bafc4a18a upstream.

A new feature of SMCCC 1.1 is that it offers firmware-based CPU
workarounds. In particular, SMCCC_ARCH_WORKAROUND_1 provides
BP hardening for CVE-2017-5715.

If the host has some mitigation for this issue, report that
we deal with it using SMCCC_ARCH_WORKAROUND_1, as we apply the
host workaround on every guest exit.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[v4.9: account for files moved to virt/ upstream]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/kvm_host.h   |    6 ++++++
 arch/arm/kvm/psci.c               |    9 ++++++++-
 arch/arm64/include/asm/kvm_host.h |    5 +++++
 include/linux/arm-smccc.h         |    5 +++++
 4 files changed, 24 insertions(+), 1 deletion(-)

--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -318,4 +318,10 @@ static inline int kvm_arm_vcpu_arch_has_
 	return -ENXIO;
 }
 
+static inline bool kvm_arm_harden_branch_predictor(void)
+{
+	/* No way to detect it yet, pretend it is not there. */
+	return false;
+}
+
 #endif /* __ARM_KVM_HOST_H__ */
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -403,13 +403,20 @@ int kvm_hvc_call_handler(struct kvm_vcpu
 {
 	u32 func_id = smccc_get_function(vcpu);
 	u32 val = PSCI_RET_NOT_SUPPORTED;
+	u32 feature;
 
 	switch (func_id) {
 	case ARM_SMCCC_VERSION_FUNC_ID:
 		val = ARM_SMCCC_VERSION_1_1;
 		break;
 	case ARM_SMCCC_ARCH_FEATURES_FUNC_ID:
-		/* Nothing supported yet */
+		feature = smccc_get_arg1(vcpu);
+		switch(feature) {
+		case ARM_SMCCC_ARCH_WORKAROUND_1:
+			if (kvm_arm_harden_branch_predictor())
+				val = 0;
+			break;
+		}
 		break;
 	default:
 		return kvm_psci_call(vcpu);
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -393,4 +393,9 @@ static inline void __cpu_init_stage2(voi
 		  "PARange is %d bits, unsupported configuration!", parange);
 }
 
+static inline bool kvm_arm_harden_branch_predictor(void)
+{
+	return cpus_have_cap(ARM64_HARDEN_BRANCH_PREDICTOR);
+}
+
 #endif /* __ARM64_KVM_HOST_H__ */
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -73,6 +73,11 @@
 			   ARM_SMCCC_SMC_32,				\
 			   0, 1)
 
+#define ARM_SMCCC_ARCH_WORKAROUND_1					\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   0, 0x8000)
+
 #ifndef __ASSEMBLY__
 
 #include <linux/linkage.h>
