Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AD0C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A59D208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D55rvR25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A59D208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbeHBNld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:41:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39564 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732252AbeHBNlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U6fW/izvP24EZMoN+Wixchj0VutMhM57U48S9KuzyDA=; b=D55rvR25FVZPW33JhfQEXzR1i
        npsyzzMmmIbCuypt9O2zPdF36xuBreNvxe/72zq2o86grSbZbCLPVW+s310ztEF7iAG9pZSq+iLA1
        E3ElCs6LkRnzROdE9DvRiF1FyWmPcMoU8Es5ic7EzYIWHD/l3V6u5HAQD8UUZFvc8UZ4C9Qe91BFs
        Uuy0B/cljaDovxMuilCk5Ll0PVJS8DOLRbf5NRgHtYdqYJTDu/1yGFQGACt/93ENoSHcDQ79up4u/
        a1gpJefsmnNy+zsV9niwiBL/vEXREgXiutLUpNw3NAp0jCt+CxW3uccjt2MAZmAY2m1SH4J0vqlb9
        baaBCKJXg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flC7r-0005NE-Hp; Thu, 02 Aug 2018 11:50:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: [PATCH 07/11] RISC-V: add a definition for the SIE SEIE bit
Date:   Thu,  2 Aug 2018 13:50:04 +0200
Message-Id: <20180802115008.4031-8-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802115008.4031-1-hch@lst.de>
References: <20180802115008.4031-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mirrors the SIE_SSIE and SETE bits that are used in a similar
fashion.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/csr.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 421fa3585798..28a0d1cb374c 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -54,6 +54,7 @@
 /* Interrupt Enable and Interrupt Pending flags */
 #define SIE_SSIE _AC(0x00000002, UL) /* Software Interrupt Enable */
 #define SIE_STIE _AC(0x00000020, UL) /* Timer Interrupt Enable */
+#define SIE_SEIE _AC(0x00000200, UL) /* External Interrupt Enable */
 
 #define EXC_INST_MISALIGNED     0
 #define EXC_INST_ACCESS         1
-- 
2.18.0

