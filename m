Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C8DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390472175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NbiS68kH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393336AbfBMRku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:40:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40504 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbfBMRko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eZ58SmjxShPdlPalu9FwP6Ih9rIG9TiLHdmUn9VD9ws=; b=NbiS68kHfVezTi1fyDMmrYYDUU
        /Ed/Q0ZJo6Up4UN9V1P/VTYFZwM3kP4g3A7GpHfxquPQVG0ptG/1s6LNaHVAD8VJC2vskz3D15x+q
        Y8Rj5piiAjJMDz8oi2qGefQXb7KWsOcM88rTdtv0dw6G057CxDJMBzKak0hSO7vVgy+qaisZCcxnS
        6VnKtqupKRGfZ7O4FOmjQ/ESBX2iVdmQJIveALuHUoReczwSINkAR/LmkbDdRunqS+SKttaXpTmtV
        D5K7FwpHYgoWz75IAW94pko7mxadV9bQB2BQAfcqcPN0pkLtdCCUjxkzqVSwFHs2ErJgNsjrGiIqc
        O2Q0/Nug==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtyWZ-00006E-CO; Wed, 13 Feb 2019 17:40:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] s390: don't redefined the HAS_IOMEM symbol
Date:   Wed, 13 Feb 2019 18:40:05 +0100
Message-Id: <20190213174005.28785-12-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213174005.28785-1-hch@lst.de>
References: <20190213174005.28785-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rely on the common defintion instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/s390/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9a25e19364f5..0f62e33ffcb2 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -159,6 +159,7 @@ config S390
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE	if PCI
 	select NEED_SG_DMA_LENGTH	if PCI
+	select NO_IOMEM			if !PCI
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND3
 	select PCI_DOMAINS		if PCI
@@ -708,9 +709,6 @@ config PCI_NR_FUNCTIONS
 
 endif	# PCI
 
-config HAS_IOMEM
-	def_bool PCI
-
 config CHSC_SCH
 	def_tristate m
 	prompt "Support for CHSC subchannels"
-- 
2.20.1

