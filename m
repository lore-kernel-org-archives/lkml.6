Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A79C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8CA218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cLMIDUAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfAXX2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 18:28:32 -0500
Received: from mail-ot1-f73.google.com ([209.85.210.73]:51100 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfAXX2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 18:28:31 -0500
Received: by mail-ot1-f73.google.com with SMTP id h4so2966316otg.17
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 15:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AyptAvfvM/wcW1EoZU8xDvJM9SOpx5lXxyZ/dg3vpOA=;
        b=cLMIDUAeUxUTQwen6ta2KO0L/aNMWhOUpqV7A2dhQbyNN/FXERU+DtaH0fgAA7Z4qr
         0zRuEQ8ZxgoEynTK+H0Dxa+tFt72i/BHUSxK+v4NXiyxMADPATUZNY5FIOZ1BKEoEaQL
         svKhFsx80KRknGu5UaqDkEiyjzKTjtNMkKusH7kUnTUvBkSel+FXl6p8B6H2ChZ7athf
         lpEjUfO40sMX7/YYBCIOZOMs0Fa4j1Kinnr/cdvE8XGV5jbEgVO2j70ViSESv2qlTkgL
         jkgZgbWlOGVqsQRubOrsDZmG3aIISY4ULCxaptq4ehEesvP3BBuf3hU79NNUI/OacB5O
         OetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AyptAvfvM/wcW1EoZU8xDvJM9SOpx5lXxyZ/dg3vpOA=;
        b=IuBO5WGZO4kDJrXSy/TYbur0opsxvaeFodEMrkLo50g+8jKeENnYV5pFGgnVDS2hDh
         PJjNEksGNSJevnPAqFRHoC4aq1oPvrf3h8l4GL0VOo1DqCDMyHAm49YoJIVHfzXQcjnX
         NT9cmWuEygWjuFxxn6enaD7z/J/Fpc4cySoUzDkNlhjj7bRf4gvgRx6t997aq9BSrcJA
         jWRQxuz8sYi05dudbimnygrHAAld1dD7e/TIomiDtiG5GWnJfGYuqyHI+10KuIk5Cmt6
         Gj/xA7a+G0WhMpko1/EGJJWhOFUyag8IAVsfEk2U7HXShyEHiCxHBawDfuFa3tRPiKad
         omtA==
X-Gm-Message-State: AJcUukeZuiUnHxbB7N4Y6Aq6XvZFz8nDqi9vVYrU/4GWCQpu88G1EXad
        0gbdHQcx6IIB8C5hVccT+lZveXqDi9FR
X-Google-Smtp-Source: ALg8bN4+/rvFAxXRPJdKuvtD6VUqqn8fJ80Cs1wKwE6x5hBQph3eFbxKCcmF5BttejzUtvidEsyyfgKx5DIJ
X-Received: by 2002:a9d:7f15:: with SMTP id j21mr6121444otq.71.1548372509988;
 Thu, 24 Jan 2019 15:28:29 -0800 (PST)
Date:   Thu, 24 Jan 2019 15:28:14 -0800
In-Reply-To: <20190124232814.252661-1-rajatja@google.com>
Message-Id: <20190124232814.252661-4-rajatja@google.com>
Mime-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20190124232814.252661-1-rajatja@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v6 4/4] Bluetooth: btusb: Use the cmd_timeout method to reset
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
v6: Move the cmd_timeout() hook assignment with other hooks, move the
    reset_gpio check in the timeout function.
v5: Rename the hook to cmd_timeout, and wait for 5 timeouts before
    resetting the device.
v4: Use data->flags instead of clearing the quirk in btusb_hw_reset()
v3: Better error handling for gpiod_get_optional()
v2: Handle the EPROBE_DEFER case.

 drivers/bluetooth/btusb.c | 54 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4761499db9ee..5de0c2e59b97 100644
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
 
@@ -489,8 +493,41 @@ struct btusb_data {
 	int (*setup_on_usb)(struct hci_dev *hdev);
 
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
+	unsigned cmd_timeout_cnt;
 };
 
+
+static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct gpio_desc *reset_gpio = data->reset_gpio;
+
+	if (++data->cmd_timeout_cnt < 5)
+		return;
+
+	if (!reset_gpio) {
+		bt_dev_err(hdev, "No way to reset. Ignoring and continuing");
+		return;
+	}
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
@@ -2915,6 +2952,7 @@ static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
 	struct usb_endpoint_descriptor *ep_desc;
+	struct gpio_desc *reset_gpio;
 	struct btusb_data *data;
 	struct hci_dev *hdev;
 	unsigned ifnum_base;
@@ -3028,6 +3066,15 @@ static int btusb_probe(struct usb_interface *intf,
 
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
@@ -3082,6 +3129,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->shutdown = btusb_shutdown_intel;
 		hdev->set_diag = btintel_set_diag_mfg;
 		hdev->set_bdaddr = btintel_set_bdaddr;
+		hdev->cmd_timeout = btusb_intel_cmd_timeout;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
@@ -3094,6 +3142,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->hw_error = btintel_hw_error;
 		hdev->set_diag = btintel_set_diag;
 		hdev->set_bdaddr = btintel_set_bdaddr;
+		hdev->cmd_timeout = btusb_intel_cmd_timeout;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
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

