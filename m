Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752465AbeBICK6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 21:10:58 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42223 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752239AbeBICK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 21:10:57 -0500
X-Google-Smtp-Source: AH8x225+0a4woUk1KBd7b3+yeCbliUYP2Ncz76I8OMKbHyV0UYEaO866Le41XWOCmNyQWtBu38kk+w==
From: Jaedon Shin <jaedon.shin@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH] irqchip: Use %px to print pointer value
Date: Fri,  9 Feb 2018 11:10:31 +0900
Message-Id: <20180209021031.20631-1-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
pointers printed with %p are hashed. Use %px instead of %p to print
pointer value.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/irqchip/irq-bcm7038-l1.c | 2 +-
 drivers/irqchip/irq-bcm7120-l2.c | 2 +-
 drivers/irqchip/irq-brcmstb-l2.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 55cfb986225b..f604c1d89b3b 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -339,7 +339,7 @@ int __init bcm7038_l1_of_init(struct device_node *dn,
 		goto out_unmap;
 	}
 
-	pr_info("registered BCM7038 L1 intc (mem: 0x%p, IRQs: %d)\n",
+	pr_info("registered BCM7038 L1 intc (mem: 0x%px, IRQs: %d)\n",
 		intc->cpus[0]->map_base, IRQS_PER_WORD * intc->n_words);
 
 	return 0;
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 983640eba418..1cc4dd1d584a 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -318,7 +318,7 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 		}
 	}
 
-	pr_info("registered %s intc (mem: 0x%p, parent IRQ(s): %d)\n",
+	pr_info("registered %s intc (mem: 0x%px, parent IRQ(s): %d)\n",
 			intc_name, data->map_base[0], data->num_parent_irqs);
 
 	return 0;
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 691d20eb0bec..6760edeeb666 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -262,7 +262,7 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 		ct->chip.irq_set_wake = irq_gc_set_wake;
 	}
 
-	pr_info("registered L2 intc (mem: 0x%p, parent irq: %d)\n",
+	pr_info("registered L2 intc (mem: 0x%px, parent irq: %d)\n",
 			base, parent_irq);
 
 	return 0;
-- 
2.16.1
