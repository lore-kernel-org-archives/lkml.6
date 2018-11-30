Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A59C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E932082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="yTXZdN85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E932082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeK3TLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:11:14 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33741 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeK3TLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:11:14 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so2421614plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vvfSG98aNiXqSmgABJxQO+jhN81ElYo6VSgb9BxCS6Q=;
        b=yTXZdN85ZwFfIRh1qgNRjeFsJKWoxepZuxHlpZbdmay2uZ4LPGUS17QOI5fEb8RIVA
         +VMW0K/qzALTAekgIyXWtxC+Dheb5KM5+t/QqGIrTXPOsK/27eRj/k70dKhjICK53We4
         jnhD5aRliWYYOdbUmiwEVkkCrzhHL/LK/9oOhc8hMqTQW2wJHZQdoR7GBs3XX0ExRRwJ
         hI4NyChD4BwPfTXTsoTHgYx+tHcWUHshM9+ExCJ7gRHutJ81gtW9m4QpWqEkY0eDefyb
         Iy/R2s/D0gkuYK90IhcQatA5BKrjmaI1nStvIPH+0AzC72RUjRdZuM38KIUaB2XeEYsK
         wclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vvfSG98aNiXqSmgABJxQO+jhN81ElYo6VSgb9BxCS6Q=;
        b=jZR6udVPOCPBLPNuofETcMhOKEc2ZBH7BUW5q26IxqiIXW54EvcLIRSLIWR7rtzGpp
         2y5ybUoUTkoaIUEhJClrDnBk5sQe9AmqcucRgW0u/HSgkwX3N/EjGrgidDficHyj71NB
         fbcW0K/oa/OcCKDWlvdAwtX+xaHXR54CTWegtIpU1blBgEX9CKq0DHz44b1ynCyZs5sB
         65TfJhUqjx69/NKr8k5zdZUt2eSWDFQt93OBX2bvS51+aKE9QSzbZjC3CsVYsN+EAhWN
         43WA/Wml18dVmnswxwrpOtKEKskRBZrmQ5qi9GKDPaxO/QZBkCzRe1Q7XUKRllk8ps0R
         Kvgg==
X-Gm-Message-State: AA+aEWblJB4R+obV1k0IqxkzEEi9vrg8SoC7gR0tKeVpr935JRwX4Fr/
        snfYHG2HipfNIj0SGn17814cvA==
X-Google-Smtp-Source: AFSGD/Xoui3ezebGaCOi5/CYqeIairgBmj5UztDHX+apMQ33KkcwVugVt3KsDrNoDP5r/wC6hhdNbQ==
X-Received: by 2002:a17:902:784d:: with SMTP id e13mr4792786pln.188.1543564966690;
        Fri, 30 Nov 2018 00:02:46 -0800 (PST)
Received: from anup-ubuntu64.qualcomm.com ([49.207.52.208])
        by smtp.googlemail.com with ESMTPSA id q187sm19218333pfq.128.2018.11.30.00.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 00:02:46 -0800 (PST)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH v3 6/6] irqchip: sifive-plic: Implement irq_set_affinity() for SMP host
Date:   Fri, 30 Nov 2018 13:32:07 +0530
Message-Id: <20181130080207.20505-7-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130080207.20505-1-anup@brainfault.org>
References: <20181130080207.20505-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on SMP host, all CPUs take external interrupts routed via
PLIC. All CPUs will try to claim a given external interrupt but only
one of them will succeed while other CPUs would simply resume whatever
they were doing before. This means if we have N CPUs then for every
external interrupt N-1 CPUs will always fail to claim it and waste
their CPU time.

Instead of above, external interrupts should be taken by only one CPU
and we should have provision to explicitly specify IRQ affinity from
kernel-space or user-space.

This patch provides irq_set_affinity() implementation for PLIC driver.
It also updates irq_enable() such that PLIC interrupts are only enabled
for one of CPUs specified in IRQ affinity mask.

With this patch in-place, we can change IRQ affinity at any-time from
user-space using procfs.

Example:

/ # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  8:         44          0          0          0  SiFive PLIC   8  virtio0
 10:         48          0          0          0  SiFive PLIC  10  ttyS0
IPI0:        55        663         58        363  Rescheduling interrupts
IPI1:         0          1          3         16  Function call interrupts
/ #
/ #
/ # echo 4 > /proc/irq/10/smp_affinity
/ #
/ # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  8:         45          0          0          0  SiFive PLIC   8  virtio0
 10:        160          0         17          0  SiFive PLIC  10  ttyS0
IPI0:        68        693         77        410  Rescheduling interrupts
IPI1:         0          2          3         16  Function call interrupts

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 drivers/irqchip/irq-sifive-plic.c | 35 +++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 17269622be21..c5bbb12e74e0 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -106,14 +106,42 @@ static void plic_irq_toggle(const struct cpumask *mask, int hwirq, int enable)
 
 static void plic_irq_enable(struct irq_data *d)
 {
-	plic_irq_toggle(irq_data_get_affinity_mask(d), d->hwirq, 1);
+	unsigned int cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
+					   cpu_online_mask);
+	WARN_ON(cpu >= nr_cpu_ids);
+	plic_irq_toggle(cpumask_of(cpu), d->hwirq, 1);
 }
 
 static void plic_irq_disable(struct irq_data *d)
 {
-	plic_irq_toggle(irq_data_get_affinity_mask(d), d->hwirq, 0);
+	plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
 }
 
+#ifdef CONFIG_SMP
+static int plic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
+			    bool force)
+{
+	unsigned int cpu;
+
+	if (!force)
+		cpu = cpumask_any_and(mask_val, cpu_online_mask);
+	else
+		cpu = cpumask_first(mask_val);
+
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	if (!irqd_irq_disabled(d)) {
+		plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
+		plic_irq_toggle(cpumask_of(cpu), d->hwirq, 1);
+	}
+
+	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	return IRQ_SET_MASK_OK_DONE;
+}
+#endif
+
 static struct irq_chip plic_chip = {
 	.name		= "SiFive PLIC",
 	/*
@@ -122,6 +150,9 @@ static struct irq_chip plic_chip = {
 	 */
 	.irq_enable	= plic_irq_enable,
 	.irq_disable	= plic_irq_disable,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = plic_set_affinity,
+#endif
 };
 
 static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
-- 
2.17.1

