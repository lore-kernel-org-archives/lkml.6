Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01671C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A5A208AC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnh3ViqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A5A208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388524AbeHAVAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:00:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40277 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387714AbeHAVAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:00:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id x5-v6so11280322pgp.7;
        Wed, 01 Aug 2018 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JpaT7TRpuSXZsxMI4cnEQZ2GiNweb/AOqE4Z7IOYzao=;
        b=bnh3ViqEk96whARsVe9lmdaqtlA5Ndg5PZMa2ULQjRqoWl+7mvZ4UoAJQJ8F2xdsN0
         3DdDxQCZ5cMsvWG0XXXX76NcDlYt2Fu9pppV+mEGm7ZQhuJIAmZqMXeg0ecKNlslCZXY
         aSNkT94xCw649W0uOR2DQqCHdYQBA6GyX/jilKREg2XCnjMFUAQvmFB7Fy9snl+rSYi9
         ImzObvA1sbMXw7fbV9lHcMsqskZwHXHtd1y67ERmUjS8NJY7jgnlnoFB0cweL06wrwCa
         7bj4KMTgJNFlDzHVs1H7by9XOXakmzCRvXpDpw0XKwPjbMtZ84BaYRadPJrQvmVSHlrO
         F0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JpaT7TRpuSXZsxMI4cnEQZ2GiNweb/AOqE4Z7IOYzao=;
        b=DtFTVJfQ5OedxrApoTNbow49JwTQBbls+aHCMht6YtIJRo1fp7aXv3Bez4GahtzXOk
         qwcLKGYWZeCcCKtlT+Xoy8PS3FJTyUq8tJfH/pd04u3Sd5v66gTeL9smxpJEttryf8Zi
         qDVSUSW72U/HBak1iE0JM3T+yXXqCr1OhOF01N86QJS2NZIuvSoQnxVW4RdkINJ7NSNB
         TTdhMT8nIK56YnKQKLGY0Sdm03WnNb6jdm0QpOX4SL22kWDD6mwMSpG0hfFKMCQWDfSk
         SQ37T2T2oUYmkCxafB77nwO/mKOOFH7rzgl84MGsDA284fT53PRYHeG3ovGjyPGMFRTb
         Q5Cg==
X-Gm-Message-State: AOUpUlEvp57z760hcWrQx/6n7n5ysW4SEQP5jUM4HAPz3gN6fLHRBuT9
        vfBo39u728opAzRMvtTVvyFzYtBW
X-Google-Smtp-Source: AAOMgpcVmWYGBmny/26co1muyKVIg2JSRM8Kd5wh8H77QJdYA6rha1ge1JHLLjCiASz090X9UlXP7g==
X-Received: by 2002:a62:ee06:: with SMTP id e6-v6mr27994269pfi.2.1533150776569;
        Wed, 01 Aug 2018 12:12:56 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-24-5-209-231.hsd1.ca.comcast.net. [24.5.209.231])
        by smtp.googlemail.com with ESMTPSA id u42-v6sm31171336pgn.1.2018.08.01.12.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 12:12:55 -0700 (PDT)
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
Subject: [PATCH v3 12/14] media: imx-csi: Move crop/compose reset after filling default mbus fields
Date:   Wed,  1 Aug 2018 12:12:25 -0700
Message-Id: <1533150747-30677-13-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
References: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If caller passes un-initialized field type V4L2_FIELD_ANY to CSI
sink pad, the reset CSI crop window would not be correct, because
the crop window depends on a valid input field type. To fix move
the reset of crop and compose windows to after the call to
imx_media_fill_default_mbus_fields().

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/staging/media/imx/imx-media-csi.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 139c694..6f24b3b 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1402,19 +1402,6 @@ static void csi_try_fmt(struct csi_priv *priv,
 				      W_ALIGN, &sdformat->format.height,
 				      MIN_H, MAX_H, H_ALIGN, S_ALIGN);
 
-		/* Reset crop and compose rectangles */
-		crop->left = 0;
-		crop->top = 0;
-		crop->width = sdformat->format.width;
-		crop->height = sdformat->format.height;
-		if (sdformat->format.field == V4L2_FIELD_ALTERNATE)
-			crop->height *= 2;
-		csi_try_crop(priv, crop, cfg, &sdformat->format, upstream_ep);
-		compose->left = 0;
-		compose->top = 0;
-		compose->width = crop->width;
-		compose->height = crop->height;
-
 		*cc = imx_media_find_mbus_format(sdformat->format.code,
 						 CS_SEL_ANY, true);
 		if (!*cc) {
@@ -1430,6 +1417,20 @@ static void csi_try_fmt(struct csi_priv *priv,
 		imx_media_fill_default_mbus_fields(
 			&sdformat->format, infmt,
 			priv->active_output_pad == CSI_SRC_PAD_DIRECT);
+
+		/* Reset crop and compose rectangles */
+		crop->left = 0;
+		crop->top = 0;
+		crop->width = sdformat->format.width;
+		crop->height = sdformat->format.height;
+		if (sdformat->format.field == V4L2_FIELD_ALTERNATE)
+			crop->height *= 2;
+		csi_try_crop(priv, crop, cfg, &sdformat->format, upstream_ep);
+		compose->left = 0;
+		compose->top = 0;
+		compose->width = crop->width;
+		compose->height = crop->height;
+
 		break;
 	}
 }
-- 
2.7.4

