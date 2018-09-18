Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A16ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4668214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6NCvhRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4668214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbeIRGSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:18:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47033 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbeIRGSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:18:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id b129-v6so94380pga.13;
        Mon, 17 Sep 2018 17:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UXrwtXVoYP6FYwFbk7hnJYf0IXCoVIxfi4PArWLBiD4=;
        b=Z6NCvhRNigWiw13uGK69CU+GOsyJ6JRZEObwgss8AFL912Qf5U9/v8C2jA4e7aPPtp
         5P4xAtQaemGRtzRWUTBKcfVbUdpMWvYwhXIAOpWSpc/WzqTB2eUFjIA9UbLXbnjnl3Z0
         NUZEye9qAb37MpFso1uLpQuaOqfWiZZpCnRIjKbjrTrN5TTDf1vEf1MbdSsCt98ur0V+
         zalJ5LPZU/A6PojKodG11NqIrZewX5DfyKce603eRgcTwx4u58HqoE1keFhJTty78BYf
         4l2sp7QtQCSS4NE4H5X9aoEtyKI0NVoF+d2aNKXcgF0V5TVtmXUioUwuT1A3AHh5kj/X
         NQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UXrwtXVoYP6FYwFbk7hnJYf0IXCoVIxfi4PArWLBiD4=;
        b=b1h/a3jK7bzPWObK2VDmszAkU4b0cv2EjTCK5ohJmqIiyHHK8Z1YX1Vfqmq/FS7JMv
         +OMlE3km2Wr/2LQXReEy46Mz6Qcb0qTKeCmAJ/K7A7lp+x7ExiwqrBMAZuJf145djf9P
         ovqpH/ssgHXzRNJKc0UoG6Xut78MjNMVCbVc1fpiqP5zTy6pvgK74O5W3l/9xSx+O6hl
         +TaMzXJ8DCzxQfQFVBHB5nuz6e52rca+4SHeak0r+X9ZRtetbiplBaUvR0/MsLkuxwtF
         Yc8oLDsgNpV+xqtz0rubyTr6LaVuDV/+ErRRihOfa3IojCzWJehHidvwhAT1bfZhYJpl
         MToA==
X-Gm-Message-State: APzg51DCSe1UQxLJOUEYeIKaChVxpsDh7ok4jyzyytqqBKeMtzWCIvPu
        kTxF9gB6Xn/ovq9ysgN2XFW8KHlA
X-Google-Smtp-Source: ANB0VdZ0DhUm0ch+CQpWjyWqnQiR8qONN4dC610U1HN47NYz1nvlUjPeE2e5pjxS33NECVdOnypqMA==
X-Received: by 2002:a63:f902:: with SMTP id h2-v6mr25541742pgi.154.1537231685874;
        Mon, 17 Sep 2018 17:48:05 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w69-v6sm26053316pgd.37.2018.09.17.17.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:48:04 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 20/20] Input: iforce - use unaligned accessors, where appropriate
Date:   Mon, 17 Sep 2018 17:47:32 -0700
Message-Id: <20180918004732.9875-20-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of open-coding conversion from/to little-endian, let's
use proper accessors.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-main.c    |  7 ++++---
 drivers/input/joystick/iforce/iforce-packets.c | 12 ++++++++----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index 5cb3e80f4e0d..d696b0b653b6 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -21,6 +21,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
+#include <asm/unaligned.h>
 #include "iforce.h"
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>, Johann Deneux <johann.deneux@gmail.com>");
@@ -286,17 +287,17 @@ int iforce_init_device(struct device *parent, u16 bustype,
  */
 
 	if (!iforce_get_id_packet(iforce, 'M', buf, &len) || len < 3)
-		input_dev->id.vendor = (buf[2] << 8) | buf[1];
+		input_dev->id.vendor = get_unaligned_le16(buf + 1);
 	else
 		dev_warn(&iforce->dev->dev, "Device does not respond to id packet M\n");
 
 	if (!iforce_get_id_packet(iforce, 'P', buf, &len) || len < 3)
-		input_dev->id.product = (buf[2] << 8) | buf[1];
+		input_dev->id.product = get_unaligned_le16(buf + 1);
 	else
 		dev_warn(&iforce->dev->dev, "Device does not respond to id packet P\n");
 
 	if (!iforce_get_id_packet(iforce, 'B', buf, &len) || len < 3)
-		iforce->device_memory.end = (buf[2] << 8) | buf[1];
+		iforce->device_memory.end = get_unaligned_le16(buf + 1);
 	else
 		dev_warn(&iforce->dev->dev, "Device does not respond to id packet B\n");
 
diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index 976ec1c7cf15..76c4475740ab 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -21,6 +21,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
+#include <asm/unaligned.h>
 #include "iforce.h"
 
 static struct {
@@ -175,8 +176,10 @@ void iforce_process_packet(struct iforce *iforce,
 	switch (packet_id) {
 
 	case 0x01:	/* joystick position data */
-		input_report_abs(dev, ABS_X, (__s16) (((__s16)data[1] << 8) | data[0]));
-		input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[3] << 8) | data[2]));
+		input_report_abs(dev, ABS_X,
+				 (__s16) get_unaligned_le16(data));
+		input_report_abs(dev, ABS_Y,
+				 (__s16) get_unaligned_le16(data + 2));
 		input_report_abs(dev, ABS_THROTTLE, 255 - data[4]);
 
 		if (len >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
@@ -188,7 +191,8 @@ void iforce_process_packet(struct iforce *iforce,
 		break;
 
 	case 0x03:	/* wheel position data */
-		input_report_abs(dev, ABS_WHEEL, (__s16) (((__s16)data[1] << 8) | data[0]));
+		input_report_abs(dev, ABS_WHEEL,
+				 (__s16) get_unaligned_le16(data));
 		input_report_abs(dev, ABS_GAS,   255 - data[2]);
 		input_report_abs(dev, ABS_BRAKE, 255 - data[3]);
 
@@ -214,7 +218,7 @@ void iforce_process_packet(struct iforce *iforce,
 		}
 
 		for (j = 3; j < len; j += 2)
-			mark_core_as_ready(iforce, data[j] | (data[j + 1] << 8));
+			mark_core_as_ready(iforce, get_unaligned_le16(data + j));
 
 		break;
 	}
-- 
2.19.0.397.gdd90340f6a-goog

