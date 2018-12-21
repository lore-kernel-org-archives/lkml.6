Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A23C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA462218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="n9ewZN0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbeLUHE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:04:28 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:54432 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbeLUHE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:04:27 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 46085CFA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 07:04:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rSHEyTCfo_8F for <linux-kernel@vger.kernel.org>;
        Fri, 21 Dec 2018 01:04:26 -0600 (CST)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 0AC96CF6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 01:04:26 -0600 (CST)
Received: by mail-it1-f197.google.com with SMTP id j202so11495732itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 23:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=v/dFnFU7Shmd0+bhBNKw4Rcta7xP+/MJf4OJ1gDaB6M=;
        b=n9ewZN0sh/905HqzRqq8wV+n+JCGS7KX0kBqO8qQqCrOV70sQq1KO6BjZc6ot04Izs
         RRBX7PK0lFq6nGmZ3NPpG0C35ekUqKH++V8b4ArK7A2tq0iDyhJ7M4PNSttQ2Puf95ot
         jM1ude7MEz3isr8cSGAK7MIs7BKuLYg068iwhQYpcMAE3UFzZd8mZENLxLAIfbF6ASMt
         14fYWVeKem1sbsnjY+YjPV5rORKviUu5Vy3qxF1SwfsCoVNOBaKUMQ2ZnQmUL7k0jE2s
         R+hCadzAfd6ZRWF8wvVSFpxunYryN+0ydWDYgKLSaamouiwkD44gEj3uE7S3jLVL/a7h
         lOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v/dFnFU7Shmd0+bhBNKw4Rcta7xP+/MJf4OJ1gDaB6M=;
        b=MZ165WPHwtZYoz1V1giz6jmpg7bsDX59Bc4VmjuabXcNfpES1xsQIkjmK55xWFs7qd
         KqpO+xBGiOPEZiI2WaBj8ouSmhlfQEbxUN1Ht9wiZMyvSa0VZXC5etrobF81jhaJP49f
         Kf9se+L0oE/9bOiOlRc9sfqn73/vID6lxGEblYBrKEr2nrwOHIKDYsK4Xcisoy4HZjzN
         44ijwUh4z2UG16Qwo4PItXeaexPSrVcSqm9r1kftIaLVg327LCrl7Hc751nWHA3M6pMy
         Q8yiS1g4+7AxllJn+1CMotFpgjcRDNGxk2H8AxB0AI1HaD+7WjCjqOAZHr5A35BhtpB8
         piRw==
X-Gm-Message-State: AJcUukcsVfQrcXCPu+AbNAgzbdKbulKkqyV9wz58evQyDw9poKGqwHXu
        tHlO3OnyBCHDyKo0AtJ17gv+upQVcWn0SpoTPM7kA3UmzzbtzIfaOc6K7uFZwpZbYMVedfnCxVX
        0Lrk0IPOz5zVVkBl70uQyLiY7pJl7
X-Received: by 2002:a6b:ab83:: with SMTP id u125mr828033ioe.211.1545375865617;
        Thu, 20 Dec 2018 23:04:25 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4d8SsIYXwsiYoNHTIaSE14oqxMhJJX9Dcg8lQx8VaJCXUmOB/hwpyX9kpVCcPyHAUuKFlU/g==
X-Received: by 2002:a6b:ab83:: with SMTP id u125mr828022ioe.211.1545375865378;
        Thu, 20 Dec 2018 23:04:25 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-23.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.23])
        by smtp.gmail.com with ESMTPSA id 79sm7654383itx.11.2018.12.20.23.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 23:04:24 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Joe Perches <joe@perches.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] touchscreen: elants: fix a missing check of return values
Date:   Fri, 21 Dec 2018 00:59:16 -0600
Message-Id: <20181221065919.60129-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

elants_i2c_send() may fail, let's check its return values. The fix does
the check and reports an error message upon the failure.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/input/touchscreen/elants_i2c.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index f2cb23121833..cb3c1470bb68 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -245,8 +245,14 @@ static int elants_i2c_calibrate(struct elants_data *ts)
 	ts->state = ELAN_WAIT_RECALIBRATION;
 	reinit_completion(&ts->cmd_done);
 
-	elants_i2c_send(client, w_flashkey, sizeof(w_flashkey));
-	elants_i2c_send(client, rek, sizeof(rek));
+	error = elants_i2c_send(client, w_flashkey, sizeof(w_flashkey));
+	error |= elants_i2c_send(client, rek, sizeof(rek));
+	if (error) {
+		dev_err(&client->dev,
+				"error in sending I2C messages for calibration: %d\n",
+				error);
+		return error;
+	}
 
 	enable_irq(client->irq);
 
-- 
2.17.2 (Apple Git-113)

