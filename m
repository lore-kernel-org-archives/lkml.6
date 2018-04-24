Return-Path: <krzk@kernel.org>
X-Google-Smtp-Source: AIpwx49VvaZGkcewKpLvOmQ6bsv3ZmShQJfdLrN7Wm9q1hp80aQjp/FaZphWBup92wk0/EOEAWjE
ARC-Seal: i=1; a=rsa-sha256; t=1524602032; cv=none;
        d=google.com; s=arc-20160816;
        b=ilB6vEkhOtT7/haEb++4aZueGWpSb50rb5lX2c5OdKHwc5vVnXC4jVS4FQA13g0bPm
         Hd/HCzXCrlIukRCnmLF0MmoEzpW7DO+Jf+PCMUJNu0AWKGJUtk1bMhiwvwTd380aqO98
         OpGsL7N9n7HSsFiglMr0DrZfIKjzoVQJViAyOLCfTKmUCmrYbR6eK/NVGm7Ca1bSPNoj
         5rrb/QmxvIvVPzi5BITsJL0vO0k7qzTzUYrK+RlfOqYBqNPcILR47+qjvOrmsrIptKg4
         ijLnOuLNIU02ZLVBCu0/E5tQCLQRL2Bu3uuJDML/v3MdqpBCFSHKBxmWuZGGD5EX78Es
         ES2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=Wz5sX5t48jUKusRXoDm7m3CtfS1cq+hhMQJpgsY5V3g=;
        b=ZBBFW2uqh6cdn7xoPUur1BThepXyVF/r2vXgxfGB2FqPCnFGpQJpLndu4YDVsR9t+o
         8C5nLDzb0VlCmGU7J5wo0K4DoPvDgB0v674aFaUtlPc7MVztcbmI94N/scIOmO/yG0pP
         IPaMrCfXnjzhvSmcOZbORkaxcjB4+5jPWL7jm2wAdLqRMG6dprmL6fVjwwb/aRCyjJix
         GhshBQUybmVhFY9Y06ou/q99EJRBT2PyrRKgfcHuINjqeXKErNcY9yFM24gKrznutvCk
         I7GQR960BNu6B8ASFmX9hIyH0TSYBTa5ufIWjcir0N+rrTdDRkyvqD3GVrg93mnlqv1V
         6rXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC48217CE
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
Subject: [RFC 06/10] thermal: samsung: Remove support for Exynos5440
Date: Tue, 24 Apr 2018 22:32:35 +0200
Message-Id: <20180424203239.21885-7-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180424203239.21885-1-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598661101248192093?=
X-GMAIL-MSGID: =?utf-8?q?1598661101248192093?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Exynos5440 is not actively developed, there are no development
boards available and probably there are no real products with it.
Remove wide-tree support for Exynos5440.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/thermal/exynos-thermal.txt |  14 +-
 drivers/thermal/samsung/exynos_tmu.c               | 155 +--------------------
 drivers/thermal/samsung/exynos_tmu.h               |   1 -
 3 files changed, 4 insertions(+), 166 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
index b957acff57aa..ad648d93d961 100644
--- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
@@ -12,7 +12,6 @@
 	       "samsung,exynos5420-tmu-ext-triminfo" for TMU channels 2, 3 and 4
 			Exynos5420 (Must pass triminfo base and triminfo clock)
                "samsung,exynos5433-tmu"
-	       "samsung,exynos5440-tmu"
 	       "samsung,exynos7-tmu"
 - interrupt-parent : The phandle for the interrupt controller
 - reg : Address range of the thermal registers. For soc's which has multiple
@@ -68,18 +67,7 @@ Example 1):
 		#thermal-sensor-cells = <0>;
 	};
 
-Example 2):
-
-	tmuctrl_0: tmuctrl@160118 {
-		compatible = "samsung,exynos5440-tmu";
-		reg = <0x160118 0x230>, <0x160368 0x10>;
-		interrupts = <0 58 0>;
-		clocks = <&clock 21>;
-		clock-names = "tmu_apbif";
-		#thermal-sensor-cells = <0>;
-	};
-
-Example 3): (In case of Exynos5420 "with misplaced TRIMINFO register")
+Example 2): (In case of Exynos5420 "with misplaced TRIMINFO register")
 	tmu_cpu2: tmu@10068000 {
 		compatible = "samsung,exynos5420-tmu-ext-triminfo";
 		reg = <0x10068000 0x100>, <0x1006c000 0x4>;
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index ed805c7c5ace..f92f470bce21 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -123,28 +123,6 @@
 
 #define EXYNOS5433_PD_DET_EN			1
 
-/*exynos5440 specific registers*/
-#define EXYNOS5440_TMU_S0_7_TRIM		0x000
-#define EXYNOS5440_TMU_S0_7_CTRL		0x020
-#define EXYNOS5440_TMU_S0_7_DEBUG		0x040
-#define EXYNOS5440_TMU_S0_7_TEMP		0x0f0
-#define EXYNOS5440_TMU_S0_7_TH0			0x110
-#define EXYNOS5440_TMU_S0_7_TH1			0x130
-#define EXYNOS5440_TMU_S0_7_TH2			0x150
-#define EXYNOS5440_TMU_S0_7_IRQEN		0x210
-#define EXYNOS5440_TMU_S0_7_IRQ			0x230
-/* exynos5440 common registers */
-#define EXYNOS5440_TMU_IRQ_STATUS		0x000
-#define EXYNOS5440_TMU_PMIN			0x004
-
-#define EXYNOS5440_TMU_INTEN_RISE0_SHIFT	0
-#define EXYNOS5440_TMU_INTEN_RISE1_SHIFT	1
-#define EXYNOS5440_TMU_INTEN_RISE2_SHIFT	2
-#define EXYNOS5440_TMU_INTEN_RISE3_SHIFT	3
-#define EXYNOS5440_TMU_INTEN_FALL0_SHIFT	4
-#define EXYNOS5440_TMU_TH_RISE4_SHIFT		24
-#define EXYNOS5440_EFUSE_SWAP_OFFSET		8
-
 /* Exynos7 specific registers */
 #define EXYNOS7_THD_TEMP_RISE7_6		0x50
 #define EXYNOS7_THD_TEMP_FALL7_6		0x60
@@ -614,57 +592,6 @@ static int exynos5433_tmu_initialize(struct platform_device *pdev)
 	return ret;
 }
 
-static int exynos5440_tmu_initialize(struct platform_device *pdev)
-{
-	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	unsigned int trim_info = 0, con, rising_threshold;
-	int threshold_code;
-	int crit_temp = 0;
-
-	/*
-	 * For exynos5440 soc triminfo value is swapped between TMU0 and
-	 * TMU2, so the below logic is needed.
-	 */
-	switch (data->id) {
-	case 0:
-		trim_info = readl(data->base + EXYNOS5440_EFUSE_SWAP_OFFSET +
-				 EXYNOS5440_TMU_S0_7_TRIM);
-		break;
-	case 1:
-		trim_info = readl(data->base + EXYNOS5440_TMU_S0_7_TRIM);
-		break;
-	case 2:
-		trim_info = readl(data->base - EXYNOS5440_EFUSE_SWAP_OFFSET +
-				  EXYNOS5440_TMU_S0_7_TRIM);
-	}
-	sanitize_temp_error(data, trim_info);
-
-	/* Write temperature code for rising and falling threshold */
-	rising_threshold = readl(data->base + EXYNOS5440_TMU_S0_7_TH0);
-	rising_threshold = get_th_reg(data, rising_threshold, false);
-	writel(rising_threshold, data->base + EXYNOS5440_TMU_S0_7_TH0);
-	writel(0, data->base + EXYNOS5440_TMU_S0_7_TH1);
-
-	data->tmu_clear_irqs(data);
-
-	/* if last threshold limit is also present */
-	if (!data->tzd->ops->get_crit_temp(data->tzd, &crit_temp)) {
-		threshold_code = temp_to_code(data, crit_temp / MCELSIUS);
-		/* 5th level to be assigned in th2 reg */
-		rising_threshold =
-			threshold_code << EXYNOS5440_TMU_TH_RISE4_SHIFT;
-		writel(rising_threshold, data->base + EXYNOS5440_TMU_S0_7_TH2);
-		con = readl(data->base + EXYNOS5440_TMU_S0_7_CTRL);
-		con |= (1 << EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
-		writel(con, data->base + EXYNOS5440_TMU_S0_7_CTRL);
-	}
-	/* Clear the PMIN in the common TMU register */
-	if (!data->id)
-		writel(0, data->base_second + EXYNOS5440_TMU_PMIN);
-
-	return 0;
-}
-
 static int exynos7_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
@@ -816,35 +743,6 @@ static void exynos5433_tmu_control(struct platform_device *pdev, bool on)
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 }
 
-static void exynos5440_tmu_control(struct platform_device *pdev, bool on)
-{
-	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tzd;
-	unsigned int con, interrupt_en;
-
-	con = get_con_reg(data, readl(data->base + EXYNOS5440_TMU_S0_7_CTRL));
-
-	if (on) {
-		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
-		interrupt_en =
-			(of_thermal_is_trip_valid(tz, 3)
-			 << EXYNOS5440_TMU_INTEN_RISE3_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 2)
-			 << EXYNOS5440_TMU_INTEN_RISE2_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 1)
-			 << EXYNOS5440_TMU_INTEN_RISE1_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 0)
-			 << EXYNOS5440_TMU_INTEN_RISE0_SHIFT);
-		interrupt_en |=
-			interrupt_en << EXYNOS5440_TMU_INTEN_FALL0_SHIFT;
-	} else {
-		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
-		interrupt_en = 0; /* Disable all interrupts */
-	}
-	writel(interrupt_en, data->base + EXYNOS5440_TMU_S0_7_IRQEN);
-	writel(con, data->base + EXYNOS5440_TMU_S0_7_CTRL);
-}
-
 static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
@@ -911,10 +809,8 @@ static u32 get_emul_con_reg(struct exynos_tmu_data *data, unsigned int val,
 	if (temp) {
 		temp /= MCELSIUS;
 
-		if (data->soc != SOC_ARCH_EXYNOS5440) {
-			val &= ~(EXYNOS_EMUL_TIME_MASK << EXYNOS_EMUL_TIME_SHIFT);
-			val |= (EXYNOS_EMUL_TIME << EXYNOS_EMUL_TIME_SHIFT);
-		}
+		val &= ~(EXYNOS_EMUL_TIME_MASK << EXYNOS_EMUL_TIME_SHIFT);
+		val |= (EXYNOS_EMUL_TIME << EXYNOS_EMUL_TIME_SHIFT);
 		if (data->soc == SOC_ARCH_EXYNOS7) {
 			val &= ~(EXYNOS7_EMUL_DATA_MASK <<
 				EXYNOS7_EMUL_DATA_SHIFT);
@@ -955,16 +851,6 @@ static void exynos4412_tmu_set_emulation(struct exynos_tmu_data *data,
 	writel(val, data->base + emul_con);
 }
 
-static void exynos5440_tmu_set_emulation(struct exynos_tmu_data *data,
-					 int temp)
-{
-	unsigned int val;
-
-	val = readl(data->base + EXYNOS5440_TMU_S0_7_DEBUG);
-	val = get_emul_con_reg(data, val, temp);
-	writel(val, data->base + EXYNOS5440_TMU_S0_7_DEBUG);
-}
-
 static int exynos_tmu_set_emulation(void *drv_data, int temp)
 {
 	struct exynos_tmu_data *data = drv_data;
@@ -987,7 +873,6 @@ static int exynos_tmu_set_emulation(void *drv_data, int temp)
 }
 #else
 #define exynos4412_tmu_set_emulation NULL
-#define exynos5440_tmu_set_emulation NULL
 static int exynos_tmu_set_emulation(void *drv_data, int temp)
 	{ return -EINVAL; }
 #endif /* CONFIG_THERMAL_EMULATION */
@@ -1005,11 +890,6 @@ static int exynos4412_tmu_read(struct exynos_tmu_data *data)
 	return readb(data->base + EXYNOS_TMU_REG_CURRENT_TEMP);
 }
 
-static int exynos5440_tmu_read(struct exynos_tmu_data *data)
-{
-	return readb(data->base + EXYNOS5440_TMU_S0_7_TEMP);
-}
-
 static int exynos7_tmu_read(struct exynos_tmu_data *data)
 {
 	return readw(data->base + EXYNOS_TMU_REG_CURRENT_TEMP) &
@@ -1020,16 +900,9 @@ static void exynos_tmu_work(struct work_struct *work)
 {
 	struct exynos_tmu_data *data = container_of(work,
 			struct exynos_tmu_data, irq_work);
-	unsigned int val_type;
 
 	if (!IS_ERR(data->clk_sec))
 		clk_enable(data->clk_sec);
-	/* Find which sensor generated this interrupt */
-	if (data->soc == SOC_ARCH_EXYNOS5440) {
-		val_type = readl(data->base_second + EXYNOS5440_TMU_IRQ_STATUS);
-		if (!((val_type >> data->id) & 0x1))
-			goto out;
-	}
 	if (!IS_ERR(data->clk_sec))
 		clk_disable(data->clk_sec);
 
@@ -1042,7 +915,6 @@ static void exynos_tmu_work(struct work_struct *work)
 
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
-out:
 	enable_irq(data->irq);
 }
 
@@ -1077,15 +949,6 @@ static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
 	writel(val_irq, data->base + tmu_intclear);
 }
 
-static void exynos5440_tmu_clear_irqs(struct exynos_tmu_data *data)
-{
-	unsigned int val_irq;
-
-	val_irq = readl(data->base + EXYNOS5440_TMU_S0_7_IRQ);
-	/* clear the interrupts */
-	writel(val_irq, data->base + EXYNOS5440_TMU_S0_7_IRQ);
-}
-
 static irqreturn_t exynos_tmu_irq(int irq, void *id)
 {
 	struct exynos_tmu_data *data = id;
@@ -1105,7 +968,6 @@ static const struct of_device_id exynos_tmu_match[] = {
 	{ .compatible = "samsung,exynos5420-tmu", },
 	{ .compatible = "samsung,exynos5420-tmu-ext-triminfo", },
 	{ .compatible = "samsung,exynos5433-tmu", },
-	{ .compatible = "samsung,exynos5440-tmu", },
 	{ .compatible = "samsung,exynos7-tmu", },
 	{ /* sentinel */ },
 };
@@ -1130,8 +992,6 @@ static int exynos_of_get_soc_type(struct device_node *np)
 		return SOC_ARCH_EXYNOS5420_TRIMINFO;
 	else if (of_device_is_compatible(np, "samsung,exynos5433-tmu"))
 		return SOC_ARCH_EXYNOS5433;
-	else if (of_device_is_compatible(np, "samsung,exynos5440-tmu"))
-		return SOC_ARCH_EXYNOS5440;
 	else if (of_device_is_compatible(np, "samsung,exynos7-tmu"))
 		return SOC_ARCH_EXYNOS7;
 
@@ -1242,14 +1102,6 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 8;
 		break;
-	case SOC_ARCH_EXYNOS5440:
-		data->tmu_initialize = exynos5440_tmu_initialize;
-		data->tmu_control = exynos5440_tmu_control;
-		data->tmu_read = exynos5440_tmu_read;
-		data->tmu_set_emulation = exynos5440_tmu_set_emulation;
-		data->tmu_clear_irqs = exynos5440_tmu_clear_irqs;
-		data->ntrip = 4;
-		break;
 	case SOC_ARCH_EXYNOS7:
 		data->tmu_initialize = exynos7_tmu_initialize;
 		data->tmu_control = exynos7_tmu_control;
@@ -1267,8 +1119,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	 * Check if the TMU shares some registers and then try to map the
 	 * memory of common registers.
 	 */
-	if (data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO &&
-	    data->soc != SOC_ARCH_EXYNOS5440)
+	if (data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO)
 		return 0;
 
 	if (of_address_to_resource(pdev->dev.of_node, 1, &res)) {
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 5149c2a3030c..f3f830edd79a 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -34,7 +34,6 @@ enum soc_type {
 	SOC_ARCH_EXYNOS5420,
 	SOC_ARCH_EXYNOS5420_TRIMINFO,
 	SOC_ARCH_EXYNOS5433,
-	SOC_ARCH_EXYNOS5440,
 	SOC_ARCH_EXYNOS7,
 };
 
-- 
2.14.1
