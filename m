Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C41C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B301208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T0bvTHyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B301208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbeGaNUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:20:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43900 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731912AbeGaNUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gj7iSFnwOf+CI7HCg1QW1Nd6RqKyr0qFIqZNPXrbr6A=; b=T0bvTHyLWEEoh42J+tepyUloV
        mZc0rFbYzL/X2O88qqzJ6/+Kc7mATHpyPCZtqydfB1T7J4UyB0aYRR+vWrr3xNBtxRZLT4vxOItLk
        7Nm1zAG6HsfRrW2cM8gDcjz2MSK/lUBve+NpiVmkkzhMfKbHY58aJf01j10Pmj7lQH6psIjekIoFp
        4wxRHzrhJXJ1bkKCwuBmZYfojSv+LRtL9dbJ1hM+r/sv4JX4mOe44EQw0rxsTvzXMXsNL8GiSBObL
        +TqJ5zcSHBb4LAV/53vDMLJcKHYFZ/TkUJO71JOgf28ftZh8qpBgP9zbTCqbg7yNcgc26mNsqq6vx
        xnvw/ZREw==;
Received: from 089144201224.atnat0010.highway.a1.net ([89.144.201.224] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkT0e-0002OP-JQ; Tue, 31 Jul 2018 11:40:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Ley Foon Tan <lftan@altera.com>,
        Michal Simek <monstr@monstr.eu>, linux-kbuild@vger.kernel.org,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] kconfig: add a Memory Management options" menu
Date:   Tue, 31 Jul 2018 13:39:35 +0200
Message-Id: <20180731113935.6105-11-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731113935.6105-1-hch@lst.de>
References: <20180731113935.6105-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves all the options under a proper menu.

Based on a patch from Randy Dunlap.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
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

