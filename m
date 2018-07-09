Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013FCC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F9B2086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdulJvbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F9B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933433AbeGIWjz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:39:55 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41979 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933399AbeGIWjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:39:51 -0400
Received: by mail-pf0-f196.google.com with SMTP id c21-v6so10030913pfn.8;
        Mon, 09 Jul 2018 15:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LfaJZ9Sv9T9GTV00UIL+Hju8t9N61PlZcJ3RIYqAEUc=;
        b=rdulJvblo7AlN/cPh444PSdlKSJhU2a2RPAepuS5XqMvT8sxK+lMmePY1dfRu2/hM+
         7xLLf+8nobWLRHv+Wwu5hMtS9R3QcPTWow6qbgrz1uAHFRZmG17kutApLsqmLAH3CdVJ
         p1UCA+CgWQn4Ev8qJI0gN1Dvr37wu6V7laVtYqlDG8yVEChrvZ4crjh5X6arLXgLtJWl
         hf6JWQfm3G9LDZq9OxC0bTx9NrLGwgqxocBM/5PwHKv11bZH8Tr/24j94Ff4VbAQenF4
         EMyqMA71JdLYFGE5CBdjhNNHAu/tptjfEiCWw9BeTSeImqx+Z8IAefBPFIaeIPywaEk6
         DfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LfaJZ9Sv9T9GTV00UIL+Hju8t9N61PlZcJ3RIYqAEUc=;
        b=dQgDtSRc6KB0MPXQ5cEOdvXsOQ5ZbiNOoBywrzt/aoBHXzlsNGIl2/m1BO9CCaGhIp
         GByw2LfTqjGv0vg2WS78yy2Rjn13X0dKeKdXR/fo1S258NTE5y2N4E0dt2YuuAKi5cZh
         1QkJXj9yB8+PJJSbS05gXSgPBiOsdmkdFfXjeG9hEAhjNWr2JXjOOgpmt55vSkMbUrER
         qS7w7KlC2hb6UFoQJVPrCQEOnlD1fLRi0mz0aVSS4Dro7lEy9VYgMywgmKyI9d3njdP4
         /YkKR9KDEzrI0u2gzSaG8MC+ryBj9ddgzvPfQXQ5redQq0tE3mtHdeGrU32LlZZd229F
         zm9A==
X-Gm-Message-State: APt69E17vR4JG9mH+peEKeomO4uUXlpR4zov4eDqXLp7IwwdWjWVq/T6
        lJBNckXJOVapkSYP4l/7h9a2AA==
X-Google-Smtp-Source: AAOMgpe27ynSr0dZsVD1tXNGxugZPzLNEp1Ow+2S6jMH+W9beZBgr4Tg2KxV+eQHaPi6ExYW4c+iJQ==
X-Received: by 2002:a63:4d47:: with SMTP id n7-v6mr20407977pgl.270.1531175990838;
        Mon, 09 Jul 2018 15:39:50 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id r16-v6sm30143804pfe.173.2018.07.09.15.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 15:39:50 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 07/17] media: platform: video-mux: Register a subdev notifier
Date:   Mon,  9 Jul 2018 15:39:07 -0700
Message-Id: <1531175957-1973-8-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse neighbor remote devices on the video muxes input ports, add them to a
subdev notifier, and register the subdev notifier for the video mux, by
calling v4l2_async_register_fwnode_subdev().

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
Changes since v5:
- add missing select V4L2_FWNODE to Kconfig for VIDEO_MUX
Changes since v4:
- none
Changes since v3:
- pass num_pads - 1 (num_input_pads) to video_mux_async_register().
Changes since v2:
- none
Changes since v1:
- add #include <linux/slab.h> for kcalloc() declaration.
---
 drivers/media/platform/Kconfig     |  1 +
 drivers/media/platform/video-mux.c | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 210b44a..6c3b2b7 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -58,6 +58,7 @@ config VIDEO_MUX
 	select MULTIPLEXER
 	depends on VIDEO_V4L2 && OF && VIDEO_V4L2_SUBDEV_API && MEDIA_CONTROLLER
 	select REGMAP
+	select V4L2_FWNODE
 	help
 	  This driver provides support for N:1 video bus multiplexers.
 
diff --git a/drivers/media/platform/video-mux.c b/drivers/media/platform/video-mux.c
index 1fb8872..e54a719 100644
--- a/drivers/media/platform/video-mux.c
+++ b/drivers/media/platform/video-mux.c
@@ -21,8 +21,10 @@
 #include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <media/v4l2-async.h>
 #include <media/v4l2-device.h>
+#include <media/v4l2-fwnode.h>
 #include <media/v4l2-subdev.h>
 
 struct video_mux {
@@ -207,6 +209,38 @@ static const struct v4l2_subdev_ops video_mux_subdev_ops = {
 	.video = &video_mux_subdev_video_ops,
 };
 
+static int video_mux_parse_endpoint(struct device *dev,
+				    struct v4l2_fwnode_endpoint *vep,
+				    struct v4l2_async_subdev *asd)
+{
+	/*
+	 * it's not an error if remote is missing on a video-mux
+	 * input port, return -ENOTCONN to skip this endpoint with
+	 * no error.
+	 */
+	return fwnode_device_is_available(asd->match.fwnode) ? 0 : -ENOTCONN;
+}
+
+static int video_mux_async_register(struct video_mux *vmux,
+				    unsigned int num_input_pads)
+{
+	unsigned int i, *ports;
+	int ret;
+
+	ports = kcalloc(num_input_pads, sizeof(*ports), GFP_KERNEL);
+	if (!ports)
+		return -ENOMEM;
+	for (i = 0; i < num_input_pads; i++)
+		ports[i] = i;
+
+	ret = v4l2_async_register_fwnode_subdev(
+		&vmux->subdev, sizeof(struct v4l2_async_subdev),
+		ports, num_input_pads, video_mux_parse_endpoint);
+
+	kfree(ports);
+	return ret;
+}
+
 static int video_mux_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -272,7 +306,7 @@ static int video_mux_probe(struct platform_device *pdev)
 
 	vmux->subdev.entity.ops = &video_mux_ops;
 
-	return v4l2_async_register_subdev(&vmux->subdev);
+	return video_mux_async_register(vmux, num_pads - 1);
 }
 
 static int video_mux_remove(struct platform_device *pdev)
-- 
2.7.4

