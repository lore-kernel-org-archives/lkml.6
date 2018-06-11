Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id DZFRLIhiHlvjVgAAmS7hNA
	; Mon, 11 Jun 2018 11:53:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A8F19608D4; Mon, 11 Jun 2018 11:53:38 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifCZzySa"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8CFCB601C3;
	Mon, 11 Jun 2018 11:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8CFCB601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933232AbeFKLxe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:53:34 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46100 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933004AbeFKLxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:53:30 -0400
Received: by mail-lf0-f67.google.com with SMTP id j13-v6so30073097lfb.13;
        Mon, 11 Jun 2018 04:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GEN7IdTATWghTMPM7hc3U+Ki/zQhk34K4xGdS2iASg0=;
        b=ifCZzySa7wOK26ni5Fl3NsMu8UCo1o0n5tkZJo3eLtVN0K/+OTC1nnoOkxFFaXr5gY
         r7BuNU7qHV156UfwbzDrtlZtGgAB9bZLhITDly3qKVKwVZ6bsebPN99JmBNySwMYLEUj
         FG/CPgFtRfqDzQ1YB2oQL6aGVzxyMkNQTfmAJvG406sNTQWBZuxzHIZCKXX2q2nFxXEn
         Fl190yIHDsBz1QYZESi1CimpxjIWj6L/O8uWVBDhFIt5BviZWeYxqp/myeRoNTj6eFOM
         N3F8Os8cZds2jJRpu+XCaehBIDgfKiia2chd0+l5b0VAXL2ZUhkV8Pr/ATBAERFVgwLd
         qT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GEN7IdTATWghTMPM7hc3U+Ki/zQhk34K4xGdS2iASg0=;
        b=RNUrVI4IIH3hCakS6v+y03USrG/maq0XSWFVbnIH5DQMXeoGiHDM4aLUJqRo8CLG5N
         F1L+wCVj83RooTogE2JPPxgJTEqLnxW63VFhO6fDWf3v6Zsqjb65meiFNQ2CwQvsQ8nR
         rukGQVQJ2ymUGj6pkuCyZfr1K8y0xdT7wHFsVRVhlKJ+tUOMXi+sf8ua1jmELQhe1sFR
         TA47Z07fbJKWK/PCymdr3NjMffN1F/LV+ePKjq54gWDQ7GO5BZv2HofaF0UtMH9HT8R4
         3EsdJDOwoB7Yi03xsXr33tleT3SvnPZwANgfefdkwakJBOidrrHd7AccWoCEjRfnsZY8
         W9og==
X-Gm-Message-State: APt69E3E8OmG52XAi7eH2o0XkdhnmO797W9a/CREN2J4jm1bRuOldmHu
        L6Jay90mlGR6g/ZwWERKu+niv0Ye
X-Google-Smtp-Source: ADUXVKLPWLpufs1eOwYOcnsKjJ+dojhJZCReKcKGKGxNoisS1iVLDR7YMR1spcAAFyxMNJqWcofUXA==
X-Received: by 2002:a19:f03:: with SMTP id e3-v6mr10696101lfi.145.1528718008600;
        Mon, 11 Jun 2018 04:53:28 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:53:27 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v2 20/24] serdev: Make match_id accessible by drivers
Date: Mon, 11 Jun 2018 13:52:36 +0200
Message-Id: <20180611115240.32606-21-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers that make use of the driver_data field require to transverse the
id_table. There is no reason to have one implementation per driver.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/core.c | 12 +++++++-----
 include/linux/serdev.h    |  3 +++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 587d2796b3d5..3084b6d10179 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -158,17 +158,19 @@ static const struct device_type serdev_ctrl_type = {
 	.release	= serdev_ctrl_release,
 };
 
-static int serdev_match_id(const struct serdev_device_id *id,
-			   const struct serdev_device *sdev)
+const struct serdev_device_id *serdev_match_id(
+			const struct serdev_device_id *id,
+			const struct serdev_device *sdev)
 {
 	while (id->name[0]) {
 		if (!strcmp(sdev->modalias, id->name))
-			return 1;
+			return id;
 		id++;
 	}
 
-	return 0;
+	return NULL;
 }
+EXPORT_SYMBOL_GPL(serdev_match_id);
 
 static int serdev_device_match(struct device *dev, struct device_driver *drv)
 {
@@ -186,7 +188,7 @@ static int serdev_device_match(struct device *dev, struct device_driver *drv)
 		return 1;
 
 	if (sdrv->id_table)
-		return serdev_match_id(sdrv->id_table, sdev);
+		return serdev_match_id(sdrv->id_table, sdev) != NULL;
 
 	return strcmp(sdev->modalias, drv->name) == 0;
 }
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 07d63933bdb9..bf282b3781b9 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -172,6 +172,9 @@ static inline void serdev_controller_put(struct serdev_controller *ctrl)
 		put_device(&ctrl->dev);
 }
 
+const struct serdev_device_id *serdev_match_id(
+		const struct serdev_device_id *id,
+		const struct serdev_device *sdev);
 struct serdev_device *serdev_device_alloc(struct serdev_controller *);
 int serdev_device_add(struct serdev_device *);
 void serdev_device_remove(struct serdev_device *);
-- 
2.17.1
