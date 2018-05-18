Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbeEROkt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:40:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54164 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751957AbeEROjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:39:31 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v3 3/5] ARM: Make CONFIG_CPU_V7 valid for 32bit ARMv8 implementations
Date: Fri, 18 May 2018 15:39:11 +0100
Message-Id: <20180518143913.26306-4-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180518143913.26306-1-marc.zyngier@arm.com>
References: <20180518143913.26306-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARMv8 is a superset of ARMv7, and all the ARMv8 features are
discoverable with a set of ID registers. It means that we can
use CPU_V7 to guard ARMv8 features at compile time.

This commit simply amends the CPU_V7 configuration symbol comment
to reflect that CPU_V7 also covers ARMv8.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 7f14acf67caf..86550040de19 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -402,7 +402,7 @@ config CPU_V6K
 	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V6 if MMU
 
-# ARMv7
+# ARMv7 and ARMv8 architectures
 config CPU_V7
 	bool
 	select CPU_32v6K
-- 
2.14.2
