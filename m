Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-168518-1519572384-2-6215735572883915856
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519572383; b=EYLzV05S6JXyIN/RZRdTgEF6l/+FkahycssXC56Sk/a7yzN
    NRE6GEkwr8KsBb2b6ExlYgv7tzUfcALfBk2ZuN/Ecb55PJ7XEVcvlfPqwZgb9F3g
    WOXy/oPSg9Ubke0TY+KBB08sjHn0CtTaL2asiHAgPIhB1MvnRfHWaciQi8HHcd0l
    X/+XWe//4q+n0MH6UuE+/f/1weOL5zGLprewHTEXDU737csvuJePTT0jMjuhS6z9
    jDbf0La4ZpZY5/OyiFMIkMCoUxzpDM3QiRI5nljcg6I4RFLmrXnmEdho7msaw2uu
    aodrj37D8BPvIwVvQDcg+ENfVX8VKyRlbEuEGDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519572383;
    bh=a9buWi4y7DyjT/bMHYrDqUgvMLT+1EOX8HI8U3FiWw0=; b=eeeaaD85Mn1Z
    9PUS1ma3i7D9Zcx3sCHf8cY+/ZZJfI1aPP/NDSpu61vpZfQIYp7C//RQWqJiBKW+
    ylrkZtfd111XNlyIeIivMe6pp+fKc4XGu/obUCRqlEc0wVi57PSzfzX9+7gGQrKb
    BQT5ma8LRQEegtVGA1/4RTmUziHXeZ8YLO/M4BLAl1mSLOAM/3uZBerCA207vHGE
    t79PaxcE1ZnYlAXUjGrTgCjFA/Ne1C7WeUzmhiIpWJsZt5qCvwo2LF7Ce3Jtf5Ht
    iqoZPtOfgxgLW+8b2p8lPj1+P8Qa2re03m4i03YAlhCV1qZtZ/WTsTcBGmvgVVTq
    hYVsYPkm+g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeBYPZf (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 10:25:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751844AbeBYPZ2 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sun, 25 Feb 2018 10:25:28 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 08/12] xhci: Add Intel extended cap / otg phy mux handling
Date: Sun, 25 Feb 2018 16:25:06 +0100
Message-Id: <20180225152510.10159-9-hdegoede@redhat.com>
In-Reply-To: <20180225152510.10159-1-hdegoede@redhat.com>
References: <20180225152510.10159-1-hdegoede@redhat.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The xHCI controller on various Intel SoCs has an extended cap mmio-range
which contains registers to control the muxing to the xHCI (host mode)
or the dwc3 (device mode) and vbus-detection for the otg usb-phy.

Having a role-sw driver included in the xHCI code (under drivers/usb/host)
is not desirable. So this commit adds a simple handler for this extended
capability, which creates a platform device with the caps mmio region as
resource, this allows us to write a separate platform role-sw driver for
the role-switch.

Note this commit adds a call to the new xhci_ext_cap_init() function
to xhci_pci_probe(), it is added here because xhci_ext_cap_init() must
be called only once. If in the future we also want to handle ext-caps
on non pci xHCI HCDs from xhci_ext_cap_init() a call to it should also
be added to other bus probe paths.

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Use SPDX license header
-Various small style cleanups / changes
-Add Heikki's Reviewed-by

Changes from some time ago when this patch was part of another patch-set:
-Check xHCI controller PCI device-id instead of only checking for the
 Intel Extended capability ID, as the Extended capability ID is used on
 other model Intel xHCI controllers too
-Add a new generic xhci_ext_cap_init() function and handle the new
 XHCI_INTEL_CHT_USB_MUX quirk there.
-Stop using Cherry Trail / CHT in various places as other Intel SoCs
 (e.g. Broxton / Apollo Lake) also have this
---
 drivers/usb/host/Makefile        |  2 +-
 drivers/usb/host/xhci-ext-caps.c | 90 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci-ext-caps.h |  2 +
 drivers/usb/host/xhci-pci.c      |  5 +++
 drivers/usb/host/xhci.h          |  2 +
 5 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/host/xhci-ext-caps.c

diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 4ede4ce12366..8a8cffe0b445 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -11,7 +11,7 @@ fhci-y += fhci-mem.o fhci-tds.o fhci-sched.o
 
 fhci-$(CONFIG_FHCI_DEBUG) += fhci-dbg.o
 
-xhci-hcd-y := xhci.o xhci-mem.o
+xhci-hcd-y := xhci.o xhci-mem.o xhci-ext-caps.o
 xhci-hcd-y += xhci-ring.o xhci-hub.o xhci-dbg.o
 xhci-hcd-y += xhci-trace.o
 
diff --git a/drivers/usb/host/xhci-ext-caps.c b/drivers/usb/host/xhci-ext-caps.c
new file mode 100644
index 000000000000..399113f9fc5c
--- /dev/null
+++ b/drivers/usb/host/xhci-ext-caps.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * XHCI extended capability handling
+ *
+ * Copyright (c) 2017 Hans de Goede <hdegoede@redhat.com>
+ */
+
+#include <linux/platform_device.h>
+#include "xhci.h"
+
+#define USB_SW_DRV_NAME		"intel_xhci_usb_sw"
+#define USB_SW_RESOURCE_SIZE	0x400
+
+static void xhci_intel_unregister_pdev(void *arg)
+{
+	platform_device_unregister(arg);
+}
+
+static int xhci_create_intel_xhci_sw_pdev(struct xhci_hcd *xhci, u32 cap_offset)
+{
+	struct usb_hcd *hcd = xhci_to_hcd(xhci);
+	struct device *dev = hcd->self.controller;
+	struct platform_device *pdev;
+	struct resource	res = { 0, };
+	int ret;
+
+	pdev = platform_device_alloc(USB_SW_DRV_NAME, PLATFORM_DEVID_NONE);
+	if (!pdev) {
+		xhci_err(xhci, "couldn't allocate %s platform device\n",
+			 USB_SW_DRV_NAME);
+		return -ENOMEM;
+	}
+
+	res.start = hcd->rsrc_start + cap_offset;
+	res.end	  = res.start + USB_SW_RESOURCE_SIZE - 1;
+	res.name  = USB_SW_DRV_NAME;
+	res.flags = IORESOURCE_MEM;
+
+	ret = platform_device_add_resources(pdev, &res, 1);
+	if (ret) {
+		dev_err(dev, "couldn't add resources to intel_xhci_usb_sw pdev\n");
+		platform_device_put(pdev);
+		return ret;
+	}
+
+	pdev->dev.parent = dev;
+
+	ret = platform_device_add(pdev);
+	if (ret) {
+		dev_err(dev, "couldn't register intel_xhci_usb_sw pdev\n");
+		platform_device_put(pdev);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, xhci_intel_unregister_pdev, pdev);
+	if (ret) {
+		dev_err(dev, "couldn't add unregister action for intel_xhci_usb_sw pdev\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+int xhci_ext_cap_init(struct xhci_hcd *xhci)
+{
+	void __iomem *base = &xhci->cap_regs->hc_capbase;
+	u32 offset, val;
+	int ret;
+
+	offset = xhci_find_next_ext_cap(base, 0, 0);
+
+	while (offset) {
+		val = readl(base + offset);
+
+		switch (XHCI_EXT_CAPS_ID(val)) {
+		case XHCI_EXT_CAPS_VENDOR_INTEL:
+			if (xhci->quirks & XHCI_INTEL_USB_ROLE_SW) {
+				ret = xhci_create_intel_xhci_sw_pdev(xhci,
+								     offset);
+				if (ret)
+					return ret;
+			}
+			break;
+		}
+		offset = xhci_find_next_ext_cap(base, offset, 0);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xhci_ext_cap_init);
diff --git a/drivers/usb/host/xhci-ext-caps.h b/drivers/usb/host/xhci-ext-caps.h
index 631e7cc62604..268328c20681 100644
--- a/drivers/usb/host/xhci-ext-caps.h
+++ b/drivers/usb/host/xhci-ext-caps.h
@@ -39,6 +39,8 @@
 #define XHCI_EXT_CAPS_ROUTE	5
 /* IDs 6-9 reserved */
 #define XHCI_EXT_CAPS_DEBUG	10
+/* Vendor caps */
+#define XHCI_EXT_CAPS_VENDOR_INTEL	192
 /* USB Legacy Support Capability - section 7.1.1 */
 #define XHCI_HC_BIOS_OWNED	(1 << 16)
 #define XHCI_HC_OS_OWNED	(1 << 24)
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 6c79037876db..4486640d925c 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -164,6 +164,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
 		 pdev->device == PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI) {
 		xhci->quirks |= XHCI_SSIC_PORT_UNUSED;
+		xhci->quirks |= XHCI_INTEL_USB_ROLE_SW;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
 	    (pdev->device == PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI ||
@@ -297,6 +298,10 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		goto dealloc_usb2_hcd;
 	}
 
+	retval = xhci_ext_cap_init(xhci);
+	if (retval)
+		goto put_usb3_hcd;
+
 	retval = usb_add_hcd(xhci->shared_hcd, dev->irq,
 			IRQF_SHARED);
 	if (retval)
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 96099a245c69..5917e3095e2a 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1825,6 +1825,7 @@ struct xhci_hcd {
 /* Reserved. It was XHCI_U2_DISABLE_WAKE */
 #define XHCI_ASMEDIA_MODIFY_FLOWCONTROL	(1 << 28)
 #define XHCI_HW_LPM_DISABLE	(1 << 29)
+#define XHCI_INTEL_USB_ROLE_SW	(1 << 30)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
@@ -2020,6 +2021,7 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks);
 void xhci_init_driver(struct hc_driver *drv,
 		      const struct xhci_driver_overrides *over);
 int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id);
+int xhci_ext_cap_init(struct xhci_hcd *xhci);
 
 int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup);
 int xhci_resume(struct xhci_hcd *xhci, bool hibernated);
-- 
2.14.3

