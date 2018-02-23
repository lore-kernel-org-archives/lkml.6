Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3586829-1519410981-2-13372644644771381304
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519410981; b=ehFxGJHt077NTYt3GRjAdBFTdHnq/NBTYnnV4AP9JR8ij5k
    lqHDOU2sRCE83Nzqh3Xn7ePim0nGVa5MwS+8mXhqCfum9oQ7MXSKzHmcmI8zi4Pz
    0CzyIDSl+DG7qINaVe+yMcXXeC5+THr5wFeEIFlgfAi8HiWXBI6+GSFOI8cEF7+q
    vOBbzOrdbeiarhhN7XhUe3KD0D31fU5Qx1YHzNlIXCySof+x6oMYzp8bxK2dOr6Q
    u+Fl2liOE4sIaMPfIJ9odQY63awlKM/1GXTEZJj0YxskN/e7DPNH4afI4nbGsAYA
    ne86R/PE1JfyJNT928Q1ltZAiIshALtCnsI6c5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519410981; bh=1C4CMbjl3IVsqHL5SlBbPgsFJN
    GCgNfa5OSGA8pRnMY=; b=Qqnb23IqjAunEJ0KSsSMkP9XQ4kmc4oI62KO3EeDcz
    kUpr6lPqM/6fa+QdqV6C/wQHp3Lme7FIm0UT7RM+XKdsIFDEo9pNWbcYzi7nfyIv
    2G2Zcp4i2Tmu9XnBIJGXX/yivUNYoUkb7KEA7TacYKEKtQyjcGjKbFWfzDuceNWd
    1/slYUNkE5Zy/6S6IVHIsz/7LWam9N0p7SRrx3+YcGZAvTvXiA6JB2bQZWBY6aI4
    aXoRaJHXbCw1yJYe6RG2siF6uGAwhIbimN0Vcwy8AdcS6nXdqrjnd7JrvEufe9j/
    s86xmi6GXAZuWnKXJduT87atDoNo19N3H3lQsS6z+Z0A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753525AbeBWSgQ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:36:16 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37606 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752639AbeBWSgO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:36:14 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao Feng <gfree.wind@vip.163.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 041/193] ipvlan: Add the skb->mark as flow4s member to lookup route
Date: Fri, 23 Feb 2018 19:24:34 +0100
Message-Id: <20180223170332.474008716@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
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

From: Gao Feng <gfree.wind@vip.163.com>


[ Upstream commit a98a4ebc8c61d20f0150d6be66e0e65223a347af ]

Current codes don't use skb->mark to assign flowi4_mark, it would
make the policy route rule with fwmark doesn't work as expected.

Signed-off-by: Gao Feng <gfree.wind@vip.163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ipvlan/ipvlan_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -353,6 +353,7 @@ static int ipvlan_process_v4_outbound(st
 		.flowi4_oif = dev->ifindex,
 		.flowi4_tos = RT_TOS(ip4h->tos),
 		.flowi4_flags = FLOWI_FLAG_ANYSRC,
+		.flowi4_mark = skb->mark,
 		.daddr = ip4h->daddr,
 		.saddr = ip4h->saddr,
 	};
