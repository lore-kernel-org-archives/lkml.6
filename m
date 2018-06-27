Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC09EC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD2625D4A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="TlzslJfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD2625D4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966302AbeF0TK0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:10:26 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35740 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966255AbeF0TKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:10:05 -0400
Received: by mail-qt0-f196.google.com with SMTP id z6-v6so2639350qti.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I1KqJ09/Y9VO/VmHIddPxhlI+JNBCrcVYnWeMoZOd/c=;
        b=TlzslJfipvVt0wAvZxZiB+DjhfXTTsEWYQwxVlf2uoX57XdIjRya3H9qQ6qTeqLaQs
         WeevMY90SGKKpbyRtudPgRzLd56cOYyEtKxQFqir4+wTZENZqwCrJJX1bsTBnRtrtwlH
         ZMb59Ji/09SrXKxkQ9D3WZDsv9Z39NfA662B9KWn8MEdSEVJzQQBT3GM2NWPVmwEObDz
         yt/Bln2uV4e2F1m902f2b/+CbWZyhi3UeoDEC8TZLWa7yjizxeEGcKEDOM0bz7kVhUcu
         H4TcygzOtegpksXJpOEYg4VYj6cTBhDqdbH3q96yjfDUQBqSxNbQ2wJUO4A6wKd8lyH8
         VFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I1KqJ09/Y9VO/VmHIddPxhlI+JNBCrcVYnWeMoZOd/c=;
        b=IQclEuQQEXAQ/gtwvnUG3w1GjxxJAE5JoBtgC7b2vIKE8Na1/vqCdFBf93gWFQbpo1
         iA+nRXo7ISdP174zaihT39sAjna5gqRJize7ZjjNXe01bBGBQF1m5w4jjf1TSugXT8G0
         N48pbqGtFkHKCwtxMezTnH1bwjm7JYAi0xu5c2PDuguUWHVmJdTuTojpD1NP1GalQAQ9
         i2Z07zoxggnfNpztxl5PrL2S5mpON0cnVFk4flxKzvrXC7g3IZ73hJ3ILzA6ymxSaqOc
         7WPT7fGjRlBXldVr2ZjjHvx/wBcURK/Rf898z1V+YpGTBzyJQXy5YGmT08pevJXjtMCG
         374w==
X-Gm-Message-State: APt69E0XPfbvxAkOX7u3UndoYKYcyQM1CkN17RLAlm1+kgwhzKxj11+s
        6K6dCbNroLay2GZZ37o23ALX4Yys
X-Google-Smtp-Source: AAOMgpd1UUVAN3lYkmYZtTvoeRlpDq/URSgW84EBrHpjPLyZ8z4c5tIaItB8J5Mt/9aTxh8z1rlYQA==
X-Received: by 2002:aed:36e7:: with SMTP id f94-v6mr6716094qtb.276.1530126604636;
        Wed, 27 Jun 2018 12:10:04 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y128-v6sm3448733qkc.1.2018.06.27.12.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 12:10:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 14/14] skip readahead if the cgroup is congested
Date:   Wed, 27 Jun 2018 15:09:40 -0400
Message-Id: <20180627190940.4696-15-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180627190940.4696-1-josef@toxicpanda.com>
References: <20180627190940.4696-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <jbacik@fb.com>

We noticed in testing we'd get pretty bad latency stalls under heavy
pressure because read ahead would try to do its thing while the cgroup
was under severe pressure.  If we're under this much pressure we want to
do as little IO as possible so we can still make progress on real work
if we're a throttled cgroup, so just skip readahead if our group is
under pressure.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 mm/readahead.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/readahead.c b/mm/readahead.c
index 539bbb6c1fad..cda6b09e0a59 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -19,6 +19,7 @@
 #include <linux/syscalls.h>
 #include <linux/file.h>
 #include <linux/mm_inline.h>
+#include <linux/blk-cgroup.h>
 
 #include "internal.h"
 
@@ -500,6 +501,9 @@ void page_cache_sync_readahead(struct address_space *mapping,
 	if (!ra->ra_pages)
 		return;
 
+	if (blk_cgroup_congested())
+		return;
+
 	/* be dumb */
 	if (filp && (filp->f_mode & FMODE_RANDOM)) {
 		force_page_cache_readahead(mapping, filp, offset, req_size);
@@ -550,6 +554,9 @@ page_cache_async_readahead(struct address_space *mapping,
 	if (inode_read_congested(mapping->host))
 		return;
 
+	if (blk_cgroup_congested())
+		return;
+
 	/* do read-ahead */
 	ondemand_readahead(mapping, ra, filp, true, offset, req_size);
 }
-- 
2.14.3

