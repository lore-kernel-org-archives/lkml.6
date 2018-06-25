Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98E9C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9366F24FF3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="am9EMPee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9366F24FF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964784AbeFYPNn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:13:43 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36911 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934876AbeFYPNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:13:09 -0400
Received: by mail-qk0-f194.google.com with SMTP id t79-v6so934970qke.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=9y7CqGBN0TOAnxl5iFoh9qAAnZAPUKalhtMJvSXgCMA=;
        b=am9EMPeedoR7dbs5flGHcMsyF+0dUFS/3KNxFWY/I4pDOCqXzzy1gPehNxTD4URxgN
         xJCKN2XW0V25SodLCw34ICrs0+mOE0DYB7VvqintDs8WDBq8x9KLF9Np7G12eiWLxaZZ
         Ky12+N811o8lP/o1ymax+25zqM8O7dGg6zhxPBhQXnlnLRdxpnlkdUmG7FfPXsjDR9EM
         b0qqldsPGFRTfPbUm2lr1zeSghHdPOW8LFUsLCjldNa4bZI1lhfMckjSgTodQMvo8gP8
         yI2c1iixXoJHYwwven2e0dca/+dwQCHYJYia4zIvlNrjP58T/vJwZ9qCfdMMbH+jUwt0
         3xbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=9y7CqGBN0TOAnxl5iFoh9qAAnZAPUKalhtMJvSXgCMA=;
        b=j2hFnadx7RmE8Ke5EEmNNcvfyrCtTAD1FrpIZugPxW3hzOaIfyEdWpfLgAFDQuUnp7
         0xXxtVbl29Bp/obPP+l9Uclcu1F23d12ukgDTtnm0Nl787ov4LDkHoNq8ex3btInZUvP
         dRZ+Qvuv3obCjC9LaTxAtJ0n9gEeU3Ll9638XxdKMCmoUzjQgnsKAttd0u8auxm8TEYX
         Ls6SNg1BGYE99LYn4qBOGtbFQtDxWdeoTRXGEEolgf01q5AjDdLu2wxIKNsMtOqGMVN2
         WbX3pZD/8r9l73luuGTaos+SjsGr8AYg2ngcB1L/19mx7rHz70o9dlnxR1aAiI3A50l4
         7cIw==
X-Gm-Message-State: APt69E12OiSD1t4k0TJt5NMQPkPppR5e7JWMR9EbH68mPA0QWwWUNz5B
        klcynEhLhc+Zd39uFT64C+GYQw==
X-Google-Smtp-Source: AAOMgpeT3yPn6S589G6plaJ7JwWPExLCInSgB7F0+h1vgdcWEHi3RKaDCf6H+rj9RT9aK9U+G+hHNQ==
X-Received: by 2002:a37:6086:: with SMTP id u128-v6mr10501271qkb.8.1529939588248;
        Mon, 25 Jun 2018 08:13:08 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d192-v6sm10414549qkb.46.2018.06.25.08.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 08:13:07 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/15] block: use irq variant for blkcg->lock
Date:   Mon, 25 Jun 2018 11:12:43 -0400
Message-Id: <20180625151243.2132-16-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180625151243.2132-1-josef@toxicpanda.com>
References: <20180625151243.2132-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We inconsistently use the irq and non-irq variants of spin_lock for
blkcg->lock, which results in awesome lockdep messages when I have to
use a irq safe lock inside the private data callbacks.  Fix this to
always use the irq safe variants.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-cgroup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index fd614c31ccd2..ab88d96d2e43 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -226,7 +226,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 	}
 
 	/* insert */
-	spin_lock(&blkcg->lock);
+	spin_lock_irq(&blkcg->lock);
 	ret = radix_tree_insert(&blkcg->blkg_tree, q->id, blkg);
 	if (likely(!ret)) {
 		hlist_add_head_rcu(&blkg->blkcg_node, &blkcg->blkg_list);
@@ -240,7 +240,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 		}
 	}
 	blkg->online = true;
-	spin_unlock(&blkcg->lock);
+	spin_unlock_irq(&blkcg->lock);
 
 	if (!ret)
 		return blkg;
@@ -381,10 +381,10 @@ static void blkg_destroy_all(struct request_queue *q)
 	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 
-		spin_lock(&blkcg->lock);
+		spin_lock_irq(&blkcg->lock);
 		blkg_pd_offline(blkg);
 		blkg_destroy(blkg);
-		spin_unlock(&blkcg->lock);
+		spin_unlock_irq(&blkcg->lock);
 	}
 
 	q->root_blkg = NULL;
-- 
2.14.3

