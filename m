Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367C0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CD220659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="TmYlY5CV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CD220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeIDRKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:10:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38919 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeIDRKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:10:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id w14-v6so1593975plp.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 05:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t6EBfeBsA49RIXJWUgN9zEEfw2Bjd/ZXXD+zuv1ABCM=;
        b=TmYlY5CVX1BOpRClmA3iRDBCcfK1lRAV3coeNKt4HZjJnOyk3/7qphMK7tRn6C4HQd
         XUpSyCxGhBDUWJIr1+MFDLfGdHi/QjQUay26iXwUGGt1WV/4X8YvF+b2upSpc5uxxu26
         kUXRBCXZmZ271XvhbEf1wGMsnvSoJ6mpcmSjtJCD87IHtNi88u7N50N/hhxY5bExI2+h
         ej9iOsMqZpeV7OqHQ/yVWrmL/AhogHw2ZxCaN72OL/6My9N11KzQ4IoAs0IU51xzs1sv
         ImKEBPIJA/oGY0Xkh21xSLyCjAJMWETvrZ4U/31pvWzFXBozbL5iWepl4E+8byAD3CyT
         klMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t6EBfeBsA49RIXJWUgN9zEEfw2Bjd/ZXXD+zuv1ABCM=;
        b=JQDTp/8acuFz9y2IaEaRkC4VgyAU30DE/hDlqWiZxJMwz4T2I8MGb0NLvBEhW7uKdz
         dBCov5HEZPyv16TcWyfNcj5nNgSaeIP02t2rNbXi/IeeewPuC0di2VrbHR1yPpvMIg2P
         g60v1XuHfigfcjZiVaI0kkHmKi6NyBuJphsh/LNHUQ/CG1EZeqJCXtxwPgBltiI4Yj/w
         x+V9aOAFqPf68f4KE8pSoTTyIDqrIcZ+x8jsnSg27YKYcELXBz0FNscP7kJtClOLZmTR
         UQWQ+rTl2yF4Lv6VJAVTzs9Qs/7OdZXFxKt/0G9Hm1uowjFwTOCDt9fh6deF52Q3I0tI
         GrSA==
X-Gm-Message-State: APzg51AxvK3YAK8FmowaJLRIrEO+anUZUnJN3csEK6wawp20HQBK7TtJ
        aLkmJCaFq1KTjZEGgd3hZkDzhA==
X-Google-Smtp-Source: ANB0VdYdJc9YuTtiTcXuAuyG0qwZhNP+l+CVKHsqWqsSq6Ep+RbunjWxdWBSW0P8pQR/YqvhubGVaQ==
X-Received: by 2002:a17:902:758a:: with SMTP id j10-v6mr34132116pll.281.1536065154813;
        Tue, 04 Sep 2018 05:45:54 -0700 (PDT)
Received: from anup-ubuntu64.wlan.qualcomm.com ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id p11-v6sm31621773pfj.72.2018.09.04.05.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 05:45:54 -0700 (PDT)
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
Subject: [RFC PATCH 2/5] RISC-V: No need to pass scause as arg to do_IRQ()
Date:   Tue,  4 Sep 2018 18:15:11 +0530
Message-Id: <20180904124514.6290-3-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180904124514.6290-1-anup@brainfault.org>
References: <20180904124514.6290-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scause is already part of pt_regs so no need to pass
scause as separate arg to do_IRQ().

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
index 5532e7cedaec..c51c9b402e87 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -26,11 +26,11 @@
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

