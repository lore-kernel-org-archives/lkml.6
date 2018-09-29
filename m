Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5DDC64E93
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFB820882
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sS9sYJkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFB820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbeI3CYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 22:24:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46852 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbeI3CYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 22:24:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id r64-v6so91908pfb.13;
        Sat, 29 Sep 2018 12:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lIp0rTNiuyAyhElobrrLnBJf244yMlpx3Z9dzruhI6s=;
        b=sS9sYJkYXODwKdWa5PxE+2Ys/XwSNGZh2miwwgU2rBSuPZxJHoBv2hsueH+Ejz8z+z
         ZdpxMMO0YkFKxXp1IBotUsCVhVmHrWrI5mFOipyMgpimbXFky6ciSbJ0wISxE0BCXUSq
         9HqFbULAFnHc46gporBCr6OBXD30ZjRgFWXJlvsX+/AiEb3QpOlzSoNjxAaKHMKTTlre
         cWqIsSCdhRNsEo+gTEwRyW1cOwwHTNliI1wlVPhpvp9QUagSa5CRgyt+pRg0q+lwT+5U
         9oqXaUBzfIvVcryJv7SjtuhBPnZLoceHHq6DFNeHqIZUij2SmYkM65dBG/+BgBtAhHix
         TuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lIp0rTNiuyAyhElobrrLnBJf244yMlpx3Z9dzruhI6s=;
        b=Sb3KBJ8u6+qvgXW1vNG9ZUxKZg3OE6ugX69MFigW4Vm+Ui98KYtYXlc+g9F0wm8yV+
         2wiqEtC/nBxKFy2Jiys998ma3yPpelIgWYMN9AaFBPV3DipWKXDIVlZWCjnEmC2x79DN
         gpSNEjKRuJ16LoVP7DanD7oJMt+PXKMWksYf2/cu91IRFlT2LV+bFzkKn1xoZS/FspAg
         Uq8OUEjIYhG1iZYlATuQgMmslfMFN9DNxvazjOZm6saoB7Orr+z3++RYYB3ooHAKnMTv
         ca4eYKwQ9I/o9MUA9uWU75eZF/AwDCW3p5l6JCax8sYvIVDjOVwDcqM+su1lEEx5hXlf
         sBJg==
X-Gm-Message-State: ABuFfojChWghh67o3+pyqHFQ6UxyTNMfsjA3jZ4AyS9S8bIToCjd1z6J
        6YYBLsRViuFvh0PHuXGOnLAVeUae
X-Google-Smtp-Source: ACcGV63tj5sKbYPKXls5uBNcMv6PUYkWoikf7NrVsLfHtCamdKtpjn0uVR+5aEaa3GdFdhWqiA4ENA==
X-Received: by 2002:a63:2c8e:: with SMTP id s136-v6mr4125337pgs.390.1538250901849;
        Sat, 29 Sep 2018 12:55:01 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.gmail.com with ESMTPSA id b126-v6sm18371946pga.49.2018.09.29.12.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:55:00 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v7 11/17] media: staging/imx: Loop through all registered subdevs for media links
Date:   Sat, 29 Sep 2018 12:54:14 -0700
Message-Id: <20180929195420.28579-12-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929195420.28579-1-slongerbeam@gmail.com>
References: <20180929195420.28579-1-slongerbeam@gmail.com>
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

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/staging/media/imx/imx-media-dev.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-dev.c b/drivers/staging/media/imx/imx-media-dev.c
index 1931d1b038dc..718954f969bd 100644
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
2.17.1

