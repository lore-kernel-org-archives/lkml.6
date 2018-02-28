Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-476314-1519833411-2-17777049815594087177
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
    t=1519833410; b=e5hnHVJdyhbcUyIuajo+ndG0uFXaOGrPL+eUPPzd3JGgxgu
    uVKnGegwoRzAUamNr5qKM6XZd4exJu5taDXQ4bje19sgeXsXBSPt+t8eijdbpZf2
    DN54VwhCbW1rVVCVCqR4ABFtjxW4QtnLCFto1Jvz3tRep8O5ZVqySp2Lt5GBptFG
    FyCeov8GSQF87e8YWDvBRU2zD3a4Im5o7lvXR4hujWrMlsfJTOb74Fj+n9LRwaFK
    B+f3mLvF6fuazGptB9LE5kDa4M9jfjtlm+AN0IUcWBML1ahsaz9OK71Ic4hTQfGX
    fIuKdOQGzcyY0sfa9tFzNtPWSP1X1gLAiaPn47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833410; bh=3KCPpi5Hc409SCXpDGX
    iCh6f++DVQwjeBsfB1mZJdvU=; b=nPkuzJU2iH6SfhdbaxwkzuYUUdCw43J/xzo
    hjhymz7QdnusGZAQh4ZewTj8D7WxQ4ffeGQ+XCLF/hIjON6tkJwwXNaRB2j74dtU
    9Yq9/xARxxOOp+x6SF3ichJ8hSM2ArL9dA6f/MN7SILsulhbBBjDQhusYccGXxky
    rXIVl16IqYSAFTZonV/Su8bzBcKpO4NZvP9xghRJXCh0IrNpNOhvQBs9dXk+hAtS
    MR9Ur3t7JwUqVNhZtQ4sJ3bKFl6F1dT8jqm8HdE5vPE1AZgc8Nl90BFdyN6exIgx
    UkXnMFppaxNr1NKu4NFIUlz0opOc9/wsytUTXt7TwZVC9dFDnxA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933691AbeB1PxO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:53:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34437 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933975AbeB1PxJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:53:09 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Mike Looijmans" <mike.looijmans@topic.nl>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.367221591@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 024/254] usb: hub: Cycle HUB power when
 initialization fails
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

From: Mike Looijmans <mike.looijmans@topic.nl>

commit 973593a960ddac0f14f0d8877d2d0abe0afda795 upstream.

Sometimes the USB device gets confused about the state of the initialization and
the connection fails. In particular, the device thinks that it's already set up
and running while the host thinks the device still needs to be configured. To
work around this issue, power-cycle the hub's output to issue a sort of "reset"
to the device. This makes the device restart its state machine and then the
initialization succeeds.

This fixes problems where the kernel reports a list of errors like this:

usb 1-1.3: device not accepting address 19, error -71

The end result is a non-functioning device. After this patch, the sequence
becomes like this:

usb 1-1.3: new high-speed USB device number 18 using ci_hdrc
usb 1-1.3: device not accepting address 18, error -71
usb 1-1.3: new high-speed USB device number 19 using ci_hdrc
usb 1-1.3: device not accepting address 19, error -71
usb 1-1-port3: attempt power cycle
usb 1-1.3: new high-speed USB device number 21 using ci_hdrc
usb-storage 1-1.3:1.2: USB Mass Storage device detected

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/core/hub.c | 9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -4792,6 +4792,15 @@ loop:
 		usb_put_dev(udev);
 		if ((status == -ENOTCONN) || (status == -ENOTSUPP))
 			break;
+
+		/* When halfway through our retry count, power-cycle the port */
+		if (i == (SET_CONFIG_TRIES / 2) - 1) {
+			dev_info(&port_dev->dev, "attempt power cycle\n");
+			usb_hub_set_port_power(hdev, hub, port1, false);
+			msleep(2 * hub_power_on_good_delay(hub));
+			usb_hub_set_port_power(hdev, hub, port1, true);
+			msleep(hub_power_on_good_delay(hub));
+		}
 	}
 	if (hub->hdev->parent ||
 			!hcd->driver->port_handed_over ||
