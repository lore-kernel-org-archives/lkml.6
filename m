Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0BBC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9462324454
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tH0AvFd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9462324454
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936904AbeF2Sz3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:55:29 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37118 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936821AbeF2SxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:53:04 -0400
Received: by mail-pg0-f67.google.com with SMTP id n15-v6so1128025pgv.4;
        Fri, 29 Jun 2018 11:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DgmGdYmryCeQfiqt5Qy1bS1F3s2iiSYKxPQ+fmoNc/I=;
        b=tH0AvFd46YI7DgafJbrb7B8bJXn4YQTXrhO0kFLz2U0C98Nl4wgo3CrqwcWwecni8H
         YcQyiY9la42z2JlMLp+s2ct9oq6o6o6qlAp05fqDBa+JTQOh/YMbWlofwwNo/ZmIDroF
         rKyQoYMXTwblSGR8mlGCA9TYXLx9txa2zsMrRTQ2qAHoMIW9BlP5bPDK3Xo581gPfktn
         2HUMlj1QlZsToUjhWAe5FjPV7x6Y77Qm3ESk1idYSiBrMGzBCplCSOTWv54V8PTd3WKi
         O06iOzHOFeXnHAYsAI+GaCHwqd/p/lM9BeRx2EzcFldwvwOM0N6kiJP0qOugQ/1jNvJ9
         iHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DgmGdYmryCeQfiqt5Qy1bS1F3s2iiSYKxPQ+fmoNc/I=;
        b=p9l4YLluP8o7yfY99Vf8jBAjpQsz0CjByZ7xzzefLIZnl4cX4ikJ+yP5tzF46HXo8z
         pKGYxYav/jyzAAUIxO9GaqVqfDP4oY+vg8xTno4XVQ9g5aGL+K2dRXJJv5qUQx+u4OrY
         8LxUoviL33+uyt2W6cnyWR0xW4fJvs5ssB8BHp58TEhTBHyC+etmTVZTarYXRBKq6Rab
         v5cgjhihJHHBWWeQbfauXeTLOLlAImYLcMcad7TDFNedEvdAf1MXQhBKXcF9zUwe0eT4
         azoEleuyqPYeDCzNUF6hT3swL8la1O13d4Z1T2HOROgERcRG97N4Vm5XZ/4Era3Bm7g/
         vZiw==
X-Gm-Message-State: APt69E1YPJjSrWGumfNRyqm2T+eFD4kxYc2f0OC1fZCvKIYLCiqG+1P4
        MIq1MfY4vD0UDUIt70G5+e4+/w==
X-Google-Smtp-Source: ADUXVKLaMbV61SRYRI+0RARAALZwgPEFDptdar7bhb1GUK/bKkJacK/jJcM2B9sLjk+Aeh1zzA/0mQ==
X-Received: by 2002:a63:541:: with SMTP id 62-v6mr13391928pgf.368.1530298383845;
        Fri, 29 Jun 2018 11:53:03 -0700 (PDT)
Received: from mappy.world.mentorg.com ([2602:306:cc3b:f020:7cd8:9ad7:a375:e853])
        by smtp.googlemail.com with ESMTPSA id k13-v6sm27672308pfg.130.2018.06.29.11.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 11:53:03 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/17] media: staging/imx: Loop through all registered subdevs for media links
Date:   Fri, 29 Jun 2018 11:49:55 -0700
Message-Id: <1530298220-5097-12-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
References: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The root imx-media notifier no longer sees all bound subdevices because
some of them will be bound to subdev notifiers. So imx_media_create_links()
now needs to loop through all subdevices registered with the v4l2-device,
not just the ones in the root notifier's done list. This should be safe
because imx_media_create_of_links() checks if a fwnode link already
exists before creating.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/staging/media/imx/imx-media-dev.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-dev.c b/drivers/staging/media/imx/imx-media-dev.c
index b0be80f..ae87c81 100644
--- a/drivers/staging/media/imx/imx-media-dev.c
+++ b/drivers/staging/media/imx/imx-media-dev.c
@@ -175,7 +175,7 @@ static int imx_media_subdev_bound(struct v4l2_async_notifier *notifier,
 }
 
 /*
- * create the media links for all subdevs that registered async.
+ * Create the media links for all subdevs that registered.
  * Called after all async subdevs have bound.
  */
 static int imx_media_create_links(struct v4l2_async_notifier *notifier)
@@ -184,14 +184,7 @@ static int imx_media_create_links(struct v4l2_async_notifier *notifier)
 	struct v4l2_subdev *sd;
 	int ret;
 
-	/*
-	 * Only links are created between subdevices that are known
-	 * to the async notifier. If there are other non-async subdevices,
-	 * they were created internally by some subdevice (smiapp is one
-	 * example). In those cases it is expected the subdevice is
-	 * responsible for creating those internal links.
-	 */
-	list_for_each_entry(sd, &notifier->done, async_list) {
+	list_for_each_entry(sd, &imxmd->v4l2_dev.subdevs, list) {
 		switch (sd->grp_id) {
 		case IMX_MEDIA_GRP_ID_VDIC:
 		case IMX_MEDIA_GRP_ID_IC_PRP:
@@ -211,7 +204,10 @@ static int imx_media_create_links(struct v4l2_async_notifier *notifier)
 				imx_media_create_csi_of_links(imxmd, sd);
 			break;
 		default:
-			/* this is an external fwnode subdev */
+			/*
+			 * if this subdev has fwnode links, create media
+			 * links for them.
+			 */
 			imx_media_create_of_links(imxmd, sd);
 			break;
 		}
-- 
2.7.4

