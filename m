Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3366930-1521215587-2-931407582734324409
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521215587; b=wdKVrps4E7zZSXNig+ilNLE2uFRjwEu8NdBRxMJUTTqvsL1
    PYcT0DsKB1AsiTMjHpp5JIZU1o0z+tIjl1LvE+GSW1NhUiD7Z0DEjBCwNoNyQv7F
    L0GZA2Tg5eF6vwXDBAqefy7Uq4TgU/iXDXWuxoe7A+9z+0603RCgdLfnS72LelBu
    26FDedOQNi3AYqDq1lYb/45Zw8Gofv7jGDUfTsoWHQ+xe44F+ZeRXhDWn0V50xv7
    mt+Tikrp0KeBBKlQt4FdWGy6QGsz2TWzfauMELkjEtqdsmUOD+iK0TKBdFMPIxij
    1tXuAfSGQ409uUWadvYhpH+7K8s3+CNwopXB+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521215587; bh=O6Wo2NU247yJ1CqGthgSbZ9ZjB
    ejlOIDMz3qkOJ2QPM=; b=aOTN2CkNXGgzi/ENEQyEYCXLDWapOPb60D3R4BNlKu
    ZMy3nUCVvFaE01nLcI7EaNcBaQwqu71Hvzs4XO+0KLD8x4U8FYZYyCmIXaUSiCbt
    aWwrlJoXl3TTkDm4p/HPR8g0mQEK7mTveoUab+9yFsmd22WzO4XrW3x/7aU8J08r
    hdzIOrkqwh6Brbqpo5nU9PumBrF5bMqo3cEBfsmmibx2kBJ3S3CJyOJmYqWnTvwd
    AwGOYfE9ca+BJ0JIVJLNnj+XoCcrsPCxbY4oKgJzXprDstn7S4GOrZx9NBWSUZ1Z
    Gw0Fgwmk/Vec9auP0WIC0lGULRCjQ6xpNlst5xgZ26hA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S965383AbeCPPoR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:44:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45870 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965364AbeCPPoO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:44:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 110/128] veth: set peer GSO values
Date: Fri, 16 Mar 2018 16:24:11 +0100
Message-Id: <20180316152342.021185245@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
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

From: Stephen Hemminger <stephen@networkplumber.org>


[ Upstream commit 72d24955b44a4039db54a1c252b5031969eeaac3 ]

When new veth is created, and GSO values have been configured
on one device, clone those values to the peer.

For example:
   # ip link add dev vm1 gso_max_size 65530 type veth peer name vm2

This should create vm1 <--> vm2 with both having GSO maximum
size set to 65530.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/veth.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -410,6 +410,9 @@ static int veth_newlink(struct net *src_
 	if (ifmp && (dev->ifindex != 0))
 		peer->ifindex = ifmp->ifi_index;
 
+	peer->gso_max_size = dev->gso_max_size;
+	peer->gso_max_segs = dev->gso_max_segs;
+
 	err = register_netdevice(peer);
 	put_net(net);
 	net = NULL;
