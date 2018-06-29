Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBD3C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1436427C49
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejhfNfyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1436427C49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965982AbeF2SxN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:53:13 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37121 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933159AbeF2SxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:53:08 -0400
Received: by mail-pg0-f66.google.com with SMTP id n15-v6so1128093pgv.4;
        Fri, 29 Jun 2018 11:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZpjQvMjInO59qUhw/rpU7CB0iK/MmgvhHGXRrtBPxXk=;
        b=ejhfNfyO3pOjHaigKBNTDH2Ocd7w2l9HjVbHKriJy4ueh8VpzevItxZ0MoDQzfxu1w
         KlhYinpHeOvskOrmJuQCcN7XN5GC9drnBT8cEAV+QXTuhlezZvhLJsby5CiaAFoox0Nh
         rm5WALEwPO+/OySCWbc7g0SHP1oEmMpiElkR+DCuFWAbZzKMrc3li/d4OukYt6zyRSsv
         5ts+I+YPpMnGe2ZWIum30Tpp8MGFvJebjm3tfGBXwswOXzfRtoBTpsHock6iVwaDYgVh
         HJIsMScgtM8tGiE/EHo9euxLsVI6t0thF85Gz57+Wu/WXT0MSziygZWhSRCZupQf/sue
         2ELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZpjQvMjInO59qUhw/rpU7CB0iK/MmgvhHGXRrtBPxXk=;
        b=XkUXWMr7IsJyjeNzuiyUYXJOgzwPTijDSMSsr+uRFNgGJhhSrijdcQN7mjHR4/Yc+H
         8hCTCxzt8a3DEipixZEroUvnKeVXvDpqXD6s1eSkRrgvnvWjeMTG8J6K2sbud80gOjDx
         cj1jasJjFV3p8YcBXqwG3xFYUncCgX3PX1C+w5LM1KOM3/hTewbncPIPg2Lr+HmXXKwU
         5guOP9bJ2uLKfYtSVEuKohamEvlP4CAIrBVcd10RSfGcQBL00b7G07W1hjaFMegLJCgf
         4Vs57CMeCnaAkT41Ui78aflMnNnvj+q18QwUkHwtZPn8qMNwctzcBbwtxUCsW0UbWrvW
         XSww==
X-Gm-Message-State: APt69E0D6JeqCO6pW0GBSGkrhjqcB4EvBNqQSChsZeizRJvRflaaPe8c
        jt7nJEZmoyfpKxtd51oXNHfxfw==
X-Google-Smtp-Source: AAOMgpdFPQWWvv8jFZdaOQefy2UVakJa8+uEFXY76X4xSYkOHBx/TN8yPkD1O4+xJYzGOHKGPuzCVg==
X-Received: by 2002:a62:e813:: with SMTP id c19-v6mr2707475pfi.124.1530298387921;
        Fri, 29 Jun 2018 11:53:07 -0700 (PDT)
Received: from mappy.world.mentorg.com ([2602:306:cc3b:f020:7cd8:9ad7:a375:e853])
        by smtp.googlemail.com with ESMTPSA id k13-v6sm27672308pfg.130.2018.06.29.11.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 11:53:07 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/17] media: staging/imx: Rename root notifier
Date:   Fri, 29 Jun 2018 11:49:56 -0700
Message-Id: <1530298220-5097-13-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
References: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the imx-media root async notifier from "subdev_notifier" to
simply "notifier", so as not to confuse it with true subdev notifiers.
No functional changes.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/staging/media/imx/imx-media-dev.c | 14 +++++++-------
 drivers/staging/media/imx/imx-media.h     |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-dev.c b/drivers/staging/media/imx/imx-media-dev.c
index ae87c81..982e455 100644
--- a/drivers/staging/media/imx/imx-media-dev.c
+++ b/drivers/staging/media/imx/imx-media-dev.c
@@ -29,7 +29,7 @@
 
 static inline struct imx_media_dev *notifier2dev(struct v4l2_async_notifier *n)
 {
-	return container_of(n, struct imx_media_dev, subdev_notifier);
+	return container_of(n, struct imx_media_dev, notifier);
 }
 
 /*
@@ -113,7 +113,7 @@ int imx_media_add_async_subdev(struct imx_media_dev *imxmd,
 
 	list_add_tail(&imxasd->list, &imxmd->asd_list);
 
-	imxmd->subdev_notifier.num_subdevs++;
+	imxmd->notifier.num_subdevs++;
 
 	dev_dbg(imxmd->md.dev, "%s: added %s, match type %s\n",
 		__func__, np ? np->name : devname, np ? "FWNODE" : "DEVNAME");
@@ -532,7 +532,7 @@ static int imx_media_probe(struct platform_device *pdev)
 		goto unreg_dev;
 	}
 
-	num_subdevs = imxmd->subdev_notifier.num_subdevs;
+	num_subdevs = imxmd->notifier.num_subdevs;
 
 	/* no subdevs? just bail */
 	if (num_subdevs == 0) {
@@ -552,10 +552,10 @@ static int imx_media_probe(struct platform_device *pdev)
 		subdevs[i++] = &imxasd->asd;
 
 	/* prepare the async subdev notifier and register it */
-	imxmd->subdev_notifier.subdevs = subdevs;
-	imxmd->subdev_notifier.ops = &imx_media_subdev_ops;
+	imxmd->notifier.subdevs = subdevs;
+	imxmd->notifier.ops = &imx_media_subdev_ops;
 	ret = v4l2_async_notifier_register(&imxmd->v4l2_dev,
-					   &imxmd->subdev_notifier);
+					   &imxmd->notifier);
 	if (ret) {
 		v4l2_err(&imxmd->v4l2_dev,
 			 "v4l2_async_notifier_register failed with %d\n", ret);
@@ -580,7 +580,7 @@ static int imx_media_remove(struct platform_device *pdev)
 
 	v4l2_info(&imxmd->v4l2_dev, "Removing imx-media\n");
 
-	v4l2_async_notifier_unregister(&imxmd->subdev_notifier);
+	v4l2_async_notifier_unregister(&imxmd->notifier);
 	imx_media_remove_internal_subdevs(imxmd);
 	v4l2_device_unregister(&imxmd->v4l2_dev);
 	media_device_unregister(&imxmd->md);
diff --git a/drivers/staging/media/imx/imx-media.h b/drivers/staging/media/imx/imx-media.h
index e945e0e..7edb18a 100644
--- a/drivers/staging/media/imx/imx-media.h
+++ b/drivers/staging/media/imx/imx-media.h
@@ -148,7 +148,7 @@ struct imx_media_dev {
 
 	/* for async subdev registration */
 	struct list_head asd_list;
-	struct v4l2_async_notifier subdev_notifier;
+	struct v4l2_async_notifier notifier;
 };
 
 enum codespace_sel {
-- 
2.7.4

