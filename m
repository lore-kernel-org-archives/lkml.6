Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2903091-1519260756-2-14944975731084266024
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519260756; b=WDGpuANYmZIFxm6lk3boW/SOO6bOMtJkp5w4xpimk3nIAZx
    b7/L73J3ajk03GnaK33OnASi+u37K+SOlDGrpVK+VSdpQwlkpB0VG40SBjluc7vB
    ICp1aCNPGlx1x9kuNVaO5EeJpyUv1yIx3p3pJuvQd2XVT8D3+MhrzxPmSWQEXi8G
    hQXtOeeMx9gBWyUeGgAG5H+LJ7Va4iaFU89CscKV6gQyy/XqDHe6NH5rdmKEiqFW
    JjA2bkrD3wedUoOGJqgRviqF4digzcxdllFrrbbb3oblSbl5IQYrA1QvAdJCA6mh
    IiKpyWDjtHWzkC+so5/2E2pSfGyv3W+Ui8i56hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519260756; bh=FkL5Ykr9ncp9w2C0FlnMy3d4PV
    s4p1h9yTPdjJh4ot8=; b=jA+LL4FybqoYrQdf+MBatBNAh2iQRT1H5rmzvTblxs
    XZPyqNshJ4ibY0Rajhh7abH+0rPCAdgnorrW5lC3ccfh38PZjTHFOfhDmcV/75bf
    t8lAiiTVW5U/ce2mkfUiakJ/3OZfiwU5syZUfR5OKpqFNG7/67TzIq6ok8k8legy
    i/2oYm6NhWptdVYBDVwZVC3HiLu0qpQr5oEHrUnAQ52ZazqHRS/lX5nPOlAwSX5+
    hurOKdBM7f6Q9UgwKKvyFAny/uSfQc3Ar5x3TeWbUCUKptPytCNcy5kLSnZjvXPu
    l95OBGY4UJHs61ZXy1YEo6xOodtmnczUMbg8zaMbMsUg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=dk-develop.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dk-develop.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=dk-develop.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dk-develop.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751633AbeBVAwT (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 19:52:19 -0500
Received: from hs01.dk-develop.de ([213.136.71.231]:34377 "EHLO
        hs01.dk-develop.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbeBVAwS (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 21 Feb 2018 19:52:18 -0500
From: Danilo Krummrich <danilokrummrich@dk-develop.de>
To: gregkh@linuxfoundation.org, felipe.balbi@linux.intel.com
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, kai.heng.feng@canonical.com,
        Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH v2] usb: quirks: add control message delay for 1b1c:1b20
Date: Thu, 22 Feb 2018 01:51:46 +0100
Message-Id: <20180222005146.4451-1-danilokrummrich@dk-develop.de>
X-Mailer: git-send-email 2.14.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Corsair Strafe RGB keyboard does not respond to usb control messages
sometimes and hence generates timeouts.

Commit de3af5bf259d ("usb: quirks: add delay init quirk for Corsair
Strafe RGB keyboard") tried to fix those timeouts by adding
USB_QUIRK_DELAY_INIT.

Unfortunately, even with this quirk timeouts of usb_control_msg()
can still be seen, but with a lower frequency (approx. 1 out of 15):

[   29.103520] usb 1-8: string descriptor 0 read error: -110
[   34.363097] usb 1-8: can't set config #1, error -110

Adding further delays to different locations where usb control
messages are issued just moves the timeouts to other locations,
e.g.:

[   35.400533] usbhid 1-8:1.0: can't add hid device: -110
[   35.401014] usbhid: probe of 1-8:1.0 failed with error -110

The only way to reliably avoid those issues is having a pause after
each usb control message. In approx. 200 boot cycles no more timeouts
were seen.

Addionaly, keep USB_QUIRK_DELAY_INIT as it turned out to be necessary
to have the delay in hub_port_connect() after hub_port_init().

The overall boot time seems not to be influenced by these additional
delays, even on fast machines.

Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
---
v2: remove empty line in usb_get_descriptor() added by accident
---
 drivers/usb/core/message.c | 4 ++++
 drivers/usb/core/quirks.c  | 3 ++-
 include/linux/usb/quirks.h | 3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 77001bcfc504..a4025760dd84 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -150,6 +150,10 @@ int usb_control_msg(struct usb_device *dev, unsigned int pipe, __u8 request,
 
 	ret = usb_internal_control_msg(dev, pipe, dr, data, size, timeout);
 
+	/* Linger a bit, prior to the next control message. */
+	if (dev->quirks & USB_QUIRK_DELAY_CTRL_MSG)
+		msleep(200);
+
 	kfree(dr);
 
 	return ret;
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 4024926c1d68..4450bec7f3af 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -227,7 +227,8 @@ static const struct usb_device_id usb_quirk_list[] = {
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
 
 	/* Corsair Strafe RGB */
-	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT },
+	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT |
+	  USB_QUIRK_DELAY_CTRL_MSG },
 
 	/* Corsair K70 LUX */
 	{ USB_DEVICE(0x1b1c, 0x1b36), .driver_info = USB_QUIRK_DELAY_INIT },
diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
index f1fcec2fd5f8..b7a99ce56bc9 100644
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -63,4 +63,7 @@
  */
 #define USB_QUIRK_DISCONNECT_SUSPEND		BIT(12)
 
+/* Device needs a pause after every control message. */
+#define USB_QUIRK_DELAY_CTRL_MSG		BIT(13)
+
 #endif /* __LINUX_USB_QUIRKS_H */
-- 
2.14.1

