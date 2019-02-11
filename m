Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4383DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4E721479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPu4YPw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfBKHAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:00:47 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42557 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfBKHAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:00:47 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so4547976pga.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 23:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iztFEfon4yD4EZwdqzN6BH/r2Qo+X5UZrt09IFZTxqs=;
        b=EPu4YPw8h9LOI9JT2kM02JWLtasDF7C92Wl/dPbv2ztNLKrSTiOnB31TP4t318u5Fh
         Q+N9sodkMl0kqTeiKFnLmWCZiLKJxTMFggMQLo67/F1gDmzuDuFs/lefG/BI5pQrLWQP
         ymrMeQX16ppGA+bN7S5X4/wlIRjgXZCZATv0vNQ0yPUSbll1d6CTfztA+1ydj+DcT2A6
         e+4hZBomktdj0uJo/tApCF6LT8lGH6j+GdzyP6XLgfZ+gJh+JmcifDI1vQXGQ8yhcXcu
         ++HS4ipFvjNMg2iUt6+fz8cFUqLfi2+Hik4LHlv2KxpZAxdk/PS9jHtqHudubFb1rU4J
         d1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iztFEfon4yD4EZwdqzN6BH/r2Qo+X5UZrt09IFZTxqs=;
        b=WkJYiDoglijBzNb/xvU8fpEod+ZW3ZpJolI9Pr7i6gvUHytkdEBPk6vzsTXfnZzPgs
         iAkqg4WbF6TZ0dAlNL/JQ9HVsWI4pd/PVizNPxZpkgYUpvk4356eerXW5cgMousvTx3l
         R0SWiu8UUkEIaIi++rRBb2Cma8ombLxo1SfEXXKdO9rcYuqcQ6TR6lMdojrDl8PJCvlG
         +PpD45w0Z0LQhjsXyymmhlAynbMDzg4hHdkqDIlmEsjTcx5TkzINauf7Kom5t/UvwpNf
         0OuaUZbMLm3i3qB30hBLPew7DH1aq25sLxMopr/DdxbNrUDfFa6uX3dQsOblrIRoJR3o
         D1OA==
X-Gm-Message-State: AHQUAuZf/5n5RN2qR8dqb1viOq8OVif+Ctg2zClSDc1tLISrSSv3IEsF
        aGVILY73123t3P+afmuc0B1HSJ5I
X-Google-Smtp-Source: AHgI3IbQDEwKIkXbBQu4/GMNDVWGkt9GBpcAuThoNDxxaSffSPHUe9yj6UDXub3Rsx7r17Qqj0V37w==
X-Received: by 2002:a62:1706:: with SMTP id 6mr4766266pfx.28.1549868445790;
        Sun, 10 Feb 2019 23:00:45 -0800 (PST)
Received: from localhost.localdomain (c-73-169-153-56.hsd1.wa.comcast.net. [73.169.153.56])
        by smtp.gmail.com with ESMTPSA id i74sm16370555pfi.33.2019.02.10.23.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 23:00:45 -0800 (PST)
From:   Jim Broadus <jbroadus@gmail.com>
To:     kai.heng.feng@canonical.com, benjamin.tissoires@gmail.com,
        jkosina@suse.cz, linux-kernel@vger.kernel.org
Cc:     Jim Broadus <jbroadus@gmail.com>
Subject: [PATCH] Fix resume for ELAN2097 touchscreen.
Date:   Sun, 10 Feb 2019 23:00:40 -0800
Message-Id: <20190211070040.4569-1-jbroadus@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 52cf93e63ee6 ("HID: i2c-hid: Don't reset device upon system resume")
fixes the resume behavior of several devices. However, this breaks the
resume on the ELAN2097, used on Dell Inspiron laptops, with the same flood
of messages:

[27009.817110] i2c_hid i2c-ELAN2097:00: i2c_hid_get_input: incomplete report (67/65535)
[27009.818867] i2c_hid i2c-ELAN2097:00: i2c_hid_get_input: incomplete report (67/65535)
[27009.820623] i2c_hid i2c-ELAN2097:00: i2c_hid_get_input: incomplete report (67/65535)

This change adds a new I2C_HID_QUIRK_RESET_AFTER_RESUME and replaces the
original reset behavior for this device.

Signed-off-by: Jim Broadus <jbroadus@gmail.com>
---
 drivers/hid/hid-ids.h              |  1 +
 drivers/hid/i2c-hid/i2c-hid-core.c | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 24f846d67478..38cc7033712a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -387,6 +387,7 @@
 #define USB_DEVICE_ID_TOSHIBA_CLICK_L9W	0x0401
 #define USB_DEVICE_ID_HP_X2		0x074d
 #define USB_DEVICE_ID_HP_X2_10_COVER	0x0755
+#define USB_DEVICE_ID_ELAN2097		0x2504
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index c5edfa966343..fdbad29b4406 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -50,6 +50,7 @@
 #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET	BIT(1)
 #define I2C_HID_QUIRK_NO_RUNTIME_PM		BIT(2)
 #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP		BIT(3)
+#define I2C_HID_QUIRK_RESET_AFTER_RESUME	BIT(4)
 
 /* flags */
 #define I2C_HID_STARTED		0
@@ -181,6 +182,8 @@ static const struct i2c_hid_quirks {
 		I2C_HID_QUIRK_NO_RUNTIME_PM },
 	{ I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01F0,
 		I2C_HID_QUIRK_NO_RUNTIME_PM },
+	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN2097,
+		 I2C_HID_QUIRK_RESET_AFTER_RESUME },
 	{ 0, 0 }
 };
 
@@ -1279,12 +1282,17 @@ static int i2c_hid_resume(struct device *dev)
 
 	enable_irq(client->irq);
 
-	/* Instead of resetting device, simply powers the device on. This
-	 * solves "incomplete reports" on Raydium devices 2386:3118 and
-	 * 2386:4B33 and fixes various SIS touchscreens no longer sending
-	 * data after a suspend/resume.
-	 */
-	ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
+	if (ihid->quirks & I2C_HID_QUIRK_RESET_AFTER_RESUME) {
+		ret = i2c_hid_hwreset(client);
+	} else {
+		/* Instead of resetting device, simply powers the device on.
+		 * This solves "incomplete reports" on Raydium devices 2386:3118
+		 * and 2386:4B33 and fixes various SIS touchscreens no longer
+		 * sending data after a suspend/resume.
+		 */
+		ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
+	}
+
 	if (ret)
 		return ret;
 
-- 
2.20.1

