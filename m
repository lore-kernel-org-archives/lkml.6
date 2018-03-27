Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-196919-1522173888-2-8563807247398328360
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522173887; b=UAq3dI6v/eqQFeSHkRZXWmh43KXuUKjtZcJnNl8iQ+K/nr0
    nthMf2NHt5CsRF16r0Rb1HvIqpXtTU8UYLlOq7Wz4pO/hBgjb1ilulJZYs+huSTQ
    l6gQ02Gx1KE6olniS3K3mFkrxJUbkvd8YGbmiV9NhTMYUdxwSHIPRxOoXTHqF7Mf
    1aEUQVbhsecBIPou4TtJ4Gsimu3OGHJvSCr60CzTWtr1cHL0VwoqAb+4iHuIx4jZ
    uqMea8xCwxvO9togJLEP2NVf7+V26fX9YKGhUzlbPvrD61C4aV/J/RfP9oD9Mecf
    2mm0ZakAW+WkzvnwJiavfyPjnD7E3kjlbe1o+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522173887; bh=/n5NKa37Tq2XQLapCHoVEqizD9
    cP9vIYX5bE1GTpcos=; b=P7ws9KK4HtT1OXjkJvPCwTs1Up6J3zMQMWG63LfJPo
    Qg8+Z0aVMcianPC2S1N/h90lm3cnGNqVrLl2SMyqaVgiv83idL06XLbkyypQ1NfZ
    NvdXn8hYL7c4BACHdwq6wNpoQlHZ2xyZ44XOkJ70zK/2S/KBd9x4ztkuoFymOU3t
    Zu2h0Roen8bGokomE3qVxL/Lafd4OUv9uDrlakVR6coX0mlJwgWA9+FG9oRSk5Mk
    r2upCspr3FmrRyNyafVRnX+Xc2XljGiCflIqcOeUCSuuAA2Q0W3jaFIe9X97lXtG
    GiSnYlouzvEt8O2LDghKqPJXWE22OzNZCPBJOHx4w60A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPUPCpmGnDDnG8Zh/yyFSyEfJ9hbP9PCYdw2iED0TKxrI5mBFU9N0bB1UTtGXd1tpxlBnufZ/EK6v7mEAlHdutsE94O2cYvtB5WVT6NexRpbKjbxhPad
    xBaZsBKT+ROZs2XwBuhHHKmcBTuvXC97J2Qf4ho14VGfUxF2DBuap+Y3fI7Z6Yixio4YnE69pJckfCNlzSdPQgm4AQum/Z0mNtLTg6jCeeSXTvxcP9IYY78n
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=nTPwkA1SAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=k70z3KJa6u0epaJ5EroA:9
    a=QEXdDO2ut3YA:10 a=HUqATDVKn4QA:10 a=Her_73y7XSQQkpQYGz2D:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbeC0SEa (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 14:04:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41484 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752709AbeC0Q3r (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:29:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andri Yngvason <andri.yngvason@marel.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.4 33/43] can: cc770: Fix use after free in cc770_tx_interrupt()
Date: Tue, 27 Mar 2018 18:27:37 +0200
Message-Id: <20180327162718.269524359@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andri Yngvason <andri.yngvason@marel.com>

commit 9ffd7503944ec7c0ef41c3245d1306c221aef2be upstream.

This fixes use after free introduced by the last cc770 patch.

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
Fixes: 746201235b3f ("can: cc770: Fix queue stall & dropped RTR reply")
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/cc770/cc770.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -706,13 +706,12 @@ static void cc770_tx_interrupt(struct ne
 		return;
 	}
 
-	can_put_echo_skb(priv->tx_skb, dev, 0);
-	can_get_echo_skb(dev, 0);
-
 	cf = (struct can_frame *)priv->tx_skb->data;
 	stats->tx_bytes += cf->can_dlc;
 	stats->tx_packets++;
 
+	can_put_echo_skb(priv->tx_skb, dev, 0);
+	can_get_echo_skb(dev, 0);
 	priv->tx_skb = NULL;
 
 	netif_wake_queue(dev);
