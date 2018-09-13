Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98948C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A8320854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRFk6fxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A8320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbeIMSql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:46:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45593 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeIMSqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:46:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id r4-v6so4807484lff.12;
        Thu, 13 Sep 2018 06:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZUDSm2FD2hYYPP2BfK4f9rXkC1bUeU5Jp9/jFHeXBjE=;
        b=cRFk6fxe9M+eVBuzMZS3cHsE1uetveMMfNiiEMHxtdjc335aE5bReGV+11XZwjBi2M
         Qt/WrRM1fpe8wyW4cmBo4TlRyC1fbYNBtTxWxCYXGirWDlkHBwPwoF8aRjIyvKkOVinj
         9q79FQ5aVS7+m7N7O8xAY1iW+CKlTazT6dOrIkbkHlqruK2Dbs8bpB1vl5V13nFoOcUo
         15v1j7qA8LcvDM/te1edM0TygLynbJny0N6Kv5xXh8nPEmYZSXPYCNH3Qd131seR6FfL
         hwZRD47mMlRfgT1ePb00O/4oIfSEFZ6EHHTrzWsM30uCvZnk0GiVrrj6HqKwvYHdiFKO
         PUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZUDSm2FD2hYYPP2BfK4f9rXkC1bUeU5Jp9/jFHeXBjE=;
        b=Xgk/6KS/eelkbXHYjIdLC8nL3qX7mO0TXyFo08WJGKkuGE94F6/ZJ0S+/GmGY76iKl
         gzJkaU+Pk5gcn8PR4AGfQh+z5hS+fuKI4XjnFG6PTuxHRYVvThvXJg8tuhEwXxy+wXjN
         nBvSdqtZg6cYJIx3Y4wp4pg2MExouDtLEE+jw19NgcVC/2Y0Oo6aV/VAZbJ+ZKd9dMui
         XpGWAv66dHPbkl4mHBz72Xcp0KXjjDzQ0kiLg5xurilOJkBDM70fAZ3jhE2qhxI6VOWF
         nEcS2b8/4zXPalkQ4tw9Q9XRJS8eJ2NM0c89C5FgjJxk7qiQwr4Ji38t67WWAit8uZB0
         C5Ow==
X-Gm-Message-State: APzg51DBJIWt7psnl7x/IFdP9orloMmYETJi5mLVaZty6nJHzjnt/Fbk
        L1ZJy7doRsAPs4Ieems6sfM=
X-Google-Smtp-Source: ANB0VdZXXo7obIqxEYtmoKW9PwxzBgwNLbAAUAesjcLF3073b5/MGW0gvbtpja2+Pygp+nx5jV91ug==
X-Received: by 2002:a19:ea52:: with SMTP id i79-v6mr4710803lfh.75.1536845828033;
        Thu, 13 Sep 2018 06:37:08 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id 96-v6sm750026lfu.40.2018.09.13.06.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 06:37:06 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Timur Tabi <timur@codeaurora.org>, stable@vger.kernel.org
Subject: [PATCH] gpiolib: Free the last requested descriptor
Date:   Thu, 13 Sep 2018 15:37:04 +0200
Message-Id: <20180913133704.15739-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code only frees N-1 gpios if an error occurs during
gpiod_set_transitory, gpiod_direction_output or gpiod_direction_input.
Leading to gpios that cannot be used by userspace nor other drivers.

Cc: Timur Tabi <timur@codeaurora.org>
Cc: stable@vger.kernel.org
Fixes: ab3dbcf78f60f46d ("gpioib: do not free unrequested descriptors)
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e8f8a1999393..a57300c1d649 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -571,7 +571,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 		if (ret)
 			goto out_free_descs;
 		lh->descs[i] = desc;
-		count = i;
+		count = i + 1;
 
 		if (lflags & GPIOHANDLE_REQUEST_ACTIVE_LOW)
 			set_bit(FLAG_ACTIVE_LOW, &desc->flags);
-- 
2.18.0

