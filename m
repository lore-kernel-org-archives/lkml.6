Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788E2C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D2E24C39
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="MVm3juD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D2E24C39
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934983AbeFYPOQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:14:16 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33333 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934872AbeFYPNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:13:07 -0400
Received: by mail-qt0-f196.google.com with SMTP id l10-v6so12257173qtj.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I1KqJ09/Y9VO/VmHIddPxhlI+JNBCrcVYnWeMoZOd/c=;
        b=MVm3juD2xKZX3dYF8WMBWCsBcGVI/sbBPW4FyC29SqDhEKBn7h5h6I8s1m7alhQNRG
         80bAiZKJgsjz9Eju7BtwX9nR/vSSTxowg3sjqw+Ac5SKykni00uootHS4Lm22svLZWgr
         FQjImYVI9MxOZ8sGswWRBufoR/9/GwP/ppY5Wq+DYcbHGUrpRH+3Crq/FNl8fajydvS9
         NF4ynaZvv97WmmXoh/3NUyJE5/C3eU+gkO8r87IVKs3Ab6oQLY6bpCDWqrEx8sRJf6RO
         XnNuGnzycw46NyouCuwv/jTxlzuos0bojiwPz/yzzXMozNXuMsEwnXdkDdGNNDl3xIUC
         qDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I1KqJ09/Y9VO/VmHIddPxhlI+JNBCrcVYnWeMoZOd/c=;
        b=ABS7QlPbTg48XyrGITcfPOAR+U8AE0JzFYlQ35iTkq2XPxsQablH1UrurlItAVv2Qs
         TLsQuq3wv91vLrUtUlRuN82QKEXvbomm+eCIv2pl1hx3F3TqdIb8rpgb3RCP2W7iNVdd
         sPmk0816/g/e9fG5wK3iZfdlcTppL0TfqzexAjaIm8IHaUJl3cMtgAJREOnovuWSiFWS
         MLwX2/xuI3RQEYT7Q2Fh7qsreQrpFkfIIQn0z0KlfUai3Feo8FPht/ivD61SiMpumXVV
         c5gUGp+N8zQV63i0Q9/28stoiJGa0iLAppHnfyx6EbP7HmufDQB88QAZMql+uOsN0xT7
         lCLA==
X-Gm-Message-State: APt69E3M7YwqlJGXrJZFNmK5Wv2Q0ekXV1ECNHgD+u+N7lOAMAZ8ctR9
        mp+XpW7yloslW3LbG3mho/wPvQ==
X-Google-Smtp-Source: AAOMgpff8jfbASvhyUat7T5UuovtznVzWzuX2wecRGcxoDF3+PIR2Lt+m5SxfF2J06XsyN5YXgVedw==
X-Received: by 2002:a0c:b41e:: with SMTP id u30-v6mr8718091qve.102.1529939586708;
        Mon, 25 Jun 2018 08:13:06 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m63-v6sm10699398qke.9.2018.06.25.08.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 08:13:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 14/15] skip readahead if the cgroup is congested
Date:   Mon, 25 Jun 2018 11:12:42 -0400
Message-Id: <20180625151243.2132-15-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180625151243.2132-1-josef@toxicpanda.com>
References: <20180625151243.2132-1-josef@toxicpanda.com>
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

