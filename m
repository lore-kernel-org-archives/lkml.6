Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CBEC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCA42086B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nlgihIct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DCA42086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbeKQLXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 06:23:05 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:37917 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731090AbeKQLXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 06:23:01 -0500
Received: by mail-qk1-f202.google.com with SMTP id l7-v6so55655284qkd.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 17:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9Bz/gCkqSI0CecCt2g4/WTM1AOdDeQtvlngMweYYdmw=;
        b=nlgihIctGCne0mtlEThgsyUWNHtbhJpNh7Z49gDzmEhVdo/LQZm/OA/XsS3egMZ8FK
         G4chD8RmD72ekB+dcMRvjugvKGX0znbKqtkm69Ne0nKmGG0+0cLvlLb+Enzkwktv78+r
         +rqn5i+5tKs9Y5IvgtzuOQgqQQXY6NtRE96pr5NYtSMjsUhVH7giRhp+p/r0D/UgHkuI
         vV96C+IVoEiXhIZBO4pMTLfRRduH1miJBg8vIgkNV1t3KiQ5JXBYEgz/5qYYs+hL1djj
         eblAGBCjApClh1JtV7aC+fpNL04w0O72N+v3E9BigjIkCNoqPjyc/GFnZZY9imJxjIyi
         gF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9Bz/gCkqSI0CecCt2g4/WTM1AOdDeQtvlngMweYYdmw=;
        b=JKii2yEaWyVevX+3luspmk+4IcUZEHNRf5YSwAthBQdse1yi2WZEWX8qNQXbQJ4B3B
         3laErAozJevJ6TUdGmgfFsFEpQJ83+Y14QjikScTey25ef2l9zU++K3RGS6NMtt3GZQF
         sXh32AVD14igPSU8xmV4LLuBOT3WYa0DsC6tj7yKLcJsGkVY3ZZ5uPKzdnTZ63+ShehK
         ZGTBw0TxDxfwk03bvmC+/c++6hslSk4iJUswUkEP2Krj7Lc37g4Ug3pQVVKQcQWn9Q81
         OgAkfbevGMJ49KjiPtTufDKjsmawAfxXFJqAvfXgpehUXRNAZvUbguvWfoxOGrGxPGbs
         X5Lg==
X-Gm-Message-State: AA+aEWZ/ERnrc2QxmVmLbrhWaKR7YLnXPDQZVGvBbBMNrnZjxponv/4f
        Do7o0hP0JoOnuV+iCyoNDt6j8CMrXrHY
X-Google-Smtp-Source: AJdET5cv9bDoi1wGJAXcfLMtIHhqtws0JIoFPYKrXO1shBaaUzv1dsbUlXe3IOo1/i/vZTgPNyoTUETi1XLA
X-Received: by 2002:a37:fcd:: with SMTP id 74mr5130365qkp.11.1542416899291;
 Fri, 16 Nov 2018 17:08:19 -0800 (PST)
Date:   Fri, 16 Nov 2018 17:07:48 -0800
In-Reply-To: <20181117010748.24347-1-rajatja@google.com>
Message-Id: <20181117010748.24347-6-rajatja@google.com>
Mime-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 5/5] Bluetooth: btusb: Use the hw_reset method to allow
 resetting the BT chip
From:   Rajat Jain <rajatja@google.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Alex Hung <alex.hung@canonical.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org
Cc:     rajatxjain@gmail.com, dtor@google.com, raghuram.hegde@intel.com,
        chethan.tumkur.narayan@intel.com, sukumar.ghorai@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the platform provides it, use the reset gpio to reset the BT
chip (requested by the HCI core if needed). This has been found helpful
on some of Intel bluetooth controllers where the firmware gets stuck and
the only way out is a hard reset pin provided by the platform.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/bluetooth/btusb.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e8e148480c91..8aad02d9e211 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -29,6 +29,7 @@
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/suspend.h>
+#include <linux/gpio/consumer.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -475,6 +476,8 @@ struct btusb_data {
 	struct usb_endpoint_descriptor *diag_tx_ep;
 	struct usb_endpoint_descriptor *diag_rx_ep;
 
+	struct gpio_desc *reset_gpio;
+
 	__u8 cmdreq_type;
 	__u8 cmdreq;
 
@@ -490,6 +493,28 @@ struct btusb_data {
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
 };
 
+
+static void btusb_hw_reset(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct gpio_desc *reset_gpio = data->reset_gpio;
+
+	/*
+	 * Toggle the hard reset line if the platform provides one. The reset
+	 * is going to yank the device off the USB and then replug. So doing
+	 * once is enough. The cleanup is handled correctly on the way out
+	 * (standard USB disconnect), and the new device is detected cleanly
+	 * and bound to the driver again like it should be.
+	 */
+	if (reset_gpio) {
+		bt_dev_dbg(hdev, "%s: Initiating HW reset via gpio", __func__);
+		clear_bit(HCI_QUIRK_HW_RESET_ON_TIMEOUT, &hdev->quirks);
+		gpiod_set_value(reset_gpio, 1);
+		mdelay(100);
+		gpiod_set_value(reset_gpio, 0);
+	}
+}
+
 static inline void btusb_free_frags(struct btusb_data *data)
 {
 	unsigned long flags;
@@ -3030,6 +3055,11 @@ static int btusb_probe(struct usb_interface *intf,
 
 	SET_HCIDEV_DEV(hdev, &intf->dev);
 
+	data->reset_gpio = gpiod_get_optional(&data->udev->dev, "reset",
+					      GPIOD_OUT_LOW);
+	if (data->reset_gpio)
+		hdev->hw_reset = btusb_hw_reset;
+
 	hdev->open   = btusb_open;
 	hdev->close  = btusb_close;
 	hdev->flush  = btusb_flush;
@@ -3085,6 +3115,7 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
+		set_bit(HCI_QUIRK_HW_RESET_ON_TIMEOUT, &hdev->quirks);
 
 		if (id->driver_info & BTUSB_INTEL) {
 			hdev->setup = btusb_setup_intel;
@@ -3225,6 +3256,8 @@ static int btusb_probe(struct usb_interface *intf,
 	return 0;
 
 out_free_dev:
+	if (data->reset_gpio)
+		gpiod_put(data->reset_gpio);
 	hci_free_dev(hdev);
 	return err;
 }
@@ -3268,6 +3301,9 @@ static void btusb_disconnect(struct usb_interface *intf)
 	if (data->oob_wake_irq)
 		device_init_wakeup(&data->udev->dev, false);
 
+	if (data->reset_gpio)
+		gpiod_put(data->reset_gpio);
+
 	hci_free_dev(hdev);
 }
 
-- 
2.19.1.1215.g8438c0b245-goog

