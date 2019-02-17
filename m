Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A69FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 06:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BBC21B69
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 06:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tflIUzDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfBQGLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 01:11:30 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38124 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfBQGLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 01:11:30 -0500
Received: by mail-it1-f196.google.com with SMTP id l66so23655346itg.3;
        Sat, 16 Feb 2019 22:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cD2xTT2d2Swt8dfY5oO9l6rZgzmCM3S/DcGBHpq/rag=;
        b=tflIUzDgNUqAzZGGmvxK0MUEOJPu390ioPS3/jsQuK1OFVUVF5RqYlgoSQ3OmcK0op
         FDzpPh/9jxuoU0hGE9HXYEwX6N6Q02j36fat59iiVbsiSdLjzWFkwOLgL3J2tA6SioeZ
         NmUg76509N1rJHWxrzo/ABJFHh2ghH6qNSaSfOwS5HeR4EIeMBdmb61vJZ8rYyFTiU44
         SlyhPejFn+Kx36z5t5ZnNhp3n5TxaTbDtU+EbbegYGyXzyO3W4F4EjAYtR5qAz2wdBZl
         jRJU2HkEi52meg1m2Y3QfRj6Yp+VFZ4slAY9SuUyW3GaHO9XHjKHksGOyQCGksxJ7nfr
         JJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cD2xTT2d2Swt8dfY5oO9l6rZgzmCM3S/DcGBHpq/rag=;
        b=j3icCxbnJ4QV2mqDkAEc2ZZlxzZ0hrYJJFXy/HJBLV9tkGQzqjHIBchX9Qu+CzPuZ0
         Y1NRyA6jluLvQlFIDobDc+EDQQ9IO46ysZxjI4GDtaxh43FJpBV8ZcnQT+hEHyZEeXn4
         PZPKzxRCNE0LomaAm1Xrp2tK7uCg07Ft1gowfH4K0eLpr25fP/VV1nqNYL4pJDU/Mmum
         ZKHS01Bd0MirTcGzYCQ5SNPybNRRsTRz7Sf+q838w1TPUnpDGv6WDMgWXvSulu8Re300
         X27+ssEEn2MP8el8s33F994kcq0jfAI+Bdm4b132dbYEOLXy/5fusnfH5caPAc1J5YHx
         sF4g==
X-Gm-Message-State: AHQUAuZkxVeRZ2XdsqMhMQcIct4+ZngB/+MJoRf1aNB6giJ92IgMg9gR
        8rsHBu7MvcutKps0iDRTsoSRQo41
X-Google-Smtp-Source: AHgI3Ib6IV8HzGZ+hvLR7dUNv5M6MzUqJ35UF7BBKVzCH3eebbp/NoFptR4+U/EuMWBJ0o3gPFT+Cg==
X-Received: by 2002:a6b:1444:: with SMTP id 65mr10715743iou.105.1550383888449;
        Sat, 16 Feb 2019 22:11:28 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id m8sm3980522ioc.85.2019.02.16.22.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 22:11:27 -0800 (PST)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@gmail.com
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH v2] Input: synaptics_i2c - remove redundant spinlock
Date:   Sun, 17 Feb 2019 01:10:53 -0500
Message-Id: <20190217061053.4559-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <TheSven73@gmail.com>

Remove a leftover spinlock.

This was required back when mod_delayed_work() did not exist,
and had to be implemented with a cancel + queue. See
commit e7c2f967445d ("workqueue: use mod_delayed_work() instead of
__cancel + queue")

schedule_delayed_work() and mod_delayed_work() can now be used
concurrently. So the spinlock is no longer needed.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---

v2: replace useless synaptics_i2c_reschedule_work() with
		mod_delayed_work().

 drivers/input/mouse/synaptics_i2c.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index 8538318d332c..fa304648d611 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -219,7 +219,6 @@ struct synaptics_i2c {
 	struct i2c_client	*client;
 	struct input_dev	*input;
 	struct delayed_work	dwork;
-	spinlock_t		lock;
 	int			no_data_count;
 	int			no_decel_param;
 	int			reduce_report_param;
@@ -369,23 +368,11 @@ static bool synaptics_i2c_get_input(struct synaptics_i2c *touch)
 	return xy_delta || gesture;
 }
 
-static void synaptics_i2c_reschedule_work(struct synaptics_i2c *touch,
-					  unsigned long delay)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&touch->lock, flags);
-
-	mod_delayed_work(system_wq, &touch->dwork, delay);
-
-	spin_unlock_irqrestore(&touch->lock, flags);
-}
-
 static irqreturn_t synaptics_i2c_irq(int irq, void *dev_id)
 {
 	struct synaptics_i2c *touch = dev_id;
 
-	synaptics_i2c_reschedule_work(touch, 0);
+	mod_delayed_work(system_wq, &touch->dwork, 0);
 
 	return IRQ_HANDLED;
 }
@@ -461,7 +448,7 @@ static void synaptics_i2c_work_handler(struct work_struct *work)
 	 * We poll the device once in THREAD_IRQ_SLEEP_SECS and
 	 * if error is detected, we try to reset and reconfigure the touchpad.
 	 */
-	synaptics_i2c_reschedule_work(touch, delay);
+	mod_delayed_work(system_wq, &touch->dwork, delay);
 }
 
 static int synaptics_i2c_open(struct input_dev *input)
@@ -474,7 +461,7 @@ static int synaptics_i2c_open(struct input_dev *input)
 		return ret;
 
 	if (polling_req)
-		synaptics_i2c_reschedule_work(touch,
+		mod_delayed_work(system_wq, &touch->dwork,
 				msecs_to_jiffies(NO_DATA_SLEEP_MSECS));
 
 	return 0;
@@ -530,7 +517,6 @@ static struct synaptics_i2c *synaptics_i2c_touch_create(struct i2c_client *clien
 	touch->scan_rate_param = scan_rate;
 	set_scan_rate(touch, scan_rate);
 	INIT_DELAYED_WORK(&touch->dwork, synaptics_i2c_work_handler);
-	spin_lock_init(&touch->lock);
 
 	return touch;
 }
@@ -637,7 +623,7 @@ static int __maybe_unused synaptics_i2c_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	synaptics_i2c_reschedule_work(touch,
+	mod_delayed_work(system_wq, &touch->dwork,
 				msecs_to_jiffies(NO_DATA_SLEEP_MSECS));
 
 	return 0;
-- 
2.17.1

