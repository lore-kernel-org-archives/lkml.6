Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE6DC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2302120882
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uB4vd9cR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2302120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeI3CYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 22:24:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38806 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbeI3CYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 22:24:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so6506859pfh.5;
        Sat, 29 Sep 2018 12:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wqjks55hakEdD6oDpu+hfrsRJCQpZA/ZAhyZEEJ5Jq8=;
        b=uB4vd9cR+oOYA7/NyPtw4FaE6SMWIZIf6xg7Boy0J+jwBrLrMWGf3wK80xItaHpojB
         krAQqR/Dr5nRrDmU5ihdzzwlnitE2eI28wCeAgtoCWKeqkS+ZGVil96st4mgjYqxUeGT
         a2An7GCg0N4WMow4JqHE/Td2G7hkwZ3ABkMi28a9T5w8VULAfH1WvSqynr1jF8uvwh8Z
         oaJY+UZ+koKBKYT32ksFN0GbRfHGTkD/veQ+6nFe+phbqTJPkVx/jZYkcya1cezIgjF9
         ZlFamSi0DfT2NdYi5b7SJQmo41ESI8IrBGYaiWdGL4ZLWf9yKCte3MSwmQaj2Aov6g+y
         JmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wqjks55hakEdD6oDpu+hfrsRJCQpZA/ZAhyZEEJ5Jq8=;
        b=qoL2fGulVVd7Lg6Lor6JoKXxIv0X4vPLhS9AlFK4KYJcTvPB9T6Cdk5aer+eHs7E8D
         65Jueiz4QuFg9lpKZikKumo9b1NR3BC5jXnWVvCsbMs9Lc0eKxaEVQx6zZn8w+LmLJZx
         ful6nG7A2MDMODt1ChPVoeeOg8FWh2WHSR24Tcc1BFYFVEkuGwLp0zoRfYTAncbRcFdG
         dKtnLq3VO9jjurXbwr95PID/zfJRo7IdgSKvdIis0sI8QUUwwg2zR5BtL3v8H6mGU5he
         4H9KS/40k9Q1q2BhCK59QJlr1NAuUElGuPENtR/sExyNUyw6d3y9qG1ea9LXqtn8J8ug
         nufQ==
X-Gm-Message-State: ABuFfoiDdp/obvUeIUPnNfStJ1guck13i2Cqd3JRYXjRQDRJM9jvHlyh
        h35e3MAMioCQ3bYQ4MukhcKFghnJ
X-Google-Smtp-Source: ACcGV60y3VfG1MLTkoSPehuiN7B/aZasrcVuHy5XcD7/VO4Mwoq+jLwhZy/BihLofDoPkQ+SwhQXxw==
X-Received: by 2002:a17:902:6a2:: with SMTP id 31-v6mr4371083plh.1.1538250903572;
        Sat, 29 Sep 2018 12:55:03 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.gmail.com with ESMTPSA id b126-v6sm18371946pga.49.2018.09.29.12.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:55:02 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v7 12/17] media: staging/imx: Rename root notifier
Date:   Sat, 29 Sep 2018 12:54:15 -0700
Message-Id: <20180929195420.28579-13-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929195420.28579-1-slongerbeam@gmail.com>
References: <20180929195420.28579-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the imx-media root async notifier from "subdev_notifier" to
simply "notifier", so as not to confuse it with true subdev notifiers.
No functional changes.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/staging/media/imx/imx-media-dev.c | 14 +++++++-------
 drivers/staging/media/imx/imx-media.h     |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-dev.c b/drivers/staging/media/imx/imx-media-dev.c
index 718954f969bd..a9faee4b2495 100644
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
index 57bd094cf765..227b79ccc194 100644
--- a/drivers/staging/media/imx/imx-media.h
+++ b/drivers/staging/media/imx/imx-media.h
@@ -150,7 +150,7 @@ struct imx_media_dev {
 
 	/* for async subdev registration */
 	struct list_head asd_list;
-	struct v4l2_async_notifier subdev_notifier;
+	struct v4l2_async_notifier notifier;
 };
 
 enum codespace_sel {
-- 
2.17.1

