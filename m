Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597E6C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B84B20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PDLyXUOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B84B20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbeGYKr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:47:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbeGYKr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZBUcb8OiPuzvSWRfiRcVNJ11Hja0IpnA9ik2umvRM/Y=; b=PDLyXUOInxNYYjQqlYk80N9DC
        9b+OQBpZOYQzor3gEbD0KKJsZxlxYQydBX4K/chanLifCEsK3TWNwpIG0j1UCXkshtkawP+puq1Wm
        Qx3Pb3EZRDyqIziUlrbtnSpTsUj7pLsbOKE6rvGoqV+F/TJS6UfoPTLzxGu9x1teDsT4lrQHoljbV
        /qPqbu32Mw/S5WciIERo//edGhewGHM5/tEWllTZVXQkezSgHyK/NGM1UzcBLxZ1lMM5Uw9/qxtjO
        ZFVkYj59s99oXOo6itoTmaxil5amSK+RFIruRWaEakd1veKqmVua9raYso9lzmZH9B+ku6Dju31fv
        ELcsKKhYw==;
Received: from [91.112.108.175] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiGE7-0005Ew-MJ; Wed, 25 Jul 2018 09:37:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: [PATCH 2/6] RISC-V: remove INTERRUPT_CAUSE_* defines from asm/irq.h
Date:   Wed, 25 Jul 2018 11:36:45 +0200
Message-Id: <20180725093649.32332-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725093649.32332-1-hch@lst.de>
References: <20180725093649.32332-1-hch@lst.de>
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
index 4dee9d4c13c0..93eb75eac4ff 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -17,10 +17,6 @@
 
 #define NR_IRQS         0
 
-#define INTERRUPT_CAUSE_SOFTWARE    1
-#define INTERRUPT_CAUSE_TIMER       5
-#define INTERRUPT_CAUSE_EXTERNAL    9
-
 void riscv_timer_interrupt(void);
 
 #include <asm-generic/irq.h>
-- 
2.18.0

