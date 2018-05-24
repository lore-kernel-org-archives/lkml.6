Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602388-1527149970-2-768311508845835169
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
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
    1527149970; b=ZkK+FNe5CmaQGMX2zJAnWTYHr6a3MIfROpFyiD6YFJv1NBPnzV
    6CKw318xeaM+w1w2axGxlQV9MNXTQyzcTq7AhC9B6jDYShURXNAZqIz5WdkvNrK3
    oJobsMYwaqnXkg7om+detc+0INJxckMa8PKUxE3Kii81SCwjAGEufwaoJ/1FDubp
    IUa98/7n+EmsdJN7u/mTG3PbASFuiaIduz4uJ7zJRCakUUUR0uRliHjURzlqrhHf
    C3MuJlw2aVfloGnRD353cJ+JjU5VOILu+HsxGOwdTYWeiA86n38R6ScpRLMM25S4
    TFDVbba8GswsE0jAx9kxMNQIinkN0d3njvsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527149970; bh=
    cEv0j1CnW4jwkIYN77e/7WxfrKN4nlYbJZdXz1GKYms=; b=LlkV8gq2pxFQEpkt
    GnNFuFBbKpz3EkhK16iEFhTlSo6p9Cej5IXZpEmlhjdeQ8AXEfby7HlC/c0SKdzv
    ThgVEZCQtIjmOygFWWZyZHkZ6/fQ06cBX7Q3Zi8k2ad4oiNkAxuh6tRj3YwXbfq+
    DdsR3beM6evSRDsg+Gam0aKZixSU39LJK6qQZoDMwc7WYUTzqaTKCwbPMRtyxcKC
    1RTwA/fIA5s23QcAwgnBXkxZvwPnwka6LrWefTAvRP5A4gIwN+yFWK4WfoMRK4XN
    Xx6/bcRZE0EPeRKcsJGjfZRpF2oHWGFNi5Ci6/zNpebln2Ii8AiOC1bWN22jZMGh
    jm7lzA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfIbIbM2ioTwbq0YAyz0RE33UIFSpvxC6Z8dVb1YoYR8ErHiMc5Bb0j+9s7VhreVtrvY7XRC3cu4gucdhm+h5NVxKDfeZvo2nvp1CRersf+vm128B/uma
    3ibVdnE6dVJfAyCC4bW78Oe7745PLlQ5+fIwaL9zoesQpQj67lA2eYtSV84TEV+kpuNsBFs1D43abuN5ZFt2ZbK7ct3fqd1lJ8sVlNVW9hWbU9K3865gKYWL
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=VgRjuRsXx-d-BTbMe_AA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965230AbeEXISg (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 04:18:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:65272 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964867AbeEXISc (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 24 May 2018 04:18:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,436,1520924400";
   d="scan'208";a="58073597"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v3 1/4] usb: roles: intel_xhci: Always allow user control
Date: Thu, 24 May 2018 11:18:24 +0300
Message-Id: <20180524081827.37861-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524081827.37861-1-heikki.krogerus@linux.intel.com>
References: <20180524081827.37861-1-heikki.krogerus@linux.intel.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Trying to determine the USB port type with this mux is very
difficult. To simplify the situation, always allow user
control, even if the port is USB Type-C port.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 .../usb/roles/intel-xhci-usb-role-switch.c    | 23 ++-----------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
index 28102127b9d5..6e922b50b674 100644
--- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
+++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
@@ -38,20 +38,6 @@ struct intel_xhci_usb_data {
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
@@ -127,9 +113,10 @@ static enum usb_role intel_xhci_usb_get_role(struct device *dev)
 	return role;
 }
 
-static struct usb_role_switch_desc sw_desc = {
+static const struct usb_role_switch_desc sw_desc = {
 	.set = intel_xhci_usb_set_role,
 	.get = intel_xhci_usb_get_role,
+	.allow_userspace_control = true,
 };
 
 static int intel_xhci_usb_probe(struct platform_device *pdev)
@@ -137,7 +124,6 @@ static int intel_xhci_usb_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct intel_xhci_usb_data *data;
 	struct resource *res;
-	int i;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -150,11 +136,6 @@ static int intel_xhci_usb_probe(struct platform_device *pdev)
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

