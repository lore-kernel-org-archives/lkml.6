Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966986AbeEYQLJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:11:09 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:44657 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965666AbeEYQLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:11:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: arm@kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ludovic Barre <ludovic.barre@st.com>,
        Olof Johansson <olof@lixom.net>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: stm32: Don't select DMA unconditionally on STM32MP157C
Date: Fri, 25 May 2018 18:09:13 +0200
Message-Id: <20180525160926.150713-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:3PpjhnR6c7pIyzSdQKhlNEahgRkZsVVVvoeaM5kx2MzUzkcpTKw
 KhxM9xRjZsWytlwboKLxhJtLrtReWm6UKiOazMS10sk6yxFzz2j5RXtLRYMleJxmuj5I8Ot
 3NEd33jD234zaq3Jz1tV8TM/WqxvR5WvdKw6W+fxTu0ntn5UwrZVJu+XLk3Or1S7HJOxqzZ
 NWcgtpwFuKUbgnD+Wznzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d8Raya714HI=:+AeVTq84ZBIYO+ZpsyQMHf
 pRHbC0R5AFECjSxfzfgnJ96svSdFaw9TMH3fQTguYqNN6ZZwx1nE1dP1trkt8C54T5VreEYB4
 TNtTr9zH5DL1c+mz63pOp8tEtVetwfJKo95Ts6erfKb9QG3iNnRRqj058sEIuWt2My1u61FUZ
 eJfVnmvPjslkAWWqGDVCPUJrOXHG7lwMabENujfxhi94fNEFf4S6/32tWI5QvANomZSgggTOI
 EM5MCzYznAjNZDqiV8vA9fwZwde6/IxmEdKeutfgCRG/eHXUjv/FW3g/my/BlaI2aHEkfDajM
 xWc7rZkC9cOKIu/lY6vfi8Qtj7wLyqqHJ0WW0+XwCZZYSyk//mpyrk60L/eoAL33PxMS2L9N4
 NzFTF3s+WfhCudE5i3nfhQ4DCE/v1CwyRb+v9GytGxHmhBY1JaSM9bVF2BL+2MMLK32ZAblEo
 cepsd8pqBZGBKgueapF2FPzlzSY2REmRu8no8GehayPqccq+udPuVcco3MDrB33IbLsHZfJv+
 1ZQhp9h+mTt4snBXPtrkW+2uD80cqc89jyCkYqhqgVj/AhXV5ZwzWm7Tgqo4vT+5VkCYF65aV
 7DvEQwV2+BBRBdYO4IG9qoy7MbBW0dzI5/VVKhoY9lSb0+fTwTn0UTmAWPUCH1A9ytjXRd+8W
 zFSvVzUT2i9qfGho0fPjTGtGB46x/9bzIKHGUNdCa/IbY5D59YNAF9gENVTb066BnZZc=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch that enabled these had no useful changelog that explains
why it is done, and it causes a build warning:

WARNING: unmet direct dependencies detected for STM32_DMA
  Depends on [n]: DMADEVICES [=n] && (ARCH_STM32 [=y] || COMPILE_TEST [=y])
  Selected by [y]:
  - MACH_STM32MP157 [=y] && ARCH_STM32 [=y] && ARCH_MULTI_V7 [=y]

Generally, platforms should not select arbitrary drivers, so let's
just revert that change.

Fixes: de6037fa207f ("ARM: stm32: Select DMA, DMAMUX and MDMA support on STM32MP157C")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-stm32/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 82a93b8d9ae6..713c068b953f 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -46,9 +46,6 @@ if ARCH_MULTI_V7
 
 config MACH_STM32MP157
 	bool "STMicroelectronics STM32MP157"
-	select STM32_DMA
-	select STM32_DMAMUX
-	select STM32_MDMA
 	default y
 
 endif # ARMv7-A
-- 
2.9.0
