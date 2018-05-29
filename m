Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933673AbeE2MLj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:11:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38372 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933135AbeE2MLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:11:33 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Cc: Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Julien Grall <julien.grall@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 01/17] arm/arm64: smccc: Add SMCCC-specific return codes
Date: Tue, 29 May 2018 13:11:05 +0100
Message-Id: <20180529121121.24927-2-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180529121121.24927-1-marc.zyngier@arm.com>
References: <20180529121121.24927-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've so far used the PSCI return codes for SMCCC because they
were extremely similar. But with the new ARM DEN 0070A specification,
"NOT_REQUIRED" (-2) is clashing with PSCI's "PSCI_RET_INVALID_PARAMS".

Let's bite the bullet and add SMCCC specific return codes. Users
can be repainted as and when required.

Acked-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/arm-smccc.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index a031897fca76..c89da86de99f 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -291,5 +291,10 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
  */
 #define arm_smccc_1_1_hvc(...)	__arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
 
+/* Return codes defined in ARM DEN 0070A */
+#define SMCCC_RET_SUCCESS			0
+#define SMCCC_RET_NOT_SUPPORTED			-1
+#define SMCCC_RET_NOT_REQUIRED			-2
+
 #endif /*__ASSEMBLY__*/
 #endif /*__LINUX_ARM_SMCCC_H*/
-- 
2.14.2
