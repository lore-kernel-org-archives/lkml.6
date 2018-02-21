Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965906AbeBUNvZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 08:51:25 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40743 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754658AbeBUNui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 08:50:38 -0500
X-Google-Smtp-Source: AH8x2266VB6xQRFbZ2Ahb72xv6Ixj74daghTtFjBtPFnk0Qx5VPBE/nMsc/qmqllbGEUBHFov+hkZw==
From: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: [PATCH 2/2] ARM: pinctrl: stm32: Optimizes and enhances stm32gpio irqchip
Date: Wed, 21 Feb 2018 14:50:27 +0100
Message-Id: <1519221027-4028-3-git-send-email-radoslaw.pietrzyk@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519221027-4028-1-git-send-email-radoslaw.pietrzyk@gmail.com>
References: <1519221027-4028-1-git-send-email-radoslaw.pietrzyk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	- removes unneeded irq_chip.irq_eoi callback
	- adds irq_chip.irq_set_wake callback for possible
	in the future GPIO wakeup

Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 617df16..5b1740d 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -268,10 +268,10 @@ static void stm32_gpio_irq_release_resources(struct irq_data *irq_data)
 
 static struct irq_chip stm32_gpio_irq_chip = {
 	.name           = "stm32gpio",
-	.irq_eoi	= irq_chip_eoi_parent,
 	.irq_mask       = irq_chip_mask_parent,
 	.irq_unmask     = irq_chip_unmask_parent,
 	.irq_set_type   = irq_chip_set_type_parent,
+	.irq_set_wake   = irq_chip_set_wake_parent,
 	.irq_request_resources = stm32_gpio_irq_request_resources,
 	.irq_release_resources = stm32_gpio_irq_release_resources,
 };
-- 
1.9.1
