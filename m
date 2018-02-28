Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519832304-2-2203876806526375582
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519832304; b=RI4p0o+CpNWIO9TvkwhFMYbHzA0maSxuWtwD79VNBfGRNs+
    hh67b1R+O+07h2/gQ1dJuqqq2GwEyu7aKkf+mg0B0COouPuhKmSbuYkokOwk73B5
    UMAVqjcykyIPdvkYuOWlzN5Y9lEJ9iP7M9cW7O5y+DYBc+6MrOsVstIzNAGRU847
    l14QsJx/24hgVo8Ec5Yvfb9UtAFnKV3C7tktTU2o6CubNMnCNqS0W+pGCMiDYz9N
    xbMJU+eozFyK8CLgYqqcA3OxrO3BoFDKF9iLM4bnRySrH6SYnOwuISs+po6+iVh2
    nSFsoKfRHWn61/DKL2nwz6El1wztYopMcOiI8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832304; bh=iBxxcKZ0rhMikc1diWB
    U44Bpo7MVZ82CbMZQrpOGeUY=; b=DK258cz/4xNXFxNWExJuhwvJ2oAoN7HlaYE
    nFm+rsbusAkl/RXSnwim3QjQJDL3lWqouSmLCqKQp+JqJAdlp4+UCyEP0LbEbie2
    6h5ld7m4lXm5M/0VpS+XQkBNjvZTGQ7mFrcWovHvSaWJUSPpmOE9lQs/joPOBYk+
    S16tNSyPEdTqGhB58LHYjro1HgR7xmjQ2ytLcY29sYK3xhUAb5DNAw6cbjriSThB
    eJ2cEQy8VQsDzJXwINFzacEvIQWzNzmUdoEbhoWhwLGdFRxH/eRQa7CyYvq8h16s
    qOn2+yJUfL9Zl/+4YP9y2whLDUyOnIQDKpfKfVB5h6o9BHVVxSA==
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
        id S933262AbeB1Pgl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:36:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33256 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752742AbeB1PWe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:34 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Marc Kleine-Budde" <mkl@pengutronix.de>,
        "Jimmy Assarsson" <jimmyassarsson@gmail.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.203202797@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 043/254] can: kvaser_usb: ratelimit errors if
 incomplete messages are received
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

commit 8bd13bd522ff7dfa0eb371921aeb417155f7a3be upstream.

Avoid flooding the kernel log with "Formate error", if incomplete message
are received.

Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/can/usb/kvaser_usb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -417,8 +417,8 @@ static int kvaser_usb_wait_msg(const str
 			}
 
 			if (pos + tmp->len > actual_len) {
-				dev_err(dev->udev->dev.parent,
-					"Format error\n");
+				dev_err_ratelimited(dev->udev->dev.parent,
+						    "Format error\n");
 				break;
 			}
 
@@ -1001,7 +1001,8 @@ static void kvaser_usb_read_bulk_callbac
 		}
 
 		if (pos + msg->len > urb->actual_length) {
-			dev_err(dev->udev->dev.parent, "Format error\n");
+			dev_err_ratelimited(dev->udev->dev.parent,
+					    "Format error\n");
 			break;
 		}
 
