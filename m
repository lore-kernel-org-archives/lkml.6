Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BC9C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 05:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1072086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 05:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="c9iglgff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfASF5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 00:57:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37048 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfASF5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 00:57:14 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so7642331pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 21:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QPq/o0R9ggNlb2oMRGbkSeTpgM0rzBY83T9WPQ+nWrg=;
        b=c9iglgffLpFLhSbvvzWlFeS/AvjO1P40S00smgVlLs3YsQBwjZMXqbP/aAAXhAhoaU
         sKCAXePv6bS9r+kmQxgtpiCwwGLxGZXp18KdPCWPBXk+TdXZmD/7a0tuyJQ0d8R87xnr
         Q07fJcQPr9WP5xf5QruBLirguXjfdTkl/nCWXHQXBo05DtYfxtdR562jSwn/QG2Kt4n9
         SXqkAy/msiA/fclUCpM8xKtfjqpzZnHtdmGNkRFjfrx47tJrq76JfHYFCdmYsDT13s7T
         tdwo5AXFp3mV+gX8qwruOOmNRzuHiJz0djr8IRmL84vE+A5Lpx0b7h/WeDJGL4Spqm87
         KbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QPq/o0R9ggNlb2oMRGbkSeTpgM0rzBY83T9WPQ+nWrg=;
        b=Srov1nHBXYUNyzTXZwHnzVEScZxyCswkIwsoda4DL1KGZbvEaR/nw7zBqoPH0WVwCI
         8SiWnoBu/WQnm5SNe4UkVhq+XXWRwwF1lmzIg/yGC5Hbjb3BlPqe8diRL7YtB+6IQIJJ
         vyrQ3qAOVwZN9oxVHelft7ttJp1wkZqjkIdt9WOSxuI4WWx33V9UMk2Ko7nOIKbA91aK
         B7N/w17VugruzWKbYlUUWHn+HUSUHwKIE+ob/pXVHn56ObI2eCHsLHCEiH54yZ7qIj3a
         +SvWZfPBqb+cIM3g3IOxwnZvvm+RhaFBfwDKnEYM9jCp4lJH2GjK4PuZsuerheziKsGG
         J8yw==
X-Gm-Message-State: AJcUukfqCuz+mcuCEIh5vUbAbgxxa19l8bG/Hznst3G1MdpJkddi+Xtn
        uVerwBRjVQK1NmCKkt7YRL12Lw==
X-Google-Smtp-Source: ALg8bN6JYdjBjQL1iTQMTWXvrOTiU/Fa0DfbRJm4zuIRUgdZLqvPh2JyNaWwYssKxs/5vtkL9ZBrAQ==
X-Received: by 2002:a63:f412:: with SMTP id g18mr20671728pgi.262.1547877432781;
        Fri, 18 Jan 2019 21:57:12 -0800 (PST)
Received: from localhost.localdomain ([49.207.51.221])
        by smtp.gmail.com with ESMTPSA id c7sm9295535pfh.18.2019.01.18.21.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 21:57:12 -0800 (PST)
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
Subject: [PATCH v5 3/5] irqchip: sifive-plic: Add warning in plic_init() if handler already present
Date:   Sat, 19 Jan 2019 11:26:23 +0530
Message-Id: <20190119055625.100054-4-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190119055625.100054-1-anup@brainfault.org>
References: <20190119055625.100054-1-anup@brainfault.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/irqchip/irq-sifive-plic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 01bbbbffbcae..b9a0bcefe426 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -229,6 +229,11 @@ static int __init plic_init(struct device_node *node,
 
 		cpu = riscv_hartid_to_cpuid(hartid);
 		handler = per_cpu_ptr(&plic_handlers, cpu);
+		if (handler->present) {
+			pr_warn("handler already present for context %d.\n", i);
+			continue;
+		}
+
 		handler->present = true;
 		handler->hart_base =
 			plic_regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
-- 
2.17.1

