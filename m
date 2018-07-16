Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF455ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BC3208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/sC4JUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BC3208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbeGPVc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:32:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55475 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729601AbeGPVc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:32:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so4275214wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 14:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XtqqCN2m3xu2+xIK5UM2oKwxj9zAXPr6CmFB6iF0ET0=;
        b=S/sC4JUZWZNQryEq7Tf2YQbA7CF0BR7N6sSfHLD2XJomM9ML4dbQG7N6CpF19WEnLZ
         JymdPNbBfOmRQydOR5udU5U0KHVDYMAMEXN4a+9xpjJAo179Km05l1IENAGz0RlHDyey
         VVvw/KQ/dvFW6FvQ65H5a6cOXhkPhEgG7wYgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XtqqCN2m3xu2+xIK5UM2oKwxj9zAXPr6CmFB6iF0ET0=;
        b=Crxbc7ozjTAnRJ4Ck8JhId+fxw055tRs5hZIF6ZzHS9T0O9TvNJPsX5jIftnANSSeT
         Rr/xD4Km1EAiLGWJKDch9aEz4AI22Ji3rKDxmU5WqYIjgvNCdQg2Rz0bBOdOwNZRCjfH
         HkKCbXe66H31pLc5ucwE/TgrWQ5F0Igzdq0X6tcSMQzQvqY9prUOyjTXy5ZVSttWuiAo
         DkYidQ+DdtysAXzAt1qmwWGQUJFrCk7/GuApDy7pwn5PDkosGRaJAzNZQ6IseUqX0F4l
         bqzlqXAlrPRS12bYbpLgTzOR3v0tZBxz8FDUqr/X7yQmSV4QpwtKbwJf/hdtoDgqDKvK
         xYJQ==
X-Gm-Message-State: AOUpUlGO1qF7KKzZapwmtE/K9JRYH1AtmQyfA/ZYdkdPXK0ju744ncnM
        8V+2grm8VkW3aq8YrlWq8RCOjw==
X-Google-Smtp-Source: AAOMgpe1r72w0fHi5KLe2PHYwWQebahpDRj3TY9tbmn0Uuk/vQspoBFxh851a5ni3+31LBODUu7/yw==
X-Received: by 2002:a1c:d892:: with SMTP id p140-v6mr2649336wmg.76.1531774996308;
        Mon, 16 Jul 2018 14:03:16 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id u135-v6sm15127923wmf.2.2018.07.16.14.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 14:03:15 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@linaro.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH] backlight: pwm_bl: Fix uninitialized variable
Date:   Mon, 16 Jul 2018 22:02:41 +0100
Message-Id: <20180716210241.9457-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if the DT does not define num-interpolated-steps then
num_steps is undefined and the interpolation code will deploy randomly.
Fix this.

Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation between
brightness-levels")
Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---
 drivers/video/backlight/pwm_bl.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 9ee4c1b735b2..e3c22b79fbcd 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -299,15 +299,14 @@ static int pwm_backlight_parse_dt(struct device *dev,
 		 * interpolation between each of the values of brightness levels
 		 * and creates a new pre-computed table.
 		 */
-		of_property_read_u32(node, "num-interpolated-steps",
-				     &num_steps);
-
-		/*
-		 * Make sure that there is at least two entries in the
-		 * brightness-levels table, otherwise we can't interpolate
-		 * between two points.
-		 */
-		if (num_steps) {
+		if ((of_property_read_u32(node, "num-interpolated-steps",
+					  &num_steps) == 0) && num_steps) {
+			/*
+			 * Make sure that there is at least two entries in the
+			 * brightness-levels table, otherwise we can't
+			 * interpolate
+			 * between two points.
+			 */
 			if (data->max_brightness < 2) {
 				dev_err(dev, "can't interpolate\n");
 				return -EINVAL;
--
2.17.1

