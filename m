Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1668128-1522355768-2-9340240765241825403
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522355767; b=bq0xcLRSrumoZ24Bsdxtn13SB1Rd1M9VCisk+TmqORulX0KVpU
    a2jNH0XMdA0dRimshcgY1RVFhGmRS2+6o0PhIikJwgo27mHujzYS8eFJaTBSfrc8
    tnWCfYDjpdmyGhl9Lnp3PRlaL0IChl2CiF/8DfMF6FJ2mgtfDOzAa1xf3XRB0HL2
    96lenzpezmUDhXRDihG3NpcvOekiBTJujDod0QxlnfGM2lUBATYg+JEJ0yuwgtkN
    KurM9FzSmwkdNqUuRaFQzvsZHAEdXSXntHDh+wu42vGI+/6rcA52qnsQOF17u6tC
    3IQqcHBCgnB3hmcGwW3yDAEB++QyBAOFYeYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522355767; bh=
    uo2eln1VlZAV26umCN+rr36lsCXD1wCmgus6dYJl8r4=; b=p5h1tMAPSwRAUAFk
    CdmDMHlbLNcfu0X/iVxXsmx1rV1wChc630rb+hAdBW2qqk13YxYC2Kuoe+NHv3T6
    YnmRWRKVadWv6YOgR/fQEA/vckhih1zmUOiR2/F1W7TFpFcdpupcCkiOcxQncuML
    FOL89Wn8KJC6SAjOnWLgAineX7TwpgPEKpq6/msfI9rFlizJdTn6WhKQGk978xhg
    lZjcldJh2fvP+YcoFpDzLYlwcPsF3t7hyJwDyc5y5a14rlJhGNrPrqfprvnGICLa
    5x3Q8nWwbMIfcI85viVfvV5ORJ7VQFYqmhVsaJiAh5t7j6W7lyVBLsUa++MEEjjv
    lFM/LQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=NIfu8kK1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=NIfu8kK1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLmU1z6G6dnwmCXM48+TaLs87KrmrszG7M8yzjOKNQxboipydgQWzPKE5u7htH98q/uxFbmOAoJkpovzpYxuLbFO+vlz0eBlNZcfD5+ER+7sjTHzc4Da
    XT68VhoHQxWw+kvm1fUJAjCZdjytjZGKKVaWjBI1MJpicOLa0+lUJpP66X6hNLYOKgdlidMlRFHUYdhBf/FIninbLZUqBYiWzDn6KUt6um1DkKLICPJ9UmYT
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=asEyZy900Z8-iek_oV0A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeC2UfX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 16:35:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54068 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753077AbeC2UfV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 16:35:21 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 29/30] timerfd: convert to ->poll_mask
Date: Thu, 29 Mar 2018 22:33:27 +0200
Message-Id: <20180329203328.3248-30-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180329203328.3248-1-hch@lst.de>
References: <20180329203328.3248-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/timerfd.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index cdad49da3ff7..d84a2bee4f82 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -226,21 +226,20 @@ static int timerfd_release(struct inode *inode, struct file *file)
 	kfree_rcu(ctx, rcu);
 	return 0;
 }
-
-static __poll_t timerfd_poll(struct file *file, poll_table *wait)
+	
+static struct wait_queue_head *timerfd_get_poll_head(struct file *file,
+		__poll_t eventmask)
 {
 	struct timerfd_ctx *ctx = file->private_data;
-	__poll_t events = 0;
-	unsigned long flags;
 
-	poll_wait(file, &ctx->wqh, wait);
+	return &ctx->wqh;
+}
 
-	spin_lock_irqsave(&ctx->wqh.lock, flags);
-	if (ctx->ticks)
-		events |= EPOLLIN;
-	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
+static __poll_t timerfd_poll_mask(struct file *file, __poll_t eventmask)
+{
+	struct timerfd_ctx *ctx = file->private_data;
 
-	return events;
+	return ctx->ticks ? EPOLLIN : 0;
 }
 
 static ssize_t timerfd_read(struct file *file, char __user *buf, size_t count,
@@ -364,7 +363,8 @@ static long timerfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 
 static const struct file_operations timerfd_fops = {
 	.release	= timerfd_release,
-	.poll		= timerfd_poll,
+	.get_poll_head	= timerfd_get_poll_head,
+	.poll_mask	= timerfd_poll_mask,
 	.read		= timerfd_read,
 	.llseek		= noop_llseek,
 	.show_fdinfo	= timerfd_show,
-- 
2.14.2

