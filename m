Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932183AbeEWJBP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:01:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45689 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754378AbeEWJBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:01:12 -0400
Date: Wed, 23 May 2018 02:00:52 -0700
From: tip-bot for Konrad Rzeszutek Wilk <tipbot@zytor.com>
Message-ID: <tip-0aa48468d00959c8a37cd3ac727284f4f7359151@git.kernel.org>
Cc: hpa@zytor.com, rkrcmar@redhat.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        pbonzini@redhat.com
Reply-To: hpa@zytor.com, rkrcmar@redhat.com, konrad.wilk@oracle.com,
        pbonzini@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20180521215449.26423-2-konrad.wilk@oracle.com>
References: <20180521215449.26423-2-konrad.wilk@oracle.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] KVM/VMX: Expose SSBD properly to guests
Git-Commit-ID: 0aa48468d00959c8a37cd3ac727284f4f7359151
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0aa48468d00959c8a37cd3ac727284f4f7359151
Gitweb:     https://git.kernel.org/tip/0aa48468d00959c8a37cd3ac727284f4f7359151
Author:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
AuthorDate: Mon, 21 May 2018 17:54:49 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 23 May 2018 10:55:52 +0200

KVM/VMX: Expose SSBD properly to guests

The X86_FEATURE_SSBD is an synthetic CPU feature - that is
it bit location has no relevance to the real CPUID 0x7.EBX[31]
bit position. For that we need the new CPU feature name.

Fixes: 52817587e706 ("x86/cpufeatures: Disentangle SSBD enumeration")
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: kvm@vger.kernel.org
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: stable@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lkml.kernel.org/r/20180521215449.26423-2-konrad.wilk@oracle.com

---
 arch/x86/kvm/cpuid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index ced851169730..598461e24be3 100644
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
