Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935497AbeD0OPo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 10:15:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935301AbeD0OPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:15:38 -0400
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com, cdall@kernel.org,
        peter.maydell@linaro.org
Cc: andre.przywara@arm.com, drjones@redhat.com, wei@redhat.com
Subject: [PATCH v4 10/12] KVM: arm/arm64: Add KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION
Date: Fri, 27 Apr 2018 16:15:03 +0200
Message-Id: <1524838505-3823-11-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1524838505-3823-1-git-send-email-eric.auger@redhat.com>
References: <1524838505-3823-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new attribute allows the userspace to set the base address
of a reditributor region, relaxing the constraint of having all
consecutive redistibutor frames contiguous.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>

---

v3 -> v4:
- keep previous indentation for existing attributes
- added Christoffer's A-b
---
 arch/arm/include/uapi/asm/kvm.h   | 1 +
 arch/arm64/include/uapi/asm/kvm.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
index 2ba95d6..e4f243f 100644
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -91,6 +91,7 @@ struct kvm_regs {
 #define KVM_VGIC_V3_ADDR_TYPE_DIST	2
 #define KVM_VGIC_V3_ADDR_TYPE_REDIST	3
 #define KVM_VGIC_ITS_ADDR_TYPE		4
+#define KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION	5
 
 #define KVM_VGIC_V3_DIST_SIZE		SZ_64K
 #define KVM_VGIC_V3_REDIST_SIZE		(2 * SZ_64K)
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 9abbf30..df0f47c 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -91,6 +91,7 @@ struct kvm_regs {
 #define KVM_VGIC_V3_ADDR_TYPE_DIST	2
 #define KVM_VGIC_V3_ADDR_TYPE_REDIST	3
 #define KVM_VGIC_ITS_ADDR_TYPE		4
+#define KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION	5
 
 #define KVM_VGIC_V3_DIST_SIZE		SZ_64K
 #define KVM_VGIC_V3_REDIST_SIZE		(2 * SZ_64K)
-- 
2.5.5
