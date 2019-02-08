Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9DFC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EB320855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZGtFvtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfBHTel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:34:41 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50928 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfBHTek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:34:40 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so11685669iti.0;
        Fri, 08 Feb 2019 11:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QjA83Q8MmTnop4g3h12nedCeyOVJGzg441SSGsBaBLU=;
        b=JZGtFvtBThRiVbSnGwZTFJJl98DqMfRpC0mqLw6NW45pRx9sU0fvH3xhsCZtoL73pd
         Vi1i2NsIru7iLnSQcW7fhx6NSRPFiYfJ6gNMxX+1gqHX+tHPRc4hJecN6xoBl98FfLT7
         bzP4dzCIjQj9kfYv3QmpLm81XCDgCBEJA4lbJMalHJ2Sb6PvWYexz1SMK+zeUhLvfXB6
         3gMC4AnJqFcGfvI8JThFKzRIA+KvK7SNxz6p4Y1EqXufAqO1q0xOf49UuIQp6OxBPmV7
         EffhkboZ/oOG5K5gFjGd0faccxRF9wUXrTPDmBoa3BcRqOrGy13gLmZp44cW3/RJFQiW
         O2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QjA83Q8MmTnop4g3h12nedCeyOVJGzg441SSGsBaBLU=;
        b=nWHN/eNAfzcee57VZg9057fk4XiK2AMI5ubZoZiEtI+udX9KdCIGdO10b7m5cIo0bc
         QFTaKHaP0Dz7nSN6kl5Ylabm7pzm+owgR8UGd5eqDYA2SHDzRBnqT/6Tnfq2Eb226/B2
         buxvXOsJdyquS737Z9BhjzXTIKmTus/VSMPOF/DFZ9iUdPGCWR/3T1L4ycC5leTFa4/q
         Wj3lPKDWUzRBPNIr5RW2WBz9x2vrssOV/Gvn1Bo6HbyS5cWPBpyiD/NxQDdojOfa01tl
         HUvR235IuIFwJglbekGmqaWajhB7WuqFfS1XVnm1LrYtRNj7lIgdQGjjtonaifft4EAF
         4rFQ==
X-Gm-Message-State: AHQUAubAaIEmUSNVL/0c1Q5pUZNx7qApzm4K1Hl3OfZipLz4r1HBaXu9
        isE1QDRBTmWU30U+CYUtirM=
X-Google-Smtp-Source: AHgI3IZLyKilqku5xceicyM+C4QVJD+OV/4P3V7MtJFjFLZsxokb7uDa8RlnPgUsYC/xroSZuaDZHg==
X-Received: by 2002:a24:5651:: with SMTP id o78mr59774itb.157.1549654479510;
        Fri, 08 Feb 2019 11:34:39 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id v202sm1636425ita.13.2019.02.08.11.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 11:34:38 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] Input: lm8323: switch to using set_brightness_blocking
Date:   Fri,  8 Feb 2019 14:34:33 -0500
Message-Id: <20190208193434.5629-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disclaimer:
I cannot test this driver as I do not have any h/w.
This RFC patch is not intended as a ready-made solution,
but to provoke discussion.

Problem 1:
lm8323_pwm_work() could still run after the device has been removed, which
would result in a use-after-free.

Problem 2:
The brightness_set callback must not sleep, but in this case it grabs a
mutex, which can potentially sleep.

Solution:
lm8323_pwm_work() grabs a mutex and performs i2c accesses, therefore it may
sleep, and that is not allowed in brightness_set callback.
Use brightness_set_blocking callback instead. This has its own workqueue,
which is handled correctly on device removal. So the use-after-free
disappears. As a bonus, we no longer require a separate work_struct.

Question:
The original set_brightness had a separate code path when the device is in
suspend:

	/*
	* Schedule PWM work as usual unless we are going into suspend
	*/
	mutex_lock(&lm->lock);
	if (likely(!lm->pm_suspend))
	       schedule_work(&pwm->work);
	else
	       lm8323_pwm_work(&pwm->work);
	mutex_unlock(&lm->lock);

Why was it there, and does the current led core code handle this case
correctly?

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/input/keyboard/lm8323.c | 49 ++++++---------------------------
 1 file changed, 8 insertions(+), 41 deletions(-)

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 04a5d7e134d7..ea4ed1750eb5 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -137,7 +137,6 @@ struct lm8323_pwm {
 	bool			running;
 	/* pwm lock */
 	struct mutex		lock;
-	struct work_struct	work;
 	struct led_classdev	cdev;
 	struct lm8323_chip	*chip;
 };
@@ -148,7 +147,6 @@ struct lm8323_chip {
 	struct i2c_client	*client;
 	struct input_dev	*idev;
 	bool			kp_enabled;
-	bool			pm_suspend;
 	unsigned		keys_down;
 	char			phys[32];
 	unsigned short		keymap[LM8323_KEYMAP_SIZE];
@@ -162,7 +160,6 @@ struct lm8323_chip {
 #define client_to_lm8323(c)	container_of(c, struct lm8323_chip, client)
 #define dev_to_lm8323(d)	container_of(d, struct lm8323_chip, client->dev)
 #define cdev_to_pwm(c)		container_of(c, struct lm8323_pwm, cdev)
-#define work_to_pwm(w)		container_of(w, struct lm8323_pwm, work)
 
 #define LM8323_MAX_DATA 8
 
@@ -365,7 +362,7 @@ static void pwm_done(struct lm8323_pwm *pwm)
 	mutex_lock(&pwm->lock);
 	pwm->running = false;
 	if (pwm->desired_brightness != pwm->brightness)
-		schedule_work(&pwm->work);
+		led_set_brightness(&pwm->cdev, pwm->desired_brightness);
 	mutex_unlock(&pwm->lock);
 }
 
@@ -450,15 +447,18 @@ static void lm8323_write_pwm(struct lm8323_pwm *pwm, int kill,
 	pwm->running = true;
 }
 
-static void lm8323_pwm_work(struct work_struct *work)
+static int lm8323_pwm_set_brightness(struct led_classdev *led_cdev,
+				      enum led_brightness brightness)
 {
-	struct lm8323_pwm *pwm = work_to_pwm(work);
+	struct lm8323_pwm *pwm = cdev_to_pwm(led_cdev);
 	int div512, perstep, steps, hz, up, kill;
 	u16 pwm_cmds[3];
 	int num_cmds = 0;
 
 	mutex_lock(&pwm->lock);
 
+	pwm->desired_brightness = brightness;
+
 	/*
 	 * Do nothing if we're already at the requested level,
 	 * or previous setting is not yet complete. In the latter
@@ -504,31 +504,7 @@ static void lm8323_pwm_work(struct work_struct *work)
 
  out:
 	mutex_unlock(&pwm->lock);
-}
-
-static void lm8323_pwm_set_brightness(struct led_classdev *led_cdev,
-				      enum led_brightness brightness)
-{
-	struct lm8323_pwm *pwm = cdev_to_pwm(led_cdev);
-	struct lm8323_chip *lm = pwm->chip;
-
-	mutex_lock(&pwm->lock);
-	pwm->desired_brightness = brightness;
-	mutex_unlock(&pwm->lock);
-
-	if (in_interrupt()) {
-		schedule_work(&pwm->work);
-	} else {
-		/*
-		 * Schedule PWM work as usual unless we are going into suspend
-		 */
-		mutex_lock(&lm->lock);
-		if (likely(!lm->pm_suspend))
-			schedule_work(&pwm->work);
-		else
-			lm8323_pwm_work(&pwm->work);
-		mutex_unlock(&lm->lock);
-	}
+	return 0;
 }
 
 static ssize_t lm8323_pwm_show_time(struct device *dev,
@@ -579,13 +555,12 @@ static int init_pwm(struct lm8323_chip *lm, int id, struct device *dev,
 	pwm->desired_brightness = 0;
 	pwm->running = false;
 	pwm->enabled = false;
-	INIT_WORK(&pwm->work, lm8323_pwm_work);
 	mutex_init(&pwm->lock);
 	pwm->chip = lm;
 
 	if (name) {
 		pwm->cdev.name = name;
-		pwm->cdev.brightness_set = lm8323_pwm_set_brightness;
+		pwm->cdev.brightness_set_blocking = lm8323_pwm_set_brightness;
 		pwm->cdev.groups = lm8323_pwm_groups;
 		if (led_classdev_register(dev, &pwm->cdev) < 0) {
 			dev_err(dev, "couldn't register PWM %d\n", id);
@@ -799,10 +774,6 @@ static int lm8323_suspend(struct device *dev)
 	irq_set_irq_wake(client->irq, 0);
 	disable_irq(client->irq);
 
-	mutex_lock(&lm->lock);
-	lm->pm_suspend = true;
-	mutex_unlock(&lm->lock);
-
 	for (i = 0; i < 3; i++)
 		if (lm->pwm[i].enabled)
 			led_classdev_suspend(&lm->pwm[i].cdev);
@@ -816,10 +787,6 @@ static int lm8323_resume(struct device *dev)
 	struct lm8323_chip *lm = i2c_get_clientdata(client);
 	int i;
 
-	mutex_lock(&lm->lock);
-	lm->pm_suspend = false;
-	mutex_unlock(&lm->lock);
-
 	for (i = 0; i < 3; i++)
 		if (lm->pwm[i].enabled)
 			led_classdev_resume(&lm->pwm[i].cdev);
-- 
2.17.1

