Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BECEC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB2E20821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CX9qkTpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbfBFSJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:09:00 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33963 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfBFSJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:09:00 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so3444626pfg.1;
        Wed, 06 Feb 2019 10:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6nJURJ4r/iJ7dJytgwY+6iLCpLFguSmIjCgEe0Lraf4=;
        b=CX9qkTpSPWYIhphSfmRUdXLrgLmlbaKzOftqHnWN/uEZ+574Od5BHx5eGFl7JK+Kgc
         V71UTnYtks8orwnbDX37EomRWbqUQJ9iJz+MkMdKMVrM+X5MwFgXwqHYMTlPkmjms3G3
         bxJMEwqE8JT+nVUYzTFV1jbMffn6J2w1cJwge0586eFSXI7GEJAjEzPsK8KPTXsmeYfk
         gtS7qcvh1d51WMe62YP6Ub+22OM2hIQlGp2ur/l0zY5Okz0oQofNb8dcc7ph5vbkktqc
         FRyPOtkbdI4/paj0OZ+h+DhcwP/khOlUX/0YYKUZ23y1kXZEWsJTqNQvMd2Z/VC5cmFX
         TmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6nJURJ4r/iJ7dJytgwY+6iLCpLFguSmIjCgEe0Lraf4=;
        b=c6sSdvCowdFiIAjbZ+6lr0bYcAYGuSVIhViz75p/KfjlkQIoO4fb/5qLPb/1+cAEzT
         +fkrLbu6Jk71NlioGaZPT52/2aGS9ul1TVkeif/lSwjq6ZsDjsw7BkgcZDjp/gpwwBZC
         sbC3xiLZxDx3Rv6hdjRetDRq4vGaXp4yyQZzaLZe6ouQoBH3/A+/pJLP6OohzJlDDWEV
         AS0w+huXACYdeB4S3IiETx5dWKsSaRF/aRy/RXTzTLvDD3lKNdLKV6HauGhPRa6k8dhH
         0YXx9al6o6UOGkVEmGduSY1LEMr2NP08acuzmVf7Ypcrfe80oGwHS6CizCpGGYQxGe6v
         qHAA==
X-Gm-Message-State: AHQUAuYqHrVg0czL+Jq1ZBzjYzkxAhFNxfjoCrHZXA5ApAxGzt+cuzTA
        FdG63eghWUl6g8hGvrDWisANq30r
X-Google-Smtp-Source: AHgI3IYov8k9udyigdeSHw/oTZigWam/SVQ74ajGgWhMSpG3YhAsKmXtujg6yJV6u9gA0vecaPFaSg==
X-Received: by 2002:a63:f552:: with SMTP id e18mr865806pgk.239.1549476538510;
        Wed, 06 Feb 2019 10:08:58 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id h128sm8875408pgc.15.2019.02.06.10.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 10:08:57 -0800 (PST)
Date:   Wed, 6 Feb 2019 10:08:56 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>
Subject: [PATCH] Input: ims-pcu - switch to using brightness_set_blocking()
Message-ID: <20190206180856.GA199121@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that LEDs core allows "blocking" flavor of "set brightness" method we
can use it and get rid of private work item.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 3d51175c4d72..74cf3b612f05 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -39,8 +39,6 @@ struct ims_pcu_gamepad {
 
 struct ims_pcu_backlight {
 	struct led_classdev cdev;
-	struct work_struct work;
-	enum led_brightness desired_brightness;
 	char name[32];
 };
 
@@ -949,14 +947,14 @@ static void ims_pcu_process_async_firmware(const struct firmware *fw,
 
 #define IMS_PCU_MAX_BRIGHTNESS		31998
 
-static void ims_pcu_backlight_work(struct work_struct *work)
+static int ims_pcu_backlight_set_brightness(struct led_classdev *cdev,
+					    enum led_brightness value)
 {
 	struct ims_pcu_backlight *backlight =
-			container_of(work, struct ims_pcu_backlight, work);
+			container_of(cdev, struct ims_pcu_backlight, cdev);
 	struct ims_pcu *pcu =
 			container_of(backlight, struct ims_pcu, backlight);
-	int desired_brightness = backlight->desired_brightness;
-	__le16 br_val = cpu_to_le16(desired_brightness);
+	__le16 br_val = cpu_to_le16(value);
 	int error;
 
 	mutex_lock(&pcu->cmd_mutex);
@@ -966,19 +964,11 @@ static void ims_pcu_backlight_work(struct work_struct *work)
 	if (error && error != -ENODEV)
 		dev_warn(pcu->dev,
 			 "Failed to set desired brightness %u, error: %d\n",
-			 desired_brightness, error);
+			 value, error);
 
 	mutex_unlock(&pcu->cmd_mutex);
-}
 
-static void ims_pcu_backlight_set_brightness(struct led_classdev *cdev,
-					     enum led_brightness value)
-{
-	struct ims_pcu_backlight *backlight =
-			container_of(cdev, struct ims_pcu_backlight, cdev);
-
-	backlight->desired_brightness = value;
-	schedule_work(&backlight->work);
+	return error;
 }
 
 static enum led_brightness
@@ -1015,14 +1005,14 @@ static int ims_pcu_setup_backlight(struct ims_pcu *pcu)
 	struct ims_pcu_backlight *backlight = &pcu->backlight;
 	int error;
 
-	INIT_WORK(&backlight->work, ims_pcu_backlight_work);
 	snprintf(backlight->name, sizeof(backlight->name),
 		 "pcu%d::kbd_backlight", pcu->device_no);
 
 	backlight->cdev.name = backlight->name;
 	backlight->cdev.max_brightness = IMS_PCU_MAX_BRIGHTNESS;
 	backlight->cdev.brightness_get = ims_pcu_backlight_get_brightness;
-	backlight->cdev.brightness_set = ims_pcu_backlight_set_brightness;
+	backlight->cdev.brightness_set_blocking =
+					 ims_pcu_backlight_set_brightness;
 
 	error = led_classdev_register(pcu->dev, &backlight->cdev);
 	if (error) {
@@ -1040,7 +1030,6 @@ static void ims_pcu_destroy_backlight(struct ims_pcu *pcu)
 	struct ims_pcu_backlight *backlight = &pcu->backlight;
 
 	led_classdev_unregister(&backlight->cdev);
-	cancel_work_sync(&backlight->work);
 }
 
 
-- 
2.20.1.611.gfbb209baf1-goog


-- 
Dmitry
