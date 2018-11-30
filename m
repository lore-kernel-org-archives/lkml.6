Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAE5C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0711C2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="wjl1UJN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0711C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbeK3TK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:10:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42686 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeK3TK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:10:58 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so2389553pfr.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T0WD9iFbcYcBF+9tnjwvFYL8QS9M8hvpmA7nOVXSSFo=;
        b=wjl1UJN5WECuRxVrxFO9Md5dOpl1rJKgaQyV8B7tM0/JjOOV/jLOt/XmZji9lZGs48
         awFXpiHCYYrVS8Bi2booEEZuIE0iJ6XsosqhWClkw3OonRcuZ1r9PTfBckCsRpVSUJsV
         NzwlRA/e6RUUHH3h7ctHFjbtu/AmUFdcOaLT5enpMwaAJtHQ7PE7S1yUAHjnSN/NbMMU
         t6NbxUckG7WZe3/fwzN4rO1qurr8osenXi1Pqxn4mxlGBxt1+VOyg8eBu20/m1xP3ABV
         mwvBNYweGfVg74nXfCOtRsWt7WkxqbWMZD7XsynMBO/faOwBlZm/1NwdgifBLnqJCGyF
         1p+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T0WD9iFbcYcBF+9tnjwvFYL8QS9M8hvpmA7nOVXSSFo=;
        b=fhOd0q0xMctIeG3ICWpAVMLNxXsCIS5/AvaDqOtxYOJSTHZB1v5wFZsWiw5Q3PdSqq
         ISegNv3WppZC7X0MbmS9sFLkTsvtojP658SKk2nBG9ZSUk9nrpzALtjdA95Z/o52RJ6d
         zMtm41kspZ9Qfrloy0fkqCAem+YIhuakgW9Ug6hnOHozu+gcihdVYBYeWC4QCbof0zLX
         F5xFbW8ikT/zH5qa6uYyQgB27rGeR7A5UQA2QZPLkC3PpbiLHUpoE0++IkV8LqiL6Fpd
         hL+uRIzYWpg+Nakknz+hYxjcfJMzXBYei+W/c4Mob8iNIAejNhlhgRCQ7HO+vzb0OMDb
         WT3A==
X-Gm-Message-State: AA+aEWYuCXaoRAwya13ZE7/8U0MG1gzPGm2gyP6CBa6gKRhvj8XPdWja
        LtwZrQglszJZUkk6fjSij6Q/JA==
X-Google-Smtp-Source: AFSGD/UU/M4HBSQV/wbUYfbV4VJLosqQcHkSBmI/FPBg+p0zHXEzcPdn/OHc+YgH8fUfZ3CUYFRP7Q==
X-Received: by 2002:a63:4e41:: with SMTP id o1mr2895034pgl.282.1543564950998;
        Fri, 30 Nov 2018 00:02:30 -0800 (PST)
Received: from anup-ubuntu64.qualcomm.com ([49.207.52.208])
        by smtp.googlemail.com with ESMTPSA id q187sm19218333pfq.128.2018.11.30.00.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 00:02:30 -0800 (PST)
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
Subject: [PATCH v3 3/6] irqchip: sifive-plic: More flexible plic_irq_toggle()
Date:   Fri, 30 Nov 2018 13:32:04 +0530
Message-Id: <20181130080207.20505-4-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130080207.20505-1-anup@brainfault.org>
References: <20181130080207.20505-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We make plic_irq_toggle() more generic so that we can enable/disable
hwirq for given cpumask. This generic plic_irq_toggle() will be
eventually used to implement set_affinity for PLIC driver.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 drivers/irqchip/irq-sifive-plic.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 48bee877e0f1..d4433399eb89 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -78,8 +78,7 @@ struct plic_hw {
 
 static struct plic_hw plic;
 
-static inline void plic_toggle(struct plic_handler *handler,
-				int hwirq, int enable)
+static void plic_toggle(struct plic_handler *handler, int hwirq, int enable)
 {
 	u32 __iomem *reg = handler->enable_base + (hwirq / 32) * sizeof(u32);
 	u32 hwirq_mask = 1 << (hwirq % 32);
@@ -92,27 +91,27 @@ static inline void plic_toggle(struct plic_handler *handler,
 	raw_spin_unlock(&handler->enable_lock);
 }
 
-static inline void plic_irq_toggle(struct irq_data *d, int enable)
+static void plic_irq_toggle(const struct cpumask *mask, int hwirq, int enable)
 {
 	int cpu;
 
-	writel(enable, plic.regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
-	for_each_cpu(cpu, irq_data_get_affinity_mask(d)) {
+	writel(enable, plic.regs + PRIORITY_BASE + hwirq * PRIORITY_PER_ID);
+	for_each_cpu(cpu, mask) {
 		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
 
 		if (handler->present)
-			plic_toggle(handler, d->hwirq, enable);
+			plic_toggle(handler, hwirq, enable);
 	}
 }
 
 static void plic_irq_enable(struct irq_data *d)
 {
-	plic_irq_toggle(d, 1);
+	plic_irq_toggle(irq_data_get_affinity_mask(d), d->hwirq, 1);
 }
 
 static void plic_irq_disable(struct irq_data *d)
 {
-	plic_irq_toggle(d, 0);
+	plic_irq_toggle(irq_data_get_affinity_mask(d), d->hwirq, 0);
 }
 
 static struct irq_chip plic_chip = {
-- 
2.17.1

