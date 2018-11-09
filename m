Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FE5C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF09C208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VY7CPxw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF09C208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbeKISjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:39:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54012 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbeKISjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Tf1uRvXyDTrxkP+ofU3lvZWIX1WIYczdk9oIy5SjKaE=; b=VY7CPxw9H4H6YLPTDS170fZ1jp
        bL/6tRSFMTpzyezsiau4AE/t/wYqKzjO2Rbn46zgtUzZEzTy2dEDtXKHgX+u4wUzRHXiEyyKszjMx
        5WKq7eX99WXTePMfgGtG058hs5IppEcXcRFtAjSV0ZLY9jN9ZJWTFypmyzclAvlwgmXKww/Hgx5GR
        cHWFEAp7lLLZaLzRPUiCGZE1V0jT/UtGwWmVtwJdi9vvecyxQ1Gl24BZXj/IxGobZHWjrs57ERlf4
        jR0YiDjLqhFQdc3jKCs7j8zB0uZQke++hZyx9PZx7kOuvFASUQ8SB6u5DR9Y1UXEAWaIsWbFNcoMu
        y2h57Ibw==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gL2eG-0003u2-Ok; Fri, 09 Nov 2018 09:00:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] csky, h8300, riscv: remove <asm/scatterlist.h> leftovers
Date:   Fri,  9 Nov 2018 10:00:07 +0100
Message-Id: <20181109090008.24150-2-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181109090008.24150-1-hch@lst.de>
References: <20181109090008.24150-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There has been no <asm/scatterlist.h> for a long time, which also means
there is no point in using it from asm-generic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/csky/include/asm/Kbuild  | 1 -
 arch/h8300/include/asm/Kbuild | 1 -
 arch/riscv/include/asm/Kbuild | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 2a0abe8f2a35..7c48a123300d 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -34,7 +34,6 @@ generic-y += pci.h
 generic-y += percpu.h
 generic-y += preempt.h
 generic-y += qrwlock.h
-generic-y += scatterlist.h
 generic-y += sections.h
 generic-y += serial.h
 generic-y += shm.h
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index a5d0b2991f47..32f0c8952147 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -36,7 +36,6 @@ generic-y += parport.h
 generic-y += percpu.h
 generic-y += pgalloc.h
 generic-y += preempt.h
-generic-y += scatterlist.h
 generic-y += sections.h
 generic-y += serial.h
 generic-y += sizes.h
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 6a646d9ea780..011cc7c7b3ad 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -37,7 +37,6 @@ generic-y += poll.h
 generic-y += posix_types.h
 generic-y += preempt.h
 generic-y += resource.h
-generic-y += scatterlist.h
 generic-y += sections.h
 generic-y += sembuf.h
 generic-y += serial.h
-- 
2.19.1

