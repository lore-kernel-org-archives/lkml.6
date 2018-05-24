Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2597100-1527197324-2-10430674584197173654
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527197322; b=JXmLYHd3i5nAJ+S/jlnjgsCmTMGOReNX3nwfrRUA+hg9dU8STl
    73Qu/Bd1wHW4QE15uBpX/T8G23lbcZFNkRTIaf98gN5sGoG3AC7klqTNmZlbn3ni
    NDYo5AdHysCTU74KAJ0PKrxuNbt+nkvmc2JvBBJMxsaat4wz6CzugsRlG0YetCrc
    rODDF3mgikkUDoF1UMPzwYP98wzIldNmLZY/euTnys3k9/q2xeQl9dkjktCz9wn0
    VCr4PV3ftZuWe3YhrPBbAmqsGCE5twwExkL82I5zTy07zZz8WeBjLt+nBxBdrzy9
    gzTQCdCsu8h8siWyXyWug21zAXFO4VjU3/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527197322; bh=
    /Ss1YVMyvs2GpiG7Ufl+ymSWKbK38a2LT195xQrRDdE=; b=f8PfR4GGQnuCYFXN
    L/2b29ty/WXTaXViSwBa9Bp+FmNTz5vHFyJBJCwU37S6h8hcrMZJGCPzwgFLYejq
    Gar6XTUPVJ0NC2IwvU4RUmWavihrv9Ce4alJf0AVcQH0e1QkxoSwvqmsGSV+QTnR
    Oz/3s/Y/QVEjMMxR7leXdxooD7eJUlMrctx4vb4k7lxVmsToz4SBOs5yHy+pfg4I
    QhQJNverj2hBn53KU/MSM4CjWMrN0wUyD0TVao/AnKK4OVzWi9eoD0WMKLfFIHHX
    8zsdKeC5Fuo50NXYvi0rdWAqfewBL12i7XXh0aZWk7IZxb6zQGvqOQoPK2V3rNVj
    mvtS6Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=stgolabs.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=stgolabs.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAjFovc3zSCOL2J/LOMgBZeQaCfi4bYwzEpqcrcBS+Ig3TOmRiKp9sUcv0QkGoGLMgq/8Plxy4jH1NW6qysmJjjAU4AV8bP38i+ZNgqhpEFSYBWu5Bnv
    +L7MWGXKFixro7Pm4dr/5FAs8e3s3bCnlzfGB+MCbFlUBndB01el8CVjPduEJ5ITZtWwFis82v0lAoc55Okr2xjMnqNjxMYgve5pxY2n9vxx3Xei2sd9ZRfQ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=fUSZZkATYxXnQMecnGkA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161364AbeEXV2h (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 17:28:37 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:55055 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161324AbeEXV2e (ORCPT
        <rfc822;groupwise-linux-api@vger.kernel.org:0:0>);
        Thu, 24 May 2018 17:28:34 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc: tgraf@suug.ch, herbert@gondor.apana.org.au,
        manfred@colorfullife.com, guillaume.knispel@supersonicimagine.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 3/6] lib/bucket_locks: use kvmalloc_array()
Date: Thu, 24 May 2018 14:11:32 -0700
Message-Id: <20180524211135.27760-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180524211135.27760-1-dave@stgolabs.net>
References: <20180524211135.27760-1-dave@stgolabs.net>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For some reason we don't use this call, but we rely just
fine on kmalloc_array(). Make both consistent.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 lib/bucket_locks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bucket_locks.c b/lib/bucket_locks.c
index 266a97c5708b..75fe7386756f 100644
--- a/lib/bucket_locks.c
+++ b/lib/bucket_locks.c
@@ -31,7 +31,7 @@ int alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *locks_mask,
 
 	if (sizeof(spinlock_t) != 0) {
 		if (gfpflags_allow_blocking(gfp))
-			tlocks = kvmalloc(size * sizeof(spinlock_t), gfp);
+			tlocks = kvmalloc_array(size, sizeof(spinlock_t), gfp);
 		else
 			tlocks = kmalloc_array(size, sizeof(spinlock_t), gfp);
 		if (!tlocks)
-- 
2.13.6

