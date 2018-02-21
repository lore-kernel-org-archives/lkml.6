Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeBUU6E (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:58:04 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47077 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbeBUU54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:56 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 091/100] rtc: s35390a: remove useless message
Date: Wed, 21 Feb 2018 21:56:26 +0100
Message-Id: <20180221205635.31314-92-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-s35390a.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 7067bca5c20d..604f527a1235 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -450,7 +450,6 @@ static int s35390a_probe(struct i2c_client *client,
 	int err, err_read;
 	unsigned int i;
 	struct s35390a *s35390a;
-	struct rtc_time tm;
 	char buf, status1;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
@@ -508,9 +507,6 @@ static int s35390a_probe(struct i2c_client *client,
 		}
 	}
 
-	if (err_read > 0 || s35390a_get_datetime(client, &tm) < 0)
-		dev_warn(&client->dev, "clock needs to be set\n");
-
 	device_set_wakeup_capable(&client->dev, 1);
 
 	s35390a->rtc = devm_rtc_device_register(&client->dev,
-- 
2.16.1
