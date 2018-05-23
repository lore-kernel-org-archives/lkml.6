Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-219543-1527086375-2-7321966325104379110
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527086374; b=I6CcNOrAj+Y5i2M5f8NMUiXSgqr0z/lPQf/n4GLm7Q3mrbJ++N
    yXNm4RU6XBJa2orc+IsUd0TbnEeWacbENDJBkCX7vdCdIrJtGC2lg1T8Qxbz/VPx
    iyBqBhMbK584lJ4TyABKHSqx4ijTs9xC39ZQlaUtxcELu/fS0ZrxYqGhkKCFXi7g
    SK9bEJBd0+elskHqMA08L1nr3/CNNjFK+RNo/LOhc503W9lNhAZVjizijwzFtbGr
    Yzy9mYvpndNmmztNMXyJWudgoNUHnlpkwinnu9v0XnIG/5RuDxzDYnorWDJREti6
    gqOpCApverKYgvzdrSa27haIe3V/EUfe+UTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527086374; bh=
    R7uuo0wL89Dk25v9LvFjI4EZrERJNanDv1G/OW3aRwY=; b=cObThQY34MyBT9SQ
    6NgX3mjcmKF7B9UIgYL/qbXkq8Q4TkbWQMpDewcYO8K/ww+kZ/HdB1YIHBR4L+NN
    wWSx1pZnCrjwVx+HhgDwyOavGqMNUGxt3xruUR1rfXTANRXydiMnz2l3HHNY0FBq
    PZ+lsHlAJdTJKGdhfw4WPMcOCdYOYkpIJ3SwGD9TsglLcQTFbqtL+WOYyhTv8bjn
    lSs55lZYQmCeMW1upgmiv1pRA0QpJu9monSHWr/rQHt4p3dncgRtXuNlHMaFKmpk
    OZmmTWJuFOfGSiFOqaAlx3qf+TfILCBATqOiCezPZpIZJbBGy6d7sKeS6sy//CgL
    2cUuSA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfOn7A1Ygu3e+dNmFLvWDFThfT2DmzFkpeNtQsRwTYRnfem+WWhauy+2XR7ea0Er4YgneoCOvXONAyQWD0VQespf0wskqSLuFFYnHOrjbh2+IUlwmN9mK
    v9cxj9sy+98RHjW10bEyrKEsRCyDtIs4ugJ41AusZDhe5NB85rMe03CzuPsa2S78AF0uImsNlGJxfuVj3/nEVoxIBEfT7r22IXQWkeqXA38YhBiTtuyR8BYp
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=0G_0c1pej6gM9b92uHwA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933274AbeEWOiH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 10:38:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:29020 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933081AbeEWOiE (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 23 May 2018 10:38:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,433,1520924400";
   d="scan'208";a="57815002"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 1/3] usb: roles: intel_xhci: Always allow user control
Date: Wed, 23 May 2018 17:37:56 +0300
Message-Id: <20180523143758.66348-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523143758.66348-1-heikki.krogerus@linux.intel.com>
References: <20180523143758.66348-1-heikki.krogerus@linux.intel.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Trying to determine the USB port type with this mux is very
difficult. To simplify the situation, always allowing user
control, even if the port is USB Type-C port.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 .../usb/roles/intel-xhci-usb-role-switch.c    | 21 +------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
index 30b07ea3a3c6..3f14153d753f 100644
--- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
+++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
@@ -39,20 +39,6 @@ struct intel_xhci_usb_data {
 	void __iomem *base;
 };
 
-struct intel_xhci_acpi_match {
-	const char *hid;
-	int hrv;
-};
-
-/*
- * ACPI IDs for PMICs which do not support separate data and power role
- * detection (USB ACA detection for micro USB OTG), we allow userspace to
- * change the role manually on these.
- */
-static const struct intel_xhci_acpi_match allow_userspace_ctrl_ids[] = {
-	{ "INT33F4",  3 }, /* X-Powers AXP288 PMIC */
-};
-
 static int intel_xhci_usb_set_role(struct device *dev, enum usb_role role)
 {
 	struct intel_xhci_usb_data *data = dev_get_drvdata(dev);
@@ -139,6 +125,7 @@ static enum usb_role intel_xhci_usb_get_role(struct device *dev)
 static struct usb_role_switch_desc sw_desc = {
 	.set = intel_xhci_usb_set_role,
 	.get = intel_xhci_usb_get_role,
+	.allow_userspace_control = true,
 };
 
 static int intel_xhci_usb_probe(struct platform_device *pdev)
@@ -146,7 +133,6 @@ static int intel_xhci_usb_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct intel_xhci_usb_data *data;
 	struct resource *res;
-	int i;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -159,11 +145,6 @@ static int intel_xhci_usb_probe(struct platform_device *pdev)
 	if (!data->base)
 		return -ENOMEM;
 
-	for (i = 0; i < ARRAY_SIZE(allow_userspace_ctrl_ids); i++)
-		if (acpi_dev_present(allow_userspace_ctrl_ids[i].hid, "1",
-				     allow_userspace_ctrl_ids[i].hrv))
-			sw_desc.allow_userspace_control = true;
-
 	platform_set_drvdata(pdev, data);
 
 	data->role_sw = usb_role_switch_register(dev, &sw_desc);
-- 
2.17.0

