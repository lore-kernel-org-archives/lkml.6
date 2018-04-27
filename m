Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524839459-2-10853784255306575108
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
    1524839456; b=kqAYKLXES3SBZlV8yu+LjKjRQPKo/erw3W6Nq6uH2ILleiELVC
    AqJiLlvPye1m/THkFPNyGv2wqfjXk+ANHI5X1AKarFjloDEc32EFSgRw1d5rhCQb
    EPenjBVl+Sl40gp9yAJBr/SRY5JCjoSAFEG5ZumNWuW2ltGqM6E7PRcQACVZku6w
    aDgqKUOrEutLVxY5Y8Bouu8ACfxOzbW34vdTuxKM1ikInQq4xsGyrkxt7JuNuSDW
    8oaFpF2w57jDTsUI9+f16E5T7gorqEV/j2Q5d7FKKGloK7MNocLmkHZLwMqhmVQ5
    33aSBv+Wg5JehDesTcIl7jfVIRU1tlSFIIGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839456; bh=OYvkksCi4y2AYR61ACEDCsIwObc8r1
    pRn1W4RDphqbk=; b=N26MlU7IGep1y44GJcfeN7tg/u6YnowU+xXE1Uu3iBEU/Z
    np8rxmh3/wTF8m1YdD0bE9iQlVrTA2lhLT0CtzqO/gs4czOGyAhBwUeMy8BPEKLk
    KjTfkYdODzdk2aywUH3AdPAdcj+IxW1DyMMc3SFRkK7gUvtavIZl1QVQY8HwuysU
    9SGcyt5ydEUbZvusK2Z+y7lp6blmE/AvuSBIHr3MfOXxYvqOexD5t6i7dMVvcS53
    OjxcELTn3FaPC+7unweJr6qCala6oSq+jY9cfJ5rr9HM1RnOBFeez5vg5IEIv5zD
    Pka8NXhFMQqUAcpWCSf5w3cHCIRpjUirLy13TpFw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfFb2EdKk8ub2JhJasrhLF1v2hjb0AO7Thg5OzqpJj2iOF2io4osyJS9DGX/yk2hlw29Fkd0iyVyi6S+ACgxfDfytFer0mys22LH0lJoyy8SS3XX9vHii
    KZSmVQ20kIsH0XQZKoIR8gx6I2IperSbXNf46ipaaPADPV1gbMpFJ45siHO8Msf2k1Gnm/mGpQJcwY25kHIk5BdnnCTSEPZkf12scs9N96BNyhTIcv+6GNrh
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=0FD05c-RAAAA:8 a=t7CeM3EgAAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=rVueRbDqSJiEZ4vksXwA:9 a=QEXdDO2ut3YA:10
    a=l1rpMCqCXRGZwUSuRcM3:22 a=FdTzh2GWekK77mhwV6Dw:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934890AbeD0OKs (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934799AbeD0OKp (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:10:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5451E21864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 32/81] tipc: add policy for TIPC_NLA_NET_ADDR
Date: Fri, 27 Apr 2018 15:58:34 +0200
Message-Id: <20180427135744.899362740@linuxfoundation.org>
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


[ Upstream commit ec518f21cb1a1b1f8a516499ea05c60299e04963 ]

Before syzbot/KMSAN bites, add the missing policy for TIPC_NLA_NET_ADDR

Fixes: 27c21416727a ("tipc: add net set to new netlink api")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jon Maloy <jon.maloy@ericsson.com>
Cc: Ying Xue <ying.xue@windriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/netlink.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/tipc/netlink.c
+++ b/net/tipc/netlink.c
@@ -79,7 +79,8 @@ const struct nla_policy tipc_nl_sock_pol
 
 const struct nla_policy tipc_nl_net_policy[TIPC_NLA_NET_MAX + 1] = {
 	[TIPC_NLA_NET_UNSPEC]		= { .type = NLA_UNSPEC },
-	[TIPC_NLA_NET_ID]		= { .type = NLA_U32 }
+	[TIPC_NLA_NET_ID]		= { .type = NLA_U32 },
+	[TIPC_NLA_NET_ADDR]		= { .type = NLA_U32 },
 };
 
 const struct nla_policy tipc_nl_link_policy[TIPC_NLA_LINK_MAX + 1] = {
