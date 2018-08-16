Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEFFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9B82089E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q9pA60Bv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9B82089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbeHPTvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:51:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36092 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbeHPTvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:51:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id w24-v6so4945740wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gLZ7QU55IsLVhhisN3q0YJquTs5gtaPrOh82kVhuIcI=;
        b=Q9pA60BvtGVg5Qk9BZEC9RPwv6VE30CQG96npMXKKLFK687sa2wy5rmGfhusSXFe1y
         6P4pAvKNB9K5o0+W9hW8qcfmjyx7QitMS0xwesCJ0X1vc960UZV3Rv2aPGzYPumCJQCc
         e9DKMRLroOeAn7gPZuXSrQ666mIhWcaGixrxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gLZ7QU55IsLVhhisN3q0YJquTs5gtaPrOh82kVhuIcI=;
        b=USf56FvQ/fOCTnPANJ9jCK/kaE9QcvvJ3/W5rntLkNIxRVyN/uAz/1hsP8VxIjtEjT
         hYof6V/iWqB6FsU8iE1QyDIz+5RFWKQwUjopg4SAPlrp0HOxy4Zmh3P83MgTT5JBjFdF
         W1eY+vW9AfMLKJzqTe1fiaFSOEUXTVsovabyTH9P50vawGtm8UCDHs3cnIYfRmGa+/dc
         RVFpooDonVS9ZJKpeKtSQQC3+v7ynOQxV9O8q8EwEtmzzPkrSpjoSvQ268qfwf2xbZxl
         pwcNl1CRkIH5DBmBc2liUk8gkZxHG1pS2tyQkLfpoEV4skKXnjXNrclL7mdpbZFBMjGq
         O/BA==
X-Gm-Message-State: AOUpUlGf1KM9t2pibvxXIXDeDv8VNFP10O940ItGd4s1tTuGG6eX+qE9
        m63bN0A1MarpGGZ2knziiuTfmg==
X-Google-Smtp-Source: AA+uWPyQc/QmVFufHKF653DtcznVIl+PWJw7XwfaujV607gnewQr09bbFnhCJOQ9rPBbffEGh0fXsA==
X-Received: by 2002:a1c:bb86:: with SMTP id l128-v6mr16316007wmf.26.1534438317067;
        Thu, 16 Aug 2018 09:51:57 -0700 (PDT)
Received: from localhost.localdomain (146-241-5-103.dyn.eolo.it. [146.241.5.103])
        by smtp.gmail.com with ESMTPSA id o3-v6sm30036180wrj.31.2018.08.16.09.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 09:51:56 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT 1/4] block, bfq: readd missing reset of parent-entity service
Date:   Thu, 16 Aug 2018 18:51:15 +0200
Message-Id: <20180816165118.17402-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180816165118.17402-1-paolo.valente@linaro.org>
References: <20180816165118.17402-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The received-service counter needs to be equal to 0 when an entity is
set in service. Unfortunately, commit "block, bfq: fix service being
wrongly set to zero in case of preemption" mistakenly removed the
resetting of this counter for the parent entities of the bfq_queue
being set in service. This commit fixes this issue by resetting
service for parent entities, directly on the expiration of the
in-service bfq_queue.

Fixes: 9fae8dd59ff3 ("block, bfq: fix service being wrongly set to zero in case of preemption")
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 41d9036b1822..62efc1b97afb 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3298,6 +3298,27 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
 		 */
 	} else
 		entity->service = 0;
+
+	/*
+	 * Reset the received-service counter for every parent entity.
+	 * Differently from what happens with bfqq->entity.service,
+	 * the resetting of this counter never needs to be postponed
+	 * for parent entities. In fact, in case bfqq may have a
+	 * chance to go on being served using the last, partially
+	 * consumed budget, bfqq->entity.service needs to be kept,
+	 * because if bfqq then actually goes on being served using
+	 * the same budget, the last value of bfqq->entity.service is
+	 * needed to properly decrement bfqq->entity.budget by the
+	 * portion already consumed. In contrast, it is not necessary
+	 * to keep entity->service for parent entities too, because
+	 * the bubble up of the new value of bfqq->entity.budget will
+	 * make sure that the budgets of parent entities are correct,
+	 * even in case bfqq and thus parent entities go on receiving
+	 * service with the same budget.
+	 */
+	entity = entity->parent;
+	for_each_entity(entity)
+		entity->service = 0;
 }
 
 /*
-- 
2.16.1

