Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05555C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD018208E1
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdBZr2pI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD018208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933467AbeGIWkB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:40:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35423 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933438AbeGIWj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:39:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6-v6so1550302pgv.2;
        Mon, 09 Jul 2018 15:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DgmGdYmryCeQfiqt5Qy1bS1F3s2iiSYKxPQ+fmoNc/I=;
        b=DdBZr2pIhQluQ3uCBUPXIuadeeUXedJk0hwMB+l6cZED9S+ueOP9YFxNqShVaXLuzl
         aYb8DznPP++rjosYBNPpyhc92t494FH2P32rAwPoYpVvtW0Ab8jDBNAh4HFfQmhzoYTG
         caaT1WxUfw027GxeUqRmPQvRNImWfH5c8mGke9uIRTw7Rmkrs66aTdAGR6g+j4xL71CM
         WWUCi9s4a957fW/ujlA7Bhh40TxMIxz1vonoJMTbGbXco3GadkqbZ6fkF+bS9rFA+JVY
         UsULvGaDJf48z2C/xHjg7ZQirpaeGOQd47tMXZwqKGMyTn40uMHVonAybcT1F+wKVWbq
         X0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DgmGdYmryCeQfiqt5Qy1bS1F3s2iiSYKxPQ+fmoNc/I=;
        b=JY+wehfOMFzhskVsVQ+uIK2LqXEYqdBuwu2+yvChu4J+sTUxAbukLQqhw6ia3z6dkw
         Q2xdlvpomfTBqr0bogsMj6n2jqFSSrNchnUJxzPIR7/ijuajWCgY5gSqE6SMiOgJa0q3
         /0rvIRLjZue90l04I/bHIHmheC0Es15HZQsO8q9yHNFn69WLrcVDSJ1OKqBEp6C/bjj1
         UG4jsDMqfYPiL/zDiQOokqwA4D+CTZKKX4EATAoNijv6eFrizkgpRui5RVRobshBC9iB
         UmatYkNMMKgv29zMNjKYBufPr70X+DPA0TpknNzjKB/Q+kwtB9XkKYalLerP3BLXdvCr
         Lb7Q==
X-Gm-Message-State: APt69E0lW9ZranlTT31eeoho2d1YlZEPQGyvRKtmS2DylHZl4he6QoDx
        5YDqSwaHBxM3xwNa4MMqAcL1Zg==
X-Google-Smtp-Source: AAOMgpfhwvsOo0WARN7gfZKTEOldeWmQF0gCuGte1iuVXOECUdr2rx9LJawa1gUm9vA0KvuwtVgbNQ==
X-Received: by 2002:a65:6689:: with SMTP id b9-v6mr20241561pgw.326.1531175996831;
        Mon, 09 Jul 2018 15:39:56 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id r16-v6sm30143804pfe.173.2018.07.09.15.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 15:39:56 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 11/17] media: staging/imx: Loop through all registered subdevs for media links
Date:   Mon,  9 Jul 2018 15:39:11 -0700
Message-Id: <1531175957-1973-12-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
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

