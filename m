Return-Path: <krzk@kernel.org>
X-Google-Smtp-Source: AIpwx4+kgVGbPIq/9Pk/P+HNYgWhCz/S27JfoegMeKaoc4/GjfxlTaFMLBXDoUF1aJ5sxPK83p76
ARC-Seal: i=1; a=rsa-sha256; t=1524602060; cv=none;
        d=google.com; s=arc-20160816;
        b=nJE4UwogkT1iYbbFh30dbL9NgliHg35aKLJJVT6gbp+m5I2kw/wnH7WrU1J11oFCGW
         Pvm99Yo/NlMtQ5FQRbPLYwYPWq26RN75BkAagbRHwge8YArIXOElc+nRhuYDgQZyUoql
         /bCSAX/G7CBg6JAGG96RV8Hmt87y0xB24z9b9u+BqX4F8igK6CeVuI+eW2paNx0iAEr0
         fyrbBIXWWOZ1FgYGJqW6r+9b7GRnRCWdJ16nRtjEs3pVd7oD6kaaAWjGN50unaKe3sA5
         zqhRVZNRNdwLNoi6cN3PJvnkSUhKwG9mOYDh2p8cdCg3un0bRExC858u8S84dYHo4koW
         v+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=r57c7gaAdrra93yNLrZZY3QoI+PN5XF8NqzdEHiUUNs=;
        b=AXCQ49XTKcFV7xip5ypGOq+Dphtl0mcNB5i406olftFkq8tTtkEFlWV4p/P8+cc75h
         3isiS6Sty7BPNGxMyc96wvfMWL2xtqk7kJL3obX5PIn7Yj1fXgnFu02zcjw5w82O/pw4
         BZ2ffp7CHgcvF3qXfhrsi/WQ3sfAP4jh5q/VAqlW8c4AtmZkkwP4LGHp87D4FkAWjL2O
         8e8GIdQGZfUqYCm/NEkIjDdxIkA4foEQdeWUg3urYbjFkN+ATnRKSYJ8Yk3ogzpNNATW
         VzDno/N4Qw3YLJ0nmtMJ+UDMeD7YShUdqn+X0Qkq2edoJaOM+/QfsrIkyOqvTU1d0DvZ
         zhDA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690E0217CE
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
Subject: [RFC 10/10] ARM: exynos: Remove support for Exynos5440
Date: Tue, 24 Apr 2018 22:32:39 +0200
Message-Id: <20180424203239.21885-11-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180424203239.21885-1-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598661129700313461?=
X-GMAIL-MSGID: =?utf-8?q?1598661129700313461?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Exynos5440 is not actively developed, there are no development
boards available and probably there are no real products with it.
Remove wide-tree support for Exynos5440.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-exynos/Kconfig  | 12 ------------
 arch/arm/mach-exynos/common.h |  8 --------
 arch/arm/mach-exynos/exynos.c | 15 ++-------------
 3 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 647c319f9f5f..219d389a8521 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -108,18 +108,6 @@ config SOC_EXYNOS5420
 	default y
 	depends on ARCH_EXYNOS5
 
-config SOC_EXYNOS5440
-	bool "SAMSUNG EXYNOS5440"
-	default y
-	depends on ARCH_EXYNOS5
-	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
-	select HAVE_ARM_ARCH_TIMER
-	select AUTO_ZRELADDR
-	select PINCTRL_EXYNOS5440
-	select PM_OPP
-	help
-	  Enable EXYNOS5440 SoC support
-
 config SOC_EXYNOS5800
 	bool "SAMSUNG EXYNOS5800"
 	default y
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 098f84a149a3..f332c654784b 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -21,7 +21,6 @@
 #define EXYNOS5250_SOC_ID	0x43520000
 #define EXYNOS5410_SOC_ID	0xE5410000
 #define EXYNOS5420_SOC_ID	0xE5420000
-#define EXYNOS5440_SOC_ID	0xE5440000
 #define EXYNOS5800_SOC_ID	0xE5422000
 #define EXYNOS5_SOC_MASK	0xFFFFF000
 
@@ -39,7 +38,6 @@ IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID, EXYNOS4_CPU_MASK)
 IS_SAMSUNG_CPU(exynos5250, EXYNOS5250_SOC_ID, EXYNOS5_SOC_MASK)
 IS_SAMSUNG_CPU(exynos5410, EXYNOS5410_SOC_ID, EXYNOS5_SOC_MASK)
 IS_SAMSUNG_CPU(exynos5420, EXYNOS5420_SOC_ID, EXYNOS5_SOC_MASK)
-IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
 IS_SAMSUNG_CPU(exynos5800, EXYNOS5800_SOC_ID, EXYNOS5_SOC_MASK)
 
 #if defined(CONFIG_SOC_EXYNOS3250)
@@ -82,12 +80,6 @@ IS_SAMSUNG_CPU(exynos5800, EXYNOS5800_SOC_ID, EXYNOS5_SOC_MASK)
 # define soc_is_exynos5420()	0
 #endif
 
-#if defined(CONFIG_SOC_EXYNOS5440)
-# define soc_is_exynos5440()	is_samsung_exynos5440()
-#else
-# define soc_is_exynos5440()	0
-#endif
-
 #if defined(CONFIG_SOC_EXYNOS5800)
 # define soc_is_exynos5800()	is_samsung_exynos5800()
 #else
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 8c4f5e342dc1..460ae13b3145 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -63,15 +63,6 @@ void __init exynos_sysram_init(void)
 	}
 }
 
-static void __init exynos_init_late(void)
-{
-	if (of_machine_is_compatible("samsung,exynos5440"))
-		/* to be supported later */
-		return;
-
-	exynos_pm_init();
-}
-
 static int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
 					int depth, void *data)
 {
@@ -79,8 +70,7 @@ static int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
 	const __be32 *reg;
 	int len;
 
-	if (!of_flat_dt_is_compatible(node, "samsung,exynos4210-chipid") &&
-		!of_flat_dt_is_compatible(node, "samsung,exynos5440-clock"))
+	if (!of_flat_dt_is_compatible(node, "samsung,exynos4210-chipid"))
 		return 0;
 
 	reg = of_get_flat_dt_prop(node, "reg", &len);
@@ -209,7 +199,6 @@ static char const *const exynos_dt_compat[] __initconst = {
 	"samsung,exynos5250",
 	"samsung,exynos5260",
 	"samsung,exynos5420",
-	"samsung,exynos5440",
 	NULL
 };
 
@@ -232,7 +221,7 @@ DT_MACHINE_START(EXYNOS_DT, "SAMSUNG EXYNOS (Flattened Device Tree)")
 	.init_early	= exynos_firmware_init,
 	.init_irq	= exynos_init_irq,
 	.init_machine	= exynos_dt_machine_init,
-	.init_late	= exynos_init_late,
+	.init_late	= exynos_pm_init,
 	.dt_compat	= exynos_dt_compat,
 	.dt_fixup	= exynos_dt_fixup,
 MACHINE_END
-- 
2.14.1
