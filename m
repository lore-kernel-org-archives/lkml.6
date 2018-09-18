Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FFAC4161C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6D0214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfqnQWhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6D0214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbeIRGRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:17:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41992 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbeIRGRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:17:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so103499pgp.9;
        Mon, 17 Sep 2018 17:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0w+EbiE4L+ll0rh87wVXQ0LffiC/T5ki4PVoOHplc8U=;
        b=NfqnQWhfFhmM+QPrJQhqJMwlaTM+DwEBI8/OyQlUbNbV5GgT7O36hWW+j5Ve4cscz+
         NC3EqHwhbwYpDbuq+kkJUfH7q/1vZJY7y0th82HNM6mV1JsZabsprvbV6R7K56u7/OkD
         HRP5+4nKijb8VNauNLA/cx4RbAJ3YGsIQVooF0Odns0Sk/gch5q2HvomXYLIlhWSqc5x
         hOrxsgqaYUi3fY98itDISZvwPKPb2W5leBPl1UkQ+srMhX47xIB+Dzf84fd5xTOmL6tB
         E8sF5dshYvmRgH9fK0BGnVXQm/NgMo9YR4kB9At5UdT1Wf+FuOoCfPl+O7l5IhUAqWPH
         ScBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0w+EbiE4L+ll0rh87wVXQ0LffiC/T5ki4PVoOHplc8U=;
        b=mlw8BDIfd5l+UFFRX0TU7/Q3AEhXs98ICtxTsWuqzpMyGAnV7Gi1EKStwS1qkOm1G4
         mUF6JR59zH77sk6FKAqK7Ozo0g5zldLIoApt5XCSPvxoPU1/dMwwC9p8kMDRAdwvy3fg
         EoxzHSSmEelc1TcF3ruw2qUuYfchYSdeEAADxFO8Z74XG9x6xJAlLWzbVN2Gr9DoYRof
         B8y2gq/o69v9isesOMW3Uw1SaqYsgwsesnWp8U6BSXGsdcngnVehgUGFW6646A+jcYFQ
         ak4W5XV06yPjzO2V1KvDnhhfThxhX4BXLNwcvvGcvcm4BdM8IBGXwLe9AJcNH8n/0ZO4
         a8vA==
X-Gm-Message-State: APzg51BpovqHY/ttgWnaC3EUdC6YQYrH6LucBB/BMcd/cVV7GVXuMmG4
        /OuRMA6pJCxl5rFtkj6CRDpeshuX
X-Google-Smtp-Source: ANB0Vdbc44lKUcxxo46h98t6Jq87N8DkZf8f3dL1OIxBmeUbdvjIqRi3rYPFd1MUnD7EJYlhAPQYzg==
X-Received: by 2002:a62:642:: with SMTP id 63-v6mr28386809pfg.42.1537231671646;
        Mon, 17 Sep 2018 17:47:51 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w69-v6sm26053316pgd.37.2018.09.17.17.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:47:50 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 11/20] Input: iforce - factor out hat handling when parsing packets
Date:   Mon, 17 Sep 2018 17:47:23 -0700
Message-Id: <20180918004732.9875-11-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes code clearer a bit.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../input/joystick/iforce/iforce-packets.c    | 101 ++++++++++--------
 1 file changed, 57 insertions(+), 44 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index 7aba2966454a..ffd1dd65deb8 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -130,11 +130,47 @@ static int mark_core_as_ready(struct iforce *iforce, unsigned short addr)
 	return -1;
 }
 
-void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
+static void iforce_report_hats_buttons(struct iforce *iforce, u8 *data)
 {
 	struct input_dev *dev = iforce->dev;
 	int i;
 
+	input_report_abs(dev, ABS_HAT0X, iforce_hat_to_axis[data[6] >> 4].x);
+	input_report_abs(dev, ABS_HAT0Y, iforce_hat_to_axis[data[6] >> 4].y);
+
+	for (i = 0; iforce->type->btn[i] >= 0; i++)
+		input_report_key(dev, iforce->type->btn[i],
+				 data[(i >> 3) + 5] & (1 << (i & 7)));
+
+	/* If there are untouched bits left, interpret them as the second hat */
+	if (i <= 8) {
+		u8 btns = data[6];
+
+		if (test_bit(ABS_HAT1X, dev->absbit)) {
+			if (btns & BIT(3))
+				input_report_abs(dev, ABS_HAT1X, -1);
+			else if (btns & BIT(1))
+				input_report_abs(dev, ABS_HAT1X, 1);
+			else
+				input_report_abs(dev, ABS_HAT1X, 0);
+		}
+
+		if (test_bit(ABS_HAT1Y, dev->absbit)) {
+			if (btns & BIT(0))
+				input_report_abs(dev, ABS_HAT1Y, -1);
+			else if (btns & BIT(2))
+				input_report_abs(dev, ABS_HAT1Y, 1);
+			else
+				input_report_abs(dev, ABS_HAT1Y, 0);
+		}
+	}
+}
+
+void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
+{
+	struct input_dev *dev = iforce->dev;
+	int i, j;
+
 	wake_up(&iforce->wait);
 
 	if (!iforce->type)
@@ -143,48 +179,26 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 	switch (HI(cmd)) {
 
 	case 0x01:	/* joystick position data */
-	case 0x03:	/* wheel position data */
-		if (HI(cmd) == 1) {
-			input_report_abs(dev, ABS_X, (__s16) (((__s16)data[1] << 8) | data[0]));
-			input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[3] << 8) | data[2]));
-			input_report_abs(dev, ABS_THROTTLE, 255 - data[4]);
-			if (LO(cmd) >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
-				input_report_abs(dev, ABS_RUDDER, (__s8)data[7]);
-		} else {
-			input_report_abs(dev, ABS_WHEEL, (__s16) (((__s16)data[1] << 8) | data[0]));
-			input_report_abs(dev, ABS_GAS,   255 - data[2]);
-			input_report_abs(dev, ABS_BRAKE, 255 - data[3]);
-		}
+		input_report_abs(dev, ABS_X, (__s16) (((__s16)data[1] << 8) | data[0]));
+		input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[3] << 8) | data[2]));
+		input_report_abs(dev, ABS_THROTTLE, 255 - data[4]);
 
-		input_report_abs(dev, ABS_HAT0X, iforce_hat_to_axis[data[6] >> 4].x);
-		input_report_abs(dev, ABS_HAT0Y, iforce_hat_to_axis[data[6] >> 4].y);
-
-		for (i = 0; iforce->type->btn[i] >= 0; i++)
-			input_report_key(dev, iforce->type->btn[i], data[(i >> 3) + 5] & (1 << (i & 7)));
-
-		/* If there are untouched bits left, interpret them as the second hat */
-		if (i <= 8) {
-			int btns = data[6];
-			if (test_bit(ABS_HAT1X, dev->absbit)) {
-				if (btns & 8)
-					input_report_abs(dev, ABS_HAT1X, -1);
-				else if (btns & 2)
-					input_report_abs(dev, ABS_HAT1X, 1);
-				else
-					input_report_abs(dev, ABS_HAT1X, 0);
-			}
-			if (test_bit(ABS_HAT1Y, dev->absbit)) {
-				if (btns & 1)
-					input_report_abs(dev, ABS_HAT1Y, -1);
-				else if (btns & 4)
-					input_report_abs(dev, ABS_HAT1Y, 1);
-				else
-					input_report_abs(dev, ABS_HAT1Y, 0);
-			}
-		}
+		if (LO(cmd) >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
+			input_report_abs(dev, ABS_RUDDER, (__s8)data[7]);
+
+		iforce_report_hats_buttons(iforce, data);
 
 		input_sync(dev);
+		break;
 
+	case 0x03:	/* wheel position data */
+		input_report_abs(dev, ABS_WHEEL, (__s16) (((__s16)data[1] << 8) | data[0]));
+		input_report_abs(dev, ABS_GAS,   255 - data[2]);
+		input_report_abs(dev, ABS_BRAKE, 255 - data[3]);
+
+		iforce_report_hats_buttons(iforce, data);
+
+		input_sync(dev);
 		break;
 
 	case 0x02:	/* status report */
@@ -202,11 +216,10 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 			/* Report stop event */
 			input_report_ff_status(dev, i, FF_STATUS_STOPPED);
 		}
-		if (LO(cmd) > 3) {
-			int j;
-			for (j = 3; j < LO(cmd); j += 2)
-				mark_core_as_ready(iforce, data[j] | (data[j+1]<<8));
-		}
+
+		for (j = 3; j < LO(cmd); j += 2)
+			mark_core_as_ready(iforce, data[j] | (data[j + 1] << 8));
+
 		break;
 	}
 }
-- 
2.19.0.397.gdd90340f6a-goog

