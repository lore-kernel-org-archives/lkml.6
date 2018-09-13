Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38860C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E583820839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riZZQpOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E583820839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeIMQbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:31:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44250 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbeIMQbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:31:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so5192041wro.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 04:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=91QhPC3Xjc3TQAm8K0a68uNGIKKtw9ovWxFTrPH712w=;
        b=riZZQpOLYYgXvrzanT+oP6q20l7xDTE9KI/t3vpOi8wHs7eQDCxEU0ugz4L2FOGQoD
         8z0TGQx7cZVCa6M4QEv9QmG79N97tgQDx/B2vqBG7OlLyYWEWC0pyd4lN+dGJx2ritNG
         snvxyeTGrljkVOBZKnXLKVWiAOJrBi8qaRboiRhTP/zDrYW4jesRujxPkflceLuwSj0D
         eitOaCe6sj1KDWLrgUEZsULmKnYwsKp/5K+e6HbACyZ1GiywKVMt1SuaiWBJNsVPfPcm
         V2O/uUDF0tF9SgMq18YpbVciJbrv9MsPzse5Op+MO6jP4dVcEn5cQEHbRH8LR8zzWo9E
         y7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=91QhPC3Xjc3TQAm8K0a68uNGIKKtw9ovWxFTrPH712w=;
        b=VsQxqBRfczXkR+iKkBNdpSlv3u3w+zmvOgqzWn+be0SiNfBnylp2PIJLfiDxtsUddS
         VXDFquYhq94dHEJac1DQefR2e3U7SVTp9cgo4es1DvaJezJaaUkGCiN8DMc5GVremrAI
         T8Y+JrFl7XJUeYYniJzHbhtlKusUdxK3M9EDOG8nA/Vr6abNvtmC+Z9Zen18Beeq2Cpp
         fUu1Mk9kogkUmFbwN/6zdNUPYzGEoq5wiEok0lAbC3/TmipEaE2qq5b0cLelJKQHJouj
         BIY8z0R8TbP6C44//BlBfDRJpXLxGqZ42woUmfKLle4OPezPRD14NTgmbbXqnyUBwRuL
         bRug==
X-Gm-Message-State: APzg51Cjyzhyshpcqq6rGtNEQmXlRjxZdxv8t8nJ7rVunLOmapQna0vx
        pWzqSwoP8neqcpcXIivQJUSl2buC
X-Google-Smtp-Source: ANB0VdYqCUnjXP6MKQP2zhG/3nONfeEuuGNRPhw2jYx8ZKQLxeQbfcF/O3upeF9QxqwbR3FYa+NsBQ==
X-Received: by 2002:adf:b2b5:: with SMTP id g50-v6mr4758562wrd.218.1536837730615;
        Thu, 13 Sep 2018 04:22:10 -0700 (PDT)
Received: from baker.fritz.box ([2a02:908:1257:4460:c8f7:2479:525e:9500])
        by smtp.gmail.com with ESMTPSA id u65-v6sm5528748wmd.31.2018.09.13.04.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 04:22:09 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/ttm: once more fix ttm_bo_bulk_move_lru_tail v2
Date:   Thu, 13 Sep 2018 13:22:08 +0200
Message-Id: <20180913112208.1353-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180913112208.1353-1-christian.koenig@amd.com>
References: <20180913112208.1353-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While cutting the lists we sometimes accidentally added a list_head from
the stack to the LRUs, effectively corrupting the list.

Remove the list cutting and use explicit list manipulation instead.

v2: separate out new list_bulk_move_tail helper

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 46 +++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 138c98902033..26b889f86670 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -247,47 +247,38 @@ void ttm_bo_move_to_lru_tail(struct ttm_buffer_object *bo,
 }
 EXPORT_SYMBOL(ttm_bo_move_to_lru_tail);
 
-static void ttm_bo_bulk_move_helper(struct ttm_lru_bulk_move_pos *pos,
-				    struct list_head *lru, bool is_swap)
-{
-	struct list_head *list;
-	LIST_HEAD(entries);
-	LIST_HEAD(before);
-
-	reservation_object_assert_held(pos->last->resv);
-	list = is_swap ? &pos->last->swap : &pos->last->lru;
-	list_cut_position(&entries, lru, list);
-
-	reservation_object_assert_held(pos->first->resv);
-	list = is_swap ? pos->first->swap.prev : pos->first->lru.prev;
-	list_cut_position(&before, &entries, list);
-
-	list_splice(&before, lru);
-	list_splice_tail(&entries, lru);
-}
-
 void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
 {
 	unsigned i;
 
 	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
+		struct ttm_lru_bulk_move_pos *pos = &bulk->tt[i];
 		struct ttm_mem_type_manager *man;
 
-		if (!bulk->tt[i].first)
+		if (!pos->first)
 			continue;
 
-		man = &bulk->tt[i].first->bdev->man[TTM_PL_TT];
-		ttm_bo_bulk_move_helper(&bulk->tt[i], &man->lru[i], false);
+		reservation_object_assert_held(pos->first->resv);
+		reservation_object_assert_held(pos->last->resv);
+
+		man = &pos->first->bdev->man[TTM_PL_TT];
+		list_bulk_move_tail(&man->lru[i], &pos->first->lru,
+				    &pos->last->lru);
 	}
 
 	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
+		struct ttm_lru_bulk_move_pos *pos = &bulk->vram[i];
 		struct ttm_mem_type_manager *man;
 
-		if (!bulk->vram[i].first)
+		if (!pos->first)
 			continue;
 
-		man = &bulk->vram[i].first->bdev->man[TTM_PL_VRAM];
-		ttm_bo_bulk_move_helper(&bulk->vram[i], &man->lru[i], false);
+		reservation_object_assert_held(pos->first->resv);
+		reservation_object_assert_held(pos->last->resv);
+
+		man = &pos->first->bdev->man[TTM_PL_VRAM];
+		list_bulk_move_tail(&man->lru[i], &pos->first->lru,
+				    &pos->last->lru);
 	}
 
 	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
@@ -297,8 +288,11 @@ void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
 		if (!pos->first)
 			continue;
 
+		reservation_object_assert_held(pos->first->resv);
+		reservation_object_assert_held(pos->last->resv);
+
 		lru = &pos->first->bdev->glob->swap_lru[i];
-		ttm_bo_bulk_move_helper(&bulk->swap[i], lru, true);
+		list_bulk_move_tail(lru, &pos->first->swap, &pos->last->swap);
 	}
 }
 EXPORT_SYMBOL(ttm_bo_bulk_move_lru_tail);
-- 
2.14.1

