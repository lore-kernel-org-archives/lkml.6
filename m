Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-840750-1518038593-2-17398300838268161138
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
    t=1518038593; b=QTkFiY9U9MNxMYEH5wCZvypzlKnxKpOHHBmdv8vP9kJJzn1
    EC84Gda431dt5FWeC36uYTepeanrGhAN0wIjKOxccuOO/UeJYahGFPnt5cWS7jX2
    wC9X+qAYzCzcsUqQJ+qp/u6+udrfFw+1QEdlYQ+0LB6YfJthH5YQ12wupG3huD0r
    MW/t89J6Wz6flibL1khhIQ4MqTEUBkIsowz3W/FPR0zwVV6tNuqrbAlLuJaiE0sK
    m29XHI8dvWEKy6RkoBoG2GEzAuZGmseISe1mhya0nsP8HtIxA4IEHcpdX4laP1JK
    0HRAOdGPdcGrXqp8jnymMZGs5RUP26BeQN96I0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1518038593; bh=/0/DlyYX+OfcaNGmlfEaMh4DFVCsgr3igBo
    cQsBzvY4=; b=o2F3aEXlGsrL3AcUhemkAxhJOiRcX0LI6Yqb5W583l82WD+MU0b
    ueV8w2Rjn9jMpfbT90TwI7X/8rgWsVd7+nUutTOKMY4GhoFo8T7OOlz9W+RnjQVY
    1GcinwHDe4yUanybN7uWiwVTLVW8fyfZa1qijIeyrf088HmiVnKvWkyBrJOFiDLS
    UTfT4BOS0mh9oaClAGbYhl3Zn7+mXRvCVluxlLNuXs1fIIkGLcyyGm+WbP48e8Av
    fUeGHw0TnWIOETFZphbVunjrKdGGviNo0knZ8Nac4+b4qWPnxz0YgYGlE3rp2kii
    UXnfbrSKWKUpSwwAlrJ6gAXK5tJznHtAvZQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932290AbeBGVW5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 16:22:57 -0500
Received: from osg.samsung.com ([64.30.133.232]:42287 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932277AbeBGVVD (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 7 Feb 2018 16:21:03 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 3.18 6/9] usbip: vhci_hcd: clear just the USB_PORT_STAT_POWER bit
Date: Wed,  7 Feb 2018 14:20:29 -0700
Message-Id: <c90a25c10d82a92c7632593f864244ee087872f3.1518036867.git.shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1518036867.git.shuahkh@osg.samsung.com>
References: <cover.1518036867.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1518036867.git.shuahkh@osg.samsung.com>
References: <cover.1518036867.git.shuahkh@osg.samsung.com>
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
index 2c7bed7b19d6..e480b924a04c 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -279,7 +279,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
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

