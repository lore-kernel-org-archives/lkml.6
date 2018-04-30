Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1295708-1525092159-2-12713059807829949463
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525092158; b=f6crWz1NOO2vDvutrfFD2+TDOa4mDlV9zSPfzkf/CeCE8P46S2
    AcZAJOkGgBOaXCjgL5dGc/7ZeMM3HjiHuAevwBmjgoBmBqJWo8WiBr/nMqR3pKN4
    Y/UYW6ncTpyVc4W3QrjeqgLDG+Vg20+2fGH/AZOHRnJScYh9i0t7fBizNqF4DcFI
    06eS7OfUIg+a5bGODUaMxLsTWVxbFINvU5RRzJQHTC28tQasU4nWrjdsBNFByjOk
    5Ka9q3u4T5BV2NU4iC6wSgJwnWw5ssldQE4tlYMkPES1U9HXdSN7GhgbwX98LGEM
    tUAbWxSYHgI0BdxByOqzq2VACT7PbXuXELkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525092158; bh=
    Gyx2lnD9+F61UcKp69/6i1Je6WZh2P/U4FkMLB4xwvk=; b=LvUeDJIiLK2ACnxd
    wjOxyO+DMPyuGEzgjRwaIi1eaqn3NH8y9dD8eUgGf3DGYbITHo3mCmW8YWGHF5Bi
    uHtbJianEoN4dJq38fYhHpnq4vXl650PId1BcALicdIM4Wg/5WO5maOCfhARkOEY
    vGWLsu/JV1eTTzxcicaFvOzIIIoVJl28HRUchZvPf2L+4T4xhAXhSUi8R+a8qFi4
    QsrAAX0BWw4XwmBRjFnjL3Vld99p8RysCiEVYU7vOxhIoYVgbWMd9x+bGBoXOfxp
    dqdyqCvGS74pm7o+fVtoDam2p9zid1gic3P3G5QrazzrBRKTfgTdsqPF9pOVMUF9
    +NOxpg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFWrndTIOV4LM9i3vRj6ZEeKSuVq0uWQJRbH4VwSJ/X7qYXlYFqHTdU8OAXVKSZJrprqMR1Uxmp0h5o1foyXruInEAhfTqr8vHjpX0Clr8dclbsWnkGw
    O0ddFJb8SmGtGHbuTN2q4LgodilgSLGSniQZv1D6LvCAehsq9+dDKzQtsoS3fk4rUolC9TdBl8MX3RXfzXUANPHox/3nnk/wfuNX0al3gW/Ez3/frG00QqJx
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=aNI-wmK9kdO-_JBVu3oA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753753AbeD3Mm1 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 08:42:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:39224 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753110AbeD3MmK (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 30 Apr 2018 08:42:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,346,1520924400";
   d="scan'208";a="51127043"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 4/4] usb: roles: intel_xhci: Always allow user control
Date: Mon, 30 Apr 2018 15:41:58 +0300
Message-Id: <20180430124158.45269-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430124158.45269-1-heikki.krogerus@linux.intel.com>
References: <20180430124158.45269-1-heikki.krogerus@linux.intel.com>
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
 drivers/usb/roles/intel-xhci-usb-role-switch.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
index 28102127b9d5..6482eee6fd45 100644
--- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
+++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
@@ -43,15 +43,6 @@ struct intel_xhci_acpi_match {
 	int hrv;
 };
 
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
@@ -137,7 +128,6 @@ static int intel_xhci_usb_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct intel_xhci_usb_data *data;
 	struct resource *res;
-	int i;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -150,10 +140,7 @@ static int intel_xhci_usb_probe(struct platform_device *pdev)
 	if (!data->base)
 		return -ENOMEM;
 
-	for (i = 0; i < ARRAY_SIZE(allow_userspace_ctrl_ids); i++)
-		if (acpi_dev_present(allow_userspace_ctrl_ids[i].hid, "1",
-				     allow_userspace_ctrl_ids[i].hrv))
-			sw_desc.allow_userspace_control = true;
+	sw_desc.allow_userspace_control = true;
 
 	platform_set_drvdata(pdev, data);
 
-- 
2.17.0

