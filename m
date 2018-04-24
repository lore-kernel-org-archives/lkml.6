Return-Path: <krzk@kernel.org>
X-Google-Smtp-Source: AIpwx49UZP527mrxBOGdEHH/WabWLdaHS1ZKWlG1NEs6z6tmhdp7pMmOP/i5aOIM+3j/zr49Dq2O
ARC-Seal: i=1; a=rsa-sha256; t=1524602019; cv=none;
        d=google.com; s=arc-20160816;
        b=kOIePkdAC3zo52zvQq+QjUsh2KpGvuM5lKGla60zuw/QvxcAa9Bgkr2sWkETWOeGz0
         XvZ1CIUuks8+45fl4n48n1aeFbMulMTdZZS4svLfHUKmaO5WBazC5VYAGgSOeT759sw6
         mEsKjmz9YMeIj+YDXHLqFJioGS9oEobqe+3AVCC+cSwKaxFGlEEXUesOtptwpSFxMywq
         /vMcUlJjS3hyRfVknG5AjVo7m9UkOuYjHfNUsBaa2x9fd9L56Lwle+FHfq+sx1/u9Opd
         28pmiJi6pLthOLhRWEXRanfmY9SLyzZIy+kiAbRRNdRJNaHgfbu8nYjKfHo+lK/VOe0c
         2owg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=UEKyLrxH3lD4zs50VeNuPA5d1CFUDP73VgZoEhhDRN8=;
        b=yMULyrk2F7bj/R47xu8zqNccGtRzpTrgE8sPRg3ni0dNxkvLow1By3q7I6FkgZW888
         K2G0y68mitCuPTBxJ3uaE1RZ+R5alS5xwE2Q7Zehp9arWInUlWtgWDyhQR8sOPxT3UbX
         lwVLIXhzJY0CUICJ9cd/8PfSkMZ2tG6rbBfOyISIYmyKe4cseLcnFTBWyqX6oKSvvLHi
         mXTjz+QO64FBIsVP6fLTIrvw9Kj9m7Cn55syNwVjkWHKV5gyVmZmP+/eV/HMh/bfEA/3
         /2sghP3VpCDh3HJa6ER/iLvxEz2oDzvknC43VDp0crtSq0F8+XV6D1ISNHZ49NgbRMda
         0iBA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8EA217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tejun Heo <tj@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Hans de Goede <hdegoede@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andi Shyti <andi@etezian.org>,
	Mark Brown <broonie@kernel.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC 04/10] clk: samsung: Remove support for Exynos5440
Date: Tue, 24 Apr 2018 22:32:33 +0200
Message-Id: <20180424203239.21885-5-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180424203239.21885-1-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598661087387202007?=
X-GMAIL-MSGID: =?utf-8?q?1598661087387202007?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Exynos5440 is not actively developed, there are no development
boards available and probably there are no real products with it.
Remove wide-tree support for Exynos5440.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/clock/exynos5440-clock.txt |  28 ----
 drivers/clk/samsung/Makefile                       |   1 -
 drivers/clk/samsung/clk-exynos5440.c               | 167 ---------------------
 include/dt-bindings/clock/exynos5440.h             |  44 ------
 4 files changed, 240 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos5440-clock.txt
 delete mode 100644 drivers/clk/samsung/clk-exynos5440.c
 delete mode 100644 include/dt-bindings/clock/exynos5440.h

diff --git a/Documentation/devicetree/bindings/clock/exynos5440-clock.txt b/Documentation/devicetree/bindings/clock/exynos5440-clock.txt
deleted file mode 100644
index c7d227c31e95..000000000000
--- a/Documentation/devicetree/bindings/clock/exynos5440-clock.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* Samsung Exynos5440 Clock Controller
-
-The Exynos5440 clock controller generates and supplies clock to various
-controllers within the Exynos5440 SoC.
-
-Required Properties:
-
-- compatible: should be "samsung,exynos5440-clock".
-
-- reg: physical base address of the controller and length of memory mapped
-  region.
-
-- #clock-cells: should be 1.
-
-Each clock is assigned an identifier and client nodes can use this identifier
-to specify the clock which they consume.
-
-All available clocks are defined as preprocessor macros in
-dt-bindings/clock/exynos5440.h header and can be used in device
-tree sources.
-
-Example: An example of a clock controller node is listed below.
-
-	clock: clock-controller@10010000 {
-		compatible = "samsung,exynos5440-clock";
-		reg = <0x160000 0x10000>;
-		#clock-cells = <1>;
-	};
diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
index 513826393158..1a4e6b787978 100644
--- a/drivers/clk/samsung/Makefile
+++ b/drivers/clk/samsung/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_SOC_EXYNOS5410)	+= clk-exynos5410.o
 obj-$(CONFIG_SOC_EXYNOS5420)	+= clk-exynos5420.o
 obj-$(CONFIG_SOC_EXYNOS5420)	+= clk-exynos5-subcmu.o
 obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos5433.o
-obj-$(CONFIG_SOC_EXYNOS5440)	+= clk-exynos5440.o
 obj-$(CONFIG_EXYNOS_AUDSS_CLK_CON) += clk-exynos-audss.o
 obj-$(CONFIG_ARCH_EXYNOS)	+= clk-exynos-clkout.o
 obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos7.o
diff --git a/drivers/clk/samsung/clk-exynos5440.c b/drivers/clk/samsung/clk-exynos5440.c
deleted file mode 100644
index b08bd54c5e76..000000000000
--- a/drivers/clk/samsung/clk-exynos5440.c
+++ /dev/null
@@ -1,167 +0,0 @@
-/*
- * Copyright (c) 2013 Samsung Electronics Co., Ltd.
- * Author: Thomas Abraham <thomas.ab@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Common Clock Framework support for Exynos5440 SoC.
-*/
-
-#include <dt-bindings/clock/exynos5440.h>
-#include <linux/clk-provider.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/notifier.h>
-#include <linux/reboot.h>
-
-#include "clk.h"
-#include "clk-pll.h"
-
-#define CLKEN_OV_VAL		0xf8
-#define CPU_CLK_STATUS		0xfc
-#define MISC_DOUT1		0x558
-
-static void __iomem *reg_base;
-
-/* parent clock name list */
-PNAME(mout_armclk_p)	= { "cplla", "cpllb" };
-PNAME(mout_spi_p)	= { "div125", "div200" };
-
-/* fixed rate clocks generated outside the soc */
-static struct samsung_fixed_rate_clock exynos5440_fixed_rate_ext_clks[] __initdata = {
-	FRATE(0, "xtal", NULL, 0, 0),
-};
-
-/* fixed rate clocks */
-static const struct samsung_fixed_rate_clock exynos5440_fixed_rate_clks[] __initconst = {
-	FRATE(0, "ppll", NULL, 0, 1000000000),
-	FRATE(0, "usb_phy0", NULL, 0, 60000000),
-	FRATE(0, "usb_phy1", NULL, 0, 60000000),
-	FRATE(0, "usb_ohci12", NULL, 0, 12000000),
-	FRATE(0, "usb_ohci48", NULL, 0, 48000000),
-};
-
-/* fixed factor clocks */
-static const struct samsung_fixed_factor_clock exynos5440_fixed_factor_clks[] __initconst = {
-	FFACTOR(0, "div250", "ppll", 1, 4, 0),
-	FFACTOR(0, "div200", "ppll", 1, 5, 0),
-	FFACTOR(0, "div125", "div250", 1, 2, 0),
-};
-
-/* mux clocks */
-static const struct samsung_mux_clock exynos5440_mux_clks[] __initconst = {
-	MUX(0, "mout_spi", mout_spi_p, MISC_DOUT1, 5, 1),
-	MUX(CLK_ARM_CLK, "arm_clk", mout_armclk_p, CPU_CLK_STATUS, 0, 1),
-};
-
-/* divider clocks */
-static const struct samsung_div_clock exynos5440_div_clks[] __initconst = {
-	DIV(CLK_SPI_BAUD, "div_spi", "mout_spi", MISC_DOUT1, 3, 2),
-};
-
-/* gate clocks */
-static const struct samsung_gate_clock exynos5440_gate_clks[] __initconst = {
-	GATE(CLK_PB0_250, "pb0_250", "div250", CLKEN_OV_VAL, 3, 0, 0),
-	GATE(CLK_PR0_250, "pr0_250", "div250", CLKEN_OV_VAL, 4, 0, 0),
-	GATE(CLK_PR1_250, "pr1_250", "div250", CLKEN_OV_VAL, 5, 0, 0),
-	GATE(CLK_B_250, "b_250", "div250", CLKEN_OV_VAL, 9, 0, 0),
-	GATE(CLK_B_125, "b_125", "div125", CLKEN_OV_VAL, 10, 0, 0),
-	GATE(CLK_B_200, "b_200", "div200", CLKEN_OV_VAL, 11, 0, 0),
-	GATE(CLK_SATA, "sata", "div200", CLKEN_OV_VAL, 12, 0, 0),
-	GATE(CLK_USB, "usb", "div200", CLKEN_OV_VAL, 13, 0, 0),
-	GATE(CLK_GMAC0, "gmac0", "div200", CLKEN_OV_VAL, 14, 0, 0),
-	GATE(CLK_CS250, "cs250", "div250", CLKEN_OV_VAL, 19, 0, 0),
-	GATE(CLK_PB0_250_O, "pb0_250_o", "pb0_250", CLKEN_OV_VAL, 3, 0, 0),
-	GATE(CLK_PR0_250_O, "pr0_250_o", "pr0_250", CLKEN_OV_VAL, 4, 0, 0),
-	GATE(CLK_PR1_250_O, "pr1_250_o", "pr1_250", CLKEN_OV_VAL, 5, 0, 0),
-	GATE(CLK_B_250_O, "b_250_o", "b_250", CLKEN_OV_VAL, 9, 0, 0),
-	GATE(CLK_B_125_O, "b_125_o", "b_125", CLKEN_OV_VAL, 10, 0, 0),
-	GATE(CLK_B_200_O, "b_200_o", "b_200", CLKEN_OV_VAL, 11, 0, 0),
-	GATE(CLK_SATA_O, "sata_o", "sata", CLKEN_OV_VAL, 12, 0, 0),
-	GATE(CLK_USB_O, "usb_o", "usb", CLKEN_OV_VAL, 13, 0, 0),
-	GATE(CLK_GMAC0_O, "gmac0_o", "gmac", CLKEN_OV_VAL, 14, 0, 0),
-	GATE(CLK_CS250_O, "cs250_o", "cs250", CLKEN_OV_VAL, 19, 0, 0),
-};
-
-static const struct of_device_id ext_clk_match[] __initconst = {
-	{ .compatible = "samsung,clock-xtal", .data = (void *)0, },
-	{},
-};
-
-static int exynos5440_clk_restart_notify(struct notifier_block *this,
-		unsigned long code, void *unused)
-{
-	u32 val, status;
-
-	status = readl_relaxed(reg_base + 0xbc);
-	val = readl_relaxed(reg_base + 0xcc);
-	val = (val & 0xffff0000) | (status & 0xffff);
-	writel_relaxed(val, reg_base + 0xcc);
-
-	return NOTIFY_DONE;
-}
-
-/*
- * Exynos5440 Clock restart notifier, handles restart functionality
- */
-static struct notifier_block exynos5440_clk_restart_handler = {
-	.notifier_call = exynos5440_clk_restart_notify,
-	.priority = 128,
-};
-
-static const struct samsung_pll_clock exynos5440_plls[] __initconst = {
-	PLL(pll_2550x, CLK_CPLLA, "cplla", "xtal", 0, 0x4c, NULL),
-	PLL(pll_2550x, CLK_CPLLB, "cpllb", "xtal", 0, 0x50, NULL),
-};
-
-/*
- * Clock aliases for legacy clkdev look-up.
- */
-static const struct samsung_clock_alias exynos5440_aliases[] __initconst = {
-	ALIAS(CLK_ARM_CLK, NULL, "armclk"),
-};
-
-/* register exynos5440 clocks */
-static void __init exynos5440_clk_init(struct device_node *np)
-{
-	struct samsung_clk_provider *ctx;
-
-	reg_base = of_iomap(np, 0);
-	if (!reg_base) {
-		pr_err("%s: failed to map clock controller registers,"
-			" aborting clock initialization\n", __func__);
-		return;
-	}
-
-	ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
-
-	samsung_clk_of_register_fixed_ext(ctx, exynos5440_fixed_rate_ext_clks,
-		ARRAY_SIZE(exynos5440_fixed_rate_ext_clks), ext_clk_match);
-
-	samsung_clk_register_pll(ctx, exynos5440_plls,
-			ARRAY_SIZE(exynos5440_plls), ctx->reg_base);
-
-	samsung_clk_register_fixed_rate(ctx, exynos5440_fixed_rate_clks,
-			ARRAY_SIZE(exynos5440_fixed_rate_clks));
-	samsung_clk_register_fixed_factor(ctx, exynos5440_fixed_factor_clks,
-			ARRAY_SIZE(exynos5440_fixed_factor_clks));
-	samsung_clk_register_mux(ctx, exynos5440_mux_clks,
-			ARRAY_SIZE(exynos5440_mux_clks));
-	samsung_clk_register_div(ctx, exynos5440_div_clks,
-			ARRAY_SIZE(exynos5440_div_clks));
-	samsung_clk_register_gate(ctx, exynos5440_gate_clks,
-			ARRAY_SIZE(exynos5440_gate_clks));
-	samsung_clk_register_alias(ctx, exynos5440_aliases,
-						ARRAY_SIZE(exynos5440_aliases));
-
-	samsung_clk_of_add_provider(np, ctx);
-
-	if (register_restart_handler(&exynos5440_clk_restart_handler))
-		pr_warn("exynos5440 clock can't register restart handler\n");
-
-	pr_info("Exynos5440: arm_clk = %ldHz\n", _get_rate("arm_clk"));
-	pr_info("exynos5440 clock initialization complete\n");
-}
-CLK_OF_DECLARE(exynos5440_clk, "samsung,exynos5440-clock", exynos5440_clk_init);
diff --git a/include/dt-bindings/clock/exynos5440.h b/include/dt-bindings/clock/exynos5440.h
deleted file mode 100644
index 842cdc0adff1..000000000000
--- a/include/dt-bindings/clock/exynos5440.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * Copyright (c) 2013 Samsung Electronics Co., Ltd.
- * Author: Andrzej Hajda <a.hajda@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Device Tree binding constants for Exynos5440 clock controller.
-*/
-
-#ifndef _DT_BINDINGS_CLOCK_EXYNOS_5440_H
-#define _DT_BINDINGS_CLOCK_EXYNOS_5440_H
-
-#define CLK_XTAL		1
-#define CLK_ARM_CLK		2
-#define CLK_CPLLA		3
-#define CLK_CPLLB		4
-#define CLK_SPI_BAUD		16
-#define CLK_PB0_250		17
-#define CLK_PR0_250		18
-#define CLK_PR1_250		19
-#define CLK_B_250		20
-#define CLK_B_125		21
-#define CLK_B_200		22
-#define CLK_SATA		23
-#define CLK_USB			24
-#define CLK_GMAC0		25
-#define CLK_CS250		26
-#define CLK_PB0_250_O		27
-#define CLK_PR0_250_O		28
-#define CLK_PR1_250_O		29
-#define CLK_B_250_O		30
-#define CLK_B_125_O		31
-#define CLK_B_200_O		32
-#define CLK_SATA_O		33
-#define CLK_USB_O		34
-#define CLK_GMAC0_O		35
-#define CLK_CS250_O		36
-
-/* must be greater than maximal clock id */
-#define CLK_NR_CLKS		37
-
-#endif /* _DT_BINDINGS_CLOCK_EXYNOS_5440_H */
-- 
2.14.1
