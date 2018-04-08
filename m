Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeDHHAD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 03:00:03 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:44175 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbeDHG77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 02:59:59 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
CC: Yixun Lan <yixun.lan@amlogic.com>, Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, Rob Herring <robh@kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] irqchip/meson-gpio: add support for Meson-AXG SoCs
Date: Sun, 8 Apr 2018 14:57:00 +0000
Message-ID: <20180408145700.23520-4-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180408145700.23520-1-yixun.lan@amlogic.com>
References: <20180408145700.23520-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Meson-AXG SoC uses the same GPIO interrupt controller IP block as the other
Meson SoCs. A total of 100 pins can be spied on, which is the sum of:
- 255:100 Undefined(no interrupt)
- 99:84, 16 pins on bank GPIOY
- 83:61, 23 pins on bank GPIOX
- 60:40, 21 pins on bank GPIOA
- 39:25, 15 pins on bank BOOT
- 24:14, 11 pins on bank GPIOZ
- 13:0 , 14 pins in the AO domain

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/irqchip/irq-meson-gpio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index a59bdbc0b9bb..7b531fd075b8 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -63,11 +63,16 @@ static const struct meson_gpio_irq_params gxl_params = {
 	.nr_hwirq = 110,
 };
 
+static const struct meson_gpio_irq_params axg_params = {
+	.nr_hwirq = 100,
+};
+
 static const struct of_device_id meson_irq_gpio_matches[] = {
 	{ .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
 	{ .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params },
 	{ .compatible = "amlogic,meson-gxbb-gpio-intc", .data = &gxbb_params },
 	{ .compatible = "amlogic,meson-gxl-gpio-intc", .data = &gxl_params },
+	{ .compatible = "amlogic,meson-axg-gpio-intc", .data = &axg_params },
 	{ }
 };
 
-- 
2.16.2
