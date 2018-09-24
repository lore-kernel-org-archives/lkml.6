Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A605DECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696FD214FE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696FD214FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbeIXTdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:33:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48504 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730354AbeIXTdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:33:19 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BCF7D70186710;
        Mon, 24 Sep 2018 21:31:05 +0800 (CST)
Received: from SHA150392835-N.china.huawei.com (10.45.48.175) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Mon, 24 Sep 2018 21:30:57 +0800
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     <christoffer.dall@arm.com>, <marc.zyngier@arm.com>,
        <james.morse@arm.com>, <drjones@redhat.com>,
        <peter.maydell@linaro.org>, <linux@armlinux.org.uk>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <gengdongjiu@huawei.com>
Subject: [PATCH 1/2] arm/arm64: KVM: rename function kvm_arch_dev_ioctl_check_extension()
Date:   Mon, 24 Sep 2018 21:29:59 +0800
Message-ID: <20180924133000.10244-2-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.11.0.windows.1
In-Reply-To: <20180924133000.10244-1-gengdongjiu@huawei.com>
References: <20180924133000.10244-1-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.45.48.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename kvm_arch_dev_ioctl_check_extension() to
kvm_arch_vm_ioctl_check_extension(), because it does
not have any relationship with device.

Cc: James Morse <james.morse@arm.com> 
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
I remeber James also mentioned that rename this function.

---
 arch/arm/include/asm/kvm_host.h   | 2 +-
 arch/arm64/include/asm/kvm_host.h | 2 +-
 arch/arm64/kvm/reset.c            | 4 ++--
 virt/kvm/arm/arm.c                | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 3ad482d..3ee29db 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -273,7 +273,7 @@ static inline void __cpu_init_stage2(void)
 	kvm_call_hyp(__init_stage2_translation);
 }
 
-static inline int kvm_arch_dev_ioctl_check_extension(struct kvm *kvm, long ext)
+static inline int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 {
 	return 0;
 }
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 3d6d733..c20537f 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -53,7 +53,7 @@
 
 int __attribute_const__ kvm_target_cpu(void);
 int kvm_reset_vcpu(struct kvm_vcpu *vcpu);
-int kvm_arch_dev_ioctl_check_extension(struct kvm *kvm, long ext);
+int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext);
 void __extended_idmap_trampoline(phys_addr_t boot_pgd, phys_addr_t idmap_start);
 
 struct kvm_arch {
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index e37c78b..fd37c53 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -55,12 +55,12 @@ static bool cpu_has_32bit_el1(void)
 }
 
 /**
- * kvm_arch_dev_ioctl_check_extension
+ * kvm_arch_vm_ioctl_check_extension
  *
  * We currently assume that the number of HW registers is uniform
  * across all CPUs (see cpuinfo_sanity_check).
  */
-int kvm_arch_dev_ioctl_check_extension(struct kvm *kvm, long ext)
+int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 {
 	int r;
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index c92053b..40e79ea 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -240,7 +240,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = 1;
 		break;
 	default:
-		r = kvm_arch_dev_ioctl_check_extension(kvm, ext);
+		r = kvm_arch_vm_ioctl_check_extension(kvm, ext);
 		break;
 	}
 	return r;
-- 
1.9.1


