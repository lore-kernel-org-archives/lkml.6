Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBD8C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BA225EA4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pNSpRgIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BA225EA4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbeGBOrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:47:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50406 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbeGBOrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hwy+l2NiaPnSgbbx7aVzLr5I8ilkDBL5l6JsQrkrvic=; b=pNSpRgIKmtdVVIEb+CxBP4nDh
        utEsKilZ4ghASdmxOX6fZqLybbSMYNckfYVhWVL0YPnCa9vQY9Iqm574jLofZN71l9sIST7s6LpId
        ALxnc4SSaRRwZhURUJSj3dwf7M4aOl0AZwv+dHC1ZSTwwaUUL24CxhM6lQgqhiD1KxQdWvqNZpkmI
        CvgnVBsPNMRptFQ2eY1lpiPTNVS4S0aJ+jk6oniK2rBeH0wUdnB3YpMzJX+29eNfjwlxIQP5tyGbN
        UoJwrikscVGmMYwrMTyA/TXGnU3qm5QGckw7BFy51olWKO5SbbfWH9sLakzcymNAf6tTNMK2L0web
        1Wsla0QGQ==;
Received: from [208.118.102.130] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fa06m-0000Z8-Ff; Mon, 02 Jul 2018 14:47:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] kconfig: add a Memory Management options" menu
Date:   Mon,  2 Jul 2018 08:47:10 -0600
Message-Id: <20180702144711.22111-5-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180702144711.22111-1-hch@lst.de>
References: <20180702144711.22111-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves all the options under a proper menu.

Based on a patch from Randy Dunlap.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index ce95491abd6a..9ae1b6a8e30f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1,3 +1,6 @@
+
+menu "Memory Management options"
+
 config SELECT_MEMORY_MODEL
 	def_bool y
 	depends on ARCH_SELECT_MEMORY_MODEL
@@ -762,3 +765,5 @@ config GUP_BENCHMARK
 
 config ARCH_HAS_PTE_SPECIAL
 	bool
+
+endmenu
-- 
2.18.0

