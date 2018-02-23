Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeBWIcP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:32:15 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37584 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbeBWIb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:31:57 -0500
X-Google-Smtp-Source: AG47ELu2IeJB3lgn2JhS3EIzZqPlNx5XMTJt34i3eRd5gMf+IBcV3/j1Z6wjMWOQGkK8cSYfKNAL7w==
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
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Ludovic BARRE <ludovic.barre@st.com>
Subject: [PATCH v2 2/2] pinctrl: stm32: Optimizes and enhances stm32gpio irqchip
Date: Fri, 23 Feb 2018 09:31:45 +0100
Message-Id: <c648235f538b030e7f349e286661fd00894d5316.1519374248.git.radoslaw.pietrzyk@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1519374248.git.radoslaw.pietrzyk@gmail.com>
References: <cover.1519374248.git.radoslaw.pietrzyk@gmail.com>
In-Reply-To: <cover.1519374248.git.radoslaw.pietrzyk@gmail.com>
References: <1519221027-4028-1-git-send-email-radoslaw.pietrzyk@gmail.com> <cover.1519374248.git.radoslaw.pietrzyk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- removes unneeded irq_chip.irq_eoi callback
- adds irq_chip.irq_set_wake callback for possible
in the future GPIO wakeup
- adds irq_chip.irq_ack callback

Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 617df16..6cbcff4 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -268,10 +268,11 @@ static void stm32_gpio_irq_release_resources(struct irq_data *irq_data)
 
 static struct irq_chip stm32_gpio_irq_chip = {
 	.name           = "stm32gpio",
-	.irq_eoi	= irq_chip_eoi_parent,
+	.irq_ack       = irq_chip_ack_parent,
 	.irq_mask       = irq_chip_mask_parent,
 	.irq_unmask     = irq_chip_unmask_parent,
 	.irq_set_type   = irq_chip_set_type_parent,
+	.irq_set_wake   = irq_chip_set_wake_parent,
 	.irq_request_resources = stm32_gpio_irq_request_resources,
 	.irq_release_resources = stm32_gpio_irq_release_resources,
 };
-- 
1.9.1
