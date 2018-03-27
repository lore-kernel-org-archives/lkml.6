Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752937AbeC0NQ7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:16:59 -0400
Received: from foss.arm.com ([217.140.101.70]:55218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752893AbeC0NQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:16:56 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, cdall@kernel.org, marc.zyngier@arm.com,
        punit.agrawal@arm.com, will.deacon@arm.com, catalin.marinas@arm.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, ard.biesheuvel@linaro.org,
        peter.maydell@linaro.org, kristina.martsenko@arm.com,
        mark.rutland@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [kvmtool PATCH 19/17] kvmtool: arm64: Add support for guest physical address size
Date: Tue, 27 Mar 2018 14:15:29 +0100
Message-Id: <1522156531-28348-20-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522156531-28348-1-git-send-email-suzuki.poulose@arm.com>
References: <1522156531-28348-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an option to specify the physical address size used by this
VM.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arm/aarch64/include/kvm/kvm-config-arch.h | 5 ++++-
 arm/include/arm-common/kvm-config-arch.h  | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arm/aarch64/include/kvm/kvm-config-arch.h b/arm/aarch64/include/kvm/kvm-config-arch.h
index 04be43d..c4bb207 100644
--- a/arm/aarch64/include/kvm/kvm-config-arch.h
+++ b/arm/aarch64/include/kvm/kvm-config-arch.h
@@ -8,7 +8,10 @@
 			"Create PMUv3 device"),				\
 	OPT_U64('\0', "kaslr-seed", &(cfg)->kaslr_seed,			\
 			"Specify random seed for Kernel Address Space "	\
-			"Layout Randomization (KASLR)"),
+			"Layout Randomization (KASLR)"),		\
+	OPT_UINTEGER('\0', "phys-shift", &(cfg)->phys_shift,		\
+			"Specify maximum physical address size (not "	\
+			"the amount of memory)"),
 
 #include "arm-common/kvm-config-arch.h"
 
diff --git a/arm/include/arm-common/kvm-config-arch.h b/arm/include/arm-common/kvm-config-arch.h
index 6a196f1..d841b0b 100644
--- a/arm/include/arm-common/kvm-config-arch.h
+++ b/arm/include/arm-common/kvm-config-arch.h
@@ -11,6 +11,7 @@ struct kvm_config_arch {
 	bool		has_pmuv3;
 	u64		kaslr_seed;
 	enum irqchip_type irqchip;
+	unsigned int	phys_shift;
 };
 
 int irqchip_parser(const struct option *opt, const char *arg, int unset);
-- 
1.9.1
