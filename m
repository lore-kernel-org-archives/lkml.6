Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E75EC5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51173214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oI0jG3xX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51173214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeJQHxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:53:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43291 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbeJQHxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:53:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id 30-v6so11746532plb.10;
        Tue, 16 Oct 2018 17:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eZ4OiF2jjJanfn9zHTYWPJ1ac2b/b0TjaIhiN/6VybM=;
        b=oI0jG3xXKHdFXUwnVLC18OIDZDHPwyatNS6aDDw/+pvabNEULX3AI3VY6NOBdIsk+v
         +Wi1Ac2AIgGvd5XEaj7r+3fTwegyR7/C2KQAvufskfVUmiKSSLpoCXBH31BHk/2jry7m
         73I+ArSlOPvPBmIRDfzOSx23yUCn/He3fZObVnE1l8uHd/I7AXPtOOLlt4UXku56Pt8E
         bPEOItZtHHiKPo9mnvQ/zI6SfH95QxfTaaf5PBYFee9PSGqWs8sry4KYKEqJgiroCG18
         p1MTAZpcAg2gvNyQ6iJZ0DTjrLlfZNN0i1faw39JOnUTLf7xAW6a2c02Z5EvS7OyfZcb
         7FFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eZ4OiF2jjJanfn9zHTYWPJ1ac2b/b0TjaIhiN/6VybM=;
        b=IWU/qRDj6F4dxVwvLsV0RgOIyCRgeCYpVSkTkKMHSMZQpaf0o9v9NPjXwtf6Ri0d6t
         oicyImPSapCYU9agRQirukrkuLSAp94xtg1wSAnQExsllVn3q0OHkwEIIkRuOkqYYt5N
         4n+bhkK7vDlkqp9owboW9wz8zE2GXF/O3ylxbGv+JvSIiDG+7OBV4X400Fh9uDWJTVcB
         xRHQzL2HMtOO2Ci3v8dlcthGY+FCXZIm202stW6jyiKMOdfL/UjfKYI8xzecE9hiaj60
         Zk/hgPGbZ0rzj0wKsEB9JT+tHjg6ejVFAG0MIfJ/zNB/1k/S1ja5T1vKSwTpTf1kjgfJ
         xdDQ==
X-Gm-Message-State: ABuFfojG3Xv39oSsHa2D0WCv+QnOmAA5J7yfYRbkOfaA47GZGzmKJjYM
        +YsY9samyOTUU4yk8yjYUcnu14Ft
X-Google-Smtp-Source: ACcGV63zSS2ZDjlWaU8Gq2by+bqFntU9NAcFELZlvPOTaujDMZUNYdBEm38qRHKfsQVzQijkhh7xKg==
X-Received: by 2002:a17:902:101:: with SMTP id 1-v6mr23531127plb.15.1539734446417;
        Tue, 16 Oct 2018 17:00:46 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id o12-v6sm17033117pgv.7.2018.10.16.17.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 17:00:45 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 06/12] media: imx-csi: Double crop height for alternate fields at sink
Date:   Tue, 16 Oct 2018 17:00:21 -0700
Message-Id: <20181017000027.23696-7-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181017000027.23696-1-slongerbeam@gmail.com>
References: <20181017000027.23696-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the incoming sink field type is alternate, the reset crop height
and crop height bounds must be set to twice the incoming height,
because in alternate field mode, upstream will report only the
lines for a single field, and the CSI captures the whole frame.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/media/imx/imx-media-csi.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 8f52428d2c75..d5b0f8a66750 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1140,6 +1140,8 @@ static void csi_try_crop(struct csi_priv *priv,
 			 struct v4l2_mbus_framefmt *infmt,
 			 struct v4l2_fwnode_endpoint *upstream_ep)
 {
+	u32 in_height;
+
 	crop->width = min_t(__u32, infmt->width, crop->width);
 	if (crop->left + crop->width > infmt->width)
 		crop->left = infmt->width - crop->width;
@@ -1147,6 +1149,10 @@ static void csi_try_crop(struct csi_priv *priv,
 	crop->left &= ~0x3;
 	crop->width &= ~0x7;
 
+	in_height = infmt->height;
+	if (infmt->field == V4L2_FIELD_ALTERNATE)
+		in_height *= 2;
+
 	/*
 	 * FIXME: not sure why yet, but on interlaced bt.656,
 	 * changing the vertical cropping causes loss of vertical
@@ -1156,12 +1162,12 @@ static void csi_try_crop(struct csi_priv *priv,
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
 
@@ -1401,6 +1407,8 @@ static void csi_try_fmt(struct csi_priv *priv,
 		crop->top = 0;
 		crop->width = sdformat->format.width;
 		crop->height = sdformat->format.height;
+		if (sdformat->format.field == V4L2_FIELD_ALTERNATE)
+			crop->height *= 2;
 		csi_try_crop(priv, crop, cfg, &sdformat->format, upstream_ep);
 		compose->left = 0;
 		compose->top = 0;
@@ -1528,6 +1536,8 @@ static int csi_get_selection(struct v4l2_subdev *sd,
 		sel->r.top = 0;
 		sel->r.width = infmt->width;
 		sel->r.height = infmt->height;
+		if (infmt->field == V4L2_FIELD_ALTERNATE)
+			sel->r.height *= 2;
 		break;
 	case V4L2_SEL_TGT_CROP:
 		sel->r = *crop;
-- 
2.17.1

