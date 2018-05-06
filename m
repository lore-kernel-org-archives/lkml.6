Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751751AbeEFO4F (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 10:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751358AbeEFO4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 10:56:03 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH fixes-for-current] arm64: dts: exynos: Fix interrupt type for I2S1 device on Exynos5433
Date: Sun,  6 May 2018 16:55:24 +0200
Message-Id: <20180506145524.14570-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

All interrupts from SoC internal modules are level triggered, so fix
incorrect trigger type for I2S1 device on Exynos5433 SoCs.

This fixes following kernel warning:

WARNING: CPU: 2 PID: 1 at drivers/irqchip/irq-gic.c:1016 gic_irq_domain_translate+0xb0/0xb8
Modules linked in:
CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc7-next-20180329 #646
Hardware name: Samsung TM2 board (DT)
pstate: 20000005 (nzCv daif -PAN -UAO)
pc : gic_irq_domain_translate+0xb0/0xb8
lr : irq_create_fwspec_mapping+0x64/0x328
sp : ffff0000098b38d0
...
Call trace:
 gic_irq_domain_translate+0xb0/0xb8
 irq_create_of_mapping+0x78/0xa0
 of_irq_get+0x6c/0xa0
 of_irq_to_resource+0x38/0x108
 of_irq_to_resource_table+0x50/0x78
 of_device_alloc+0x118/0x1b8
 of_platform_device_create_pdata+0x54/0xe0
 of_platform_bus_create+0x118/0x340
 of_platform_bus_create+0x17c/0x340
 of_platform_populate+0x74/0xd8
 of_platform_default_populate_init+0xb0/0xcc
 do_one_initcall+0x50/0x158
 kernel_init_freeable+0x184/0x22c
 kernel_init+0x10/0x108
 ret_from_fork+0x10/0x18
---[ end trace 6decb2b3078d73f0 ]---

Fixes: d8d579c316e8 ("ARM: dts: exynos: Add I2S1 device node to exynos5433")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---

Hi Arnd and Olof,

That's one fix for current release cycle (issue introduced in merge window).

Best regards,
Krzysztof


 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index c0231d077fa6..1ad8677f6a0a 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1317,7 +1317,7 @@
 			reg = <0x14d60000 0x100>;
 			dmas = <&pdma0 31 &pdma0 30>;
 			dma-names = "tx", "rx";
-			interrupts = <GIC_SPI 435 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu_peric CLK_PCLK_I2S1>,
 				 <&cmu_peric CLK_PCLK_I2S1>,
 				 <&cmu_peric CLK_SCLK_I2S1>;
-- 
2.14.1
