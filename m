Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2D4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6DA20856
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bwiJX9nx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbeL0Hd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 02:33:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52288 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbeL0Hd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 02:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pPyyHsYu/BbkZXviNa4czWkQtW0flQ6AgEzLZ/T9LiA=; b=bwiJX9nxqDIq8zC+8pIAx/BBd
        V6AeXHtyIDHwHaBmhp/PG3Vt9dFz0dHHdEfmTQiTs0jMvtyWR8PntE0zVzDX2oL1t8WkP88yGuJQ6
        Dqnlv4/njN0N+6TWjABlL/e7SS6REJ8Ng/4iH1eVokLwveiyQEbpkjNtM5EXvR15XMxLjAIsCuIvi
        nvgJW21+EwACKlOUxSOdkjSIe4rMake9BmLYO+LXaucktN7yXlgo7ugluVBcln7wkcQVhJdziuwMa
        hNVf3ffFPdpHR+J4LFRWk059/EPxvDV0BUNDFzI7vDuRjqWrLE0+LJyU0ah4Kwz9M9XzKPtzRGS+X
        QRxb9V/Gw==;
Received: from p4ff2ede0.dip0.t-ipconnect.de ([79.242.237.224] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gcQAZ-0007zU-8t; Thu, 27 Dec 2018 07:33:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     richard@nod.at
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] um: writev needs <sys/uio.h>
Date:   Thu, 27 Dec 2018 08:33:24 +0100
Message-Id: <20181227073324.10090-1-hch@lst.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vector_user.c doesn't compile without this for me.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/vector_user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index 3d8cdbdb4e66..41eefbcdc86f 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -25,6 +25,7 @@
 #include <linux/if_packet.h>
 #include <sys/socket.h>
 #include <sys/wait.h>
+#include <sys/uio.h>
 #include <linux/virtio_net.h>
 #include <netdb.h>
 #include <stdlib.h>
-- 
2.19.2

