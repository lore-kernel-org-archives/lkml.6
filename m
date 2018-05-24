Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1599868-1527149958-2-8151249043570270894
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527149957; b=SSIr4GAVYycRgcK80tmRhFbj4gaT8UHMxHfFdPlIrcuCinXQKl
    jZnd9Gi6IbFxZHVSaLE66EFpWhIZBSjcCxdkvF/rg19bSw18jyTta12Ofk03LPOJ
    jZxWUYqgg+4xVQkDjLoOyWjnX7mnIIj0GNoNrU9jHh1ilb1F5NyKuhMMRf+3wYJ8
    uEA3qLjUdBVYvC+fevAypHRETq9IwPLNqYBiuxWwjw7FU6GesX68Nxb/uHiXbyeP
    Aosxgo4FWJSQVTVsFNjWAzGZnRw2xrjTXahX/HK9Ev0n6nJPIqriJBrRT44dur7k
    0s+Bi0vsHO7fqMsRH0dUcW7LeFWHdVvD1nLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527149957; bh=
    xPnlJ1NL8kwvc+2PARNo1RvuvJFIOBq5bYtirLX6WMc=; b=Q+VENTXxCbL6A3qM
    LtEO4I7DKkpLfG/GaY/r19hHHQELdsiBS/mOOMQOijHBNFC0kpjDNLMkWUIQgpK/
    0G1CTmUEKZPubKrYZF+zmASbB+ebtwxOsibB4cDUyOGCDLahDEVpGe1k/IljbEKZ
    0PzDIlo3g8wFNZPHT+29hUWl+w7HqJvrVHNeql/RG1hNybQ2GJbC38OpMaQ0ZaGN
    shA7vc3TveJiJN0io3onjxyZY5Nv5rZgeli3bnpiyU0eM7VU1T3Z7zadGeNoI/oG
    dx6JfhvD4eY6dlWEV+5yQOQO8NDZ/1BFefcAET2PCVjpLHh1ATUEcpdwWnOb1EZN
    s5gh+w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJVwgxK6pqeLLagQddY+fcogbmsFPi5g6tsmGy3rIC4VrsviDppTmNxcL0h/WbcS/q+GWz0SLUvGLd06qfiF19Kfiv6yvGyA8JG0duJ5Y6zoKgbuYK/w
    fPnYmkWCCi1Yfa814f42XkRxqxQfY8dodC7ZVo5ZyLWiGZM6IDpG7qtbacg9a0Iit1e3zasq+FzoHFrEv7HqFi2v7K8N1EtlCdWe7fCe9yZflVxLrO2S4+oL
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=jEwyjOoxjFaqbH4N4UIA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964787AbeEXITA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 04:19:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:65280 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964867AbeEXISk (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 24 May 2018 04:18:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,436,1520924400";
   d="scan'208";a="58073610"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v3 4/4] usb: roles: intel_xhci: Enable runtime PM
Date: Thu, 24 May 2018 11:18:27 +0300
Message-Id: <20180524081827.37861-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524081827.37861-1-heikki.krogerus@linux.intel.com>
References: <20180524081827.37861-1-heikki.krogerus@linux.intel.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This fixes an issue where the mux does not get configured
when the parent device is suspended. The registers for this
mux are mapped to the parent device MMIO (usually xHCI PCI
device), so in order for the driver to be able to program
the registers, the parent device must be resumed.

Reported-by: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
Fixes: f6fb9ec02be1 ("usb: roles: Add Intel xHCI USB role switch driver")
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/roles/intel-xhci-usb-role-switch.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
index 6e922b50b674..1fb3dd0f1dfa 100644
--- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
+++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/usb/role.h>
 
 /* register definition */
@@ -56,6 +57,8 @@ static int intel_xhci_usb_set_role(struct device *dev, enum usb_role role)
 		return -EIO;
 	}
 
+	pm_runtime_get_sync(dev);
+
 	/* Set idpin value as requested */
 	val = readl(data->base + DUAL_ROLE_CFG0);
 	switch (role) {
@@ -84,13 +87,17 @@ static int intel_xhci_usb_set_role(struct device *dev, enum usb_role role)
 	/* Polling on CFG1 register to confirm mode switch.*/
 	do {
 		val = readl(data->base + DUAL_ROLE_CFG1);
-		if (!!(val & HOST_MODE) == (role == USB_ROLE_HOST))
+		if (!!(val & HOST_MODE) == (role == USB_ROLE_HOST)) {
+			pm_runtime_put(dev);
 			return 0;
+		}
 
 		/* Interval for polling is set to about 5 - 10 ms */
 		usleep_range(5000, 10000);
 	} while (time_before(jiffies, timeout));
 
+	pm_runtime_put(dev);
+
 	dev_warn(dev, "Timeout waiting for role-switch\n");
 	return -ETIMEDOUT;
 }
@@ -101,7 +108,9 @@ static enum usb_role intel_xhci_usb_get_role(struct device *dev)
 	enum usb_role role;
 	u32 val;
 
+	pm_runtime_get_sync(dev);
 	val = readl(data->base + DUAL_ROLE_CFG0);
+	pm_runtime_put(dev);
 
 	if (!(val & SW_IDPIN))
 		role = USB_ROLE_HOST;
@@ -142,6 +151,9 @@ static int intel_xhci_usb_probe(struct platform_device *pdev)
 	if (IS_ERR(data->role_sw))
 		return PTR_ERR(data->role_sw);
 
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
 	return 0;
 }
 
-- 
2.17.0

