Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756884AbeDZQT4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:19:56 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52642 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756848AbeDZQT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:19:29 -0400
From: Ludovic Barre <ludovic.Barre@st.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald BAEZA <gerald.baeza@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Ludovic Barre" <ludovic.barre@st.com>
Subject: [PATCH 09/11] pinctrl: stm32: add irq_eoi for stm32gpio irqchip
Date: Thu, 26 Apr 2018 18:18:32 +0200
Message-ID: <1524759514-12392-10-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524759514-12392-1-git-send-email-ludovic.Barre@st.com>
References: <1524759514-12392-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-26_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

-Parent domain of stm32gpio evolves to hierarchy domain
 and could have a handle_fasteoi_irq. So an irq_eoi parent callback
 is needed for children.
-Replace space by tabulation.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 6cbcff4..dfed609 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -267,12 +267,13 @@ static void stm32_gpio_irq_release_resources(struct irq_data *irq_data)
 }
 
 static struct irq_chip stm32_gpio_irq_chip = {
-	.name           = "stm32gpio",
-	.irq_ack       = irq_chip_ack_parent,
-	.irq_mask       = irq_chip_mask_parent,
-	.irq_unmask     = irq_chip_unmask_parent,
-	.irq_set_type   = irq_chip_set_type_parent,
-	.irq_set_wake   = irq_chip_set_wake_parent,
+	.name		= "stm32gpio",
+	.irq_eoi	= irq_chip_eoi_parent,
+	.irq_ack	= irq_chip_ack_parent,
+	.irq_mask	= irq_chip_mask_parent,
+	.irq_unmask	= irq_chip_unmask_parent,
+	.irq_set_type	= irq_chip_set_type_parent,
+	.irq_set_wake	= irq_chip_set_wake_parent,
 	.irq_request_resources = stm32_gpio_irq_request_resources,
 	.irq_release_resources = stm32_gpio_irq_release_resources,
 };
-- 
2.7.4
