Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbeEROjv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:39:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54190 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752056AbeEROjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:39:35 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v3 5/5] ARM: mach-virt: Select PMUv3 driver by default
Date: Fri, 18 May 2018 15:39:13 +0100
Message-Id: <20180518143913.26306-6-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180518143913.26306-1-marc.zyngier@arm.com>
References: <20180518143913.26306-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 32bit guests are not unlikely to run on an ARMv8 host,
let's select the PMUv3 driver, which allows the PMU to be used
on such systems.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7f8e7f4b88f..5dc5d5f15560 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -703,6 +703,7 @@ config ARCH_VIRT
 	select ARM_GIC_V3
 	select ARM_GIC_V3_ITS if PCI
 	select ARM_PSCI
+	select ARM_PMUV3 if PERF_EVENTS
 	select HAVE_ARM_ARCH_TIMER
 
 #
-- 
2.14.2
