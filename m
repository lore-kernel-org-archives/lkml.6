Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-438867-1519831901-2-16142517127993538576
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
    t=1519831900; b=gIsv8noviOke2F5Z5otqq+ltdFj5yRHlMxnYMEJiwugbuq+
    4ZXaGbhyNntSOeApDXmMxn+r7SZCLFckOSgPZ7smoxrwJn9qreJ1bv1zp7jPTAIn
    c9Tg5gVV8+RZTYKJh8PKW8f6bBpuk9Vq1eKtLchBjB4g1MNeCusbJkmY8fPth4dz
    ghq8HY5P0JuDYCUmZGLCVylHGpmH+nJIAjAtrMgZOkxZ2tR61HqSRwAcDH+Ys65H
    6ia9xzTWfSoiQfXOxRvBDR7rO5kVqmabY4sYyZWubxsfDAeUUNBWlDghaFjnnlP7
    7KjYtZOTJS4tdhCWFhnTIayH+u7LRr5YkVY1PCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519831900; bh=MzzkN6bzQEWxWNxYCOq
    uNXxp9/AVFChRtW4qG2KhlLk=; b=lbHXDGHgkQHp8IP52/+MhMJoK4ubEmPUizm
    dFJGHZcAduodJ4GXC82mahzG+N+I5757wpF/eL3E737NH3GnwrJ+FUhyUv01P1XW
    50fYkIsml6ytnf18rfCd6c8bVAAIdfBkXtKkTz9wFA1DjpwEXdQVueDUvZ2RUUG5
    0S7BLjW7ABIc+jJNVQpUNUb0NQZvnIWCm93Q/IHSdjpaiHQT8EPEQv7ZsF7mBKwm
    cQBC9UsPIy4Ok4MPS/EfZj44iUXR6RAsDNyG1uvhRHWozAJm9UVsxcfQ+/eRoq1S
    tAnLZtTKYVpcRW6hRNUDaK9sWOH/cJn9Y7TWepUB5k0Mxf0fAWw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932956AbeB1P1M (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:27:12 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33333 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752872AbeB1PWk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:40 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Marc Kleine-Budde" <mkl@pengutronix.de>,
        "Martin Kelly" <mkelly@xevo.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.960051785@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 036/140] can: esd_usb2: cancel urb on -EPIPE and -EPROTO
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Kelly <mkelly@xevo.com>

commit 7a31ced3de06e9878e4f9c3abe8f87d9344d8144 upstream.

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
 drivers/net/can/usb/esd_usb2.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/can/usb/esd_usb2.c
+++ b/drivers/net/can/usb/esd_usb2.c
@@ -393,6 +393,8 @@ static void esd_usb2_read_bulk_callback(
 		break;
 
 	case -ENOENT:
+	case -EPIPE:
+	case -EPROTO:
 	case -ESHUTDOWN:
 		return;
 
