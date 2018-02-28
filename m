Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-438867-1519831899-2-12652100285572334104
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
    t=1519831899; b=j8EpC9jnuxCgRnM+t1z7aPfFwAbZkjPtPWfxghghpGiVY9l
    CZRYzdB5IJMDYqssRDQDPcedpoouFxI2LqI18BI3rxR2qivx1cOTIJKYOclHBBN2
    hAZ9pgPR91ofkvMCX6zclFC2ipFG/07tir/bd6f5fYsqZ49vch3+gwylN8QZbs8N
    H26SgAXXU1NX3+bFOwLGFtlqi50Jt92we/8hvXiMLlKw134NKm5+mbzk9oZ1HUv5
    mWA7QkxVaDuFihNrG/w03KLLu5tyMFDh5i4mitL+IJBDGq6GLnvqboF9hDLfGYIi
    iD2XgiNmz6WBzMB7R7dAUaRMGZB2fIrhenLJfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519831899; bh=airFOJ0XAyGS4nJCDds
    kNnkh5/belzc5BX4TF+MpxCk=; b=E57abPNDx9bdpCkzwoM1oRVTFNLQ+pr3zRN
    z/K8mLKavNSCyrtfpJeTGJmaPfSLfGW6eWHHg66HPo6Mvji99cHzwHhOi9jc/fPE
    4FcW8Sh4wgaMlE8sw8yqTuNlooau7+H0oPoUOm0OzKHe3+e9yZLKPOKCXX/u2Ptq
    /LMr2HgOqcY3VakDQY99qqve80ndPCEssGmcTyGyKNgSBAVQsecJIXId2auSY8x0
    geJ2Vy8iM0TQI4lY5YlwfkmtwibTiOvL4gl/KvkjiSG9P9RWU3WP3wlIr4zYAkTG
    OO7otaoaAg1FLFxvN3+Wq5KBxHGJIWNs3368qMFOZlHRKe7NVjA==
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
        id S932958AbeB1P1M (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:27:12 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33339 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752871AbeB1PWj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:39 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Martin Kelly" <mkelly@xevo.com>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.641670032@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 035/140] can: ems_usb: cancel urb on -EPIPE and -EPROTO
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

commit bd352e1adfe0d02d3ea7c8e3fb19183dc317e679 upstream.

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
 drivers/net/can/usb/ems_usb.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -292,6 +292,8 @@ static void ems_usb_read_interrupt_callb
 
 	case -ECONNRESET: /* unlink */
 	case -ENOENT:
+	case -EPIPE:
+	case -EPROTO:
 	case -ESHUTDOWN:
 		return;
 
