Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835272-2-15550621364953184095
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835272; b=pzorCQjSGbCZVOptR1ad5pf24itSuEzEiAEP7v6wt4lsfho
    W/odb/q9mkB1ajo2adOVHMYbOy5g74nuaFLM6RsY8d08RVmXspyRhSwihxLEkMrg
    Qio9FVhbSu2wZVbC2F1hVIMyDW2YcdrwqoH6PV/9RUulNHT0YFcHx0cOdAnBa2iM
    tKi4u5Yx60t8iGPON/NLtrvK5rvAg9yTc/cX1a0VOo5/tQtK/d3Lr296Y/D8I4a1
    jJ3/HGgDvCwkWOXI1d+mGqjeQv8FsOH41hhW5FOL9anW3sw6Jgpb8enYjURZVUiN
    0IOTiUwC+0yuvPTSC/gWHkAEZxd8pQGLta+XdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835272; bh=qfeiSb0wLJisfyPKrqc
    FhXiJyl8RfZVtiUk6zNt+de0=; b=YblU9B8o7miG+3FMMDtWrXUzqbrRZwzvfL3
    ozGYSUaZ9Y/I/4Z/Ct1qmEXwQEgbF3YjcejvKdW4kD2XBGheIjWrJUCKBCBGOQMy
    424Y/Z8BsJV+m07ulLc+bTkJhtljqPYauCqSgMVTxQJySzutlmOzWcwmjXjXgw7H
    Jx/WqC9Nm6AnF55a22N7+IU5YJZFM/jahCLqZAKWWGVgLH839QbTCwtsCNHWihD6
    YC9hgMORi0r2ex/u4Sz1l3ojONPoxzYPRC0ijrwXhI3VX9neShcCQxJFQvuaozNw
    0x5g+4dpjuPbMms/djgYQeRNKnLOH1f8hTBpcN+r6B1sPINlH5g==
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
        id S933749AbeB1Q1e (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:27:34 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35201 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934465AbeB1QPz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:15:55 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Wolfgang Grandegger" <wg@grandegger.com>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.112846300@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 162/254] can: gs_usb: fix return value of the
 "set_bittiming" callback
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

From: Wolfgang Grandegger <wg@grandegger.com>

commit d5b42e6607661b198d8b26a0c30969605b1bf5c7 upstream.

The "set_bittiming" callback treats a positive return value as error!
For that reason "can_changelink()" will quit silently after setting
the bittiming values without processing ctrlmode, restart-ms, etc.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/can/usb/gs_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -430,7 +430,7 @@ static int gs_usb_set_bittiming(struct n
 		dev_err(netdev->dev.parent, "Couldn't set bittimings (err=%d)",
 			rc);
 
-	return rc;
+	return (rc > 0) ? 0 : rc;
 }
 
 static void gs_usb_xmit_callback(struct urb *urb)
