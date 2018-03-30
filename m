Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3779118-1522424738-2-13493340227774434169
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522424737; b=M068pbVZeYDO4wKAZAFPQYd+Geun4MOwK2b+NUVDUS3vG+UIbE
    SLTXS5qm87uilInCHHh6GwSyeEdhi/CDHQlCIYsP0imuSjRBndOokSAfdBr5/Dmi
    Vkkk4dj9Lx9fPumdZHlsXtG9h1CVoVhqrwBRDCW5TgKKl0MUjXRQC7padpqLnkpG
    /NrcPyVZJOpNia4MBnEihoTTW5JSop/QY9u2G1Nrwae7TivaDhcLpJofAgv3CC5r
    untEawnfpkLYbHgRejWG00F3eGVra0gG2ceIWXmymJd+uBiKiaeaUhfZlu3MWmW1
    7eGVKwcwjxwDEBog3HGUcn/zXcVGLhS541uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522424737; bh=
    Ggz/rNXWiikI0ka3wRDV7+PPmrdCR+0U9UPTcuZDFlc=; b=FWUVTOMa2JmsFtGv
    hlKfpqXEHHAWZC8CSB/AE0RMcVyzqSZ9hCDRt5O5hHUn9RilBWMGGTtXlqyQQmXY
    hzvJ8Gf/l45lzVekcz5Ugd0N5I1uo/OfUzmxXuYJHGqPVw5DKL4ORec7mxbWCyRR
    p8lqaJLu3ZrfGPDLNXn5KvxFgfH92PZyLQLxaZeX6Ir5CQ7vUomyBLuOcQdmeoLd
    oI0xkZ3HNRkL7UXh88/YZkfAgkttbKh3/nVxZb2zxFlnXqBiCTjruMwLGBEs0bck
    rBMjci66pDJi3N5zt6XnrpJ8T55XVldna1uRwk1OPMSfgX+b78c/iKTv2NEFmWEe
    wbuOgw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Y/BPsyPS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Y/BPsyPS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMbDBpXExX6VwhhNEu/3UpXhyCWSVFZjXLB29s/Wi+/GK+ET7G6zDZtiaQvSs4n0hPGZD49vPKvZjKrU1CPiF24UGbPiaoWxkJH24E/nKwQSYruIBFjU
    e78v3C5hRnoUtvwnkiOfD5kZQprkWsMVXJ8M3Al88wLMJctfXGi9b5cSxm5grW0uGwiAQFnQ/cM1qDRYzH8Rri8pl2Bbpz3eVWLpyArJmZcqsHtRKkTrybzR
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=glk3bNZYZL77nadNM_AA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbeC3Poe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 30 Mar 2018 11:44:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbeC3Pc0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 30 Mar 2018 11:32:26 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 30/32] eventfd: switch to ->poll_mask
Date: Fri, 30 Mar 2018 17:08:07 +0200
Message-Id: <20180330150809.28094-31-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180330150809.28094-1-hch@lst.de>
References: <20180330150809.28094-1-hch@lst.de>
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

