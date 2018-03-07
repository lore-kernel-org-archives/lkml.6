Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4119318-1520452971-5-4478646932759786227
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520452970; b=DERnZ0GZsijUN2MbyOkuw3DDx8RQfdXdNqDxTY6ouhUQxM7
    8or8nt0UTOnsp1XfSGotl+43/ksVUXfhsCJdb3k4eXvpMssv6bevGzxgZD/m2T6F
    h1wY5G7g/Xr/V7/b8aUjZRIIRM3GlQA4ithX4ye+FYtC8s2PNnlgCUX0FlD+X+IM
    q5YSleK5Bci7j6ITy3BuoNytjj18rvmH5zScFEzsNjgquLYTHVD1txsGRwMGtUT1
    0HMkW+kv9Di4TFWLTsgoDd4xj4qiDnZV7BFR9eVyUyaJ0d7DgKpFczcNKK4uPlaz
    hTfMGeW93KIyyWHFs7Q5PnJK2b7dtK+ztnPk5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452970; bh=488pdMX254qnt7ULRKKjp/ioAD
    VaYcMOP9R4AqXQgdE=; b=oXfruoT5DmJI1WjkGGgSeX6Z5MykTUT9ZqYA+6704n
    TCsJ0Vj6Fw4jmvji1GnrVtGGgazZJgjPl5rAno6EBRYsi4ydBBVj8S4dl/8j3qDp
    pox8mlt17Hci1vOKbTLlx+cuOYmu98jnyxhilYrExSy9CbZQ1aMHyJJOHxDPns1y
    b0raaNqPui7ssjF9t+ul8263cxePkiykxJiGZwwKXmVUDuFF5iVfiW7AOvyDtykT
    J3+I9ekUdPvZ8cWktccxUlJ/8euBVbLpIpzEnB+mm/AKh2rsXXNgw6fsRHt0lU6Y
    +ZTRyyf+NLWzO6W+2WVSl6/XO9lnstFC76TjwsRtIIPg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934327AbeCGUCr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:02:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44742 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965593AbeCGTqo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:44 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 051/110] net: phy: fix phy_start to consider PHY_IGNORE_INTERRUPT
Date: Wed,  7 Mar 2018 11:38:34 -0800
Message-Id: <20180307191046.235254674@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>


[ Upstream commit 08f5138512180a479ce6b9d23b825c9f4cd3be77 ]

This condition wasn't adjusted when PHY_IGNORE_INTERRUPT (-2) was added
long ago. In case of PHY_IGNORE_INTERRUPT the MAC interrupt indicates
also PHY state changes and we should do what the symbol says.

Fixes: 84a527a41f38 ("net: phylib: fix interrupts re-enablement in phy_start")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -842,7 +842,7 @@ void phy_start(struct phy_device *phydev
 		break;
 	case PHY_HALTED:
 		/* make sure interrupts are re-enabled for the PHY */
-		if (phydev->irq != PHY_POLL) {
+		if (phy_interrupt_is_valid(phydev)) {
 			err = phy_enable_interrupts(phydev);
 			if (err < 0)
 				break;
