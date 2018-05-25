Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754729AbeEYRQq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 13:16:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751509AbeEYRQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 13:16:45 -0400
From: Waiman Long <longman@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] x86/KVM: Fix incorrect SSBD bit in kvm_cpuid_7_0_edx_x86_features
Date: Fri, 25 May 2018 13:16:24 -0400
Message-Id: <1527268584-752-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the SSBD bit in kvm_cpuid_7_0_edx_x86_features has been renamed to
SPEC_CTRL_SSBD in the commit 52817587e706 ("x86/cpufeatures: Disentangle
SSBD enumeration"). The corresponding name change needed to be made in
the KVM code as well.

Fixes: 52817587e706 ("x86/cpufeatures: Disentangle SSBD enumeration")

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/kvm/cpuid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index ced8511..598461e 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -407,8 +407,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 
 	/* cpuid 7.0.edx*/
 	const u32 kvm_cpuid_7_0_edx_x86_features =
-		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) | F(SSBD) |
-		F(ARCH_CAPABILITIES);
+		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
+		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES);
 
 	/* all calls to cpuid_count() should be made on the same cpu */
 	get_cpu();
-- 
1.8.3.1
