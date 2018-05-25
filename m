Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965773AbeEYJxB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:53:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57632 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966133AbeEYJur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:50:47 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v4 21/26] arm64: Add build option for IRQ masking via priority
Date: Fri, 25 May 2018 10:49:27 +0100
Message-Id: <1527241772-48007-22-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a build option to enable using  GICv3 priorities to enable/disable
interrupts.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index eb2cf49..ab214b9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -938,6 +938,21 @@ config HARDEN_EL2_VECTORS
 
 	  If unsure, say Y.
 
+config USE_ICC_SYSREGS_FOR_IRQFLAGS
+	bool "Use ICC system registers for IRQ masking"
+	select CONFIG_ARM_GIC_V3
+	help
+	  Using the ICC system registers for IRQ masking makes it possible
+	  to simulate NMI on ARM64 systems. This allows several interesting
+	  features (especially debug features) to be used on these systems.
+
+	  Say Y here to implement IRQ masking using ICC system
+	  registers when the GIC System Registers are available. The changes
+	  are applied dynamically using the alternatives system so it is safe
+	  to enable this option on systems with older interrupt controllers.
+
+	  If unsure, say N
+
 menuconfig ARMV8_DEPRECATED
 	bool "Emulate deprecated/obsolete ARMv8 instructions"
 	depends on COMPAT
-- 
1.9.1
