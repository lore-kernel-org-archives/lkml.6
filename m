Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B766C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32DF2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="clu9Clm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfBLMxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:53:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34916 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbfBLMxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:53:11 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so1275039plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 04:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KN7W2zftQeNZmthGr7261iLl0/Bm6gqlbkD5vYrU3Gg=;
        b=clu9Clm+93UAt2QM1XWrn1vYPSq8oKz3lHcIePW3ElbCv/vD1r/1EAYTg4Dsy8ZvyV
         PzCZ7vqUm9CIxcohKr3rfqfPZPBiNLyr9MYaqSiWF8zX9o9Kzeb00pXDXUIk+uQ+EBCF
         +Oh/zxkUTtWxZHDLdCNVbt4CivKTEBMeosjUlv8wIrXzaWiyN0zI26MRyg/OGMoiU84K
         lmDfJ6Kdqt5+hSGJg3U7R/49sSxcfwwZYCzCaKwoVLXP6n9ZeGmzQjTLQ2epB0JNxKVa
         WAuThza2V7FR07Xmco8aD1OZR5aLpGz2hx3HVz88gT9TklF6RP6Y/hGESlTNI28YJqah
         oXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KN7W2zftQeNZmthGr7261iLl0/Bm6gqlbkD5vYrU3Gg=;
        b=HOpnKSwkWdGPht2Jpfdtd/CwXXU7cS31DJhkZAbbhms1duCKyxlzJewe1DTjFacg6a
         EYsFM8qIlV19UiTgrooZYiqJ4H6NGT37R1TZGFVHtLDeXh/umiD7dpcut3LL7Qjr6Vuq
         9sUh1IThSMVXQlxLIoqVVytwuKonNgN1c33islfWyU5eg81Ms9yryD4eLADU6idZGwUo
         AC2qg11LpiwN7Jl2nepTq6hpFYX7UblPdlT+2QSi1Tkooke4PksHp+H7G3FXc5LHmLB0
         2xreTbUv3YKvxnbq2HOKFblmHfGrXH7tAF3QBV5ZRbEpVerwALJYwjtz/XGh1hP9z6R3
         QCgQ==
X-Gm-Message-State: AHQUAuZg6RK248kbjsF8KVhsqUBYVGN70gGNta+k+PpiDQOCotX+0I2H
        NKd1tmw5iacXNMikA6nDbg8HBA==
X-Google-Smtp-Source: AHgI3IZXlLtSjUmye988PQqP+32ZggHZf2XeImz4rG1qXMbBln/IxB0Jf0Xl+N9odDXR/sJQCv2bCA==
X-Received: by 2002:a17:902:8303:: with SMTP id bd3mr4030967plb.10.1549975990187;
        Tue, 12 Feb 2019 04:53:10 -0800 (PST)
Received: from localhost.localdomain ([49.207.48.205])
        by smtp.gmail.com with ESMTPSA id z67sm27894828pfd.188.2019.02.12.04.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 04:53:09 -0800 (PST)
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
Subject: [PATCH v6 2/4] irqchip: sifive-plic: Add warning in plic_init() if handler already present
Date:   Tue, 12 Feb 2019 18:22:44 +0530
Message-Id: <20190212125246.69239-3-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212125246.69239-1-anup@brainfault.org>
References: <20190212125246.69239-1-anup@brainfault.org>
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
index c23a293a2aae..da09f46fad64 100644
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

