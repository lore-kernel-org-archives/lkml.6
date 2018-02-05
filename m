Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3071467-1517852788-2-11665015509216667235
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517852788; b=qt9eRFrL50qgG5yjVnrL8ooD4tAhh7S8lXnTauDqmL7LlDi
    crY8kZF/a/KifziavtXG4qLrEw9ix2Lumwo9zT/T7yWjqTble+jSvBRTwA3YcQSB
    RT2cYPjvVCWBrkT6AbH+vJ/U2uBSINT2frkwBDEkdKPLRnhy9EIGokDiSV6KQpXH
    /od3h4dLR7956R5gZKTerniCYkS27YakkpK8StAXOUmXdIPiGmNdzMsEl4/tpRrk
    N14mMePQO6J5QCA27rjKQGaatBS5vojxLPdbN4XPLgCdZlxlD9SxhhHpVftzUv/9
    4bMy9qBfJfvULEqID231QRnzxxXFtm2NquTMDWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1517852788; bh=KwaHcv3kE58dUDL/uHOumlBH/RJMbNoWI+c
    SX1vW9PU=; b=isJ9mQ9CRG55SAu7ubNeAi3w6IFLjwQg1yEpHDyrYroZfXP1W7m
    u9UgcQxRSqNiR7DfwQfUQ3MQjWr1b+Wp0se8KQn2w8PFxZZAgPxJZVGqxmzYqlAi
    Lj/dJDq36kWmlPfm6XczXfpWljJf8oPT9jeOOFp/sWJ0qNHptUOJ+ZojUqy4T1XK
    4WHx1Aw/yPt5e0yXrsM5d/xR70M+HeZPsyMnC1Yn6EnIt+NC+0zuJElUfQE+ecYW
    ktbnIMz6s13e5gnurBO1t9lYSWt8iZ/K2/12XhskJQjD/WuAAf81L8yQqKQesFu5
    y/b+Vq5+6ij4d+xkyIxbHW4YdeRLrqBoFTw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753300AbeBERqW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 12:46:22 -0500
Received: from osg.samsung.com ([64.30.133.232]:42020 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753102AbeBERqU (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 5 Feb 2018 12:46:20 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 4.4 v2 1/2] usbip: vhci_hcd: clear just the USB_PORT_STAT_POWER bit
Date: Mon,  5 Feb 2018 10:45:55 -0700
Message-Id: <8a118955998e8b3d101b8105f786cee354256d41.1517852038.git.shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1517852037.git.shuahkh@osg.samsung.com>
References: <cover.1517852037.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1517852037.git.shuahkh@osg.samsung.com>
References: <cover.1517852037.git.shuahkh@osg.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Upstream commit 1c9de5bf4286 ("usbip: vhci-hcd: Add USB3 SuperSpeed
support")

vhci_hcd clears all the bits port_status bits instead of clearing
just the USB_PORT_STAT_POWER bit when it handles ClearPortFeature:
USB_PORT_FEAT_POWER. This causes vhci_hcd attach to fail in a bad
state, leaving device unusable by the client. The device is still
attached and however client can't use it.

The problem was fixed as part of larger change to add USB3 Super Speed
support.

This patch isolates the one line fix to clear the USB_PORT_STAT_POWER
from the original patch.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/usb/usbip/vhci_hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 00d68945548e..2d96bfd34138 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -285,7 +285,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		case USB_PORT_FEAT_POWER:
 			usbip_dbg_vhci_rh(
 				" ClearPortFeature: USB_PORT_FEAT_POWER\n");
-			dum->port_status[rhport] = 0;
+			dum->port_status[rhport] &= ~USB_PORT_STAT_POWER;
 			dum->resuming = 0;
 			break;
 		case USB_PORT_FEAT_C_RESET:
-- 
2.14.1

