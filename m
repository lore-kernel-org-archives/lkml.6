Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-179796-1524182096-2-15522752283900413796
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524182095; b=arXuuxMtXiKaqOpXf5kGd3EI7twEbqu6qr0dl2si4wqXrwHPlJ
    SVcGrQD4OGLAVb7U06QHZI4kpwo/pgvO+7NYNLtt6IFkAT2uT3FuFoul1NWg4rNc
    zN68JRmDoJNBSaA3P+ffvLgMEbrUv9/TRqsKJUFQv9qKntp9u7Py+U1lXSBdM6eX
    1aV0BaoOjSLHMELCH0c5rqW0R2NZh+dovA2cR1e4C1JT7ausMNE/KYqNTNXWPyw1
    MT4rKRPd1sH3riDbXG3Xqf0wtm2R6MGiHm7f9CDAtzH3o7kxxvoFgUEWpaGXoUEh
    LnxAYCWPXQOLyvm9so1YH1TV8hoKnEDTnhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524182095; bh=aZY7QuxlbXAX4eM5JqpH/JLyQyIt7C
    KYHz/bMWPSMdc=; b=gO8Dczm15Fl/j6I9UifXhCX1KnMsrnT9YpUJf67IT8x/gX
    Nyzm676su8w+c/h5tHMeoVzhJcwnbazPjiW8W3upBhvTEnpIbFaO+VNJiixtsZQ+
    E0Cig75zVa25NzbBCK8NRlGtF83lf3JkVoCJAlvsvHcbyiM8Ep8tyyCi1un061OK
    8Rf+DsCekrqDcs3VO7n70sqOEk9s6gIFs4H0WLuTPeodlZN1CLAEooS2boOlcQhg
    qXzvEy3Y9FBwiys6C1cLbSbb6dAOBkhTRHmb1Hec7VGQv9UbcRCTF5BLspimpRo9
    4c7D8YsZ5eZTrjfmHXaAaKcc54wzpngSqkBy5ZGQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfOYPVVfA6ZBNgqk6WYnq5EaPwtOXRO3NIosaPXkMrmR0LWRqkMJFWXFf4Bs7s6iyWOTXVgGH0uGj9EmHftsck49bcO7lNhqeI3+OLbEKwMuluoMDxyhT
    byOId+OS78KAk1e0MXwKUupWl+a3IkLsq6/uW5CDzASO3oFYYC8913W9s87Ci8WIMDA7y0UuMaFSjAlJadQwF1BQZWvecdG2MmWtszRB418OtBteLpIw4QOD
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=YsvZ5-EkTph6n4u5spgA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753817AbeDSXyl (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 19:54:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:38491 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753581AbeDSXyl (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 19 Apr 2018 19:54:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,298,1520924400";
   d="scan'208";a="49313087"
From: sathyanarayanan.kuppuswamy@linux.intel.com
To: gregkh@linuxfoundation.org, mathias.nyman@linux.intel.com,
        heikki.krogerus@intel.com, felipe.balbi@linux.intel.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        sathyaosid@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Kamil Lulko <kamilx.lulko@intel.com>
Subject: [PATCH v2 1/1] usb: core: Add quirk for HP v222w 16GB Mini
Date: Thu, 19 Apr 2018 16:54:02 -0700
Message-Id: <2cda8d53172668ad76cdaf45107b002534acd2c9.1523903007.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kamil Lulko <kamilx.lulko@intel.com>

Add DELAY_INIT quirk to fix the following problem with HP
v222w 16GB Mini:

usb 1-3: unable to read config index 0 descriptor/start: -110
usb 1-3: can't read configurations, error -110
usb 1-3: can't set config #1, error -110

Signed-off-by: Kamil Lulko <kamilx.lulko@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
---

Changes since v1:
 * Fixed indentation.

 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 920f48a..c55def2 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -186,6 +186,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x03f0, 0x0701), .driver_info =
 			USB_QUIRK_STRING_FETCH_255 },
 
+	/* HP v222w 16GB Mini USB Drive */
+	{ USB_DEVICE(0x03f0, 0x3f40), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Creative SB Audigy 2 NX */
 	{ USB_DEVICE(0x041e, 0x3020), .driver_info = USB_QUIRK_RESET_RESUME },
 
-- 
2.7.4

