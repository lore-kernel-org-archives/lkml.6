Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-23226-1522169096-2-9044337127394700683
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522169096; b=ufc7YFSVpK3h7LRmcn4/Oq/42DpMNbNI3RZ7hIJh7gl9lFc
    ceEh9YSWfDPOH+k+kPXoGf3pc7kgf7arj6C//nQ3lo46F1U3gdIOpvsCrz3cFhLv
    8ns3hup70/QilcaVpOw38zxF+MVu0FuDoNiubUP4FvV6BfJIL+AC/zBj7v8pftHd
    ygYd+33aVoNsvhC4V1h22syRQJkbfGKDrjvxxpm6R+TQdT3VHzI4Ol9aPwfT9wrQ
    lenHual9hjYPRq+loWG8dNdw/o2p2nlRK8fM/7fS86KshoSS8ZyVDc0+YybsH+8m
    MX3CyjK4FyLVVZ9afrkZpcSLiDow60aqx8/fKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522169096; bh=5pGi++857pjJKW0wzjJc978IX+
    aGJvoEe5ZH8pqXVbs=; b=X0l9r6xT9YSA9+/sCGLz00p+Trs+yO4rsPJjlpwkEo
    6MnMqF9mywBehlzgYDTVXjD9rcFzIITihCWWM80FeNEnMnPx3XZbfyvyAo1JDuxT
    iTMuFu0RS6Fg8QdtyTru09sMoIW+aNYvyOKc0Co57cc2vuEfFKQMvIpsNHmdfpDc
    XL4zp3DqxCfO4fgvy6EcRR/qmnU7ndYShK+G9uVVgstPl/LVmfiG51g0QI3NE9Xv
    Y5XTIM+1+r/xmgRlJrH+uofaoCYZB5B7NCkqpwk2M9yYnsB6aiffVO24k8NxFilq
    VbxN8+ojP2advbQgZUgSNGxTfU9+i9dpq7YcvzL27Kxg==
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
X-CM-Envelope: MS4wfNk6hBaRPSAXgEU66pxrc6rEUjnChhUbr8A6M7V84JMO9FHlIGkKxv/7KlSoI9O1k0FWkOEQrXE6U3OUdIJ4REG+sBZqBbAG9msUZyQfhCgllt0W4Amx
    ySl/HhNO0TEblFExMpsEMLvxBORXlHpcaRDoxM3aaXfcBme1QzOYlo/1M60XEud6A8Rdpp8kEQwTPmqHmHkOYKaBcQsGFSFEup/mOPN0nLH94b7FD7FRdegf
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=nTPwkA1SAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=hs5qnzdQf2hmqSGAq_AA:9
    a=QEXdDO2ut3YA:10 a=Her_73y7XSQQkpQYGz2D:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755662AbeC0Qof (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:44:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49564 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751066AbeC0Qnc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:43:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Andri Yngvason <andri.yngvason@marel.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.15 079/105] can: cc770: Fix stalls on rt-linux, remove redundant IRQ ack
Date: Tue, 27 Mar 2018 18:27:59 +0200
Message-Id: <20180327162802.926434251@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andri Yngvason <andri.yngvason@marel.com>

commit f4353daf4905c0099fd25fa742e2ffd4a4bab26a upstream.

This has been reported to cause stalls on rt-linux.

Suggested-by: Richard Weinberger <richard@nod.at>
Tested-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/cc770/cc770.c |   15 ---------------
 1 file changed, 15 deletions(-)

--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -447,15 +447,6 @@ static netdev_tx_t cc770_start_xmit(stru
 
 	stats->tx_bytes += dlc;
 
-
-	/*
-	 * HM: We had some cases of repeated IRQs so make sure the
-	 * INT is acknowledged I know it's already further up, but
-	 * doing again fixed the issue
-	 */
-	cc770_write_reg(priv, msgobj[mo].ctrl0,
-			MSGVAL_UNC | TXIE_UNC | RXIE_UNC | INTPND_RES);
-
 	return NETDEV_TX_OK;
 }
 
@@ -684,12 +675,6 @@ static void cc770_tx_interrupt(struct ne
 	/* Nothing more to send, switch off interrupts */
 	cc770_write_reg(priv, msgobj[mo].ctrl0,
 			MSGVAL_RES | TXIE_RES | RXIE_RES | INTPND_RES);
-	/*
-	 * We had some cases of repeated IRQ so make sure the
-	 * INT is acknowledged
-	 */
-	cc770_write_reg(priv, msgobj[mo].ctrl0,
-			MSGVAL_UNC | TXIE_UNC | RXIE_UNC | INTPND_RES);
 
 	stats->tx_packets++;
 	can_get_echo_skb(dev, 0);
