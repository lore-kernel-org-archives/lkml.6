Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-620147-1519837384-2-13258172664925318274
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519837384; b=ZZqwsEUCbkWmrQOX+Jr3YO3cBIY+4cs+6M8ccB+qGXvSloq
    cMD++uAYuPT1HGXmXmp0hdeE5YnYeorMveJ0CUIV/gQlKjxZEP6VESGaCJhhM0PB
    0aX/6ixgJkOzHFFkLZ5qFpmXHD54KW9TXF2Pv/MWDJQeUgqL51O10Tuau53UKyqS
    RA0Vgfa9F/AJ6u01iSn04JGJ7N2+HjQSnEwGDbhJPXYG6d5NCKw3c94jXhevl/Ul
    WcrPkOY5lwhfpoaS9ZaTkRQGsLS+ZVcSHWA8WcBa8uP39GJ/TdjnAWm1NxKDk62M
    9blz0Wsknw0/9TO+BiUoKoL1mDX74ENnr6zSm0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837384; bh=52xfxLlkMJDg0RFgJnO
    dPrv35hHBBv2htDLYDtH4CxU=; b=LoWo1Ci5QO1wdbwoB84gcytODglSwXbdC44
    ylOrDL/Uv+LSeNFSeWXilwKhaKtg6drOKSE4kiJpeQ2ko7xg0k/pTxEaezIjmdYI
    rNC37nCqWXy29ewA5G1qIchZJKkXPMznVdCZ0V1QTqSYnUhBoDNqkbH/BFzR+eVK
    WsLATuH67xt67yd93ewJx8YndXkRwtxCfDHAZGV7L8J45OzuRePACJtnyf185XBq
    FnQ/FIYsRSy2bjXsvMUGu/1EKaKSO2iVhjs13HB1tiHKKxEr1ptvOWEOHmjxv8VP
    SA8G+NTjuwLgJOuQg4OWaiLuVbP5Vgl1sbJRNwUQRexYuSkESVg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933759AbeB1Pvv (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:51:51 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34352 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933736AbeB1Pvq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:51:46 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Martin Kelly" <mkelly@xevo.com>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.397936130@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 070/254] can: usb_8dev: cancel urb on -EPIPE and -EPROTO
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Kelly <mkelly@xevo.com>

commit 12147edc434c9e4c7c2f5fee2e5519b2e5ac34ce upstream.

In mcba_usb, we have observed that when you unplug the device, the driver will
endlessly resubmit failing URBs, which can cause CPU stalls. This issue
is fixed in mcba_usb by catching the codes seen on device disconnect
(-EPIPE and -EPROTO).

This driver also resubmits in the case of -EPIPE and -EPROTO, so fix it
in the same way.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/can/usb/usb_8dev.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -527,6 +527,8 @@ static void usb_8dev_read_bulk_callback(
 		break;
 
 	case -ENOENT:
+	case -EPIPE:
+	case -EPROTO:
 	case -ESHUTDOWN:
 		return;
 
