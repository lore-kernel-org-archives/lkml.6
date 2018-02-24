Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752711AbeBXAI6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 19:08:58 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:41701 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbeBXAI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 19:08:56 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/3] rtc: pcf85363: add .max_register in regmap_config
Date: Sat, 24 Feb 2018 01:08:50 +0100
Message-Id: <20180224000853.29365-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helps debugging as it allows reading registers from debugfs.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf85363.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index 64573cccf7fe..3c5e5e1a5ead 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -157,6 +157,7 @@ static int pcf85363_nvram_write(void *priv, unsigned int offset, void *val,
 static const struct regmap_config regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
+	.max_register = 0x7f,
 };
 
 static int pcf85363_probe(struct i2c_client *client,
-- 
2.16.1
