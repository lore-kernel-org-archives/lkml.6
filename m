Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3102847-1519657544-2-9180555624514827064
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519657542; b=QGw0wyDROtdxbX6N0s+lyiMdfgWAlqNuo071y7pUHBJzrJd
    YdHsS0tFCwUCmuZFuxFFSo2HcvOh/jtbcSOveTCf3fvC319fKgLxaejo7AIUVYTw
    lZS84p/ugCKf64F+z+7mHoHv8yqqtT24jjlzRE7aJtEHlhYI/qmX4XdhTAtrBI/Z
    9BbG4jbKWV5OmpR6Bq5IEwvAX7+EyDgsmqTgUJNCFAZeYKhtGo+sRJvgtxGjt6Aw
    OdcazdYp43X+NpWzpJXVXzsu7/aZh5AHzg+y389j0NDr0sFGjVfua8/LsZim2O0B
    zG6DYlspjO9hsNiScq8n5ESrrD238o6o5f1Eq7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519657542; bh=bnUwXBK6gnGafzw8jr7jW2zSYr
    cOLY4/WYcSO21VsdU=; b=hJW3dAm+rHnTkavUwRQtzE5XBguvki+ZLmd5etRnVA
    e/yj2GzuYbJQ6ZIDBAkzEp+NM6+N4f1cRawAt+3BLH5EsNut4jp4kBey7NZ9iWji
    3KQdpbwCM7P9tRXXSJbhZUZhEtiJjuNJ+rAwYSHsmpILcXtcEZC3FpmdlDa0KUHA
    xtx8ie7d8hwHILIwUQVY0/Lq8CPtCwqR5cn+0Rs1Bo44gxI0u+GqY7MSSasPe22C
    GnVZ9Zj55mJb1fFV61yztInwQ0b+kri+Q7LNMpM86otvJ9Z29GDELPQxL+VZ2WjA
    Q8/fN/RqDvsIcEzKs2Xl9SHMj/+As5IZuG7/OY/+Jlvg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754119AbeBZPFZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 10:05:25 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42425 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754090AbeBZPFJ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 26 Feb 2018 10:05:09 -0500
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: gregkh@linuxfoundation.org
Cc: oneukum@suse.com, willy@infradead.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v4] usb: core: Add "quirks" parameter for usbcore
Date: Mon, 26 Feb 2018 23:04:57 +0800
Message-Id: <20180226150457.22299-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Trying quirks in usbcore needs to rebuild the driver or the entire
kernel if it's builtin. It can save a lot of time if usbcore has similar
ability like "usbhid.quirks=" and "usb-storage.quirks=".

Rename the original quirk detection function to "static" as we introduce
this new "dynamic" function.

Now users can use "usbcore.quirks=" as short term workaround before the
next kernel release. Also, the quirk parameter can XOR the builtin
quirks for debugging purpose.

This is inspired by usbhid and usb-storage.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v4: Use kmalloc() to reduce memory usage.
    Remove tolower() so we can use capital character in the future.
    
v3: Stop overridding static quirks.
    Use XOR for dynamic quirks.
    Save parsed quirk as a list to avoid parsing quirk table everytime.

v2: Use in-kernel tolower() function.

 Documentation/admin-guide/kernel-parameters.txt |  55 ++++++++
 drivers/usb/core/quirks.c                       | 160 +++++++++++++++++++++++-
 drivers/usb/core/usb.c                          |   1 +
 drivers/usb/core/usb.h                          |   1 +
 4 files changed, 212 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1d1d53f85ddd..70a7398c20e2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4368,6 +4368,61 @@
 
 	usbcore.nousb	[USB] Disable the USB subsystem
 
+	usbcore.quirks=
+			[USB] A list of quirks entries to supplement or
+			override the built-in usb core quirk list.  List
+			entries are separated by commas.  Each entry has
+			the form VID:PID:Flags where VID and PID are Vendor
+			and Product ID values (4-digit hex numbers) and
+			Flags is a set of characters, each corresponding
+			to a common usb core quirk flag as follows:
+				a = USB_QUIRK_STRING_FETCH_255 (string
+					descriptors must not be fetched using
+					a 255-byte read);
+				b = USB_QUIRK_RESET_RESUME (device can't resume
+					correctly so reset it instead);
+				c = USB_QUIRK_NO_SET_INTF (device can't handle
+					Set-Interface requests);
+				d = USB_QUIRK_CONFIG_INTF_STRINGS (device can't
+					handle its Configuration or Interface
+					strings);
+				e = USB_QUIRK_RESET (device can't be reset
+					(e.g morph devices), don't use reset);
+				f = USB_QUIRK_HONOR_BNUMINTERFACES (device has
+					more interface descriptions than the
+					bNumInterfaces count, and can't handle
+					talking to these interfaces);
+				g = USB_QUIRK_DELAY_INIT (device needs a pause
+					during initialization, after we read
+					the device descriptor);
+				h = USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL (For
+					high speed and super speed interrupt
+					endpoints, the USB 2.0 and USB 3.0 spec
+					require the interval in microframes (1
+					microframe = 125 microseconds) to be
+					calculated as interval = 2 ^
+					(bInterval-1).
+					Devices with this quirk report their
+					bInterval as the result of this
+					calculation instead of the exponent
+					variable used in the calculation);
+				i = USB_QUIRK_DEVICE_QUALIFIER (device can't
+					handle device_qualifier descriptor
+					requests);
+				j = USB_QUIRK_IGNORE_REMOTE_WAKEUP (device
+					generates spurious wakeup, ignore
+					remote wakeup capability);
+				k = USB_QUIRK_NO_LPM (device can't handle Link
+					Power Management);
+				l = USB_QUIRK_LINEAR_FRAME_INTR_BINTERVAL
+					(Device reports its bInterval as linear
+					frames instead of the USB 2.0
+					calculation);
+				m = USB_QUIRK_DISCONNECT_SUSPEND (Device needs
+					to be disconnected before suspend to
+					prevent spurious wakeup)
+			Example: quirks=0781:5580:bk,0a5c:5834:gij
+
 	usbhid.mousepoll=
 			[USBHID] The interval which mice are to be polled at.
 
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 4024926c1d68..b15e80e414c8 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -11,6 +11,23 @@
 #include <linux/usb/hcd.h>
 #include "usb.h"
 
+static char quirks_param[128];
+module_param_string(quirks, quirks_param, sizeof(quirks_param), 0644);
+MODULE_PARM_DESC(quirks, "Add/modify USB quirks by specifying quirks=vendorID:productID:quirks");
+
+static char quirks_param_orig[128];
+
+static LIST_HEAD(quirk_list);
+
+static struct mutex quirk_mutex;
+
+struct quirk_entry {
+	u16 vid;
+	u16 pid;
+	u32 flags;
+	struct list_head list;
+};
+
 /* Lists of quirky USB devices, split in device quirks and interface quirks.
  * Device quirks are applied at the very beginning of the enumeration process,
  * right after reading the device descriptor. They can thus only match on device
@@ -305,6 +322,105 @@ static bool usb_match_any_interface(struct usb_device *udev,
 	return false;
 }
 
+static int usb_build_quirk_list(const char *quirks_param)
+{
+	char *param, *p, *field;
+	u16 vid, pid;
+	u32 flags;
+	struct quirk_entry *quirk;
+
+	usb_release_quirk_list();
+
+	param = kmalloc(strlen(quirks_param), GFP_KERNEL);
+	if (!param)
+		return -ENOMEM;
+
+	strcpy(param, quirks_param);
+	p = param;
+	while (p && *p) {
+		/* Each entry consists of VID:PID:flags */
+		field = strsep(&p, ":");
+		if (!field)
+			break;
+
+		if (kstrtou16(field, 16, &vid))
+			break;
+
+		field = strsep(&p, ":");
+		if (!field)
+			break;
+
+		if (kstrtou16(field, 16, &pid))
+			break;
+
+		field = strsep(&p, ",");
+		if (!field)
+			break;
+
+		/* Collect the flags */
+		for (flags = 0; *field; field++) {
+			switch (*field) {
+			case 'a':
+				flags |= USB_QUIRK_STRING_FETCH_255;
+				break;
+			case 'b':
+				flags |= USB_QUIRK_RESET_RESUME;
+				break;
+			case 'c':
+				flags |= USB_QUIRK_NO_SET_INTF;
+				break;
+			case 'd':
+				flags |= USB_QUIRK_CONFIG_INTF_STRINGS;
+				break;
+			case 'e':
+				flags |= USB_QUIRK_RESET;
+				break;
+			case 'f':
+				flags |= USB_QUIRK_HONOR_BNUMINTERFACES;
+				break;
+			case 'g':
+				flags |= USB_QUIRK_DELAY_INIT;
+				break;
+			case 'h':
+				flags |= USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL;
+				break;
+			case 'i':
+				flags |= USB_QUIRK_DEVICE_QUALIFIER;
+				break;
+			case 'j':
+				flags |= USB_QUIRK_IGNORE_REMOTE_WAKEUP;
+				break;
+			case 'k':
+				flags |= USB_QUIRK_NO_LPM;
+				break;
+			case 'l':
+				flags |= USB_QUIRK_LINEAR_FRAME_INTR_BINTERVAL;
+				break;
+			case 'm':
+				flags |= USB_QUIRK_DISCONNECT_SUSPEND;
+				break;
+			/* Ignore unrecognized flag characters */
+			}
+		}
+
+		quirk = kmalloc(sizeof(struct quirk_entry), GFP_KERNEL);
+		if (!quirk) {
+			kfree(param);
+			return -ENOMEM;
+		}
+
+		quirk->vid = vid;
+		quirk->pid = pid;
+		quirk->flags = flags;
+
+		list_add(&quirk->list, &quirk_list);
+	}
+
+	kfree(param);
+
+	return 0;
+}
+
 static int usb_amd_resume_quirk(struct usb_device *udev)
 {
 	struct usb_hcd *hcd;
@@ -317,8 +433,8 @@ static int usb_amd_resume_quirk(struct usb_device *udev)
 	return 0;
 }
 
-static u32 __usb_detect_quirks(struct usb_device *udev,
-			       const struct usb_device_id *id)
+static u32 usb_detect_static_quirks(struct usb_device *udev,
+				    const struct usb_device_id *id)
 {
 	u32 quirks = 0;
 
@@ -336,21 +452,45 @@ static u32 __usb_detect_quirks(struct usb_device *udev,
 	return quirks;
 }
 
+static u32 usb_detect_dynamic_quirks(struct usb_device *udev)
+{
+	u16 vid = le16_to_cpu(udev->descriptor.idVendor);
+	u16 pid = le16_to_cpu(udev->descriptor.idProduct);
+	struct quirk_entry *quirk;
+
+	mutex_lock(&quirk_mutex);
+	if (strcmp(quirks_param, quirks_param_orig) != 0) {
+		strcpy(quirks_param_orig, quirks_param);
+		if (usb_build_quirk_list(quirks_param))
+			dev_warn(&udev->dev, "failed to build quirk list");
+	}
+	mutex_unlock(&quirk_mutex);
+
+	list_for_each_entry(quirk, &quirk_list, list) {
+		if (vid == quirk->vid && pid == quirk->pid)
+			return quirk->flags;
+	}
+
+	return 0;
+}
+
 /*
  * Detect any quirks the device has, and do any housekeeping for it if needed.
  */
 void usb_detect_quirks(struct usb_device *udev)
 {
-	udev->quirks = __usb_detect_quirks(udev, usb_quirk_list);
+	udev->quirks = usb_detect_static_quirks(udev, usb_quirk_list);
 
 	/*
 	 * Pixart-based mice would trigger remote wakeup issue on AMD
 	 * Yangtze chipset, so set them as RESET_RESUME flag.
 	 */
 	if (usb_amd_resume_quirk(udev))
-		udev->quirks |= __usb_detect_quirks(udev,
+		udev->quirks |= usb_detect_static_quirks(udev,
 				usb_amd_resume_quirk_list);
 
+	udev->quirks ^= usb_detect_dynamic_quirks(udev);
+
 	if (udev->quirks)
 		dev_dbg(&udev->dev, "USB quirks for this device: %x\n",
 			udev->quirks);
@@ -369,7 +509,7 @@ void usb_detect_interface_quirks(struct usb_device *udev)
 {
 	u32 quirks;
 
-	quirks = __usb_detect_quirks(udev, usb_interface_quirk_list);
+	quirks = usb_detect_static_quirks(udev, usb_interface_quirk_list);
 	if (quirks == 0)
 		return;
 
@@ -377,3 +517,13 @@ void usb_detect_interface_quirks(struct usb_device *udev)
 		quirks);
 	udev->quirks |= quirks;
 }
+
+void usb_release_quirk_list(void)
+{
+	struct quirk_entry *quirk, *tmp;
+
+	list_for_each_entry_safe(quirk, tmp, &quirk_list, list) {
+		list_del(&quirk->list);
+		kfree(quirk);
+	}
+}
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 2f5fbc56a9dd..0adb6345ff2e 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -1259,6 +1259,7 @@ static void __exit usb_exit(void)
 	if (usb_disabled())
 		return;
 
+	usb_release_quirk_list();
 	usb_deregister_device_driver(&usb_generic_driver);
 	usb_major_cleanup();
 	usb_deregister(&usbfs_driver);
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 149cc7480971..546a2219454b 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -36,6 +36,7 @@ extern void usb_deauthorize_interface(struct usb_interface *);
 extern void usb_authorize_interface(struct usb_interface *);
 extern void usb_detect_quirks(struct usb_device *udev);
 extern void usb_detect_interface_quirks(struct usb_device *udev);
+extern void usb_release_quirk_list(void);
 extern int usb_remove_device(struct usb_device *udev);
 
 extern int usb_get_device_descriptor(struct usb_device *dev,
-- 
2.15.1

