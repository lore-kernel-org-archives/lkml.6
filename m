Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518710567-2-15842499003803670364
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710566; b=IoFUDYs2Sg8R1ol1cfpnQjnM3qcM03a0qiOO4FIL6USCKyN
    PMD90igmb+J6rYYWaavhaeW8w7BCMK8NTq5cP8XhF5YSMijn/cpvVBJ7x+hvScQb
    gvQCtu/jE4IFaDxINsIFv+BqTKZvTwwQrAYPl1PsIQzSel3m72o04I4JnSo7XUri
    wI4RUEI4Nv4piLSD37HJw072MJ4XhETyjK2cCWxRmaGTg5MTT2BASsP7vkpAZ7kG
    BT9o2gxeBV/gkAEVxaFOLjYSz05VJ0hR69CfmCxDOqj92GdoGJUJKw+3kAYL2DVX
    CNTNgGNGm08v9tHNIK2yZCImj7CdNC/4wG6zqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710566; bh=cjgyVatN2b4KDg8hdmnkeTcmsW
    iB/R617a03aBWyYvo=; b=g97cLNTggYx0BjogpqImYYwrnZrs9htUOGffoY4ULq
    cCJq7XawT8JNpRMN5RA5No/u3ogg1LH1AWGOnInNU3YVAsbWhTmbMZLGMnUXvcvD
    SEhMp3TsH5siKzBgObh/nmX3xyjFieHhKRflmlgzjQ/yOTGUzRPrKtyN2h1EGibr
    8a4XTTgZhiPYZRgEw5n8v2Psnz1FW/CH1yAfpdhl4bPtWp5Td+cVQOOL6ISRgYBz
    YTQ+moW8NAPJ0WD1JZi+Ess2RTY3kHYsPLW3NcpBs/1wCNVzUPxbvLISZIzc9Kzk
    SP3fbLoenNy2U3HvZhcJ26xC+c9a9VEisQB5rAEHAyUA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424687AbeBOPqc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:46:32 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35646 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424685AbeBOPq3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:46:29 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leif Liddy <leif.linux@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Daniel Drake <drake@endlessm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.15 164/202] Bluetooth: btusb: Restore QCA Rome suspend/resume fix with a "rewritten" version
Date: Thu, 15 Feb 2018 16:17:44 +0100
Message-Id: <20180215151721.461045833@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 61f5acea8737d9b717fcc22bb6679924f3c82b98 upstream.

Commit 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
removed the setting of the BTUSB_RESET_RESUME quirk for QCA Rome devices,
instead favoring adding USB_QUIRK_RESET_RESUME quirks in usb/core/quirks.c.

This was done because the DIY BTUSB_RESET_RESUME reset-resume handling
has several issues (see the original commit message). An added advantage
of moving over to the USB-core reset-resume handling is that it also
disables autosuspend for these devices, which is similarly broken on these.

But there are 2 issues with this approach:
1) It leaves the broken DIY BTUSB_RESET_RESUME code in place for Realtek
   devices.
2) Sofar only 2 of the 10 QCA devices known to the btusb code have been
   added to usb/core/quirks.c and if we fix the Realtek case the same way
   we need to add an additional 14 entries. So in essence we need to
   duplicate a large part of the usb_device_id table in btusb.c in
   usb/core/quirks.c and manually keep them in sync.

This commit instead restores setting a reset-resume quirk for QCA devices
in the btusb.c code, avoiding the duplicate usb_device_id table problem.

This commit avoids the problems with the original DIY BTUSB_RESET_RESUME
code by simply setting the USB_QUIRK_RESET_RESUME quirk directly on the
usb_device.

This commit also moves the BTUSB_REALTEK case over to directly setting the
USB_QUIRK_RESET_RESUME on the usb_device and removes the now unused
BTUSB_RESET_RESUME code.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
Fixes: 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
Cc: Leif Liddy <leif.linux@gmail.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Daniel Drake <drake@endlessm.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btusb.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -23,6 +23,7 @@
 
 #include <linux/module.h>
 #include <linux/usb.h>
+#include <linux/usb/quirks.h>
 #include <linux/firmware.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
@@ -387,9 +388,8 @@ static const struct usb_device_id blackl
 #define BTUSB_FIRMWARE_LOADED	7
 #define BTUSB_FIRMWARE_FAILED	8
 #define BTUSB_BOOTING		9
-#define BTUSB_RESET_RESUME	10
-#define BTUSB_DIAG_RUNNING	11
-#define BTUSB_OOB_WAKE_ENABLED	12
+#define BTUSB_DIAG_RUNNING	10
+#define BTUSB_OOB_WAKE_ENABLED	11
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -3117,6 +3117,12 @@ static int btusb_probe(struct usb_interf
 	if (id->driver_info & BTUSB_QCA_ROME) {
 		data->setup_on_usb = btusb_setup_qca;
 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
+
+		/* QCA Rome devices lose their updated firmware over suspend,
+		 * but the USB hub doesn't notice any status change.
+		 * explicitly request a device reset on resume.
+		 */
+		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
 	}
 
 #ifdef CONFIG_BT_HCIBTUSB_RTL
@@ -3127,7 +3133,7 @@ static int btusb_probe(struct usb_interf
 		 * but the USB hub doesn't notice any status change.
 		 * Explicitly request a device reset on resume.
 		 */
-		set_bit(BTUSB_RESET_RESUME, &data->flags);
+		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
 	}
 #endif
 
@@ -3293,14 +3299,6 @@ static int btusb_suspend(struct usb_inte
 		enable_irq(data->oob_wake_irq);
 	}
 
-	/* Optionally request a device reset on resume, but only when
-	 * wakeups are disabled. If wakeups are enabled we assume the
-	 * device will stay powered up throughout suspend.
-	 */
-	if (test_bit(BTUSB_RESET_RESUME, &data->flags) &&
-	    !device_may_wakeup(&data->udev->dev))
-		data->udev->reset_resume = 1;
-
 	return 0;
 }
 
