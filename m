Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753458AbeCFLR0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 06:17:26 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:39334 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeCFLRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 06:17:25 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w26BG3JD006591
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Patrice CHOTARD <patrice.chotard@st.com>,
        Rob Herring <robh@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pinctrl: stm32: add 'depends on HAS_IOMEM' to fix unmet dependency
Date: Tue,  6 Mar 2018 20:15:56 +0900
Message-Id: <1520334956-9900-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These configs select MFD_SYSCON, but do not depend on HAS_IOMEM.

Compile testing on architecture without HAS_IOMEM causes "unmet
direct dependencies" in Kconfig phase.

Detected by "make ARCH=score allyesconfig".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Arnd Bergmann and I discussed how to fix unmet dependency of MFD_SYSCON.
https://lkml.org/lkml/2018/2/27/284

We agreed to add 'depends on HAS_IOMEM' to drivers causing
unmet dependency.


 drivers/pinctrl/stm32/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/stm32/Kconfig b/drivers/pinctrl/stm32/Kconfig
index 1c4e00b2..cd3936e 100644
--- a/drivers/pinctrl/stm32/Kconfig
+++ b/drivers/pinctrl/stm32/Kconfig
@@ -11,37 +11,37 @@ config PINCTRL_STM32
 
 config PINCTRL_STM32F429
 	bool "STMicroelectronics STM32F429 pin control" if COMPILE_TEST && !MACH_STM32F429
-	depends on OF
+	depends on OF && HAS_IOMEM
 	default MACH_STM32F429
 	select PINCTRL_STM32
 
 config PINCTRL_STM32F469
 	bool "STMicroelectronics STM32F469 pin control" if COMPILE_TEST && !MACH_STM32F469
-	depends on OF
+	depends on OF && HAS_IOMEM
 	default MACH_STM32F469
 	select PINCTRL_STM32
 
 config PINCTRL_STM32F746
 	bool "STMicroelectronics STM32F746 pin control" if COMPILE_TEST && !MACH_STM32F746
-	depends on OF
+	depends on OF && HAS_IOMEM
 	default MACH_STM32F746
 	select PINCTRL_STM32
 
 config PINCTRL_STM32F769
 	bool "STMicroelectronics STM32F769 pin control" if COMPILE_TEST && !MACH_STM32F769
-	depends on OF
+	depends on OF && HAS_IOMEM
 	default MACH_STM32F769
 	select PINCTRL_STM32
 
 config PINCTRL_STM32H743
 	bool "STMicroelectronics STM32H743 pin control" if COMPILE_TEST && !MACH_STM32H743
-	depends on OF
+	depends on OF && HAS_IOMEM
 	default MACH_STM32H743
 	select PINCTRL_STM32
 
 config PINCTRL_STM32MP157
 	bool "STMicroelectronics STM32MP157 pin control" if COMPILE_TEST && !MACH_STM32MP157
-	depends on OF
+	depends on OF && HAS_IOMEM
 	default MACH_STM32MP157
 	select PINCTRL_STM32
 endif
-- 
2.7.4
