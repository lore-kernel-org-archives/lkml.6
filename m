Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2711254-1520286335-2-15756883906972162585
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
    t=1520286333; b=sCrXOVpI7x7rH3EG7U6fsfbz7k24JxwfS5ME3IH6oPTvE/E
    7h19cDFAMvw3cSMYGhsjqGcWdEhPKAgSnZBUii18MBvegRsvqt6OT0hF7WBfV73j
    gxR2VCDeYFDcp/zYPiId0+xOr4TZZD1LyUi5o1VEiubdEm5qxQDS1ifNnWAiDhGc
    Lonyv1R/7v47aphxPwV0YyuY9HBibBXmuT15JUHkcoc7/9TCDJLiFrPPfG4VokN+
    wHE1hth1x8OLWbOuAoM0POdtnpd6WfFyI7AzTY98jzgr5QvOl2ovi1eYK4x4S2e/
    ZaBy8tanW/1R3IZF+UdCis2AShQGB/L4YY35fLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520286333;
    bh=eM7jVMi6x0jRAufoec6WixJcgcUj0IfOysCvCBgcaO8=; b=hL+7uTqU4fvT
    p7F6EawAXxH+JLkm9Qqx5mqd9SgfYYrod0tQ+OoUBLLTpomnCAesGELf6Kj4CLrU
    NMFk2vwB75NiukiiHrXxAEMddaPp47VEqzhvYkaUZdqd4DAfVg0l5IgwN2zRAIXZ
    yHmKXOtVpQDyIDtNR7bugkokM1JV6HgYOSM5+Ce3SoftJNYiQBh4nuDUOJDuUJD0
    PxdZwbdmETeHv/7u8qZyAQaeq2EBCcj10zob1IGzSYJc0M1fQLV0D2hcg5W7ioR1
    UnRq2fZb//rC5b5x+lBzoKoNloP5oAHiPCyh91PEq5fpoXo8E0UK030PhXuVNlN0
    uihiWIF1Yg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=TU8Zcott x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=TU8Zcott x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753047AbeCEV1s (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 16:27:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbeCEV1q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Mar 2018 16:27:46 -0500
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/36] aio: remove an outdated comment in aio_complete
Date: Mon,  5 Mar 2018 13:27:09 -0800
Message-Id: <20180305212743.16664-3-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180305212743.16664-1-hch@lst.de>
References: <20180305212743.16664-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These days we don't treat sync iocbs special in the aio completion code as
they never use it.  Remove the old comment, and move the BUG_ON for a sync
iocb to the top of the function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Moyer <jmoyer@redhat.com>
---
 fs/aio.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 03d59593912d..41fc8ce6bc7f 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1088,6 +1088,8 @@ static void aio_complete(struct kiocb *kiocb, long res, long res2)
 	unsigned tail, pos, head;
 	unsigned long	flags;
 
+	BUG_ON(is_sync_kiocb(kiocb));
+
 	if (kiocb->ki_flags & IOCB_WRITE) {
 		struct file *file = kiocb->ki_filp;
 
@@ -1100,15 +1102,6 @@ static void aio_complete(struct kiocb *kiocb, long res, long res2)
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

