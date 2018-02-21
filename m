Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeBUU6C (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:58:02 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47084 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751887AbeBUU5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:55 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 087/100] rtc: rx8581: remove useless message
Date: Wed, 21 Feb 2018 21:56:22 +0100
Message-Id: <20180221205635.31314-88-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-rx8581.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
index 9998d7937688..32caadf912ca 100644
--- a/drivers/rtc/rtc-rx8581.c
+++ b/drivers/rtc/rtc-rx8581.c
@@ -164,11 +164,7 @@ static int rx8581_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 		tm->tm_sec, tm->tm_min, tm->tm_hour,
 		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
 
-	err = rtc_valid_tm(tm);
-	if (err < 0)
-		dev_err(&client->dev, "retrieved date/time is not valid.\n");
-
-	return err;
+	return 0;
 }
 
 static int rx8581_set_datetime(struct i2c_client *client, struct rtc_time *tm)
-- 
2.16.1
