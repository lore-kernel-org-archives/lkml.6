Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3775223-1519415801-2-14680802585178881224
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
    t=1519415800; b=Y8HezYPqvBvNv/0woYQfpjEUiGB/ezfcERW0ZK9Hbu5jwhw
    3PuQgmNO9lQZvYLQ32Qr10wTA6C3bPPhV5Fw5BDMoflRG2SfxLeZGJWSPNJ6VDnJ
    hxbxP/vxx20+pK70/Uo7hfI51ey8L7fabK50XjDBWWpP7UyktbgYW10k4k2k7jcy
    O/g76YuU+UiE4Wp4Ypt4fZwQdCIdO2NvZ+2f6Khd2bmmOkmGW0Uy1nft5yygiZ83
    u7HwCUg3ymPrFSVP9ikQTx9u9xh2jQgVS23qE7P0x4kYzuo7qJ6u3tB/KWQm3l9G
    +NsxRoFrcC50TtDY6yfTr0UpceTlN508A8H9qrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415800; bh=A4bnxl9Jb5rE9Y1EurcQlwmEbv
    Vs0+HIZpIADrE4+a4=; b=QZUo+41ieseb8LBcw7nVVM2912Zs3CDn/lOuTgzies
    QFB3HEHe+Nw8OsLiZkyE6J9t432vuHihX/Dc/AqwWRrAZSOuqdKzG4bKWaPupw8r
    grAoZvN98olrQj1D0wjSUXgOrdnUsVbFCJmj5CCmDopAKFIT1d0FSIsSm3wtKdAM
    7orwFokCLEUfkkvBzKfE6aA+aw6z7N+VxaswhUlsu0w1VisCag7HhwzJQvhsnoc4
    XO4z6QtiAk8ImJM53+YYCMGrjJEJvEDWNDCtVeXg5EDdYSjuBlhO2YIwYbuWiECF
    8rMlPhJ75mk+z2O08tJ0/zCLj5g9k7sjdu3F0zO9ywmQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932912AbeBWT4X (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:56:23 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42962 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754212AbeBWSow (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:44:52 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao Feng <gfree.wind@vip.163.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 059/145] ipvlan: Add the skb->mark as flow4s member to lookup route
Date: Fri, 23 Feb 2018 19:26:05 +0100
Message-Id: <20180223170732.421385784@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -370,6 +370,7 @@ static int ipvlan_process_v4_outbound(st
 		.flowi4_oif = dev->ifindex,
 		.flowi4_tos = RT_TOS(ip4h->tos),
 		.flowi4_flags = FLOWI_FLAG_ANYSRC,
+		.flowi4_mark = skb->mark,
 		.daddr = ip4h->daddr,
 		.saddr = ip4h->saddr,
 	};
