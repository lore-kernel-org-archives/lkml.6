Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbeBUSSh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 13:18:37 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46942 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752674AbeBUSSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 13:18:32 -0500
X-Google-Smtp-Source: AH8x224C+jKaUf2NuHRsGyaOpSscSrrFy2125pfvNqPvxoDuNCkvfBXnbUQbRNgKuH8OJ7pCVVCk4g==
From: Kees Cook <keescook@chromium.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, Will Deacon <will.deacon@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: cpufeature: Remove redundant "feature" in reports
Date: Wed, 21 Feb 2018 10:18:22 -0800
Message-Id: <1519237102-46854-3-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519237102-46854-1-git-send-email-keescook@chromium.org>
References: <1519237102-46854-1-git-send-email-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The word "feature" is repeated in the CPU features reporting. This drops it
for improved readability.

Before (redundant "feature" word):

 SMP: Total of 4 processors activated.
 CPU features: detected feature: 32-bit EL0 Support
 CPU features: detected feature: Kernel page table isolation (KPTI)
 CPU features: emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching
 CPU: All CPU(s) started at EL2

After:

 SMP: Total of 4 processors activated.
 CPU features: detected: 32-bit EL0 Support
 CPU features: detected: Kernel page table isolation (KPTI)
 CPU features: emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching
 CPU: All CPU(s) started at EL2

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 61aff55245ea..6c799ca58b53 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1357,7 +1357,7 @@ void check_local_cpu_capabilities(void)
 
 static void __init setup_feature_capabilities(void)
 {
-	update_cpu_capabilities(arm64_features, "detected feature:");
+	update_cpu_capabilities(arm64_features, "detected:");
 	enable_cpu_capabilities(arm64_features);
 }
 
-- 
2.7.4
