Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-402196-1526281362-2-15060975219947589602
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526281362; b=f21LIKexiKxl5ja9BTjGQFAD8gSyBxAc3csOQ2eXDSf6w9X94t
    q8dTY+9Ks8qSs+KjpIA4kjOKTXAmEI51HeJjhUcGPKrCAVMe0JrZzVxJdeIJ3t43
    FAsxZYhrp0bME/xvfwgwbrCMuWsJIhYg0yaHxfq2aYurzJk2JRNn0q7oSpwUv/q7
    ZLsdI+bR1fkrkQDGdXRsqdvKsEuc68cQMiFBBcWPc2m2V+bJLguvajj6OQr8RsKD
    Z9RMVvSg/BePFOKH7QebUfc8joUQSbuJpWjodx0fC9Qz3EljLTb4YbMZ45+pVA3e
    h9Ngh9UXTH4vnh3vaZ0/GLrVzd9U9IYGIMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526281362; bh=5+hpAODjnUac1g99/fP3Xd59Dm4snd
    8YcgIqa08NRTs=; b=nfGqAVui9pbHz4ziwKWwLc42yzYQrZR52kloPU+YYFcNZ+
    mJopVBjytaoeUpizwqt7RsQ7dZcrBr32FCMc3CwCkr5HnKrdaJMDUvzqa72QwGlH
    SFe7zdIMOMCbZImZxHrA2XOjsQDU+uk1iL/yAo//hvrrQN6AT4dUhX+qFRFqisEl
    ADBgK+BkUO+AC85j/drfGWEo+lmpsQx48HvjxB52qWl8l/fJCnb/BqNdwfcTU2Qm
    eyVRNLBnwTGFa/I5Mojl+vSzC66mmurnPI78y1RuMIoHEJEqAaPbVVLgQLwpDMqV
    aybPFq31RooWJqTvVbT7tdoPrDOGlfUhI7p3owKA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=U6Qt5YNg x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=U6Qt5YNg x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHS7pbyE/Xv2jyUoPK3pSdtBMuKk8GFkaAXteYQNyVnaVxX3KNVCqyJqT0WeGiuXhCUFtw4ca+LGOVJHdbMuQ1nyeur7hOXHyHpfmMKM6P/bx2nQXFA8
    9wy7tmMwFIr1dS4NQHmxq1mKu2brGzw8We8zN14DEktLi0BPgyRhN6fyb8dNNXm35epz8oc8W+illU5QEDdAct0yV1bWfzs4RqSzH8zBP6QrRY7/4LZN6ZRx
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=t0M9nft4AAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=sfoQkU7UpnacVtsXjZoA:9
    a=QEXdDO2ut3YA:10 a=9blVyPJtsqGH_lG0htnH:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbeENHAn (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:00:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754173AbeENHAm (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 03:00:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jimmy Assarsson <extja@kvaser.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.16 36/72] can: kvaser_usb: Increase correct stats counter in kvaser_usb_rx_can_msg()
Date: Mon, 14 May 2018 08:48:53 +0200
Message-Id: <20180514064824.697518152@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jimmy Assarsson <extja@kvaser.com>

commit 6ee00865ffe4e8c8ba4a68d26db53c7ec09bbb89 upstream.

Increase rx_dropped, if alloc_can_skb() fails, not tx_dropped.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/usb/kvaser_usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -1179,7 +1179,7 @@ static void kvaser_usb_rx_can_msg(const
 
 	skb = alloc_can_skb(priv->netdev, &cf);
 	if (!skb) {
-		stats->tx_dropped++;
+		stats->rx_dropped++;
 		return;
 	}
 
