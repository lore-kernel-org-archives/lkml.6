Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2711254-1520286318-2-9643060893310777934
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
    t=1520286318; b=K8dmY/q+AZCr+ilBMUpYlHP1D9aV1O5ylebZFHwGrzDxr5P
    MOf3E2sgwm4BT7WoOEGnNTD1g73bghR6suyvgpQjG8biuOJK2pR7QCGTnfw5bnqp
    r0MEsjIUMBNkNMkI/EiKVELCuiVhE9g6cLLgKC33TULmaLA3e3momutMSAxlRBK7
    /CIJVyBw2x3jCM6flKz32FDgCXcqh8JxgOYEG+0RoSZNSwZ4DnfgXf/RY6+1tt/O
    x+Z1PpwItIGEQXTA8rV6TZebMcxKPLDgiGHmBkroE83Icm2N9759g2lt8F7FQ3C3
    JIv/5k51Pq+FJySdp7U1DlXaU6tz59Pa/CNOi+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520286318;
    bh=XDmYlVZfEaNXw36fjjyh7602kjE6bdKD8lA2+mSkN9o=; b=pgq5189d9v/n
    6FHst/GPb9xfy7Nh3L6TrCabRDz1CT0eHSW3/01ld7NV2GqCfQfGgSsijEIrbV2x
    ONlKusSPGfokZnDYmyadrI0Nsju/o1/oMBa/rR2wqbehILvgz4AXWZA/qjmX9eye
    uI+XVOgSiBs/gIUmSdQvxYtn4JGX6jnygEgoOMN4PG+xnnE9E7wiWNHh3vO/RtCk
    ayYoZ/QEfYNK7OeGK0sTHpKha85xeP6o0yGIgFD/VAKeR2BglhRrEBh0DFHfJkfK
    gDwC4r4uCkICmbrMFbS/SEHYWH9xn+mwKfjRbMvob54w3CHsyK5bt8BKAbTN7F+A
    KLPxfLEe7w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=t8+P6Qv2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=t8+P6Qv2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932084AbeCEVoq (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 16:44:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932069AbeCEV1t (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Mar 2018 16:27:49 -0500
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/36] aio: delete iocbs from the active_reqs list in kiocb_cancel
Date: Mon,  5 Mar 2018 13:27:13 -0800
Message-Id: <20180305212743.16664-7-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180305212743.16664-1-hch@lst.de>
References: <20180305212743.16664-1-hch@lst.de>
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

