Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1763006-1522223134-2-9620552823245623338
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522223133; b=coEtWt+oD6c33Rg8EQ9sA4S3kN0YGD4LKlaANJ+GK9pNGJM
    SdY5JmxudSzukST3NEuTW6ecJPW4zcDaXYsGPaZiLQrsKpHv1IqUKB0We4sdDNsp
    ZW5MI6ufG76VkIbo7XiQmR3B+UuzPs8hYdIoNKUDJKK5YgiBtw0ylSkr3WOoce+Z
    yALbpWa6hT682EMY2SliW89xzPyzHNW47zXTYABuc7i2s/vNqqqSvIyG3fhmK9K/
    8qc5eJ4EoctwN8iY6C2p8HpIQ1qoPS09GrLKDl/5CEwMbh8iVSEC7vgbclCAyGUn
    xTb3EfsxdBf0xzXXPcv8/vRdHsb3BHdpubH5sxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522223133;
    bh=A8bReqIqQDdcRzw5zj4MF7IqwbUCpmEcPysMepMCF8w=; b=lhOneQPFRjUH
    P0djqjfTQvytt70Ar8Lfy78YRQ0h35/lESkHLkM5KsWqUU8QpjDhOQWWjcqejmFm
    xJjCfNtIxQqOAM/TAq9r1r5ZIke5R+JqeeQOJiLyiJRb9Wa3nHRtK3En9JDjL4Mz
    zC8S11mlI3XbFXZtMBt0nnixGGo8M678b9fQVyqiekka2/NixeTfLNkTfCZdd1S8
    OWuljgY1TgnPAv/mDO5ZdMJeFoBdn2NmK3KBrZ9ZafWte/AccwTKeeooQ/XoO95L
    KOPjIwBeTe2GaftBqDdCOQwMKUORAgasP3d3cc3vIaKq+/paMR6MfUUb1w/lNcVZ
    tBHsZEwfpQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=NxUdU3/f x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=NxUdU3/f x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNKbXRtHxKpzCRghL8gcQPWxSnBtap7TlPvFgxWcnRCremRvgx2VGFKlZAJ+pVlLlEGr3A5l93bDrFW39rlMalkZHSOel2m5Jt9R7cdKD5j+YeeYZd2u
    G8BOEx74yyM+fmnuYkVFOR4FniL85fa49IEaYHLwkFtUBQ4ssbkknhfKAEqQAZak0aAF3lYR7VpoLuZIOqOufvlKDDW56ysRaW78Ir5woyOTnlF8JgVZ3+nl
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=rOdiVRBb5U8030cKwhAA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeC1HpQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 03:45:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44438 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752572AbeC1H0x (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 03:26:53 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] aio: remove an outdated comment in aio_complete
Date: Wed, 28 Mar 2018 09:26:35 +0200
Message-Id: <20180328072639.16885-3-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180328072639.16885-1-hch@lst.de>
References: <20180328072639.16885-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These days we don't treat sync iocbs special in the aio completion code as
they never use it.  Remove the old comment and BUG_ON given that the
current definition of is_sync_kiocb makes it impossible to hit.
iocb to the top of the function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/aio.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 03d59593912d..f536b0f249d4 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1100,15 +1100,6 @@ static void aio_complete(struct kiocb *kiocb, long res, long res2)
 		file_end_write(file);
 	}
 
-	/*
-	 * Special case handling for sync iocbs:
-	 *  - events go directly into the iocb for fast handling
-	 *  - the sync task with the iocb in its stack holds the single iocb
-	 *    ref, no other paths have a way to get another ref
-	 *  - the sync task helpfully left a reference to itself in the iocb
-	 */
-	BUG_ON(is_sync_kiocb(kiocb));
-
 	if (iocb->ki_list.next) {
 		unsigned long flags;
 
-- 
2.14.2

