Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3D3C0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993AA218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEPRLoTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436722AbfBMVNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:13:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42836 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfBMVNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:13:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id l7-v6so3286993ljg.9;
        Wed, 13 Feb 2019 13:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SuPZp0PA0NSVsevbzzHn4l4X9J3aVFHlrQvuB9cAKfs=;
        b=JEPRLoTKUaaP84kKrr6isW/tshw9CPpML7GZh1Wz8/ygCZBMSN+ZQ2hfNqc2cfxy13
         yXZ1BCwxVkECnrYFjJla8x7IgGzDD0MzcTXnh5s/n+sPHkAqmDnsS714olv/2UrZOExY
         HYXHpw5gGcJANDYZdJhjCFrbGYtQqaD+CBAY9pR9k1154LOw5XEG/V4wL1Vv2Cflwglv
         Rz1J0BVjdKXkOSvx8IS5HoXiCoIODS7/yhjQctBJ19/zJh7uoQ54lH+vd36xLXK75vUY
         Uuqjv5D+312WlM8VbiJCR9Y4qr4BAAojSwBXf6Q8m278dWaQoBYyHjFA/hEUrHftt9dh
         ZthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SuPZp0PA0NSVsevbzzHn4l4X9J3aVFHlrQvuB9cAKfs=;
        b=fB1GjvhoaJah6iXs4JTnrTxwecH5Fm82Drubo6SRLqYjxVwqW+jtLWyscdNaVadxcE
         GISHJOm4FeJvJJEG5O9u7T4eRASB5tRoIvzZfqah/tsF8lKdZEAs8iVoSSZPBzZWFkic
         dOn8zdRgKqH00UQCDN6hxsmQJ7nVtZkjniI0ELsldbgjJ8E+kIKrVlNPeUr33NIQMAnv
         5q3oXtyUBD+b1py6Qcmq3SRtKarbWTwWGYBui12giwozNJdXdZCEg/XkI/8n8SR//P65
         pbcycAjz8H5l1LRuvPB3fEOnYXi5W9Uc34E/4vLUdtZfmGoWCHGdKmFYW4gycOUHeo5v
         GEAQ==
X-Gm-Message-State: AHQUAuYcSYHQmU1e4aezRZKO9Qrbvv9ceBsGvsWDBMPWgMwavyH7ruf1
        1gJ1FEJg17J7/kVFSrgcj7LJ9NTJwHM=
X-Google-Smtp-Source: AHgI3IalxlobjrAHBSHi7wBmcfyj4YcVIU+SWTFLf2qHscrRU7nRjHGM8bXdfNRIhQv+TC5mm2PWuQ==
X-Received: by 2002:a2e:a0cb:: with SMTP id f11mr106374ljm.55.1550092423691;
        Wed, 13 Feb 2019 13:13:43 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-226-91.is74.ru. [109.191.226.91])
        by smtp.gmail.com with ESMTPSA id p77-v6sm83857lja.0.2019.02.13.13.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 13:13:43 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Martin Liu <liumartin@google.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Benson Leung <bleung@chromium.org>,
        Harry Pan <harry.pan@intel.com>,
        Jack Stocker <jackstocker.93@gmail.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        Samuel Sadok <samuel.sadok@bluewin.ch>,
        Ivan Mironov <mironov.ivan@gmail.com>
Subject: [RFC PATCH 1/2] usb: core: Add support of disabling SS link before system suspend
Date:   Thu, 14 Feb 2019 02:13:22 +0500
Message-Id: <20190213211323.6072-2-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213211323.6072-1-mironov.ivan@gmail.com>
References: <20190213211323.6072-1-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Apple MacBooks contain internal SD card reader connected to the USB
3.0 bus. Example: MacBook Pro Retina mid 2015, which contains USB card
reader with ID 05ac:8406.

Currently, such card reader works only after a reboot and completely
disappears from system after the first system suspend/resume cycle.
Also, any subsequent attempts to suspend are starting to fail.

There is a known way to circumvent the suspend problem: removing device
using /sys/devices/*/*/usb*/*-*/remove helps. But this unbreaks only
suspend, not the card reader itself (it remains absent).

When trying to fix both suspend and card reader device, I found that the
only working method is to set link state to disabled during suspend
procedure.

This patch adds new quirk for USB devices:
USB_QUIRK_DISABLE_LINK_ON_SUSPEND. When enabled, it changes the usual
suspend procedure for USB 3.0 devices by setting link state to DISABLED
instead of U3. To "resume" from disabled state, new code sets link state
to RX_DETECT and also enables reset for device.

As usual, this quirk may be enabled manually by adding
'usbcore.quirks=$VID:$PID:p' to the kernel parameters.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=111201
Link: https://bugzilla.kernel.org/show_bug.cgi?id=202509
Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
---
 drivers/usb/core/driver.c  |  6 +++
 drivers/usb/core/hub.c     | 84 ++++++++++++++++++++++++++++++++++++--
 drivers/usb/core/quirks.c  |  3 ++
 include/linux/usb.h        |  3 ++
 include/linux/usb/quirks.h |  9 ++++
 5 files changed, 101 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 53564386ed57..1a1ee1ba7a63 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1145,6 +1145,10 @@ static int usb_suspend_device(struct usb_device *udev, pm_message_t msg)
 			udev->state == USB_STATE_SUSPENDED)
 		goto done;
 
+	if (!PMSG_IS_AUTO(msg) &&
+			(udev->quirks & USB_QUIRK_DISABLE_LINK_ON_SUSPEND))
+		udev->disable_link_on_suspend = 1;
+
 	/* For devices that don't have a driver, we do a generic suspend. */
 	if (udev->dev.driver)
 		udriver = to_usb_device_driver(udev->dev.driver);
@@ -1188,6 +1192,8 @@ static int usb_resume_device(struct usb_device *udev, pm_message_t msg)
 
  done:
 	dev_vdbg(&udev->dev, "%s: status %d\n", __func__, status);
+	if (!status)
+		udev->disable_link_on_suspend = 0;
 	return status;
 }
 
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 1d1e61e980f3..c2e4e23500d3 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3230,8 +3230,22 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
 			goto err_ltm;
 	}
 
+	if (udev->disable_link_on_suspend && !hub_is_superspeed(hub->hdev)) {
+		dev_dbg(&udev->dev,
+				"disabling link unsupported on <USB 3.0\n");
+		udev->disable_link_on_suspend = 0;
+	}
+
+	if (udev->disable_link_on_suspend) {
+		status = hub_set_port_link_state(hub, port1,
+				USB_SS_PORT_LS_SS_DISABLED);
+		if (status) {
+			dev_dbg(&port_dev->dev, "can't disable link\n");
+			udev->disable_link_on_suspend = 0;
+		}
+	}
 	/* see 7.1.7.6 */
-	if (hub_is_superspeed(hub->hdev))
+	else if (hub_is_superspeed(hub->hdev))
 		status = hub_set_port_link_state(hub, port1, USB_SS_PORT_LS_U3);
 
 	/*
@@ -3431,6 +3445,32 @@ static int wait_for_connected(struct usb_device *udev,
 	return status;
 }
 
+static int wait_for_link(struct usb_device *udev,
+		struct usb_hub *hub, int port1,
+		u16 *portchange, u16 *portstatus)
+{
+	int status = 0, delay_ms = 0;
+
+	while (delay_ms < 2000) {
+		status = hub_port_status(hub, port1, portstatus, portchange);
+
+		if (status || ((*portstatus & USB_PORT_STAT_LINK_STATE) ==
+					USB_SS_PORT_LS_POLLING) ||
+				(*portstatus & USB_PORT_STAT_CONNECTION))
+			break;
+
+		msleep(20);
+		delay_ms += 20;
+	}
+	dev_dbg(&udev->dev, "waited %dms for link, status %d\n", delay_ms,
+			status);
+
+	if (delay_ms >= 2000)
+		status = -ENODEV;
+
+	return status;
+}
+
 /*
  * usb_port_resume - re-activate a suspended usb device's upstream port
  * @udev: device to re-activate, not a root hub
@@ -3484,8 +3524,43 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
 
 	usb_lock_port(port_dev);
 
-	/* Skip the initial Clear-Suspend step for a remote wakeup */
 	status = hub_port_status(hub, port1, &portstatus, &portchange);
+	if (status)
+		dev_dbg(&udev->dev,
+				"port status: first read failed, status %d\n",
+				status);
+
+	if (status == 0 && udev->disable_link_on_suspend) {
+		if ((portstatus & USB_PORT_STAT_LINK_STATE) ==
+				USB_SS_PORT_LS_SS_DISABLED) {
+			status = hub_set_port_link_state(hub, port1,
+					USB_SS_PORT_LS_RX_DETECT);
+			if (status) {
+				dev_dbg(&port_dev->dev, "can't enable link\n");
+				goto SuspendCleared;
+			}
+
+			status = wait_for_link(udev, hub, port1, &portchange,
+					&portstatus);
+			if (status) {
+				dev_dbg(&port_dev->dev,
+						"wait for link failed\n");
+				goto SuspendCleared;
+			}
+			if (portstatus & USB_PORT_STAT_CONNECTION) {
+				dev_dbg(&port_dev->dev,
+						"connected after enabling link\n");
+				udev->disable_link_on_suspend = 0;
+			}
+
+			set_bit(port1, hub->warm_reset_bits);
+		} else {
+			dev_dbg(&port_dev->dev, "link is not disabled\n");
+			udev->disable_link_on_suspend = 0;
+		}
+	}
+
+	/* Skip the initial Clear-Suspend step for a remote wakeup */
 	if (status == 0 && !port_is_suspended(hub, portstatus)) {
 		if (portchange & USB_PORT_STAT_C_SUSPEND)
 			pm_wakeup_event(&udev->dev, 0);
@@ -3530,7 +3605,7 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
 		}
 	}
 
-	if (udev->persist_enabled)
+	if (udev->persist_enabled && !udev->disable_link_on_suspend)
 		status = wait_for_connected(udev, hub, &port1, &portchange,
 				&portstatus);
 
@@ -4069,7 +4144,8 @@ static int usb_disable_link_state(struct usb_hcd *hcd, struct usb_device *udev,
 	if (usb_set_lpm_timeout(udev, state, 0))
 		return -EBUSY;
 
-	usb_set_device_initiated_lpm(udev, state, false);
+	if (!udev->disable_link_on_suspend)
+		usb_set_device_initiated_lpm(udev, state, false);
 
 	if (hcd->driver->disable_usb3_lpm_timeout(hcd, udev, state))
 		dev_warn(&udev->dev, "Could not disable xHCI %s timeout, "
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 8bc35d53408b..c26ba784dc54 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -131,6 +131,9 @@ static int quirks_param_set(const char *val, const struct kernel_param *kp)
 			case 'o':
 				flags |= USB_QUIRK_HUB_SLOW_RESET;
 				break;
+			case 'p':
+				flags |= USB_QUIRK_DISABLE_LINK_ON_SUSPEND;
+				break;
 			/* Ignore unrecognized flag characters */
 			}
 		}
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 5e49e82c4368..44dff19a7839 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -610,6 +610,8 @@ struct usb3_lpm_parameters {
  * @do_remote_wakeup:  remote wakeup should be enabled
  * @reset_resume: needs reset instead of resume
  * @port_is_suspended: the upstream port is suspended (L2 or U3)
+ * @disable_link_on_suspend: link was disabled/should be disabled before
+ *	suspend
  * @wusb_dev: if this is a Wireless USB device, link to the WUSB
  *	specific data for the device.
  * @slot_id: Slot ID assigned by xHCI
@@ -699,6 +701,7 @@ struct usb_device {
 	unsigned do_remote_wakeup:1;
 	unsigned reset_resume:1;
 	unsigned port_is_suspended:1;
+	unsigned disable_link_on_suspend:1;
 #endif
 	struct wusb_dev *wusb_dev;
 	int slot_id;
diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
index a1be64c9940f..d23f14145782 100644
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -69,4 +69,13 @@
 /* Hub needs extra delay after resetting its port. */
 #define USB_QUIRK_HUB_SLOW_RESET		BIT(14)
 
+/*
+ * Disable link on device's port before system suspend and then
+ * enable it again after resume. This also enables device reset
+ * after resume.
+ *
+ * Has effect only on USB 3.0 devices connected to USB 3.0 ports.
+ */
+#define USB_QUIRK_DISABLE_LINK_ON_SUSPEND	BIT(15)
+
 #endif /* __LINUX_USB_QUIRKS_H */
-- 
2.20.1

