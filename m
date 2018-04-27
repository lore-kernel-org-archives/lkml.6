Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298528-1524839801-2-16189842478478245163
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524839801; b=R2GWjBCodkBIYpFNHws7KxVT66Y4BpGBErtZAdOEVZp2WyzAhR
    HF3Wn/F03lXdLkbvrgbPBq37Zj6H9Ceh7IkTed9ET9yP5iJnw4H29A5yWY4VMJNt
    VQwHOtQHWS3U6DkXk8ab1tKzRxeFHAkmqhNDSJw9OBCMVv+3BsxmNLmVvk/qzufp
    cQ01HB8oBEIpzBdj/wXKOQc6R8V1ypW5enHBZRJXoHEmX7M11i4UzjDQjS9qCoTp
    NRmqG3nv4zvOaWXjJI+OlesiCC8a+Uk3L7DEtk/aV6YZkheJiYvVc/4T1D+VWvDh
    5016af9B/Blw9isi7q2vhCIJNjV/2s8MXcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839801; bh=29LUj9zvGdzIRJK+oAn4TwC6a4U2PN
    J0vsBjbi+PKJs=; b=DnLVo2s2wvdcg9EufMVGX9ZfS+6FzFz32/IMYUO91TOwhh
    I7N1JBgkJdvZ0dnfprg/6vlpytXuFAvebNNnt8xOT6wIx6SeaUVM+Fe0+6y5VZtU
    S2SbFQkXwy4vnmuPPfbXwv9yk7xMv9Zizof7mUvB9S5R4iRC8qogxI1UudidXQ3X
    ZEZMhW5f9FAQ76VQdsbdgWLCKmDXGZzviwzTeBv2fg8exlGtvr4cvR45oNVLv5fZ
    jzWJZEYUJ+8Gru8Pe+ix5IXfiOkx+7OmZuixmW6iWS9zZazh4BzkY0JOri7wq8V4
    HKcdQHwQQfBXrrGc1JX06KuDMlDny6PreEbJtuzQ==
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
X-CM-Envelope: MS4wfELfZJeFo3pwBDnP8BWJm25gApXxOjveBJKjb7mYtq1njqScCCqa+juz0439qOIj4COeZfVXFG8CpfQDH327p5ETt2LifnOxJVNgyVA86eDpCWu0hJI7
    y8am37FtPnFmq28ljJKRwl4EzHU26cGUoNCiAILbxfEt1i2jPO9JRlUN3+4EO9FRJCnxjbaNQ76dUKj9i9qK0gLIslj+hcuwvhCgd/9CqpYYjyk+MpcsEONF
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=4RBUngkUAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=1g3IOloauNWvxtIhmr8A:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
    a=QEXdDO2ut3YA:10 a=_sbA2Q-Kp09kWB8D3iXc:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932882AbeD0OgX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:36:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934698AbeD0OJg (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:09:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B7221864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 10/81] ipv6: add RTA_TABLE and RTA_PREFSRC to rtm_ipv6_policy
Date: Fri, 27 Apr 2018 15:58:12 +0200
Message-Id: <20180427135743.784254497@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit aa8f8778493c85fff480cdf8b349b1e1dcb5f243 ]

KMSAN reported use of uninit-value that I tracked to lack
of proper size check on RTA_TABLE attribute.

I also believe RTA_PREFSRC lacks a similar check.

Fixes: 86872cb57925 ("[IPv6] route: FIB6 configuration using struct fib6_config")
Fixes: c3968a857a6b ("ipv6: RTA_PREFSRC support for ipv6 route source address selection")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3862,6 +3862,7 @@ void rt6_mtu_change(struct net_device *d
 
 static const struct nla_policy rtm_ipv6_policy[RTA_MAX+1] = {
 	[RTA_GATEWAY]           = { .len = sizeof(struct in6_addr) },
+	[RTA_PREFSRC]		= { .len = sizeof(struct in6_addr) },
 	[RTA_OIF]               = { .type = NLA_U32 },
 	[RTA_IIF]		= { .type = NLA_U32 },
 	[RTA_PRIORITY]          = { .type = NLA_U32 },
@@ -3873,6 +3874,7 @@ static const struct nla_policy rtm_ipv6_
 	[RTA_EXPIRES]		= { .type = NLA_U32 },
 	[RTA_UID]		= { .type = NLA_U32 },
 	[RTA_MARK]		= { .type = NLA_U32 },
+	[RTA_TABLE]		= { .type = NLA_U32 },
 };
 
 static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
