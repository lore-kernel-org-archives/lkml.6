Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IUV+KwHeGVsoFAAAmS7hNA
	; Fri, 08 Jun 2018 01:38:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CBC9E6074D; Fri,  8 Jun 2018 01:38:18 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cS+nx1af"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4C95160290;
	Fri,  8 Jun 2018 01:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C95160290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeFHBiQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 21:38:16 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36372 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752139AbeFHBiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 21:38:14 -0400
Received: by mail-pf0-f195.google.com with SMTP id a12-v6so5797304pfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 18:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1U/liwz4F/Xy961ksalRBAfgSmg5iLR83HVgM45wYfs=;
        b=cS+nx1afDhXhCzTzjKT/h+ckzq5+vUnKLtkkwELgNa4CMH4SeoC5tvpDliIQMVOf2k
         9NSrXajIElo1GpcT2krvPD5vUMaHaU7zSIwWHzh6SUWQWYkgVzbr8/5OnAMVefeuRYMO
         byYvf+iZVaJs7zHTtRBdyBX7hgsCSXD+wGc0wBL/Z2dKDuy4DXls9UxtTh1oUYTy0Czh
         CR7TS99mdxXYq+xppmGKnTjnFJC+uYScUDabJXS48fD3Z6uc5WTTWxqzMncgdFmubROk
         kDhKHSo82KyPPj5hdlXE7v6o3+dQDH+jX76J7LkR8UPZ6UThu86kuYHUU7vKI0yepvqM
         cUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1U/liwz4F/Xy961ksalRBAfgSmg5iLR83HVgM45wYfs=;
        b=bioho8s8E5wcF3pbgVebECMSy/3Za2PB+74RPeBp7DAekb+ZsxMBsimamyt590pmx0
         tnNbqyCnktW9DxUG7tv3dBoNA9Xh5YdAg5uDXGTI585JB60ofhQwVfVxedkkWH2lMAcK
         VSYGBqjL7pe085QZzCM+ScxgkgLrgSqR0Qw0uEslSyPWkJEqfX06kOlCZsGIEVJrei/B
         /hQ7sjRFSTdkPgmXx4JE+SC2/TQdguNpg3WdO3JKJeTB50XwrNfqASLd0WlOJOtPnkP7
         3KGn9E5ti92u7C6r0fYBZxQAOhsdmX9MzguKUbhNtd+hliIpYc0jnu0wLayQYR/0mcHj
         nWnQ==
X-Gm-Message-State: APt69E2ZUo1BvCaflpNs8o5OKo2OYQIaOCrNJ/c5ZXI2+OZAxmz7Z9wu
        1iSV4eLRxemhW6z9J07bvWN4BkLomgM=
X-Google-Smtp-Source: ADUXVKK7tcBYy4hHA1lQNaogjgxhhsoDG+EVZ2uqnfYiwsfblInhFY+Pt2q/IJ1PeUX7E9i1pLGuGw==
X-Received: by 2002:a63:6647:: with SMTP id a68-v6mr1687924pgc.82.1528421893993;
        Thu, 07 Jun 2018 18:38:13 -0700 (PDT)
Received: from shakeelb.mtv.corp.google.com ([2620:15c:2cb:201:3a5f:3a4f:fa44:6b63])
        by smtp.gmail.com with ESMTPSA id j19-v6sm11971449pfi.84.2018.06.07.18.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 18:38:12 -0700 (PDT)
From: Shakeel Butt <shakeelb@google.com>
To: Jan Kara <jack@suse.com>
Cc: Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH] fs: reclaim least recently used dquots
Date: Thu,  7 Jun 2018 18:37:59 -0700
Message-Id: <20180608013759.46315-1-shakeelb@google.com>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Thelen <gthelen@google.com>

The dquots in the free_dquots list are not reclaimed in LRU way.
put_dquot_last() puts entries to the tail and dqcache_shrink_scan()
frees from the tail. Free unreferenced dquots in LRU order because it
seems more reasonable than freeing most recently used.

Signed-off-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 fs/quota/dquot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index d88231e3b2be..241b00f835b9 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -716,7 +716,7 @@ dqcache_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	unsigned long freed = 0;
 
 	spin_lock(&dq_list_lock);
-	head = free_dquots.prev;
+	head = free_dquots.next;
 	while (head != &free_dquots && sc->nr_to_scan) {
 		dquot = list_entry(head, struct dquot, dq_free);
 		remove_dquot_hash(dquot);
@@ -725,7 +725,7 @@ dqcache_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		do_destroy_dquot(dquot);
 		sc->nr_to_scan--;
 		freed++;
-		head = free_dquots.prev;
+		head = free_dquots.next;
 	}
 	spin_unlock(&dq_list_lock);
 	return freed;
-- 
2.18.0.rc1.242.g61856ae69a-goog
