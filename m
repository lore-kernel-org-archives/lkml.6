Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519832537-2-2506557553653368522
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
    t=1519832536; b=tROVhWjatKV0H3EYRRo58QrTEGQ0tarlcalOoLb7H4G/3F0
    s1EloDWvHavxa5dqhzmnyXVNfDZISco/79GgVFf9bMMSy16o58Ov+L3sYvPokXFV
    pIkhT0ow5MSXF+h0MV5XjeTDSjG4RPhLDyXgL579luKNiu9glnGrczPdBBfL9HMT
    APmXNcXgZ4mgun73vTegFTff1t0ck3SPXR3xRzrf0qdk2feoFsi5VSOBzEManGVR
    7vMFBfwyfs4IdGAfLrrwTx+cLRY7VZmfIWukM0JLx6EZsPvec4ksX7Dkgn/JH+H8
    mICbXH/N77TYimEkUD5uCt5ICdj31AYxDtTGHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832536; bh=kYeC/bF2kn6fhjZaaCk
    4lkJaVQGR5GJFEf18F/k+kCU=; b=ZMibhgzzmxQCEURt7wwl27oF5qdvv8Cdmau
    FqE25PcTLYqKlNGwkhEokSoJHDB7yQUy89UpXrSocIZcXu2y6dSaqN4CqfNMCFzU
    oGRKDIz8MJBplw+tNhnUfzSnD18gtlzFmlfRKcbB7QjuHrTyzozX/C/roMneGykA
    YNQB8E6d+XcnVprnC8xMMmeOEEA4O4whOuslao39UVKF3TpQqWghoUefUDO0iM3s
    NlBWjkwiyZmipjLRC7eG+9lXwJgWeRJir0CSiQkEO6DeWnhDLhzVGssKa+4pL9DY
    BwXA3QcA1qGCnbLbPlv6eyb2SIdtgjab0mqE/XPcq7NEiKQJeWw==
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
        id S932697AbeB1Pi5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:38:57 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33237 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752731AbeB1PWd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:33 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Jimmy Assarsson" <jimmyassarsson@gmail.com>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.861434654@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 042/254] can: kvaser_usb: Fix comparison bug in
 kvaser_usb_read_bulk_callback()
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

From: Jimmy Assarsson <jimmyassarsson@gmail.com>

commit e84f44eb5523401faeb9cc1c97895b68e3cfb78d upstream.

The conditon in the while-loop becomes true when actual_length is less than
2 (MSG_HEADER_LEN). In best case we end up with a former, already
dispatched msg, that got msg->len greater than actual_length. This will
result in a "Format error" error printout.

Problem seen when unplugging a Kvaser USB device connected to a vbox guest.

warning: comparison between signed and unsigned integer expressions
[-Wsign-compare]

Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/can/usb/kvaser_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -983,7 +983,7 @@ static void kvaser_usb_read_bulk_callbac
 		goto resubmit_urb;
 	}
 
-	while (pos <= urb->actual_length - MSG_HEADER_LEN) {
+	while (pos <= (int)(urb->actual_length - MSG_HEADER_LEN)) {
 		msg = urb->transfer_buffer + pos;
 
 		/* The Kvaser firmware can only read and write messages that
