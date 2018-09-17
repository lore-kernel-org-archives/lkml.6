Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE4AECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0296E214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dem8uHLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0296E214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbeIQRfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:35:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38851 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbeIQRfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:35:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id t25-v6so9266058wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 05:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=01xnjUBjpsg6KuuGXx13wnd3HzOPmCqvqdiDn4zfD8Y=;
        b=Dem8uHLo/PJWAxqKDdpm6EfnTRbyUtqqkQK1ZK2pezUqYmB5UdDO92iTvhEpcspCNR
         jzec9RaaX7sIDzBZSsfD7+ArrRS+kA2IqDHzCCD5RS1O8a6Nlc+ssFcPn9DFtCd7vOh2
         peOl3VHNrfwkvMy6CxH12zHKoztgNLMNKZgVSGUs7x7my9+49/0DIgPCnrPynsRO8z1m
         W/jh8hY29xVgku2H+ZAg4ZrVC5YE43fh/qCRsXXM+QAEzCBzD5epjbK3EFS3ud3ShQTa
         5lOjYsgsZtuxy3GWB0Zrye9wR3Dt2q/KkxZsw74H0QjHN+She1xPwHXRyN1YTRRbXnff
         zazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=01xnjUBjpsg6KuuGXx13wnd3HzOPmCqvqdiDn4zfD8Y=;
        b=EycTaAcGB9MJu2IZx9hGv7HLRI9l7td5ifDdBqSY8hk1f2l3peP7F1bNkxhAO0x49Y
         a+3QbZqmKHDu2Cx+BQvVFEow2vYl7SoZ0U3uQGuJoWbXg4vBKMpwQcZ7jdoID18IKTxm
         AKbtR1D+xhEvHNH+K5j3gq8aYWjKM+GjvVf3mc8FvyA2SGJWe6mV+bI/+ajdF/UnAXzp
         YbMdoyJpcZQ8DY/9Eds1uJdxGYGzt/alAv/lQ+lSpnJAP118VW9E8TfFkAArWgk1zrZT
         AFX8kTYmSN/ScoHaoO+J7Vd8pQEReJHTCi/LrNtxqurEUoJAst7mRsigrbjweLZNP53Z
         eS/A==
X-Gm-Message-State: APzg51D4wTI7J00aRKxhbRUdSF/T6GRjue4qcbfbP+w6TDvfwcfF9xZ1
        6MTrBBjyqj21qWma9nUgL2olecvm
X-Google-Smtp-Source: ANB0Vda7IFHwc4RKpScluDevpMyq723D+USOguGUmd1ynZ1W5nWthAna2XqCNn0NUh1izKrMfBfLqA==
X-Received: by 2002:a1c:3503:: with SMTP id c3-v6mr11122272wma.46.1537186116009;
        Mon, 17 Sep 2018 05:08:36 -0700 (PDT)
Received: from baker.fritz.box ([2a02:908:1257:4460:21bc:9ef5:2350:67f5])
        by smtp.gmail.com with ESMTPSA id v6-v6sm11608213wro.66.2018.09.17.05.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 05:08:35 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH] list: introduce list_bulk_move_tail helper
Date:   Mon, 17 Sep 2018 14:08:34 +0200
Message-Id: <20180917120834.13993-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move all entries between @first and including @last before @head.

This is useful for LRU lists where a whole block of entries should be
moved to the end of the list.

Used as a band aid in TTM, but better placed in the common list headers.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 25 +++++--------------------
 include/linux/list.h         | 23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index b2a33bf1ef10..26b889f86670 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -247,20 +247,6 @@ void ttm_bo_move_to_lru_tail(struct ttm_buffer_object *bo,
 }
 EXPORT_SYMBOL(ttm_bo_move_to_lru_tail);
 
-static void ttm_list_move_bulk_tail(struct list_head *list,
-				    struct list_head *first,
-				    struct list_head *last)
-{
-	first->prev->next = last->next;
-	last->next->prev = first->prev;
-
-	list->prev->next = first;
-	first->prev = list->prev;
-
-	last->next = list;
-	list->prev = last;
-}
-
 void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
 {
 	unsigned i;
@@ -276,8 +262,8 @@ void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
 		reservation_object_assert_held(pos->last->resv);
 
 		man = &pos->first->bdev->man[TTM_PL_TT];
-		ttm_list_move_bulk_tail(&man->lru[i], &pos->first->lru,
-					&pos->last->lru);
+		list_bulk_move_tail(&man->lru[i], &pos->first->lru,
+				    &pos->last->lru);
 	}
 
 	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
@@ -291,8 +277,8 @@ void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
 		reservation_object_assert_held(pos->last->resv);
 
 		man = &pos->first->bdev->man[TTM_PL_VRAM];
-		ttm_list_move_bulk_tail(&man->lru[i], &pos->first->lru,
-					&pos->last->lru);
+		list_bulk_move_tail(&man->lru[i], &pos->first->lru,
+				    &pos->last->lru);
 	}
 
 	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
@@ -306,8 +292,7 @@ void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
 		reservation_object_assert_held(pos->last->resv);
 
 		lru = &pos->first->bdev->glob->swap_lru[i];
-		ttm_list_move_bulk_tail(lru, &pos->first->swap,
-					&pos->last->swap);
+		list_bulk_move_tail(lru, &pos->first->swap, &pos->last->swap);
 	}
 }
 EXPORT_SYMBOL(ttm_bo_bulk_move_lru_tail);
diff --git a/include/linux/list.h b/include/linux/list.h
index de04cc5ed536..edb7628e46ed 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -183,6 +183,29 @@ static inline void list_move_tail(struct list_head *list,
 	list_add_tail(list, head);
 }
 
+/**
+ * list_bulk_move_tail - move a subsection of a list to its tail
+ * @head: the head that will follow our entry
+ * @first: first entry to move
+ * @last: last entry to move, can be the same as first
+ *
+ * Move all entries between @first and including @last before @head.
+ * All three entries must belong to the same linked list.
+ */
+static inline void list_bulk_move_tail(struct list_head *head,
+				       struct list_head *first,
+				       struct list_head *last)
+{
+	first->prev->next = last->next;
+	last->next->prev = first->prev;
+
+	head->prev->next = first;
+	first->prev = head->prev;
+
+	last->next = head;
+	head->prev = last;
+}
+
 /**
  * list_is_last - tests whether @list is the last entry in list @head
  * @list: the entry to test
-- 
2.14.1

