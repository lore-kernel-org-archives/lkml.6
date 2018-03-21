Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3333851-1521617649-2-1321867020789034129
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
    t=1521617648; b=NIfZgcd+6E7yMQ7/KmgT9VxrXmAMZqQsLfrxsXFHu4ChLeu
    zFs/Q5QBBEiAeoMCf3pzDbQ/6kPJjVi0njAFkqa0TOqHI000JEZf9fMHXtgcfQv9
    SaFJq0E/OEbGp9eNzH8gyOhiyUJDbOMpxUbphhJG+yy0vWyttZf+VdHX24f09zzm
    deZAB/+cZMtOfJnzXVfjkxPXz5O9cL8mAWlaIJMO5LaFJEuyxdMCiidQBkhfXc8O
    vLJjzdXb77IbTgFrAu9UVJZfIpwV+UBYwJo5W7NCzmc4tkOqMmcTYgAJRbS64MgS
    oQXuzTg5p2igY7Cb3GBwFMPpBgBbY3db9rFQbOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521617648;
    bh=XDmYlVZfEaNXw36fjjyh7602kjE6bdKD8lA2+mSkN9o=; b=dgFNNUvqjqtb
    E6z2zx7Y9a2IRZiyRWW/HbZFTbOtZMaaQgsG3PzRQg+geTiyYbpjsxMsFB/KpiMT
    QjiZ4bwNPhOVw2R06IO9wC5vMFvnhn5GPehqoawPndF96LpO4M9syR32Mm4i7Tiq
    B4gUg1k+2LBMWSlzLyc8ZoGf5+ID7s6YGFbxNLY+xmdHBIIpq/sd0oaPn6RJ57g1
    Z4MZhfgj9xREEqBSBdhtGdh+oaNXJfBag0MQN9SXkO8k5nnz3my794IEdp406tfs
    0Bt/T2r7+zH7MGwNE6sBuBNlbMYO0W1KygdKhhLofOZwLrw2l+IwmMdBngVjy3JD
    BtxmP1YZ7A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=l8u+hXak x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=l8u+hXak x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeCUHdF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 03:33:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46694 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbeCUHdB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 03:33:01 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] aio: delete iocbs from the active_reqs list in kiocb_cancel
Date: Wed, 21 Mar 2018 08:32:29 +0100
Message-Id: <20180321073232.13366-7-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180321073232.13366-1-hch@lst.de>
References: <20180321073232.13366-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

One we cancel an iocb there is no reason to keep it on the active_reqs
list, given that the list is only used to look for cancelation candidates.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Moyer <jmoyer@redhat.com>
---
 fs/aio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 2d40cf5dd4ec..0b6394b4e528 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -561,6 +561,8 @@ static int kiocb_cancel(struct aio_kiocb *kiocb)
 {
 	kiocb_cancel_fn *cancel = kiocb->ki_cancel;
 
+	list_del_init(&kiocb->ki_list);
+
 	if (!cancel)
 		return -EINVAL;
 	kiocb->ki_cancel = NULL;
@@ -607,8 +609,6 @@ static void free_ioctx_users(struct percpu_ref *ref)
 	while (!list_empty(&ctx->active_reqs)) {
 		req = list_first_entry(&ctx->active_reqs,
 				       struct aio_kiocb, ki_list);
-
-		list_del_init(&req->ki_list);
 		kiocb_cancel(req);
 	}
 
-- 
2.14.2

