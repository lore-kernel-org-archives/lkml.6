Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A824EC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 08:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5F4217BF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 08:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HPQEb7Yf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5F4217BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbeHDKX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 06:23:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbeHDKX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 06:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iCUp1RxSOoZ/ZQKAtIpDDmRmceSbdKx72yYLlD3vono=; b=HPQEb7YfL+WfYwZdbfK14ZRB8
        sDJYdkhtM5Wyo7TRosaMdJyuiBBcr58DrcfajyXllzt4arNly3YIMtDVlD6KJ7awcszw7UTi4AaDD
        LPx28lxD9MLHy3HVrZIHE8XsfA0lFOPq7FgserZ7TzvC3AbKgGDXCxFgJXiZD0qgksupW6RFJdxzw
        I0lw5evGc4qt+A+F9AcEAxRPeIn8Hx5lK5b1JtS+OaXWYCYKXGagRoIyIfMU/+x49ftAlQfxT3O6h
        BLNiNh8msVYCfeNxse0qZM73MpT+cRi4rh26aIcI3jKAGQMpID0vqQWFgKoJrsrTmYGwH1ZHd88KX
        Mq0qV9PWg==;
Received: from [46.125.249.69] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flrqW-0003g1-G8; Sat, 04 Aug 2018 08:23:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: [PATCH 3/8] RISC-V: remove INTERRUPT_CAUSE_* defines from asm/irq.h
Date:   Sat,  4 Aug 2018 10:23:14 +0200
Message-Id: <20180804082319.5711-4-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082319.5711-1-hch@lst.de>
References: <20180804082319.5711-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are only of use to the local irq controller driver, so add them in
that driver implementation instead, which will be submitted soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/irq.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index c871661c9df4..996b6fbe17a6 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -17,10 +17,6 @@
 
 #define NR_IRQS         0
 
-#define INTERRUPT_CAUSE_SOFTWARE    1
-#define INTERRUPT_CAUSE_TIMER       5
-#define INTERRUPT_CAUSE_EXTERNAL    9
-
 void riscv_timer_interrupt(void);
 void riscv_software_interrupt(void);
 
-- 
2.18.0

