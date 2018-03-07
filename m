Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4155223-1520454293-2-17790803144501823802
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520454293; b=GoOaCbTX9xAgvpxNgUmC4Qi34whS1Z7sxegObYMpxZsx2VK
    fnp6Hh3aMGuGzHCJpBosGB59JutjI73wRmntF+3+ibtMm08zkJHFGpjx/1881Iyk
    bHvmwymHXwdbIxHprs8QQUOzq3DWynvntJwfRls19MF2ycjC1XBpnFY8LEJ4jfn3
    kQ/DJxfOGfCTwljEupFCWkxyuBajkhcT6/lJ7/q83vWY+SxQqtq3tyHzTmXtLvRv
    Yv6C1ijdpiu7pMmZqMfcP4+JNFagR6fwrNefNjF6vXtmXixGZ663K3LF/yufjAcc
    y+0MVRNrptBkQ5cdgG7zCbo/MY1H+lwfCoaxHLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520454293; bh=014rqgN0ZxpNMlRqMIgcba7Cli
    vF57VOb+4DVFAyXHo=; b=eU4HAcRoq8+eqlimN3Z5mpADANXzZfoumFDrU0SdH3
    S7Zo/XA6nyjbxNqEm0DflJSoI+K1Y9o2B9j3UcTAxBXo39E8JdM6+cYlHfjPnOHa
    U3FsuVjXBUjiqbEWFZt0DKuZvfwxt9r0MglLWLywsOHvaLMDSYSzNFAEflcUvzB3
    TtF8kN9vZSChme68NGJWetKQi3dLtFuIb9E2XH1FcewJOvNE2HF2pQA8IR6JfxHQ
    g9I/+Le3YUPR+LTw8/0DtHh/e7Shho6b1a5HRwFqjRg3gLR8vrwSzcaCXVEN6tfI
    dBtPkjRo/aB8dfcHEE1e4L6FGuBmnb6PoO0iaSEUUfBg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964962AbeCGUYN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:24:13 -0500
Received: from mga11.intel.com ([192.55.52.93]:30107 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964783AbeCGUYM (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 7 Mar 2018 15:24:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,437,1515484800";
   d="scan'208";a="22821885"
From: sathyanarayanan.kuppuswamy@linux.intel.com
To: gregkh@linuxfoundation.org, johan@kernel.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v1 1/1] USB: serial: Add boundry check for read_urbs array access
Date: Wed,  7 Mar 2018 12:23:56 -0800
Message-Id: <f48feae7582a5669422066b4821a9e310eebc9ba.1520454192.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

In usb_serial_generic_submit_read_urb() function we are accessing the
port->read_urbs array without any boundry checks. This might lead to
kernel panic when index value goes above array length.

One posible call path for this issue is,

usb_serial_generic_read_bulk_callback()
{
 ...
 if (!port->throttled) {
	usb_serial_generic_submit_read_urb(port, i, GFP_ATOMIC);
 ...
}

This patch fixes this issue.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/usb/serial/generic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/serial/generic.c b/drivers/usb/serial/generic.c
index 2274d96..72ebdde 100644
--- a/drivers/usb/serial/generic.c
+++ b/drivers/usb/serial/generic.c
@@ -306,6 +306,9 @@ static int usb_serial_generic_submit_read_urb(struct usb_serial_port *port,
 {
 	int res;
 
+	if (index >= ARRAY_SIZE(port->read_urbs))
+		return -EINVAL;
+
 	if (!test_and_clear_bit(index, &port->read_urbs_free))
 		return 0;
 
-- 
2.7.4

