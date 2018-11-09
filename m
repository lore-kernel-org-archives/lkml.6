Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1E6C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBD920818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EQkB4rgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBD920818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeKJEU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:20:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47474 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeKJEU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rBt4Mmj9tx6XIvHM8hWDRG5RXSzKRynY1fQCBNNt4BQ=; b=EQkB4rgAdc5Ry3Zbjwxus4eWs
        7HIKVXzoOhsl0I5EunwK2vZqNQW4li6w6zSNuZGJpjTMLTvxYyzCWox8TlCXn6ad833P8amSBhg/k
        d6xcmuGfXSrTjKBo9JpAVG25UCEk+kRSkNyrTBIBd5JOSAzdGKF/qUNyvHuT7Usj4TDdmf121o1kG
        3y+i6VC3iAZbpp9PjNnx8FAyp6sWs7nPR8vr8eMYE9XOQoIomM0jOzTAZZh7oA+K85GsO112ux4Lv
        Oi74e6b4QfCtl2mBtpsKjN7t2c4F4b353OdLVQOb2FjSQ5qWzODyLVnsYZ9TpMR7vpm+dH2v9ty0t
        jrzRjpLjg==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLBgT-0002SE-25; Fri, 09 Nov 2018 18:39:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: remove the unused struct hcd_timeout definition
Date:   Fri,  9 Nov 2018 19:39:03 +0100
Message-Id: <20181109183903.21607-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No users of this type anywhere in the tree.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/usb/hcd.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 97e2ddec18b1..7dc3a411bece 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -235,11 +235,6 @@ static inline struct usb_hcd *bus_to_hcd(struct usb_bus *bus)
 	return container_of(bus, struct usb_hcd, self);
 }
 
-struct hcd_timeout {	/* timeouts we allocate */
-	struct list_head	timeout_list;
-	struct timer_list	timer;
-};
-
 /*-------------------------------------------------------------------------*/
 
 
-- 
2.19.1

