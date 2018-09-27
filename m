Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512C4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAF921570
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYABdoke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CAF921570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeI0OZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:25:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36510 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbeI0OZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:25:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id f4-v6so4223483edq.3;
        Thu, 27 Sep 2018 01:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=I3IjiiTtgj3cp3ij0TNgBVCKK7QImTXbAYlmJHpzt0A=;
        b=UYABdokezUuF0hllbqv1TxyopXGL79NTO65oX4cgY4TbLlpgiJjaQvkqjvW+cTiMa+
         tl7qsTP0AB3P251MWzt9htDkQmGh1GcM0bHQVimlOvvsEh/R3QL69eLaBwYEcAHTQ8iu
         OdT2UUPk1qzu2V6YcMB2vSCJMb1KvCEprqWRSIvt3Qivh83RN2+q1/ZTKlFl6cjXCbBM
         AoXMB3KnqjAok6LHtWQzNzR/miBoZ3/RsJ98tSuBdaaObxbsN9BseKp7a5V113IOCk5f
         7SZ2ldOyRfjo71s4KrHEUIakF8D/UCDJNr3d+nSiqmPFddPrskzzm5MvFIXKqTE5TGlq
         FxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I3IjiiTtgj3cp3ij0TNgBVCKK7QImTXbAYlmJHpzt0A=;
        b=aYisEP8ttqbf9Of9XfkNB1re2F0yugBdblSr2qQPyBS0wKtx2zl8cLDasRbI4mPkDD
         VHxtphJjejaMAotpsGqIcIsrrw7/nCO25UvgJQJ1akmficvFDoE9gUHW+xnBG2RCXq6b
         y9WQFhtoyD81HpYjv28eNgHaX3HuTxwfRVJME2rY8QWY+qGZE2sb4Q4ZeOH3UYuiSUiQ
         uVorHhtaCwvjJWEI9WWzs+0DSmtIWfnGbqL2VEij95LKE0GWrRVD7hrjqbu2gN2NOPFZ
         4uFOT8aUx52QAUjpdCjDCa1WZPHjEWyDZpYYSDzX258MqsC+vGundU049aeSXEdfznae
         EMIQ==
X-Gm-Message-State: ABuFfogUzUlHiPRj0xzRpIv0E80Fqv9gcGu1/a2hgLHXlFOu9MbGnjte
        bI/TwlVHETHsE+X6eSOQ4Xg=
X-Google-Smtp-Source: ACcGV62yDAewyYxlhwA8ZgNn+ljpEOPnx9mM61YAOg3ZGtinXH9JPl3B1nlUnZkdmtqCdQfRnUd5aw==
X-Received: by 2002:a50:ace6:: with SMTP id x93-v6mr11763921edc.176.1538035679826;
        Thu, 27 Sep 2018 01:07:59 -0700 (PDT)
Received: from jinpu-GA-870A-USB3.pb.local ([2001:1438:4010:254c:1e6f:65ff:fed4:d10])
        by smtp.googlemail.com with ESMTPSA id g39-v6sm1127372edg.63.2018.09.27.01.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 01:07:59 -0700 (PDT)
From:   Jack Wang <xjtuwjp@gmail.com>
X-Google-Original-From: Jack Wang <jinpuwang@gmail.com>
To:     shli@kernel.org, neilb@suse.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH] md/bitmap: use mddev_suspend/resume instead of ->quiesce()
Date:   Thu, 27 Sep 2018 10:07:57 +0200
Message-Id: <1538035677-20770-1-git-send-email-jinpuwang@gmail.com>
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
Reviewed-by: Gioh Kim <gi-oh.kim@profitbricks.com>

---
v2->v1: add reviewed-by.
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

