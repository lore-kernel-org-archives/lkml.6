Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D14C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F99220844
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OtmbWSxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F99220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbeGZPyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:54:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbeGZPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U6fW/izvP24EZMoN+Wixchj0VutMhM57U48S9KuzyDA=; b=OtmbWSxzxorZeoG13eCnPSjHb
        zzizI7dvPouAMVBOICWZn6cRgCu0GEk/aNFVaGmAL5tbuI5566Ic9gydIOshDkmyalHq0/OOoP6mK
        /JniqpCX9kEMcUtWGWzj7EnLh4dupQBnH6gCwOzrxHiMzCY4GD3Gd9rZqm8qbbHqHk8Uhmjoxt55z
        lGlhTNrRFgj2RTL3nYSn9RqM4vlqsFNhX/1yTG1OtKWMMxkvln3w8YyzXCpkYyFt2qI6VAVzvCg9Y
        fFXek2YR6lAF3lp6Pzo1Fb56RKAjNrfWYcvNPfC3YR4JzchhjwKc+9UKo3SYRZQS4Crv7gmiM1Sy2
        3rWMZQKtQ==;
Received: from 213-225-8-157.nat.highway.a1.net ([213.225.8.157] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fihOf-0005kD-0D; Thu, 26 Jul 2018 14:37:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: [PATCH 4/9] RISC-V: add a definition for the SIE SEIE bit
Date:   Thu, 26 Jul 2018 16:37:18 +0200
Message-Id: <20180726143723.16585-5-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726143723.16585-1-hch@lst.de>
References: <20180726143723.16585-1-hch@lst.de>
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

