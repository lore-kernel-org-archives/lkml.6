Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3CAC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB9920856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VItZERpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB9920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388703AbeGXTE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:04:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42232 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388476AbeGXTE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4hIEQbQJkffoYpzl9w5ONUHKIok0l2QGSgTO2IRGDks=; b=VItZERpPidbdC5i8osCPRDMLM
        olH2c03sahJsP9BiFwgDmBHZPOz4jqw1uLyoZvaspYFEmbWUwTjdXw729zqj9+N6yktFtYdlzdK1/
        L7DImFOY2BnDgsqdsU5Jhx75Pi+f8JJK9s9F5E23ragwpueFm4fEnAeoVCC73o/B4FhQo31JekTPM
        Ni1361byHYZmN4cvPfMiAM8U5TyqQSCunT22tynACxIVjvQXG3Rx7i8tTf+7svo90iS4oBnWKh5hJ
        m9DT0VdQ2wHQiiFt3ks/bRALlzhx3TWCNggvlmEem/s3ARQkCk8+rdmo0sjM/xgZpcn7vu3dEPOkE
        SsiQH6QAQ==;
Received: from 089144194224.atnat0003.highway.a1.net ([89.144.194.224] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fi1Yj-0007FL-Lk; Tue, 24 Jul 2018 17:57:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Ley Foon Tan <lftan@altera.com>,
        Michal Simek <monstr@monstr.eu>, linux-kbuild@vger.kernel.org,
        linux-um@lists.infradead.org, linux-arch@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] kconfig: move the "Executable file formats" menu to fs/Kconfig.binfmt
Date:   Tue, 24 Jul 2018 19:56:45 +0200
Message-Id: <20180724175646.3621-10-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724175646.3621-1-hch@lst.de>
References: <20180724175646.3621-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to have this in the top-level Kconfig.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
 Kconfig           | 2 --
 fs/Kconfig.binfmt | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index a5997d6c2029..48a80beab685 100644
--- a/Kconfig
+++ b/Kconfig
@@ -13,9 +13,7 @@ source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
 
-menu "Executable file formats"
 source "fs/Kconfig.binfmt"
-endmenu
 
 source "mm/Kconfig"
 
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 56df483de619..b795f8da81f3 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -1,3 +1,6 @@
+
+menu "Executable file formats"
+
 config BINFMT_ELF
 	bool "Kernel support for ELF binaries"
 	depends on MMU
@@ -187,3 +190,5 @@ config COREDUMP
 	  This option enables support for performing core dumps. You almost
 	  certainly want to say Y here. Not necessary on systems that never
 	  need debugging or only ever run flawless code.
+
+endmenu
-- 
2.18.0

