Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-9445-1523641306-2-13733463459891050260
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
    1523641306; b=R+NRsJQMrcUlFsyTSqVBvl420MwyNE7067HO21zSsktcJKfAe2
    tNTGgqa1tUosTJijb1olfecGr8g2zOEg3lTEdXLrEx+ez4F5S3hea5AQMAuODGtS
    l3A6I2z+dtANxDXwq0QH7bo0if+J0NAi/OIODhGUpzuCncmIc4gbx1roM4UkMEym
    tR/459oaZHPqT+F7PygzbbKLDXTHzufViXuP1W4FVbWSOG3M8odyQ+3vm73xGXfp
    wKzBjNotRbTHFXCeqI/AwZA+JSR0Dh4qNwuLS3UF4noSKVN2xpYmFOQXokPwdvIb
    0yhU2p6mOl7nOAQ3AnqJyzhh5azJORzEiXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523641306; bh=wQUQviz30AmROYEyzqjNt6A031lKfe
    o+TUTe+o5bYCI=; b=Ka2+nVKT23tuBVgYdAI8/nuFklNKhifVakSIrwwjrPdDFB
    o9uwEp7IoVzbdqgYcvvjZ0a9YKl2+wBl6jB2e/wWcmWPnY90HG7iluu7tnNFJpNi
    fn+EtvNhhAML3tf0uOhjJoPW+O5O76hIhpOOT66GLmPPhs4NO3fMtxl1ZcqJNc7/
    Lh9p6DQOLTU7jPNeXl710TAiaTmyYhTA3jR4MDNN+HRuFabbgbkndYbS6pTUJ1Vv
    zrUW84cY/MStpvL/kdEE/TBdcE/ixVtqlYn5VpCYI0WZzfD9uKYvTV1YUykuq8Z2
    Dy+CDdv3f23bWfwJ3N7h8iTy4M5TbPA15fLN4ioQ==
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
X-CM-Envelope: MS4wfJJMCOfdRx4pXHZdrJRIFi2uKXCVGYYU2/Sk0qk2GkiloCAnq2MpxpWtybBHpPDE2qGqCk+XFZt29QIVgW2TpoQYxHS8+UHpi/Azy5UJyXP5LrZlmttt
    o1RsMarZqQrAJIiNDmO/ioI6opQ+bXW7I9MBghYMWcWukV7WURXIPckAOSiFgzQ2CcvRWVaslxn1jXKFWFELTLDWvuc15s7uXav7YZmoGY3svEZJUyFz+BEk
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=YsvZ5-EkTph6n4u5spgA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750839AbeDMRld (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 13:41:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:7801 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750783AbeDMRlc (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 13 Apr 2018 13:41:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,446,1517904000";
   d="scan'208";a="43124054"
From: sathyanarayanan.kuppuswamy@linux.intel.com
To: gregkh@linuxfoundation.org, mathias.nyman@linux.intel.com,
        heikki.krogerus@intel.com, felipe.balbi@linux.intel.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        sathyaosid@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Kamil Lulko <kamilx.lulko@intel.com>
Subject: [PATCH v1 1/1] usb: core: Add quirk for HP v222w 16GB Mini
Date: Fri, 13 Apr 2018 10:40:59 -0700
Message-Id: <9bc2d73d74474258be14ec6a3fe243354e247679.1523640999.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 54b019e..f2ef913 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -40,6 +40,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x03f0, 0x0701), .driver_info =
 			USB_QUIRK_STRING_FETCH_255 },
 
+        /* HP v222w 16GB Mini USB Drive */
+        { USB_DEVICE(0x03f0, 0x3f40), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Creative SB Audigy 2 NX */
 	{ USB_DEVICE(0x041e, 0x3020), .driver_info = USB_QUIRK_RESET_RESUME },
 
-- 
2.7.4

