Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523478955-2-8025878080905439876
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523478954; b=URVSzXzkFzC+fPiMbe3EfoC+JXF6FMbp066wQieDDN3PIhP1Hn
    pC90bsfrAmmwhZBJbJD5iJ3nQKx5nDVzQaNL2lhnoN3XfjEzUsnSQVXLYX1g4O4E
    DKvBKPslYUu/Z2qPDgKd7KwAYv+4hnbreOfQKoOXXAWtOXwWRJHWOV0owbK1+HCN
    6lLBZi3gU6kvQgxlm65CIQgCNqo7MldKxhHUNrXuCx6FVWRH2OxPcDxsH071dDek
    F2LQBIDPigHEErSTToYVSWEg+xuMB2KncZvJ3uwd9craC1KLhq5xtHmFYsi7ODnR
    2XuQvhfpDcrs8cr27ir8xTb1zrpZn61oDfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523478954; bh=ncIHHeRo48t6FHYykLclbiIPvC+gK6
    5ZcIeQBMQi7Yo=; b=asiD/66RRyXlQvZQsumt6eDsWPrUYAmFORhaRDR7fpKt+P
    tApOKL65AjUzQ9iBBMa+OPKL0kAzmwEjc0VPxCVbXbhmQzkWuaYwiiSe/Yi8WBMz
    XTiEt4Hw9UMqV7N9W1MLmoJDWptMaC91/gL7gSrrjMuhNVkM9nyp5B9hszIpOhtf
    uZZv6UwaKGpOjQoMK5G6/WDeuX3KMNphO4yNmqHD6os+ZI0uwcEcCnbpKViCXqi0
    pk67S3OK/zaqy4R4TxQrV3Ib1AQCaFiMymX2KwQtIGriDodP6++Qi6ssezeeeMF+
    sq9bjvzSkDjF+RER46x9hzxsKzrbT5Q8GZyOsJtw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfEjBBqkDTnExSa4gq9BfK4fOvOegclDh3HP8aHcCIFaBc+cZ9Aqp9NARcv68J1zAni1SDxCI5DUz1IjVOdwLBhYlX4ChJJbwbfqNf74ypPC6zUlUDkDu
    D7LHAgdy75dnduzosFLuc2rRX/i40K7Po22SUYAqFqeIFsgig+NfbjeZiNLw8awiLPbAfqGWwAQqe7buYA4Wvt8HP+8P9Od7JcmN3MKwx50Ay+Uu+GBnyqAl
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=R5C9hjxsAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=KmEauc0Fp4htJtg8AIUA:9 a=QEXdDO2ut3YA:10 a=KpS7wOGxO9l4JKx0McS0:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756142AbeDKSss (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:48:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59774 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754583AbeDKSsp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:48:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 118/190] sit: reload iphdr in ipip6_rcv
Date: Wed, 11 Apr 2018 20:36:04 +0200
Message-Id: <20180411183558.102547820@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
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

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>


[ Upstream commit b699d0035836f6712917a41e7ae58d84359b8ff9 ]

Since iptunnel_pull_header() can call pskb_may_pull(),
we must reload any pointer that was related to skb->head.

Fixes: a09a4c8dd1ec ("tunnels: Remove encapsulation offloads on decap")
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/sit.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -690,6 +690,7 @@ static int ipip6_rcv(struct sk_buff *skb
 
 		if (iptunnel_pull_header(skb, 0, htons(ETH_P_IPV6)))
 			goto out;
+		iph = ip_hdr(skb);
 
 		err = IP_ECN_decapsulate(iph, skb);
 		if (unlikely(err)) {
