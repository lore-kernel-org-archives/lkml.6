Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4022553-1520325550-2-11148562389889800936
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520325549; b=uTGiQP9KxblvfHyR4rHd75ccCu8CpYNbD4EZr/FqiqrbwS+
    z5Y2z9scKSH9iyc+UvA2jlNwRAhvLucNuPlaOpon58yvFzUQyL05Xo8/4KyIum7I
    OiGCEulgHuBqvIq9kfD3cfAf8bW4k6YZCWEQvs/ltFqR166F8BeZ2HixWQenjbsZ
    aTdQaSrkIy4JCBXBIZEcRCK6dkTnmcDk16+BKz7lXWWTLBO/5Ii1y0yN3DK/eX82
    1/qS4oEHW73+nkqPdO3N5v2b0xCluz+yMP41Yb/0H8bH4w40Z8N75aJmeGuNg8DL
    a0lv8oxAeFIuCY7KblyjF0tRDnrk9gWWEcdOg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520325549; bh=MyUWsnk9iIyZSjS85f3mmcLJCJ
    mrX7FBbjxn4DumzT8=; b=Ij/j2gqVfywscHlfeJqMw2LqsK7/YHLHp37yx5/wSr
    dxcJE9BAUfjUGJYbEYyv8JkRVjNV9wuNDNcAxnUKEPz+PkCW+yEIsF/LWsNV7D0q
    CRv0NkP+qPb4MecQUV01e4b3O/vDec53Bw84x4+xTj9d9kjRitYT50pBxiwxaQKv
    vSDdVzxYaohVxFTbdt1brX7uP5u1orUkhMm/StgE9IlMavKewqBZwRDQFNOcksNq
    gBFwJfFMvF1oXsWKOmrNpU7yNph2R5kaVkTr3qvzYvWAbIxy4v8m99j5LBqXYFaA
    c1eo4tyrYJKQbHj29sE7WIj4twlcKmhG3snUJoPdusIQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=dk-develop.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dk-develop.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=dk-develop.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dk-develop.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeCFIjH (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 03:39:07 -0500
Received: from hs01.dk-develop.de ([213.136.71.231]:58567 "EHLO
        hs01.dk-develop.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeCFIjG (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 6 Mar 2018 03:39:06 -0500
From: Danilo Krummrich <danilokrummrich@dk-develop.de>
To: gregkh@linuxfoundation.org, felipe.balbi@linux.intel.com
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, kai.heng.feng@canonical.com,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        stable@vger.kernel.org
Subject: [PATCH resend] usb: quirks: add control message delay for 1b1c:1b20
Date: Tue,  6 Mar 2018 09:38:49 +0100
Message-Id: <20180306083849.3293-1-danilokrummrich@dk-develop.de>
X-Mailer: git-send-email 2.16.2
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
delays, even on fast machines and lightweight distributions.

Fixes: de3af5bf259d ("usb: quirks: add delay init quirk for Corsair Strafe RGB keyboard")
Cc: stable@vger.kernel.org
Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
---
 drivers/usb/core/message.c | 4 ++++
 drivers/usb/core/quirks.c  | 3 ++-
 include/linux/usb/quirks.h | 3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index c64cf6c4a83d..0c11d40a12bc 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -151,6 +151,10 @@ int usb_control_msg(struct usb_device *dev, unsigned int pipe, __u8 request,
 
 	ret = usb_internal_control_msg(dev, pipe, dr, data, size, timeout);
 
+	/* Linger a bit, prior to the next control message. */
+	if (dev->quirks & USB_QUIRK_DELAY_CTRL_MSG)
+		msleep(200);
+
 	kfree(dr);
 
 	return ret;
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index f4a548471f0f..54b019e267c5 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -230,7 +230,8 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT },
 
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
2.16.2

