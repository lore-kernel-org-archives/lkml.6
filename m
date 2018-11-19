Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7362C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5E32080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lOk71o3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5E32080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbeKTJaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:30:35 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:49391 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732135AbeKTJae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:30:34 -0500
Received: by mail-qk1-f201.google.com with SMTP id c7so72158649qkg.16
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 15:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uunCudW0fot0kDo/jeeOPd18t40N78uRVjkv0yBK6zA=;
        b=lOk71o3NxeCWm9bJNYIMXN4I+aUUIwxSptyVPuHV8z2duzNewaXh2mGFbrBapiNHv1
         6IoabAVkJ7Ygx/OOSZW7nEtTI4265YnShh/Fgvb2cOuIglufftZhJIfHmlXoSgsmlxAp
         CRuWiJwoFJ9k5DXpEK27kw1Dm4VQQWt6xIFScQ7DFtp7bezYqbSgfbVdzQxWxNrZU1wd
         xX77LONY/tQudNeE2p4z7BDhq+kryGu9LvFqRKDlSAn1EamPfaWuRpk+ZKlKq1BkL4ro
         j+wYkD/AO4eHKPDw7dSv2tvx11WfxlOEraEHtHamUaN5V042vG7Azob0gWNP1IWbZErl
         1DcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uunCudW0fot0kDo/jeeOPd18t40N78uRVjkv0yBK6zA=;
        b=Sa2HjHJFHNCOOapPV+P5aRL87ePWIV1hSIBDj5DjLorEh010LKqRS/i5drad80yzp9
         crbfj7DVBfuaekZsS08sFR4mCB4TDaLTo0yuWSqe3Mh373gktlM57Cv9b1t3/enjdq7j
         AvKsm+dcXVUaxyYRbXAsrJ2HN/cTujGAJDb+KLX+vQO8P3N/WOmDFLxFiH/azCMZDrMs
         XSggJ+rbqWsqB+t+SZ/+NAXFht8nqUIK009KEHFeBjxD0XGEiFYpP9CD3YtJ+ygI+TFq
         F80gpSlDKT4vvf4m3/21GtIw1B1OprTLnG1Xvd5O5Lhk5cymZ9RSD7kbkS1aBsDdbO0H
         dN+w==
X-Gm-Message-State: AA+aEWZ0BvsCXDUdHv/ev4sTtgajH/Z75kn/R5NpGAb+mdiz97Q7Iu5Z
        OhurGg6pQKofw8XHtWML7S7uyAE6PuTv
X-Google-Smtp-Source: AFSGD/UmypK1BXBSOWjH9ly9xBG5GYKA/SVJn/QG/4r71X12BbayHM465co2I8oBcCyTQt+PcqR5+6BN3iyf
X-Received: by 2002:ac8:17af:: with SMTP id o44mr12329594qtj.24.1542668676210;
 Mon, 19 Nov 2018 15:04:36 -0800 (PST)
Date:   Mon, 19 Nov 2018 15:04:09 -0800
In-Reply-To: <20181119230409.258121-1-rajatja@google.com>
Message-Id: <20181119230409.258121-5-rajatja@google.com>
Mime-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20181119230409.258121-1-rajatja@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH v2 5/5] Bluetooth: btusb: Use the hw_reset method to allow
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
v2: Handle the EPROBE_DEFER case.

 drivers/bluetooth/btusb.c | 42 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e8e148480c91..bf522cfe68c1 100644
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
@@ -2917,6 +2942,7 @@ static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
 	struct usb_endpoint_descriptor *ep_desc;
+	struct gpio_desc *reset_gpio;
 	struct btusb_data *data;
 	struct hci_dev *hdev;
 	unsigned ifnum_base;
@@ -3030,6 +3056,16 @@ static int btusb_probe(struct usb_interface *intf,
 
 	SET_HCIDEV_DEV(hdev, &intf->dev);
 
+	reset_gpio = gpiod_get_optional(&data->udev->dev, "reset",
+					GPIOD_OUT_LOW);
+	if (PTR_ERR(reset_gpio) == -EPROBE_DEFER) {
+		err = -EPROBE_DEFER;
+		goto out_free_dev;
+	} else if (!IS_ERR(reset_gpio)) {
+		data->reset_gpio = reset_gpio;
+		hdev->hw_reset = btusb_hw_reset;
+	}
+
 	hdev->open   = btusb_open;
 	hdev->close  = btusb_close;
 	hdev->flush  = btusb_flush;
@@ -3085,6 +3121,7 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
+		set_bit(HCI_QUIRK_HW_RESET_ON_TIMEOUT, &hdev->quirks);
 
 		if (id->driver_info & BTUSB_INTEL) {
 			hdev->setup = btusb_setup_intel;
@@ -3225,6 +3262,8 @@ static int btusb_probe(struct usb_interface *intf,
 	return 0;
 
 out_free_dev:
+	if (data->reset_gpio)
+		gpiod_put(data->reset_gpio);
 	hci_free_dev(hdev);
 	return err;
 }
@@ -3268,6 +3307,9 @@ static void btusb_disconnect(struct usb_interface *intf)
 	if (data->oob_wake_irq)
 		device_init_wakeup(&data->udev->dev, false);
 
+	if (data->reset_gpio)
+		gpiod_put(data->reset_gpio);
+
 	hci_free_dev(hdev);
 }
 
-- 
2.19.1.1215.g8438c0b245-goog

