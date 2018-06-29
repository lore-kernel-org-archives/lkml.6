Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA20C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E2327D3D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="Ov8xea/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E2327D3D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936551AbeF2T0a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:26:30 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41393 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936270AbeF2T0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:26:05 -0400
Received: by mail-qt0-f196.google.com with SMTP id y20-v6so8814150qto.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 12:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I1KqJ09/Y9VO/VmHIddPxhlI+JNBCrcVYnWeMoZOd/c=;
        b=Ov8xea/y8QEs2VzZ3lU1vnXx1Ntzy8yO/UstJ/rEdlIP1+ZCOgbdIta8PBIamYqLL7
         Ocb0WNJofDZGBkz45mFNxZmiosHU/LZf2To0WV1bOw5UMGBzw/Rv+MEM6sHSWiTNcXYM
         spVOboERE1RTPy5DIVaZXOwK1H+OiUGpQY6KeSMpNwAtpyAJEvaoLMVLD3Ug4ou0WJJ2
         x8tPOCJkd7Wi5YTrpFqLO2mZB6M1LhxzKbIUqGGrxNJqe6Lx5iGUeOn5BKg8fRN290Ep
         pcmmdlFUQRxxJGBqYMdAaV8trxIaSHfmrqqYgxwu38pFISpZ7lmVDAozu5NAva5z1thK
         8V0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I1KqJ09/Y9VO/VmHIddPxhlI+JNBCrcVYnWeMoZOd/c=;
        b=P6DK7UhbzBslnqlwgr1/clg7YOb6TYh7zNmossueZJpD5X6gZVgSQNru/2DTIZ/x+7
         LR68nTHyooumdDvGCFhGe47aNKhWmRSofupAbwmDC/gAi14vEXrOX7fLC74ZZjMdQCNs
         Onq+zLqvMbU0cDaB4oSEEWGPNFAiCppO6fI8IJ4IQi8Fc+jr1DK14TZDKz/K6TtuA6rF
         6sYazyuwzF0GhGkYw0FAcSUxOlSV0i71o3nU4+5lnA0ogGl78XeMJQeGFt+/GmdLooH0
         lLlxH+S16HGcZdfLhTGFTKozSog6SZyjq8WjpTSanLsgxMvaOQf1QvbQgHtxZR9uJBBp
         e0CA==
X-Gm-Message-State: APt69E1RycQlSOMBiWeZvs5Si4sD5T7VUdPRcx5rcR/K+YB7nLlItXL8
        fPnsE5g/HylYwA2Wxmo8Is7A0A==
X-Google-Smtp-Source: AAOMgpcIO+zbPtxloUkt2CN4dRaq8BZAKF27OQQiLwiUtRZwA0U/S+bODwKm19+wCml0sPvXillhzg==
X-Received: by 2002:ac8:40ca:: with SMTP id f10-v6mr14375253qtm.387.1530300364762;
        Fri, 29 Jun 2018 12:26:04 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a127-v6sm5798121qkd.9.2018.06.29.12.26.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 12:26:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 14/14] skip readahead if the cgroup is congested
Date:   Fri, 29 Jun 2018 15:25:42 -0400
Message-Id: <20180629192542.26649-15-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180629192542.26649-1-josef@toxicpanda.com>
References: <20180629192542.26649-1-josef@toxicpanda.com>
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

