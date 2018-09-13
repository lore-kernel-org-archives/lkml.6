Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644C1C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0877421476
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZxvatSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0877421476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeIMUpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:45:36 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34023 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbeIMUpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:45:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id u1-v6so5008103eds.1;
        Thu, 13 Sep 2018 08:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lUGuwyJBK+eOBIJ+Csd74OxRQFY8pSLNTRdiFxzxFDg=;
        b=VZxvatSDU4XFyONhokO3sHKwyYRKC6IyhfGK2+V39I2snSsFzr7bfTc9d5oxyxaq+Q
         G7/SJjA8y9CsHnmeqO2YdP53gE6fdvZu0G3lbiM+5fPvaxNYnbIOxogkAfVUWgwyBLQD
         czQQv2T2wcw84OMSVCDbqZCIWnWooaX0KvZhpvjYjtEv0KABVrCX0RzL3P6GKTtrQJfQ
         3dcouLBZTBrDmRg7YfIgDHUhYNrqaMr4UMp7bHgKhFr5IynPhr0C7CDezGoNcQKaulu9
         rrfApDcUMhJ65NXC+hC976JEgPCt8JpDAsRbuRNkU9zkka+Ai1DxOs8W9O9sRUXTS7Qm
         sFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lUGuwyJBK+eOBIJ+Csd74OxRQFY8pSLNTRdiFxzxFDg=;
        b=t5JHv1FNmEZzt73LZr8AJ9OmBnOiMPHvNrFV7hUqj5BJC/YtKAIWl0gMwTnz6LesXd
         jEh8RFto5KWrI1NxLqyppYCko4tw8FhUZhvEVOv3Ko3cJieDTess5zHGog11l2NKKgS/
         LcikR1+yUVZfSws9q9u3DHivrqREr8rRFOryWK19KCZBIk7hl5knqYYlCbWJnBcruuTa
         qFFWWVopYdFZSq1JZdjQZ+8KyjoWbx8skSyR2cWbNDev7J7EDgu4Q0dO5ZSL9YaXjFqx
         o5PWPy7RbnzC0PG9n5PCUA3UT1t+PoAhDdOc9jd70Ur3wNeGbxpFP/FRtznHuPcAoRr1
         NniQ==
X-Gm-Message-State: APzg51DiMQ/of0mQ9c9X4VWq2yeThIcOmDpRwKIoOoD8SlynEgNp0T/p
        hrhfvd/uu59XUJKuPJxscVk=
X-Google-Smtp-Source: ANB0VdYJ+PPixEilNZxl83rOyU7wlgmEE48/zHBHIiX22rl8yGvjyYZyRne2grncziO8Z8Z3EwURQA==
X-Received: by 2002:a50:ad0f:: with SMTP id y15-v6mr11909028edc.78.1536852933039;
        Thu, 13 Sep 2018 08:35:33 -0700 (PDT)
Received: from jinpu-GA-870A-USB3.pb.local ([2001:1438:4010:254c:1e6f:65ff:fed4:d10])
        by smtp.googlemail.com with ESMTPSA id d3-v6sm2171210edi.80.2018.09.13.08.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Sep 2018 08:35:32 -0700 (PDT)
From:   Jack Wang <xjtuwjp@gmail.com>
X-Google-Original-From: Jack Wang <jinpuwang@gmail.com>
To:     shli@kernel.org, neilb@suse.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH] md: bitmap: use mddev_suspend/resume instead of ->quiesce()
Date:   Thu, 13 Sep 2018 17:35:30 +0200
Message-Id: <1536852930-18926-1-git-send-email-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jack Wang <jinpu.wang@profitbricks.com>

After 9e1cc0a54556 ("md: use mddev_suspend/resume instead of ->quiesce()")
We still have similar left in bitmap functions.

Replace quiesce() with mddev_suspend/resume.

Also move md_bitmap_create out of mddev_suspend. and move mddev_resume
after md_bitmap_destroy. as we did in set_bitmap_file.

Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
---
 drivers/md/md-bitmap.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 2fc8c113977f..c369f1753ea6 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2123,7 +2123,7 @@ int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
 	}
 
 	if (!init)
-		bitmap->mddev->pers->quiesce(bitmap->mddev, 1);
+		mddev_suspend(bitmap->mddev);
 
 	store.file = bitmap->storage.file;
 	bitmap->storage.file = NULL;
@@ -2239,7 +2239,7 @@ int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
 
 	if (!init) {
 		md_bitmap_unplug(bitmap);
-		bitmap->mddev->pers->quiesce(bitmap->mddev, 0);
+		mddev_resume(bitmap->mddev);
 	}
 	ret = 0;
 err:
@@ -2288,9 +2288,9 @@ location_store(struct mddev *mddev, const char *buf, size_t len)
 			goto out;
 		}
 		if (mddev->pers) {
-			mddev->pers->quiesce(mddev, 1);
+			mddev_suspend(mddev);
 			md_bitmap_destroy(mddev);
-			mddev->pers->quiesce(mddev, 0);
+			mddev_resume(mddev);
 		}
 		mddev->bitmap_info.offset = 0;
 		if (mddev->bitmap_info.file) {
@@ -2327,8 +2327,8 @@ location_store(struct mddev *mddev, const char *buf, size_t len)
 			mddev->bitmap_info.offset = offset;
 			if (mddev->pers) {
 				struct bitmap *bitmap;
-				mddev->pers->quiesce(mddev, 1);
 				bitmap = md_bitmap_create(mddev, -1);
+				mddev_suspend(mddev);
 				if (IS_ERR(bitmap))
 					rv = PTR_ERR(bitmap);
 				else {
@@ -2337,11 +2337,12 @@ location_store(struct mddev *mddev, const char *buf, size_t len)
 					if (rv)
 						mddev->bitmap_info.offset = 0;
 				}
-				mddev->pers->quiesce(mddev, 0);
 				if (rv) {
 					md_bitmap_destroy(mddev);
+					mddev_resume(mddev);
 					goto out;
 				}
+				mddev_resume(mddev);
 			}
 		}
 	}
-- 
2.7.4

