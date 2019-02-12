Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB54EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D2F218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mvwyx3IZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBLBew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:34:52 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54487 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfBLBev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 20:34:51 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so3281720ita.4;
        Mon, 11 Feb 2019 17:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T5tavS5I4KQf0A8sNcYdGmLAMLmvEySgTFJqoQKEz20=;
        b=Mvwyx3IZD+1Q7u+w1q8UcwM/Xdu69epJB9p+OQkPb9uz4L28IeE3caXVVaLnD99qxY
         1D/VnjRGVFJDWXQh7MDNtpf4Lt6NV3Pchcxb6QW4k+1J87suSvdzpWGyckUPCrj3elvi
         Q5Os5vSwox7+ao/6BNHM2XmGPaBfrrTgvti3rUBb4RANDiqF9wStqBMadLFCArF3n5ZT
         qWwdef84uCx72Twvo/e6CouLIEYssaRNnyxnIV+HxXVYrUoQlRBVC8u6+hgqfwFouTNI
         n8VA2D+wv6kA8YQqOsgWV4AMQtAVT0bg2rNI/U9ApeaqkP+L6tXSy1HvnpN/aQX98fi6
         J+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T5tavS5I4KQf0A8sNcYdGmLAMLmvEySgTFJqoQKEz20=;
        b=O2Y92XmyJYxB5UzEnaOSgS7Wpi47RjkJ3zz1rbx38kYTffFeV2RszS9sAiJ8QUrPIo
         NBFcxpMAruPodDYtJ5dZni5VZPqgXtbUrEu1H4jp2JPmgtLb7vQ9a/W7Y1AWKFwd1ooP
         aNga1wFzgWniqUpnD1VPlmbCvyEmx1CU2rIwV22DMZSPXfvmaObrrpFDOfmGPfiMquKg
         LWpuc0UqS8ulyreTrLw1Lit+4DuOj7Y0NsRV+FQOtLjfgsZ56i1V0cV2uHlEYbXXufJe
         soHzvWJ0PlDr9Uliz5H9r3+bc6PDx6Bo702YLflGjXbCRLakYK03LhhdPiUKlpPVANaP
         gQDg==
X-Gm-Message-State: AHQUAuY0Ma4lBhbzs2KSmFbOk8Cn50ME8CBm4m2tc2reSNrrLZJLnBmD
        RZVqn88CqR3D2RQH+Ec1UDr6HUZW
X-Google-Smtp-Source: AHgI3IbjchdEUIC2yxQ+BqSRPbPJOK21Vgy7P+7uxgvZhhIdtNj02oC1lvA3mfkHZv/I3o2xv3rjgw==
X-Received: by 2002:a6b:600b:: with SMTP id r11mr755331iog.259.1549935290545;
        Mon, 11 Feb 2019 17:34:50 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id v19sm587496itb.0.2019.02.11.17.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 17:34:50 -0800 (PST)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@gmail.com
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH] Input: synaptics_i2c - remove redundant spinlock
Date:   Mon, 11 Feb 2019 20:34:42 -0500
Message-Id: <20190212013442.26030-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <TheSven73@gmail.com>

Remove a leftover spinlock.

This was required back when mod_delayed_work() did not exist,
and had to be implemented with a cancel + schedule. See
commit e7c2f967445d ("workqueue: use mod_delayed_work() instead of
__cancel + queue")

schedule_delayed_work() and mod_delayed_work() can now be used
concurrently. So the spinlock is no longer needed.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/input/mouse/synaptics_i2c.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index 8538318d332c..2b2230984ad5 100644
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
@@ -372,13 +371,7 @@ static bool synaptics_i2c_get_input(struct synaptics_i2c *touch)
 static void synaptics_i2c_reschedule_work(struct synaptics_i2c *touch,
 					  unsigned long delay)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&touch->lock, flags);
-
 	mod_delayed_work(system_wq, &touch->dwork, delay);
-
-	spin_unlock_irqrestore(&touch->lock, flags);
 }
 
 static irqreturn_t synaptics_i2c_irq(int irq, void *dev_id)
@@ -530,7 +523,6 @@ static struct synaptics_i2c *synaptics_i2c_touch_create(struct i2c_client *clien
 	touch->scan_rate_param = scan_rate;
 	set_scan_rate(touch, scan_rate);
 	INIT_DELAYED_WORK(&touch->dwork, synaptics_i2c_work_handler);
-	spin_lock_init(&touch->lock);
 
 	return touch;
 }
-- 
2.17.1

