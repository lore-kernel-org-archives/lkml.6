Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E18C282C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971D82083B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RazYKkRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfBKCdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 21:33:18 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39428 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfBKCdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 21:33:18 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so22554409itl.4;
        Sun, 10 Feb 2019 18:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=okp0rNGrZPFz/aB6B5PLCu0W3mjSEL1TwEuPEk5lvUg=;
        b=RazYKkRbksX4u8DdnDbvfr15jCGsUaImQBR4DYAr+CwqHIdRdJM5uDYjLdyOLW3jAI
         AnlRS9atCVYYyH2lupd5wyXlIAlaxuxKXxD9Hf7kVfWz/p350RLAHxyZPKf420dVs06T
         KIBqJC48i49eb+JMBQYYKeOwj4zHIxtw8WA0ldeBN7PjS0V2Ys1RqW2FRmyB4vqfTgtF
         QgM09PHGyKw2u9It1SM/BtTnzqyLh6C5C+SSadIP20/D2UsWKkKFoO2bREv9z88S9LSs
         aE7bjAighpauDbJ7J9JjfNIAQ/1cWitsSWkf9ji/vqGtdmnoP48JZm8EyN1cshCLBUZJ
         GWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=okp0rNGrZPFz/aB6B5PLCu0W3mjSEL1TwEuPEk5lvUg=;
        b=i6EJdy2KEmRO7ZwJU7VyDpWjduqLPL4G2ZdIFLmPEDEe+V/s+IXUQS7T8AfexjeK0j
         VcvJMNw8YpnK+l0bVAl5+MTyUdHwttYDrYH+ysd9H+7Yt1sI4VimC6XZdGAfWiyAgkjY
         MCYbk82lc3yW1035fQfdaDy/faniEYGLFNIyQlEGGa3/f93yMkvy68yjwHVamnnal5AH
         kZyAQU5mFfDheS9iIvL33X0vkq2x6bgkcxFigkotfUq+rFeAfc4rl/MIVNBkdzgMpjUo
         5rggZCD6qXJVhXXcb5vAUwn4JOAk59lIiJc8lXtomwKn1J1eFlSl5AG0I7VrGy3qWIXd
         uBJg==
X-Gm-Message-State: AHQUAuZzhH956w7Ema2ORlTL3vSm0HiMqFAXPGi76LaGYZFy/Yk4zOlv
        tpMsV/PO0axV0or1yyMlzEk=
X-Google-Smtp-Source: AHgI3IZGXSrKoyFVQtg1AcFmlHU+d5CSeZJZPaYDLc0PDe+tf2htJDVBzn/9LaKnfpDZgSMwydgGvQ==
X-Received: by 2002:a02:6384:: with SMTP id j126mr3658277jac.143.1549852397203;
        Sun, 10 Feb 2019 18:33:17 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id v6sm3783806ioh.37.2019.02.10.18.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 18:33:16 -0800 (PST)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@gmail.com
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH] Input: qt2160 - remove redundant spinlock
Date:   Sun, 10 Feb 2019 21:32:22 -0500
Message-Id: <20190211023222.29168-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <TheSven73@gmail.com>

Remove a spinlock which prevents schedule_delayed_work() and
mod_delayed_work() from executing concurrently.

This was required back when mod_delayed_work() did not exist,
and had to be implemented with a cancel + schedule. See
commit e7c2f967445d ("workqueue: use mod_delayed_work() instead of
__cancel + queue")

schedule_delayed_work() and mod_delayed_work() can now be used
concurrently. So the spinlock is no longer needed.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/input/keyboard/qt2160.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 43b86482dda0..23dc7c0c7d78 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -69,7 +69,6 @@ struct qt2160_data {
 	struct i2c_client *client;
 	struct input_dev *input;
 	struct delayed_work dwork;
-	spinlock_t lock;        /* Protects canceling/rescheduling of dwork */
 	unsigned short keycodes[ARRAY_SIZE(qt2160_key2code)];
 	u16 key_matrix;
 #ifdef CONFIG_LEDS_CLASS
@@ -221,22 +220,15 @@ static int qt2160_get_key_matrix(struct qt2160_data *qt2160)
 static irqreturn_t qt2160_irq(int irq, void *_qt2160)
 {
 	struct qt2160_data *qt2160 = _qt2160;
-	unsigned long flags;
-
-	spin_lock_irqsave(&qt2160->lock, flags);
 
 	mod_delayed_work(system_wq, &qt2160->dwork, 0);
 
-	spin_unlock_irqrestore(&qt2160->lock, flags);
-
 	return IRQ_HANDLED;
 }
 
 static void qt2160_schedule_read(struct qt2160_data *qt2160)
 {
-	spin_lock_irq(&qt2160->lock);
 	schedule_delayed_work(&qt2160->dwork, QT2160_CYCLE_INTERVAL);
-	spin_unlock_irq(&qt2160->lock);
 }
 
 static void qt2160_worker(struct work_struct *work)
@@ -406,7 +398,6 @@ static int qt2160_probe(struct i2c_client *client,
 	qt2160->client = client;
 	qt2160->input = input;
 	INIT_DELAYED_WORK(&qt2160->dwork, qt2160_worker);
-	spin_lock_init(&qt2160->lock);
 
 	input->name = "AT42QT2160 Touch Sense Keyboard";
 	input->id.bustype = BUS_I2C;
-- 
2.17.1

