Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519839586-2-15683204205300992012
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
    t=1519839586; b=QDvL/K18Ety7TRZT+BRhzgw4Ez9yOfqnULyhvD/h6jVj5EB
    Pij2+dz6V2SHTj6wLwqhlZJ64fnO0LWkhzwLaGdMy4LgIrDUTNW0nKV5nooGR1vB
    VLuj+FhRPjnkafV9u31h6TDQVxX8BXX6P+MK6ZSxuE9aZGzfUkN8ixs55FRct92B
    SEz0GtKBa9clmLegiHtQHDM10BNf/eFpAwq4HMlOvpHHoGFUiWzMa2jQ30YpUePh
    4aY+uT/Y82Y285j2VtUWluNyVIa8APSZGdZss7x4n5tvhbvTp6xtt7xmydw1G+xI
    Dwaw3UKmRmIVeFGpbu5UPhVWhXXvHm+Z78MLglQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839586; bh=6I/myV1p+/jkAcV3QUT
    KZFwUznj2VAzkb6DI1MWYZeg=; b=D+QYO8JLnffUNXgnM35Zp/ao2oUQRLhL/AD
    DHZG3C23t/5a8AMPrhBvDRobi9wFEyJ5+aAtlfHeJftWfqL5wSN335+RXOWf/Byr
    RpHbziNAWKjPFm3W4avtaBHbHbzWLB1U0qaKBqekMJl+qmgqdAvxwU70zj6m+CPJ
    WpdYmkte46HpBajKI4o27NlIfrJj4bgX8+EoT3Y5ogyDZBPJBWlXSv6Rh/YKvNU/
    d51zOW7qT/rhc5X/pLsUMYwDa49rx56GP1zwGEeuplykqmLEqm6hszCciuBj6N1Z
    gEor5aqekC/8rk47Z3tbhjn8p/V4E4aGHvEwlGfYIXvoMwkvcaw==
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
        id S932947AbeB1RjP (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:39:15 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33171 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932531AbeB1PWN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:13 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Oliver Hartkopp" <socketcan@hartkopp.net>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.221203413@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 110/140] can: af_can: can_rcv(): replace WARN_ONCE by
 pr_warn_once
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

From: Marc Kleine-Budde <mkl@pengutronix.de>

commit 8cb68751c115d176ec851ca56ecfbb411568c9e8 upstream.

If an invalid CAN frame is received, from a driver or from a tun
interface, a Kernel warning is generated.

This patch replaces the WARN_ONCE by a simple pr_warn_once, so that a
kernel, bootet with panic_on_warn, does not panic. A printk seems to be
more appropriate here.

Reported-by: syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com
Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[bwh: Backported to 3.2:
 - Keep using the 'drop' label, as it has another user
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -653,13 +653,13 @@ static int can_rcv(struct sk_buff *skb,
 	if (!net_eq(dev_net(dev), &init_net))
 		goto drop;
 
-	if (WARN_ONCE(dev->type != ARPHRD_CAN ||
-		      skb->len != sizeof(struct can_frame) ||
-		      cf->can_dlc > 8,
-		      "PF_CAN: dropped non conform skbuf: "
-		      "dev type %d, len %d, can_dlc %d\n",
-		      dev->type, skb->len, cf->can_dlc))
+	if (unlikely(dev->type != ARPHRD_CAN ||
+		     skb->len != sizeof(struct can_frame) ||
+		     cf->can_dlc > 8)) {
+		pr_warn_once("PF_CAN: dropped non conform CAN skbuf: dev type %d, len %d, can_dlc %d\n",
+			     dev->type, skb->len, cf->can_dlc);
 		goto drop;
+	}
 
 	/* update statistics */
 	can_stats.rx_frames++;
