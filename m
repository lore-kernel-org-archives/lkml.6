Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D67AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BF6208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fs6A57g3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23BF6208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732427AbeHBNl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:41:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39456 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732252AbeHBNl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iCUp1RxSOoZ/ZQKAtIpDDmRmceSbdKx72yYLlD3vono=; b=Fs6A57g3IrTcPKVdo4Yfp/acT
        /rNCsD33erjswi7bY1z7NR+Zt2Vd9Zr+zN05AxHvVpNohCgZrgMmCZBRQWoVO4FxSzUpNSoZuMAwv
        p7d0f1G1XYow+Dk0tzem7sDP9wYOb6mI9Df26H1GktvQkw6r78s37zc7co24d7cCqgCCTsS2pf4wA
        lxwI26bNggBb1kh8s5BR8WFkhbdVCF9U49N8gEYW63vFl4ItE7ev9uxpqQszgbfLR7qMvBaNercX3
        JbtpXv07A7x8Z0PXreyTuGdBPWZryuKgQLHql2j81lwh59U8ETuFUpY/ABTiJShQKZgmkMJ5qMeTT
        oW6QKuRyg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flC7m-0005HU-VT; Thu, 02 Aug 2018 11:50:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: [PATCH 06/11] RISC-V: remove INTERRUPT_CAUSE_* defines from asm/irq.h
Date:   Thu,  2 Aug 2018 13:50:03 +0200
Message-Id: <20180802115008.4031-7-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802115008.4031-1-hch@lst.de>
References: <20180802115008.4031-1-hch@lst.de>
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

