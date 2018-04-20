Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2094390-1524244002-2-1172003856467716257
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524244002; b=iozs751NN3nuzbmXOzj+LX921oHiYWYRjhcB+rzMG6P0j8+asK
    UNKbMtQvhc/+4CPqlx2qKZJtmBOPCqG+OFobMSGl4ku/baS0AnRRsVkA4FzzhVMJ
    yKsLxoe2BPo8kb3itYk/y/cWi0SwEsJbub2STy5vSyJExl5GLVhEGjWmCCkgwXSK
    pKw2qREMhIpkxScGiApXcVf7wrWjmVLpHhmHMEwOiI5IJVBvTOOxIosmLBOi/XIB
    OlXmxZNvSdtHqSOh9UOgMUHtfw9uhME93xKwHvAMndRCeb/GMfFu1GKbkMC6RjA8
    vRuYcmbv5QJo3a1QcYe7M0DhP94uJgtDeBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524244002; bh=
    0nM6ROLIYdmfzanixgQ9idLhGzSrA10W05gqlmPwZPM=; b=o2neWBBM2tveIwzh
    68ejom4YvxC6lonE+LHON3yS4X8HVz2VZr5uDnBgwoBdBIMFfyGe/GGAjodlZKAH
    /gN86fEEqP9yRgCuJIadXE0r6AkSzDjOzNDsQGw+0GB17myrsmZwmgV50UbpsNoS
    VnYZfLhN1DxoBOX3XdkkZXITnYEMe0jM4c5NdtRWrZX7bxS+UZ1h7Uf0OSZxI69G
    tLZ0Z6erISFmPo5Q9CjUU4gLwg+TbP9+3zvywsdAAMJZoRVdcsTAtYNrKQD+1pen
    ZfbefLzDTN7yfwzAxdSonNtrasDCGO4qEsirAedK1zejDrJJFIxweSR6c42v1lFC
    azUuTw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=Fgszt4fq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oFSl0X3Z;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=Fgszt4fq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oFSl0X3Z;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEmT74NxSiib/O8lET4z+pQStn4rDgPAQ0MhqTjE1UATg/8PnxYJA4NbFZcnzreT97E5dQkYKHvc3pC+tE6RiNCF59AZd9cgcCjDGy4wHxjyQTU4KK9/
    iBKzGyJUTTjdrRFcJUQBU+yQfWG/YT1pnpQJn0Mmj+hnQ9w9OHro2xRNYPcYyAqUbvXvTCwRtxJkTFW7v56tjjDSrOhoR074Vgu+bof0c85xxkBwD30gcjdv
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=nYT8p2_G6mNX4mR58M8A:9 a=x8gzFH9gYPwA:10
    a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753533AbeDTRFx (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 13:05:53 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39960 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753481AbeDTRFt (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 20 Apr 2018 13:05:49 -0400
X-Google-Smtp-Source: AIpwx4+09viiswGMUIW6HGAtiLQGjNd0BEp+QJKfg1w1DArkVT96TEOCH+ttX8EtBhaxc+EAg9kxnQ==
From: Ravi Chandra Sadineni <ravisadineni@chromium.org>
To: stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        martin.blumenstingl@googlemail.com, ravisadineni@google.com,
        chunfeng.yun@mediatek.com, johan@kernel.org,
        arvind.yadav.cs@gmail.com, dtor@google.com,
        anton.bondarenko.sama@gmail.com, f.fainelli@gmail.com,
        keescook@chromium.org, mathias.nyman@linux.intel.com,
        felipe.balbi@linux.intel.com, ekorenevsky@gmail.com,
        peter.chen@nxp.com, joe@perches.com
Cc: tbroch@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajatja@google.com,
        bleung@google.com,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: [PATCH V3] USB: Increment wakeup count on remote wakeup.
Date: Fri, 20 Apr 2018 10:05:27 -0700
Message-Id: <20180420170527.143240-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <Pine.LNX.4.44L0.1804201010110.1407-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1804201010110.1407-100000@iolanthe.rowland.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On chromebooks we depend on wakeup count to identify the wakeup source.
But currently USB devices do not increment the wakeup count when they
trigger the remote wake. This patch addresses the same.

Resume condition is reported differently on USB 2.0 and USB 3.0 devices.

On USB 2.0 devices, a wake capable device, if wake enabled, drives
resume signal to indicate a remote wake (USB 2.0 spec section 7.1.7.7).
The upstream facing port then sets C_PORT_SUSPEND bit and reports a
port change event (USB 2.0 spec section 11.24.2.7.2.3). Thus if a port
has resumed before driving the resume signal from the host and
C_PORT_SUSPEND is set, then the device attached to the given port might
be the reason for the last system wakeup. Increment the wakeup count for
the same.

On USB 3.0 devices, a function may signal that it wants to exit from device
suspend by sending a Function Wake Device Notification to the host (USB3.0
spec section 8.5.6.4) Thus on receiving the Function Wake, increment the
wakeup count.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
 drivers/usb/core/hcd.c |  2 ++
 drivers/usb/core/hub.c | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 777036ae63674..b8024ae4fdcaa 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2375,6 +2375,8 @@ void usb_hcd_resume_root_hub (struct usb_hcd *hcd)
 {
 	unsigned long flags;
 
+	if (hcd->rh_registered)
+		pm_wakeup_event(&hcd->self.root_hub->dev, 0);
 	spin_lock_irqsave (&hcd_root_hub_lock, flags);
 	if (hcd->rh_registered) {
 		set_bit(HCD_FLAG_WAKEUP_PENDING, &hcd->flags);
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index f6ea16e9f6bb9..aa9968d90a48c 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -653,12 +653,17 @@ void usb_wakeup_notification(struct usb_device *hdev,
 		unsigned int portnum)
 {
 	struct usb_hub *hub;
+	struct usb_port *port_dev;
 
 	if (!hdev)
 		return;
 
 	hub = usb_hub_to_struct_hub(hdev);
 	if (hub) {
+		port_dev = hub->ports[portnum - 1];
+		if (port_dev && port_dev->child)
+			pm_wakeup_event(&port_dev->child->dev, 0);
+
 		set_bit(portnum, hub->wakeup_bits);
 		kick_hub_wq(hub);
 	}
@@ -3434,8 +3439,11 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
 
 	/* Skip the initial Clear-Suspend step for a remote wakeup */
 	status = hub_port_status(hub, port1, &portstatus, &portchange);
-	if (status == 0 && !port_is_suspended(hub, portstatus))
+	if (status == 0 && !port_is_suspended(hub, portstatus)) {
+		if (portchange & USB_PORT_STAT_C_SUSPEND)
+			pm_wakeup_event(&udev->dev, 0);
 		goto SuspendCleared;
+	}
 
 	/* see 7.1.7.7; affects power usage, but not budgeting */
 	if (hub_is_superspeed(hub->hdev))
-- 
2.17.0.484.g0c8726318c-goog

