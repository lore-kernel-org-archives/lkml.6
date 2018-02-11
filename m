Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324862-2-1698551727427863020
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324862; b=ogv4vFZY+A5+lnjumOC7Z/kQ2YZgPmZ5lQrdBLjqf06PHVA
    RLKLwK7VAESYvTCPVs3fdVEels52Zh3HeBAaBo1aPY5t9L646pby8GVbww9+hkTt
    8as88IldP2JVInmsT7VUKMfbl2PFZ9cRW/+9NlY1n70SM4R8rwGyw1Jny4hJylO8
    RY6A6kkwiOvTCdhrQWR0W9sBtsY6px49pkmizhbMIK/2rxzn8vyh1mD/99oFx84I
    9SmYldzw0CJBYlM4AgKAylfjsllib9o9jfcxmGOJhfjZlERGb84egzrbC9NyZ7us
    AItTY6Wu5XRhC01bzHhhbdqzQOO5FqOplQjXAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324862; bh=ULlfCyK1mVNY59J9TrI
    nhfFOUCBRinlBq/MPjC+ohR4=; b=GRXWFkRWG1Rt2a0V4SLTy2e0dk4Kg3q+nWi
    pYS5KKeqon/I8BVRAbgv6eWNdV0qcOWmHhoy3AUhdz+1V22JfaPfCsOJNk0C1PbQ
    pi3FaVbknTv2W+GFj4DdPlWmcMT8ES1+B/hdBPUXnRsl/QRWdFTSBsrNw+TN2spv
    gEkd7Y5N1z7UNRqpb5z7p+hRNd3BM01SCRwP/q0WElrqHSXqlScCnXXYFnXKQsjV
    qOgOcONw3NVRWBNYk2is1ceD/qYtKilLhYRhWEMAXVo00kCsPvpac4TrIOYquEY2
    TiKQvHP83qm2Yz3tV5meOYDNmjf/vv7FeBqnAxlUA2HjTEvlKUQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbeBKEyT (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:54:19 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41726 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752804AbeBKEd5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:57 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Mauro Carvalho Chehab" <m.chehab@samsung.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.530009470@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 127/136] [media] cx231xx: Fix the max number of
 interfaces
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <m.chehab@samsung.com>

commit 139d28826b8e2bc7a9232fde0d2f14812914f501 upstream.

The max number of interfaces was read from the wrong descriptor.

Signed-off-by: Mauro Carvalho Chehab <m.chehab@samsung.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/usb/cx231xx/cx231xx-cards.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/media/usb/cx231xx/cx231xx-cards.c
+++ b/drivers/media/usb/cx231xx/cx231xx-cards.c
@@ -1185,8 +1185,7 @@ static int cx231xx_usb_probe(struct usb_
 	dev->vbi_or_sliced_cc_mode = 0;
 
 	/* get maximum no.of IAD interfaces */
-	assoc_desc = udev->actconfig->intf_assoc[0];
-	dev->max_iad_interface_count = assoc_desc->bInterfaceCount;
+	dev->max_iad_interface_count = udev->config->desc.bNumInterfaces;
 
 	/* init CIR module TBD */
 
