Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7496FC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB2220673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZPf1R82c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB2220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbeGZPyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:54:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57300 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbeGZPyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x+WznFoFquYzZMKHKDtQXuiW8Nghf0FEVyG7kqGigbI=; b=ZPf1R82ct+uMn/haDT6MexUkf
        /wKCMiYFzwRjwQ4ShEY3CPfEguAf/voGvh80W9lWo8amTl4iWEvCV820XNF2TA85s4Jqs57CXF8cw
        UI8CmfzyxCwCLgbRI9I1OvVNxT1avEg0C76yz82hz98gqd5OuMgUkTGx0MMRlKgx8LZ83UZtNWwTj
        dCgEQuAo9lN6p1f5Jkx6+TQU+7T872jclfJmyogbbIiUOKebWkX93xJMzIyq7bAPpayr22pGHjzpJ
        fg5rwuYJTRjWGF5HZX1y6Ei7fZOi+3y6ZlYrpEtz7G7+JaqfsMJCpQs1Cb5+PU1w79P51PGsw0xiM
        r7n8vBs7g==;
Received: from 213-225-8-157.nat.highway.a1.net ([213.225.8.157] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fihOV-0005g4-IK; Thu, 26 Jul 2018 14:37:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: [PATCH 1/9] RISC-V: remove timer leftovers
Date:   Thu, 26 Jul 2018 16:37:15 +0200
Message-Id: <20180726143723.16585-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726143723.16585-1-hch@lst.de>
References: <20180726143723.16585-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code is currently unused and will be added back later in a different
place with the real interrupt and clocksource support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/kernel/time.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
index 2463fcca719e..0df9b2cbd645 100644
--- a/arch/riscv/kernel/time.c
+++ b/arch/riscv/kernel/time.c
@@ -13,32 +13,11 @@
  */
 
 #include <linux/clocksource.h>
-#include <linux/clockchips.h>
 #include <linux/delay.h>
-
-#ifdef CONFIG_RISCV_TIMER
-#include <linux/timer_riscv.h>
-#endif
-
 #include <asm/sbi.h>
 
 unsigned long riscv_timebase;
 
-DECLARE_PER_CPU(struct clock_event_device, riscv_clock_event);
-
-void riscv_timer_interrupt(void)
-{
-#ifdef CONFIG_RISCV_TIMER
-	/*
-	 * FIXME: This needs to be cleaned up along with the rest of the IRQ
-	 * handling cleanup.  See irq.c for more details.
-	 */
-	struct clock_event_device *evdev = this_cpu_ptr(&riscv_clock_event);
-
-	evdev->event_handler(evdev);
-#endif
-}
-
 void __init init_clockevent(void)
 {
 	timer_probe();
-- 
2.18.0

