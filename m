Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B658C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CCB27BDA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a850oKOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CCB27BDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755517AbeF2Sq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:46:59 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39240 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752225AbeF2Sq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:46:57 -0400
Received: by mail-pl0-f67.google.com with SMTP id s24-v6so4863504plq.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=g5ND04aNPqFMAeogDMTcSKK/m3nnqOsA1sRjxsKaOhI=;
        b=a850oKOYK1JVQKgt5+NxnZHq5LOD31tDQkaAid2rlYw4n2qsIpy6bepss7yd5eS1ut
         VgSMZ3DYW9TsIuPx4iEWvyneP0a8SGY7Mv8gfokw81kW9La4Oh8HjnKyf3/IlYtlT0F+
         /AAE4FIgU/BDU9+WwGO3IokqEIqUpTG4hmlL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=g5ND04aNPqFMAeogDMTcSKK/m3nnqOsA1sRjxsKaOhI=;
        b=ohk/XJma712PGNhWvHJGyGv7/YaJPyznwcCjT8Jion9hdL3X/oSYywEnpTWv1MZ548
         VYlpIyrUMWcoO3UHZdEEjiNDTyh6bIg7XYAGAh8RpSMAa2sAVxjspCzDVTUQI8G6txul
         F5GI0vNQGh+2dEbmPWUf5yMFxl296AcV94a00mRQmCDQuWMP5UnELgairEmBOvLdieng
         0q0b4+BQTGgsoxJwqVZ9HWxOoQovudpTZpLXNuTBLtLLObEg/141mU703SD5c7yqcHSe
         FYWsRIzsBRFkl2sMIAgfBn03ZJiedQtmEqlvA1ZPgwDx8IwmMMNL49i2vfqpC7FmONNY
         wMvg==
X-Gm-Message-State: APt69E18jqrQNcxfjTylbo/bFuTSq9LFClE8Of53hQknp+2FLrBFvaDR
        muJuqe0l+l3jlGacw0u9SK1JMA==
X-Google-Smtp-Source: ADUXVKImmgNesnFvrtbU6UOdaFz0MP8QhsHP3K2eGVpq7jI8j9CRINMXGNeJICdl5xkqNy6FNxjvhA==
X-Received: by 2002:a17:902:8341:: with SMTP id z1-v6mr16191495pln.40.1530298016906;
        Fri, 29 Jun 2018 11:46:56 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id z19-v6sm14199636pfe.163.2018.06.29.11.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 11:46:55 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:46:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Timur Tabi <timur@tabi.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: fsl-diu-fb: Remove VLA usage
Message-ID: <20180629184655.GA37391@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this moves
the buffer off the stack (since it could be as much as 1024 bytes), and
uses a new area in the cursor data structure. Additionally adds missed
documentation and removes redundant assignments.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/video/fbdev/fsl-diu-fb.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index 1bfd13cbd4e3..bc9eb8afc313 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -360,6 +360,10 @@ struct mfb_info {
  * @ad[]: Area Descriptors for each real AOI
  * @gamma: gamma color table
  * @cursor: hardware cursor data
+ * @blank_cursor: blank cursor for hiding cursor
+ * @next_cursor: scratch space to build load cursor
+ * @edid_data: EDID information buffer
+ * @has_edid: whether or not the EDID buffer is valid
  *
  * This data structure must be allocated with 32-byte alignment, so that the
  * internal fields can be aligned properly.
@@ -381,6 +385,8 @@ struct fsl_diu_data {
 	__le16 cursor[MAX_CURS * MAX_CURS] __aligned(32);
 	/* Blank cursor data -- used to hide the cursor */
 	__le16 blank_cursor[MAX_CURS * MAX_CURS] __aligned(32);
+	/* Scratch cursor data -- used to build new cursor */
+	__le16 next_cursor[MAX_CURS * MAX_CURS] __aligned(32);
 	uint8_t edid_data[EDID_LENGTH];
 	bool has_edid;
 } __aligned(32);
@@ -1056,13 +1062,17 @@ static int fsl_diu_cursor(struct fb_info *info, struct fb_cursor *cursor)
 	 * FB_CUR_SETSHAPE - the cursor bitmask has changed
 	 */
 	if (cursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETCMAP | FB_CUR_SETIMAGE)) {
+		/*
+		 * Determine the size of the cursor image data.  Normally,
+		 * it's 8x16.
+		 */
 		unsigned int image_size =
-			DIV_ROUND_UP(cursor->image.width, 8) * cursor->image.height;
+			DIV_ROUND_UP(cursor->image.width, 8) *
+			cursor->image.height;
 		unsigned int image_words =
 			DIV_ROUND_UP(image_size, sizeof(uint32_t));
 		unsigned int bg_idx = cursor->image.bg_color;
 		unsigned int fg_idx = cursor->image.fg_color;
-		uint8_t buffer[image_size];
 		uint32_t *image, *source, *mask;
 		uint16_t fg, bg;
 		unsigned int i;
@@ -1070,13 +1080,6 @@ static int fsl_diu_cursor(struct fb_info *info, struct fb_cursor *cursor)
 		if (info->state != FBINFO_STATE_RUNNING)
 			return 0;
 
-		/*
-		 * Determine the size of the cursor image data.  Normally,
-		 * it's 8x16.
-		 */
-		image_size = DIV_ROUND_UP(cursor->image.width, 8) *
-			cursor->image.height;
-
 		bg = ((info->cmap.red[bg_idx] & 0xf8) << 7) |
 		     ((info->cmap.green[bg_idx] & 0xf8) << 2) |
 		     ((info->cmap.blue[bg_idx] & 0xf8) >> 3) |
@@ -1088,7 +1091,7 @@ static int fsl_diu_cursor(struct fb_info *info, struct fb_cursor *cursor)
 		     1 << 15;
 
 		/* Use 32-bit operations on the data to improve performance */
-		image = (uint32_t *)buffer;
+		image = (uint32_t *)data->next_cursor;
 		source = (uint32_t *)cursor->image.data;
 		mask = (uint32_t *)cursor->mask;
 
-- 
2.17.1


-- 
Kees Cook
Pixel Security
