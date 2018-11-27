Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41300C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A842146F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="sO0/VK35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A842146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbeK0VBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:01:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41723 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbeK0VBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:01:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so8106485pfi.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 02:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dN98w9I5INwpkhNGUkRMYFLzjCSv+OZAezmuQZQ+ddo=;
        b=sO0/VK35tm2AheeAcYzA8s7RURZ57m91yq8ZClthssKGmyBE/DzDNmWwXICHAPEoCT
         wgCE4TCmHXWEsQh/920Likcc1cCtzDSq+/w/o29GX/wO5Az2cNv62WorklTHu+Al65Qn
         9tioKsYLZPceBNI9WHETYbmRNDkJr++BMPGMcSVXow0f5v/84qUbOieKHEVekdxl/xwJ
         +roGcwklYBi97zCAM3eFGvFshTZ4z7QUuxExXyJBjbTTlz4+iPHm6jmXcAizx+Tn1V29
         2dHNfyWUwEnudRQvw9e+LzD/xbWsruDA4O/vfFISTUBwFw0KnuspwIdKy5nmV7Sit+3s
         cDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dN98w9I5INwpkhNGUkRMYFLzjCSv+OZAezmuQZQ+ddo=;
        b=MTPIoSZLUnO9MCrFHztpN8JIWhKSrTARl4QkQbVRR5Sq7O2LvU/5kMlBGVUIglpMdM
         XQdJtHrna+o2Rn7FPSN9ylNdRWrzK6J8qgmjRSnWBPTSLvfdFE3Ro5+XgKIoQjVRGQNc
         kmhpjTEQDPbK25tRt6rXsp5rmwokdZdzhYFQhvu4+rbQHL2gXo8ETSLCmDtOCZafLt2c
         UK8WQiXA4QrGReL33lJi5HsDTKgE5Vr1FrAyBZeJMtyR1Q5DROGxYOB29OROmITqPpLj
         iK6tf9JXhmTwQ7dBvRibc10t4p5xMEelwKPAYJkGl899P+eLU514mHVQi75a1Y0OyV0M
         LwVg==
X-Gm-Message-State: AA+aEWYEZ0vpMku8gfBlB+KqLjBX29SfJNzO8q8fJqtQqjo1apFKaKWa
        rQo7jSliX/HtjukBDLiIBUEHiQ==
X-Google-Smtp-Source: AFSGD/VWhAb0ja271OBzyvwMk5MnCTwXQ7xN2UawQd5izyWUcv400qLQFMnJKNH+y569tQY8t3i/Zg==
X-Received: by 2002:a63:6ecf:: with SMTP id j198mr29093500pgc.3.1543313029266;
        Tue, 27 Nov 2018 02:03:49 -0800 (PST)
Received: from anup-ubuntu64.qualcomm.com ([49.207.48.241])
        by smtp.googlemail.com with ESMTPSA id t87sm9519590pfk.122.2018.11.27.02.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 02:03:48 -0800 (PST)
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
Subject: [PATCH v2 4/4] irqchip: sifive-plic: Implement irq_set_affinity() for SMP host
Date:   Tue, 27 Nov 2018 15:33:17 +0530
Message-Id: <20181127100317.12809-5-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181127100317.12809-1-anup@brainfault.org>
References: <20181127100317.12809-1-anup@brainfault.org>
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
and we should have provision to explicity specify IRQ affinity from
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
index ffd4deaca057..fec7da3797fa 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -98,14 +98,42 @@ static void plic_irq_toggle(const struct cpumask *mask, int hwirq, int enable)
 
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
@@ -114,6 +142,9 @@ static struct irq_chip plic_chip = {
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

