Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797899-1518708195-2-16605703972229064828
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518708194; b=KW4Yg0HPtWFQDagYQPIUoetfV+kRxPSdn0r9NRdUZjFHKy/
    B3LDkHgBg1nWswH1kRbLk4Q/W/HuMEnAUM0Qc0yCVhvNAIvgkq9lw79j9Asnq7xt
    8+uF3FVbFPKSt/hKmXqV8222j7h9aMmIdqP77bIrCSHU/nCzdBCgJvgnkrO0+QBV
    VDnb9v28NuOVWFC3zQQv2rHYBxUyJWP+2bYtSK1hdVhn6KS8Diamil1Al8P1WryD
    3VH0dGqJW4m3r1TRohoq/KxtVlkVmjJHDD++7I/2tpMslXgS8l5qy7XWbMVcfxHP
    GhmlYNLisVlI4kiEs/85/rp6hpF/TiEaszuY0Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518708194; bh=GopoaclYP63BQQ9C3Qdg8lVZGP
    Ry3Pji0LVkt+WvCaw=; b=wOOlAk0IOTY00FggQyY7eTy8OeWboiyW//lGKGTpN5
    3cHPjSj/8+DbVTuS0Ha3ynexnAdljgxy0jzTf3JCyITuCIQAhcYlagBW0j+Ykfvr
    GjUVUvob3BERn+jRQz9gStZwFpOsW6/FlmKiCcd2ShXor0fQP6t4HE6YnkNJHV+2
    uAQ0OgGSidJjXtKlYVsvN/vDNpCKnnqDN0Q19Qr99FuTMnmEHZ/1J4F0NVAECuHX
    h8zp1CWNJ09ibPVZsl6xqNxbme/MHDWdjT2JdR0DajwpHYRkmGqDPlB+X3/0BYyN
    b1cmpmjnhPSq7DuakN2mt7bRWN+NmFwCs2xtEzpRJLrw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162581AbeBOPXM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:23:12 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50724 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162408AbeBOPXK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:10 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.4 018/108] usbip: vhci_hcd: clear just the USB_PORT_STAT_POWER bit
Date: Thu, 15 Feb 2018 16:16:15 +0100
Message-Id: <20180215151225.118712516@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/usbip/vhci_hcd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -285,7 +285,7 @@ static int vhci_hub_control(struct usb_h
 		case USB_PORT_FEAT_POWER:
 			usbip_dbg_vhci_rh(
 				" ClearPortFeature: USB_PORT_FEAT_POWER\n");
-			dum->port_status[rhport] = 0;
+			dum->port_status[rhport] &= ~USB_PORT_STAT_POWER;
 			dum->resuming = 0;
 			break;
 		case USB_PORT_FEAT_C_RESET:
