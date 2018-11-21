Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6FEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA9F206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kAV5XAUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA9F206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403790AbeKVK1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:27:16 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:43660 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403773AbeKVK1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:27:15 -0500
Received: by mail-qt1-f201.google.com with SMTP id m37so4806189qte.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 15:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=49KNIZPrfArthj9ro1doAHEAjCBEwzm+6FuKhqdEH8Y=;
        b=kAV5XAUTMCOMF7BB20c0IuXEJl+JXkxU1jiix9TVaZss2RhqRQhlbB9HvQLVvNYDRW
         KGRSQsxCIQg0p7vVh3VMLlnmfHFMSZ9AR2K+KiU7rB9/1nOPuYKL0v4WdsZVOe7F1Zf/
         XZoxgFAXcDh4zqNKF4vjLmxdvVc4IsuP7QaicZ3lct2vQ4QR0e8XIE6Y7swNiKZ5agYh
         hNRMpJsi7CdTlsFnGLmkx7de77j+Y4oSyeeyT3AATktcPD/YpFZU3sEkqJjQ/Aoc9a/R
         Trsk2EOB38fiQj57i9Ghj6aGl1CSWs/fV0URG2erbmQHsmKcS222XFMcCjmKe0CkTwJm
         a59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=49KNIZPrfArthj9ro1doAHEAjCBEwzm+6FuKhqdEH8Y=;
        b=YnBbH8B8/3HQSYe6SQwlioxyVtMgOZiT6TOSv5MsS5fzROSgHZ7nRZB5BdQoatWBDX
         OACo4gsgBAeKCrTIQw0u+AwLtaQmtCHPsUfH4LSOL7C2noAtwdw8Yp8Ztp+0OOOk8OVe
         jJby8UVyqkK404yI3KOZVTGzMrZC7M9vAH698abaPMvhqf8KW2M4oRqhWwYl+R/PkBWb
         XxPEsrNqN6CgAvsqnmyxCpBiPxCVhgSoKLNkzJLfmQDogmaNHls503yQucWqBBi/FQt4
         rDg0TQDLc5+KZq+EfGltaUPrIZU8CE8AxWyv9F21tvrZTqx3ZgDDedjFtPJ7N4fekHcw
         cgPA==
X-Gm-Message-State: AA+aEWZgHpbMOb4whz0yYW+hs74+yhP5DNUcW+4GGz1iAr0qXzfh1f/W
        iLv+nrQErdai727rSn0sdRNnVjUGP/OB
X-Google-Smtp-Source: AFSGD/WnVgvVzCatQXeW5JG0m4sbonAQMQGPIW0trfOIVbOXlspNjZ8KgKkznzch9kg8XeWk5cQ+reOT/NZP
X-Received: by 2002:a0c:98c6:: with SMTP id g6mr5314556qvd.46.1542844238510;
 Wed, 21 Nov 2018 15:50:38 -0800 (PST)
Date:   Wed, 21 Nov 2018 15:50:20 -0800
In-Reply-To: <20181121235020.29461-1-rajatja@google.com>
Message-Id: <20181121235020.29461-5-rajatja@google.com>
Mime-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20181121235020.29461-1-rajatja@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH v3 5/5] Bluetooth: btusb: Use the hw_reset method to allow
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
v3: Better error handling for gpiod_get_optional()
v2: Handle the EPROBE_DEFER case.

 drivers/bluetooth/btusb.c | 40 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e8e148480c91..e7631f770fae 100644
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
 
@@ -490,6 +493,26 @@ struct btusb_data {
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
+	bt_dev_dbg(hdev, "%s: Initiating HW reset via gpio", __func__);
+	clear_bit(HCI_QUIRK_HW_RESET_ON_TIMEOUT, &hdev->quirks);
+	gpiod_set_value(reset_gpio, 1);
+	mdelay(100);
+	gpiod_set_value(reset_gpio, 0);
+}
+
 static inline void btusb_free_frags(struct btusb_data *data)
 {
 	unsigned long flags;
@@ -2917,6 +2940,7 @@ static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
 	struct usb_endpoint_descriptor *ep_desc;
+	struct gpio_desc *reset_gpio;
 	struct btusb_data *data;
 	struct hci_dev *hdev;
 	unsigned ifnum_base;
@@ -3030,6 +3054,16 @@ static int btusb_probe(struct usb_interface *intf,
 
 	SET_HCIDEV_DEV(hdev, &intf->dev);
 
+	reset_gpio = gpiod_get_optional(&data->udev->dev, "reset",
+					GPIOD_OUT_LOW);
+	if (IS_ERR(reset_gpio)) {
+		err = PTR_ERR(reset_gpio);
+		goto out_free_dev;
+	} else if (reset_gpio) {
+		data->reset_gpio = reset_gpio;
+		hdev->hw_reset = btusb_hw_reset;
+	}
+
 	hdev->open   = btusb_open;
 	hdev->close  = btusb_close;
 	hdev->flush  = btusb_flush;
@@ -3085,6 +3119,7 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
+		set_bit(HCI_QUIRK_HW_RESET_ON_TIMEOUT, &hdev->quirks);
 
 		if (id->driver_info & BTUSB_INTEL) {
 			hdev->setup = btusb_setup_intel;
@@ -3225,6 +3260,8 @@ static int btusb_probe(struct usb_interface *intf,
 	return 0;
 
 out_free_dev:
+	if (data->reset_gpio)
+		gpiod_put(data->reset_gpio);
 	hci_free_dev(hdev);
 	return err;
 }
@@ -3268,6 +3305,9 @@ static void btusb_disconnect(struct usb_interface *intf)
 	if (data->oob_wake_irq)
 		device_init_wakeup(&data->udev->dev, false);
 
+	if (data->reset_gpio)
+		gpiod_put(data->reset_gpio);
+
 	hci_free_dev(hdev);
 }
 
-- 
2.19.1.1215.g8438c0b245-goog

