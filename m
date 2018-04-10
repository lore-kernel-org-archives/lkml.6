Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836988-1523364843-2-16879934718486031629
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES sk.us-asciienca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523364842; b=ZU6cZiB2QG9DUIEluMlZ/uufF8QpzmPss55SnDqyyDcO4AHjCu
    B9XbmYLcfT4FbAvDklvz/py+z/PFdDty+V4NacJHjIKxihUu3aCY7oZxE9+U9G7Z
    l2e3BSzszb0D1O7UP0kRu+ln8wDQ8VGmASUafXRpkXvl1d601KBzhtaB0mSSFjX+
    iNselquSqoRCdlGbItOa++1k/d7tGZILQZXX3VZlAjJLII5mPHh7GyQ5RR0E0xKN
    B4dk4SZD1J9fgYtvIy0dpaxTgM4KNHDX39/zHIygcumWXTI7icwzEjoclRjN6B7a
    bhiCHiIsi+hvzy5PCZ+QEv6KAYDjfwQZ1C5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523364842; bh=eac1jG3rZJD0f9lmeuIAxoQk6lfNG9
    tLn8arejvI09k=; b=kWV+mUFRep6kVgykSHfLHKGIWoldvWfZzsnQDfw3BLpfIl
    aHywHTcbQNNxAZYnBhCSLL6LZWS43IvIjT9E0Y+4P2oiRgqcAdg4ImytOU2FaY17
    l/sprvEPSLoBLwO21l+PKOjN3lgPf40HOti7LOoAoPXR2SLduLQXP9w9tlxMuXkV
    x/f2TTPmx6jISxhZRCPoW6iB0Fu2fwVMLZOIdSTOVQ8a3kgKwAa9YV2opNUGO96Y
    stBldHCNfsUJBJs9CJ4DT9LVbGefD5Jmt+Pw8zmA0F+pJ6OPlljkifQrn5s5i2Pi
    Am+p5cQaqVD2O459e9MbqphleB9GeKCqP8/WZKig==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=s1iOtu9N x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=s1iOtu9N x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIy0X0799Gj39Leks53my8NXh93gAZba6k2uZH2C92M5fIV0qegS5GcvXunT3JeMR1lXwnWkB7aordUumuBHMA1S4am6XiJUaMXAfpbB1+wlwj1u1RBy
    K6RR9esck1irD+PdrtkgXwX/LLUfckk35FpgYbTrboBPnEEF+Hk15kGy92EFdoMYHo8sQnWwx1nBwZgShwgK5ZPkeG7R3EI3QR7p86q0YnfUDbKKyHb84Shp
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=yMhMjlubAAAA:8
    a=VwQbUJbxAAAA:8 a=ChNhmaFWNEd2nPMphe8A:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbeDJMyA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 08:54:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37194 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753164AbeDJMx6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 08:53:58 -0400
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        stable@vger.kernel.org
Subject: [PATCH 1/2] slab: __GFP_ZERO is incompatible with a constructor
Date: Tue, 10 Apr 2018 05:53:50 -0700
Message-Id: <20180410125351.15837-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthew Wilcox <mawilcox@microsoft.com>

__GFP_ZERO requests that the object be initialised to all-zeroes,
while the purpose of a constructor is to initialise an object to a
particular pattern.  We cannot do both.  Add a warning to catch any
users who mistakenly pass a __GFP_ZERO flag when allocating a slab with
a constructor.

Fixes: d07dbea46405 ("Slab allocators: support __GFP_ZERO in all allocators")
Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Cc: stable@vger.kernel.org
---
 mm/slab.c | 6 ++++--
 mm/slob.c | 4 +++-
 mm/slub.c | 6 ++++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 38d3f4fd17d7..8b2cb7db85db 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3313,8 +3313,10 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid,
 	local_irq_restore(save_flags);
 	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, caller);
 
-	if (unlikely(flags & __GFP_ZERO) && ptr)
-		memset(ptr, 0, cachep->object_size);
+	if (unlikely(flags & __GFP_ZERO) && ptr) {
+		if (!WARN_ON_ONCE(cachep->ctor))
+			memset(ptr, 0, cachep->object_size);
+	}
 
 	slab_post_alloc_hook(cachep, flags, 1, &ptr);
 	return ptr;
diff --git a/mm/slob.c b/mm/slob.c
index 1a46181b675c..958173fd7c24 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -556,8 +556,10 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
 					    flags, node);
 	}
 
-	if (b && c->ctor)
+	if (b && c->ctor) {
+		WARN_ON_ONCE(flags & __GFP_ZERO);
 		c->ctor(b);
+	}
 
 	kmemleak_alloc_recursive(b, c->size, 1, c->flags, flags);
 	return b;
diff --git a/mm/slub.c b/mm/slub.c
index 9e1100f9298f..0f55f0a0dcaa 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2714,8 +2714,10 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 		stat(s, ALLOC_FASTPATH);
 	}
 
-	if (unlikely(gfpflags & __GFP_ZERO) && object)
-		memset(object, 0, s->object_size);
+	if (unlikely(gfpflags & __GFP_ZERO) && object) {
+		if (!WARN_ON_ONCE(s->ctor))
+			memset(object, 0, s->object_size);
+	}
 
 	slab_post_alloc_hook(s, gfpflags, 1, &object);
 
-- 
2.16.3
