Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2711254-1520286213-2-10164544650049980882
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
    t=1520286212; b=HyK3kpQMiflvFhOp0tzc0qoelRxExHGwLDqOAcVsXl26krH
    9Rpsodd9ckux3Zq3HivtJU543STKGTAmAtt7+XJHympv21UG06w9sJwNHpYPS/FS
    g9YABDL4jVDt4pygAogRy1o5IswDg3qjMlRI8T764Nd6gjJYZiF4RPjDjQ3EV/Q5
    GYpxoMb6UgWWMiuF3H4fCh9B8k0gPLRBlPsiXgBUis+0gm00keL8dA+6Qsw5ZnBH
    VWmNKh95KiwpZljGp2bMOjv54SATfTrRtJva45LVnNrKyqWZs5M4+R/2nKr9Bi7/
    U57Ah+je8Iu+0ijMIRUshJpzoNqMHQ2TLkaDEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520286212;
    bh=bqKnQavJboaqa6bV+AqVJwkWOWZm5FlTPdj/h0QAi1M=; b=U23abVDpNihL
    VQ52V39aRmjmICqTRFmvkA0HFxsD9GOCVoBS3qiNJBILqPrnuOHLJSbliQLqiyeK
    cmY2cHF8GL17yc+jBNBCjr3O6NGr9/0kizt5mFP2pnw1thIIKlGzPwCm7PScukNi
    Au/tRVGhiYVtrS8d/8dYAh5jPsUGNWy8sQB/fZS2snhkSENhWSCKBRwFn7YN/5es
    4OzVzykZjwSLejpvi7Dw1uUk+TtE4tnIpoAUj2pS0t0E5wFaq3hV4tBZYRUfPAnx
    K4eZx1OstGoCar11McQYtq7foazMETXzhXLwXy/ikMO1Yf1sV9Zca7QDV7U56xja
    6H6L5FNang==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=J/8SwFhu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=J/8SwFhu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932530AbeCEVnM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 16:43:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932313AbeCEV1u (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Mar 2018 16:27:50 -0500
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/36] aio: don't print the page size at boot time
Date: Mon,  5 Mar 2018 13:27:08 -0800
Message-Id: <20180305212743.16664-2-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180305212743.16664-1-hch@lst.de>
References: <20180305212743.16664-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The page size is in no way related to the aio code, and printing it in
the (debug) dmesg at every boot serves no purpose.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Moyer <jmoyer@redhat.com>
---
 fs/aio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index a062d75109cb..03d59593912d 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -264,9 +264,6 @@ static int __init aio_setup(void)
 
 	kiocb_cachep = KMEM_CACHE(aio_kiocb, SLAB_HWCACHE_ALIGN|SLAB_PANIC);
 	kioctx_cachep = KMEM_CACHE(kioctx,SLAB_HWCACHE_ALIGN|SLAB_PANIC);
-
-	pr_debug("sizeof(struct page) = %zu\n", sizeof(struct page));
-
 	return 0;
 }
 __initcall(aio_setup);
-- 
2.14.2

