Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965455AbeEIRdj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:33:39 -0400
Received: from vern.gendns.com ([206.190.152.46]:51967 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935560AbeEIR1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:27:02 -0400
From: David Lechner <david@lechnology.com>
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>
Subject: [PATCH v10 13/27] ARM: davinci: remove CONFIG_DAVINCI_RESET_CLOCKS
Date: Wed,  9 May 2018 12:25:52 -0500
Message-Id: <20180509172606.29387-14-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509172606.29387-1-david@lechnology.com>
References: <20180509172606.29387-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The common clock framework will take care of disabling unused clocks when
we switch from the legacy davinci clocks and having this enabled will
cause compile errors after we switch, so remove it now.

Signed-off-by: David Lechner <david@lechnology.com>
Reviewed-by: Sekhar Nori <nsekhar@ti.com>
---

v10 changes:
- none

v9 changes:
- none

v8 changes:
- none

v7 changes:
- none

v6 changes:
- none


 arch/arm/mach-davinci/Kconfig               | 12 ------------
 arch/arm/mach-davinci/common.c              |  1 -
 arch/arm/mach-davinci/include/mach/common.h |  6 ------
 3 files changed, 19 deletions(-)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 05c3eecf47cb..ba9912b4dfab 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -231,18 +231,6 @@ config DAVINCI_MUX_WARNINGS
 	  to change the pin multiplexing setup. When there are no warnings
 	  printed, it's safe to deselect DAVINCI_MUX for your product.
 
-config DAVINCI_RESET_CLOCKS
-	bool "Reset unused clocks during boot"
-	depends on ARCH_DAVINCI
-	help
-	  Say Y if you want to reset unused clocks during boot.
-	  This option saves power, but assumes all drivers are
-	  using the clock framework. Broken drivers that do not
-	  yet use clock framework may not work with this option.
-	  If you are booting from another operating system, you
-	  probably do not want this option enabled until your
-	  device drivers work properly.
-
 endmenu
 
 endif
diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index bcb6a7ba84e9..e03f95ccd95c 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -118,5 +118,4 @@ void __init davinci_common_init(const struct davinci_soc_info *soc_info)
 void __init davinci_init_late(void)
 {
 	davinci_cpufreq_init();
-	davinci_clk_disable_unused();
 }
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 5f45d0ac66a8..ded8f5f42725 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -83,12 +83,6 @@ extern void davinci_common_init(const struct davinci_soc_info *soc_info);
 extern void davinci_init_ide(void);
 void davinci_init_late(void);
 
-#ifdef CONFIG_DAVINCI_RESET_CLOCKS
-int davinci_clk_disable_unused(void);
-#else
-static inline int davinci_clk_disable_unused(void) { return 0; }
-#endif
-
 #ifdef CONFIG_CPU_FREQ
 int davinci_cpufreq_init(void);
 #else
-- 
2.17.0
