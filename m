Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A107C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D302208C1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er8yVqsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D302208C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbeHAVAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:00:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44133 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387714AbeHAVAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:00:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so8334383pff.11;
        Wed, 01 Aug 2018 12:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DTd4/8cDqyBu2yWckg8cZ6M10oFFB1hFkTUQhaOWB88=;
        b=Er8yVqsN7ZZww3P5sG+8tEgjiLrb4bao4p6hs08TaXOWR4TSB84xqmFcQQKaZcpAxK
         WfaTbkW/niyXZS3dVUKn+pME1Xp930gdtDBPHfVUgcflzqBO0n/3ZGeogE6PcmfB2K5g
         qp0ahF1lrzRY+PaZ3xckVYXUy9L9Ucd3UgVA3C0Ly4r4ZVo7+4zsu78I8Pu9irhgECa0
         Epcasn41CATxY3q3A0zpdaM8gdSfKNMF2yDgBwR1Px9rzFtvBShPi3HT6425cXOHg8TL
         /cJGC5hXl3HRLEljIixY/5sWG+QpFkgzj5omvkWo48GUTXt+z6k8ozmn3BWwe/F5fUk3
         UfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DTd4/8cDqyBu2yWckg8cZ6M10oFFB1hFkTUQhaOWB88=;
        b=O4663yPJLICxmy6Z5JYwb1nYWVSq8F9KFJgybZ5DZSVVhTq63JRZklv2bLDlvmUEfo
         2qR+5VCrjdG+wRW6AiXhk4DP1nJP/YJ8w8+crEPysAkuGXKBTY/ZHsVVv2S8N09CttlR
         /kIpQ8BaC25SfFw+UYKaZumJyzSXo7OAej8U+XODbKpAm7jM/nbqI4CpjTvU0lLPisYm
         hkntUHpfo08GBFztzR6Jxq+/P5fR4OkUvTV0HGcf4c/+4fqXddAmLyYrtKck9NQw6oct
         vNAGZ8OMoCgWM8KjCKXtsW2Ii5ububtleDz/AQI40CG2dvRBkdsNpXyZUZ+FEkwh7z5p
         oHBA==
X-Gm-Message-State: AOUpUlHAwFKOuCk2vWu1JUkm7dzC4PMIanuVDCX9xg3PQrJ6tSwbPIMB
        AphXdreTS/kXoDrJ0o4Wq50nrFEl
X-Google-Smtp-Source: AAOMgpdvpAvlH+9EFwzEWHKPM/5qLL+rJcyEX3el1MJcSBhZCiDiWatjQBWeIu/1Br2SYl7rS6qosA==
X-Received: by 2002:a63:161a:: with SMTP id w26-v6mr26353701pgl.257.1533150769542;
        Wed, 01 Aug 2018 12:12:49 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-24-5-209-231.hsd1.ca.comcast.net. [24.5.209.231])
        by smtp.googlemail.com with ESMTPSA id u42-v6sm31171336pgn.1.2018.08.01.12.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 12:12:48 -0700 (PDT)
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
Subject: [PATCH v3 08/14] media: imx-csi: Double crop height for alternate fields at sink
Date:   Wed,  1 Aug 2018 12:12:21 -0700
Message-Id: <1533150747-30677-9-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
References: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the incoming sink field type is alternate, the reset crop height
and crop height bounds must be set to twice the incoming height,
because in alternate field mode, upstream will report only the
lines for a single field, and the CSI captures the whole frame.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/staging/media/imx/imx-media-csi.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 8be1033..3a09a9b 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1135,6 +1135,8 @@ static void csi_try_crop(struct csi_priv *priv,
 			 struct v4l2_mbus_framefmt *infmt,
 			 struct v4l2_fwnode_endpoint *upstream_ep)
 {
+	u32 in_height;
+
 	crop->width = min_t(__u32, infmt->width, crop->width);
 	if (crop->left + crop->width > infmt->width)
 		crop->left = infmt->width - crop->width;
@@ -1142,6 +1144,10 @@ static void csi_try_crop(struct csi_priv *priv,
 	crop->left &= ~0x3;
 	crop->width &= ~0x7;
 
+	in_height = infmt->height;
+	if (infmt->field == V4L2_FIELD_ALTERNATE)
+		in_height *= 2;
+
 	/*
 	 * FIXME: not sure why yet, but on interlaced bt.656,
 	 * changing the vertical cropping causes loss of vertical
@@ -1151,12 +1157,12 @@ static void csi_try_crop(struct csi_priv *priv,
 	if (upstream_ep->bus_type == V4L2_MBUS_BT656 &&
 	    (V4L2_FIELD_HAS_BOTH(infmt->field) ||
 	     infmt->field == V4L2_FIELD_ALTERNATE)) {
-		crop->height = infmt->height;
-		crop->top = (infmt->height == 480) ? 2 : 0;
+		crop->height = in_height;
+		crop->top = (in_height == 480) ? 2 : 0;
 	} else {
-		crop->height = min_t(__u32, infmt->height, crop->height);
-		if (crop->top + crop->height > infmt->height)
-			crop->top = infmt->height - crop->height;
+		crop->height = min_t(__u32, in_height, crop->height);
+		if (crop->top + crop->height > in_height)
+			crop->top = in_height - crop->height;
 	}
 }
 
@@ -1396,6 +1402,8 @@ static void csi_try_fmt(struct csi_priv *priv,
 		crop->top = 0;
 		crop->width = sdformat->format.width;
 		crop->height = sdformat->format.height;
+		if (sdformat->format.field == V4L2_FIELD_ALTERNATE)
+			crop->height *= 2;
 		csi_try_crop(priv, crop, cfg, &sdformat->format, upstream_ep);
 		compose->left = 0;
 		compose->top = 0;
@@ -1523,6 +1531,8 @@ static int csi_get_selection(struct v4l2_subdev *sd,
 		sel->r.top = 0;
 		sel->r.width = infmt->width;
 		sel->r.height = infmt->height;
+		if (infmt->field == V4L2_FIELD_ALTERNATE)
+			sel->r.height *= 2;
 		break;
 	case V4L2_SEL_TGT_CROP:
 		sel->r = *crop;
-- 
2.7.4

