Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC93C67790
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 15:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293EB208A2
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 15:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="at6G58dc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293EB208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933048AbeGHPU0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 11:20:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932898AbeGHPUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 11:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gj7iSFnwOf+CI7HCg1QW1Nd6RqKyr0qFIqZNPXrbr6A=; b=at6G58dcGyGbbw0PJgDXTUD1z
        rDC2CKALsFQRpMoLyzT57jJywwubi4Axsx0szJuu0EUPdE/HhaFXOO597uWLVJpWPx8UkRuvV73pu
        Q1lZ1518l3IxoDG3wOcV+sGPKhoxV6Fxirm290xD6++e9kF5yMERz0H3gCxk3PJHiDjmgARZpzp6F
        p3iOxU9K2rCMHOJjraabn+Ga89mh/5xabQU1Lu+501vvU34oI++AcUc12v3hz7YX5RCpukmSPE8n6
        8syfTxEi7sQ061KOdPe94kixAEL/gdNNHL052x5vXh0sLu1Kca14ZPFIGzKPoIMrjtdZ5QPJc13vW
        Nnl8D8M+Q==;
Received: from ip-64-134-140-74.public.wayport.net ([64.134.140.74] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcBTu-0003K6-N1; Sun, 08 Jul 2018 15:20:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kbuild@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] kconfig: add a Memory Management options" menu
Date:   Sun,  8 Jul 2018 08:20:04 -0700
Message-Id: <20180708152004.21679-10-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708152004.21679-1-hch@lst.de>
References: <20180708152004.21679-1-hch@lst.de>
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

