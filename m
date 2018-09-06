Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49895C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0331320652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="sLIw0MnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0331320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbeIFRMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:12:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44121 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbeIFRMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:12:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so5209506pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 05:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i5CW7ot0bZc1KWxMcuk+xrMpDjm9at5IVA+yuFgxfU4=;
        b=sLIw0MnEAAPi/T3loITh7TJh7ojLv8M+8bvzI9JDvMM2H3WbeN/QpPBYG7Yx6T1rwD
         EOVONeVcmd80Q4rve2P9zNlfTer3+uiCXx2NBnT4WGoYvAr5pBBAFbmPlFHoz3toIO1n
         7TjNS3kJUyOoi9luD6MtRJpXwu4tiqNL2B3CLIV4hX/lyWyV+rE690LTdAsRkRuQswxQ
         ffoc109KKrRwgxVIBYtiVVXCANiX15aBpZ+GyLdrsaQbrtFH34Yu6Oh8GFxXFxZBU0i4
         Os9uc7cM4lpK9pAaF4WjF65MyUxoqngc2/Fv0wPhbnNGPlCXUWfNJiLWv53lYUI+bXyP
         4p7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i5CW7ot0bZc1KWxMcuk+xrMpDjm9at5IVA+yuFgxfU4=;
        b=C9wYMsw3AMpNIfzs56miM803wVBw8BqNKfGFmcoaU/GkN14OhP8GYKjqSq1K/aprdL
         Lamj9XV6IdSL+VqTGlVHEL7NBwMNO9V0NVZV6F2GbR5I8qhbpXgamFO3CWSp/DkuXDYF
         qqPT1NmQ2xVwdPhhfyRhaId23NJDrq1OLOvKtfCPwPBbqCZUFTORAk0joHPCn1u+jPBD
         ubFNZ7X5eGYcWWYjR6MzGUWnWCtOg0HGctgGJyQHlQJDdtdRcxkCV6hLJYBWfn3aXYlh
         RLN7tGe32pHymqRuYY6bjvU6+XjU7cMMTJRJAymPRyb3sjcbCdr+6n27ROJ8s/1jW20J
         6QYw==
X-Gm-Message-State: APzg51DNTLpIS61qFDn6BivvAJ4hnokHcigSIJZnfR1+yb6nh7zZ0D6M
        YaWLnfv9oUvndNNVcqUWUVWXew==
X-Google-Smtp-Source: ANB0VdZGQOp3nwqLpB8B8+dkf6jotC7LLPjrXD/4lkAmYi5C00NVN/jNndytZ3demHynBWKnNmNaCw==
X-Received: by 2002:a63:7353:: with SMTP id d19-v6mr2454357pgn.281.1536237442792;
        Thu, 06 Sep 2018 05:37:22 -0700 (PDT)
Received: from anup-ubuntu64.wlan.qualcomm.com ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id 193-v6sm11446165pgh.47.2018.09.06.05.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 05:37:21 -0700 (PDT)
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
Subject: [PATCH v2 2/5] RISC-V: No need to pass scause as arg to do_IRQ()
Date:   Thu,  6 Sep 2018 18:06:48 +0530
Message-Id: <20180906123651.28500-3-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180906123651.28500-1-anup@brainfault.org>
References: <20180906123651.28500-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scause is already part of pt_regs so no need to pass
scause as separate arg to do_IRQ().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kernel/entry.S | 1 -
 arch/riscv/kernel/irq.c   | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index fa2c08e3c05e..6eaacfa5b63d 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -168,7 +168,6 @@ ENTRY(handle_exception)
 
 	/* Handle interrupts */
 	move a0, sp /* pt_regs */
-	move a1, s4 /* scause */
 	tail do_IRQ
 1:
 	/* Exceptions run with interrupts enabled */
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index f5073dcbc560..d0de40e1e7f3 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -24,11 +24,11 @@
  */
 #define INTERRUPT_CAUSE_FLAG	(1UL << (__riscv_xlen - 1))
 
-asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long cause)
+asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
 
-	switch (cause & ~INTERRUPT_CAUSE_FLAG) {
+	switch (regs->scause & ~INTERRUPT_CAUSE_FLAG) {
 	case INTERRUPT_CAUSE_TIMER:
 		old_regs = set_irq_regs(regs);
 		irq_enter();
-- 
2.17.1

