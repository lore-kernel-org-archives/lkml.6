Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967085AbeEYQLm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:11:42 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:36739 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965666AbeEYQLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:11:41 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: arm@kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ludovic Barre <ludovic.barre@st.com>,
        Olof Johansson <olof@lixom.net>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: stm32: Don't select DMA unconditionally on STM32MP157C
Date: Fri, 25 May 2018 18:10:20 +0200
Message-Id: <20180525161051.187324-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:YfML3ONVGXTaTj9iaAN/b7P8JTcQbN6CWxIC1H4HYBLmMOaonoW
 hTtSOwpuOkZxs6FnckPL4XIfMU31w0B6zWeEUYcfTftPBI0c2W76WiHseVIiWG3gRYEf0uB
 fKuOAPSadcDPaffPq80B2T7d8QTkHOczpBAOVXKa9tYQ9yjgql3Po4X9yfmbzqqAAqoaQq+
 s/Z1yq79zRAoctBMuJJzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qYz2Pecb7ag=:WSScp1Ge/Pt0vfwhklrtEa
 TQvFuAStB/YO7veCdw9soHgsLTxrBNf7YjXjL21etxDCQV+3X2Jzn4Db+oXrdfRcOEU43rWlB
 lm+Bpn4UTCthOYg6b2+QU01GjzY2rEY3LVKFqQt6rTYgclKrxuc6DMe8RUDdXlHVaF5LQQaFt
 kkpDyncLuu7cVab3LNIvuZ53k8FbAySDRX8Q1qDHDv0OvfqXLG6LMppLEE54YfTkZxaKG+Do6
 vBBBmMFN7J0N6X3EtS9SrvQn0RU+EgQaqiRZk45G2JkCIARV5WUQ6Dg2bwTsDUBO7Z4v+aB/R
 iHCF7D77s5jWNV5JYq0n01t0agAQMpvcejp69GRh4ZQJAUrDI6GvE5Mvrg5aF7h2rFXkFeU6I
 BweDQFkALOTQliHvHFcYiqwUnzzpsNkeBEokbGtcS5qrAL2yFvUjXG2o/Vr/ePEdax9HjOaUL
 7HwFPuCuV8Ltlwa7Wa8m03Dh4JncMyQz3XF44JWNPexfN6ZutYnumxkCaJW5EfPQSFFvgTVPt
 erTDnTkQOBdpJPrWQO8DVwpvq94PPKhQB6K7qGI2bi01nL41hvTM+Fm1FbiDnyutL5Kda5wwd
 lOkhk87m0IfR5YrWFnsT/SaVvqMdeMWAKoPY8jOw2VLEu1/Iy4VUEUs44RGDcN5y5mxIBSkRL
 7wGndEBLNcjr4VR7bmUzGMt68DyGrMuSXcK7WVB/3h+5pfNJo+Ha3cgZQyeQs/YVJYgE=
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
