Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id s0bgABVOGVtKdQAAmS7hNA
	; Thu, 07 Jun 2018 15:26:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 508E0608B8; Thu,  7 Jun 2018 15:26:55 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LH8PnK+E"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DF3F1601B4;
	Thu,  7 Jun 2018 15:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DF3F1601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934874AbeFGO5a (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:57:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60210 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933205AbeFGO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QKH8PoXeHU53llWIDaCCGPfS6h6juRwuJA6oGiO9+VA=; b=LH8PnK+EydDfWdvK5in24KG2F
        SuUT1u1HDEFK8ymlHYbPANavlfMfWjU2VWlPXmRY6Bk7/Ke64RPgBlcClGsiGosLcIMMl1FakL0ZG
        Ki7LMNPmy2J32O99iDB1QYjIeW2Q0XTv3cWJiFtRixwSKH8bsRwHvVBySDtDcMLO2SttcZQoPzsD7
        AZ3NGwxxdt54q+GCkhLyJfuyo5h31P2yMLYY4ZWHrwfoWTbUGbmb68OOc08sSAXn+u3qr/akdwf5g
        KY5m6rfbYdWqaPGvTJy5MLk2qNcSwdZKkCo5T+WPSWFpgkSCGB4xxABSGdTPc1qjt8naECXcBwNsj
        7hGc+uXeg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQwLs-0005ti-Cw; Thu, 07 Jun 2018 14:57:24 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH 1/6] Convert virtio_console to struct_size
Date: Thu,  7 Jun 2018 07:57:15 -0700
Message-Id: <20180607145720.22590-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180607145720.22590-1-willy@infradead.org>
References: <20180607145720.22590-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 drivers/char/virtio_console.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 21085515814f..4bf7c06c2343 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -433,8 +433,7 @@ static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size
 	 * Allocate buffer and the sg list. The sg list array is allocated
 	 * directly after the port_buffer struct.
 	 */
-	buf = kmalloc(sizeof(*buf) + sizeof(struct scatterlist) * pages,
-		      GFP_KERNEL);
+	buf = kmalloc(struct_size(buf, sg, pages), GFP_KERNEL);
 	if (!buf)
 		goto fail;
 
-- 
2.17.0
