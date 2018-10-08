Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D64C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100DD205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNAZUdbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100DD205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbeJHWgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:36:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35970 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJHWgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:36:21 -0400
Received: by mail-ed1-f68.google.com with SMTP id c26-v6so10264557edt.3;
        Mon, 08 Oct 2018 08:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lUHSrEGNwH4XkJwjc548JoA84/Eg9lPr+f8xZgSiHJ4=;
        b=LNAZUdbYxRp4h0umVfRM9KKhCABAquYc0tKCcFYWCzy3vWPwDvTrTCHcxs8ECFRTQj
         qxpmcOYEzAnboz9O57l+eB4IQigsr6gRdRP6FQlOp7H8iJOxN01k3uWgTtUsbE4ncArh
         92+RrZV17kJqM8MdVegydL3GaECDemM/UV7E3TQBDH44PZ6rtUcgQ2TwDv85DNYHJejc
         JAhWoW1wc8p+DB1cL6GsxRDGKIXrK3HD071BEm+zkeMJwk/GkWA1O6lyVyfxsntOyi8+
         x8gmDCPiN+wfXUkE0AsBvdJxzMrTDUTqjk5jj/GIk/T0AVYsTfTFFqBMf4rphqteDGzI
         acSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lUHSrEGNwH4XkJwjc548JoA84/Eg9lPr+f8xZgSiHJ4=;
        b=cz2Q8OBNv0RKCU8aJHSh0FWl+3Cqpn8KJMrTXPvVZr23Emn3FwjShOcwgJ/OlxhLch
         cRiw/1hmtmycVkbjurVYRbYEpb7W7JdJpt3UmkYtIRBfhjOJCgSQvUKGcNxQCCGdjF68
         iYG/SYf96kI/vmR4Pvm3I+qLbbMvd7tNwI795X08yXNRiLh2QS2i5RjvuDeTPanaEQNi
         MzPW58bPnr47bP7CK6bZ7HYlSz5pO0MUlO+2oNzI3yUltlH0ImrxkKutyJeH1S+OE8qc
         FIBMOLxWaSSgK8ocz8CDDEbgsqdVN1sLg/cIC+T9EG9J8V9xHuxd4JY8ITT0Kdlj3YL0
         zICw==
X-Gm-Message-State: ABuFfojgBulVmLsC/sBEGHk9xXMCYIVCG4kLRdsfNUU+Jkt8J+qleYmd
        i+LcQ2DfBlEnbBvz19wCPYE=
X-Google-Smtp-Source: ACcGV62rm1XUk+2fAVJc9S94dxC6AT/VY7iwLlfbg/xo12zZg+MW5n1BpBj1XbkK2diLw+aE2UCJ9A==
X-Received: by 2002:a50:998a:: with SMTP id m10-v6mr30334664edb.7.1539012245392;
        Mon, 08 Oct 2018 08:24:05 -0700 (PDT)
Received: from jinpu-GA-870A-USB3.pb.local ([2001:1438:4010:254c:1e6f:65ff:fed4:d10])
        by smtp.googlemail.com with ESMTPSA id l34-v6sm5568274eda.54.2018.10.08.08.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Oct 2018 08:24:04 -0700 (PDT)
From:   Jack Wang <xjtuwjp@gmail.com>
X-Google-Original-From: Jack Wang <jinpuwang@gmail.com>
To:     shli@kernel.org, neilb@suse.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH] md/bitmap: use mddev_suspend/resume instead of ->quiesce()
Date:   Mon,  8 Oct 2018 17:24:03 +0200
Message-Id: <1539012243-7489-1-git-send-email-jinpuwang@gmail.com>
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
v3->v2: Drop the change in md_bitmap_resize, as Shaohua noticed
mddev_suspend/resume is supposed to be called with reconfig_mutex hold, it's not
the case here.
v2->v1: add reviewed-by.
---
 drivers/md/md-bitmap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 2fc8c113977f..1cd4f991792c 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
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

