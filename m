Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330799-1519989034-2-6225122828292045408
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
    t=1519989034; b=hTbhYOpWrlEAobiAy1fHcaV00OgsDtUCe+6quHSudBsRwyt
    RM258dOn6Lg0cIrnx2xks8EO4GZ31qskjuJxs4qvptKr7sJJ86Cvoehm+3QqKJhv
    f1mz9NkylvSCNVvD0Fvhraw1P20iBwdJr1LNIkSY3b2k0QkHPQnnmsTEWHZYj0Yo
    BSR+yxG1R3pp07i3Tkps6wXPP+umn0QgUfv/k/nxXwsURj54DRQ29gnS8OCymgqa
    bcUBjGFZpWDtf+7TB/BH/iNVN5QDuBgicohZAjRvK0B5M4BqZpE1qCsINyxaAVQu
    j5k2oXBmYin1ZeO3x9B1TIWDXYPRVI59IagV4UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519989034; bh=nggcFs0rrfTLXoLIHLBYGXlOfX
    IuZkIV8jCqrWEuK28=; b=EmRZtm5D4xDp52qPp1spkL6Tgr+m5SzZVE3KPA/R5E
    6pojY5D6BgoqWvDqgo0vI1O2YV6CcGwIJlmZZac9TgV6VeeJuSstp8YE6Ab0sFry
    /wZY/cSyXNFwvg08nUyj+XeciedMrHOoWrVppTiX5E1VAJLxA+yjC2oRofnDsuw1
    t2bu7kCNL8XDDNls6nAZEcwUMRMViTNOg0Umca6wc7jI0tZk30/shL7Nlddw0GUp
    U1QSwZ4LltUBRkQw0egO6ZwEcpA2Pr9BcW2p0tD4HvjMsQsf4B0xbxbOBbmxD9tz
    4A0OOTJHsdGD7CZKDJCuOsxsc7+KfupJV7qw68fpemaw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423484AbeCBIyW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:54:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50412 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423465AbeCBIyV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:54:21 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 14/34] tg3: Enable PHY reset in MTU change path for 5720
Date: Fri,  2 Mar 2018 09:51:10 +0100
Message-Id: <20180302084436.879173502@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
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

From: Siva Reddy Kallam <siva.kallam@broadcom.com>


[ Upstream commit e60ee41aaf898584205a6af5c996860d0fe6a836 ]

A customer noticed RX path hang when MTU is changed on the fly while
running heavy traffic with NCSI enabled for 5717 and 5719. Since 5720
belongs to same ASIC family, we observed same issue and same fix
could solve this problem for 5720.

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/tg3.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -14240,7 +14240,8 @@ static int tg3_change_mtu(struct net_dev
 	 */
 	if (tg3_asic_rev(tp) == ASIC_REV_57766 ||
 	    tg3_asic_rev(tp) == ASIC_REV_5717 ||
-	    tg3_asic_rev(tp) == ASIC_REV_5719)
+	    tg3_asic_rev(tp) == ASIC_REV_5719 ||
+	    tg3_asic_rev(tp) == ASIC_REV_5720)
 		reset_phy = true;
 
 	err = tg3_restart_hw(tp, reset_phy);
