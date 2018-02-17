Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3572970-1518900476-2-4629156860207003594
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518900476; b=QP7wl9AGXVaHAmUjciWh0ianP+woZzOIq6zjY0uhDbCERxX
    +IwkABLIs1bQhY6+Z3rI7vQsgw1npjqm9UmWHv0saHOEB29XZWTIfSlQVNS5YMHy
    rvZ+uEvtChiNAf8HMJAgQlIIxA5yNhrCfwgwY04wpsn5HWJPZFTPFFWAMPoQyBuP
    /p+iNUNmR+U9KgqQ9Uy5RE6EQt5WuQb0mda/e1uL2bdkvJ0MFabIPw9bJOT0hfr9
    Y9FIdNIp1F0n1vPt2djQpr6jGob99uO7SHRy5hSUft5GDcEBJGobWxeETv2nYDSe
    BCqNXI4G7UHmyWbY4Tw/ditmXM3ta140T8vXPCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518900476; bh=ny32GS+IGDdExHVmh4r83dEugk
    jatazyb+IwZSkOmF8=; b=cyvapUw8mR1BCX8ZbgGteTkcg49tLv0ip7R+QmKFh2
    rFWHjyimxM6n0TYOt9yIYgeTyDk+5LalxDb6rNgYvWsBKSGxpcTbcbYhbcj2apc4
    +hSfd60kwTjJVS2IDbS416K2G7XyUTzUOazaUNZPoCiK2DJxtiJH36AnCvjZzifE
    76Jhlv9D6NkRMm7Ld+i5sI9O9fJSj/I7daCtAI3YzuZ3Lcg/PXoHROe1e0l35n9G
    saViBayih4XriZRESs4MXH5K9H/1+uyO0nUfUIJd76mkkCu0nZA9FhudM84DeTkI
    MezpCR34ijTRzhbZpL/m5Nvk8OonDeYaaK8aXomz7YAA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbeBQUrj (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Feb 2018 15:47:39 -0500
Received: from muru.com ([72.249.23.125]:57474 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751439AbeBQUri (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sat, 17 Feb 2018 15:47:38 -0500
From: Tony Lindgren <tony@atomide.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH] phy: dm816x-usb: Remove unused phy_data
Date: Sat, 17 Feb 2018 12:47:09 -0800
Message-Id: <20180217204709.27265-1-tony@atomide.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is used by some TI USB PHY drivers but not this one, so we
can just remove it.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/phy/ti/phy-dm816x-usb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/phy/ti/phy-dm816x-usb.c b/drivers/phy/ti/phy-dm816x-usb.c
--- a/drivers/phy/ti/phy-dm816x-usb.c
+++ b/drivers/phy/ti/phy-dm816x-usb.c
@@ -189,7 +189,6 @@ static int dm816x_usb_phy_probe(struct platform_device *pdev)
 	struct phy_provider *phy_provider;
 	struct usb_otg *otg;
 	const struct of_device_id *of_id;
-	const struct usb_phy_data *phy_data;
 	int error;
 
 	of_id = of_match_device(of_match_ptr(dm816x_usb_phy_id_table),
@@ -220,8 +219,6 @@ static int dm816x_usb_phy_probe(struct platform_device *pdev)
 	if (phy->usbphy_ctrl == 0x2c)
 		phy->instance = 1;
 
-	phy_data = of_id->data;
-
 	otg = devm_kzalloc(&pdev->dev, sizeof(*otg), GFP_KERNEL);
 	if (!otg)
 		return -ENOMEM;
-- 
2.16.1
