Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACFBC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B81E2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XPeOo/+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393233AbfBMRkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:40:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389327AbfBMRkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t+ji021zhkwzIs6brDgGkxIVc/8SHPxNoEW5HT5nSK8=; b=XPeOo/+mxfIHJZeKbwGU9VVPvX
        X1lKEphkzDb94UV0ubFlybbVq/37gfm6Kd1kx2jM1GBhUzgZapXHbivAk+zwYU4ob1nAhzf0pmqUr
        SkRBovl9HFpu0ngHdxqCkiA8nuN7R3hAsKH+iERzCDsjxZ0zX54u3mz/sjNupp7b7OEvhFAYlUjbm
        pbVyUrb/W95a+WcBdBk6TYcMyh3PmIL3C3eEsUbXL0/uegWHSog0LNBfnuyhxp4gm2ijkStFbEfJb
        mNJXFVk9od+HzRuiHON0JV7IGaRy7FfeHKLEVKl39uXGLNvOI1+xcuMA7P4kwbiAmeKDqELxXUKM9
        CHDhiqQQ==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtyWC-00089P-Du; Wed, 13 Feb 2019 17:40:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] riscv: remove the HAVE_KPROBES option
Date:   Wed, 13 Feb 2019 18:39:56 +0100
Message-Id: <20190213174005.28785-3-hch@lst.de>
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

HAVE_KPROBES is defined genericly in arch/Kconfig and architectures
should just select it if supported.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 515fc3cc9687..b60f4e3e36f4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -94,9 +94,6 @@ config PGTABLE_LEVELS
 	default 3 if 64BIT
 	default 2
 
-config HAVE_KPROBES
-	def_bool n
-
 menu "Platform type"
 
 choice
-- 
2.20.1

