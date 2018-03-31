Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752885AbeCaLWj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 07:22:39 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38602 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751720AbeCaLWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 07:22:11 -0400
X-Google-Smtp-Source: AIpwx49SplD2Rv5GuD7SPe81Wt2+NNxvPg5SfcBN1t6ss5VYy0Sf5rm6wUJgmnnXkhRS8o0wJk+Svw==
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] input: as5011: avoid using __set_bit() for capabilities
Date: Sat, 31 Mar 2018 13:21:41 +0200
Message-Id: <20180331112143.18768-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180331112143.18768-1-marcus.folkesson@gmail.com>
References: <20180331112143.18768-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

input_set_capability() and input_set_abs_param() will do it for you.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/input/joystick/as5011.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/joystick/as5011.c b/drivers/input/joystick/as5011.c
index 005d852a06e9..f051993c568e 100644
--- a/drivers/input/joystick/as5011.c
+++ b/drivers/input/joystick/as5011.c
@@ -269,9 +269,7 @@ static int as5011_probe(struct i2c_client *client,
 	input_dev->id.bustype = BUS_I2C;
 	input_dev->dev.parent = &client->dev;
 
-	__set_bit(EV_KEY, input_dev->evbit);
-	__set_bit(EV_ABS, input_dev->evbit);
-	__set_bit(BTN_JOYSTICK, input_dev->keybit);
+	input_set_capability(input_dev, EV_KEY, BTN_JOYSTICK);
 
 	input_set_abs_params(input_dev, ABS_X,
 		AS5011_MIN_AXIS, AS5011_MAX_AXIS, AS5011_FUZZ, AS5011_FLAT);
-- 
2.16.2
