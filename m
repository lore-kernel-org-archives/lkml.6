Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC75C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A99725C60
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="EQF8Lm1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A99725C60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964828AbeFYPR4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:17:56 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46521 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934752AbeFYPMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:12:49 -0400
Received: by mail-qt0-f193.google.com with SMTP id h5-v6so12210543qtm.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gkdJSYLh9LN7Ss8j0Rn9mX3g9Rqhn9vecXPFB0z5w9o=;
        b=EQF8Lm1v9iOrAGXShAs6yzFBe5UdR2PvSB5ZajUzmT2yXGXW6RIxpfYDkZ8sbBbZWB
         dLusYs55wJ6tR67k/i1gr2bkP6L4OHjWzgCWjkM6HxS9hVnEAapykK6ItuHlN3ty77cm
         2yGzv47+qsZpEdubSwsdWO85l8EwTfgpi4um/eBhSMvlg2oE67JOiWRHfvVynpRUXM8P
         aOWRjRr0zAJhy0E1Aa1gcur39A9/s+S5MRdFSEf58Qj4M1iPim66567zCoFET45OlQE4
         M8FJdD0iNpdS5yAFhigqoi71P4MBV/0WK/rmib4xl+dTwlsSneRfmZWvdWMrpNyL/jFo
         U7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gkdJSYLh9LN7Ss8j0Rn9mX3g9Rqhn9vecXPFB0z5w9o=;
        b=d6dU5yiwX7G/hjw5wOHdz+2jVNtEq2awZq7rPW99opSzD7OK8rJ/LLH6ppyiXfNBGL
         LxxNFq+Irn92ZonZRwclmIE2QMRUEq0Wl10FYn0CKGSV8eYO0exKQoGYcSkgheXKSzRv
         9x3W1lHg1vPKGghwo38bdhg1+kFp3sKPUAO5RDvJjxVCw7tdsOXewhh/RyeWHGkInhb0
         EVY4OLtr9xGywQlbOMGJHpaH+/doa/GoUEjmKoDM4UfeHYRCPiCN5sRkC347K0Q/Pu9Z
         OAAxBABgsTNZmfqc2b+B4R/uqg9bkbcgcwUbo/NQEM50Ooaap7P0np0/GoxNEXyj0kCn
         q0hg==
X-Gm-Message-State: APt69E0SjLP1LfA/Fc/3P4e/721KP32JCllw1j0AXni/BG/4vksZdGfo
        9lZ5kolMcX8fWsjEeu5jP8HsBg==
X-Google-Smtp-Source: AAOMgpeSJa1CXpx5Yr9ZDKOghBCFPjbPBNf1GgMLrdwY8pFxLX/0JMb84yMStsej5Fe6subN6TaJlQ==
X-Received: by 2002:aed:37c2:: with SMTP id j60-v6mr11330385qtb.417.1529939568954;
        Mon, 25 Jun 2018 08:12:48 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g49-v6sm10878806qtc.3.2018.06.25.08.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 08:12:48 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 02/15] block: introduce bio_issue_as_root_blkg
Date:   Mon, 25 Jun 2018 11:12:30 -0400
Message-Id: <20180625151243.2132-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180625151243.2132-1-josef@toxicpanda.com>
References: <20180625151243.2132-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <jbacik@fb.com>

Instead of forcing all file systems to get the right context on their
bio's, simply check for REQ_META to see if we need to issue as the root
blkg.  We don't want to force all bio's to have the root blkg associated
with them if REQ_META is set, as some controllers (blk-iolatency) need
to know who the originating cgroup is so it can backcharge them for the
work they are doing.  This helper will make sure that the controllers do
the proper thing wrt the IO priority and backcharging.

Signed-off-by: Josef Bacik <jbacik@fb.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 include/linux/blk-cgroup.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 6c666fd7de3c..69aa71dc0c04 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -238,6 +238,22 @@ static inline struct blkcg *bio_blkcg(struct bio *bio)
 	return css_to_blkcg(task_css(current, io_cgrp_id));
 }
 
+/**
+ * bio_issue_as_root_blkg - see if this bio needs to be issued as root blkg
+ * @return: true if this bio needs to be submitted with the root blkg context.
+ *
+ * In order to avoid priority inversions we sometimes need to issue a bio as if
+ * it were attached to the root blkg, and then backcharge to the actual owning
+ * blkg.  The idea is we do bio_blkcg() to look up the actual context for the
+ * bio and attach the appropriate blkg to the bio.  Then we call this helper and
+ * if it is true run with the root blkg for that queue and then do any
+ * backcharging to the originating cgroup once the io is complete.
+ */
+static inline bool bio_issue_as_root_blkg(struct bio *bio)
+{
+	return (bio->bi_opf & REQ_META);
+}
+
 /**
  * blkcg_parent - get the parent of a blkcg
  * @blkcg: blkcg of interest
-- 
2.14.3

