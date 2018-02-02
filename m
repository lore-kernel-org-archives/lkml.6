Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1920597-1517561083-2-12380074731364850479
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517561083; b=nyNCXEiiNK5brA+5JgXo22RLr8JdzjzcfLgWhTa6FJCc6Au
    xuez7+4rDAQWit2EdDZRZkG5U7yK7akYKjnKSIuA+9A6dpo5w/O3uZiJfczdu1C7
    eENc+wpOJAnFU+GGGD62T2TvlLm/6gXtmTFctNLO27hAKHR7829Psk7OJCjGSBcY
    8alYwJhJtHgiScMnyzohmUAMDdT2+Vx/C84RyRrz+P5pvkOBtjS+Pff2A9UwjoWv
    6nw/3oswGpJEH2jma6du2bLxQNBFSEqzrkanvA+KIm6fxvPvSsr1daGcj21RuLFi
    prSGepa2zg+RBL28wYLbUEOjrx3/HUdxyatmfVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517561083; bh=T+w9s1CzWLP3utPlcLIiEvuXfD
    O29BCgTOl6GH8SdLg=; b=XLqJkyWrm2EJdPAJjkHXiBZHMeW0vZRlOzHqKmEgNK
    EwXMpHwJ1jYfvo6OBmJN/OWMkNtHpHg9oh2B+xeRcf7agOA+06Ajf2jpo50lgHxf
    kDdyOXQ3mtROuYA6uF/c3IesWYJ5RCBTJB2ODcfCiBNsQ9kdZNb31Ly+nKUcx4r8
    VnaX9YLsMIIIyyUxQUirO8CmOU5jtKAtNXkcwKdHEXy1o24HF0i3gOWF8yHaxAI6
    VNCUnXzIvf7yeIlPjQJghSlbc0EXxgEKBVD1GyJ3BFa4ijHrlGSO9jZKJ2RNKGeM
    rLsMwlO74h/5XsXLtgIyR/WgM6eSoLxNImtKLKIte2Dw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=realtek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=realtek.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=realtek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=realtek.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeBBIoP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 03:44:15 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:46693 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbeBBIoG (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 2 Feb 2018 03:44:06 -0500
Authenticated-By: 
X-Remote-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID w128i4F6023494, This message is accepted by code: ctloc85258
From: Hayes Wang <hayeswang@realtek.com>
To: <netdev@vger.kernel.org>
CC: <nic_swsd@realtek.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Hayes Wang <hayeswang@realtek.com>
Subject: [PATCH net 2/2] r8152: set rx mode early when linking on
Date: Fri, 2 Feb 2018 16:43:36 +0800
Message-ID: <1394712342-15778-285-albertk@realtek.com>
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <1394712342-15778-283-albertk@realtek.com>
References: <1394712342-15778-283-albertk@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.177.200]
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Set rx mode before calling netif_wake_queue() when linking on to avoid
the device missing the receiving packets.

The transmission may start after calling netif_wake_queue(), and the
packets of resopnse may reach before calling rtl8152_set_rx_mode()
which let the device could receive packets. Then, the packets of
response would be missed.

Signed-off-by: Hayes Wang <hayeswang@realtek.com>
---
 drivers/net/usb/r8152.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 756de9ea8d2e..958b2e8b90f6 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3795,11 +3795,12 @@ static void set_carrier(struct r8152 *tp)
 	if (speed & LINK_STATUS) {
 		if (!netif_carrier_ok(netdev)) {
 			tp->rtl_ops.enable(tp);
-			set_bit(RTL8152_SET_RX_MODE, &tp->flags);
 			netif_stop_queue(netdev);
 			napi_disable(napi);
 			netif_carrier_on(netdev);
 			rtl_start_rx(tp);
+			clear_bit(RTL8152_SET_RX_MODE, &tp->flags);
+			_rtl8152_set_rx_mode(netdev);
 			napi_enable(&tp->napi);
 			netif_wake_queue(netdev);
 			netif_info(tp, link, netdev, "carrier on\n");
@@ -4259,7 +4260,7 @@ static int rtl8152_post_reset(struct usb_interface *intf)
 		mutex_lock(&tp->control);
 		tp->rtl_ops.enable(tp);
 		rtl_start_rx(tp);
-		rtl8152_set_rx_mode(netdev);
+		_rtl8152_set_rx_mode(netdev);
 		mutex_unlock(&tp->control);
 	}
 
-- 
2.13.6

