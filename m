Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F93C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C7821855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KPqiIjRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfAWU5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:57:52 -0500
Received: from mail-ua1-f74.google.com ([209.85.222.74]:51405 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfAWU5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:57:42 -0500
Received: by mail-ua1-f74.google.com with SMTP id j14so212953uap.18
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 12:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NfnIiqmrqgT5KkxLxxzewrtxoVbG/bYu9guRRR7bbjU=;
        b=KPqiIjRi2oveYkiaVkE64/05N0OfazIQ7G3qWcDpZyGc7qHQNDpUOzJdgxevZaOG6c
         wZaB0wdsfLo3/Xy4qtBeilfG+pDYBhoUWdjqy32DL/2mh8f05FDv9eYxEg420IUXzM+F
         fh3Yzclze2YCvGliykQW9j/dvAf/ZAiK2jQ5gDKgS5ph8ZJsnBJjEZRxPpa4MYjYTnsK
         1/auDG+3oydmqLRYLEBXZi9cgjRq5thcQhqBS0jcA3s/7O3zG/4im1ydLvA5ugLcYecx
         EqIy6uKzY7MHNkxNTNKfsxYxzzcpmYn4zRB5ufMdX2xuKE4NSWZrkrzNST+Z4j6TFR9R
         8j5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NfnIiqmrqgT5KkxLxxzewrtxoVbG/bYu9guRRR7bbjU=;
        b=PGW8cGFBd5PSBua26Fao/pMx2ssv0RnJK8YPjYg4Fydo6RE6SLqiiyzl5gjuEL5B/O
         QvNqudCcm6A+YJtPM2x5aX2c9aShsw2Ok231MgeSrY/TnLwrYyjc2nQU0Icn65ijOF+G
         SN1KDpZdRSpK4TlE/9DmiGGI4lskYELGTGwt1GlmARkKJz7cLnT4JxuihqXNc+y2XK8A
         U1RmAksnlqZmx6/Rdlw0K0LnbaJheH9AyoRdJrofSShxvC3RboZoFm3mU8gXE75CZIIm
         VfEYia00F23M/tlbTlq0xue7GkrYmNJ94rTauFN+muuSIu88gP8/hQnITd0ym41Y15mr
         tbDw==
X-Gm-Message-State: AJcUukfQdWDZc1UNUp/T92GZA6SRWEBVEAxgCTTipAcvFNhJmMc7vkcF
        whg7cuLLM5Mw7Hbpr4ZIxToQrK+F99cO
X-Google-Smtp-Source: ALg8bN5IexxK6W7en1oWzrXdWLGC7CJ6WXC2viDjFkUWF63bba/OpTd1sz3zh4ygKP3CaArBgwcOP99dN9f8
X-Received: by 2002:a67:e218:: with SMTP id g24mr3057516vsa.2.1548277061160;
 Wed, 23 Jan 2019 12:57:41 -0800 (PST)
Date:   Wed, 23 Jan 2019 12:57:25 -0800
In-Reply-To: <20190123205725.239661-1-rajatja@google.com>
Message-Id: <20190123205725.239661-4-rajatja@google.com>
Mime-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20190123205725.239661-1-rajatja@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v5 4/4] Bluetooth: btusb: Use the cmd_timeout method to reset
 the Intel BT chip
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

If the platform provides it, use the reset gpio to reset the Intel BT
chip, as part of cmd_timeout handling. This has been found helpful on
Intel bluetooth controllers where the firmware gets stuck and the only
way out is a hard reset pin provided by the platform.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v5: Rename the hook to cmd_timeout, and wait for 5 timeouts before
    resetting the device.
v4: Use data->flags instead of clearing the quirk in btusb_hw_reset()
v3: Better error handling for gpiod_get_optional()
v2: Handle the EPROBE_DEFER case.

 drivers/bluetooth/btusb.c | 54 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4761499db9ee..8949ea30a1bc 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -29,6 +29,7 @@
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/suspend.h>
+#include <linux/gpio/consumer.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -439,6 +440,7 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
 #define BTUSB_BOOTING		9
 #define BTUSB_DIAG_RUNNING	10
 #define BTUSB_OOB_WAKE_ENABLED	11
+#define BTUSB_HW_RESET_ACTIVE	12
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -476,6 +478,8 @@ struct btusb_data {
 	struct usb_endpoint_descriptor *diag_tx_ep;
 	struct usb_endpoint_descriptor *diag_rx_ep;
 
+	struct gpio_desc *reset_gpio;
+
 	__u8 cmdreq_type;
 	__u8 cmdreq;
 
@@ -489,8 +493,39 @@ struct btusb_data {
 	int (*setup_on_usb)(struct hci_dev *hdev);
 
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
+	unsigned num_cmd_timeout;
 };
 
+
+static void btusb_intel_cmd_timeout(struct hci_dev *hdev,
+				    struct hci_command_hdr *cmd)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct gpio_desc *reset_gpio = data->reset_gpio;
+
+	bt_dev_err(hdev, "btusb num_cmd_timeout = %u", ++data->num_cmd_timeout);
+
+	if (data->num_cmd_timeout < 5)
+		return;
+
+	/*
+	 * Toggle the hard reset line if the platform provides one. The reset
+	 * is going to yank the device off the USB and then replug. So doing
+	 * once is enough. The cleanup is handled correctly on the way out
+	 * (standard USB disconnect), and the new device is detected cleanly
+	 * and bound to the driver again like it should be.
+	 */
+	if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
+		bt_dev_err(hdev, "last reset failed? Not resetting again");
+		return;
+	}
+
+	bt_dev_err(hdev, "Initiating HW reset via gpio");
+	gpiod_set_value(reset_gpio, 1);
+	mdelay(100);
+	gpiod_set_value(reset_gpio, 0);
+}
+
 static inline void btusb_free_frags(struct btusb_data *data)
 {
 	unsigned long flags;
@@ -2915,6 +2950,7 @@ static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
 	struct usb_endpoint_descriptor *ep_desc;
+	struct gpio_desc *reset_gpio;
 	struct btusb_data *data;
 	struct hci_dev *hdev;
 	unsigned ifnum_base;
@@ -3028,6 +3064,15 @@ static int btusb_probe(struct usb_interface *intf,
 
 	SET_HCIDEV_DEV(hdev, &intf->dev);
 
+	reset_gpio = gpiod_get_optional(&data->udev->dev, "reset",
+					GPIOD_OUT_LOW);
+	if (IS_ERR(reset_gpio)) {
+		err = PTR_ERR(reset_gpio);
+		goto out_free_dev;
+	} else if (reset_gpio) {
+		data->reset_gpio = reset_gpio;
+	}
+
 	hdev->open   = btusb_open;
 	hdev->close  = btusb_close;
 	hdev->flush  = btusb_flush;
@@ -3085,6 +3130,8 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
+		if (data->reset_gpio)
+			hdev->cmd_timeout = btusb_intel_cmd_timeout;
 	}
 
 	if (id->driver_info & BTUSB_INTEL_NEW) {
@@ -3097,6 +3144,8 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
+		if (data->reset_gpio)
+			hdev->cmd_timeout = btusb_intel_cmd_timeout;
 	}
 
 	if (id->driver_info & BTUSB_MARVELL)
@@ -3226,6 +3275,8 @@ static int btusb_probe(struct usb_interface *intf,
 	return 0;
 
 out_free_dev:
+	if (data->reset_gpio)
+		gpiod_put(data->reset_gpio);
 	hci_free_dev(hdev);
 	return err;
 }
@@ -3269,6 +3320,9 @@ static void btusb_disconnect(struct usb_interface *intf)
 	if (data->oob_wake_irq)
 		device_init_wakeup(&data->udev->dev, false);
 
+	if (data->reset_gpio)
+		gpiod_put(data->reset_gpio);
+
 	hci_free_dev(hdev);
 }
 
-- 
2.20.1.321.g9e740568ce-goog

