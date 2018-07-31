Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86A0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D4E208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TUotJjhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D4E208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732276AbeGaNUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:20:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43762 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731912AbeGaNUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Nd/NAshcC+N9sJXOXpHOLtro9zm+WHYdhQEaujYnfgA=; b=TUotJjhuZGlFozPGd9JwXdarJ
        kf4h3pdoPMTwFzxBNHX3y+460JbtmbVzXr9YLCUEK4bTRQVANtcXMER+XmpKahutyB+KkZfaIJR3f
        W1F+Yz7616XHjTNI6eltql5z22TBlObMrmnLv2oZ9L+MNDENot3RMuTl3tWEa/5HCGzj+lGiGG0qy
        ZAMb+C0el3ZhBXQRYtlC3maxRYwOeDZg8hfYz7tVAquX//gtk14KT6i/Lk0Ahdi+fHDqhCZtwEoxg
        S5uLicjlLVMHdR1aZ99WrxrWLzTsifj6E/cD4kArxP7h+fTp826CX7GXVJ6xi7nfpV/uPuLT0ClLS
        UB8RLlcPw==;
Received: from 089144201224.atnat0010.highway.a1.net ([89.144.201.224] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkT0X-0001XP-DC; Tue, 31 Jul 2018 11:40:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Ley Foon Tan <lftan@altera.com>,
        Michal Simek <monstr@monstr.eu>, linux-kbuild@vger.kernel.org,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] kconfig: use a menu in arch/Kconfig to reduce clutter
Date:   Tue, 31 Jul 2018 13:39:33 +0200
Message-Id: <20180731113935.6105-9-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731113935.6105-1-hch@lst.de>
References: <20180731113935.6105-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Put everything in arch/Kconfig into a General options menu
so that they don't clutter up the main/major/primary list of
menu options.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index cddd0faae4cb..6cf1b17a8df2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -9,6 +9,8 @@
 #
 source "arch/$(SRCARCH)/Kconfig"
 
+menu "General architecture-dependent options"
+
 config CRASH_CORE
 	bool
 
@@ -981,3 +983,5 @@ config REFCOUNT_FULL
 	  security flaw exploits.
 
 source "kernel/gcov/Kconfig"
+
+endmenu
-- 
2.18.0

