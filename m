Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3454413-1521618205-2-7468160770230689176
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521618204; b=ssAg37uVajb8Q/mth6ZQTWWLn2jei7Jk77XjkfKs+A6usVc
    1VIfVbJIy3q/p+y6v8RYh1wO9JzKhdLFS1N7Dak8meAJ2pPEo/qrhG0qUNHzaop6
    VklUVR/aZj1OHxXpgCD49xEabMraEgPQ0fZEWB8Ct4R3axZypaO+NGecfLx2MfXg
    DQKudDHZNXLTVMtPS/NoTN5fwKQq8+OrHTGY3zUkFI/f6jQ8f65oBbC14pRqBfj2
    x5e9Jmdq9BVUswrphE/qqLSzgmJEr29CVRBgmczZ8DWIkDqaK7kS+xZfo/XnvrnR
    5S45Ml35F6kvXVt2BF+zZ4S97yVZKWrJXSu63fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521618204;
    bh=Ggz/rNXWiikI0ka3wRDV7+PPmrdCR+0U9UPTcuZDFlc=; b=UHKo8UF7J12T
    qIi1ODO09a7jaRG1ZXbg4ho11+ZVc9M0UycrPdrNcNovUUhJZwJVrmV0oadvNRX7
    0vjq7rJYh8grNNsyq0ZLiEbX5adEbZLhWYknrcwVRJivIvxhjP5qcrH4aKobuWd3
    myuNlxPZZg7Pix+qrVQvU4UIYqBZPLUzy3jgnXjMwGR7YpQuNQdk4OqlGlvz3t8T
    +FFu5VFfgTpie86dy7fhQRbihMCX2+vpH7Xt1bMHJbOCFGgU9mm59MRS6nj1R9Jb
    e8wi58cGLlMX3gSMq7o5AZ8+A1Al1onh07j+1ovfQG7CvapSE+heQikm3FhHKNSZ
    LoVuTuTWhA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=IB3O08Gq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=IB3O08Gq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbeCUHmX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 03:42:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48320 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbeCUHmU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 03:42:20 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 26/28] eventfd: switch to ->poll_mask
Date: Wed, 21 Mar 2018 08:40:30 +0100
Message-Id: <20180321074032.14211-27-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180321074032.14211-1-hch@lst.de>
References: <20180321074032.14211-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/eventfd.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 012f5bd46dfa..d70b4907f978 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -101,14 +101,20 @@ static int eventfd_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static __poll_t eventfd_poll(struct file *file, poll_table *wait)
+static struct wait_queue_head *
+eventfd_get_poll_head(struct file *file, __poll_t events)
+{
+	struct eventfd_ctx *ctx = file->private_data;
+
+	return &ctx->wqh;
+}
+
+static __poll_t eventfd_poll_mask(struct file *file, __poll_t eventmask)
 {
 	struct eventfd_ctx *ctx = file->private_data;
 	__poll_t events = 0;
 	u64 count;
 
-	poll_wait(file, &ctx->wqh, wait);
-
 	/*
 	 * All writes to ctx->count occur within ctx->wqh.lock.  This read
 	 * can be done outside ctx->wqh.lock because we know that poll_wait
@@ -305,7 +311,8 @@ static const struct file_operations eventfd_fops = {
 	.show_fdinfo	= eventfd_show_fdinfo,
 #endif
 	.release	= eventfd_release,
-	.poll		= eventfd_poll,
+	.get_poll_head	= eventfd_get_poll_head,
+	.poll_mask	= eventfd_poll_mask,
 	.read		= eventfd_read,
 	.write		= eventfd_write,
 	.llseek		= noop_llseek,
-- 
2.14.2

