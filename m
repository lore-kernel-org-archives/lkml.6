Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AF8C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1FE2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="SFxS6wu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1FE2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeK3TLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:11:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40896 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeK3TLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:11:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so2395930pfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lMAJpPkeXbFuvURRfJbfrtp/xBSKSRsVuvnhRc6stns=;
        b=SFxS6wu6QrPWQfl28NHZOLuzvYcc5IHvoKBoVzgU6Z+qFtN4IDpNxafnC+mj7ba1SQ
         KSqsDSPzg+mIvMwgwPdwA3VP3qwrbjBYOXP3NIqq0QaUqKiztCaedvteBp/mH26MBBrs
         oZjxmlPr8qu548LkXpr53hAmS762GB/mO4ULcgFEs6HyXltot17GZg5XNDwdGr+0KmHe
         e9JhjAnRfLFLVXDXSxFPwmqzCDQsJFdhFn2fXO34yVsBhtXrdnP9HYn82Wfmaw7wRgS3
         DZpzvK8wASRgFZR41lhI9oNS5c1ZdQL2+LWcF9KpJs9OcsPEp/9KI0A7KrDtnwQ8a05J
         BErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lMAJpPkeXbFuvURRfJbfrtp/xBSKSRsVuvnhRc6stns=;
        b=iCGiDDg4kFermLWM61//ehrrk3ByrMkKuunLJ9j2BCf8RqcjDn1ygfcoBjkjcdpSmT
         s6rFXLvtXcxLRMvsUAhnNkvzexu/YMB3M5dJtlvVwdlRvYzQVk+lR3IltHcaacJrcm/h
         fiTzn3O0aRIUzuXN4rMlyZ4J949IqwNHkLmAyOKXPXGuCx+erAhQZfwsbfY20Gzyo8yX
         5hQHOMlj6G28FHFq90RnDGc99u3pMtrLZHaVf0WtBMbI0VtbAYKG1+8JJo8xT5/81Zmt
         46DEERUG/u/ednlh79QXN/pWxZlsZzcN5jKE8tkKD28xAteP9WSdhWZDjoJGkge2LE8l
         XYcA==
X-Gm-Message-State: AA+aEWYY9Ee+jtKv8ko1/sO2xczhI9Joa6iwrolb78NsbYw6XLGEhU8O
        TYIor/c8vuuhzWQDCGxPauUvsA==
X-Google-Smtp-Source: AFSGD/UkXS06dwoA9Vc9rLmPQ8Dro3U/CzAEklnNoR3GBBxZQBrzULpEwg0QAav6T5dp2lppp4nFwg==
X-Received: by 2002:a63:6704:: with SMTP id b4mr4048021pgc.100.1543564956124;
        Fri, 30 Nov 2018 00:02:36 -0800 (PST)
Received: from anup-ubuntu64.qualcomm.com ([49.207.52.208])
        by smtp.googlemail.com with ESMTPSA id q187sm19218333pfq.128.2018.11.30.00.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 00:02:35 -0800 (PST)
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
Subject: [PATCH v3 4/6] irqchip: sifive-plic: Add warning in plic_init() if handler already present
Date:   Fri, 30 Nov 2018 13:32:05 +0530
Message-Id: <20181130080207.20505-5-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130080207.20505-1-anup@brainfault.org>
References: <20181130080207.20505-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have two enteries (one for M-mode and another for S-mode) in the
interrupts-extended DT property of PLIC DT node for each HART. It is
expected that firmware/bootloader will set M-mode HWIRQ line of each
HART to 0xffffffff (i.e. -1) in interrupts-extended DT property
because Linux runs in S-mode only.

If firmware/bootloader is buggy then it will not correctly update
interrupts-extended DT property which might result in a plic_handler
configured twice. This patch adds a warning in plic_init() if a
plic_handler is already marked present. This warning provides us
a hint about incorrectly updated interrupts-extended DT property.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 drivers/irqchip/irq-sifive-plic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index d4433399eb89..3d4f205f8abe 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -234,6 +234,11 @@ static int __init plic_init(struct device_node *node,
 
 		cpu = riscv_hartid_to_cpuid(hartid);
 		handler = per_cpu_ptr(&plic_handlers, cpu);
+		if (handler->present) {
+			pr_warn("handler not available for context %d.\n", i);
+			continue;
+		}
+
 		handler->present = true;
 		handler->hart_base =
 			plic.regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
-- 
2.17.1

