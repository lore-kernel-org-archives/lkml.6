Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527159680-2-12041241156567881619
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527159680; b=Aq4O8zxXtzOLjU5i/9d8RgdaYcd079hMX5ez/ZmHCPfRV2oy8o
    /pG3uxP6aTvNmG+gvZGEaQs+oZdz+pOk5iO36KzTRPBO41/uqWmM8KRvaSu2w8bh
    z1JQmW5f8Ez9yyeILUSpc/PNuMrinYa/NZdNXwEeVZx/yyAZruOZzf56FV9It0tj
    8p88zhlJTv7LvuYAkB0+Rbd/yCgK67jnF8jrjqXSwY1qk7F4eA/zohs51ZnYoPX7
    ua1LETfID5X1wiUHqLlyToFlFbRCaXGzDvdKTyOP2ln2BxrvkMdFQHHa3bvAO8pe
    oVywzSZJB+D7o0GAx5PxPgpjmSZXti5bGenQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527159680; bh=
    ZfCZ0fiBDjVUc9HFH8OspGsrRQOIOXT7x+ol+Jfa8X8=; b=nEZwxky5l3ROACf8
    ApNi76LRgIRXuoiJ9o7HVPnc36ZfMM0CB+cucvyT6+87Eub5QcgFdF+7OSes0oNk
    8mRORbNyi7MQr0Zdm9coSUjxNvpnEigBSlDhjB8NAPEnM8sia1NOrSrPLP2VzvwL
    d8CCgF95slP4h1mZ3+WZTc+6r5GCH2HX0p/x9OYISaw7rUyoopFJYdBQJvN/YTr8
    ckqBQEopUmVk1Vfegrh9O1Lg0jYkyLOn0ZD/08EmjnwbdCHwZNfggUWBMSZwvLsd
    J0Epoz/dAxudDCuHXOGMCFBR2kpSkUf8Bpevo/w0fWAe9daZTK11CkLWpeFb5P3c
    NmaPlA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKc9RhEe+ju0iJZlh/xw6amEIE3ZaBGsd8hwjdrUhnC5Iq+BrsNgR8WNQqBoZCHT2RC7qM4jgckqi1y1NcYwBRVhmIaSncnDFqArXnvhowrZ+30fhYKE
    qtlpXAVsPzn5xbNXiJcl6TwHdEUTM+D1R3tPgMWnff6Y8fcbMDSbTumMcICGG4P5V2cJfq3A5YxFLtFMXHZWiDI51jpg2joFdOsp0qCWNiZxlDxvmt0zexX/
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=71kHirqOESHJkAQGzHkA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030261AbeEXLA0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:00:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:36143 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030243AbeEXLAY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 24 May 2018 07:00:24 -0400
From: Vlastimil Babka <vbabka@suse.cz>
To: linux-mm@kvack.org
Cc: Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC PATCH 2/5] mm, slab: allocate off-slab freelists as reclaimable when appropriate
Date: Thu, 24 May 2018 13:00:08 +0200
Message-Id: <20180524110011.1940-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524110011.1940-1-vbabka@suse.cz>
References: <20180524110011.1940-1-vbabka@suse.cz>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In SLAB, OFF_SLAB caches allocate management structures (currently just the
freelist) from kmalloc caches when placement in a slab page together with
objects would lead to suboptimal memory usage. For SLAB_RECLAIM_ACCOUNT caches,
we can allocate the freelists from the newly introduced reclaimable kmalloc
caches, because shrinking the OFF_SLAB cache will in general result to freeing
of the freelists as well. This should improve accounting and anti-fragmentation
a bit.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/slab.c b/mm/slab.c
index 8d7e1f06127b..4dd7d73a1972 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2142,8 +2142,13 @@ int __kmem_cache_create(struct kmem_cache *cachep, slab_flags_t flags)
 #endif
 
 	if (OFF_SLAB(cachep)) {
+		/*
+		 * If this cache is reclaimable, allocate also freelists from
+		 * a reclaimable kmalloc cache.
+		 */
 		cachep->freelist_cache =
-			kmalloc_slab(cachep->freelist_size, 0u);
+			kmalloc_slab(cachep->freelist_size,
+				     cachep->allocflags & __GFP_RECLAIMABLE);
 	}
 
 	err = setup_cpu_cache(cachep, gfp);
-- 
2.17.0

