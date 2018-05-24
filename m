Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1691124-1527154850-2-1184205794819200818
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527154849; b=H2n/2pIp+Fe0/aF5L/MntE+L+2hotAeHn87rwLc/MaM/yYgrW2
    n9t9YE+Rg6wyqAE+TddOjxF+AUN/zdNc8R9PNZZ0W+gDfPAN/dLJ8hH/U4fgaSvE
    zvuDO0zEkYKd1GyMAVgtanC09sQNRm1iBTib7Aw9tO/s68tEbf6SPFNzeGEvcc/A
    XuJ8eLno09H53X0Jbs9a0lL0vgbJ2KF4JYPx1v2jtBCkGnfphbVLvzqqmhGR2tpf
    N2s08lyoiEN5t+U/QjM+4t3W0S/okIgcMp0vUovlDBGclafX1ugqWSit/7IcRSbE
    FpnYpHBHfPszKmHxtuKZ0e/1e/QZtPVvuSKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527154849; bh=3E5Msk+8pdJ5QTWJe8cvqVEkiwbR6t
    5pEm87c1sPaUk=; b=fjH6XPvwq4wcdAYwhjgZ4cWa9Pgs74BX8eil95AHUb0v82
    +/AUu3/TyROromwAfpXR6MDRldC2MchpbQQW64JkqkhiVss4WkiLj/kPiqWevJna
    y9Uw6u3BsD5wPZOe804cbRU+DqaN1PRV8uToXJYZfgPtoKEE000/yq3NCnvUgN4y
    Tward+5jqh+6Frmg0RXCQYpmrpHagxMy1MvwIykIG8aHT7vh4TWzIlaE9owH7Xpj
    QVuwleisIosEnycAEr/FefQTpb3a1RjaELs/T9+fX3pKcr53CpgS1nsWFYX0ZEAx
    lBjups2svlZjoaq7MpuSARB65+4VsGxIAKEvylPw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=EHSdK3aP x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=EHSdK3aP x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfF4Ddpm301DdTc+DjEwpDbHhFYdZWVKn3tBkuLzw6wl595OhipVyVDVHEESJOp5gItIOqvOfghj8OhsjAjqTShh7v6ig7py407+MXVNJ6PnJ08c/rItz
    X0WcSuMKWmcEVleZM9x+W8Rxs1s4ZW/pQtlMdHWnhk14ExBvgmPExCc2Ry/RbF0zbsTJ1lxTPOwknIyg5AA0J2Du2fz+LpkU8xYWt4Ybz9aPtIC92oTomfke
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=0iBLjq59G9wA:10
    a=VUJBJC2UJ8kA:10 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=u197ufFuNqZpRoOgcbsA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966032AbeEXJkr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965759AbeEXJkr (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:40:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 01/45] 8139too: Use disable_irq_nosync() in rtl8139_poll_controller()
Date: Thu, 24 May 2018 11:38:09 +0200
Message-Id: <20180524093120.755166440@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ingo Molnar <mingo@elte.hu>

[ Upstream commit af3e0fcf78879f718c5f73df0814951bd7057d34 ]

Use disable_irq_nosync() instead of disable_irq() as this might be
called in atomic context with netpoll.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/8139too.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/realtek/8139too.c
+++ b/drivers/net/ethernet/realtek/8139too.c
@@ -2215,7 +2215,7 @@ static void rtl8139_poll_controller(stru
 	struct rtl8139_private *tp = netdev_priv(dev);
 	const int irq = tp->pci_dev->irq;
 
-	disable_irq(irq);
+	disable_irq_nosync(irq);
 	rtl8139_interrupt(irq, dev);
 	enable_irq(irq);
 }
