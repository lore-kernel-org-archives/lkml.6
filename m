Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752348AbeBUU7A (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:59:00 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47089 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751887AbeBUU6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:58:03 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 094/100] rtc: rs5c372:  remove useless message
Date: Wed, 21 Feb 2018 21:56:29 +0100
Message-Id: <20180221205635.31314-95-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not necessary to print a message when the time is invalid as
userspace will already get an error (and an optional dev_dbg message).

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rs5c372.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index d4eff8d7131f..37aa78fd2c4d 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -581,7 +581,6 @@ static int rs5c372_probe(struct i2c_client *client,
 	int err = 0;
 	int smbus_mode = 0;
 	struct rs5c372 *rs5c372;
-	struct rtc_time tm;
 
 	dev_dbg(&client->dev, "%s\n", __func__);
 
@@ -662,9 +661,6 @@ static int rs5c372_probe(struct i2c_client *client,
 		goto exit;
 	}
 
-	if (rs5c372_get_datetime(client, &tm) < 0)
-		dev_warn(&client->dev, "clock needs to be set\n");
-
 	dev_info(&client->dev, "%s found, %s\n",
 			({ char *s; switch (rs5c372->type) {
 			case rtc_r2025sd:	s = "r2025sd"; break;
-- 
2.16.1
