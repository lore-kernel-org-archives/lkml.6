Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8796FEC3100
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A95B2124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="dLV42eCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A95B2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbeGLTEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:04:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42786 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeGLTED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:04:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so3163647wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 11:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5jQgELfyD7VNwzfhRyNUzqx6eCK+QCKeBT5JYYC3SAs=;
        b=dLV42eCVC8/pldkn6MVgibLRU+ekXFam4i7M9HN9pQ+1rMmD+tf4livFkN859PfwVL
         LLfkbeNVVnDv7Ug+ib0w0o2Ql9RgE4dTVw+X0wL1uIupqdhabZLXpspyp5FKTCdh/CMt
         pzOIDF7rDUXT7PvClzc2UXYXnff40BqWCdmVdvMciH7PH80qybiovXL7A86liwIxO+TP
         efbfbvZ/IOK+TjamrjIhdYXry3KkdnH6EdQ4jLoyR6nKawqpc4SK2+bdKthXASBRWvtT
         HMt+Q4JBU23paGczaVDpCQxzwQRrvrU0Ln74HHvpzC/hayDYy3qYIXV5hDt3y9lfZFZL
         Lfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5jQgELfyD7VNwzfhRyNUzqx6eCK+QCKeBT5JYYC3SAs=;
        b=nSr140GAC7gIN2EOjP3skg7iQWJgwqrXSqVy4cbsLisMYWJIcVDk5fWUBISpC2i1m+
         jqgC+7/4TM9Tm1oJ1dVkMiprAHuu65B9Nrr6Va0StNPs3E166lHTLRhpLFMkxgsbQU5+
         FF9JA6ZmExCEuDp2PNjZrVAXMPKV9ShpnJ8azqXj0k7Lmi2RFmfw3NqF0DDHWBJxcRl6
         cnk6au5ALeEO96CyLcKCamHkcB+q1FhmLYL368p7Wkgc+iFMcE766sWw+5aFKpl0uf7y
         sRYP9hJ5C4J0vjqmqNNH2/HOHaE/+yaKFgqz6hiFr4TsxxbSQlxIjzqibzbo7Ju6df9m
         FWeg==
X-Gm-Message-State: AOUpUlG0Kv9Ezan2qk3efDrpZJW/3QcrUMqDGo3I2fXQL9Ru7tCE66kk
        g6J8l/+Vb4X0fzTNZhs81WcHOA==
X-Google-Smtp-Source: AAOMgpfMPDOS0ApIh7N+YNBu/V6/rjD8woRZs4wTjmfO9R+Y25Hvzpdc5l7u+uK+OEqtt+KEkIo1eA==
X-Received: by 2002:adf:8103:: with SMTP id 3-v6mr2214951wrm.213.1531421593900;
        Thu, 12 Jul 2018 11:53:13 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C98700CB5FA3798C189FE1.dip0.t-ipconnect.de. [2003:d9:93c9:8700:cb5f:a379:8c18:9fe1])
        by smtp.googlemail.com with ESMTPSA id h5-v6sm13557841wrr.19.2018.07.12.11.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 11:53:13 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 08/12] lib/rhashtable: guarantee initial hashtable allocation
Date:   Thu, 12 Jul 2018 20:52:37 +0200
Message-Id: <20180712185241.4017-9-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180712185241.4017-1-manfred@colorfullife.com>
References: <20180712185241.4017-1-manfred@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

rhashtable_init() may fail due to -ENOMEM, thus making the
entire api unusable. This patch removes this scenario,
however unlikely. In order to guarantee memory allocation,
this patch always ends up doing GFP_KERNEL|__GFP_NOFAIL
for both the tbl as well as alloc_bucket_spinlocks().

Upon the first table allocation failure, we shrink the
size to the smallest value that makes sense and retry with
__GFP_NOFAIL semantics. With the defaults, this means that
from 64 buckets, we retry with only 4. Any later issues
regarding performance due to collisions or larger table
resizing (when more memory becomes available) is the least
of our problems.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 lib/rhashtable.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 083f871491a1..0026cf3e3f27 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -179,10 +179,11 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 
 	size = nbuckets;
 
-	if (tbl == NULL && gfp != GFP_KERNEL) {
+	if (tbl == NULL && (gfp & ~__GFP_NOFAIL) != GFP_KERNEL) {
 		tbl = nested_bucket_table_alloc(ht, nbuckets, gfp);
 		nbuckets = 0;
 	}
+
 	if (tbl == NULL)
 		return NULL;
 
@@ -1065,9 +1066,16 @@ int rhashtable_init(struct rhashtable *ht,
 		}
 	}
 
+	/*
+	 * This is api initialization and thus we need to guarantee the
+	 * initial rhashtable allocation. Upon failure, retry with the
+	 * smallest possible size with __GFP_NOFAIL semantics.
+	 */
 	tbl = bucket_table_alloc(ht, size, GFP_KERNEL);
-	if (tbl == NULL)
-		return -ENOMEM;
+	if (unlikely(tbl == NULL)) {
+		size = max_t(u16, ht->p.min_size, HASH_MIN_SIZE);
+		tbl = bucket_table_alloc(ht, size, GFP_KERNEL | __GFP_NOFAIL);
+	}
 
 	atomic_set(&ht->nelems, 0);
 
-- 
2.17.1

