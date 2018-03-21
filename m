Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3333851-1521617753-2-3802689475571155563
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521617753; b=LkEikQPTzp5y5ejKJzaTGiZ2ezxK4Cnr0XWz98npZJJ2WLR
    +omH7bn+/1Jm2m4FNPVk1cR1kwE1J9XtuVpj2wBrYnc24gOQck/zOz1zFIHJ4L3v
    K1b2Z305pPNrokyigh/tERq7+XQbRYdJny+MlzPZ0PmlB7J1bb9/rUEBVh/nj31w
    DaVYnc4vOFEhrIP4BghKwgh/pZbJAtzEEWfWgcphQr7WRQEaf099gPOrAAYvjTk+
    nJKB5TTLraQW4rHZoTTin/tf2Xi5IT75C7TdCmJXEFZ05oEUsSpPRPxhd/fBxAac
    NhBeiL6yF0r8CgHK7XuDI9YS5afJFVvWGLYWFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521617753;
    bh=im9R9aiuguReRnf3PPiGgqmw1NHp8FNwzH/cfdRQmRQ=; b=uv6OWVm78W+z
    Uq9GavNBhyc9qjZZcmY9ZV8nN5hRkZTSF+7K+qljwE/oavWA37d5/MplBHfy0DBl
    bgBFCNWvfgCEjBsF7Zka+OXX0NNh6qoiKYpLqTyYt9UQTKYO+YYsKlhXkzPEVrua
    W5sQCoFjGsFR+x0Uz9tQypywmVcA7WF9yIbuWiCo3EYH6fjrB548w5alk9i73P38
    Yk95H8btfSpN1yfzt4AOua/8rRBBMIPt4VIhFkGN+Dhdg9GThZW2pbFjShi7EKWE
    X3/HiHPN4zNq7dR8+blc61pM+Re6JjP25+o4eJUtkaXVLhPAtQfpZH8A2ob2QRKp
    /TzO3x2ZTw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=rOkhIpX1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=rOkhIpX1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbeCUHfT (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 03:35:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46634 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbeCUHcp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 03:32:45 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] aio: remove an outdated comment in aio_complete
Date: Wed, 21 Mar 2018 08:32:25 +0100
Message-Id: <20180321073232.13366-3-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180321073232.13366-1-hch@lst.de>
References: <20180321073232.13366-1-hch@lst.de>
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
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
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

